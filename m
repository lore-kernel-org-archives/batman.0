Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 29 May 2013 00:20:40 +0200
Message-Id: <1369779649-2537-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1369779649-2537-1-git-send-email-ordex@autistici.org>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC 01/10] batman-adv: make struct
	batadv_neigh_node algorithm agnostic
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

some of the fields in struct batadv_neigh_node are strictly
related to the B.A.T.M.A.N. IV algorithm. In order to
make the struct usable by any routing algorithm it has to be
split and made more generic

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_iv_ogm.c        | 65 ++++++++++++++++++++++++++++-------------------------
 gateway_client.c    | 16 ++++++-------
 network-coding.c    |  8 ++++---
 originator.c        | 28 ++++++++++++-----------
 originator.h        |  3 ++-
 routing.c           |  9 ++++----
 translation-table.c |  4 ++--
 types.h             | 42 ++++++++++++++++++++--------------
 8 files changed, 96 insertions(+), 79 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 8d87f87..d885aa8 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -76,20 +76,18 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 			struct batadv_orig_node *orig_node,
 			struct batadv_orig_node *orig_neigh)
 {
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_neigh_node *neigh_node;
 
-	neigh_node = batadv_neigh_node_new(hard_iface, neigh_addr);
+	neigh_node = batadv_neigh_node_new(hard_iface, neigh_addr, orig_node);
 	if (!neigh_node)
 		goto out;
 
-	INIT_LIST_HEAD(&neigh_node->bonding_list);
+	spin_lock_init(&neigh_node->bat_iv.lq_update_lock);
 
-	neigh_node->orig_node = orig_neigh;
-	neigh_node->if_incoming = hard_iface;
-
-	spin_lock_bh(&orig_node->neigh_list_lock);
-	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
-	spin_unlock_bh(&orig_node->neigh_list_lock);
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "Creating new neighbor %pM for orig_node %pM on interface %s\n",
+		   neigh_addr, orig_node->orig, hard_iface->net_dev->name);
 
 out:
 	return neigh_node;
@@ -737,12 +735,12 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 		if (is_duplicate)
 			continue;
 
