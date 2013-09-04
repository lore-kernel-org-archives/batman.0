Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed,  4 Sep 2013 18:27:36 +0200
Message-Id: <1378312060-30922-3-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1378312060-30922-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1378312060-30922-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFCv2 2/6] batman-adv: split tq information in
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
Changes to RFC:
 * rebase on latest master
 * change compare API to consider outgoing interface
 * change EOB API to use ifinfo - this will be required to compare
   routers for different ougoing interfaces in the bonding patch
 * fix missing spin_unlock_bh
---
 bat_iv_ogm.c        |  194 ++++++++++++++++++++++++++++++++++++++-------------
 gateway_client.c    |   69 +++++++++++++++---
 main.c              |    2 +-
 originator.c        |  127 ++++++++++++++++++++++++++++-----
 originator.h        |    3 +
 translation-table.c |    2 +-
 types.h             |   62 ++++++++++------
 7 files changed, 359 insertions(+), 100 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 6cd9a0f..d46746f 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -275,6 +275,13 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 		goto out;
 
 	spin_lock_init(&neigh_node->bat_iv.lq_update_lock);
+	if (!atomic_inc_not_zero(&hard_iface->refcount)) {
+		kfree(neigh_node);
+		goto out;
+	}
+
+	neigh_node->orig_node = orig_neigh;
+	neigh_node->if_incoming = hard_iface;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Creating new neighbor %pM for orig_node %pM on interface %s\n",
@@ -897,22 +904,39 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 		batadv_hardif_free_ref(primary_if);
 }
 
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
+	uint8_t tq_avg, *tq_recv, *tq_index;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "update_originator(): Searching and updating originator entry of received packet\n");
@@ -934,10 +958,19 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 			continue;
 
 		spin_lock_bh(&tmp_neigh_node->bat_iv.lq_update_lock);
-		batadv_ring_buffer_set(tmp_neigh_node->bat_iv.tq_recv,
-				       &tmp_neigh_node->bat_iv.tq_index, 0);
-		tq_avg = batadv_ring_buffer_avg(tmp_neigh_node->bat_iv.tq_recv);
-		tmp_neigh_node->bat_iv.tq_avg = tq_avg;
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
 		spin_unlock_bh(&tmp_neigh_node->bat_iv.lq_update_lock);
 	}
 
@@ -946,7 +979,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 
 		orig_tmp = batadv_iv_ogm_orig_get(bat_priv, ethhdr->h_source);
 		if (!orig_tmp)
