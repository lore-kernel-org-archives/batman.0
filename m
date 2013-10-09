Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed,  9 Oct 2013 15:05:34 +0200
Message-Id: <1381323938-26931-4-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/7] batman-adv: split out router from
	orig_node
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
Changes to RFCv2:
 * various style changes
 * remove unneccesary batadv_orig_node_set_router prototype

Changes to RFC:
 * rebase on current master
 * remove useless goto
 * split out batman_seqno_reset as well to avoid false seqno window
   protections
---
 bat_iv_ogm.c            |  399 +++++++++++++++++++++++++++++------------------
 distributed-arp-table.c |    3 +-
 gateway_client.c        |   10 +-
 hard-interface.h        |   18 +++
 icmp_socket.c           |    2 +-
 network-coding.c        |    9 +-
 originator.c            |  175 ++++++++++++++++++++-
 originator.h            |    7 +-
 routing.c               |   42 ++++-
 routing.h               |    1 +
 translation-table.c     |    3 +-
 types.h                 |   29 +++-
 12 files changed, 515 insertions(+), 183 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 2cdcb8b..a7aa7b9 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -918,6 +918,7 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 static void
 batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 			  struct batadv_orig_node *orig_node,
+			  struct batadv_orig_node_ifinfo *orig_node_ifinfo,
 			  const struct ethhdr *ethhdr,
 			  const struct batadv_ogm_packet *batadv_ogm_packet,
 			  struct batadv_hard_iface *if_incoming,
@@ -1005,22 +1006,28 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&neigh_node->ifinfo_lock);
 
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
-	if (router_ifinfo &&
-	    (router_ifinfo->bat_iv.tq_avg > neigh_ifinfo->bat_iv.tq_avg))
-		goto out;
+	if (router) {
+		router_ifinfo = batadv_neigh_node_get_ifinfo(router,
+							     if_outgoing);
+		/* if this neighbor does not offer a better TQ we won't
+		 * consider it
+		 */
+		if (router_ifinfo->bat_iv.tq_avg > neigh_ifinfo->bat_iv.tq_avg)
+			goto out;
+	} else {
+		router_ifinfo = NULL;
+	}
 
 	/* if the TQ is the same and the link not more symmetric we
 	 * won't consider it either
@@ -1043,10 +1050,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 			goto out;
 	}
 
-	/* TODO: pass if_outgoing later */
-	batadv_update_route(bat_priv, orig_node, neigh_node);
-	goto out;
-
+	batadv_update_route(bat_priv, orig_node, if_outgoing, neigh_node);
 out:
 	rcu_read_unlock();
 	if (neigh_node)
@@ -1202,6 +1206,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_orig_node *orig_node;
+	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
 	struct batadv_neigh_node *neigh_node;
 	struct batadv_neigh_node_ifinfo *neigh_ifinfo;
 	int is_dup;
@@ -1218,13 +1223,19 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	if (!orig_node)
 		return BATADV_NO_DUP;
 
+	orig_node_ifinfo = batadv_orig_node_get_ifinfo(orig_node, if_outgoing);
+	if (WARN_ON(!orig_node_ifinfo)) {
+		batadv_orig_node_free_ref(orig_node);
+		return 0;
+	}
+
 	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
-	seq_diff = seqno - orig_node->last_real_seqno;
+	seq_diff = seqno - orig_node_ifinfo->last_real_seqno;
 
 	/* signalize caller that the packet is to be dropped. */
 	if (!hlist_empty(&orig_node->neigh_list) &&
 	    batadv_window_protected(bat_priv, seq_diff,
-				    &orig_node->batman_seqno_reset)) {
+				    &orig_node_ifinfo->batman_seqno_reset)) {
 		ret = BATADV_PROTECTED;
 		goto out;
 	}
