Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 30 Oct 2013 15:01:50 +0100
Message-Id: <1383141713-15820-6-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1383141713-15820-1-git-send-email-sw@simonwunderlich.de>
References: <1383141713-15820-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCHv2 5/8] batman-adv: consider outgoing
	interface in OGM sending
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

The current OGM sending an aggregation functionality decides on
which interfaces a packet should be sent when it parses the forward
packet struct. However, with the network wide multi interface
optimization the outgoing interface is decided by the OGM processing
function.

This is reflected by moving the decision in the OGM processing function
and add the outgoing interface in the forwarding packet struct. This
practically implies that an OGM may be added multiple times (once per
outgoing interface), and this also affects aggregation which needs to
consider the outgoing interface as well.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
Changes to PATCH:
 * beautify big if/else block in batadv_iv_ogm_schedule() and comments
 * remove TODO (obviously everyone is confused by that anyway. If
   someone wants to optimize the aggregation later, I'm sure he/she can
   do that without having my TODO in the code. :] )

Changes to RFCv2:
 * rework kerneldoc and comments
---
 bat_iv_ogm.c |  141 +++++++++++++++++++++++++++++++++++++++-------------------
 send.c       |   19 +++++---
 types.h      |    7 ++-
 3 files changed, 115 insertions(+), 52 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index a7e9cac..c44bca6 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -467,7 +467,6 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 /* send a batman ogm packet */
 static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 {
-	struct batadv_hard_iface *hard_iface;
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
@@ -487,6 +486,12 @@ static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 	soft_iface = forw_packet->if_incoming->soft_iface;
 	bat_priv = netdev_priv(soft_iface);
 
+	if (WARN_ON(!forw_packet->if_outgoing))
+		goto out;
+
+	if (WARN_ON(forw_packet->if_outgoing->soft_iface != soft_iface))
+		goto out;
+
 	if (forw_packet->if_incoming->if_status != BATADV_IF_ACTIVE)
 		goto out;
 
@@ -494,52 +499,35 @@ static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 	if (!primary_if)
 		goto out;
 
-	/* multihomed peer assumed
-	 * non-primary OGMs are only broadcasted on their interface
-	 */
-	if ((directlink && (batadv_ogm_packet->header.ttl == 1)) ||
-	    (forw_packet->own && (forw_packet->if_incoming != primary_if))) {
-		/* FIXME: what about aggregated packets ? */
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "%s packet (originator %pM, seqno %u, TTL %d) on interface %s [%pM]\n",
-			   (forw_packet->own ? "Sending own" : "Forwarding"),
-			   batadv_ogm_packet->orig,
-			   ntohl(batadv_ogm_packet->seqno),
-			   batadv_ogm_packet->header.ttl,
-			   forw_packet->if_incoming->net_dev->name,
-			   forw_packet->if_incoming->net_dev->dev_addr);
-
-		/* skb is only used once and than forw_packet is free'd */
-		batadv_send_skb_packet(forw_packet->skb,
-				       forw_packet->if_incoming,
-				       batadv_broadcast_addr);
-		forw_packet->skb = NULL;
-
-		goto out;
-	}
-
-	/* broadcast on every interface */
-	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->soft_iface != soft_iface)
-			continue;
-
-		batadv_iv_ogm_send_to_if(forw_packet, hard_iface);
-	}
-	rcu_read_unlock();
+	/* only for one specific outgoing interface */
+	batadv_iv_ogm_send_to_if(forw_packet, forw_packet->if_outgoing);
 
 out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
 }
 
