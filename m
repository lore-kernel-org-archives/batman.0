Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed,  9 Oct 2013 15:05:33 +0200
Message-Id: <1381323938-26931-3-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: split tq information in
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
Changes to RFCv2:
 * change bat_neigh_cmp and equiv_or_better to use two neighbor
   and if_outgoing as parameter
 * keep bat_neigh_is_equiv_or_better name (no _ifinfo_)
 * various style and documentation fixes

Changes to RFC:
 * rebase on latest master
 * change compare API to consider outgoing interface
 * change EOB API to use ifinfo - this will be required to compare
   routers for different ougoing interfaces in the bonding patch
 * fix missing spin_unlock_bh
---
 bat_iv_ogm.c        |  207 ++++++++++++++++++++++++++++++++++++++-------------
 gateway_client.c    |   69 ++++++++++++++---
 originator.c        |  129 +++++++++++++++++++++++++++-----
 originator.h        |    3 +
 translation-table.c |    2 +-
 types.h             |   75 +++++++++++--------
 6 files changed, 375 insertions(+), 110 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 6cd9a0f..2cdcb8b 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -274,7 +274,13 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 	if (!neigh_node)
 		goto out;
 
-	spin_lock_init(&neigh_node->bat_iv.lq_update_lock);
+	if (!atomic_inc_not_zero(&hard_iface->refcount)) {
+		kfree(neigh_node);
+		goto out;
+	}
+
+	neigh_node->orig_node = orig_neigh;
+	neigh_node->if_incoming = hard_iface;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Creating new neighbor %pM for orig_node %pM on interface %s\n",
@@ -897,22 +903,37 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 		batadv_hardif_free_ref(primary_if);
 }
 
