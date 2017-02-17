Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 17 Feb 2017 11:17:08 +0100
Message-Id: <20170217101708.19336-7-linus.luessing@c0d3.blue>
In-Reply-To: <20170217101708.19336-1-linus.luessing@c0d3.blue>
References: <20170217101708.19336-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2 6/6] batman-adv: do not aggregate
	rebroadcasts in the same packet
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

With this patch, aggregating a broadcast packet multiple times into the
same aggregation packet is avoided. Otherwise such aggregation would
defeat the purpose of retransmissions (i.e. increasing reliability).

Instead packets which are supposed to be retransmitted are just put
back into the aggregation queue and will be part of the next aggregation
packet again.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/aggregation.c | 69 +++++++++++++++++++++++++++++++++++---------
 net/batman-adv/bat_iv_ogm.c  |  3 +-
 net/batman-adv/send.c        | 58 +++++++++++++++++++++++++++++++++----
 net/batman-adv/send.h        |  8 ++++-
 net/batman-adv/types.h       |  3 ++
 5 files changed, 120 insertions(+), 21 deletions(-)

diff --git a/net/batman-adv/aggregation.c b/net/batman-adv/aggregation.c
index 21b29be..1dd6eb9 100644
--- a/net/batman-adv/aggregation.c
+++ b/net/batman-adv/aggregation.c
@@ -253,7 +253,41 @@ batadv_aggr_queue_is_full(struct batadv_hard_iface *hard_iface)
 }
 
 /**
+ * batadv_aggr_queue_tail - add packet to tail of an aggregation queue
+ * @skb: the packet to queue
+ * @hard_iface: the interface to queue on
+ *
+ * Tries to add a broadcast packet to an aggregation queue. This might fail if
+ * the queue has no more free slots available. In that case, the caller needs to
+ * take care of freeing the skb.
+ *
+ * Return: True on successful queueing, false otherwise.
+ */
+static bool batadv_aggr_queue_tail(struct sk_buff *skb,
+				   struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	bool ret = true;
+
+	spin_lock_bh(&hard_iface->aggr.aggr_list_lock);
+	if (batadv_aggr_queue_is_full(hard_iface)) {
+		batadv_inc_counter(bat_priv, BATADV_CNT_AGGR_QUEUE_FULL);
+		ret = false;
+	} else {
+		batadv_inc_counter(bat_priv, BATADV_CNT_AGGR_PARTS_TX);
+		batadv_add_counter(bat_priv, BATADV_CNT_AGGR_PARTS_TX_BYTES,
+				   skb->len + ETH_HLEN);
+
+		skb_queue_tail(&hard_iface->aggr.aggr_list, skb);
+	}
+	spin_unlock_bh(&hard_iface->aggr.aggr_list_lock);
+
+	return ret;
+}
+
+/**
  * batadv_aggr_squash_chunk - squash packets into an aggregate
+ * @hard_iface: the interface to potentially requeue on
  * @head: a list of to be squashed packets
  * @size: the size of the to be created aggregation packet
  *  (excluding the ethernet header)
@@ -261,11 +295,14 @@ batadv_aggr_queue_is_full(struct batadv_hard_iface *hard_iface)
  * Allocates an aggregation packet and squashes the provided list of broadcast
  * packets into it. The provided list of packets is freed/consumed.
  *
+ * Batman broadcast packets are potentially requeued.
+ *
  * Return: An aggregation packet ready for transmission on success, NULL
  * otherwise.
  */
 static struct sk_buff *