-		spin_lock_bh(&tmp_neigh_node->lq_update_lock);
-		batadv_ring_buffer_set(tmp_neigh_node->tq_recv,
-				       &tmp_neigh_node->tq_index, 0);
-		tq_avg = batadv_ring_buffer_avg(tmp_neigh_node->tq_recv);
-		tmp_neigh_node->tq_avg = tq_avg;
-		spin_unlock_bh(&tmp_neigh_node->lq_update_lock);
+		spin_lock_bh(&tmp_neigh_node->bat_iv.lq_update_lock);
+		batadv_ring_buffer_set(tmp_neigh_node->bat_iv.tq_recv,
+				       &tmp_neigh_node->bat_iv.tq_index, 0);
+		tq_avg = batadv_ring_buffer_avg(tmp_neigh_node->bat_iv.tq_recv);
+		tmp_neigh_node->bat_iv.tq_avg = tq_avg;
+		spin_unlock_bh(&tmp_neigh_node->bat_iv.lq_update_lock);
 	}
 
 	if (!neigh_node) {
@@ -767,12 +765,13 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 
 	neigh_node->last_seen = jiffies;
 
-	spin_lock_bh(&neigh_node->lq_update_lock);
-	batadv_ring_buffer_set(neigh_node->tq_recv,
-			       &neigh_node->tq_index,
+	spin_lock_bh(&neigh_node->bat_iv.lq_update_lock);
+	batadv_ring_buffer_set(neigh_node->bat_iv.tq_recv,
+			       &neigh_node->bat_iv.tq_index,
 			       batadv_ogm_packet->tq);
-	neigh_node->tq_avg = batadv_ring_buffer_avg(neigh_node->tq_recv);
-	spin_unlock_bh(&neigh_node->lq_update_lock);
+	tq_avg = batadv_ring_buffer_avg(neigh_node->bat_iv.tq_recv);
+	neigh_node->bat_iv.tq_avg = tq_avg;
+	spin_unlock_bh(&neigh_node->bat_iv.lq_update_lock);
 
 	if (!is_duplicate) {
 		orig_node->last_ttl = batadv_ogm_packet->header.ttl;
@@ -789,13 +788,13 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 		goto out;
 
 	/* if this neighbor does not offer a better TQ we won't consider it */
-	if (router && (router->tq_avg > neigh_node->tq_avg))
+	if (router && (router->bat_iv.tq_avg > neigh_node->bat_iv.tq_avg))
 		goto out;
 
 	/* if the TQ is the same and the link not more symmetric we
 	 * won't consider it either
 	 */
-	if (router && (neigh_node->tq_avg == router->tq_avg)) {
+	if (router && (neigh_node->bat_iv.tq_avg == router->bat_iv.tq_avg)) {
 		orig_node_tmp = router->orig_node;
 		spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
 		if_num = router->if_incoming->if_num;
@@ -874,7 +873,7 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	/* find packet count of corresponding one hop neighbor */
 	spin_lock_bh(&orig_node->ogm_cnt_lock);
 	orig_eq_count = orig_neigh_node->bcast_own_sum[if_incoming->if_num];
-	neigh_rq_count = neigh_node->real_packet_count;
+	neigh_rq_count = neigh_node->bat_iv.real_packet_count;
 	spin_unlock_bh(&orig_node->ogm_cnt_lock);
 
 	/* pay attention to not get a value bigger than 100 % */
@@ -955,6 +954,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	uint32_t seqno = ntohl(batadv_ogm_packet->seqno);
 	uint8_t *neigh_addr;
 	uint8_t packet_count;
+	unsigned long (*bitmap)[];
 
 	orig_node = batadv_get_orig_node(bat_priv, batadv_ogm_packet->orig);
 	if (!orig_node)
@@ -972,7 +972,8 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tmp_neigh_node,
 				 &orig_node->neigh_list, list) {
-		is_duplicate |= batadv_test_bit(tmp_neigh_node->real_bits,
+		bitmap = &tmp_neigh_node->bat_iv.real_bits;
+		is_duplicate |= batadv_test_bit(*bitmap,
 						orig_node->last_real_seqno,
 						seqno);
 
@@ -984,13 +985,13 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 			set_mark = 0;
 
 		/* if the window moved, set the update flag. */
-		need_update |= batadv_bit_get_packet(bat_priv,
-						     tmp_neigh_node->real_bits,
+		bitmap = &tmp_neigh_node->bat_iv.real_bits;
+		need_update |= batadv_bit_get_packet(bat_priv, *bitmap,
 						     seq_diff, set_mark);
 
-		packet_count = bitmap_weight(tmp_neigh_node->real_bits,
+		packet_count = bitmap_weight(tmp_neigh_node->bat_iv.real_bits,
 					     BATADV_TQ_LOCAL_WINDOW_SIZE);
-		tmp_neigh_node->real_packet_count = packet_count;
+		tmp_neigh_node->bat_iv.real_packet_count = packet_count;
 	}
 	rcu_read_unlock();
 
@@ -1016,7 +1017,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_hard_iface *hard_iface;
-	struct batadv_orig_node *orig_neigh_node, *orig_node;
+	struct batadv_orig_node *orig_neigh_node, *orig_node, *orig_node_tmp;
 	struct batadv_neigh_node *router = NULL, *router_router = NULL;
 	struct batadv_neigh_node *orig_neigh_router = NULL;
 	int has_directlink_flag;
@@ -1166,10 +1167,12 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	}
 
 	router = batadv_orig_node_get_router(orig_node);
-	if (router)
-		router_router = batadv_orig_node_get_router(router->orig_node);
+	if (router) {
+		orig_node_tmp = router->orig_node;
+		router_router = batadv_orig_node_get_router(orig_node_tmp);
+	}
 
-	if ((router && router->tq_avg != 0) &&
+	if ((router && router->bat_iv.tq_avg != 0) &&
 	    (batadv_compare_eth(router->addr, ethhdr->h_source)))
 		is_from_best_next_hop = true;
 
diff --git a/gateway_client.c b/gateway_client.c
index 278e8f6..69488b2 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -137,7 +137,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 		if (!atomic_inc_not_zero(&gw_node->refcount))
 			goto next;
 
-		tq_avg = router->tq_avg;
+		tq_avg = router->bat_iv.tq_avg;
 
 		switch (atomic_read(&bat_priv->gw_sel_class)) {
 		case 1: /* fast connection */
@@ -234,7 +234,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 			   next_gw->bandwidth_down / 10,
 			   next_gw->bandwidth_down % 10,
 			   next_gw->bandwidth_up / 10,
-			   next_gw->bandwidth_up % 10, router->tq_avg);
+			   next_gw->bandwidth_up % 10, router->bat_iv.tq_avg);
 		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_ADD,
 				    gw_addr);
 	} else {
@@ -244,7 +244,7 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 			   next_gw->bandwidth_down / 10,
 			   next_gw->bandwidth_down % 10,
 			   next_gw->bandwidth_up / 10,
-			   next_gw->bandwidth_up % 10, router->tq_avg);
+			   next_gw->bandwidth_up % 10, router->bat_iv.tq_avg);
 		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_CHANGE,
 				    gw_addr);
 	}
@@ -283,8 +283,8 @@ void batadv_gw_check_election(struct batadv_priv *bat_priv,
 	if (!router_orig)
 		goto out;
 
-	gw_tq_avg = router_gw->tq_avg;
-	orig_tq_avg = router_orig->tq_avg;
+	gw_tq_avg = router_gw->bat_iv.tq_avg;
+	orig_tq_avg = router_orig->bat_iv.tq_avg;
 
 	/* the TQ value has to be better */
 	if (orig_tq_avg < gw_tq_avg)
@@ -506,7 +506,7 @@ static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
 	ret = seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %u.%u/%u.%u MBit\n",
 			 (curr_gw == gw_node ? "=>" : "  "),
 			 gw_node->orig_node->orig,
-			 router->tq_avg, router->addr,
+			 router->bat_iv.tq_avg, router->addr,
 			 router->if_incoming->net_dev->name,
 			 gw_node->bandwidth_down / 10,
 			 gw_node->bandwidth_down % 10,
@@ -759,7 +759,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 		if (!neigh_curr)
 			goto out;
 
-		curr_tq_avg = neigh_curr->tq_avg;
+		curr_tq_avg = neigh_curr->bat_iv.tq_avg;
 		break;
 	case BATADV_GW_MODE_OFF:
 	default:
@@ -770,7 +770,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 	if (!neigh_old)
 		goto out;
 
-	if (curr_tq_avg - neigh_old->tq_avg > BATADV_GW_THRESHOLD)
+	if (curr_tq_avg - neigh_old->bat_iv.tq_avg > BATADV_GW_THRESHOLD)
 		out_of_range = true;
 
 out:
diff --git a/network-coding.c b/network-coding.c
index ef88a1f..173a96e 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -994,7 +994,7 @@ static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
 				   struct batadv_nc_packet *nc_packet,
 				   struct batadv_neigh_node *neigh_node)
 {
-	uint8_t tq_weighted_neigh, tq_weighted_coding;
+	uint8_t tq_weighted_neigh, tq_weighted_coding, tq_tmp;
 	struct sk_buff *skb_dest, *skb_src;
 	struct batadv_unicast_packet *packet1;
 	struct batadv_unicast_packet *packet2;
@@ -1019,8 +1019,10 @@ static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
 	if (!router_coding)
 		goto out;
 
-	tq_weighted_neigh = batadv_nc_random_weight_tq(router_neigh->tq_avg);
-	tq_weighted_coding = batadv_nc_random_weight_tq(router_coding->tq_avg);
+	tq_tmp = batadv_nc_random_weight_tq(router_neigh->bat_iv.tq_avg);
+	tq_weighted_neigh = tq_tmp;
+	tq_tmp = batadv_nc_random_weight_tq(router_coding->bat_iv.tq_avg);
+	tq_weighted_coding = tq_tmp;
 
 	/* Select one destination for the MAC-header dst-field based on
 	 * weighted TQ-values.
diff --git a/originator.c b/originator.c
index c878a00..3d312de 100644
--- a/originator.c
+++ b/originator.c
@@ -174,27 +174,28 @@ batadv_orig_node_get_router(struct batadv_orig_node *orig_node)
 
 struct batadv_neigh_node *
 batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
-		      const uint8_t *neigh_addr)
+		      const uint8_t *neigh_addr,
+		      struct batadv_orig_node *orig_node)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct batadv_neigh_node *neigh_node;
 
 	neigh_node = kzalloc(sizeof(*neigh_node), GFP_ATOMIC);
 	if (!neigh_node)
 		goto out;
 
-	INIT_HLIST_NODE(&neigh_node->list);
-
 	memcpy(neigh_node->addr, neigh_addr, ETH_ALEN);
-	spin_lock_init(&neigh_node->lq_update_lock);
+	neigh_node->if_incoming = hard_iface;
+	neigh_node->orig_node = orig_node;
+
+	spin_lock_bh(&orig_node->neigh_list_lock);
+	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+
+	INIT_LIST_HEAD(&neigh_node->bonding_list);
 
 	/* extra reference for return */
 	atomic_set(&neigh_node->refcount, 2);
 
-	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "Creating new neighbor %pM on interface %s\n", neigh_addr,
-		   hard_iface->net_dev->name);
-
 out:
 	return neigh_node;
 }