-/* return true if new_packet can be aggregated with forw_packet */
+/**
+ * batadv_iv_ogm_can_aggregate - find out if an OGM can be aggregated on an
+ *  existing forward packet
+ * @new_bat_ogm_packet: OGM packet to be aggregated
+ * @bat_priv: the bat priv with all the soft interface information
+ * @packet_len: (total) length of the OGM
+ * @send_time: timestamp (jiffies) when the packet is to be sent
+ * @direktlink: true if this is a direct link packet
+ * @if_incoming: interface where the packet was received
+ * @if_outgoing: interface for which the retransmission should be considered
+ * @forw_packet: the forwarded packet which should be checked
+ *
+ * Returns true if new_packet can be aggregated with forw_packet
+ */
 static bool
 batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 			    struct batadv_priv *bat_priv,
 			    int packet_len, unsigned long send_time,
 			    bool directlink,
 			    const struct batadv_hard_iface *if_incoming,
+			    const struct batadv_hard_iface *if_outgoing,
 			    const struct batadv_forw_packet *forw_packet)
 {
 	struct batadv_ogm_packet *batadv_ogm_packet;
@@ -573,6 +561,10 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 		if (!primary_if)
 			goto out;
 
+		/* packet is not leaving on the same interface. */
+		if (forw_packet->if_outgoing != if_outgoing)
+			goto out;
+
 		/* packets without direct link flag and high TTL
 		 * are flooded through the net
 		 */
@@ -614,11 +606,21 @@ out:
 	return res;
 }
 
-/* create a new aggregated packet and add this packet to it */
+/* batadv_iv_ogm_aggregate_new - create a new aggregated packet and add this
+ *  packet to it.
+ * @packet_buff: pointer to the OGM
+ * @packet_len: (total) length of the OGM
+ * @send_time: timestamp (jiffies) when the packet is to be sent
+ * @direct_link: whether this OGM has direct link status
+ * @if_incoming: interface where the packet was received
+ * @if_outgoing: interface for which the retransmission should be considered
+ * @own_packet: true if it is a self-generated ogm
+ */
 static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 					int packet_len, unsigned long send_time,
 					bool direct_link,
 					struct batadv_hard_iface *if_incoming,
+					struct batadv_hard_iface *if_outgoing,
 					int own_packet)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
@@ -629,6 +631,9 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	if (!atomic_inc_not_zero(&if_incoming->refcount))
 		return;
 
+	if (!atomic_inc_not_zero(&if_outgoing->refcount))
+		goto out_free_incoming;
+
 	/* own packet should always be scheduled */
 	if (!own_packet) {
 		if (!batadv_atomic_dec_not_zero(&bat_priv->batman_queue_left)) {
@@ -669,6 +674,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 
 	forw_packet_aggr->own = own_packet;
 	forw_packet_aggr->if_incoming = if_incoming;
+	forw_packet_aggr->if_outgoing = if_outgoing;
 	forw_packet_aggr->num_packets = 0;
 	forw_packet_aggr->direct_link_flags = BATADV_NO_FLAGS;
 	forw_packet_aggr->send_time = send_time;
@@ -691,6 +697,8 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 
 	return;
 out:
+	batadv_hardif_free_ref(if_outgoing);
+out_free_incoming:
 	batadv_hardif_free_ref(if_incoming);
 }
 
@@ -714,10 +722,21 @@ static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
 	}
 }
 
+/**
+ * batadv_iv_ogm_queue_add - queue up an OGM for transmission
+ * @bat_priv: the bat priv with all the soft interface information
+ * @packet_buff: pointer to the OGM
+ * @packet_len: (total) length of the OGM
+ * @if_incoming: interface where the packet was received
+ * @if_outgoing: interface for which the retransmission should be considered
+ * @own_packet: true if it is a self-generated ogm
+ * @send_time: timestamp (jiffies) when the packet is to be sent
+ */
 static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 				    unsigned char *packet_buff,
 				    int packet_len,
 				    struct batadv_hard_iface *if_incoming,
