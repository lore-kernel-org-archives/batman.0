Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 23 May 2013 23:21:09 +0200
Message-Id: <1369344072-23916-5-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1369344072-23916-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1369344072-23916-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFC 4/7] batman-adv: split out router from orig_node
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

For the network wide multi interface optimization there are different
routers for each outgoing interface (outgoing from the OGM perspective,
incoming for payload traffic). To reflect this, change the router and
associated data to a list of routers.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 bat_iv_ogm.c            |  385 +++++++++++++++++++++++++++++------------------
 distributed-arp-table.c |    3 +-
 gateway_client.c        |   10 +-
 icmp_socket.c           |    2 +-
 network-coding.c        |    9 +-
 originator.c            |  166 +++++++++++++++++++-
 originator.h            |   11 +-
 routing.c               |   42 +++++-
 routing.h               |    1 +
 translation-table.c     |    3 +-
 types.h                 |   25 ++-
 11 files changed, 483 insertions(+), 174 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index e98386c..f0b16d6 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -736,6 +736,7 @@ enum batadv_dup_status {
 static void
 batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 			  struct batadv_orig_node *orig_node,
+			  struct batadv_orig_node_ifinfo *orig_node_ifinfo,
 			  const struct ethhdr *ethhdr,
 			  const struct batadv_ogm_packet *batadv_ogm_packet,
 			  struct batadv_hard_iface *if_incoming,
@@ -823,21 +824,28 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&neigh_node->lq_update_lock);
 
 	if (dup_status == BATADV_NO_DUP) {
-		orig_node->last_ttl = batadv_ogm_packet->header.ttl;
+		orig_node_ifinfo->last_ttl = batadv_ogm_packet->header.ttl;
 		neigh_ifinfo->last_ttl = batadv_ogm_packet->header.ttl;
 	}
 
 	/* if this neighbor already is our next hop there is nothing
 	 * to change
 	 */
-	router = batadv_orig_node_get_router(orig_node);
+	router = batadv_orig_node_get_router(orig_node, if_outgoing);
 	if (router == neigh_node)
 		goto out;
 
-	router_ifinfo = batadv_neigh_node_get_ifinfo(router, if_outgoing);
-	/* if this neighbor does not offer a better TQ we won't consider it */
-	if (router_ifinfo && (router_ifinfo->tq_avg > neigh_ifinfo->tq_avg))
-		goto out;
+	if (router) {
+		router_ifinfo = batadv_neigh_node_get_ifinfo(router,
+							     if_outgoing);
+		/* if this neighbor does not offer a better TQ we won't
+		 * consider it
+		 */
+		if (router_ifinfo->tq_avg > neigh_ifinfo->tq_avg)
+			goto out;
+	} else {
+		router_ifinfo = NULL;
+	}
 
 	/* if the TQ is the same and the link not more symmetric we
 	 * won't consider it either
@@ -859,8 +867,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 			goto out;
 	}
 
-	/* TODO: pass if_outgoing later */
-	batadv_update_route(bat_priv, orig_node, neigh_node);
+	batadv_update_route(bat_priv, orig_node, if_outgoing, neigh_node);
 	goto out;
 
 out:
@@ -1016,6 +1023,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_orig_node *orig_node;
+	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
 	struct batadv_neigh_node *neigh_node;
 	struct batadv_neigh_node_ifinfo *neigh_ifinfo;
 	int is_dup;
@@ -1031,8 +1039,14 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	if (!orig_node)
 		return BATADV_NO_DUP;
 
+	orig_node_ifinfo = batadv_orig_node_get_ifinfo(orig_node, if_outgoing);
+	if (WARN_ON(!orig_node_ifinfo)) {
+		batadv_orig_node_free_ref(orig_node);
+		return 0;
+	}
+
 	spin_lock_bh(&orig_node->ogm_cnt_lock);
-	seq_diff = seqno - orig_node->last_real_seqno;
+	seq_diff = seqno - orig_node_ifinfo->last_real_seqno;
 
 	/* signalize caller that the packet is to be dropped. */
 	if (!hlist_empty(&orig_node->neigh_list) &&
@@ -1052,7 +1066,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
 		neigh_addr = neigh_node->addr;
 		is_dup = batadv_test_bit(neigh_ifinfo->real_bits,
-					 orig_node->last_real_seqno,
+					 orig_node_ifinfo->last_real_seqno,
 					 seqno);
 
 		if (batadv_compare_eth(neigh_addr, ethhdr->h_source) &&
@@ -1078,9 +1092,10 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
 	if (need_update) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "updating last_seqno: old %u, new %u\n",
-			   orig_node->last_real_seqno, seqno);
-		orig_node->last_real_seqno = seqno;
+			   "%s updating last_seqno: old %u, new %u\n",
+			   if_outgoing ? if_outgoing->net_dev->name : "NULL",
+			   orig_node_ifinfo->last_real_seqno, seqno);
+		orig_node_ifinfo->last_real_seqno = seqno;
 	}
 	rcu_read_unlock();
 