-			goto unlock;
+			goto out;
 
 		neigh_node = batadv_iv_ogm_neigh_new(if_incoming,
 						     ethhdr->h_source,
@@ -954,26 +987,29 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 
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
 
 	spin_lock_bh(&neigh_node->bat_iv.lq_update_lock);
-	batadv_ring_buffer_set(neigh_node->bat_iv.tq_recv,
-			       &neigh_node->bat_iv.tq_index,
+	batadv_ring_buffer_set(neigh_ifinfo->bat_iv.tq_recv,
+			       &neigh_ifinfo->bat_iv.tq_index,
 			       batadv_ogm_packet->tq);
-	tq_avg = batadv_ring_buffer_avg(neigh_node->bat_iv.tq_recv);
-	neigh_node->bat_iv.tq_avg = tq_avg;
+	tq_avg = batadv_ring_buffer_avg(neigh_ifinfo->bat_iv.tq_recv);
+	neigh_ifinfo->bat_iv.tq_avg = tq_avg;
 	spin_unlock_bh(&neigh_node->bat_iv.lq_update_lock);
 
 	if (dup_status == BATADV_NO_DUP) {
 		orig_node->last_ttl = batadv_ogm_packet->header.ttl;
-		neigh_node->last_ttl = batadv_ogm_packet->header.ttl;
+		neigh_ifinfo->last_ttl = batadv_ogm_packet->header.ttl;
 	}
 
 	/* if this neighbor already is our next hop there is nothing
@@ -983,14 +1019,17 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
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
@@ -1007,25 +1046,37 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
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
@@ -1070,7 +1121,15 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
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
@@ -1134,17 +1193,20 @@ out:
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
@@ -1171,15 +1233,20 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	}
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(tmp_neigh_node,
+	hlist_for_each_entry_rcu(neigh_node,
 				 &orig_node->neigh_list, list) {
-		neigh_addr = tmp_neigh_node->addr;
-		is_dup = batadv_test_bit(tmp_neigh_node->bat_iv.real_bits,
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
@@ -1190,15 +1257,14 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
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
@@ -1206,6 +1272,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 			   orig_node->last_real_seqno, seqno);
 		orig_node->last_real_seqno = seqno;
 	}
+	rcu_read_unlock();
 
 out:
 	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
@@ -1223,6 +1290,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	struct batadv_orig_node *orig_neigh_node, *orig_node, *orig_node_tmp;
 	struct batadv_neigh_node *router = NULL, *router_router = NULL;
 	struct batadv_neigh_node *orig_neigh_router = NULL;
+	struct batadv_neigh_node_ifinfo *router_ifinfo = NULL;
 	int has_directlink_flag;
 	int is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
 	int is_bidirect;
@@ -1355,7 +1423,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		return;
 
 	dup_status = batadv_iv_ogm_update_seqnos(ethhdr, batadv_ogm_packet,
-						 if_incoming);
+						 if_incoming, NULL);
 
 	if (dup_status == BATADV_PROTECTED) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
@@ -1376,7 +1444,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		router_router = batadv_orig_node_get_router(orig_node_tmp);
 	}
 
-	if ((router && router->bat_iv.tq_avg != 0) &&
+	if ((router && router_ifinfo->bat_iv.tq_avg != 0) &&
 	    (batadv_compare_eth(router->addr, ethhdr->h_source)))
 		is_from_best_next_hop = true;
 
@@ -1422,7 +1490,8 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	}
 
 	is_bidirect = batadv_iv_ogm_calc_tq(orig_node, orig_neigh_node,
-					    batadv_ogm_packet, if_incoming);
+					    batadv_ogm_packet, if_incoming,
+					    NULL);
 
 	/* update ranking if it is not a duplicate or has the same
 	 * seqno and similar ttl as the non-duplicate
@@ -1433,7 +1502,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 			    (sameseq && similar_ttl)))
 		batadv_iv_ogm_orig_update(bat_priv, orig_node, ethhdr,
 					  batadv_ogm_packet, if_incoming,
-					  tt_buff, dup_status);
+					  NULL, tt_buff, dup_status);
 
 	/* is single hop (direct) neighbor */
 	if (is_single_hop_neigh) {
@@ -1541,6 +1610,7 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	int last_seen_msecs, last_seen_secs;
 	struct batadv_orig_node *orig_node;
+	struct batadv_neigh_node_ifinfo *neigh_ifinfo;
 	unsigned long last_seen_jiffies;
 	struct hlist_head *head;
 	int batman_count = 0;
@@ -1559,7 +1629,12 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
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
@@ -1569,15 +1644,20 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 
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
@@ -1597,34 +1677,50 @@ next:
  * batadv_iv_ogm_neigh_cmp - compare the metrics of two neighbors
  * @neigh1: the first neighbor object of the comparison
  * @neigh2: the second neighbor object of the comparison
+ * @if_outgoing: outgoing interface for the comparison
  *
  * Returns a value less, equal to or greater than 0 if the metric via neigh1 is
  * lower, the same as or higher than the metric via neigh2
  */
 static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
-				   struct batadv_neigh_node *neigh2)
+				   struct batadv_neigh_node *neigh2,
+				   struct batadv_hard_iface *if_outgoing)
 {
+	struct batadv_neigh_node_ifinfo *neigh1_ifinfo, *neigh2_ifinfo;
 	uint8_t tq1, tq2;
 
-	tq1 = neigh1->bat_iv.tq_avg;
-	tq2 = neigh2->bat_iv.tq_avg;
+	neigh1_ifinfo = batadv_neigh_node_get_ifinfo(neigh1, if_outgoing);
+	neigh2_ifinfo = batadv_neigh_node_get_ifinfo(neigh2, if_outgoing);
+
+	if (!neigh1_ifinfo || !neigh2_ifinfo)
+		return 0;
+
+	tq1 = neigh1_ifinfo->bat_iv.tq_avg;
+	tq2 = neigh2_ifinfo->bat_iv.tq_avg;
 
 	return tq1 - tq2;
 }
 
 /**
- * batadv_iv_ogm_neigh_is_eob - check if neigh1 is equally good or better than
- *  neigh2 from the metric prospective
- * @neigh1: the first neighbor object of the comparison
- * @neigh2: the second neighbor object of the comparison
+ * batadv_iv_ogm_neigh_is_eob - check if neigh1_ifinfo is equally good or\
+ *  better than neigh2_ifinfo from the metric prospective
+ * @neigh1_ifinfo: the first neighbor ifinfo object of the comparison
+ * @neigh2_ifinfo: the second neighbor ifinfo object of the comparison
  *
- * Returns true if the metric via neigh1 is equally good or better than the
- * metric via neigh2, false otherwise.
+ * Returns true if the metric via neigh1_ifinfo is equally good or better than
+ * the metric via neigh2_ifinfo, false otherwise.
  */
-static bool batadv_iv_ogm_neigh_is_eob(struct batadv_neigh_node *neigh1,
-				       struct batadv_neigh_node *neigh2)
+static bool
+batadv_iv_ogm_neigh_is_eob(struct batadv_neigh_node_ifinfo *neigh1_ifinfo,
+			   struct batadv_neigh_node_ifinfo *neigh2_ifinfo)
 {
-	int diff = batadv_iv_ogm_neigh_cmp(neigh1, neigh2);
+	uint8_t tq1, tq2;
+	int diff;
+
+	tq1 = neigh1_ifinfo->bat_iv.tq_avg;
+	tq2 = neigh2_ifinfo->bat_iv.tq_avg;
+
+	diff = tq1 - tq2;
 
 	return diff > -BATADV_TQ_SIMILARITY_THRESHOLD;
 }
@@ -1638,7 +1734,7 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.bat_ogm_schedule = batadv_iv_ogm_schedule,
 	.bat_ogm_emit = batadv_iv_ogm_emit,
 	.bat_neigh_cmp = batadv_iv_ogm_neigh_cmp,
-	.bat_neigh_is_equiv_or_better = batadv_iv_ogm_neigh_is_eob,
+	.bat_neigh_ifinfo_is_equiv_or_better = batadv_iv_ogm_neigh_is_eob,
 	.bat_orig_print = batadv_iv_ogm_orig_print,
 	.bat_orig_free = batadv_iv_ogm_orig_free,
 	.bat_orig_add_if = batadv_iv_ogm_orig_add_if,
diff --git a/gateway_client.c b/gateway_client.c
index 7299936..b845ee6 100644
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
@@ -287,8 +303,11 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
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
diff --git a/main.c b/main.c
index 5c5e64b..cd6fac4 100644
--- a/main.c
+++ b/main.c
@@ -504,7 +504,7 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 	    !bat_algo_ops->bat_ogm_schedule ||
 	    !bat_algo_ops->bat_ogm_emit ||
 	    !bat_algo_ops->bat_neigh_cmp ||
-	    !bat_algo_ops->bat_neigh_is_equiv_or_better) {
+	    !bat_algo_ops->bat_neigh_ifinfo_is_equiv_or_better) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
 		ret = -EINVAL;