+/**
+ * batadv_iv_ogm_orig_update - use OGM to update corresponding data in an
+ *  originator
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: the orig node who originally emitted the ogm packet
+ * @ethhdr: Ethernet header of the OGM
+ * @batadv_ogm_packet: the ogm packet
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
+	struct batadv_neigh_node_ifinfo *neigh_ifinfo = NULL;
+	struct batadv_neigh_node_ifinfo *tmp_neigh_ifinfo, *router_ifinfo;
 	struct batadv_neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	struct batadv_neigh_node *router = NULL;
 	struct batadv_orig_node *orig_node_tmp;
 	int if_num;
 	uint8_t sum_orig, sum_neigh;
 	uint8_t *neigh_addr;
-	uint8_t tq_avg;
+	uint8_t tq_avg, *tq_recv, *tq_index;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "update_originator(): Searching and updating originator entry of received packet\n");
@@ -933,12 +954,21 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 		if (dup_status != BATADV_NO_DUP)
 			continue;
 
-		spin_lock_bh(&tmp_neigh_node->bat_iv.lq_update_lock);
-		batadv_ring_buffer_set(tmp_neigh_node->bat_iv.tq_recv,
-				       &tmp_neigh_node->bat_iv.tq_index, 0);
-		tq_avg = batadv_ring_buffer_avg(tmp_neigh_node->bat_iv.tq_recv);
-		tmp_neigh_node->bat_iv.tq_avg = tq_avg;
-		spin_unlock_bh(&tmp_neigh_node->bat_iv.lq_update_lock);
+		spin_lock_bh(&tmp_neigh_node->ifinfo_lock);
+		/* only update the entry for this outgoing interface */
+		hlist_for_each_entry_rcu(tmp_neigh_ifinfo,
+					 &tmp_neigh_node->ifinfo_list,
+					 list) {
+			if (tmp_neigh_ifinfo->if_outgoing != if_outgoing)
+				continue;
+
+			tq_recv = tmp_neigh_ifinfo->bat_iv.tq_recv;
+			tq_index = &tmp_neigh_ifinfo->bat_iv.tq_index;
+			batadv_ring_buffer_set(tq_recv, tq_index, 0);
+			tq_avg = batadv_ring_buffer_avg(tq_recv);
+			tmp_neigh_ifinfo->bat_iv.tq_avg = tq_avg;
+		}
+		spin_unlock_bh(&tmp_neigh_node->ifinfo_lock);
 	}
 
 	if (!neigh_node) {
@@ -946,7 +976,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 
 		orig_tmp = batadv_iv_ogm_orig_get(bat_priv, ethhdr->h_source);
 		if (!orig_tmp)
-			goto unlock;
+			goto out;
 
 		neigh_node = batadv_iv_ogm_neigh_new(if_incoming,
 						     ethhdr->h_source,
@@ -954,26 +984,29 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 
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
 
-	spin_lock_bh(&neigh_node->bat_iv.lq_update_lock);
-	batadv_ring_buffer_set(neigh_node->bat_iv.tq_recv,
-			       &neigh_node->bat_iv.tq_index,
+	spin_lock_bh(&neigh_node->ifinfo_lock);
+	batadv_ring_buffer_set(neigh_ifinfo->bat_iv.tq_recv,
+			       &neigh_ifinfo->bat_iv.tq_index,
 			       batadv_ogm_packet->tq);
-	tq_avg = batadv_ring_buffer_avg(neigh_node->bat_iv.tq_recv);
-	neigh_node->bat_iv.tq_avg = tq_avg;
-	spin_unlock_bh(&neigh_node->bat_iv.lq_update_lock);
+	tq_avg = batadv_ring_buffer_avg(neigh_ifinfo->bat_iv.tq_recv);
+	neigh_ifinfo->bat_iv.tq_avg = tq_avg;
+	spin_unlock_bh(&neigh_node->ifinfo_lock);
 
 	if (dup_status == BATADV_NO_DUP) {
 		orig_node->last_ttl = batadv_ogm_packet->header.ttl;
-		neigh_node->last_ttl = batadv_ogm_packet->header.ttl;
+		neigh_ifinfo->last_ttl = batadv_ogm_packet->header.ttl;
 	}
 
 	/* if this neighbor already is our next hop there is nothing
@@ -983,14 +1016,17 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	if (router == neigh_node)
 		goto out;
 
+	router_ifinfo = batadv_neigh_node_get_ifinfo(router, if_outgoing);
 	/* if this neighbor does not offer a better TQ we won't consider it */
-	if (router && (router->bat_iv.tq_avg > neigh_node->bat_iv.tq_avg))
+	if (router_ifinfo &&
+	    (router_ifinfo->bat_iv.tq_avg > neigh_ifinfo->bat_iv.tq_avg))
 		goto out;
 
 	/* if the TQ is the same and the link not more symmetric we
 	 * won't consider it either
 	 */
-	if (router && (neigh_node->bat_iv.tq_avg == router->bat_iv.tq_avg)) {
+	if (router_ifinfo &&
+	    (neigh_ifinfo->bat_iv.tq_avg == router_ifinfo->bat_iv.tq_avg)) {
 		orig_node_tmp = router->orig_node;
 		spin_lock_bh(&orig_node_tmp->bat_iv.ogm_cnt_lock);
 		if_num = router->if_incoming->if_num;
@@ -1007,25 +1043,37 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
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
@@ -1070,7 +1118,15 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 	if_num = if_incoming->if_num;
 	orig_eq_count = orig_neigh_node->bat_iv.bcast_own_sum[if_num];
-	neigh_rq_count = neigh_node->bat_iv.real_packet_count;
+	rcu_read_lock();
+	neigh_node_ifinfo = batadv_neigh_node_get_ifinfo(neigh_node,
+							 if_outgoing);
+	if (!neigh_node_ifinfo)
+		neigh_rq_count = 0;
+	else
+		neigh_rq_count = neigh_node_ifinfo->bat_iv.real_packet_count;
+
+	rcu_read_unlock();
 	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 
 	/* pay attention to not get a value bigger than 100 % */
@@ -1134,17 +1190,20 @@ out:
  * @ethhdr: ethernet header of the packet
  * @batadv_ogm_packet: OGM packet to be considered
  * @if_incoming: interface on which the OGM packet was received
+ * @if_outgoing: interface for which the retransmission should be considered
  *
  * Returns duplicate status as enum batadv_dup_status
  */
 static enum batadv_dup_status
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
@@ -1171,15 +1230,19 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	}
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(tmp_neigh_node,
-				 &orig_node->neigh_list, list) {
-		neigh_addr = tmp_neigh_node->addr;
-		is_dup = batadv_test_bit(tmp_neigh_node->bat_iv.real_bits,
+	hlist_for_each_entry_rcu(neigh_node, &orig_node->neigh_list, list) {
+		neigh_ifinfo = batadv_neigh_node_get_ifinfo(neigh_node,
+							    if_outgoing);
+		if (WARN_ON(!neigh_ifinfo))
+			continue;
+
+		neigh_addr = neigh_node->addr;
+		is_dup = batadv_test_bit(neigh_ifinfo->bat_iv.real_bits,
 					 orig_node->last_real_seqno,
 					 seqno);
 
 		if (batadv_compare_eth(neigh_addr, ethhdr->h_source) &&
-		    tmp_neigh_node->if_incoming == if_incoming) {
+		    neigh_node->if_incoming == if_incoming) {
 			set_mark = 1;
 			if (is_dup)
 				ret = BATADV_NEIGH_DUP;
@@ -1190,15 +1253,14 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 		}
 
 		/* if the window moved, set the update flag. */
-		bitmap = tmp_neigh_node->bat_iv.real_bits;
+		bitmap = neigh_ifinfo->bat_iv.real_bits;
 		need_update |= batadv_bit_get_packet(bat_priv, bitmap,
 						     seq_diff, set_mark);
 
-		packet_count = bitmap_weight(tmp_neigh_node->bat_iv.real_bits,
+		packet_count = bitmap_weight(bitmap,
 					     BATADV_TQ_LOCAL_WINDOW_SIZE);
-		tmp_neigh_node->bat_iv.real_packet_count = packet_count;
+		neigh_ifinfo->bat_iv.real_packet_count = packet_count;
 	}
-	rcu_read_unlock();
 
 	if (need_update) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
@@ -1206,6 +1268,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 			   orig_node->last_real_seqno, seqno);
 		orig_node->last_real_seqno = seqno;
 	}
+	rcu_read_unlock();
 
 out:
 	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
@@ -1223,6 +1286,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	struct batadv_orig_node *orig_neigh_node, *orig_node, *orig_node_tmp;
 	struct batadv_neigh_node *router = NULL, *router_router = NULL;
 	struct batadv_neigh_node *orig_neigh_router = NULL;
+	struct batadv_neigh_node_ifinfo *router_ifinfo = NULL;
 	int has_directlink_flag;
 	int is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
 	int is_bidirect;
@@ -1355,7 +1419,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		return;
 
 	dup_status = batadv_iv_ogm_update_seqnos(ethhdr, batadv_ogm_packet,
-						 if_incoming);
+						 if_incoming, NULL);
 
 	if (dup_status == BATADV_PROTECTED) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
@@ -1376,7 +1440,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		router_router = batadv_orig_node_get_router(orig_node_tmp);
 	}
 
-	if ((router && router->bat_iv.tq_avg != 0) &&
+	if ((router && router_ifinfo->bat_iv.tq_avg != 0) &&
 	    (batadv_compare_eth(router->addr, ethhdr->h_source)))
 		is_from_best_next_hop = true;
 
@@ -1422,7 +1486,8 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	}
 
 	is_bidirect = batadv_iv_ogm_calc_tq(orig_node, orig_neigh_node,
-					    batadv_ogm_packet, if_incoming);
+					    batadv_ogm_packet, if_incoming,
+					    NULL);
 
 	/* update ranking if it is not a duplicate or has the same
 	 * seqno and similar ttl as the non-duplicate
@@ -1433,7 +1498,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 			    (sameseq && similar_ttl)))
 		batadv_iv_ogm_orig_update(bat_priv, orig_node, ethhdr,
 					  batadv_ogm_packet, if_incoming,
-					  tt_buff, dup_status);
+					  NULL, tt_buff, dup_status);
 
 	/* is single hop (direct) neighbor */
 	if (is_single_hop_neigh) {
@@ -1541,6 +1606,7 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	int last_seen_msecs, last_seen_secs;
 	struct batadv_orig_node *orig_node;
+	struct batadv_neigh_node_ifinfo *neigh_ifinfo;
 	unsigned long last_seen_jiffies;
 	struct hlist_head *head;
 	int batman_count = 0;
@@ -1559,7 +1625,12 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 			if (!neigh_node)
 				continue;
 
-			if (neigh_node->bat_iv.tq_avg == 0)
+			neigh_ifinfo = batadv_neigh_node_get_ifinfo(neigh_node,
+								    NULL);
+			if (!neigh_ifinfo)
+				goto next;
+
+			if (neigh_ifinfo->bat_iv.tq_avg == 0)
 				goto next;
 
 			last_seen_jiffies = jiffies - orig_node->last_seen;
@@ -1569,15 +1640,20 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 
 			seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
 				   orig_node->orig, last_seen_secs,
-				   last_seen_msecs, neigh_node->bat_iv.tq_avg,
+				   last_seen_msecs, neigh_ifinfo->bat_iv.tq_avg,
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
-					   neigh_node_tmp->bat_iv.tq_avg);
+					   neigh_ifinfo->bat_iv.tq_avg);
 			}
 
 			seq_puts(seq, "\n");
