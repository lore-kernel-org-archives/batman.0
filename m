Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 23 May 2013 23:21:08 +0200
Message-Id: <1369344072-23916-4-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1369344072-23916-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1369344072-23916-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFC 3/7] batman-adv: split tq information in
	neigh_node struct
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

For the network wide multi interface optimization it is required to save
metrics per outgoing interface in one neighbor. Therefore a new type is
introduced to keep interface-specific information. This also requires
some changes in access and list management.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 bat_iv_ogm.c        |  133 +++++++++++++++++++++++++++++++++------------
 gateway_client.c    |   68 +++++++++++++++++++----
 originator.c        |  149 +++++++++++++++++++++++++++++++++++++++++++++------
 originator.h        |    3 ++
 translation-table.c |   11 +++-
 types.h             |   35 ++++++++----
 6 files changed, 325 insertions(+), 74 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index a340f9a..e98386c 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -70,6 +70,7 @@ static uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[])
 
 	return (uint8_t)(sum / count);
 }
+
 static struct batadv_neigh_node *
 batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 			const uint8_t *neigh_addr,
@@ -82,6 +83,11 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 	if (!neigh_node)
 		goto out;
 
+	if (!atomic_inc_not_zero(&hard_iface->refcount)) {
+		kfree(neigh_node);
+		goto out;
+	}
+
 	neigh_node->orig_node = orig_neigh;
 	neigh_node->if_incoming = hard_iface;
 
@@ -714,22 +720,39 @@ enum batadv_dup_status {
 	BATADV_PROTECTED,
 };
 
+/**
+ * batadv_iv_ogm_orig_update - use OGM to update corresponding data in an
+ *  originator
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: the orig node who originally emitted the ogm packet
+ * @orig_node_ifinfo: ifinfo for the according outgoing interface
+ * @ethhdr: Ethernet header of the OGM
+ * @@batadv_ogm_packet: the ogm packet
+ * @if_incoming: interface where the packet was received
+ * @if_outgoing: interface for which the retransmission should be considered
+ * @tt_buff: pointer to the tt buffer
+ * @dup_status: the duplicate status of this ogm packet.
+ */
 static void
 batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 			  struct batadv_orig_node *orig_node,
 			  const struct ethhdr *ethhdr,
 			  const struct batadv_ogm_packet *batadv_ogm_packet,
 			  struct batadv_hard_iface *if_incoming,
+			  struct batadv_hard_iface *if_outgoing,
 			  const unsigned char *tt_buff,
 			  enum batadv_dup_status dup_status)
 {
 	struct batadv_neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	struct batadv_neigh_node *router = NULL;
 	struct batadv_orig_node *orig_node_tmp;
+	struct batadv_neigh_node_ifinfo *neigh_ifinfo = NULL,
+					*tmp_neigh_ifinfo,
+					*router_ifinfo;
 	int if_num;
 	uint8_t sum_orig, sum_neigh;
 	uint8_t *neigh_addr;
-	uint8_t tq_avg;
+	uint8_t tq_avg, *tq_recv;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "update_originator(): Searching and updating originator entry of received packet\n");
@@ -751,10 +774,19 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 			continue;
 
 		spin_lock_bh(&tmp_neigh_node->lq_update_lock);
-		batadv_ring_buffer_set(tmp_neigh_node->tq_recv,
-				       &tmp_neigh_node->tq_index, 0);
-		tq_avg = batadv_ring_buffer_avg(tmp_neigh_node->tq_recv);
-		tmp_neigh_node->tq_avg = tq_avg;
+		/* only update the entry for this outgoing interface */
+		hlist_for_each_entry_rcu(tmp_neigh_ifinfo,
+					 &tmp_neigh_node->ifinfo_list,
+					 list) {
+			if (tmp_neigh_ifinfo->if_outgoing != if_outgoing)
+				continue;
+
+			tq_recv = tmp_neigh_ifinfo->tq_recv;
+			batadv_ring_buffer_set(tq_recv,
+					       &tmp_neigh_ifinfo->tq_index, 0);
+			tq_avg = batadv_ring_buffer_avg(tq_recv);
+			tmp_neigh_ifinfo->tq_avg = tq_avg;
+		}
 		spin_unlock_bh(&tmp_neigh_node->lq_update_lock);
 	}
 
@@ -763,7 +795,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 
 		orig_tmp = batadv_get_orig_node(bat_priv, ethhdr->h_source);
 		if (!orig_tmp)