@@ -1090,26 +1105,214 @@ out:
 	return ret;
 }
 
-static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
-				  struct batadv_ogm_packet *batadv_ogm_packet,
-				  const unsigned char *tt_buff,
-				  struct batadv_hard_iface *if_incoming)
+
+/**
+ * batadv_iv_ogm_process_per_outif - process a batman iv OGM for an outgoing if
+ * @ethhdr: the original ethernet header of the sender
+ * @orig_node: the orig node for the originator of this packet
+ * @batadv_ogm_packet: pointer to the ogm packet
+ * @tt_buff: pointer to the tt buffer
+ * @if_incoming: the interface where this packet was receved
+ * @if_outgoing: the interface for which the packet should be considered
+ */
+static void
+batadv_iv_ogm_process_per_outif(const struct ethhdr *ethhdr,
+				struct batadv_orig_node *orig_node,
+				struct batadv_ogm_packet *batadv_ogm_packet,
+				const unsigned char *tt_buff,
+				struct batadv_hard_iface *if_incoming,
+				struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
-	struct batadv_hard_iface *hard_iface;
-	struct batadv_orig_node *orig_neigh_node, *orig_node;
 	struct batadv_neigh_node *router = NULL, *router_router = NULL;
 	struct batadv_neigh_node *orig_neigh_router = NULL;
 	struct batadv_neigh_node_ifinfo *router_ifinfo = NULL;
-	int has_directlink_flag;
-	int is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
-	int is_bidirect;
-	bool is_single_hop_neigh = false;
-	bool is_from_best_next_hop = false;
-	int sameseq, similar_ttl;
+	struct batadv_orig_node *orig_neigh_node;
+	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
+	int is_bidirect, sameseq, similar_ttl;
 	enum batadv_dup_status dup_status;
-	uint32_t if_incoming_seqno;
 	uint8_t *prev_sender;
+	struct batadv_ogm_packet ogm_packet_backup;
+	bool is_from_best_next_hop = false;
+	bool is_single_hop_neigh = false;
+
+	/* some functions change tq value and/or flags. backup the ogm packet
+	 * and restore it at the end to allow other interfaces to access the
+	 * original data.
+	 */
+
+	memcpy(&ogm_packet_backup, batadv_ogm_packet,
+	       sizeof(ogm_packet_backup));
+
+	dup_status = batadv_iv_ogm_update_seqnos(ethhdr, batadv_ogm_packet,
+						 if_incoming, if_outgoing);
+	if (batadv_compare_eth(ethhdr->h_source, batadv_ogm_packet->orig))
+		is_single_hop_neigh = true;
+
+	if (dup_status == BATADV_PROTECTED) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Drop packet: packet within seqno protection time (sender: %pM)\n",
+			   ethhdr->h_source);
+		goto out;
+	}
+
+	if (batadv_ogm_packet->tq == 0) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Drop packet: originator packet with tq equal 0\n");
+		goto out;
+	}
+
+	rcu_read_lock();
+	router = batadv_orig_node_get_router(orig_node, if_outgoing);
+	if (router)
+		router_router = batadv_orig_node_get_router(router->orig_node,
+							    if_outgoing);
+
+	if (router)
+		router_ifinfo = batadv_neigh_node_get_ifinfo(router,
+							     if_outgoing);
+
+	if ((router_ifinfo && router_ifinfo->tq_avg != 0) &&
+	    (batadv_compare_eth(router->addr, ethhdr->h_source)))
+		is_from_best_next_hop = true;
+	rcu_read_unlock();
+
+	prev_sender = batadv_ogm_packet->prev_sender;
+	/* avoid temporary routing loops */
+	if (router && router_router &&
+	    (batadv_compare_eth(router->addr, prev_sender)) &&
+	    !(batadv_compare_eth(batadv_ogm_packet->orig, prev_sender)) &&
+	    (batadv_compare_eth(router->addr, router_router->addr))) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %pM)\n",
+			   ethhdr->h_source);
+		goto out;
+	}
+
+	/* if sender is a direct neighbor the sender mac equals
+	 * originator mac
+	 */
+	if (is_single_hop_neigh)
+		orig_neigh_node = orig_node;
+	else
+		orig_neigh_node = batadv_get_orig_node(bat_priv,
+						       ethhdr->h_source);
+
+	if (!orig_neigh_node)
+		goto out;
+
+	/* Update nc_nodes of the originator */
+	batadv_nc_update_nc_node(bat_priv, orig_node, orig_neigh_node,
+				 batadv_ogm_packet, is_single_hop_neigh);
+
+	orig_neigh_router = batadv_orig_node_get_router(orig_neigh_node,
+							if_outgoing);
+
+	/* drop packet if sender is not a direct neighbor and if we
+	 * don't route towards it
+	 */
+	if (!is_single_hop_neigh && (!orig_neigh_router)) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Drop packet: OGM via unknown neighbor!\n");
+		goto out_neigh;
+	}
+
+	is_bidirect = batadv_iv_ogm_calc_tq(orig_node, orig_neigh_node,
+					    batadv_ogm_packet, if_incoming,
+					    if_outgoing);
+
+	/* update ranking if it is not a duplicate or has the same
+	 * seqno and similar ttl as the non-duplicate
+	 */
+	rcu_read_lock();
+	orig_node_ifinfo = batadv_orig_node_get_ifinfo(orig_node, if_outgoing);
+	if (!orig_node_ifinfo) {
+		rcu_read_unlock();
+		goto out_neigh;
+	}
+
+	sameseq = (orig_node_ifinfo->last_real_seqno ==
+		   ntohl(batadv_ogm_packet->seqno));
+	similar_ttl = (orig_node_ifinfo->last_ttl - 3) <=
+		      batadv_ogm_packet->header.ttl;
+	if (is_bidirect && ((dup_status == BATADV_NO_DUP) ||
+			    (sameseq && similar_ttl)))
+		batadv_iv_ogm_orig_update(bat_priv, orig_node,
+					  orig_node_ifinfo, ethhdr,
+					  batadv_ogm_packet, if_incoming,
+					  if_outgoing, tt_buff, dup_status);
+	rcu_read_unlock();
+
+	/* is single hop (direct) neighbor */
+	if (is_single_hop_neigh) {
+		if ((batadv_ogm_packet->header.ttl <= 2) &&
+		    (if_incoming != if_outgoing)) {
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Drop packet: OGM from secondary interface and wrong outgoing interface\n");
+			goto out_neigh;
+		}
+		/* mark direct link on incoming interface */
+		batadv_iv_ogm_forward(orig_node, ethhdr, batadv_ogm_packet,
+				      is_single_hop_neigh,
+				      is_from_best_next_hop, if_incoming);
+
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Forwarding packet: rebroadcast neighbor packet with direct link flag\n");
+		goto out_neigh;
+	}
+
+	/* multihop originator */
+	if (!is_bidirect) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Drop packet: not received via bidirectional link\n");
+		goto out_neigh;
+	}
+
+	if (dup_status == BATADV_NEIGH_DUP) {
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "Drop packet: duplicate packet received\n");
+		goto out_neigh;
+	}
+
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "Forwarding packet: rebroadcast originator packet\n");
+	batadv_iv_ogm_forward(orig_node, ethhdr, batadv_ogm_packet,
+			      is_single_hop_neigh, is_from_best_next_hop,
+			      if_incoming);
+
+out_neigh:
+	if ((orig_neigh_node) && (!is_single_hop_neigh))
+		batadv_orig_node_free_ref(orig_neigh_node);
+out:
+	if (router)
+		batadv_neigh_node_free_ref(router);
+	if (router_router)
+		batadv_neigh_node_free_ref(router_router);
+	if (orig_neigh_router)
+		batadv_neigh_node_free_ref(orig_neigh_router);
+
+	memcpy(batadv_ogm_packet, &ogm_packet_backup,
+	       sizeof(ogm_packet_backup));
+}
+
+/**
+ * batadv_iv_ogm_process - process an incoming batman iv OGM
+ * @ethhdr: the original ethernet header of the sender
+ * @batadv_ogm_packet: pointer to the ogm packet
+ * @tt_buff: pointer to the tt buffer
+ * @if_incoming: the interface where this packet was receved
+ */
+static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
+				  struct batadv_ogm_packet *batadv_ogm_packet,
+				  const unsigned char *tt_buff,
+				  struct batadv_hard_iface *if_incoming)
+{
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_hard_iface *hard_iface;
+	struct batadv_orig_node *orig_neigh_node, *orig_node;
+	uint32_t if_incoming_seqno;
+	int has_directlink_flag;
+	int is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
 
 	/* Silently drop when the batman packet is actually not a
 	 * correct packet.
@@ -1134,9 +1337,6 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	else
 		has_directlink_flag = 0;
 
-	if (batadv_compare_eth(ethhdr->h_source, batadv_ogm_packet->orig))
-		is_single_hop_neigh = true;
-
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Received BATMAN packet via NB: %pM, IF: %s [%pM] (from OG: %pM, via prev OG: %pM, seqno %u, tq %d, TTL %d, V %d, IDF %d)\n",
 		   ethhdr->h_source, if_incoming->net_dev->name,
@@ -1232,127 +1432,24 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	if (!orig_node)
 		return;
 
-	dup_status = batadv_iv_ogm_update_seqnos(ethhdr, batadv_ogm_packet,
-						 if_incoming, NULL);
-
-	if (dup_status == BATADV_PROTECTED) {
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Drop packet: packet within seqno protection time (sender: %pM)\n",
-			   ethhdr->h_source);
-		goto out;
-	}
-
-	if (batadv_ogm_packet->tq == 0) {
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Drop packet: originator packet with tq equal 0\n");
-		goto out;
-	}
-
-	router = batadv_orig_node_get_router(orig_node);
-	if (router)
-		router_router = batadv_orig_node_get_router(router->orig_node);
-
-	if ((router && router_ifinfo->tq_avg != 0) &&
-	    (batadv_compare_eth(router->addr, ethhdr->h_source)))
-		is_from_best_next_hop = true;
-
-	prev_sender = batadv_ogm_packet->prev_sender;
-	/* avoid temporary routing loops */
-	if (router && router_router &&
-	    (batadv_compare_eth(router->addr, prev_sender)) &&
-	    !(batadv_compare_eth(batadv_ogm_packet->orig, prev_sender)) &&
-	    (batadv_compare_eth(router->addr, router_router->addr))) {
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %pM)\n",
-			   ethhdr->h_source);
-		goto out;
-	}
-
 	batadv_tvlv_ogm_receive(bat_priv, batadv_ogm_packet, orig_node);
 