@@ -1596,18 +1672,29 @@ next:
 /**
  * batadv_iv_ogm_neigh_cmp - compare the metrics of two neighbors
  * @neigh1: the first neighbor object of the comparison
+ * @if_outgoing: outgoing interface for the first neighbor
  * @neigh2: the second neighbor object of the comparison
+ * @if_outgoing2: outgoing interface for the second neighbor
  *
  * Returns a value less, equal to or greater than 0 if the metric via neigh1 is
  * lower, the same as or higher than the metric via neigh2
  */
 static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
-				   struct batadv_neigh_node *neigh2)
+				   struct batadv_hard_iface *if_outgoing1,
+				   struct batadv_neigh_node *neigh2,
+				   struct batadv_hard_iface *if_outgoing2)
 {
+	struct batadv_neigh_node_ifinfo *neigh1_ifinfo, *neigh2_ifinfo;
 	uint8_t tq1, tq2;
 
-	tq1 = neigh1->bat_iv.tq_avg;
-	tq2 = neigh2->bat_iv.tq_avg;
+	neigh1_ifinfo = batadv_neigh_node_get_ifinfo(neigh1, if_outgoing1);
+	neigh2_ifinfo = batadv_neigh_node_get_ifinfo(neigh2, if_outgoing2);
+
+	if (!neigh1_ifinfo || !neigh2_ifinfo)
+		return 0;
+
+	tq1 = neigh1_ifinfo->bat_iv.tq_avg;
+	tq2 = neigh2_ifinfo->bat_iv.tq_avg;
 
 	return tq1 - tq2;
 }