@@ -432,7 +433,8 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 			batadv_neigh_node_free_ref(neigh_node);
 		} else {
 			if ((!*best_neigh_node) ||
-			    (neigh_node->tq_avg > (*best_neigh_node)->tq_avg))
+			    (neigh_node->bat_iv.tq_avg >
+			     (*best_neigh_node)->bat_iv.tq_avg))
 				*best_neigh_node = neigh_node;
 		}
 	}
@@ -553,7 +555,7 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 			if (!neigh_node)
 				continue;
 
-			if (neigh_node->tq_avg == 0)
+			if (neigh_node->bat_iv.tq_avg == 0)
 				goto next;
 
 			last_seen_jiffies = jiffies - orig_node->last_seen;
@@ -563,7 +565,7 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 
 			seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
 				   orig_node->orig, last_seen_secs,
-				   last_seen_msecs, neigh_node->tq_avg,
+				   last_seen_msecs, neigh_node->bat_iv.tq_avg,
 				   neigh_node->addr,
 				   neigh_node->if_incoming->net_dev->name);
 
@@ -571,7 +573,7 @@ int batadv_orig_seq_print_text(struct seq_file *seq, void *offset)
 						 &orig_node->neigh_list, list) {
 				seq_printf(seq, " %pM (%3i)",
 					   neigh_node_tmp->addr,
-					   neigh_node_tmp->tq_avg);
+					   neigh_node_tmp->bat_iv.tq_avg);
 			}
 
 			seq_puts(seq, "\n");