@@ -1238,7 +1249,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
 		neigh_addr = neigh_node->addr;
 		is_dup = batadv_test_bit(neigh_ifinfo->bat_iv.real_bits,
-					 orig_node->last_real_seqno,
+					 orig_node_ifinfo->last_real_seqno,
 					 seqno);
 
 		if (batadv_compare_eth(neigh_addr, ethhdr->h_source) &&
@@ -1264,9 +1275,10 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
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
 
@@ -1276,26 +1288,218 @@ out:
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
-	struct batadv_orig_node *orig_neigh_node, *orig_node, *orig_node_tmp;
 	struct batadv_neigh_node *router = NULL, *router_router = NULL;
+	struct batadv_orig_node *orig_neigh_node, *orig_node_tmp;
+	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
 	struct batadv_neigh_node *orig_neigh_router = NULL;
 	struct batadv_neigh_node_ifinfo *router_ifinfo = NULL;
-	int has_directlink_flag;
-	int is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
-	int is_bidirect;
-	bool is_single_hop_neigh = false;
-	bool is_from_best_next_hop = false;
-	int sameseq, similar_ttl;
+	struct batadv_ogm_packet ogm_packet_backup;
+	uint8_t *prev_sender, last_ttl, packet_ttl;
+	uint32_t last_seqno, packet_seqno;
 	enum batadv_dup_status dup_status;
+	bool is_from_best_next_hop = false;
+	bool is_single_hop_neigh = false;
+	int is_bidirect;
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
+	if (router) {
+		orig_node_tmp = orig_node_tmp;
+		router_router = batadv_orig_node_get_router(router->orig_node,
+							    if_outgoing);
+		router_ifinfo = batadv_neigh_node_get_ifinfo(router,
+							     if_outgoing);
+	}
+
+	if ((router_ifinfo && router_ifinfo->bat_iv.tq_avg != 0) &&
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
+		orig_neigh_node = batadv_iv_ogm_orig_get(bat_priv,
+							 ethhdr->h_source);
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
+	last_seqno = orig_node_ifinfo->last_real_seqno;
+	last_ttl = orig_node_ifinfo->last_ttl;
+	packet_seqno = ntohl(batadv_ogm_packet->seqno);
+	packet_ttl = batadv_ogm_packet->header.ttl;
+	if (is_bidirect && ((dup_status == BATADV_NO_DUP) ||
+			    ((last_seqno == packet_seqno) &&
+			     (last_ttl - 3) <= packet_ttl)))
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
+	struct batadv_orig_node *orig_neigh_node, *orig_node;
+	struct batadv_hard_iface *hard_iface;
 	uint32_t if_incoming_seqno;
-	uint8_t *prev_sender;
+	int has_directlink_flag;
+	int is_my_oldorig = 0;
+	int is_my_addr = 0;
+	int is_my_orig = 0;
 
 	/* Silently drop when the batman packet is actually not a
 	 * correct packet.
@@ -1320,9 +1524,6 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	else
 		has_directlink_flag = 0;
 
-	if (batadv_compare_eth(ethhdr->h_source, batadv_ogm_packet->orig))
-		is_single_hop_neigh = true;
-
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Received BATMAN packet via NB: %pM, IF: %s [%pM] (from OG: %pM, via prev OG: %pM, seqno %u, tq %d, TTL %d, V %d, IDF %d)\n",
 		   ethhdr->h_source, if_incoming->net_dev->name,
@@ -1418,129 +1619,24 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
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
-	if (router) {
-		orig_node_tmp = router->orig_node;
-		router_router = batadv_orig_node_get_router(orig_node_tmp);
-	}
-
-	if ((router && router_ifinfo->bat_iv.tq_avg != 0) &&
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
-		orig_neigh_node = batadv_iv_ogm_orig_get(bat_priv,
-							 ethhdr->h_source);
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
@@ -1621,7 +1717,8 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			neigh_node = batadv_orig_node_get_router(orig_node);
+			neigh_node = batadv_orig_node_get_router(orig_node,
+								 NULL);
 			if (!neigh_node)
 				continue;
 
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 6c8c393..411189b 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -591,7 +591,8 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 		if (cand[i].type == BATADV_DAT_CANDIDATE_NOT_FOUND)
 			continue;
 
-		neigh_node = batadv_orig_node_get_router(cand[i].orig_node);
+		neigh_node = batadv_orig_node_get_router(cand[i].orig_node,
+							 NULL);
 		if (!neigh_node)
 			goto free_orig;
 
diff --git a/gateway_client.c b/gateway_client.c
index f616775..99f1115 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -131,7 +131,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 			continue;
 
 		orig_node = gw_node->orig_node;
-		router = batadv_orig_node_get_router(orig_node);
+		router = batadv_orig_node_get_router(orig_node, NULL);
 		if (!router)
 			continue;
 
@@ -244,7 +244,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 	if (next_gw) {
 		sprintf(gw_addr, "%pM", next_gw->orig_node->orig);
 
-		router = batadv_orig_node_get_router(next_gw->orig_node);
+		router = batadv_orig_node_get_router(next_gw->orig_node, NULL);
 		if (!router) {
 			batadv_gw_deselect(bat_priv);
 			goto out;
@@ -312,7 +312,7 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 	if (!curr_gw_orig)
 		goto deselect;
 
-	router_gw = batadv_orig_node_get_router(curr_gw_orig);
+	router_gw = batadv_orig_node_get_router(curr_gw_orig, NULL);
 	if (!router_gw)
 		goto deselect;
 
@@ -324,7 +324,7 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 	if (curr_gw_orig == orig_node)
 		goto out;
 
-	router_orig = batadv_orig_node_get_router(orig_node);
+	router_orig = batadv_orig_node_get_router(orig_node, NULL);
 	if (!router_orig)
 		goto out;
 
@@ -552,7 +552,7 @@ static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
 	int ret = -1;
 
 	rcu_read_lock();
-	router = batadv_orig_node_get_router(gw_node->orig_node);
+	router = batadv_orig_node_get_router(gw_node->orig_node, NULL);
 	if (!router)
 		goto out;
 
diff --git a/hard-interface.h b/hard-interface.h
index 4989288..26e51ac 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -53,6 +53,11 @@ void batadv_update_min_mtu(struct net_device *soft_iface);
 void batadv_hardif_free_rcu(struct rcu_head *rcu);
 bool batadv_is_wifi_iface(int ifindex);
 
+/**
+ * batadv_hardif_free_ref - decrement the hard interface refcounter and
+ *  possibly free it
+ * @hard_iface: the hard interface to free
+ */
 static inline void
 batadv_hardif_free_ref(struct batadv_hard_iface *hard_iface)
 {
@@ -60,6 +65,19 @@ batadv_hardif_free_ref(struct batadv_hard_iface *hard_iface)
 		call_rcu(&hard_iface->rcu, batadv_hardif_free_rcu);
 }
 
+/**
+ * batadv_hardif_free_ref_now - decrement the hard interface refcounter and
+ *  possibly free it (without rcu callback)
+ * @hard_iface: the hard interface to free
+ */
+static inline void
+batadv_hardif_free_ref_now(struct batadv_hard_iface *hard_iface)
+{
+	if (atomic_dec_and_test(&hard_iface->refcount))
+		batadv_hardif_free_rcu(&hard_iface->rcu);
+}
+
+
 static inline struct batadv_hard_iface *
 batadv_primary_if_get_selected(struct batadv_priv *bat_priv)
 {
diff --git a/icmp_socket.c b/icmp_socket.c
index 82ac647..efb51f6 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -223,7 +223,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 	if (!orig_node)
 		goto dst_unreach;
 
-	neigh_node = batadv_orig_node_get_router(orig_node);
+	neigh_node = batadv_orig_node_get_router(orig_node, NULL);
 	if (!neigh_node)
 		goto dst_unreach;
 
diff --git a/network-coding.c b/network-coding.c
index 351e199..8ef1cc3 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -1019,12 +1019,17 @@ static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
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
index 8508d1b..62bab34 100644
--- a/originator.c
+++ b/originator.c
@@ -174,14 +174,29 @@ void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node)
 		call_rcu(&neigh_node->rcu, batadv_neigh_node_free_rcu);
 }
 
-/* increases the refcounter of a found router */
+/**
+ * batadv_orig_node_get_router - router to the originator depending on iface
+ * @orig_node: the orig node for the router
+ * @if_received: the interface where the packet to be transmitted was received
+ *
+ * Returns the neighbor which should be router for this orig_node/iface.
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
@@ -191,6 +206,55 @@ batadv_orig_node_get_router(struct batadv_orig_node *orig_node)
 }
 
 /**
+ * batadv_orig_node_get_ifinfo - gets the ifinfo from an orig_node
+ * @orig_node: the orig node to be queried
+ * @if_received: the interface for which the ifinfo should be acquired
+ *
+ * Returns the requested orig_node_ifinfo or NULL if not found.
+ *
+ * Note: this function must be called under rcu lock
+ */
+struct batadv_orig_node_ifinfo *
+batadv_orig_node_get_ifinfo(struct batadv_orig_node *orig_node,
+			    struct batadv_hard_iface *if_received)
+{
+	struct batadv_orig_node_ifinfo *tmp, *orig_ifinfo = NULL;
+	unsigned long reset_time;
+
+	hlist_for_each_entry_rcu(tmp, &orig_node->ifinfo_list,
+				 list) {
+		if (tmp->if_outgoing != if_received)
+			continue;
+		orig_ifinfo = tmp;
+		break;
+	}
+
+	spin_lock_bh(&orig_node->neigh_list_lock);
+	if (!orig_ifinfo) {
+		orig_ifinfo = kzalloc(sizeof(*orig_ifinfo), GFP_ATOMIC);
+		if (!orig_ifinfo)
+			goto out;
+
+		if (if_received &&
+		    !atomic_inc_not_zero(&if_received->refcount)) {
+			kfree(orig_ifinfo);
+			orig_ifinfo = NULL;
+			goto out;
+		}
+		reset_time = jiffies - 1;
+		reset_time -= msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
+		orig_ifinfo->batman_seqno_reset = reset_time;
+		orig_ifinfo->if_outgoing = if_received;
+		INIT_HLIST_NODE(&orig_ifinfo->list);
+		hlist_add_head_rcu(&orig_ifinfo->list,
+				   &orig_node->ifinfo_list);
+	}
+out:
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+	return orig_ifinfo;
+}
+
+/**
  * batadv_neigh_node_get_ifinfo - gets the ifinfo from an neigh_node
  * @neigh_node: the neigh node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
@@ -275,11 +339,29 @@ out:
 	return neigh_node;
 }
 
+static void batadv_orig_node_ifinfo_free_rcu(struct rcu_head *rcu)
+{
+	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
+
+	orig_node_ifinfo = container_of(rcu, struct batadv_orig_node_ifinfo,
+					rcu);
+
+	/* We are in an rcu callback here, therefore we cannot use
+	 * batadv_hardif_free_ref() and its call_rcu():
+	 * An rcu_barrier() wouldn't wait for that to finish
+	 */
+	if (orig_node_ifinfo->if_outgoing)
+		batadv_hardif_free_ref_now(orig_node_ifinfo->if_outgoing);
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
 
@@ -292,6 +374,14 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 		batadv_neigh_node_free_ref(neigh_node);
 	}
 