@@ -1616,17 +1703,33 @@ static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
  * batadv_iv_ogm_neigh_is_eob - check if neigh1 is equally good or better than
  *  neigh2 from the metric prospective
  * @neigh1: the first neighbor object of the comparison
+ * @if_outgoing: outgoing interface for the first neighbor
  * @neigh2: the second neighbor object of the comparison
- *
- * Returns true if the metric via neigh1 is equally good or better than the
- * metric via neigh2, false otherwise.
+ * @if_outgoing2: outgoing interface for the second neighbor
+
+ * Returns true if the metric via neigh1 is equally good or better than
+ * the metric via neigh2, false otherwise.
  */
-static bool batadv_iv_ogm_neigh_is_eob(struct batadv_neigh_node *neigh1,
-				       struct batadv_neigh_node *neigh2)
+static bool
+batadv_iv_ogm_neigh_is_eob(struct batadv_neigh_node *neigh1,
+			   struct batadv_hard_iface *if_outgoing1,
+			   struct batadv_neigh_node *neigh2,
+			   struct batadv_hard_iface *if_outgoing2)
 {
-	int diff = batadv_iv_ogm_neigh_cmp(neigh1, neigh2);
+	struct batadv_neigh_node_ifinfo *neigh1_ifinfo, *neigh2_ifinfo;
+	uint8_t tq1, tq2;
 
-	return diff > -BATADV_TQ_SIMILARITY_THRESHOLD;
+	neigh1_ifinfo = batadv_neigh_node_get_ifinfo(neigh1, if_outgoing1);
+	neigh2_ifinfo = batadv_neigh_node_get_ifinfo(neigh2, if_outgoing2);
+
+	/* we can't say that the metric is better */
+	if (!neigh1_ifinfo || !neigh2_ifinfo)
+		return false;
+
+	tq1 = neigh1_ifinfo->bat_iv.tq_avg;
+	tq2 = neigh2_ifinfo->bat_iv.tq_avg;
+
+	return (tq1 - tq2) > -BATADV_TQ_SIMILARITY_THRESHOLD;
 }
 
 static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
