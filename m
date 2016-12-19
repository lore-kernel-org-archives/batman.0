Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 19 Dec 2016 12:25:34 +0100
Message-Id: <20161219112535.9446-6-linus.luessing@c0d3.blue>
In-Reply-To: <20161219112535.9446-1-linus.luessing@c0d3.blue>
References: <20161219112535.9446-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC PATCH 5/6] batman-adv: restructure rebroadcast
	counter into forw_packet API
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

This patch refactors the num_packets counter of a forw_packet in the
following three ways:

1) Removed dual-use of forw_packet::num_packets:
   -> now for aggregation purposes only
2) Using forw_packet::skb::cb::num_bcasts instead:
   -> for easier access in aggregation code later
3) make access to num_bcasts private to batadv_forw_packet_*()

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/distributed-arp-table.c |  2 +-
 net/batman-adv/main.c                  |  3 ++
 net/batman-adv/send.c                  | 50 ++++++++++++++++++++++++++++++++--
 net/batman-adv/send.h                  |  1 +
 net/batman-adv/types.h                 |  4 ++-
 5 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 689278e..3c222de 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1257,7 +1257,7 @@ bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
 	/* If this packet is an ARP_REQUEST and the node already has the
 	 * information that it is going to ask, then the packet can be dropped
 	 */
-	if (forw_packet->num_packets)
+	if (batadv_forw_packet_is_rebroadcast(forw_packet))
 		goto out;
 
 	vid = batadv_dat_get_vid(forw_packet->skb, &hdr_size);
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 286163d..e4ee067 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -534,6 +534,9 @@ static void batadv_recv_handler_init(void)
 	BUILD_BUG_ON(sizeof(struct batadv_tvlv_tt_change) != 12);
 	BUILD_BUG_ON(sizeof(struct batadv_tvlv_roam_adv) != 8);
 
+	i = FIELD_SIZEOF(struct sk_buff, cb);
+	BUILD_BUG_ON(sizeof(struct batadv_skb_cb) > i);
+
 	/* broadcast packet */
 	batadv_rx_handler[BATADV_BCAST] = batadv_recv_bcast_packet;
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index b58f8a9..b3f05b4 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -796,6 +796,50 @@ err:
 	return NETDEV_TX_BUSY;
 }
 
+/**
+ * batadv_forw_packet_bcasts_left - check if a retransmission is necessary
+ * @forw_packet: the forwarding packet to check
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
+static bool
+batadv_forw_packet_bcasts_left(struct batadv_forw_packet *forw_packet,
+			       struct batadv_hard_iface *hard_iface)
+{
+	int max = hard_iface ? hard_iface->num_bcasts : BATADV_NUM_BCASTS_MAX;
+
+	return BATADV_SKB_CB(forw_packet->skb)->num_bcasts < max;
+}
+
+/**
+ * batadv_forw_packet_bcasts_inc - increment retransmission counter of a packet
+ * @forw_packet: the packet to increase the counter for
+ */
+static void
+batadv_forw_packet_bcasts_inc(struct batadv_forw_packet *forw_packet)
+{
+	BATADV_SKB_CB(forw_packet->skb)->num_bcasts++;
+}
+
+/**
+ * batadv_forw_packet_is_rebroadcast - check packet for previous transmissions
+ * @forw_packet: the packet to check
+ *
+ * Return: True if this packet was transmitted before, false otherwise.
+ */
+bool batadv_forw_packet_is_rebroadcast(struct batadv_forw_packet *forw_packet)
+{
+	return BATADV_SKB_CB(forw_packet->skb)->num_bcasts > 0;
+}
+
 static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 {
 	struct batadv_hard_iface *hard_iface;
@@ -835,7 +879,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 		if (hard_iface->soft_iface != soft_iface)
 			continue;
 
-		if (forw_packet->num_packets >= hard_iface->num_bcasts)
+		if (!batadv_forw_packet_bcasts_left(forw_packet, hard_iface))
 			continue;
 
 		if (forw_packet->own) {
@@ -894,10 +938,10 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 	}
 	rcu_read_unlock();
 
-	forw_packet->num_packets++;
+	batadv_forw_packet_bcasts_inc(forw_packet);
 
 	/* if we still have some more bcasts to send */
-	if (forw_packet->num_packets < BATADV_NUM_BCASTS_MAX) {
+	if (batadv_forw_packet_bcasts_left(forw_packet, NULL)) {
 		batadv_forw_packet_bcast_queue(bat_priv, forw_packet,
 					       send_time);
 		return;
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 4506312..ae0e1c4 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -40,6 +40,7 @@ bool batadv_forw_packet_steal(struct batadv_forw_packet *packet, spinlock_t *l);
 void batadv_forw_packet_ogmv1_queue(struct batadv_priv *bat_priv,
 				    struct batadv_forw_packet *forw_packet,
 				    unsigned long send_time);
+bool batadv_forw_packet_is_rebroadcast(struct batadv_forw_packet *forw_packet);
 
 int batadv_send_skb_to_orig(struct sk_buff *skb,
 			    struct batadv_orig_node *orig_node,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 8964d02..e025452 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1444,9 +1444,11 @@ struct batadv_nc_packet {
  *  relevant to batman-adv in the skb->cb buffer in skbs.
  * @decoded: Marks a skb as decoded, which is checked when searching for coding
  *  opportunities in network-coding.c
+ * @num_bcasts: Counter for broadcast packet retransmissions
  */
 struct batadv_skb_cb {
 	bool decoded;
+	int num_bcasts;
 };
 
 /**
@@ -1459,7 +1461,7 @@ struct batadv_skb_cb {
  * @skb: bcast packet's skb buffer
  * @packet_len: size of aggregated OGM packet inside the skb buffer
  * @direct_link_flags: direct link flags for aggregated OGM packets
- * @num_packets: counter for bcast packet retransmission
+ * @num_packets: counter for aggregated OGMv1 packets
  * @delayed_work: work queue callback item for packet sending
  * @if_incoming: pointer to incoming hard-iface or primary iface if
  *  locally generated packet
-- 
2.1.4