-			goto unlock;
+			goto out;
 
 		neigh_node = batadv_iv_ogm_neigh_new(if_incoming,
 						     ethhdr->h_source,
@@ -771,25 +803,28 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 
 		batadv_orig_node_free_ref(orig_tmp);
 		if (!neigh_node)
-			goto unlock;
+			goto out;
 	} else
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Updating existing last-hop neighbor of originator\n");
 
-	rcu_read_unlock();
+	neigh_ifinfo = batadv_neigh_node_get_ifinfo(neigh_node,
+						    if_outgoing);
+	if (!neigh_ifinfo)
+		goto out;
 
 	neigh_node->last_seen = jiffies;
 
 	spin_lock_bh(&neigh_node->lq_update_lock);
-	batadv_ring_buffer_set(neigh_node->tq_recv,
-			       &neigh_node->tq_index,
+	batadv_ring_buffer_set(neigh_ifinfo->tq_recv,
+			       &neigh_ifinfo->tq_index,
 			       batadv_ogm_packet->tq);
-	neigh_node->tq_avg = batadv_ring_buffer_avg(neigh_node->tq_recv);
+	neigh_ifinfo->tq_avg = batadv_ring_buffer_avg(neigh_ifinfo->tq_recv);
 	spin_unlock_bh(&neigh_node->lq_update_lock);
 
 	if (dup_status == BATADV_NO_DUP) {
 		orig_node->last_ttl = batadv_ogm_packet->header.ttl;
-		neigh_node->last_ttl = batadv_ogm_packet->header.ttl;
+		neigh_ifinfo->last_ttl = batadv_ogm_packet->header.ttl;
 	}
 
 	/* if this neighbor already is our next hop there is nothing
@@ -799,14 +834,15 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	if (router == neigh_node)
 		goto out;
 
+	router_ifinfo = batadv_neigh_node_get_ifinfo(router, if_outgoing);
 	/* if this neighbor does not offer a better TQ we won't consider it */
-	if (router && (router->tq_avg > neigh_node->tq_avg))
+	if (router_ifinfo && (router_ifinfo->tq_avg > neigh_ifinfo->tq_avg))
 		goto out;
 
 	/* if the TQ is the same and the link not more symmetric we
 	 * won't consider it either
 	 */
-	if (router && (neigh_node->tq_avg == router->tq_avg)) {
+	if (router_ifinfo && (neigh_ifinfo->tq_avg == router_ifinfo->tq_avg)) {
 		orig_node_tmp = router->orig_node;
 		spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
 		if_num = router->if_incoming->if_num;
@@ -823,25 +859,37 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 			goto out;
 	}
 
+	/* TODO: pass if_outgoing later */
 	batadv_update_route(bat_priv, orig_node, neigh_node);
 	goto out;
 
-unlock:
-	rcu_read_unlock();
 out:
+	rcu_read_unlock();
 	if (neigh_node)
 		batadv_neigh_node_free_ref(neigh_node);
 	if (router)
 		batadv_neigh_node_free_ref(router);
 }
 
+/**
+ * batadv_iv_ogm_calc_tq - calculate tq for current received ogm packet
+ * @orig_node: the orig node who originally emitted the ogm packet
+ * @orig_neigh_node: the orig node struct of the neighbor who sent the packet
+ * @batadv_ogm_packet: the ogm packet
+ * @if_incoming: interface where the packet was received
+ * @if_outgoing: interface for which the retransmission should be considered
+ *
+ * Returns 1 if the link can be considered bidirectional, 0 otherwise
+ */
 static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 				 struct batadv_orig_node *orig_neigh_node,
 				 struct batadv_ogm_packet *batadv_ogm_packet,
-				 struct batadv_hard_iface *if_incoming)
+				 struct batadv_hard_iface *if_incoming,
+				 struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_neigh_node *neigh_node = NULL, *tmp_neigh_node;
+	struct batadv_neigh_node_ifinfo *neigh_node_ifinfo;
 	uint8_t total_count;
 	uint8_t orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
 	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
@@ -885,7 +933,14 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	/* find packet count of corresponding one hop neighbor */
 	spin_lock_bh(&orig_node->ogm_cnt_lock);
 	orig_eq_count = orig_neigh_node->bcast_own_sum[if_incoming->if_num];