diff --git a/gateway_client.c b/gateway_client.c
index 7299936..f616775 100644
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
 
-		tq_avg = router->bat_iv.tq_avg;
+		tq_avg = router_ifinfo->bat_iv.tq_avg;
 
 		switch (atomic_read(&bat_priv->gw_sel_class)) {
 		case 1: /* fast connection */
@@ -219,8 +224,10 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 {
 	struct batadv_gw_node *curr_gw = NULL, *next_gw = NULL;
 	struct batadv_neigh_node *router = NULL;
+	struct batadv_neigh_node_ifinfo *router_ifinfo = NULL;
 	char gw_addr[18] = { '\0' };
 
+	rcu_read_lock();
 	if (atomic_read(&bat_priv->gw_mode) != BATADV_GW_MODE_CLIENT)
 		goto out;
 
@@ -242,6 +249,12 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
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
@@ -256,7 +269,8 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 			   next_gw->bandwidth_down / 10,
 			   next_gw->bandwidth_down % 10,
 			   next_gw->bandwidth_up / 10,
-			   next_gw->bandwidth_up % 10, router->bat_iv.tq_avg);
+			   next_gw->bandwidth_up % 10,
+			   router_ifinfo->bat_iv.tq_avg);
 		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_ADD,
 				    gw_addr);
 	} else {
@@ -266,7 +280,8 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 			   next_gw->bandwidth_down / 10,
 			   next_gw->bandwidth_down % 10,
 			   next_gw->bandwidth_up / 10,
-			   next_gw->bandwidth_up % 10, router->bat_iv.tq_avg);
+			   next_gw->bandwidth_up % 10,
+			   router_ifinfo->bat_iv.tq_avg);
 		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_CHANGE,
 				    gw_addr);
 	}
@@ -274,6 +289,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 	batadv_gw_select(bat_priv, next_gw);
 
 out:
+	rcu_read_unlock();
 	if (curr_gw)
 		batadv_gw_node_free_ref(curr_gw);
 	if (next_gw)
@@ -285,10 +301,13 @@ out:
 void batadv_gw_check_election(struct batadv_priv *bat_priv,
 			      struct batadv_orig_node *orig_node)
 {
+	struct batadv_neigh_node_ifinfo *router_orig_tq = NULL;
+	struct batadv_neigh_node_ifinfo *router_gw_tq = NULL;
 	struct batadv_orig_node *curr_gw_orig;
 	struct batadv_neigh_node *router_gw = NULL, *router_orig = NULL;
 	uint8_t gw_tq_avg, orig_tq_avg;
 
+	rcu_read_lock();
 	curr_gw_orig = batadv_gw_get_selected_orig(bat_priv);
 	if (!curr_gw_orig)
 		goto deselect;
@@ -297,6 +316,10 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 	if (!router_gw)
 		goto deselect;
 
+	router_gw_tq = batadv_neigh_node_get_ifinfo(router_gw, NULL);
+	if (!router_gw_tq)
+		goto deselect;
+
 	/* this node already is the gateway */
 	if (curr_gw_orig == orig_node)
 		goto out;
@@ -305,8 +328,15 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 	if (!router_orig)
 		goto out;
 
-	gw_tq_avg = router_gw->bat_iv.tq_avg;
-	orig_tq_avg = router_orig->bat_iv.tq_avg;
+	router_orig_tq = batadv_neigh_node_get_ifinfo(router_orig, NULL);
+	if (!router_orig_tq) {
+		batadv_gw_deselect(bat_priv);
+		goto out;
+	}
+
+
+	gw_tq_avg = router_gw_tq->bat_iv.tq_avg;
+	orig_tq_avg = router_orig_tq->bat_iv.tq_avg;
 
 	/* the TQ value has to be better */
 	if (orig_tq_avg < gw_tq_avg)
@@ -324,6 +354,7 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 		   gw_tq_avg, orig_tq_avg);
 
 deselect:
+	rcu_read_unlock();
 	batadv_gw_deselect(bat_priv);
 out:
 	if (curr_gw_orig)
@@ -517,18 +548,24 @@ static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
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
-			 router->bat_iv.tq_avg, router->addr,
+			 router_ifinfo->bat_iv.tq_avg, router->addr,
 			 router->if_incoming->net_dev->name,
 			 gw_node->bandwidth_down / 10,
 			 gw_node->bandwidth_down % 10,
