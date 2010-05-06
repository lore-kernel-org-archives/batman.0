Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  6 May 2010 22:18:46 +0200
Message-Id: <1273177132-8792-21-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 20/26] staging:batman-adv: Limit queue
	lengths for batman and broadcast packets
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
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

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
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/aggregation.c    |   16 ++++++++++++-
 drivers/staging/batman-adv/main.c           |    5 ++++
 drivers/staging/batman-adv/main.h           |    4 +++
 drivers/staging/batman-adv/send.c           |   33 ++++++++++++++++++++++----
 drivers/staging/batman-adv/send.h           |    2 +-
 drivers/staging/batman-adv/soft-interface.c |    6 ++--
 6 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/batman-adv/aggregation.c b/drivers/staging/batman-adv/aggregation.c
index a5818ff..ce8b8a6 100644
--- a/drivers/staging/batman-adv/aggregation.c
+++ b/drivers/staging/batman-adv/aggregation.c
@@ -95,6 +95,7 @@ static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 	return false;
 }
 
+#define atomic_dec_not_zero(v)          atomic_add_unless((v), -1, 0)
 /* create a new aggregated packet and add this packet to it */
 static void new_aggregated_packet(unsigned char *packet_buff,
 			   int packet_len,
@@ -106,13 +107,26 @@ static void new_aggregated_packet(unsigned char *packet_buff,
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
diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index c1e57aa..aa072d1 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -42,6 +42,9 @@ DEFINE_SPINLOCK(forw_bat_list_lock);
 DEFINE_SPINLOCK(forw_bcast_list_lock);
 
 atomic_t vis_interval;
+atomic_t bcast_queue_left;
+atomic_t batman_queue_left;
+
 int16_t num_hna;
 
 struct net_device *soft_device;
@@ -79,6 +82,8 @@ int init_module(void)
 
 	atomic_set(&vis_interval, 1000);/* TODO: raise this later, this is only
 					 * for debugging now. */
+	atomic_set(&bcast_queue_left, BCAST_QUEUE_LEN);
+	atomic_set(&batman_queue_left, BATMAN_QUEUE_LEN);
 
 	/* the name should not be longer than 10 chars - see
 	 * http://lwn.net/Articles/23634/ */
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 58c1ec1..6749ce0 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -69,6 +69,8 @@
 #define MODULE_ACTIVE 1
 #define MODULE_DEACTIVATING 2
 
+#define BCAST_QUEUE_LEN 256
+#define BATMAN_QUEUE_LE	256
 
 /*
  * Debug Messages
@@ -132,6 +134,8 @@ extern spinlock_t forw_bat_list_lock;
 extern spinlock_t forw_bcast_list_lock;
 
 extern atomic_t vis_interval;
+extern atomic_t bcast_queue_left;
+extern atomic_t batman_queue_left;
 extern int16_t num_hna;
 
 extern struct net_device *soft_device;
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index 31d86ae..f58a9ed 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -375,13 +375,28 @@ static void _add_bcast_packet_to_list(struct forw_packet *forw_packet,
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
+		goto out;
+	}
+
 	forw_packet = kmalloc(sizeof(struct forw_packet), GFP_ATOMIC);
+
 	if (!forw_packet)
-		goto out;
+		goto out_and_inc;
 
 	skb = skb_copy(skb, GFP_ATOMIC);
 	if (!skb)
@@ -396,12 +411,14 @@ void add_bcast_packet_to_list(struct sk_buff *skb)
 	forw_packet->num_packets = 0;
 
 	_add_bcast_packet_to_list(forw_packet, 1);
-	return;
+	return NETDEV_TX_OK;
 
 packet_free:
 	kfree(forw_packet);
+out_and_inc:
+	atomic_inc(&bcast_queue_left);
 out:
-	return;
+	return NETDEV_TX_BUSY;
 }
 
 void send_outstanding_bcast_packet(struct work_struct *work)
@@ -436,8 +453,10 @@ void send_outstanding_bcast_packet(struct work_struct *work)
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
@@ -463,6 +482,10 @@ void send_outstanding_bat_packet(struct work_struct *work)
 	    (atomic_read(&module_state) != MODULE_DEACTIVATING))
 		schedule_own_packet(forw_packet->if_incoming);
 
+	/* don't count own packet */
+	if (!forw_packet->own)
+		atomic_inc(&batman_queue_left);
+
 	forw_packet_free(forw_packet);
 }
 
diff --git a/drivers/staging/batman-adv/send.h b/drivers/staging/batman-adv/send.h
index b84a470..feaa2fc 100644
--- a/drivers/staging/batman-adv/send.h
+++ b/drivers/staging/batman-adv/send.h
@@ -33,7 +33,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 			     struct batman_packet *batman_packet,
 			     uint8_t directlink, int hna_buff_len,
 			     struct batman_if *if_outgoing);
-void add_bcast_packet_to_list(struct sk_buff *skb);
+int  add_bcast_packet_to_list(struct sk_buff *skb);
 void send_outstanding_bcast_packet(struct work_struct *work);
 void send_outstanding_bat_packet(struct work_struct *work);
 void purge_outstanding_packets(struct batman_if *batman_if);
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index 681a0ad..14b5cca 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -216,10 +216,10 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
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
-- 
1.7.1