-batadv_aggr_squash_chunk(struct sk_buff_head *head,
+batadv_aggr_squash_chunk(struct batadv_hard_iface *hard_iface,
+			 struct sk_buff_head *head,
 			 int size)
 {
 	struct sk_buff *skb, *skb_tmp, *skb_aggr;
@@ -296,7 +333,15 @@ batadv_aggr_squash_chunk(struct sk_buff_head *head,
 		to = skb_put(skb_aggr, len);
 		skb_copy_bits(skb, offset, to, len);
 		skb_unlink(skb, head);
-		consume_skb(skb);
+
+		batadv_send_bcasts_inc(skb);
+
+		if (batadv_send_bcasts_left(skb, hard_iface)) {
+			if (!batadv_aggr_queue_tail(skb, hard_iface))
+				kfree_skb(skb);
+		} else {
+			consume_skb(skb);
+		}
 
 		tvlv_len += len + sizeof(struct batadv_tvlv_hdr);
 	}
@@ -345,7 +390,7 @@ static bool batadv_aggr_send_chunk(struct batadv_hard_iface *hard_iface)
 	skb_queue_head_init(&head);
 	emptied = batadv_aggr_get_chunk(hard_iface, &head, &size);
 
-	skb = batadv_aggr_squash_chunk(&head, size);
+	skb = batadv_aggr_squash_chunk(hard_iface, &head, size);
 	if (!skb)
 		goto out;
 
@@ -394,6 +439,7 @@ static void batadv_aggr_work(struct work_struct *work)
 int batadv_aggr_queue(struct sk_buff *skb, struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	int ret;
 
 	if (!atomic_read(&bat_priv->aggregation))
 		return NET_XMIT_DROP;
@@ -401,18 +447,15 @@ int batadv_aggr_queue(struct sk_buff *skb, struct batadv_hard_iface *hard_iface)
 	if (atomic_read(&bat_priv->aggr_num_disabled))
 		return NET_XMIT_DROP;
 
-	if (batadv_aggr_queue_is_full(hard_iface)) {
-		batadv_inc_counter(bat_priv, BATADV_CNT_AGGR_QUEUE_FULL);
-		return NET_XMIT_DROP;
+	/* we handle rebroadcasts here instead of the forw_packet API */
+	if (batadv_send_is_rebroadcast(skb)) {
+		consume_skb(skb);
+		return NET_XMIT_SUCCESS;
 	}
 
-	spin_lock_bh(&hard_iface->aggr.aggr_list_lock);
-	skb_queue_tail(&hard_iface->aggr.aggr_list, skb);
-	spin_unlock_bh(&hard_iface->aggr.aggr_list_lock);
-
-	batadv_inc_counter(bat_priv, BATADV_CNT_AGGR_PARTS_TX);
-	batadv_add_counter(bat_priv, BATADV_CNT_AGGR_PARTS_TX_BYTES,
-			   skb->len + ETH_HLEN);
+	ret = batadv_aggr_queue_tail(skb, hard_iface);
+	if (!ret)
+		return NET_XMIT_DROP;
 
 	return NET_XMIT_SUCCESS;
 }
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 896a387..5f61b6b 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -697,7 +697,8 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 		return;
 
 	forw_packet_aggr = batadv_forw_packet_alloc(if_incoming, if_outgoing,
-						    queue_left, bat_priv, skb);
+						    queue_left, bat_priv, skb,
+						    false);
 	if (!forw_packet_aggr) {
 		kfree_skb(skb);
 		return;
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 08b61e0..cec6ae8 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -492,6 +492,8 @@ void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet,
  * @queue_left: The (optional) queue counter to decrease
  * @bat_priv: The bat_priv for the mesh of this forw_packet
  * @skb: The raw packet this forwarding packet shall contain
+ * @resend: Whether this packet should be transmitted more than once on wireless
+ *  interfaces
  *
  * Allocates a forwarding packet and tries to get a reference to the
  * (optional) if_incoming, if_outgoing and queue_left. If queue_left
@@ -504,7 +506,8 @@ batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 			 struct batadv_hard_iface *if_outgoing,
 			 atomic_t *queue_left,
 			 struct batadv_priv *bat_priv,
-			 struct sk_buff *skb)
+			 struct sk_buff *skb,
+			 bool resend)
 {
 	struct batadv_forw_packet *forw_packet;
 	const char *qname;
@@ -542,6 +545,8 @@ batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 	forw_packet->if_outgoing = if_outgoing;
 	forw_packet->num_packets = 0;
 
+	BATADV_SKB_CB(forw_packet->skb)->resend = resend;
+
 	return forw_packet;
 
 err:
@@ -775,7 +780,7 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 
 	forw_packet = batadv_forw_packet_alloc(primary_if, NULL,
 					       &bat_priv->bcast_queue_left,
-					       bat_priv, newskb);
+					       bat_priv, newskb, true);
 	batadv_hardif_put(primary_if);
 	if (!forw_packet)
 		goto err_packet_free;
@@ -799,6 +804,29 @@ err:
 }
 
 /**
+ * batadv_send_bcasts_left - check if a retransmission is necessary
+ * @skb: the packet to check
+ * @hard_iface: the interface to check on
+ *
+ * Checks whether a given packet has any (re)transmissions left on the provided
+ * interface.
+ *
+ * hard_iface may be NULL: In that case the number of transmissions this skb had
+ * so far is compared with the maximum amount of retransmissions independent of
+ * any interface instead.
+ *
+ * Return: True if (re)transmissions are left, false otherwise.
+ */
+bool batadv_send_bcasts_left(struct sk_buff *skb,
+			     struct batadv_hard_iface *hard_iface)
+{
+	int max = hard_iface ? hard_iface->num_bcasts : BATADV_NUM_BCASTS_MAX;
+	bool resend = !hard_iface || BATADV_SKB_CB(skb)->resend;
+
+	return resend && BATADV_SKB_CB(skb)->num_bcasts < max;
+}
+
+/**
  * batadv_forw_packet_bcasts_left - check if a retransmission is necessary
  * @forw_packet: the forwarding packet to check
  * @hard_iface: the interface to check on
@@ -816,9 +844,16 @@ static bool
 batadv_forw_packet_bcasts_left(struct batadv_forw_packet *forw_packet,
 			       struct batadv_hard_iface *hard_iface)
 {
-	int max = hard_iface ? hard_iface->num_bcasts : BATADV_NUM_BCASTS_MAX;
+	return batadv_send_bcasts_left(forw_packet->skb, hard_iface);
+}
 
-	return BATADV_SKB_CB(forw_packet->skb)->num_bcasts < max;
+/**
+ * batadv_send_bcasts_inc - increment the retransmission counter of an skb
+ * @skb: the packet to increase the counter for
+ */
+void batadv_send_bcasts_inc(struct sk_buff *skb)
+{
+	BATADV_SKB_CB(skb)->num_bcasts++;
 }
 
 /**
@@ -828,7 +863,18 @@ batadv_forw_packet_bcasts_left(struct batadv_forw_packet *forw_packet,
 static void
 batadv_forw_packet_bcasts_inc(struct batadv_forw_packet *forw_packet)
 {
-	BATADV_SKB_CB(forw_packet->skb)->num_bcasts++;
+	batadv_send_bcasts_inc(forw_packet->skb);
+}
+
+/**
+ * batadv_send_is_rebroadcast - check whether this packet was transmitted before
+ * @skb: the packet to check
+ *
+ * Return: True if this packet was transmitted already, false otherwise.
+ */
+bool batadv_send_is_rebroadcast(struct sk_buff *skb)
+{
+	return BATADV_SKB_CB(skb)->num_bcasts > 0;
 }
 
 /**
@@ -839,7 +885,7 @@ batadv_forw_packet_bcasts_inc(struct batadv_forw_packet *forw_packet)
  */
 bool batadv_forw_packet_is_rebroadcast(struct batadv_forw_packet *forw_packet)
 {
-	return BATADV_SKB_CB(forw_packet->skb)->num_bcasts > 0;
+	return batadv_send_is_rebroadcast(forw_packet->skb);
 }
 
 static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index a16b34f..cd1ee81 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -35,13 +35,19 @@ batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 			 struct batadv_hard_iface *if_outgoing,
 			 atomic_t *queue_left,
 			 struct batadv_priv *bat_priv,