@@ -539,6 +576,7 @@ static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
 	if (curr_gw)
 		batadv_gw_node_free_ref(curr_gw);
 out:
+	rcu_read_unlock();
 	return ret;
 }
 
@@ -741,14 +779,16 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 	struct batadv_neigh_node *neigh_curr = NULL, *neigh_old = NULL;
 	struct batadv_orig_node *orig_dst_node = NULL;
 	struct batadv_gw_node *gw_node = NULL, *curr_gw = NULL;
+	struct batadv_neigh_node_ifinfo *curr_ifinfo, *old_ifinfo;
 	struct ethhdr *ethhdr;
 	bool ret, out_of_range = false;
 	unsigned int header_len = 0;
-	uint8_t curr_tq_avg;
+	uint8_t curr_if_avg;
 	unsigned short vid;
 
 	vid = batadv_get_vid(skb, 0);
 
+	rcu_read_lock();
 	ret = batadv_gw_is_dhcp_target(skb, &header_len);
 	if (!ret)
 		goto out;
@@ -772,7 +812,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 		/* If we are a GW then we are our best GW. We can artificially
 		 * set the tq towards ourself as the maximum value
 		 */
-		curr_tq_avg = BATADV_TQ_MAX_VALUE;
+		curr_if_avg = BATADV_TQ_MAX_VALUE;
 		break;
 	case BATADV_GW_MODE_CLIENT:
 		curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
@@ -792,7 +832,11 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 		if (!neigh_curr)
 			goto out;
 
-		curr_tq_avg = neigh_curr->bat_iv.tq_avg;
+		curr_ifinfo = batadv_neigh_node_get_ifinfo(neigh_curr, NULL);
+		if (!curr_ifinfo)
+			goto out;
+
+		curr_if_avg = curr_ifinfo->bat_iv.tq_avg;
 		break;
 	case BATADV_GW_MODE_OFF:
 	default:
@@ -803,10 +847,15 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 	if (!neigh_old)
 		goto out;
 
-	if (curr_tq_avg - neigh_old->bat_iv.tq_avg > BATADV_GW_THRESHOLD)
+	old_ifinfo = batadv_neigh_node_get_ifinfo(neigh_old, NULL);
+	if (!old_ifinfo)
+		goto out;
+
+	if ((curr_if_avg - old_ifinfo->bat_iv.tq_avg) > BATADV_GW_THRESHOLD)
 		out_of_range = true;
 
 out:
+	rcu_read_unlock();
 	if (orig_dst_node)
 		batadv_orig_node_free_ref(orig_dst_node);
 	if (curr_gw)
diff --git a/originator.c b/originator.c
index 919fdc0..8508d1b 100644
--- a/originator.c
+++ b/originator.c
@@ -150,10 +150,28 @@ err:
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
@@ -173,6 +191,55 @@ batadv_orig_node_get_router(struct batadv_orig_node *orig_node)
 }
 
 /**
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
+	spin_lock_bh(&neigh->ifinfo_lock);
+	hlist_add_head_rcu(&neigh_ifinfo->list, &neigh->ifinfo_list);
+	spin_unlock_bh(&neigh->ifinfo_lock);
+out:
+	rcu_read_unlock();
+
+	return neigh_ifinfo;
+}
+
+/**
  * batadv_neigh_node_new - create and init a new neigh_node object
  * @hard_iface: the interface where the neighbour is connected to
  * @neigh_addr: the mac address of the neighbour interface
@@ -181,6 +248,7 @@ batadv_orig_node_get_router(struct batadv_orig_node *orig_node)
  * Allocates a new neigh_node object and initialises all the generic fields.
  * Returns the new object or NULL on failure.
  */
+
 struct batadv_neigh_node *
 batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
 		      const uint8_t *neigh_addr,
@@ -193,6 +261,8 @@ batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
 		goto out;
 
 	INIT_HLIST_NODE(&neigh_node->list);
+	INIT_HLIST_HEAD(&neigh_node->ifinfo_list);
+	spin_lock_init(&neigh_node->ifinfo_lock);
 
 	memcpy(neigh_node->addr, neigh_addr, ETH_ALEN);
 	neigh_node->if_incoming = hard_iface;