diff --git a/originator.c b/originator.c
index 919fdc0..52cd618 100644
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
+	spin_lock_bh(&neigh->bat_iv.lq_update_lock);
+	hlist_add_head_rcu(&neigh_ifinfo->list, &neigh->ifinfo_list);
+	spin_unlock_bh(&neigh->bat_iv.lq_update_lock);
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
@@ -193,6 +261,7 @@ batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
 		goto out;
 
 	INIT_HLIST_NODE(&neigh_node->list);
+	INIT_HLIST_HEAD(&neigh_node->ifinfo_list);
 
 	memcpy(neigh_node->addr, neigh_addr, ETH_ALEN);
 	neigh_node->if_incoming = hard_iface;
@@ -364,20 +433,23 @@ free_orig_node:
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
@@ -407,13 +479,6 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 
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
 
@@ -421,6 +486,32 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
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
+		    (bao->bat_neigh_cmp(neigh, best, if_outgoing) <= 0))
+			best = neigh;
+	rcu_read_unlock();
+
+	return best;
+}
+
 static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 				   struct batadv_orig_node *orig_node)
 {
@@ -433,12 +524,12 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
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
index 1198aea..ea4c65d 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1361,7 +1361,7 @@ batadv_transtable_best_orig(struct batadv_priv *bat_priv,
 			continue;
 
 		if (best_router &&
-		    bao->bat_neigh_cmp(router, best_router) <= 0) {
+		    bao->bat_neigh_cmp(router, best_router, NULL) <= 0) {
 			batadv_neigh_node_free_ref(router);
 			continue;
 		}
diff --git a/types.h b/types.h
index ef08333..e830e20 100644
--- a/types.h
+++ b/types.h
@@ -269,32 +269,20 @@ struct batadv_gw_node {
 /**
  * struct batadv_neigh_bat_iv - B.A.T.M.A.N. IV specific structure for single
  *  hop neighbors
- * @tq_recv: ring buffer of received TQ values from this neigh node
- * @tq_index: ring buffer index
- * @tq_avg: averaged tq of all tq values in the ring buffer (tq_recv)
- * @real_bits: bitfield containing the number of OGMs received from this neigh
- *  node (relative to orig_node->last_real_seqno)
- * @real_packet_count: counted result of real_bits
- * @lq_update_lock: lock protecting tq_recv & tq_index
+ * @lq_update_lock: lock protecting tq_recv & tq_index for ifinfo members
  */
 struct batadv_neigh_bat_iv {
-	uint8_t tq_recv[BATADV_TQ_GLOBAL_WINDOW_SIZE];
-	uint8_t tq_index;
-	uint8_t tq_avg;
-	DECLARE_BITMAP(real_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
-	uint8_t real_packet_count;
 	spinlock_t lq_update_lock; /* protects tq_recv & tq_index */
 };
-
 /**
  * struct batadv_neigh_node - structure for single hops neighbors
  * @list: list node for batadv_orig_node::neigh_list
  * @orig_node: pointer to corresponding orig_node
  * @addr: the MAC address of the neighboring interface
+ * @ifinfo_list: list for routing metrics per outgoing interface
  * @if_incoming: pointer to incoming hard interface
  * @last_seen: when last packet via this neighbor was received
  * @last_ttl: last received ttl from this neigh node
- * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  * @bat_iv: B.A.T.M.A.N. IV private structure
  */
@@ -302,14 +290,43 @@ struct batadv_neigh_node {
 	struct hlist_node list;
 	struct batadv_orig_node *orig_node;
 	uint8_t addr[ETH_ALEN];
+	struct hlist_head ifinfo_list;
 	struct batadv_hard_iface *if_incoming;
 	unsigned long last_seen;
-	uint8_t last_ttl;
 	atomic_t refcount;
 	struct rcu_head rcu;
 	struct batadv_neigh_bat_iv bat_iv;
 };
 
+/* struct batadv_neigh_node_ifinfo - neighbor information per outgoing interface
+ *	for BATMAN IV
+ * @tq_recv: ring buffer of received TQ values from this neigh node
+ * @tq_index: ring buffer index
+ * @tq_avg: averaged tq of all tq values in the ring buffer (tq_recv)
+ * @real_bits: bitfield containing the number of OGMs received from this neigh
+ */
+struct batadv_neigh_ifinfo_bat_iv {
+	uint8_t tq_recv[BATADV_TQ_GLOBAL_WINDOW_SIZE];
+	uint8_t tq_index;
+	uint8_t tq_avg;
+	DECLARE_BITMAP(real_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
+	uint8_t real_packet_count;
+};
+
+/* struct batadv_neigh_node_ifinfo - neighbor information per outgoing interface
+ * @list: list node for batadv_orig_node::neigh_list
+ * @if_outgoing: pointer to outgoing hard interface
+ * @last_ttl: last received ttl from this neigh node
+ *  node (relative to orig_node->last_real_seqno)
+ * @rcu: struct used for freeing in an RCU-safe manner
+ */
+struct batadv_neigh_node_ifinfo {
+	struct hlist_node list;
+	struct batadv_hard_iface *if_outgoing;
+	struct batadv_neigh_ifinfo_bat_iv bat_iv;
+	uint8_t last_ttl;
+};
+
 /**
  * struct batadv_bcast_duplist_entry - structure for LAN broadcast suppression
  * @orig[ETH_ALEN]: mac address of orig node orginating the broadcast
@@ -989,9 +1006,10 @@ struct batadv_forw_packet {
  * @bat_primary_iface_set: called when primary interface is selected / changed
  * @bat_ogm_schedule: prepare a new outgoing OGM for the send queue
  * @bat_ogm_emit: send scheduled OGM
- * @bat_neigh_cmp: compare the metrics of two neighbors
- * @bat_neigh_is_equiv_or_better: check if neigh1 is equally good or
- *  better than neigh2 from the metric prospective
+ * @bat_neigh_cmp: compare the metrics of two neighbors for an outgoing
+ *  interface
+ * @bat_neigh_is_equiv_or_better: check if neigh1_ifinfo is equally good or
+ *  better than neigh2_ifinfo from the metric prospective
  * @bat_orig_print: print the originator table (optional)
  * @bat_orig_free: free the resources allocated by the routing algorithm for an
  *  orig_node object
@@ -1010,9 +1028,11 @@ struct batadv_algo_ops {
 	void (*bat_ogm_schedule)(struct batadv_hard_iface *hard_iface);
 	void (*bat_ogm_emit)(struct batadv_forw_packet *forw_packet);
 	int (*bat_neigh_cmp)(struct batadv_neigh_node *neigh1,
-			     struct batadv_neigh_node *neigh2);
-	bool (*bat_neigh_is_equiv_or_better)(struct batadv_neigh_node *neigh1,
-					     struct batadv_neigh_node *neigh2);
+			     struct batadv_neigh_node *neigh2,
+			     struct batadv_hard_iface *if_outgoing);
+	bool (*bat_neigh_ifinfo_is_equiv_or_better)
+		(struct batadv_neigh_node_ifinfo *neigh1_ifinfo,
+		 struct batadv_neigh_node_ifinfo *neigh2_ifinfo);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq);
 	void (*bat_orig_free)(struct batadv_orig_node *orig_node);
-- 
1.7.10.4

