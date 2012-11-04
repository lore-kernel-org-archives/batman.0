Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  4 Nov 2012 15:19:58 +0100
Message-Id: <1352038798-29658-4-git-send-email-sven@narfation.org>
In-Reply-To: <1352038798-29658-1-git-send-email-sven@narfation.org>
References: <1352038798-29658-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC 4/4] batman-adv: Use compare_ether_addr instead
	of private function
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

COMPAT_VERSION 15 provides correctly (2 bytes boundary) aligned address fields.
This allows the usage of compare_ether_addr instead of the memcmp based
batadv_compare_eth.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Btw. this one also builds...

 bat_iv_ogm.c            |   24 ++++++++++++------------
 bridge_loop_avoidance.c |   28 ++++++++++++++--------------
 distributed-arp-table.c |    4 ++--
 hard-interface.c        |    2 +-
 main.c                  |    2 +-
 main.h                  |    9 ---------
 originator.h            |    2 +-
 routing.c               |   10 +++++-----
 soft-interface.c        |    4 ++--
 translation-table.c     |   15 +++++++++------
 vis.c                   |   14 +++++++-------
 11 files changed, 54 insertions(+), 60 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 9cc7a81..8978a5f 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -670,7 +670,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	hlist_for_each_entry_rcu(tmp_neigh_node, node,
 				 &orig_node->neigh_list, list) {
 		neigh_addr = tmp_neigh_node->addr;
-		if (batadv_compare_eth(neigh_addr, ethhdr->h_source) &&
+		if (compare_ether_addr(neigh_addr, ethhdr->h_source) &&
 		    tmp_neigh_node->if_incoming == if_incoming &&
 		    atomic_inc_not_zero(&tmp_neigh_node->refcount)) {
 			if (neigh_node)
@@ -815,7 +815,7 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	hlist_for_each_entry_rcu(tmp_neigh_node, node,
 				 &orig_neigh_node->neigh_list, list) {
 
-		if (!batadv_compare_eth(tmp_neigh_node->addr,
+		if (!compare_ether_addr(tmp_neigh_node->addr,
 					orig_neigh_node->orig))
 			continue;
 
@@ -954,7 +954,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 						seqno);
 
 		neigh_addr = tmp_neigh_node->addr;
-		if (batadv_compare_eth(neigh_addr, ethhdr->h_source) &&
+		if (compare_ether_addr(neigh_addr, ethhdr->h_source) &&
 		    tmp_neigh_node->if_incoming == if_incoming)
 			set_mark = 1;
 		else
@@ -1028,7 +1028,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	else
 		has_directlink_flag = 0;
 
-	if (batadv_compare_eth(ethhdr->h_source, batadv_ogm_packet->orig))
+	if (compare_ether_addr(ethhdr->h_source, batadv_ogm_packet->orig))
 		is_single_hop_neigh = true;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
@@ -1050,15 +1050,15 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		if (hard_iface->soft_iface != if_incoming->soft_iface)
 			continue;
 
-		if (batadv_compare_eth(ethhdr->h_source,
+		if (compare_ether_addr(ethhdr->h_source,
 				       hard_iface->net_dev->dev_addr))
 			is_my_addr = 1;
 
-		if (batadv_compare_eth(batadv_ogm_packet->orig,
+		if (compare_ether_addr(batadv_ogm_packet->orig,
 				       hard_iface->net_dev->dev_addr))
 			is_my_orig = 1;
 
-		if (batadv_compare_eth(batadv_ogm_packet->prev_sender,
+		if (compare_ether_addr(batadv_ogm_packet->prev_sender,
 				       hard_iface->net_dev->dev_addr))
 			is_my_oldorig = 1;
 
@@ -1105,7 +1105,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		 * save packet seqno for bidirectional check
 		 */
 		if (has_directlink_flag &&
-		    batadv_compare_eth(if_incoming->net_dev->dev_addr,
+		    compare_ether_addr(if_incoming->net_dev->dev_addr,
 				       batadv_ogm_packet->orig)) {
 			if_num = if_incoming->if_num;
 			offset = if_num * BATADV_NUM_WORDS;
@@ -1166,15 +1166,15 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		router_router = batadv_orig_node_get_router(router->orig_node);
 
 	if ((router && router->tq_avg != 0) &&
-	    (batadv_compare_eth(router->addr, ethhdr->h_source)))
+	    (compare_ether_addr(router->addr, ethhdr->h_source)))
 		is_from_best_next_hop = true;
 
 	prev_sender = batadv_ogm_packet->prev_sender;
 	/* avoid temporary routing loops */
 	if (router && router_router &&
-	    (batadv_compare_eth(router->addr, prev_sender)) &&
-	    !(batadv_compare_eth(batadv_ogm_packet->orig, prev_sender)) &&
-	    (batadv_compare_eth(router->addr, router_router->addr))) {
+	    (compare_ether_addr(router->addr, prev_sender)) &&
+	    !(compare_ether_addr(batadv_ogm_packet->orig, prev_sender)) &&
+	    (compare_ether_addr(router->addr, router_router->addr))) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %pM)\n",
 			   ethhdr->h_source);
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index b6da6ae..fd34954 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -692,13 +692,13 @@ static int batadv_handle_request(struct batadv_priv *bat_priv,
 				 struct ethhdr *ethhdr, short vid)
 {
 	/* check for REQUEST frame */
-	if (!batadv_compare_eth(backbone_addr, ethhdr->h_dest))
+	if (!compare_ether_addr(backbone_addr, ethhdr->h_dest))
 		return 0;
 
 	/* sanity check, this should not happen on a normal switch,
 	 * we ignore it in this case.
 	 */
-	if (!batadv_compare_eth(ethhdr->h_dest, primary_if->net_dev->dev_addr))
+	if (!compare_ether_addr(ethhdr->h_dest, primary_if->net_dev->dev_addr))
 		return 1;
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
@@ -718,7 +718,7 @@ static int batadv_handle_unclaim(struct batadv_priv *bat_priv,
 	struct batadv_backbone_gw *backbone_gw;
 
 	/* unclaim in any case if it is our own */
-	if (primary_if && batadv_compare_eth(backbone_addr,
+	if (primary_if && compare_ether_addr(backbone_addr,
 					     primary_if->net_dev->dev_addr))
 		batadv_bla_send_claim(bat_priv, claim_addr, vid,
 				      BATADV_CLAIM_TYPE_UNCLAIM);
@@ -756,7 +756,7 @@ static int batadv_handle_claim(struct batadv_priv *bat_priv,
 
 	/* this must be a CLAIM frame */
 	batadv_bla_add_claim(bat_priv, claim_addr, vid, backbone_gw);
-	if (batadv_compare_eth(backbone_addr, primary_if->net_dev->dev_addr))
+	if (compare_ether_addr(backbone_addr, primary_if->net_dev->dev_addr))
 		batadv_bla_send_claim(bat_priv, claim_addr, vid,
 				      BATADV_CLAIM_TYPE_CLAIM);
 
@@ -816,7 +816,7 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 	}
 
 	/* don't accept claim frames from ourselves */
-	if (batadv_compare_eth(backbone_addr, primary_if->net_dev->dev_addr))
+	if (compare_ether_addr(backbone_addr, primary_if->net_dev->dev_addr))
 		return 0;
 
 	/* if its already the same group, it is fine. */
@@ -1030,7 +1030,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 		hlist_for_each_entry_rcu(claim, node, head, hash_entry) {
 			if (now)
 				goto purge_now;
-			if (!batadv_compare_eth(claim->backbone_gw->orig,
+			if (!compare_ether_addr(claim->backbone_gw->orig,
 						primary_if->net_dev->dev_addr))
 				continue;
 			if (!batadv_has_timed_out(claim->lasttime,
@@ -1089,7 +1089,7 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, node, head, hash_entry) {
 			/* own orig still holds the old value. */
-			if (!batadv_compare_eth(backbone_gw->orig,
+			if (!compare_ether_addr(backbone_gw->orig,
 						oldif->net_dev->dev_addr))
 				continue;
 
@@ -1152,7 +1152,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, node, head, hash_entry) {
-			if (!batadv_compare_eth(backbone_gw->orig,
+			if (!compare_ether_addr(backbone_gw->orig,
 						primary_if->net_dev->dev_addr))
 				continue;
 
@@ -1290,7 +1290,7 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 		if (entry->crc != crc)
 			continue;
 
-		if (batadv_compare_eth(entry->orig, bcast_packet->orig))
+		if (compare_ether_addr(entry->orig, bcast_packet->orig))
 			continue;
 
 		/* this entry seems to match: same crc, not too old,
@@ -1344,7 +1344,7 @@ int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(backbone_gw, node, head, hash_entry) {
-			if (batadv_compare_eth(backbone_gw->orig, orig)) {
+			if (compare_ether_addr(backbone_gw->orig, orig)) {
 				rcu_read_unlock();
 				return 1;
 			}
@@ -1476,7 +1476,7 @@ int batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid,
 	}
 
 	/* if it is our own claim ... */
-	if (batadv_compare_eth(claim->backbone_gw->orig,
+	if (compare_ether_addr(claim->backbone_gw->orig,
 			       primary_if->net_dev->dev_addr)) {
 		/* ... allow it in any case */
 		claim->lasttime = jiffies;
@@ -1570,7 +1570,7 @@ int batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid)
 		goto allow;
 
 	/* check if we are responsible. */
-	if (batadv_compare_eth(claim->backbone_gw->orig,
+	if (compare_ether_addr(claim->backbone_gw->orig,
 			       primary_if->net_dev->dev_addr)) {
 		/* if yes, the client has roamed and we have
 		 * to unclaim it.
@@ -1636,7 +1636,7 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, node, head, hash_entry) {
-			is_own = batadv_compare_eth(claim->backbone_gw->orig,
+			is_own = compare_ether_addr(claim->backbone_gw->orig,
 						    primary_addr);
 			seq_printf(seq,	" * %pM on % 5d by %pM [%c] (%04x)\n",
 				   claim->addr, claim->vid,
@@ -1687,7 +1687,7 @@ int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq, void *offset)
 			secs = msecs / 1000;
 			msecs = msecs % 1000;
 
-			is_own = batadv_compare_eth(backbone_gw->orig,
+			is_own = compare_ether_addr(backbone_gw->orig,
 						    primary_addr);
 			if (is_own)
 				continue;
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 8e1d89d..43b1fa2 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -277,7 +277,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip);
 	/* if this entry is already known, just update it */
 	if (dat_entry) {
-		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
+		if (!compare_ether_addr(dat_entry->mac_addr, mac_addr))
 			memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
 		dat_entry->last_update = jiffies;
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
@@ -441,7 +441,7 @@ static bool batadv_is_orig_node_eligible(struct batadv_dat_candidate *res,
 	 * the one with the lowest address
 	 */
 	if ((tmp_max == max) &&
-	    (batadv_compare_eth(candidate->orig, max_orig_node->orig) > 0))
+	    (compare_ether_addr(candidate->orig, max_orig_node->orig) > 0))
 		goto out;
 
 	ret = true;
diff --git a/hard-interface.c b/hard-interface.c
index 365ed74..a4c6f28 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -209,7 +209,7 @@ static void batadv_check_known_mac_addr(const struct net_device *net_dev)
 		if (hard_iface->net_dev == net_dev)
 			continue;
 
-		if (!batadv_compare_eth(hard_iface->net_dev->dev_addr,
+		if (!compare_ether_addr(hard_iface->net_dev->dev_addr,
 					net_dev->dev_addr))
 			continue;
 
diff --git a/main.c b/main.c
index 253e240..003e9f4 100644
--- a/main.c
+++ b/main.c
@@ -178,7 +178,7 @@ int batadv_is_my_mac(const uint8_t *addr)
 		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
-		if (batadv_compare_eth(hard_iface->net_dev->dev_addr, addr)) {
+		if (compare_ether_addr(hard_iface->net_dev->dev_addr, addr)) {
 			rcu_read_unlock();
 			return 1;
 		}
diff --git a/main.h b/main.h
index ec9c5ad..5a5ff17 100644
--- a/main.h
+++ b/main.h
@@ -231,15 +231,6 @@ static inline void batadv_dbg(int type __always_unused,
 		pr_err("%s: " fmt, _netdev->name, ## arg);		\
 	} while (0)
 
-/* returns 1 if they are the same ethernet addr
- *
- * note: can't use compare_ether_addr() as it requires aligned memory
- */
-static inline int batadv_compare_eth(const void *data1, const void *data2)
-{
-	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
-}
-
 /**
  * has_timed_out - compares current time (jiffies) and timestamp + timeout
  * @timestamp:		base value to compare with (in jiffies)
diff --git a/originator.h b/originator.h
index 9778e65..91f4277 100644
--- a/originator.h
+++ b/originator.h
@@ -80,7 +80,7 @@ batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(orig_node, node, head, hash_entry) {
-		if (!batadv_compare_eth(orig_node, data))
+		if (!compare_ether_addr(orig_node->orig, data))
 			continue;
 
 		if (!atomic_inc_not_zero(&orig_node->refcount))
diff --git a/routing.c b/routing.c
index f7d50d0..3c0c70b 100644
--- a/routing.c
+++ b/routing.c
@@ -154,7 +154,7 @@ void batadv_bonding_candidate_add(struct batadv_orig_node *orig_node,
 	spin_lock_bh(&orig_node->neigh_list_lock);
 
 	/* only consider if it has the same primary address ...  */
-	if (!batadv_compare_eth(orig_node->orig,
+	if (!compare_ether_addr(orig_node->orig,
 				neigh_node->orig_node->primary_addr))
 		goto candidate_del;
 
@@ -183,7 +183,7 @@ void batadv_bonding_candidate_add(struct batadv_orig_node *orig_node,
 			continue;
 
 		if ((neigh_node->if_incoming == tmp_neigh_node->if_incoming) ||
-		    (batadv_compare_eth(neigh_node->addr,
+		    (compare_ether_addr(neigh_node->addr,
 					tmp_neigh_node->addr))) {
 			interference_candidate = 1;
 			break;
@@ -738,13 +738,13 @@ batadv_find_router(struct batadv_priv *bat_priv,
 	/* if we have something in the primary_addr, we can search
 	 * for a potential bonding candidate.
 	 */
-	if (batadv_compare_eth(primary_addr, zero_mac))
+	if (compare_ether_addr(primary_addr, zero_mac))
 		goto return_router;
 
 	/* find the orig_node which has the primary interface. might
 	 * even be the same as our router_orig in many cases
 	 */
-	if (batadv_compare_eth(primary_addr, router_orig->orig)) {
+	if (compare_ether_addr(primary_addr, router_orig->orig)) {
 		primary_orig_node = router_orig;
 	} else {
 		primary_orig_node = batadv_orig_hash_find(bat_priv,
@@ -897,7 +897,7 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	if (batadv_compare_eth(orig_node->orig, unicast_packet->dest))
+	if (compare_ether_addr(orig_node->orig, unicast_packet->dest))
 		goto out;
 
 	/* update the packet header */
diff --git a/soft-interface.c b/soft-interface.c
index 7d1b0ce..13310a0 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -201,10 +201,10 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	 * The same goes for ECTP sent at least by some Cisco Switches,
 	 * it might confuse the mesh when used with bridge loop avoidance.
 	 */
-	if (batadv_compare_eth(ethhdr->h_dest, stp_addr))
+	if (compare_ether_addr(ethhdr->h_dest, stp_addr))
 		goto dropped;
 
-	if (batadv_compare_eth(ethhdr->h_dest, ectp_addr))
+	if (compare_ether_addr(ethhdr->h_dest, ectp_addr))
 		goto dropped;
 
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
diff --git a/translation-table.c b/translation-table.c
index 668766c..eac3102 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -72,7 +72,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const void *data)
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(tt_common_entry, node, head, hash_entry) {
-		if (!batadv_compare_eth(tt_common_entry, data))
+		if (!compare_ether_addr(tt_common_entry->addr, data))
 			continue;
 
 		if (!atomic_inc_not_zero(&tt_common_entry->refcount))
@@ -184,7 +184,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
 				 list) {
-		if (!batadv_compare_eth(entry->change.addr, addr))
+		if (!compare_ether_addr(entry->change.addr, addr))
 			continue;
 
 		/* DEL+ADD in the same orig interval have no effect and can be
@@ -314,7 +314,7 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	tt_local->common.added_at = tt_local->last_seen;
 
 	/* the batman interface mac address should never be purged */
-	if (batadv_compare_eth(addr, soft_iface->dev_addr))
+	if (compare_ether_addr(addr, soft_iface->dev_addr))
 		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
 
 	/* The local entry has to be marked as NEW to avoid to send it in
@@ -1518,10 +1518,13 @@ batadv_new_tt_req_node(struct batadv_priv *bat_priv,
 		       struct batadv_orig_node *orig_node)
 {
 	struct batadv_tt_req_node *tt_req_node_tmp, *tt_req_node = NULL;
+	unsigned same_addr;
 
 	spin_lock_bh(&bat_priv->tt.req_list_lock);
 	list_for_each_entry(tt_req_node_tmp, &bat_priv->tt.req_list, list) {
-		if (batadv_compare_eth(tt_req_node_tmp, orig_node) &&
+		same_addr = compare_ether_addr(tt_req_node_tmp->addr,
+					       orig_node->orig);
+		if (same_addr &&
 		    !batadv_has_timed_out(tt_req_node_tmp->issued_at,
 					  BATADV_TT_REQUEST_TIMEOUT))
 			goto unlock;
@@ -2090,7 +2093,7 @@ void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	/* Delete the tt_req_node from pending tt_requests list */
 	spin_lock_bh(&bat_priv->tt.req_list_lock);
 	list_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
-		if (!batadv_compare_eth(node->addr, tt_response->src))
+		if (!compare_ether_addr(node->addr, tt_response->src))
 			continue;
 		list_del(&node->list);
 		kfree(node);
@@ -2168,7 +2171,7 @@ static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv,
 	 * reply from the same orig_node yet
 	 */
 	list_for_each_entry(tt_roam_node, &bat_priv->tt.roam_list, list) {
-		if (!batadv_compare_eth(tt_roam_node->addr, client))
+		if (!compare_ether_addr(tt_roam_node->addr, client))
 			continue;
 
 		if (batadv_has_timed_out(tt_roam_node->first_time,
diff --git a/vis.c b/vis.c
index e08a204..b5dceb2 100644
--- a/vis.c
+++ b/vis.c
@@ -62,7 +62,7 @@ static int batadv_vis_info_cmp(const struct hlist_node *node, const void *data2)
 	d2 = data2;
 	p1 = (struct batadv_vis_packet *)d1->skb_packet->data;
 	p2 = (struct batadv_vis_packet *)d2->skb_packet->data;
-	return batadv_compare_eth(p1->vis_orig, p2->vis_orig);
+	return compare_ether_addr(p1->vis_orig, p2->vis_orig);
 }
 
 /* hash function to choose an entry in a hash table of given size
@@ -130,7 +130,7 @@ static void batadv_vis_data_insert_interface(const uint8_t *interface,
 	struct hlist_node *pos;
 
 	hlist_for_each_entry(entry, pos, if_list, list) {
-		if (batadv_compare_eth(entry->addr, interface))
+		if (compare_ether_addr(entry->addr, interface))
 			return;
 	}
 
@@ -165,7 +165,7 @@ batadv_vis_data_read_entry(struct seq_file *seq,
 {
 	if (primary && entry->quality == 0)
 		return seq_printf(seq, "TT %pM, ", entry->dest);
-	else if (batadv_compare_eth(entry->src, src))
+	else if (compare_ether_addr(entry->src, src))
 		return seq_printf(seq, "TQ %pM %d, ", entry->dest,
 				  entry->quality);
 
@@ -183,7 +183,7 @@ batadv_vis_data_insert_interfaces(struct hlist_head *list,
 		if (entries[i].quality == 0)
 			continue;
 
-		if (batadv_compare_eth(entries[i].src, packet->vis_orig))
+		if (compare_ether_addr(entries[i].src, packet->vis_orig))
 			continue;
 
 		batadv_vis_data_insert_interface(entries[i].src, list, false);
@@ -207,7 +207,7 @@ static void batadv_vis_data_read_entries(struct seq_file *seq,
 						   entry->addr, entry->primary);
 
 		/* add primary/secondary records */
-		if (batadv_compare_eth(entry->addr, packet->vis_orig))
+		if (compare_ether_addr(entry->addr, packet->vis_orig))
 			batadv_vis_data_read_prim_sec(seq, list);
 
 		seq_printf(seq, "\n");
@@ -325,7 +325,7 @@ static int batadv_recv_list_is_in(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(&bat_priv->vis.list_lock);
 	list_for_each_entry(entry, recv_list, list) {
-		if (batadv_compare_eth(entry->mac, mac)) {
+		if (compare_ether_addr(entry->mac, mac)) {
 			spin_unlock_bh(&bat_priv->vis.list_lock);
 			return 1;
 		}
@@ -609,7 +609,7 @@ static int batadv_generate_vis_packet(struct batadv_priv *bat_priv)
 			if (!router)
 				continue;
 
-			if (!batadv_compare_eth(router->addr, orig_node->orig))
+			if (!compare_ether_addr(router->addr, orig_node->orig))
 				goto next;
 
 			if (router->if_incoming->if_status != BATADV_IF_ACTIVE)
-- 
1.7.10.4