+	hlist_for_each_entry_safe(orig_node_ifinfo, node_tmp,
+				  &orig_node->ifinfo_list, list) {
+		hlist_del_rcu(&orig_node_ifinfo->list);
+		/* Can't use call_rcu here as this is already inside of
+		 * an rcu_callback.
+		 */
+		batadv_orig_node_ifinfo_free_rcu(&orig_node_ifinfo->rcu);
+	}
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 
 	/* Free nc_nodes */
@@ -389,6 +479,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
 	INIT_LIST_HEAD(&orig_node->vlan_list);
+	INIT_HLIST_HEAD(&orig_node->ifinfo_list);
 	spin_lock_init(&orig_node->bcast_seqno_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
 	spin_lock_init(&orig_node->tt_buff_lock);
@@ -404,13 +495,11 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	orig_node->bat_priv = bat_priv;
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	batadv_dat_init_orig_node_addr(orig_node);
-	orig_node->router = NULL;
 	atomic_set(&orig_node->last_ttvn, 0);
 	orig_node->tt_buff = NULL;
 	orig_node->tt_buff_len = 0;
 	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
 	orig_node->bcast_seqno_reset = reset_time;
-	orig_node->batman_seqno_reset = reset_time;
 
 	/* create a vlan object for the "untagged" LAN */
 	vlan = batadv_orig_node_vlan_new(orig_node, BATADV_NO_FLAGS);
@@ -435,6 +524,53 @@ free_orig_node:
 }
 
 /**
+ * batadv_purge_orig_ifinfo - purge ifinfo entries from originator
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: orig node which is to be checked
+ *
+ * Returns true if any ifinfo entry was purged, false otherwise.
+ */
+static bool
+batadv_purge_orig_ifinfo(struct batadv_priv *bat_priv,
+			 struct batadv_orig_node *orig_node)
+{
+	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
+	struct batadv_hard_iface *if_outgoing;
+	struct hlist_node *node_tmp;
+	bool ifinfo_purged = false;
+
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
+
+	return ifinfo_purged;
+}
+
+
+/**
  * batadv_purge_orig_neighbors - purges neighbors from originator
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: orig node which is to be checked
@@ -518,6 +654,8 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 				   struct batadv_orig_node *orig_node)
 {
 	struct batadv_neigh_node *best_neigh_node;
+	struct batadv_hard_iface *hard_iface;
+	bool changed;
 
 	if (batadv_has_timed_out(orig_node->last_seen,
 				 2 * BATADV_PURGE_TIMEOUT)) {
@@ -527,11 +665,32 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 			   jiffies_to_msecs(orig_node->last_seen));
 		return true;
 	}
-	if (!batadv_purge_orig_neighbors(bat_priv, orig_node))
+	changed = batadv_purge_orig_ifinfo(bat_priv, orig_node);
+	changed = changed || batadv_purge_orig_neighbors(bat_priv, orig_node);
+
+	if (!changed)
 		return false;
 
+	/* first for NULL ... */
 	best_neigh_node = batadv_find_best_neighbor(bat_priv, orig_node, NULL);
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
+		best_neigh_node = batadv_find_best_neighbor(bat_priv,
+							    orig_node,
+							    hard_iface);
+		batadv_update_route(bat_priv, orig_node, hard_iface,
+				    best_neigh_node);
+	}
+	rcu_read_unlock();
 
 	return false;
 }