diff --git a/originator.h b/originator.h
index cc6d686..06e5a68 100644
--- a/originator.h
+++ b/originator.h
@@ -31,7 +31,8 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 					      const uint8_t *addr);
 struct batadv_neigh_node *
 batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
-		      const uint8_t *neigh_addr);
+		      const uint8_t *neigh_addr,
+		      struct batadv_orig_node *orig_node);
 void batadv_neigh_node_free_ref(struct batadv_neigh_node *neigh_node);
 struct batadv_neigh_node *
 batadv_orig_node_get_router(struct batadv_orig_node *orig_node);
diff --git a/routing.c b/routing.c
index 2b35205..99f6844 100644
--- a/routing.c
+++ b/routing.c
@@ -133,7 +133,8 @@ void batadv_bonding_candidate_add(struct batadv_orig_node *orig_node,
 		goto candidate_del;
 
 	/* ... and is good enough to be considered */
-	if (neigh_node->tq_avg < router->tq_avg - BATADV_BONDING_TQ_THRESHOLD)
+	if (neigh_node->bat_iv.tq_avg <
+	    router->bat_iv.tq_avg - BATADV_BONDING_TQ_THRESHOLD)
 		goto candidate_del;
 
 	/* check if we have another candidate with the same mac address or
@@ -470,8 +471,7 @@ batadv_find_bond_router(struct batadv_orig_node *primary_orig,
 	 * does not exist as rcu version
 	 */
 	list_del_rcu(&primary_orig->bond_list);
-	list_add_rcu(&primary_orig->bond_list,
-		     &router->bonding_list);
+	list_add_rcu(&primary_orig->bond_list, &router->bonding_list);
 	spin_unlock_bh(&primary_orig->neigh_list_lock);
 
 out:
@@ -502,7 +502,8 @@ batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
 		if (tmp_neigh_node->if_incoming == recv_if)
 			continue;
 
-		if (router && tmp_neigh_node->tq_avg <= router->tq_avg)
+		if (router &&
+		    tmp_neigh_node->bat_iv.tq_avg <= router->bat_iv.tq_avg)
 			continue;
 
 		if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
diff --git a/translation-table.c b/translation-table.c
index 9401ca8..a256cdb 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1229,9 +1229,9 @@ batadv_transtable_best_orig(struct batadv_tt_global_entry *tt_global_entry)
 		if (!router)
 			continue;
 
-		if (router->tq_avg > best_tq) {
+		if (router->bat_iv.tq_avg > best_tq) {
 			best_entry = orig_entry;
-			best_tq = router->tq_avg;
+			best_tq = router->bat_iv.tq_avg;
 		}
 
 		batadv_neigh_node_free_ref(router);
diff --git a/types.h b/types.h
index a4d6d9f..c7d5fa1 100644
--- a/types.h
+++ b/types.h
@@ -257,40 +257,48 @@ struct batadv_gw_node {
 };
 
 /**
- * struct batadv_neigh_node - structure for single hop neighbors
- * @list: list node for batadv_orig_node::neigh_list
- * @addr: mac address of neigh node
+ * struct batadv_neigh_bat_iv - structure for single hop neighbors
  * @tq_recv: ring buffer of received TQ values from this neigh node
  * @tq_index: ring buffer index
  * @tq_avg: averaged tq of all tq values in the ring buffer (tq_recv)
- * @last_ttl: last received ttl from this neigh node
- * @bonding_list: list node for batadv_orig_node::bond_list
- * @last_seen: when last packet via this neighbor was received
  * @real_bits: bitfield containing the number of OGMs received from this neigh
  *  node (relative to orig_node->last_real_seqno)
  * @real_packet_count: counted result of real_bits
- * @orig_node: pointer to corresponding orig_node
- * @if_incoming: pointer to incoming hard interface
  * @lq_update_lock: lock protecting tq_recv & tq_index
  * @refcount: number of contexts the object is used
- * @rcu: struct used for freeing in an RCU-safe manner
  */
-struct batadv_neigh_node {
-	struct hlist_node list;
-	uint8_t addr[ETH_ALEN];
+struct batadv_neigh_bat_iv {
 	uint8_t tq_recv[BATADV_TQ_GLOBAL_WINDOW_SIZE];
 	uint8_t tq_index;
 	uint8_t tq_avg;
-	uint8_t last_ttl;
-	struct list_head bonding_list;
-	unsigned long last_seen;
 	DECLARE_BITMAP(real_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 	uint8_t real_packet_count;
-	struct batadv_orig_node *orig_node;
-	struct batadv_hard_iface *if_incoming;
 	spinlock_t lq_update_lock; /* protects tq_recv & tq_index */
+};
+
+/**
+ * struct batadv_neigh_node - structure for single hops neighbors
+ * @list: list node for batadv_orig_node::neigh_list
+ * @orig_node: pointer to corresponding orig_node
+ * @addr: the MAC address of the neighboring interface
+ * @if_incoming: pointer to incoming hard interface
+ * @last_seen: when last packet via this neighbor was received
+ * @last_ttl: last received ttl from this neigh node
+ * @bonding_list: list node for batadv_orig_node::bond_list
+ * @rcu: struct used for freeing in an RCU-safe manner
+ * @priv: pointer to the routing algorithm private data
+ */
+struct batadv_neigh_node {
+	struct hlist_node list;
+	struct batadv_orig_node *orig_node;
+	uint8_t addr[ETH_ALEN];
+	struct batadv_hard_iface *if_incoming;
+	unsigned long last_seen;
+	uint8_t last_ttl;
+	struct list_head bonding_list;
 	atomic_t refcount;
 	struct rcu_head rcu;
+	struct batadv_neigh_bat_iv bat_iv;
 };
 
 /**
-- 
1.8.1.5