-	neigh_rq_count = neigh_node->real_packet_count;
+	rcu_read_lock();
+	neigh_node_ifinfo = batadv_neigh_node_get_ifinfo(neigh_node,
+							 if_outgoing);
+	if (!neigh_node_ifinfo)
+		neigh_rq_count = 0;
+	else
+		neigh_rq_count = neigh_node_ifinfo->real_packet_count;
+	rcu_read_unlock();
 	spin_unlock_bh(&orig_node->ogm_cnt_lock);
 
 	/* pay attention to not get a value bigger than 100 % */
@@ -949,17 +1004,20 @@ out:
  * @ethhdr: Ethernet header of the packet
  * @batadv_ogm_packet: OGM packet to be considered
  * @if_incoming: interface where the OGM packet was received
- * Returns: duplicate status as enum batadv_dup_status
- * returns:
+ * @if_outgoing: interface for which the retransmission should be considered
+ *
+ * Returns duplicate status as enum batadv_dup_status
   */
 enum batadv_dup_status
 batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 			    const struct batadv_ogm_packet *batadv_ogm_packet,
-			    const struct batadv_hard_iface *if_incoming)
+			    const struct batadv_hard_iface *if_incoming,
+			    struct batadv_hard_iface *if_outgoing)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_orig_node *orig_node;
-	struct batadv_neigh_node *tmp_neigh_node;
+	struct batadv_neigh_node *neigh_node;
+	struct batadv_neigh_node_ifinfo *neigh_ifinfo;
 	int is_dup;
 	int32_t seq_diff;
 	int need_update = 0;