+				    struct batadv_hard_iface *if_outgoing,
 				    int own_packet, unsigned long send_time)
 {
 	/* _aggr -> pointer to the packet we want to aggregate with
@@ -743,6 +762,7 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 							bat_priv, packet_len,
 							send_time, direct_link,
 							if_incoming,
+							if_outgoing,
 							forw_packet_pos)) {
 				forw_packet_aggr = forw_packet_pos;
 				break;
@@ -766,7 +786,8 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 
 		batadv_iv_ogm_aggregate_new(packet_buff, packet_len,
 					    send_time, direct_link,
-					    if_incoming, own_packet);
+					    if_incoming, if_outgoing,
+					    own_packet);
 	} else {
 		batadv_iv_ogm_aggregate(forw_packet_aggr, packet_buff,
 					packet_len, direct_link);
@@ -779,7 +800,8 @@ static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 				  struct batadv_ogm_packet *batadv_ogm_packet,
 				  bool is_single_hop_neigh,
 				  bool is_from_best_next_hop,
-				  struct batadv_hard_iface *if_incoming)
+				  struct batadv_hard_iface *if_incoming,
+				  struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	uint16_t tvlv_len;
@@ -824,7 +846,8 @@ static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 
 	batadv_iv_ogm_queue_add(bat_priv, (unsigned char *)batadv_ogm_packet,
 				BATADV_OGM_HLEN + tvlv_len,
-				if_incoming, 0, batadv_iv_ogm_fwd_send_time());
+				if_incoming, if_outgoing, 0,
+				batadv_iv_ogm_fwd_send_time());
 }
 
 /**
@@ -869,10 +892,11 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	unsigned char **ogm_buff = &hard_iface->bat_iv.ogm_buff;
 	struct batadv_ogm_packet *batadv_ogm_packet;
-	struct batadv_hard_iface *primary_if;
+	struct batadv_hard_iface *primary_if, *tmp_hard_iface;
 	int *ogm_buff_len = &hard_iface->bat_iv.ogm_buff_len;
 	uint32_t seqno;
 	uint16_t tvlv_len = 0;
+	unsigned long send_time;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 
@@ -895,10 +919,32 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 	atomic_inc(&hard_iface->bat_iv.ogm_seqno);
 
 	batadv_iv_ogm_slide_own_bcast_window(hard_iface);
-	batadv_iv_ogm_queue_add(bat_priv, hard_iface->bat_iv.ogm_buff,
-				hard_iface->bat_iv.ogm_buff_len, hard_iface, 1,
-				batadv_iv_ogm_emit_send_time(bat_priv));
 
+	send_time = batadv_iv_ogm_emit_send_time(bat_priv);
+
+	if (hard_iface != primary_if) {
+		/* OGMs from secondary interfaces are only scheduled on their
+		 * respective interfaces.
+		 */
+		batadv_iv_ogm_queue_add(bat_priv, *ogm_buff, *ogm_buff_len,
+					hard_iface, hard_iface, 1, send_time);
+		goto out;
+	}
+
+	/* OGMs from primary interfaces are scheduled on all
+	 * interfaces.
+	 */
+	rcu_read_lock();
+	list_for_each_entry_rcu(tmp_hard_iface, &batadv_hardif_list, list) {
+		if (tmp_hard_iface->soft_iface != hard_iface->soft_iface)
+				continue;
+		batadv_iv_ogm_queue_add(bat_priv, *ogm_buff,
+					*ogm_buff_len, hard_iface,
+					tmp_hard_iface, 1, send_time);
+	}
+	rcu_read_unlock();
+
+out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
 }
@@ -1446,6 +1492,10 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 	}
 	batadv_orig_ifinfo_free_ref(orig_ifinfo);
 
