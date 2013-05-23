Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 23 May 2013 23:21:11 +0200
Message-Id: <1369344072-23916-7-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1369344072-23916-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1369344072-23916-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFC 6/7] batman-adv: consider outgoing interface in
	OGM sending
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
 bat_iv_ogm.c |  133 +++++++++++++++++++++++++++++++++++++++-------------------
 send.c       |   13 ++++--
 types.h      |    7 +++-
 3 files changed, 104 insertions(+), 49 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 324bf5f..3fc900c 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -272,7 +272,6 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 /* send a batman ogm packet */
 static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 {
-	struct batadv_hard_iface *hard_iface;
 	struct net_device *soft_iface;
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
@@ -292,6 +291,12 @@ static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
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
 
@@ -299,52 +304,35 @@ static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
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
@@ -378,6 +366,13 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 		if (!primary_if)
 			goto out;
 
+		/* packet is not leaving on the same interface.
+		 * TODO: some other parts here could be reworked as the
+		 * outgoing interface is specified now.
+		 */
+		if (forw_packet->if_outgoing != if_outgoing)
+			goto out;
+
 		/* packets without direct link flag and high TTL
 		 * are flooded through the net
 		 */
@@ -424,6 +419,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 					int packet_len, unsigned long send_time,
 					bool direct_link,
 					struct batadv_hard_iface *if_incoming,
+					struct batadv_hard_iface *if_outgoing,
 					int own_packet)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
@@ -434,6 +430,9 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	if (!atomic_inc_not_zero(&if_incoming->refcount))
 		return;
 
+	if (!atomic_inc_not_zero(&if_outgoing->refcount))
+		goto out_free_incoming;
+
 	/* own packet should always be scheduled */
 	if (!own_packet) {
 		if (!batadv_atomic_dec_not_zero(&bat_priv->batman_queue_left)) {
@@ -473,6 +472,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 
 	forw_packet_aggr->own = own_packet;
 	forw_packet_aggr->if_incoming = if_incoming;
+	forw_packet_aggr->if_outgoing = if_outgoing;
 	forw_packet_aggr->num_packets = 0;
 	forw_packet_aggr->direct_link_flags = BATADV_NO_FLAGS;
 	forw_packet_aggr->send_time = send_time;
@@ -495,6 +495,8 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 
 	return;
 out:
+	batadv_hardif_free_ref(if_outgoing);
+out_free_incoming:
 	batadv_hardif_free_ref(if_incoming);
 }
 
@@ -518,10 +520,21 @@ static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
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
@@ -547,6 +560,7 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 							bat_priv, packet_len,
 							send_time, direct_link,
 							if_incoming,
+							if_outgoing,
 							forw_packet_pos)) {
 				forw_packet_aggr = forw_packet_pos;
 				break;
@@ -570,7 +584,8 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 
 		batadv_iv_ogm_aggregate_new(packet_buff, packet_len,
 					    send_time, direct_link,
-					    if_incoming, own_packet);
+					    if_incoming, if_outgoing,
+					    own_packet);
 	} else {
 		batadv_iv_ogm_aggregate(forw_packet_aggr, packet_buff,
 					packet_len, direct_link);
@@ -583,7 +598,8 @@ static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 				  struct batadv_ogm_packet *batadv_ogm_packet,
 				  bool is_single_hop_neigh,
 				  bool is_from_best_next_hop,
-				  struct batadv_hard_iface *if_incoming)
+				  struct batadv_hard_iface *if_incoming,
+				  struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	uint16_t tvlv_len;
@@ -628,7 +644,8 @@ static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 
 	batadv_iv_ogm_queue_add(bat_priv, (unsigned char *)batadv_ogm_packet,
 				BATADV_OGM_HLEN + tvlv_len,
-				if_incoming, 0, batadv_iv_ogm_fwd_send_time());
+				if_incoming, if_outgoing, 0,
+				batadv_iv_ogm_fwd_send_time());
 }
 
 /**
@@ -671,10 +688,11 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
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
 
@@ -697,9 +715,31 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 	atomic_inc(&hard_iface->bat_iv.ogm_seqno);
 
 	batadv_iv_ogm_slide_own_bcast_window(hard_iface);
-	batadv_iv_ogm_queue_add(bat_priv, hard_iface->bat_iv.ogm_buff,
-				hard_iface->bat_iv.ogm_buff_len, hard_iface, 1,
-				batadv_iv_ogm_emit_send_time(bat_priv));
+
+	send_time = batadv_iv_ogm_emit_send_time(bat_priv);
+
+	if (hard_iface == primary_if) {
+		/* OGMs from primary interfaces are scheduled on all
+		 * interfaces.
+		 */
+		rcu_read_lock();
+		list_for_each_entry_rcu(tmp_hard_iface, &batadv_hardif_list,
+					list) {
+			if (tmp_hard_iface->soft_iface !=
+			    hard_iface->soft_iface)
+				continue;
+			batadv_iv_ogm_queue_add(bat_priv, *ogm_buff,
+						*ogm_buff_len, hard_iface,
+						tmp_hard_iface, 1, send_time);
+		}
+		rcu_read_unlock();
+	} else {
+		/* OGMs from secondary interfaces are only scheduled on their
+		 * respective interfaces.
+		 */
+		batadv_iv_ogm_queue_add(bat_priv, *ogm_buff, *ogm_buff_len,
+					hard_iface, hard_iface, 1, send_time);
+	}
 
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
@@ -1261,6 +1301,10 @@ batadv_iv_ogm_process_per_outif(const struct ethhdr *ethhdr,
 					  if_outgoing, tt_buff, dup_status);
 	rcu_read_unlock();
 
