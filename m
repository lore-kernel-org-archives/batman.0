Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 7 Apr 2010 10:11:23 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100407081123.GA2378@pandem0nium>
References: <20100405024603.GA11965@pandem0nium>
	<201004051321.45958.sven.eckelmann@gmx.de>
	<20100405144035.GA13768@pandem0nium>
	<20100405150605.GA15893@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
In-Reply-To: <20100405150605.GA15893@pandem0nium>
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Limit queue lengths for batman
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

This third version of the patch does not increase the local broadcast 
sequence number when the queue is already full.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
Index: a/batman-adv-kernelland/send.c
===================================================================
--- a/batman-adv-kernelland/send.c	(revision 1616)
+++ a/batman-adv-kernelland/send.c	(working copy)
@@ -378,18 +378,35 @@
 			   send_time);
 }
 
-void add_bcast_packet_to_list(struct sk_buff *skb)
+#define atomic_dec_not_zero(v)          atomic_add_unless((v), -1, 0)
+/* add a broadcast packet to the queue and setup timers. broadcast packets
+ * are sent multiple times to increase probability for beeing received.
+ *
+ * This function returns NETDEV_TX_OK on success and NETDEV_TX_BUSY on
+ * errors.
+ *
+ * The skb is not consumed, so the caller should make sure that the
+ * skb is freed. */
+int add_bcast_packet_to_list(struct sk_buff *skb)
 {
 	struct forw_packet *forw_packet;
 
+	if (!atomic_dec_not_zero(&bcast_queue_left)) {
+		bat_dbg(DBG_BATMAN, "bcast packet queue full\n");
+		return NETDEV_TX_BUSY;
+	}
+
 	forw_packet = kmalloc(sizeof(struct forw_packet), GFP_ATOMIC);
-	if (!forw_packet)
-		return;
+	if (!forw_packet) {
+		atomic_inc(&bcast_queue_left);
+		return NETDEV_TX_BUSY;
+	}
 
 	skb = skb_copy(skb, GFP_ATOMIC);
 	if (!skb) {
+		atomic_inc(&bcast_queue_left);
 		kfree(forw_packet);
-		return;
+		return NETDEV_TX_BUSY;
 	}
 
 	skb_reset_mac_header(skb);
@@ -401,6 +418,7 @@
 	forw_packet->num_packets = 0;
 
 	_add_bcast_packet_to_list(forw_packet, 1);
+	return NETDEV_TX_OK;
 }
 
 void send_outstanding_bcast_packet(struct work_struct *work)
@@ -435,8 +453,10 @@
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
@@ -462,6 +482,10 @@
 	    (atomic_read(&module_state) != MODULE_DEACTIVATING))
 		schedule_own_packet(forw_packet->if_incoming);
 
+	/* don't count own packet */
+	if (!forw_packet->own)
+		atomic_inc(&batman_queue_left);
+
 	forw_packet_free(forw_packet);
 }
 
Index: a/batman-adv-kernelland/send.h
===================================================================
--- a/batman-adv-kernelland/send.h	(revision 1616)
+++ a/batman-adv-kernelland/send.h	(working copy)
@@ -33,7 +33,7 @@
 			     struct batman_packet *batman_packet,
 			     uint8_t directlink, int hna_buff_len,
 			     struct batman_if *if_outgoing);
-void add_bcast_packet_to_list(struct sk_buff *skb);
+int  add_bcast_packet_to_list(struct sk_buff *skb);
 void send_outstanding_bcast_packet(struct work_struct *work);
 void send_outstanding_bat_packet(struct work_struct *work);
 void purge_outstanding_packets(void);
Index: a/batman-adv-kernelland/soft-interface.c
===================================================================
--- a/batman-adv-kernelland/soft-interface.c	(revision 1616)
+++ a/batman-adv-kernelland/soft-interface.c	(working copy)
@@ -227,10 +227,10 @@
 		/* set broadcast sequence number */
 		bcast_packet->seqno = htons(bcast_seqno);
 
-		bcast_seqno++;
+		/* broadcast packet. on success, increase seqno. */
+		if (add_bcast_packet_to_list(skb) == NETDEV_TX_OK)
+			bcast_seqno++;
 
-		/* broadcast packet */
-		add_bcast_packet_to_list(skb);
 		/* a copy is stored in the bcast list, therefore removing
 		 * the original skb. */
 		kfree_skb(skb);
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
@@ -95,6 +95,7 @@
 	return false;
 }
 
+#define atomic_dec_not_zero(v)          atomic_add_unless((v), -1, 0)
 /* create a new aggregated packet and add this packet to it */
 static void new_aggregated_packet(unsigned char *packet_buff,
 			   int packet_len,
@@ -106,13 +107,26 @@
 	struct forw_packet *forw_packet_aggr;
 	unsigned long flags;
 
+	/* own packet should always be scheduled */
+	if (!own_packet) {
+		if (!atomic_dec_not_zero(&batman_queue_left)) {
+			bat_dbg(DBG_BATMAN, "batman packet queue full\n");
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
 