@@ -985,15 +1043,20 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	}
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(tmp_neigh_node,
+	hlist_for_each_entry_rcu(neigh_node,
 				 &orig_node->neigh_list, list) {
-		neigh_addr = tmp_neigh_node->addr;
-		is_dup = batadv_test_bit(tmp_neigh_node->real_bits,
+		neigh_ifinfo = batadv_neigh_node_get_ifinfo(neigh_node,
+							    if_outgoing);
+		if (WARN_ON(!neigh_ifinfo))
+			continue;
+
+		neigh_addr = neigh_node->addr;
+		is_dup = batadv_test_bit(neigh_ifinfo->real_bits,
 					 orig_node->last_real_seqno,
 					 seqno);
 
 		if (batadv_compare_eth(neigh_addr, ethhdr->h_source) &&
-		    tmp_neigh_node->if_incoming == if_incoming) {
+		    neigh_node->if_incoming == if_incoming) {
 			set_mark = 1;
 			if (is_dup)
 				ret = BATADV_NEIGH_DUP;
@@ -1005,14 +1068,13 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
 		/* if the window moved, set the update flag. */
 		need_update |= batadv_bit_get_packet(bat_priv,
-						     tmp_neigh_node->real_bits,
+						     neigh_ifinfo->real_bits,
 						     seq_diff, set_mark);
 
-		packet_count = bitmap_weight(tmp_neigh_node->real_bits,
+		packet_count = bitmap_weight(neigh_ifinfo->real_bits,
 					     BATADV_TQ_LOCAL_WINDOW_SIZE);
-		tmp_neigh_node->real_packet_count = packet_count;
+		neigh_ifinfo->real_packet_count = packet_count;
 	}
-	rcu_read_unlock();
 
 	if (need_update) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
@@ -1020,6 +1082,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 			   orig_node->last_real_seqno, seqno);
 		orig_node->last_real_seqno = seqno;
 	}
+	rcu_read_unlock();
 
 out:
 	spin_unlock_bh(&orig_node->ogm_cnt_lock);
@@ -1037,6 +1100,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	struct batadv_orig_node *orig_neigh_node, *orig_node;
 	struct batadv_neigh_node *router = NULL, *router_router = NULL;
 	struct batadv_neigh_node *orig_neigh_router = NULL;
+	struct batadv_neigh_node_ifinfo *router_ifinfo = NULL;
 	int has_directlink_flag;
 	int is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
 	int is_bidirect;
@@ -1169,7 +1233,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		return;
 
 	dup_status = batadv_iv_ogm_update_seqnos(ethhdr, batadv_ogm_packet,
-						 if_incoming);
+						 if_incoming, NULL);
 
 	if (dup_status == BATADV_PROTECTED) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
@@ -1188,7 +1252,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	if (router)
 		router_router = batadv_orig_node_get_router(router->orig_node);
 
-	if ((router && router->tq_avg != 0) &&
+	if ((router && router_ifinfo->tq_avg != 0) &&
 	    (batadv_compare_eth(router->addr, ethhdr->h_source)))
 		is_from_best_next_hop = true;
 
@@ -1234,7 +1298,8 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	}
 
 	is_bidirect = batadv_iv_ogm_calc_tq(orig_node, orig_neigh_node,
-					    batadv_ogm_packet, if_incoming);
+					    batadv_ogm_packet, if_incoming,
+					    NULL);
 
 	/* update ranking if it is not a duplicate or has the same
 	 * seqno and similar ttl as the non-duplicate
@@ -1245,7 +1310,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 			    (sameseq && similar_ttl)))
 		batadv_iv_ogm_orig_update(bat_priv, orig_node, ethhdr,
 					  batadv_ogm_packet, if_incoming,
-					  tt_buff, dup_status);
+					  NULL, tt_buff, dup_status);
 
 	/* is single hop (direct) neighbor */
 	if (is_single_hop_neigh) {
diff --git a/gateway_client.c b/gateway_client.c
index 3a27408..c134321 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -114,6 +114,7 @@ static struct batadv_gw_node *
 batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 {
 	struct batadv_neigh_node *router;
+	struct batadv_neigh_node_ifinfo *router_ifinfo;
 	struct batadv_gw_node *gw_node, *curr_gw = NULL;
 	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
 	uint32_t gw_divisor;
@@ -134,10 +135,14 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 		if (!router)
 			continue;
 
+		router_ifinfo = batadv_neigh_node_get_ifinfo(router, NULL);
+		if (!router_ifinfo)
+			goto next;
+
 		if (!atomic_inc_not_zero(&gw_node->refcount))
 			goto next;
 
-		tq_avg = router->tq_avg;
+		tq_avg = router_ifinfo->tq_avg;
 
 		switch (atomic_read(&bat_priv->gw_sel_class)) {
 		case 1: /* fast connection */
@@ -192,6 +197,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 {
 	struct batadv_gw_node *curr_gw = NULL, *next_gw = NULL;
 	struct batadv_neigh_node *router = NULL;
+	struct batadv_neigh_node_ifinfo *router_ifinfo = NULL;
 	char gw_addr[18] = { '\0' };
 
 	/* The batman daemon checks here if we already passed a full originator
@@ -199,6 +205,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 	 * hear about. This check is based on the daemon's uptime which we
 	 * don't have.
 	 */
+	rcu_read_lock();
 	if (atomic_read(&bat_priv->gw_mode) != BATADV_GW_MODE_CLIENT)
 		goto out;
 
@@ -220,6 +227,12 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 			batadv_gw_deselect(bat_priv);
 			goto out;
 		}
+
+		router_ifinfo = batadv_neigh_node_get_ifinfo(router, NULL);
+		if (!router_ifinfo) {
+			batadv_gw_deselect(bat_priv);
+			goto out;
+		}
 	}
 
 	if ((curr_gw) && (!next_gw)) {
@@ -234,7 +247,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 			   next_gw->bandwidth_down / 10,
 			   next_gw->bandwidth_down % 10,
 			   next_gw->bandwidth_up / 10,
-			   next_gw->bandwidth_up % 10, router->tq_avg);
+			   next_gw->bandwidth_up % 10, router_ifinfo->tq_avg);
 		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_ADD,
 				    gw_addr);
 	} else {
@@ -244,7 +257,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 			   next_gw->bandwidth_down / 10,
 			   next_gw->bandwidth_down % 10,
 			   next_gw->bandwidth_up / 10,
-			   next_gw->bandwidth_up % 10, router->tq_avg);
+			   next_gw->bandwidth_up % 10, router_ifinfo->tq_avg);
 		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_CHANGE,
 				    gw_addr);
 	}
@@ -252,6 +265,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 	batadv_gw_select(bat_priv, next_gw);
 
 out:
+	rcu_read_unlock();
 	if (curr_gw)
 		batadv_gw_node_free_ref(curr_gw);
 	if (next_gw)