diff --git a/originator.h b/originator.h
index 161c1e3..ef2500a 100644
--- a/originator.h
+++ b/originator.h
@@ -36,7 +36,12 @@ batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
 		      struct batadv_orig_node *orig_node);
 void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node);
 struct batadv_neigh_node *
-batadv_orig_node_get_router(struct batadv_orig_node *orig_node);
+batadv_orig_node_get_router(struct batadv_orig_node *orig_node,
+			    const struct batadv_hard_iface *if_received);
+struct batadv_orig_node_ifinfo *
+batadv_orig_node_get_ifinfo(struct batadv_orig_node *orig_node,
+			    struct batadv_hard_iface *if_received);
+
 struct batadv_neigh_node_ifinfo *
 batadv_neigh_node_get_ifinfo(struct batadv_neigh_node *neigh,
 			     struct batadv_hard_iface *if_outgoing);
diff --git a/routing.c b/routing.c
index 733ebbf..304e44b 100644
--- a/routing.c
+++ b/routing.c
@@ -35,13 +35,35 @@
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
+		if (curr_router && !atomic_inc_not_zero(&curr_router->refcount))
+			curr_router = NULL;
+	} else {
+		rcu_read_unlock();
+		return;
+	}
 
 	/* route deleted */
 	if ((curr_router) && (!neigh_node)) {
@@ -71,16 +93,26 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
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
@@ -88,10 +120,10 @@ void batadv_update_route(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	router = batadv_orig_node_get_router(orig_node);
+	router = batadv_orig_node_get_router(orig_node, recv_if);
 
 	if (router != neigh_node)
-		_batadv_update_route(bat_priv, orig_node, neigh_node);
+		_batadv_update_route(bat_priv, orig_node, recv_if, neigh_node);
 
 out:
 	if (router)
@@ -382,7 +414,7 @@ batadv_find_router(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		return NULL;
 
-	router = batadv_orig_node_get_router(orig_node);
+	router = batadv_orig_node_get_router(orig_node, recv_if);
 
 	/* TODO: fill this later with new bonding mechanism */
 
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
index ea4215b..8c0d244 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1356,7 +1356,8 @@ batadv_transtable_best_orig(struct batadv_priv *bat_priv,
 
 	head = &tt_global_entry->orig_list;
 	hlist_for_each_entry_rcu(orig_entry, head, list) {
-		router = batadv_orig_node_get_router(orig_entry->orig_node);
+		router = batadv_orig_node_get_router(orig_entry->orig_node,
+						     NULL);
 		if (!router)
 			continue;
 
diff --git a/types.h b/types.h
index 0973473..860d6a4 100644
--- a/types.h
+++ b/types.h
@@ -78,6 +78,25 @@ struct batadv_hard_iface {
 	struct work_struct cleanup_work;
 };
 
+/* struct batadv_orig_node_ifinfo - originator info per outgoing interface
+ * @list: list node for orig_node::ifinfo_list
+ * @if_outgoing: pointer to outgoing hard interface
+ * @router: router that should be used to reach this originator
+ * @last_real_seqno: last and best known sequence number
+ * @last_ttl: ttl of last received packet
+ * @batman_seqno_reset: time when the batman seqno window was reset
+ * @rcu: struct used for freeing in an RCU-safe manner
+ */
+struct batadv_orig_node_ifinfo {
+	struct hlist_node list;
+	struct batadv_hard_iface *if_outgoing;
+	struct batadv_neigh_node __rcu *router; /* rcu protected pointer */
+	uint32_t last_real_seqno;
+	uint8_t last_ttl;
+	unsigned long batman_seqno_reset;
+	struct rcu_head rcu;
+};
+
 /**
  * struct batadv_frag_table_entry - head in the fragment buffer table
  * @head: head of list with fragments
@@ -153,11 +172,10 @@ struct batadv_orig_bat_iv {
  * struct batadv_orig_node - structure for orig_list maintaining nodes of mesh
  * @orig: originator ethernet address
  * @primary_addr: hosts primary interface address
- * @router: router that should be used to reach this originator
+ * @ifinfo_list: list for routers per outgoing interface
  * @batadv_dat_addr_t:  address of the orig node in the distributed hash
  * @last_seen: time when last packet from this node was received
  * @bcast_seqno_reset: time when the broadcast seqno window was reset
- * @batman_seqno_reset: time when the batman seqno window was reset
  * @capabilities: announced capabilities of this originator
  * @last_ttvn: last seen translation table version number
  * @tt_buff: last tt changeset this node received from the orig node
@@ -170,8 +188,6 @@ struct batadv_orig_bat_iv {
  *  made up by two operations (data structure update and metdata -CRC/TTVN-
  *  recalculation) and they have to be executed atomically in order to avoid
  *  another thread to read the table/metadata between those.
- * @last_real_seqno: last and best known sequence number
- * @last_ttl: ttl of last received packet
  * @bcast_bits: bitfield containing the info which payload broadcast originated
  *  from this orig node this host already has seen (relative to
  *  last_bcast_seqno)
@@ -196,13 +212,12 @@ struct batadv_orig_bat_iv {
 struct batadv_orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
-	struct batadv_neigh_node __rcu *router; /* rcu protected pointer */
+	struct hlist_head ifinfo_list;
 #ifdef CONFIG_BATMAN_ADV_DAT
 	batadv_dat_addr_t dat_addr;
 #endif
 	unsigned long last_seen;
 	unsigned long bcast_seqno_reset;
-	unsigned long batman_seqno_reset;
 	uint8_t capabilities;
 	atomic_t last_ttvn;
 	unsigned char *tt_buff;
@@ -211,8 +226,6 @@ struct batadv_orig_node {
 	bool tt_initialised;
 	/* prevents from changing the table while reading it */
 	spinlock_t tt_lock;
-	uint32_t last_real_seqno;
-	uint8_t last_ttl;
 	DECLARE_BITMAP(bcast_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 	uint32_t last_bcast_seqno;
 	struct hlist_head neigh_list;
-- 
1.7.10.4

