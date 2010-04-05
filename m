Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 5 Apr 2010 04:46:03 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100405024603.GA11965@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Limit queue lengths for batman
	and broadcast	packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This patch limits the queue lengths of batman and broadcast packets. BATMAN
packets are held back for aggregation and jittered to avoid interferences.
Broadcast packets are stored to be sent out multiple times to increase
the probability to be received by other nodes in lossy environments.

Especially in extreme cases like broadcast storms, the queues have been seen
to run full, eating up all the memory and triggering the infamous OOM killer. 
With the queue length limits introduced in this patch, this problem is 
avoided.

Each queue is limited to 256 entries for now, resulting in 1 MB of maximum
space available in total for typical setups (assuming one packet including 
overhead does not require more than 2000 byte). This should also be reasonable
for smaller routers, otherwise the defines can be tweaked later.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---

Index: a/batman-adv-kernelland/send.c
===================================================================
--- a/batman-adv-kernelland/send.c	(revision 1616)
+++ a/batman-adv-kernelland/send.c	(working copy)
@@ -382,12 +382,21 @@
 {
 	struct forw_packet *forw_packet;
 
+	if (atomic_dec_and_test(&bcast_queue_left)) {
+		bat_dbg(DBG_BATMAN, "bcast packet queue full\n");
+		atomic_inc(&bcast_queue_left);
+		return;
+	}
+
 	forw_packet = kmalloc(sizeof(struct forw_packet), GFP_ATOMIC);
-	if (!forw_packet)
+	if (!forw_packet) {
+		atomic_inc(&bcast_queue_left);
 		return;
+	}
 
 	skb = skb_copy(skb, GFP_ATOMIC);
 	if (!skb) {
+		atomic_inc(&bcast_queue_left);
 		kfree(forw_packet);
 		return;
 	}
@@ -435,8 +444,10 @@
 	if ((forw_packet->num_packets < 3) &&
 	    (atomic_read(&module_state) != MODULE_DEACTIVATING))
 		_add_bcast_packet_to_list(forw_packet, ((5 * HZ) / 1000));
-	else
+	else {
 		forw_packet_free(forw_packet);
+		atomic_inc(&bcast_queue_left);
+	}
 }
 
 void send_outstanding_bat_packet(struct work_struct *work)
@@ -462,6 +473,10 @@
 	    (atomic_read(&module_state) != MODULE_DEACTIVATING))
 		schedule_own_packet(forw_packet->if_incoming);
 
+	/* don't count own packet */
+	if (!forw_packet->own)
+		atomic_inc(&batman_queue_left);
+
 	forw_packet_free(forw_packet);
 }
 
Index: a/batman-adv-kernelland/main.c
===================================================================
--- a/batman-adv-kernelland/main.c	(revision 1616)
+++ a/batman-adv-kernelland/main.c	(working copy)
@@ -46,6 +46,9 @@
 
 atomic_t originator_interval;
 atomic_t vis_interval;
+atomic_t bcast_queue_left;
+atomic_t batman_queue_left;
+
 int16_t num_hna;
 int16_t num_ifs;
 
@@ -85,6 +88,8 @@
 	atomic_set(&originator_interval, 1000);
 	atomic_set(&vis_interval, 1000);/* TODO: raise this later, this is only
 					 * for debugging now. */
+	atomic_set(&bcast_queue_left, BCAST_QUEUE_LEN);
+	atomic_set(&batman_queue_left, BATMAN_QUEUE_LEN);
 
 	/* the name should not be longer than 10 chars - see
 	 * http://lwn.net/Articles/23634/ */
Index: a/batman-adv-kernelland/aggregation.c
===================================================================
--- a/batman-adv-kernelland/aggregation.c	(revision 1616)
+++ a/batman-adv-kernelland/aggregation.c	(working copy)
@@ -106,13 +106,27 @@
 	struct forw_packet *forw_packet_aggr;
 	unsigned long flags;
 
+	/* own packet should always be scheduled */
+	if (!own_packet) {
+		if (atomic_dec_and_test(&batman_queue_left)) {
+			bat_dbg(DBG_BATMAN, "batman packet queue full\n");
+			atomic_inc(&batman_queue_left);
+			return;
+		}
+	}
+
 	forw_packet_aggr = kmalloc(sizeof(struct forw_packet), GFP_ATOMIC);
-	if (!forw_packet_aggr)
+	if (!forw_packet_aggr) {
+		if (!own_packet)
+			atomic_inc(&batman_queue_left);
 		return;
+	}
 
 	forw_packet_aggr->packet_buff = kmalloc(MAX_AGGREGATION_BYTES,
 						GFP_ATOMIC);
 	if (!forw_packet_aggr->packet_buff) {
+		if (!own_packet)
+			atomic_inc(&batman_queue_left);
 		kfree(forw_packet_aggr);
 		return;
 	}
Index: a/batman-adv-kernelland/main.h
===================================================================
--- a/batman-adv-kernelland/main.h	(revision 1616)
+++ a/batman-adv-kernelland/main.h	(working copy)
@@ -70,6 +70,8 @@
 #define MODULE_ACTIVE 1
 #define MODULE_DEACTIVATING 2
 
+#define BCAST_QUEUE_LEN		256
+#define BATMAN_QUEUE_LEN 	256
 
 /*
  * Debug Messages
@@ -133,6 +135,8 @@
 
 extern atomic_t originator_interval;
 extern atomic_t vis_interval;
+extern atomic_t bcast_queue_left;
+extern atomic_t batman_queue_left;
 extern int16_t num_hna;
 extern int16_t num_ifs;
 