-	/* if sender is a direct neighbor the sender mac equals
-	 * originator mac
-	 */
-	if (is_single_hop_neigh)
-		orig_neigh_node = orig_node;
-	else
-		orig_neigh_node = batadv_get_orig_node(bat_priv,
-						       ethhdr->h_source);
+	batadv_iv_ogm_process_per_outif(ethhdr, orig_node, batadv_ogm_packet,
+					tt_buff, if_incoming, NULL);
 
-	if (!orig_neigh_node)
-		goto out;
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->if_status != BATADV_IF_ACTIVE)
+			continue;
 
-	/* Update nc_nodes of the originator */
-	batadv_nc_update_nc_node(bat_priv, orig_node, orig_neigh_node,
-				 batadv_ogm_packet, is_single_hop_neigh);
+		if (hard_iface->soft_iface != bat_priv->soft_iface)
+			continue;
 
-	orig_neigh_router = batadv_orig_node_get_router(orig_neigh_node);
-
-	/* drop packet if sender is not a direct neighbor and if we
-	 * don't route towards it
-	 */
-	if (!is_single_hop_neigh && (!orig_neigh_router)) {
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Drop packet: OGM via unknown neighbor!\n");
-		goto out_neigh;
-	}
-
-	is_bidirect = batadv_iv_ogm_calc_tq(orig_node, orig_neigh_node,
-					    batadv_ogm_packet, if_incoming,
-					    NULL);
-
-	/* update ranking if it is not a duplicate or has the same
-	 * seqno and similar ttl as the non-duplicate
-	 */
-	sameseq = orig_node->last_real_seqno == ntohl(batadv_ogm_packet->seqno);
-	similar_ttl = orig_node->last_ttl - 3 <= batadv_ogm_packet->header.ttl;
-	if (is_bidirect && ((dup_status == BATADV_NO_DUP) ||
-			    (sameseq && similar_ttl)))
-		batadv_iv_ogm_orig_update(bat_priv, orig_node, ethhdr,
-					  batadv_ogm_packet, if_incoming,
-					  NULL, tt_buff, dup_status);
-
-	/* is single hop (direct) neighbor */
-	if (is_single_hop_neigh) {
-		/* mark direct link on incoming interface */
-		batadv_iv_ogm_forward(orig_node, ethhdr, batadv_ogm_packet,
-				      is_single_hop_neigh,
-				      is_from_best_next_hop, if_incoming);
-
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Forwarding packet: rebroadcast neighbor packet with direct link flag\n");
-		goto out_neigh;
+		batadv_iv_ogm_process_per_outif(ethhdr, orig_node,
+						batadv_ogm_packet, tt_buff,
+						if_incoming, hard_iface);
 	}