@@ -265,8 +279,11 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 {
 	struct batadv_orig_node *curr_gw_orig;
 	struct batadv_neigh_node *router_gw = NULL, *router_orig = NULL;
+	struct batadv_neigh_node_ifinfo *router_gw_tq = NULL,
+					*router_orig_tq = NULL;
 	uint8_t gw_tq_avg, orig_tq_avg;
 
+	rcu_read_lock();
 	curr_gw_orig = batadv_gw_get_selected_orig(bat_priv);
 	if (!curr_gw_orig)
 		goto deselect;
@@ -275,6 +292,10 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 	if (!router_gw)
 		goto deselect;
 
+	router_gw_tq = batadv_neigh_node_get_ifinfo(router_gw, NULL);
+	if (!router_gw_tq)
+		goto deselect;
+
 	/* this node already is the gateway */
 	if (curr_gw_orig == orig_node)
 		goto out;
@@ -283,8 +304,15 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 	if (!router_orig)
 		goto out;
 
-	gw_tq_avg = router_gw->tq_avg;
-	orig_tq_avg = router_orig->tq_avg;
+	router_orig_tq = batadv_neigh_node_get_ifinfo(router_orig, NULL);
+	if (!router_orig_tq) {
+		batadv_gw_deselect(bat_priv);
+		goto out;
+	}
+
+
+	gw_tq_avg = router_gw_tq->tq_avg;
+	orig_tq_avg = router_orig_tq->tq_avg;
 
 	/* the TQ value has to be better */
 	if (orig_tq_avg < gw_tq_avg)
@@ -302,6 +330,7 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 		   gw_tq_avg, orig_tq_avg);
 
 deselect:
+	rcu_read_unlock();
 	batadv_gw_deselect(bat_priv);
 out:
 	if (curr_gw_orig)
@@ -495,18 +524,24 @@ static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
 {
 	struct batadv_gw_node *curr_gw;
 	struct batadv_neigh_node *router;
+	struct batadv_neigh_node_ifinfo *router_ifinfo;
 	int ret = -1;
 
+	rcu_read_lock();
 	router = batadv_orig_node_get_router(gw_node->orig_node);
 	if (!router)
 		goto out;
 
+	router_ifinfo = batadv_neigh_node_get_ifinfo(router, NULL);
+	if  (!router_ifinfo)
+		goto out;
+
 	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
 
 	ret = seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %u.%u/%u.%u MBit\n",
 			 (curr_gw == gw_node ? "=>" : "  "),
 			 gw_node->orig_node->orig,
-			 router->tq_avg, router->addr,
+			 router_ifinfo->tq_avg, router->addr,
 			 router->if_incoming->net_dev->name,
 			 gw_node->bandwidth_down / 10,
 			 gw_node->bandwidth_down % 10,
@@ -517,6 +552,7 @@ static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
 	if (curr_gw)
 		batadv_gw_node_free_ref(curr_gw);
 out:
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -697,10 +733,12 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *neigh_curr = NULL, *neigh_old = NULL;
 	struct batadv_orig_node *orig_dst_node = NULL;
 	struct batadv_gw_node *gw_node = NULL, *curr_gw = NULL;
+	struct batadv_neigh_node_ifinfo *neigh_curr_ifinfo, *neigh_old_ifinfo;
 	bool ret, out_of_range = false;
 	unsigned int header_len = 0;
-	uint8_t curr_tq_avg;
+	uint8_t curr_if_avg;
 
+	rcu_read_lock();
 	ret = batadv_gw_is_dhcp_target(skb, &header_len);
 	if (!ret)
 		goto out;
@@ -723,7 +761,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 		/* If we are a GW then we are our best GW. We can artificially
 		 * set the tq towards ourself as the maximum value
 		 */
-		curr_tq_avg = BATADV_TQ_MAX_VALUE;
+		curr_if_avg = BATADV_TQ_MAX_VALUE;
 		break;
 	case BATADV_GW_MODE_CLIENT:
 		curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
@@ -743,7 +781,12 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 		if (!neigh_curr)
 			goto out;
 
-		curr_tq_avg = neigh_curr->tq_avg;
+		neigh_curr_ifinfo = batadv_neigh_node_get_ifinfo(neigh_curr,
+								 NULL);
+		if (!neigh_curr_ifinfo)
+			goto out;
+
+		curr_if_avg = neigh_curr_ifinfo->tq_avg;
 		break;
 	case BATADV_GW_MODE_OFF:
 	default:
@@ -754,10 +797,15 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 	if (!neigh_old)
 		goto out;
 
-	if (curr_tq_avg - neigh_old->tq_avg > BATADV_GW_THRESHOLD)
+	neigh_old_ifinfo = batadv_neigh_node_get_ifinfo(neigh_old, NULL);
+	if (!neigh_old_ifinfo)
+		goto out;
+
+	if (curr_if_avg - neigh_old_ifinfo->tq_avg > BATADV_GW_THRESHOLD)
 		out_of_range = true;
 
 out:
+	rcu_read_unlock();
 	if (orig_dst_node)
 		batadv_orig_node_free_ref(orig_dst_node);
 	if (curr_gw)
diff --git a/originator.c b/originator.c
index 8e4bdec..66af68d 100644
--- a/originator.c
+++ b/originator.c
@@ -68,10 +68,28 @@ err:
 	return -ENOMEM;
 }
 