+	/* don't forward packet if no outgoing interface was specified */
+	if (!if_outgoing)
+		goto out_neigh;
+
 	/* is single hop (direct) neighbor */
 	if (is_single_hop_neigh) {
 		if ((batadv_ogm_packet->header.ttl <= 2) &&
@@ -1272,7 +1316,8 @@ batadv_iv_ogm_process_per_outif(const struct ethhdr *ethhdr,
 		/* mark direct link on incoming interface */
 		batadv_iv_ogm_forward(orig_node, ethhdr, batadv_ogm_packet,
 				      is_single_hop_neigh,
-				      is_from_best_next_hop, if_incoming);
+				      is_from_best_next_hop, if_incoming,
+				      if_outgoing);
 
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Forwarding packet: rebroadcast neighbor packet with direct link flag\n");
@@ -1296,7 +1341,7 @@ batadv_iv_ogm_process_per_outif(const struct ethhdr *ethhdr,
 		   "Forwarding packet: rebroadcast originator packet\n");
 	batadv_iv_ogm_forward(orig_node, ethhdr, batadv_ogm_packet,
 			      is_single_hop_neigh, is_from_best_next_hop,
-			      if_incoming);
+			      if_incoming, if_outgoing);
 
 out_neigh:
 	if ((orig_neigh_node) && (!is_single_hop_neigh))
diff --git a/send.c b/send.c
index 616364e..485b703 100644
--- a/send.c
+++ b/send.c
@@ -328,6 +328,8 @@ static void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
 		kfree_skb(forw_packet->skb);
 	if (forw_packet->if_incoming)
 		batadv_hardif_free_ref(forw_packet->if_incoming);
+	if (forw_packet->if_outgoing)
+		batadv_hardif_free_ref(forw_packet->if_outgoing);
 	kfree(forw_packet);
 }
 
@@ -391,6 +393,7 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 
 	forw_packet->skb = newskb;
 	forw_packet->if_incoming = primary_if;
+	forw_packet->if_outgoing = NULL;
 
 	/* how often did we send the bcast packet ? */
 	forw_packet->num_packets = 0;
@@ -488,9 +491,12 @@ void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 
 	/* we have to have at least one packet in the queue
 	 * to determine the queues wake up time unless we are
-	 * shutting down
+	 * shutting down.
+	 *
+	 * only re-schedule if this is the "original" copy.
 	 */
-	if (forw_packet->own)
+	if (forw_packet->own &&
+	    forw_packet->if_incoming == forw_packet->if_outgoing)
 		batadv_schedule_bat_ogm(forw_packet->if_incoming);
 
 out:
@@ -551,7 +557,8 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 		 * we delete only packets belonging to the given interface
 		 */
 		if ((hard_iface) &&
-		    (forw_packet->if_incoming != hard_iface))
+		    (forw_packet->if_incoming != hard_iface) &&
+		    (forw_packet->if_outgoing != hard_iface))
 			continue;
 
 		spin_unlock_bh(&bat_priv->forw_bat_list_lock);
diff --git a/types.h b/types.h
index 7e49f18..37bf7db 100644
--- a/types.h
+++ b/types.h
@@ -915,8 +915,10 @@ struct batadv_skb_cb {
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
@@ -928,6 +930,7 @@ struct batadv_forw_packet {
 	uint8_t num_packets;
 	struct delayed_work delayed_work;
 	struct batadv_hard_iface *if_incoming;
+	struct batadv_hard_iface *if_outgoing;
 };
 
 /**
-- 
1.7.10.4