-
-	/* multihop originator */
-	if (!is_bidirect) {
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Drop packet: not received via bidirectional link\n");
-		goto out_neigh;
-	}
-
-	if (dup_status == BATADV_NEIGH_DUP) {
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Drop packet: duplicate packet received\n");
-		goto out_neigh;
-	}
-
-	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "Forwarding packet: rebroadcast originator packet\n");
-	batadv_iv_ogm_forward(orig_node, ethhdr, batadv_ogm_packet,
-			      is_single_hop_neigh, is_from_best_next_hop,
-			      if_incoming);
-
-out_neigh:
-	if ((orig_neigh_node) && (!is_single_hop_neigh))
-		batadv_orig_node_free_ref(orig_neigh_node);
-out:
-	if (router)
-		batadv_neigh_node_free_ref(router);
-	if (router_router)
-		batadv_neigh_node_free_ref(router_router);
-	if (orig_neigh_router)
-		batadv_neigh_node_free_ref(orig_neigh_router);
+	rcu_read_unlock();
 
 	batadv_orig_node_free_ref(orig_node);
 }
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 99da412..d43e486 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -586,7 +586,8 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 		if (cand[i].type == BATADV_DAT_CANDIDATE_NOT_FOUND)
 			continue;
 
-		neigh_node = batadv_orig_node_get_router(cand[i].orig_node);
+		neigh_node = batadv_orig_node_get_router(cand[i].orig_node,
+							 NULL);
 		if (!neigh_node)
 			goto free_orig;
 
diff --git a/gateway_client.c b/gateway_client.c
index c134321..efe6238 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -131,7 +131,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 			continue;
 
 		orig_node = gw_node->orig_node;