@@ -364,20 +434,23 @@ free_orig_node:
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
-			    struct batadv_neigh_node **best_neigh)
+			    struct batadv_orig_node *orig_node)
 {
-	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
 	struct hlist_node *node_tmp;
 	struct batadv_neigh_node *neigh_node;
 	bool neigh_purged = false;
 	unsigned long last_seen;
 	struct batadv_hard_iface *if_incoming;
 
-	*best_neigh = NULL;
-
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
 	/* for all neighbors towards this originator ... */
@@ -407,13 +480,6 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 
 			hlist_del_rcu(&neigh_node->list);
 			batadv_neigh_node_free_ref(neigh_node);
-		} else {
-			/* store the best_neighbour if this is the first
-			 * iteration or if a better neighbor has been found
-			 */
-			if (!*best_neigh ||
-			    bao->bat_neigh_cmp(neigh_node, *best_neigh) > 0)
-				*best_neigh = neigh_node;
 		}
 	}
 
@@ -421,6 +487,33 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 	return neigh_purged;
 }
 
+/**
+ * batadv_find_best_neighbor - finds the best neighbor after purging
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: orig node which is to be checked
+ * @if_outgoing: the interface for which the metric should be compared
+ *
+ * Returns the current best neighbor
+ */
+static struct batadv_neigh_node *
+batadv_find_best_neighbor(struct batadv_priv *bat_priv,
+			  struct batadv_orig_node *orig_node,
+			  struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_neigh_node *best = NULL, *neigh;
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(neigh, &orig_node->neigh_list, list)
+		if (!best ||
+		    (bao->bat_neigh_cmp(neigh, if_outgoing,
+					best, if_outgoing) <= 0))
+			best = neigh;
+	rcu_read_unlock();
+
+	return best;
+}
+
 static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 				   struct batadv_orig_node *orig_node)
 {
@@ -433,12 +526,12 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
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
+	best_neigh_node = batadv_find_best_neighbor(bat_priv, orig_node, NULL);
+	batadv_update_route(bat_priv, orig_node, best_neigh_node);
 
 	return false;
 }
