Return-Path: <daniele.furlan@gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Date: Thu, 17 Nov 2011 16:53:49 +0100
Message-Id: <1321545233-32676-1-git-send-email-daniele.furlan@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/5] Rename 'tq_avg' field of struct
	'neigh_node' in 'tq'.
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

 This patch rename the 'tq_avg' field of struct 'neigh_node' in 'tq'.
 This will reflect the absence of an averaging of tq values.

Signed-off-by: Daniele Furlan <daniele.furlan@gmail.com>
---
 bat_iv_ogm.c     |   20 ++++++++++----------
 gateway_client.c |   36 ++++++++++++++++++------------------
 originator.c     |    8 ++++----
 routing.c        |    4 ++--
 types.h          |    2 +-
 vis.c            |    8 ++++----
 6 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 3512e25..d39938c 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -468,7 +468,7 @@ static void bat_ogm_forward(struct orig_node *orig_node,
 {
 	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct neigh_node *router;
-	uint8_t in_tq, in_ttl, tq_avg = 0;
+	uint8_t in_tq, in_ttl, tq = 0;
 	uint8_t tt_num_changes;
 
 	if (batman_ogm_packet->ttl <= 1) {
@@ -487,17 +487,17 @@ static void bat_ogm_forward(struct orig_node *orig_node,
 
 	/* rebroadcast tq of our best ranking neighbor to ensure the rebroadcast
 	 * of our best tq value */
-	if (router && router->tq_avg != 0) {
+	if (router && router->tq != 0) {
 
 		/* rebroadcast ogm of best ranking neighbor as is */
 		if (!compare_eth(router->addr, ethhdr->h_source)) {
-			batman_ogm_packet->tq = router->tq_avg;
+			batman_ogm_packet->tq = router->tq;
 
 			if (router->last_ttl)
 				batman_ogm_packet->ttl = router->last_ttl - 1;
 		}
 
-		tq_avg = router->tq_avg;
+		tq = router->tq;
 	}
 
 	if (router)
@@ -507,9 +507,9 @@ static void bat_ogm_forward(struct orig_node *orig_node,
 	batman_ogm_packet->tq = hop_penalty(batman_ogm_packet->tq, bat_priv);
 
 	bat_dbg(DBG_BATMAN, bat_priv,
-		"Forwarding packet: tq_orig: %i, tq_avg: %i, "
+		"Forwarding packet: tq_orig: %i, tq: %i, "
 		"tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
-		in_tq, tq_avg, batman_ogm_packet->tq, in_ttl - 1,
+		in_tq, tq, batman_ogm_packet->tq, in_ttl - 1,
 		batman_ogm_packet->ttl);
 
 	batman_ogm_packet->seqno = htonl(batman_ogm_packet->seqno);
@@ -607,7 +607,7 @@ static void bat_ogm_orig_update(struct bat_priv *bat_priv,
 		spin_lock_bh(&tmp_neigh_node->tq_lock);
 		ring_buffer_set(tmp_neigh_node->tq_recv,
 				&tmp_neigh_node->tq_index, 0);
-		tmp_neigh_node->tq_avg =
+		tmp_neigh_node->tq =
 			ring_buffer_avg(tmp_neigh_node->tq_recv);
 		spin_unlock_bh(&tmp_neigh_node->tq_lock);
 	}
@@ -638,7 +638,7 @@ static void bat_ogm_orig_update(struct bat_priv *bat_priv,
 	ring_buffer_set(neigh_node->tq_recv,
 			&neigh_node->tq_index,
 			batman_ogm_packet->tq);
-	neigh_node->tq_avg = ring_buffer_avg(neigh_node->tq_recv);
+	neigh_node->tq = ring_buffer_avg(neigh_node->tq_recv);
 	spin_unlock_bh(&neigh_node->tq_lock);
 
 	if (!is_duplicate) {
@@ -655,12 +655,12 @@ static void bat_ogm_orig_update(struct bat_priv *bat_priv,
 		goto update_tt;
 
 	/* if this neighbor does not offer a better TQ we won't consider it */
-	if (router && (router->tq_avg > neigh_node->tq_avg))
+	if (router && (router->tq > neigh_node->tq))
 		goto update_tt;
 
 	/* if the TQ is the same and the link not more symmetric we
 	 * won't consider it either */
-	if (router && (neigh_node->tq_avg == router->tq_avg)) {
+	if (router && (neigh_node->tq == router->tq)) {
 		orig_node_tmp = router->orig_node;
 		spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
 		bcast_own_sum_orig =
diff --git a/gateway_client.c b/gateway_client.c
index 9373a14..f84fc2d 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -134,14 +134,14 @@ static struct gw_node *gw_get_best_gw_node(struct bat_priv *bat_priv)
 			gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags,
 					     &down, &up);
 
-			tmp_gw_factor = (router->tq_avg * router->tq_avg *
+			tmp_gw_factor = (router->tq * router->tq *
 					 down * 100 * 100) /
 					 (TQ_LOCAL_WINDOW_SIZE *
 					 TQ_LOCAL_WINDOW_SIZE * 64);
 
 			if ((tmp_gw_factor > max_gw_factor) ||
 			    ((tmp_gw_factor == max_gw_factor) &&
-			     (router->tq_avg > max_tq))) {
+			     (router->tq > max_tq))) {
 				if (curr_gw)
 					gw_node_free_ref(curr_gw);
 				curr_gw = gw_node;
@@ -157,7 +157,7 @@ static struct gw_node *gw_get_best_gw_node(struct bat_priv *bat_priv)
 			  *     soon as a better gateway appears which has
 			  *     $routing_class more tq points)
 			  **/
-			if (router->tq_avg > max_tq) {
+			if (router->tq > max_tq) {
 				if (curr_gw)
 					gw_node_free_ref(curr_gw);
 				curr_gw = gw_node;
@@ -166,8 +166,8 @@ static struct gw_node *gw_get_best_gw_node(struct bat_priv *bat_priv)
 			break;
 		}
 
-		if (router->tq_avg > max_tq)
-			max_tq = router->tq_avg;
+		if (router->tq > max_tq)
+			max_tq = router->tq;
 
 		if (tmp_gw_factor > max_gw_factor)
 			max_gw_factor = tmp_gw_factor;
@@ -226,7 +226,7 @@ void gw_election(struct bat_priv *bat_priv)
 			"Adding route to gateway %pM (gw_flags: %i, tq: %i)\n",
 			next_gw->orig_node->orig,
 			next_gw->orig_node->gw_flags,
-			router->tq_avg);
+			router->tq);
 		throw_uevent(bat_priv, UEV_GW, UEV_ADD, gw_addr);
 	} else {
 		bat_dbg(DBG_BATMAN, bat_priv,
@@ -234,7 +234,7 @@ void gw_election(struct bat_priv *bat_priv)
 			"(gw_flags: %i, tq: %i)\n",
 			next_gw->orig_node->orig,
 			next_gw->orig_node->gw_flags,
-			router->tq_avg);
+			router->tq);
 		throw_uevent(bat_priv, UEV_GW, UEV_CHANGE, gw_addr);
 	}
 
@@ -253,7 +253,7 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 {
 	struct orig_node *curr_gw_orig;
 	struct neigh_node *router_gw = NULL, *router_orig = NULL;
-	uint8_t gw_tq_avg, orig_tq_avg;
+	uint8_t gw_tq, orig_tq;
 
 	curr_gw_orig = gw_get_selected_orig(bat_priv);
 	if (!curr_gw_orig)
@@ -271,11 +271,11 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 	if (!router_orig)
 		goto out;
 
-	gw_tq_avg = router_gw->tq_avg;
-	orig_tq_avg = router_orig->tq_avg;
+	gw_tq = router_gw->tq;
+	orig_tq = router_orig->tq;
 
 	/* the TQ value has to be better */
-	if (orig_tq_avg < gw_tq_avg)
+	if (orig_tq < gw_tq)
 		goto out;
 
 	/**
@@ -283,13 +283,13 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 	 * greater the TQ value of the new gateway must be
 	 **/
 	if ((atomic_read(&bat_priv->gw_sel_class) > 3) &&
-	    (orig_tq_avg - gw_tq_avg < atomic_read(&bat_priv->gw_sel_class)))
+	    (orig_tq - gw_tq < atomic_read(&bat_priv->gw_sel_class)))
 		goto out;
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Restarting gateway selection: better gateway found (tq curr: "
 		"%i, tq new: %i)\n",
-		gw_tq_avg, orig_tq_avg);
+		gw_tq, orig_tq);
 
 deselect:
 	gw_deselect(bat_priv);
@@ -448,7 +448,7 @@ static int _write_buffer_text(struct bat_priv *bat_priv, struct seq_file *seq,
 	ret = seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %3i - %i%s/%i%s\n",
 			 (curr_gw == gw_node ? "=>" : "  "),
 			 gw_node->orig_node->orig,
-			 router->tq_avg, router->addr,
+			 router->tq, router->addr,
 			 router->if_incoming->net_dev->name,
 			 gw_node->orig_node->gw_flags,
 			 (down > 2048 ? down / 1024 : down),
@@ -647,7 +647,7 @@ bool gw_out_of_range(struct bat_priv *bat_priv,
 	struct gw_node *curr_gw = NULL;
 	bool ret, out_of_range = false;
 	unsigned int header_len = 0;
-	uint8_t curr_tq_avg;
+	uint8_t curr_tq;
 
 	ret = gw_is_dhcp_target(skb, &header_len);
 	if (!ret)
@@ -669,7 +669,7 @@ bool gw_out_of_range(struct bat_priv *bat_priv,
 	case GW_MODE_SERVER:
 		/* If we are a GW then we are our best GW. We can artificially
 		 * set the tq towards ourself as the maximum value */
-		curr_tq_avg = TQ_MAX_VALUE;
+		curr_tq = TQ_MAX_VALUE;
 		break;
 	case GW_MODE_CLIENT:
 		curr_gw = gw_get_selected_gw_node(bat_priv);
@@ -687,7 +687,7 @@ bool gw_out_of_range(struct bat_priv *bat_priv,
 		if (!neigh_curr)
 			goto out;
 
-		curr_tq_avg = neigh_curr->tq_avg;
+		curr_tq = neigh_curr->tq;
 		break;
 	case GW_MODE_OFF:
 	default:
@@ -698,7 +698,7 @@ bool gw_out_of_range(struct bat_priv *bat_priv,
 	if (!!neigh_old)
 		goto out;
 
-	if (curr_tq_avg - neigh_old->tq_avg > GW_THRESHOLD)
+	if (curr_tq - neigh_old->tq > GW_THRESHOLD)
 		out_of_range = true;
 
 out:
diff --git a/originator.c b/originator.c
index 0bc2045..99ede46 100644
--- a/originator.c
+++ b/originator.c
@@ -312,7 +312,7 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 			neigh_node_free_ref(neigh_node);
 		} else {
 			if ((!*best_neigh_node) ||
-			    (neigh_node->tq_avg > (*best_neigh_node)->tq_avg))
+			    (neigh_node->tq > (*best_neigh_node)->tq))
 				*best_neigh_node = neigh_node;
 		}
 	}
@@ -448,7 +448,7 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 			if (!neigh_node)
 				continue;
 
-			if (neigh_node->tq_avg == 0)
+			if (neigh_node->tq == 0)
 				goto next;
 
 			last_seen_secs = jiffies_to_msecs(jiffies -
@@ -458,7 +458,7 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 
 			seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
 				   orig_node->orig, last_seen_secs,
-				   last_seen_msecs, neigh_node->tq_avg,
+				   last_seen_msecs, neigh_node->tq,
 				   neigh_node->addr,
 				   neigh_node->if_incoming->net_dev->name);
 
@@ -466,7 +466,7 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 						 &orig_node->neigh_list, list) {
 				seq_printf(seq, " %pM (%3i)",
 					   neigh_node_tmp->addr,
-					   neigh_node_tmp->tq_avg);
+					   neigh_node_tmp->tq);
 			}
 
 			seq_printf(seq, "\n");
diff --git a/routing.c b/routing.c
index ef24a72..d76867e 100644
--- a/routing.c
+++ b/routing.c
@@ -160,7 +160,7 @@ void bonding_candidate_add(struct orig_node *orig_node,
 		goto candidate_del;
 
 	/* ... and is good enough to be considered */
-	if (neigh_node->tq_avg < router->tq_avg - BONDING_TQ_THRESHOLD)
+	if (neigh_node->tq < router->tq - BONDING_TQ_THRESHOLD)
 		goto candidate_del;
 
 	/**
@@ -552,7 +552,7 @@ static struct neigh_node *find_ifalter_router(struct orig_node *primary_orig,
 		/* if we don't have a router yet
 		 * or this one is better, choose it. */
 		if ((!router) ||
-		    (tmp_neigh_node->tq_avg > router->tq_avg)) {
+		    (tmp_neigh_node->tq > router->tq)) {
 			/* decrement refcount of
 			 * previously selected router */
 			if (router)
diff --git a/types.h b/types.h
index e9eb043..84b9c59 100644
--- a/types.h
+++ b/types.h
@@ -127,7 +127,7 @@ struct neigh_node {
 	uint8_t real_packet_count;
 	uint8_t tq_recv[TQ_GLOBAL_WINDOW_SIZE];
 	uint8_t tq_index;
-	uint8_t tq_avg;
+	uint8_t tq;
 	uint8_t last_ttl;
 	struct list_head bonding_list;
 	unsigned long last_valid;
diff --git a/vis.c b/vis.c
index cc3b9f2..6e155a4 100644
--- a/vis.c
+++ b/vis.c
@@ -572,8 +572,8 @@ static int find_best_vis_server(struct bat_priv *bat_priv,
 				continue;
 
 			if ((orig_node->flags & VIS_SERVER) &&
-			    (router->tq_avg > best_tq)) {
-				best_tq = router->tq_avg;
+			    (router->tq > best_tq)) {
+				best_tq = router->tq;
 				memcpy(packet->target_orig, orig_node->orig,
 				       ETH_ALEN);
 			}
@@ -644,7 +644,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 			if (router->if_incoming->if_status != IF_ACTIVE)
 				goto next;
 
-			if (router->tq_avg < 1)
+			if (router->tq < 1)
 				goto next;
 
 			/* fill one entry into buffer. */
@@ -654,7 +654,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 			       router->if_incoming->net_dev->dev_addr,
 			       ETH_ALEN);
 			memcpy(entry->dest, orig_node->orig, ETH_ALEN);
-			entry->quality = router->tq_avg;
+			entry->quality = router->tq;
 			packet->entries++;
 
 next:
-- 
1.7.1