-		router = batadv_orig_node_get_router(orig_node);
+		router = batadv_orig_node_get_router(orig_node, NULL);
 		if (!router)
 			continue;
 
@@ -222,7 +222,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 	if (next_gw) {
 		sprintf(gw_addr, "%pM", next_gw->orig_node->orig);
 
-		router = batadv_orig_node_get_router(next_gw->orig_node);
+		router = batadv_orig_node_get_router(next_gw->orig_node, NULL);
 		if (!router) {
 			batadv_gw_deselect(bat_priv);
 			goto out;
@@ -288,7 +288,7 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 	if (!curr_gw_orig)
 		goto deselect;
 
-	router_gw = batadv_orig_node_get_router(curr_gw_orig);
+	router_gw = batadv_orig_node_get_router(curr_gw_orig, NULL);
 	if (!router_gw)
 		goto deselect;
 
@@ -300,7 +300,7 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 	if (curr_gw_orig == orig_node)
 		goto out;
 
-	router_orig = batadv_orig_node_get_router(orig_node);
+	router_orig = batadv_orig_node_get_router(orig_node, NULL);
 	if (!router_orig)
 		goto out;
 
@@ -528,7 +528,7 @@ static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
 	int ret = -1;
 
 	rcu_read_lock();
-	router = batadv_orig_node_get_router(gw_node->orig_node);
+	router = batadv_orig_node_get_router(gw_node->orig_node, NULL);
 	if (!router)
 		goto out;
 
diff --git a/icmp_socket.c b/icmp_socket.c
index b27508b..fc5cd17 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -222,7 +222,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 	if (!orig_node)
 		goto dst_unreach;
 
-	neigh_node = batadv_orig_node_get_router(orig_node);
+	neigh_node = batadv_orig_node_get_router(orig_node, NULL);
 	if (!neigh_node)
 		goto dst_unreach;
 
diff --git a/network-coding.c b/network-coding.c
index ef88a1f..0e1cd7e 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -1010,12 +1010,17 @@ static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
 	int coded_size = sizeof(*coded_packet);
 	int header_add = coded_size - unicast_size;
 
-	router_neigh = batadv_orig_node_get_router(neigh_node->orig_node);
+	/* TODO: do we need to consider the outgoing interface for
+	 * coded packets?
+	 */
+	router_neigh = batadv_orig_node_get_router(neigh_node->orig_node,
+						   NULL);
 	if (!router_neigh)
 		goto out;
 
 	neigh_tmp = nc_packet->neigh_node;
-	router_coding = batadv_orig_node_get_router(neigh_tmp->orig_node);
+	router_coding = batadv_orig_node_get_router(neigh_tmp->orig_node,
+						    NULL);
 	if (!router_coding)
 		goto out;
 
diff --git a/originator.c b/originator.c
index 66af68d..16e277d 100644
--- a/originator.c
+++ b/originator.c
@@ -92,14 +92,28 @@ void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node)
 		call_rcu(&neigh_node->rcu, batadv_neigh_node_free_rcu);
 }
 
-/* increases the refcounter of a found router */
+/**
+ * batadv_orig_node_get_router - router to the originator depending on iface
+ * @orig_node: the orig node for the router
+ * @if_received: the interface where the packet to be transmitted was received
+ * Returns: the neighbor which should be router for this orig_node/iface
+ */
 struct batadv_neigh_node *