+	/* only forward for specific interface, not for the default one. */
+	if (if_outgoing == BATADV_IF_DEFAULT)
+		goto out_neigh;
+
 	/* is single hop (direct) neighbor */
 	if (is_single_hop_neigh) {
 		if ((ogm_packet->header.ttl <= 2) &&
@@ -1457,7 +1507,8 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 		/* mark direct link on incoming interface */
 		batadv_iv_ogm_forward(orig_node, ethhdr, ogm_packet,
 				      is_single_hop_neigh,
-				      is_from_best_next_hop, if_incoming);
+				      is_from_best_next_hop, if_incoming,
+				      if_outgoing);
 
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Forwarding packet: rebroadcast neighbor packet with direct link flag\n");
@@ -1481,7 +1532,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 		   "Forwarding packet: rebroadcast originator packet\n");
 	batadv_iv_ogm_forward(orig_node, ethhdr, ogm_packet,
 			      is_single_hop_neigh, is_from_best_next_hop,
-			      if_incoming);
+			      if_incoming, if_outgoing);
 
 out_neigh:
 	if ((orig_neigh_node) && (!is_single_hop_neigh))
diff --git a/send.c b/send.c
index c83be5e..a0dbeef 100644
--- a/send.c
+++ b/send.c
@@ -379,6 +379,8 @@ static void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
 		kfree_skb(forw_packet->skb);
 	if (forw_packet->if_incoming)
 		batadv_hardif_free_ref(forw_packet->if_incoming);
+	if (forw_packet->if_outgoing)
+		batadv_hardif_free_ref(forw_packet->if_outgoing);
 	kfree(forw_packet);
 }
 
@@ -442,6 +444,7 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 
 	forw_packet->skb = newskb;
 	forw_packet->if_incoming = primary_if;
+	forw_packet->if_outgoing = NULL;
 
 	/* how often did we send the bcast packet ? */
 	forw_packet->num_packets = 0;
@@ -537,11 +540,16 @@ void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 
 	bat_priv->bat_algo_ops->bat_ogm_emit(forw_packet);
 
-	/* we have to have at least one packet in the queue
-	 * to determine the queues wake up time unless we are
-	 * shutting down
+	/* we have to have at least one packet in the queue to determine the
+	 * queues wake up time unless we are shutting down.
+	 *
+	 * only re-schedule if this is the "original" copy, e.g. the OGM of the
+	 * primary interface should only be rescheduled once per period, but
+	 * this function will be called for the forw_packet instances of the
+	 * other secondary interfaces as well.
 	 */
-	if (forw_packet->own)
+	if (forw_packet->own &&
+	    forw_packet->if_incoming == forw_packet->if_outgoing)
 		batadv_schedule_bat_ogm(forw_packet->if_incoming);
 
 out:
@@ -602,7 +610,8 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 		 * we delete only packets belonging to the given interface
 		 */
 		if ((hard_iface) &&
-		    (forw_packet->if_incoming != hard_iface))
+		    (forw_packet->if_incoming != hard_iface) &&
+		    (forw_packet->if_outgoing != hard_iface))
 			continue;
 
 		spin_unlock_bh(&bat_priv->forw_bat_list_lock);
diff --git a/types.h b/types.h
index 167c3a5..be3a4fd 100644
--- a/types.h
+++ b/types.h
@@ -1005,8 +1005,10 @@ struct batadv_skb_cb {
  * @direct_link_flags: direct link flags for aggregated OGM packets
  * @num_packets: counter for bcast packet retransmission
  * @delayed_work: work queue callback item for packet sending
- * @if_incoming: pointer incoming hard-iface or primary iface if locally
- *  generated packet
+ * @if_incoming: pointer to incoming hard-iface or primary iface if
+ *  locally generated packet
+ * @if_outgoing: packet where the packet should be sent to, or NULL if
+ *  unspecified
  */
 struct batadv_forw_packet {
 	struct hlist_node list;
@@ -1018,6 +1020,7 @@ struct batadv_forw_packet {
 	uint8_t num_packets;
 	struct delayed_work delayed_work;
 	struct batadv_hard_iface *if_incoming;
+	struct batadv_hard_iface *if_outgoing;
 };
 
 /**
-- 
1.7.10.4