+static void batadv_neigh_node_free_rcu(struct rcu_head *rcu)
+{
+	struct hlist_node *node_tmp;
+	struct batadv_neigh_node *neigh_node;
+	struct batadv_neigh_node_ifinfo *neigh_node_ifinfo;
+
+	neigh_node = container_of(rcu, struct batadv_neigh_node, rcu);
+
+	hlist_for_each_entry_safe(neigh_node_ifinfo, node_tmp,
+				  &neigh_node->ifinfo_list, list) {
+		if (neigh_node_ifinfo->if_outgoing)
+			batadv_hardif_free_ref(neigh_node_ifinfo->if_outgoing);
+		kfree(neigh_node_ifinfo);
+	}
+
+	kfree(neigh_node);
+}
+
 void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node)
 {
 	if (atomic_dec_and_test(&neigh_node->refcount))
-		kfree_rcu(neigh_node, rcu);
+		call_rcu(&neigh_node->rcu, batadv_neigh_node_free_rcu);
 }
 
 /* increases the refcounter of a found router */
@@ -90,6 +108,55 @@ batadv_orig_node_get_router(struct batadv_orig_node *orig_node)
 	return router;
 }
 
+/**
+ * batadv_neigh_node_get_ifinfo - gets the ifinfo from an neigh_node
+ * @neigh_node: the neigh node to be queried
+ * @if_outgoing: the interface for which the ifinfo should be acquired
+ *
+ * Note: this function must be called under rcu lock
+ *
+ * Returns the requested neigh_node_ifinfo or NULL if not found
+ */
+struct batadv_neigh_node_ifinfo *
+batadv_neigh_node_get_ifinfo(struct batadv_neigh_node *neigh,
+			     struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_neigh_node_ifinfo *neigh_ifinfo = NULL,
+					*tmp_neigh_ifinfo;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp_neigh_ifinfo, &neigh->ifinfo_list,
+				 list) {
+		if (tmp_neigh_ifinfo->if_outgoing != if_outgoing)
+			continue;
+
+		neigh_ifinfo = tmp_neigh_ifinfo;
+	}
+	if (neigh_ifinfo)
+		goto out;
+
+	neigh_ifinfo = kzalloc(sizeof(*neigh_ifinfo), GFP_ATOMIC);
+	if (!neigh_ifinfo)
+		goto out;
+
+	if (if_outgoing && !atomic_inc_not_zero(&if_outgoing->refcount)) {
+		kfree(neigh_ifinfo);
+		neigh_ifinfo = NULL;
+		goto out;
+	}
+
+	INIT_HLIST_NODE(&neigh_ifinfo->list);
+	neigh_ifinfo->if_outgoing = if_outgoing;
+
+	spin_lock_bh(&neigh->lq_update_lock);
+	hlist_add_head_rcu(&neigh_ifinfo->list, &neigh->ifinfo_list);
+	spin_unlock_bh(&neigh->lq_update_lock);
+out:
+	rcu_read_unlock();
+
+	return neigh_ifinfo;
+}
+
 struct batadv_neigh_node *
 batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
 		      const uint8_t *neigh_addr)
@@ -102,6 +169,7 @@ batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
 		goto out;
 
 	INIT_HLIST_NODE(&neigh_node->list);
+	INIT_HLIST_HEAD(&neigh_node->ifinfo_list);
 
 	memcpy(neigh_node->addr, neigh_addr, ETH_ALEN);
 	spin_lock_init(&neigh_node->lq_update_lock);
@@ -285,10 +353,16 @@ free_orig_node:
 	return NULL;
 }
 
+/**
+ * batadv_purge_orig_neighbors - purges neighbors from originator
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: orig node which is to be checked
+ *
+ * Returns true if any neighbor was purged, false otherwise
+ */
 static bool
 batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