-batadv_orig_node_get_router(struct batadv_orig_node *orig_node)
+batadv_orig_node_get_router(struct batadv_orig_node *orig_node,
+			    const struct batadv_hard_iface *if_received)
 {
-	struct batadv_neigh_node *router;
+	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
+	struct batadv_neigh_node *router = NULL;
 
 	rcu_read_lock();
-	router = rcu_dereference(orig_node->router);
+	hlist_for_each_entry_rcu(orig_node_ifinfo,
+				 &orig_node->ifinfo_list, list) {
+		if (orig_node_ifinfo->if_outgoing != if_received)
+			continue;
+
+		router = rcu_dereference(orig_node_ifinfo->router);
+		break;
+	}
 
 	if (router && !atomic_inc_not_zero(&router->refcount))
 		router = NULL;
@@ -109,6 +123,53 @@ batadv_orig_node_get_router(struct batadv_orig_node *orig_node)
 }
 
 /**
+ * batadv_orig_node_get_ifinfo - gets the ifinfo from an orig_node
+ * @orig_node: the orig node to be queried
+ * @if_received: the interface for which the ifinfo should be acquired
+ * Returns: the requested orig_node_ifinfo or NULL if not found
+ *
+ * Note: this function must be called under rcu lock
+ */
+struct batadv_orig_node_ifinfo *
+batadv_orig_node_get_ifinfo(struct batadv_orig_node *orig_node,
+			    struct batadv_hard_iface *if_received)
+{
+	struct batadv_orig_node_ifinfo *tmp_orig_node_ifinfo,
+				       *orig_node_ifinfo = NULL;
+
+	hlist_for_each_entry_rcu(tmp_orig_node_ifinfo,
+				 &orig_node->ifinfo_list, list) {
+		if (tmp_orig_node_ifinfo->if_outgoing != if_received)
+			continue;
+		orig_node_ifinfo = tmp_orig_node_ifinfo;
+		break;
+	}
+
+	spin_lock_bh(&orig_node->neigh_list_lock);
+	if (!orig_node_ifinfo) {
+		orig_node_ifinfo = kzalloc(sizeof(*orig_node_ifinfo),
+					   GFP_ATOMIC);
+		if (!orig_node_ifinfo)
+			goto out;
+
+		if (if_received &&
+		    !atomic_inc_not_zero(&if_received->refcount)) {
+			kfree(orig_node_ifinfo);
+			orig_node_ifinfo = NULL;
+			goto out;
+		}
+
+		orig_node_ifinfo->if_outgoing = if_received;
+		INIT_HLIST_NODE(&orig_node_ifinfo->list);
+		hlist_add_head_rcu(&orig_node_ifinfo->list,
+				   &orig_node->ifinfo_list);
+	}
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+out:
+	return orig_node_ifinfo;
+}
+
+/**
  * batadv_neigh_node_get_ifinfo - gets the ifinfo from an neigh_node
  * @neigh_node: the neigh node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
@@ -185,11 +246,24 @@ out:
 	return neigh_node;
 }
 
+static void batadv_orig_node_ifinfo_free_rcu(struct rcu_head *rcu)
+{
+	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
+
+	orig_node_ifinfo = container_of(rcu, struct batadv_orig_node_ifinfo,
+					rcu);
+	if (orig_node_ifinfo->if_outgoing)
+		batadv_hardif_free_ref(orig_node_ifinfo->if_outgoing);
+
+	kfree(orig_node_ifinfo);
+}
+
 static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 {
 	struct hlist_node *node_tmp;
 	struct batadv_neigh_node *neigh_node;
 	struct batadv_orig_node *orig_node;
+	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
 
 	orig_node = container_of(rcu, struct batadv_orig_node, rcu);
 
@@ -202,6 +276,12 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 		batadv_neigh_node_free_ref(neigh_node);
 	}
 
+	hlist_for_each_entry_safe(orig_node_ifinfo, node_tmp,
+				  &orig_node->ifinfo_list, list) {
+		hlist_del_rcu(&orig_node_ifinfo->list);
+		call_rcu(&orig_node_ifinfo->rcu,
+			 batadv_orig_node_ifinfo_free_rcu);
+	}
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
 	/* Free nc_nodes */
@@ -295,6 +375,7 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 		return NULL;
 
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
+	INIT_HLIST_HEAD(&orig_node->ifinfo_list);
 	spin_lock_init(&orig_node->ogm_cnt_lock);
 	spin_lock_init(&orig_node->bcast_seqno_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
@@ -309,7 +390,6 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	batadv_dat_init_orig_node_addr(orig_node);
-	orig_node->router = NULL;
 	orig_node->tt_crc = 0;
 	atomic_set(&orig_node->last_ttvn, 0);
 	orig_node->tt_buff = NULL;
@@ -354,6 +434,53 @@ free_orig_node:
 }
 
 /**
+ * batadv_purge_orig_ifinfo - purge ifinfo entries from originator
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: orig node which is to be checked
+ * Returns: true if any ifinfo entry was purged, false otherwise
+ */
+static bool
+batadv_purge_orig_ifinfo(struct batadv_priv *bat_priv,
+			 struct batadv_orig_node *orig_node)
+{
+	struct hlist_node *node_tmp;
+	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
+	bool ifinfo_purged = false;
+	struct batadv_hard_iface *if_outgoing;
+
+	rcu_read_lock();
+	spin_lock_bh(&orig_node->neigh_list_lock);
+
+	/* for all neighbors towards this originator ... */
+	hlist_for_each_entry_safe(orig_node_ifinfo, node_tmp,
+				  &orig_node->ifinfo_list, list) {
+		if_outgoing = orig_node_ifinfo->if_outgoing;
+		if (!if_outgoing)
+			continue;
+
+		if ((if_outgoing->if_status != BATADV_IF_INACTIVE) &&
+		    (if_outgoing->if_status != BATADV_IF_NOT_IN_USE) &&
+		    (if_outgoing->if_status != BATADV_IF_TO_BE_REMOVED))
+			continue;
+
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "router/ifinfo purge: originator %pM, iface: %s\n",
+			   orig_node->orig, if_outgoing->net_dev->name);
+
+		ifinfo_purged = true;
+
+		hlist_del_rcu(&orig_node_ifinfo->list);
+		call_rcu(&orig_node_ifinfo->rcu,
+			 batadv_orig_node_ifinfo_free_rcu);
+	}
+
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+	rcu_read_unlock();
+	return ifinfo_purged;
+}
+
+
+/**
  * batadv_purge_orig_neighbors - purges neighbors from originator
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node which is to be checked
@@ -446,6 +573,8 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 				   struct batadv_orig_node *orig_node)
 {
 	struct batadv_neigh_node *best_neigh_node;
+	struct batadv_hard_iface *hard_iface;
+	bool changed = false;
 
 	if (batadv_has_timed_out(orig_node->last_seen,
 				 2 * BATADV_PURGE_TIMEOUT)) {
@@ -455,11 +584,31 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 			   jiffies_to_msecs(orig_node->last_seen));
 		return true;
 	}
-	if (!batadv_purge_orig_neighbors(bat_priv, orig_node))
+	changed = changed || batadv_purge_orig_ifinfo(bat_priv, orig_node);
+	changed = changed || batadv_purge_orig_neighbors(bat_priv, orig_node);
+
+	if (!changed)
 		return false;
 
+	/* first for NULL ... */
 	best_neigh_node = batadv_find_best_neighbor(orig_node, NULL);