diff --git a/originator.h b/originator.h
index 6f77d80..161c1e3 100644
--- a/originator.h
+++ b/originator.h
@@ -37,6 +37,9 @@ batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
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
index d1840dd..ea4215b 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1361,7 +1361,7 @@ batadv_transtable_best_orig(struct batadv_priv *bat_priv,
 			continue;
 
 		if (best_router &&
-		    bao->bat_neigh_cmp(router, best_router) <= 0) {
+		    bao->bat_neigh_cmp(router, NULL, best_router, NULL) <= 0) {
 			batadv_neigh_node_free_ref(router);
 			continue;
 		}
diff --git a/types.h b/types.h
index 48eed46..0973473 100644
--- a/types.h
+++ b/types.h
@@ -267,47 +267,57 @@ struct batadv_gw_node {
 };
 
 /**
- * struct batadv_neigh_bat_iv - B.A.T.M.A.N. IV specific structure for single
- *  hop neighbors
+ * struct batadv_neigh_node - structure for single hops neighbors
+ * @list: list node for batadv_orig_node::neigh_list
+ * @orig_node: pointer to corresponding orig_node
+ * @addr: the MAC address of the neighboring interface
+ * @ifinfo_list: list for routing metrics per outgoing interface
+ * @ifinfo_lock: lock protecting private ifinfo members and list
+ * @if_incoming: pointer to incoming hard interface
+ * @last_seen: when last packet via this neighbor was received
+ * @last_ttl: last received ttl from this neigh node
+ * @rcu: struct used for freeing in an RCU-safe manner
+ * @bat_iv: B.A.T.M.A.N. IV private structure
+ */
+struct batadv_neigh_node {
+	struct hlist_node list;
+	struct batadv_orig_node *orig_node;
+	uint8_t addr[ETH_ALEN];
+	struct hlist_head ifinfo_list;
+	spinlock_t ifinfo_lock;	/* protects ifinfo_list and its members */
+	struct batadv_hard_iface *if_incoming;
+	unsigned long last_seen;
+	atomic_t refcount;
+	struct rcu_head rcu;
+};
+
+/* struct batadv_neigh_node_ifinfo - neighbor information per outgoing interface
+ *	for BATMAN IV
  * @tq_recv: ring buffer of received TQ values from this neigh node
  * @tq_index: ring buffer index
  * @tq_avg: averaged tq of all tq values in the ring buffer (tq_recv)
  * @real_bits: bitfield containing the number of OGMs received from this neigh
- *  node (relative to orig_node->last_real_seqno)
- * @real_packet_count: counted result of real_bits
- * @lq_update_lock: lock protecting tq_recv & tq_index
  */
-struct batadv_neigh_bat_iv {
+struct batadv_neigh_ifinfo_bat_iv {
 	uint8_t tq_recv[BATADV_TQ_GLOBAL_WINDOW_SIZE];
 	uint8_t tq_index;
 	uint8_t tq_avg;
 	DECLARE_BITMAP(real_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 	uint8_t real_packet_count;
-	spinlock_t lq_update_lock; /* protects tq_recv & tq_index */
 };
 
-/**
- * struct batadv_neigh_node - structure for single hops neighbors
+/* struct batadv_neigh_node_ifinfo - neighbor information per outgoing interface
  * @list: list node for batadv_orig_node::neigh_list
- * @orig_node: pointer to corresponding orig_node
- * @addr: the MAC address of the neighboring interface
- * @if_incoming: pointer to incoming hard interface
- * @last_seen: when last packet via this neighbor was received
+ * @if_outgoing: pointer to outgoing hard interface
  * @last_ttl: last received ttl from this neigh node
- * @refcount: number of contexts the object is used
+ *  node (relative to orig_node->last_real_seqno)
  * @rcu: struct used for freeing in an RCU-safe manner
- * @bat_iv: B.A.T.M.A.N. IV private structure
  */
-struct batadv_neigh_node {
+struct batadv_neigh_node_ifinfo {
 	struct hlist_node list;
-	struct batadv_orig_node *orig_node;
-	uint8_t addr[ETH_ALEN];
-	struct batadv_hard_iface *if_incoming;
-	unsigned long last_seen;
+	struct batadv_hard_iface *if_outgoing;
+	struct batadv_neigh_ifinfo_bat_iv bat_iv;
 	uint8_t last_ttl;
-	atomic_t refcount;
-	struct rcu_head rcu;
-	struct batadv_neigh_bat_iv bat_iv;
 };
 
 /**
@@ -989,9 +999,11 @@ struct batadv_forw_packet {
  * @bat_primary_iface_set: called when primary interface is selected / changed
  * @bat_ogm_schedule: prepare a new outgoing OGM for the send queue
  * @bat_ogm_emit: send scheduled OGM
- * @bat_neigh_cmp: compare the metrics of two neighbors
- * @bat_neigh_is_equiv_or_better: check if neigh1 is equally good or
- *  better than neigh2 from the metric prospective
+ * @bat_neigh_cmp: compare the metrics of two neighbors for their respective
+ *  outgoing interfaces
+ * @bat_neigh_is_equiv_or_better: check if neigh1 is equally good or better
+ *  than neigh2 for their respective outgoing interface from the metric
+ *  prospective
  * @bat_orig_print: print the originator table (optional)
  * @bat_orig_free: free the resources allocated by the routing algorithm for an
  *  orig_node object
@@ -1010,9 +1022,14 @@ struct batadv_algo_ops {
 	void (*bat_ogm_schedule)(struct batadv_hard_iface *hard_iface);
 	void (*bat_ogm_emit)(struct batadv_forw_packet *forw_packet);
 	int (*bat_neigh_cmp)(struct batadv_neigh_node *neigh1,
-			     struct batadv_neigh_node *neigh2);
-	bool (*bat_neigh_is_equiv_or_better)(struct batadv_neigh_node *neigh1,
-					     struct batadv_neigh_node *neigh2);
+			     struct batadv_hard_iface *if_outgoing1,
+			     struct batadv_neigh_node *neigh2,
+			     struct batadv_hard_iface *if_outgoing2);
+	bool (*bat_neigh_is_equiv_or_better)
+		(struct batadv_neigh_node *neigh1,
+		 struct batadv_hard_iface *if_outgoing1,
+		 struct batadv_neigh_node *neigh2,
+		 struct batadv_hard_iface *if_outgoing2);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq);
 	void (*bat_orig_free)(struct batadv_orig_node *orig_node);
-- 
1.7.10.4