-			    struct batadv_orig_node *orig_node,
-			    struct batadv_neigh_node **best_neigh_node)
+			    struct batadv_orig_node *orig_node)
 {
 	struct hlist_node *node_tmp;
 	struct batadv_neigh_node *neigh_node;
@@ -296,8 +370,6 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 	unsigned long last_seen;
 	struct batadv_hard_iface *if_incoming;
 
-	*best_neigh_node = NULL;
-
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
 	/* for all neighbors towards this originator ... */
@@ -327,10 +399,6 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 
 			hlist_del_rcu(&neigh_node->list);
 			batadv_neigh_node_free_ref(neigh_node);
-		} else {
-			if ((!*best_neigh_node) ||
-			    (neigh_node->tq_avg > (*best_neigh_node)->tq_avg))
-				*best_neigh_node = neigh_node;
 		}
 	}
 
@@ -338,6 +406,42 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 	return neigh_purged;
 }
 
+/**
+ * batadv_find_best_neighbor - finds the best neighbor after purging
+ * @orig_node: orig node which is to be checked
+ * @if_outgoing: the interface for which the TQ should be compared
+ *
+ * Returns the current best neighbor
+ */
+static struct batadv_neigh_node *
+batadv_find_best_neighbor(struct batadv_orig_node *orig_node,
+			  struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_neigh_node *best = NULL, *neigh;
+	struct batadv_neigh_node_ifinfo *neigh_ifinfo, *best_ifinfo = NULL;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(neigh, &orig_node->neigh_list, list) {
+		neigh_ifinfo = batadv_neigh_node_get_ifinfo(neigh,
+							    if_outgoing);
+		if (!neigh_ifinfo)
+			continue;
+
+		if (!best) {
+			best = neigh;
+			best_ifinfo = neigh_ifinfo;
+			continue;
+		}
+		if (neigh_ifinfo->tq_avg > best_ifinfo->tq_avg) {
+			best = neigh;
+			best_ifinfo = neigh_ifinfo;
+		}
+	}
+	rcu_read_unlock();
+
+	return best;
+}
+
 static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 				   struct batadv_orig_node *orig_node)
 {
@@ -350,12 +454,12 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 			   orig_node->orig,
 			   jiffies_to_msecs(orig_node->last_seen));
 		return true;
-	} else {
-		if (batadv_purge_orig_neighbors(bat_priv, orig_node,
-						&best_neigh_node))
-			batadv_update_route(bat_priv, orig_node,
-					    best_neigh_node);
 	}
+	if (!batadv_purge_orig_neighbors(bat_priv, orig_node))
+		return false;
+
+	best_neigh_node = batadv_find_best_neighbor(orig_node, NULL);
+	batadv_update_route(bat_priv, orig_node, best_neigh_node);
 
 	return false;
 }
@@ -424,6 +528,7 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_hard_iface *primary_if;
 	struct batadv_orig_node *orig_node;
 	struct batadv_neigh_node *neigh_node, *neigh_node_tmp;
+	struct batadv_neigh_node_ifinfo *neigh_ifinfo;
 	int batman_count = 0;
 	int last_seen_secs;
 	int last_seen_msecs;
@@ -450,7 +555,12 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 			if (!neigh_node)
 				continue;
 
-			if (neigh_node->tq_avg == 0)
+			neigh_ifinfo = batadv_neigh_node_get_ifinfo(neigh_node,
+								    NULL);
+			if (!neigh_ifinfo)
+				goto next;
+
+			if (neigh_ifinfo->tq_avg == 0)
 				goto next;
 
 			last_seen_jiffies = jiffies - orig_node->last_seen;
@@ -460,15 +570,20 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 
 			seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
 				   orig_node->orig, last_seen_secs,
-				   last_seen_msecs, neigh_node->tq_avg,
+				   last_seen_msecs, neigh_ifinfo->tq_avg,
 				   neigh_node->addr,
 				   neigh_node->if_incoming->net_dev->name);
 
 			hlist_for_each_entry_rcu(neigh_node_tmp,
 						 &orig_node->neigh_list, list) {
+				neigh_ifinfo = batadv_neigh_node_get_ifinfo(
+							neigh_node, NULL);
+				if (!neigh_ifinfo)
+					continue;
+
 				seq_printf(seq, " %pM (%3i)",
 					   neigh_node_tmp->addr,
-					   neigh_node_tmp->tq_avg);
+					   neigh_ifinfo->tq_avg);
 			}
 
 			seq_puts(seq, "\n");
diff --git a/originator.h b/originator.h
index 7887b84..a53b016 100644
--- a/originator.h
+++ b/originator.h
@@ -35,6 +35,9 @@ batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
 void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node);
 struct batadv_neigh_node *
 batadv_orig_node_get_router(struct batadv_orig_node *orig_node);