-	batadv_update_route(bat_priv, orig_node, best_neigh_node);
+	batadv_update_route(bat_priv, orig_node, NULL, best_neigh_node);
+
+	/* ... then for all other interfaces. */
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->if_status != BATADV_IF_ACTIVE)
+			continue;
+
+		if (hard_iface->soft_iface != bat_priv->soft_iface)
+			continue;
+
+		best_neigh_node = batadv_find_best_neighbor(orig_node,
+							    hard_iface);
+		batadv_update_route(bat_priv, orig_node, hard_iface,
+				    best_neigh_node);
+	}
+	rcu_read_unlock();
 
 	return false;
 }
@@ -551,7 +700,8 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			neigh_node = batadv_orig_node_get_router(orig_node);
+			neigh_node = batadv_orig_node_get_router(orig_node,
+								 NULL);
 			if (!neigh_node)
 				continue;
 
diff --git a/originator.h b/originator.h
index a53b016..8eb049c 100644
--- a/originator.h
+++ b/originator.h
@@ -34,7 +34,16 @@ batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
 		      const uint8_t *neigh_addr);
 void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node);
 struct batadv_neigh_node *
-batadv_orig_node_get_router(struct batadv_orig_node *orig_node);
+batadv_orig_node_get_router(struct batadv_orig_node *orig_node,
+			    const struct batadv_hard_iface *if_received);
+void
+batadv_orig_node_set_router(struct batadv_orig_node *orig_node,
+			    struct batadv_hard_iface *if_received,
+			    struct batadv_neigh_node *router);
+struct batadv_orig_node_ifinfo *
+batadv_orig_node_get_ifinfo(struct batadv_orig_node *orig_node,
+			    struct batadv_hard_iface *if_received);
+
 struct batadv_neigh_node_ifinfo *
 batadv_neigh_node_get_ifinfo(struct batadv_neigh_node *neigh,
 			     struct batadv_hard_iface *if_outgoing);
diff --git a/routing.c b/routing.c
index 0f08cf8..c1b6d85 100644
--- a/routing.c
+++ b/routing.c
@@ -33,13 +33,35 @@
 static int batadv_route_unicast_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if);
 