-			 struct sk_buff *skb);
+			 struct sk_buff *skb,
+			 bool resend);
 bool batadv_forw_packet_steal(struct batadv_forw_packet *packet, spinlock_t *l);
 void batadv_forw_packet_ogmv1_queue(struct batadv_priv *bat_priv,
 				    struct batadv_forw_packet *forw_packet,
 				    unsigned long send_time);
 bool batadv_forw_packet_is_rebroadcast(struct batadv_forw_packet *forw_packet);
 
+bool batadv_send_bcasts_left(struct sk_buff *skb,
+			     struct batadv_hard_iface *hard_iface);
+void batadv_send_bcasts_inc(struct sk_buff *skb);
+bool batadv_send_is_rebroadcast(struct sk_buff *skb);
+
 int batadv_send_skb_to_orig(struct sk_buff *skb,
 			    struct batadv_orig_node *orig_node,
 			    struct batadv_hard_iface *recv_if);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0c5c373..f6787fb 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1445,10 +1445,13 @@ struct batadv_nc_packet {
  * @decoded: Marks a skb as decoded, which is checked when searching for coding
  *  opportunities in network-coding.c
  * @num_bcasts: Counter for broadcast packet retransmissions
+ * @resend: Whether this packet should be transmitted more than once on wireless
+ *  interfaces
  */
 struct batadv_skb_cb {
 	bool decoded;
 	int num_bcasts;
+	bool resend;
 };
 
 /**
-- 
2.1.4