+struct batadv_neigh_node_ifinfo *
+batadv_neigh_node_get_ifinfo(struct batadv_neigh_node *neigh,
+			     struct batadv_hard_iface *if_outgoing);
 int batadv_orig_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num);
diff --git a/translation-table.c b/translation-table.c
index 44e7789..1e2adfe 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -942,6 +942,7 @@ static struct batadv_tt_orig_list_entry *
 batadv_transtable_best_orig(struct batadv_tt_global_entry *tt_global_entry)
 {
 	struct batadv_neigh_node *router = NULL;
+	struct batadv_neigh_node_ifinfo *router_ifinfo;
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry, *best_entry = NULL;
 	int best_tq = 0;
@@ -952,9 +953,15 @@ batadv_transtable_best_orig(struct batadv_tt_global_entry *tt_global_entry)
 		if (!router)
 			continue;
 
-		if (router->tq_avg > best_tq) {
+		router_ifinfo = batadv_neigh_node_get_ifinfo(router, NULL);
+		if (!router_ifinfo) {
+			batadv_neigh_node_free_ref(router);
+			continue;
+		}
+
+		if (router_ifinfo->tq_avg > best_tq) {
 			best_entry = orig_entry;
-			best_tq = router->tq_avg;
+			best_tq = router_ifinfo->tq_avg;
 		}
 
 		batadv_neigh_node_free_ref(router);
diff --git a/types.h b/types.h
index 059aa40..2bf7481 100644
--- a/types.h
+++ b/types.h
@@ -236,13 +236,8 @@ struct batadv_gw_node {
  * struct batadv_neigh_node - structure for single hop neighbors
  * @list: list node for batadv_orig_node::neigh_list
  * @addr: mac address of neigh node
- * @tq_recv: ring buffer of received TQ values from this neigh node
- * @tq_index: ring buffer index
- * @tq_avg: averaged tq of all tq values in the ring buffer (tq_recv)
- * @last_ttl: last received ttl from this neigh node
+ * @ifinfo_list: list for routing metrics per outgoing interface
  * @last_seen: when last packet via this neighbor was received
- * @real_bits: bitfield containing the number of OGMs received from this neigh
- *  node (relative to orig_node->last_real_seqno)
  * @real_packet_count: counted result of real_bits
  * @orig_node: pointer to corresponding orig_node
  * @if_incoming: pointer to incoming hard interface
@@ -253,17 +248,35 @@ struct batadv_gw_node {
 struct batadv_neigh_node {
 	struct hlist_node list;
 	uint8_t addr[ETH_ALEN];
+	struct hlist_head ifinfo_list;
+	unsigned long last_seen;
+	struct batadv_orig_node *orig_node;
+	struct batadv_hard_iface *if_incoming;
+	spinlock_t lq_update_lock; /* protects tq_recv & tq_index */
+	atomic_t refcount;
+	struct rcu_head rcu;
+};
+
+/* struct batadv_neigh_node_ifinfo - neighbor information per outgoing interface
+ * @list: list node for batadv_orig_node::neigh_list
+ * @if_outgoing: pointer to outgoing hard interface
+ * @tq_recv: ring buffer of received TQ values from this neigh node
+ * @tq_index: ring buffer index
+ * @tq_avg: averaged tq of all tq values in the ring buffer (tq_recv)
+ * @last_ttl: last received ttl from this neigh node
+ * @real_bits: bitfield containing the number of OGMs received from this neigh
+ *  node (relative to orig_node->last_real_seqno)
+ * @rcu: struct used for freeing in an RCU-safe manner
+ */
+struct batadv_neigh_node_ifinfo {
+	struct hlist_node list;
+	struct batadv_hard_iface *if_outgoing;
 	uint8_t tq_recv[BATADV_TQ_GLOBAL_WINDOW_SIZE];
 	uint8_t tq_index;
 	uint8_t tq_avg;
 	uint8_t last_ttl;
-	unsigned long last_seen;
 	DECLARE_BITMAP(real_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 	uint8_t real_packet_count;
-	struct batadv_orig_node *orig_node;
-	struct batadv_hard_iface *if_incoming;
-	spinlock_t lq_update_lock; /* protects tq_recv & tq_index */
-	atomic_t refcount;
 	struct rcu_head rcu;
 };
 
-- 
1.7.10.4