+/* _batadv_update_route - set the router for this originator
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: orig node which is to be configured
+ * @recv_if: the receive interface for which this route is set
+ * @neigh_node: neighbor which should be the next router
+ *
+ * This function does not perform any error checks
+ */
 static void _batadv_update_route(struct batadv_priv *bat_priv,
 				 struct batadv_orig_node *orig_node,
+				 struct batadv_hard_iface *recv_if,
 				 struct batadv_neigh_node *neigh_node)
 {
+	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
 	struct batadv_neigh_node *curr_router;
 
-	curr_router = batadv_orig_node_get_router(orig_node);
+	/* use batadv_orig_node_get_ifinfo() instead of
+	 * batadv_orig_node_get_router() to re-use the ifinfo below.
+	 */
+	rcu_read_lock();
+	orig_node_ifinfo = batadv_orig_node_get_ifinfo(orig_node, recv_if);
+	if (orig_node_ifinfo) {
+		curr_router = rcu_dereference(orig_node_ifinfo->router);
+		if (!atomic_inc_not_zero(&curr_router->refcount))
+			curr_router = NULL;
+	} else {
+		rcu_read_unlock();
+		return;
+	}
 
 	/* route deleted */
 	if ((curr_router) && (!neigh_node)) {
@@ -69,16 +91,26 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
 		neigh_node = NULL;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
-	rcu_assign_pointer(orig_node->router, neigh_node);
+	rcu_assign_pointer(orig_node_ifinfo->router, neigh_node);
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
+	rcu_read_unlock();
+
 	/* decrease refcount of previous best neighbor */
 	if (curr_router)
 		batadv_neigh_node_free_ref(curr_router);
 }
 
+/**
+ * batadv_update_route - set the router for this originator
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: orig node which is to be configured
+ * @recv_if: the receive interface for which this route is set
+ * @neigh_node: neighbor which should be the next router
+ */
 void batadv_update_route(struct batadv_priv *bat_priv,
 			 struct batadv_orig_node *orig_node,
+			 struct batadv_hard_iface *recv_if,
 			 struct batadv_neigh_node *neigh_node)
 {
 	struct batadv_neigh_node *router = NULL;
@@ -86,10 +118,10 @@ void batadv_update_route(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	router = batadv_orig_node_get_router(orig_node);
+	router = batadv_orig_node_get_router(orig_node, recv_if);
 
 	if (router != neigh_node)
-		_batadv_update_route(bat_priv, orig_node, neigh_node);
+		_batadv_update_route(bat_priv, orig_node, recv_if, neigh_node);
 
 out:
 	if (router)
@@ -378,7 +410,7 @@ batadv_find_router(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		return NULL;
 
-	router = batadv_orig_node_get_router(orig_node);
+	router = batadv_orig_node_get_router(orig_node, recv_if);
 	if (!router)
 		return NULL;
 
diff --git a/routing.h b/routing.h
index b8fed80..7a7c6e9 100644
--- a/routing.h
+++ b/routing.h
@@ -25,6 +25,7 @@ bool batadv_check_management_packet(struct sk_buff *skb,
 				    int header_len);
 void batadv_update_route(struct batadv_priv *bat_priv,
 			 struct batadv_orig_node *orig_node,
+			 struct batadv_hard_iface *recv_if,
 			 struct batadv_neigh_node *neigh_node);
 int batadv_recv_icmp_packet(struct sk_buff *skb,
 			    struct batadv_hard_iface *recv_if);
diff --git a/translation-table.c b/translation-table.c
index 1e2adfe..c40b734 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -949,7 +949,8 @@ batadv_transtable_best_orig(struct batadv_tt_global_entry *tt_global_entry)
 
 	head = &tt_global_entry->orig_list;
 	hlist_for_each_entry_rcu(orig_entry, head, list) {
-		router = batadv_orig_node_get_router(orig_entry->orig_node);
+		router = batadv_orig_node_get_router(orig_entry->orig_node,
+						     NULL);
 		if (!router)
 			continue;
 
diff --git a/types.h b/types.h
index 2bf7481..7e49f18 100644
--- a/types.h
+++ b/types.h
@@ -85,6 +85,23 @@ struct batadv_hard_iface {
 	struct work_struct cleanup_work;
 };
 
+/* struct batadv_orig_node_ifinfo - originator info per outgoing interface
+ * @list: list node for orig_node::ifinfo_list
+ * @if_outgoing: pointer to outgoing hard interface
+ * @router: router that should be used to reach this originator
+ * @last_real_seqno: last and best known sequence number
+ * @last_ttl: ttl of last received packet
+ * @rcu: struct used for freeing in an RCU-safe manner
+ */
+struct batadv_orig_node_ifinfo {
+	struct hlist_node list;
+	struct batadv_hard_iface *if_outgoing;
+	struct batadv_neigh_node __rcu *router; /* rcu protected pointer */
+	uint32_t last_real_seqno;
+	uint8_t last_ttl;
+	struct rcu_head rcu;
+};
+
 /**
  * struct batadv_frag_table_entry - head in the fragment buffer table
  * @head: head of list with fragments
@@ -117,7 +134,7 @@ struct batadv_frag_list_entry {
  * struct batadv_orig_node - structure for orig_list maintaining nodes of mesh
  * @orig: originator ethernet address
  * @primary_addr: hosts primary interface address
- * @router: router that should be used to reach this originator
+ * @ifinfo_list: list for routers per outgoing interface
  * @batadv_dat_addr_t:  address of the orig node in the distributed hash
  * @bcast_own: bitfield containing the number of our OGMs this orig_node
  *  rebroadcasted "back" to us (relative to last_real_seqno)
@@ -135,8 +152,6 @@ struct batadv_frag_list_entry {
  * @tt_size: number of global TT entries announced by the orig node
  * @tt_initialised: bool keeping track of whether or not this node have received
  *  any translation table information from the orig node yet
- * @last_real_seqno: last and best known sequence number
- * @last_ttl: ttl of last received packet
  * @bcast_bits: bitfield containing the info which payload broadcast originated
  *  from this orig node this host already has seen (relative to
  *  last_bcast_seqno)
@@ -159,7 +174,7 @@ struct batadv_frag_list_entry {
 struct batadv_orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
-	struct batadv_neigh_node __rcu *router; /* rcu protected pointer */
+	struct hlist_head ifinfo_list;
 #ifdef CONFIG_BATMAN_ADV_DAT
 	batadv_dat_addr_t dat_addr;
 #endif
@@ -176,8 +191,6 @@ struct batadv_orig_node {
 	spinlock_t tt_buff_lock; /* protects tt_buff & tt_buff_len */
 	atomic_t tt_size;
 	bool tt_initialised;
-	uint32_t last_real_seqno;
-	uint8_t last_ttl;
 	DECLARE_BITMAP(bcast_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 	uint32_t last_bcast_seqno;
 	struct hlist_head neigh_list;
-- 
1.7.10.4

