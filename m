Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 29 May 2013 00:20:41 +0200
Message-Id: <1369779649-2537-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1369779649-2537-1-git-send-email-ordex@autistici.org>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC 02/10] batman-adv: make struct batadv_orig_node
	algorithm agnostic
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

some of the struct batadv_orig_node members are B.A.T.M.A.N. IV
specific and therefore they are moved in a algorithm specific
substruct in order to make batadv_orig_node routing algorithm
agnostic

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_iv_ogm.c | 108 ++++++++++++++++++++++++++++++++++++++++-------------------
 originator.c |  83 +++++++++++++++++----------------------------
 originator.h |   2 +-
 routing.c    |  10 ++++--
 types.h      |  50 +++++++++++++++------------
 5 files changed, 142 insertions(+), 111 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index d885aa8..8e8dc5d 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -70,6 +70,43 @@ static uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[])
 
 	return (uint8_t)(sum / count);
 }
+
+static struct batadv_orig_node *
+batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const uint8_t *addr)
+{
+	struct batadv_orig_node *orig_node;
+	int size;
+
+	orig_node = batadv_orig_hash_find(bat_priv, addr);
+	if (orig_node)
+		return orig_node;
+
+	orig_node = batadv_orig_node_new(bat_priv, addr);
+	if (!orig_node)
+		return NULL;
+
+	spin_lock_init(&orig_node->bat_iv.ogm_cnt_lock);
+
+	size = bat_priv->num_ifaces * sizeof(unsigned long) * BATADV_NUM_WORDS;
+	orig_node->bat_iv.bcast_own = kzalloc(size, GFP_ATOMIC);
+	if (!orig_node->bat_iv.bcast_own)
+		goto free_orig_node;
+
+	size = bat_priv->num_ifaces * sizeof(uint8_t);
+	orig_node->bat_iv.bcast_own_sum = kzalloc(size, GFP_ATOMIC);
+	if (!orig_node->bat_iv.bcast_own_sum)
+		goto free_bcast_own;
+
+	return orig_node;
+
+free_bcast_own:
+	kfree(orig_node->bat_iv.bcast_own);
+free_orig_node:
+	batadv_orig_node_free_ref(orig_node);
+
+	return NULL;
+}
+
 static struct batadv_neigh_node *
 batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 			const uint8_t *neigh_addr,
@@ -647,14 +684,14 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			spin_lock_bh(&orig_node->ogm_cnt_lock);
+			spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 			word_index = hard_iface->if_num * BATADV_NUM_WORDS;
-			word = &(orig_node->bcast_own[word_index]);
+			word = &(orig_node->bat_iv.bcast_own[word_index]);
 
 			batadv_bit_get_packet(bat_priv, word, 1, 0);
-			w = &orig_node->bcast_own_sum[hard_iface->if_num];
+			w = &orig_node->bat_iv.bcast_own_sum[hard_iface->if_num];
 			*w = bitmap_weight(word, BATADV_TQ_LOCAL_WINDOW_SIZE);
-			spin_unlock_bh(&orig_node->ogm_cnt_lock);
+			spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 		}
 		rcu_read_unlock();
 	}
@@ -746,7 +783,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	if (!neigh_node) {
 		struct batadv_orig_node *orig_tmp;
 
-		orig_tmp = batadv_get_orig_node(bat_priv, ethhdr->h_source);
+		orig_tmp = batadv_iv_ogm_orig_get(bat_priv, ethhdr->h_source);
 		if (!orig_tmp)
 			goto unlock;
 
@@ -796,16 +833,16 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	 */
 	if (router && (neigh_node->bat_iv.tq_avg == router->bat_iv.tq_avg)) {
 		orig_node_tmp = router->orig_node;
-		spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
+		spin_lock_bh(&orig_node_tmp->bat_iv.ogm_cnt_lock);
 		if_num = router->if_incoming->if_num;
-		sum_orig = orig_node_tmp->bcast_own_sum[if_num];
-		spin_unlock_bh(&orig_node_tmp->ogm_cnt_lock);
+		sum_orig = orig_node_tmp->bat_iv.bcast_own_sum[if_num];
+		spin_unlock_bh(&orig_node_tmp->bat_iv.ogm_cnt_lock);
 
 		orig_node_tmp = neigh_node->orig_node;
-		spin_lock_bh(&orig_node_tmp->ogm_cnt_lock);
+		spin_lock_bh(&orig_node_tmp->bat_iv.ogm_cnt_lock);
 		if_num = neigh_node->if_incoming->if_num;
-		sum_neigh = orig_node_tmp->bcast_own_sum[if_num];
-		spin_unlock_bh(&orig_node_tmp->ogm_cnt_lock);
+		sum_neigh = orig_node_tmp->bat_iv.bcast_own_sum[if_num];
+		spin_unlock_bh(&orig_node_tmp->bat_iv.ogm_cnt_lock);
 
 		if (sum_orig >= sum_neigh)
 			goto out;
@@ -833,7 +870,7 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	uint8_t total_count;
 	uint8_t orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
 	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
-	int tq_asym_penalty, inv_asym_penalty, ret = 0;
+	int tq_asym_penalty, inv_asym_penalty, if_num, ret = 0;
 	unsigned int combined_tq;
 
 	/* find corresponding one hop neighbor */
@@ -871,10 +908,11 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	orig_node->last_seen = jiffies;
 
 	/* find packet count of corresponding one hop neighbor */
-	spin_lock_bh(&orig_node->ogm_cnt_lock);
-	orig_eq_count = orig_neigh_node->bcast_own_sum[if_incoming->if_num];
+	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
+	if_num = if_incoming->if_num;
+	orig_eq_count = orig_neigh_node->bat_iv.bcast_own_sum[if_num];
 	neigh_rq_count = neigh_node->bat_iv.real_packet_count;
-	spin_unlock_bh(&orig_node->ogm_cnt_lock);
+	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 
 	/* pay attention to not get a value bigger than 100 % */
 	if (orig_eq_count > neigh_rq_count)
@@ -951,16 +989,16 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	int32_t seq_diff;
 	int need_update = 0;
 	int set_mark, ret = -1;
-	uint32_t seqno = ntohl(batadv_ogm_packet->seqno);
+	uint32_t last_real_seqno, seqno = ntohl(batadv_ogm_packet->seqno);
 	uint8_t *neigh_addr;
 	uint8_t packet_count;
 	unsigned long (*bitmap)[];
 
-	orig_node = batadv_get_orig_node(bat_priv, batadv_ogm_packet->orig);
+	orig_node = batadv_iv_ogm_orig_get(bat_priv, batadv_ogm_packet->orig);
 	if (!orig_node)
 		return 0;
 
-	spin_lock_bh(&orig_node->ogm_cnt_lock);
+	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 	seq_diff = seqno - orig_node->last_real_seqno;
 
 	/* signalize caller that the packet is to be dropped. */
@@ -973,8 +1011,8 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	hlist_for_each_entry_rcu(tmp_neigh_node,
 				 &orig_node->neigh_list, list) {
 		bitmap = &tmp_neigh_node->bat_iv.real_bits;
-		is_duplicate |= batadv_test_bit(*bitmap,
-						orig_node->last_real_seqno,
+		last_real_seqno = orig_node->last_real_seqno;
+		is_duplicate |= batadv_test_bit(*bitmap, last_real_seqno,
 						seqno);
 
 		neigh_addr = tmp_neigh_node->addr;
@@ -1005,7 +1043,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	ret = is_duplicate;
 
 out:
-	spin_unlock_bh(&orig_node->ogm_cnt_lock);
+	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 	batadv_orig_node_free_ref(orig_node);
 	return ret;
 }
@@ -1026,8 +1064,8 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	bool is_single_hop_neigh = false;
 	bool is_from_best_next_hop = false;
 	int is_duplicate, sameseq, simlar_ttl;
-	uint32_t if_incoming_seqno;
-	uint8_t *prev_sender;
+	uint32_t seqno, if_incoming_seqno;
+	uint8_t ttl, *prev_sender;
 
 	/* Silently drop when the batman packet is actually not a
 	 * correct packet.
@@ -1100,8 +1138,8 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		int16_t if_num;
 		uint8_t *weight;
 
-		orig_neigh_node = batadv_get_orig_node(bat_priv,
-						       ethhdr->h_source);
+		orig_neigh_node = batadv_iv_ogm_orig_get(bat_priv,
+							 ethhdr->h_source);
 		if (!orig_neigh_node)
 			return;
 
@@ -1115,15 +1153,15 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 			if_num = if_incoming->if_num;
 			offset = if_num * BATADV_NUM_WORDS;
 
-			spin_lock_bh(&orig_neigh_node->ogm_cnt_lock);
-			word = &(orig_neigh_node->bcast_own[offset]);
+			spin_lock_bh(&orig_neigh_node->bat_iv.ogm_cnt_lock);
+			word = &(orig_neigh_node->bat_iv.bcast_own[offset]);
 			bit_pos = if_incoming_seqno - 2;
 			bit_pos -= ntohl(batadv_ogm_packet->seqno);
 			batadv_set_bit(word, bit_pos);
-			weight = &orig_neigh_node->bcast_own_sum[if_num];
+			weight = &orig_neigh_node->bat_iv.bcast_own_sum[if_num];
 			*weight = bitmap_weight(word,
 						BATADV_TQ_LOCAL_WINDOW_SIZE);
-			spin_unlock_bh(&orig_neigh_node->ogm_cnt_lock);
+			spin_unlock_bh(&orig_neigh_node->bat_iv.ogm_cnt_lock);
 		}
 
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
@@ -1146,7 +1184,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		return;
 	}
 
-	orig_node = batadv_get_orig_node(bat_priv, batadv_ogm_packet->orig);
+	orig_node = batadv_iv_ogm_orig_get(bat_priv, batadv_ogm_packet->orig);
 	if (!orig_node)
 		return;
 
@@ -1196,8 +1234,8 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	if (is_single_hop_neigh)
 		orig_neigh_node = orig_node;
 	else
-		orig_neigh_node = batadv_get_orig_node(bat_priv,
-						       ethhdr->h_source);
+		orig_neigh_node = batadv_iv_ogm_orig_get(bat_priv,
+							 ethhdr->h_source);
 
 	if (!orig_neigh_node)
 		goto out;
@@ -1226,8 +1264,10 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	/* update ranking if it is not a duplicate or has the same
 	 * seqno and similar ttl as the non-duplicate
 	 */
-	sameseq = orig_node->last_real_seqno == ntohl(batadv_ogm_packet->seqno);
-	simlar_ttl = orig_node->last_ttl - 3 <= batadv_ogm_packet->header.ttl;
+	seqno = ntohl(batadv_ogm_packet->seqno);
+	sameseq = orig_node->last_real_seqno == seqno;
+	ttl = batadv_ogm_packet->header.ttl;
+	simlar_ttl = orig_node->last_ttl - 3 <= ttl;
 	if (is_bidirect && (!is_duplicate || (sameseq && simlar_ttl)))
 		batadv_iv_ogm_orig_update(bat_priv, orig_node, ethhdr,
 					  batadv_ogm_packet, if_incoming,
diff --git a/originator.c b/originator.c
index 3d312de..0225ae2 100644
--- a/originator.c
+++ b/originator.c
@@ -235,8 +235,8 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 				  "originator timed out");
 
 	kfree(orig_node->tt_buff);
-	kfree(orig_node->bcast_own);
-	kfree(orig_node->bcast_own_sum);
+	kfree(orig_node->bat_iv.bcast_own);
+	kfree(orig_node->bat_iv.bcast_own_sum);
 	kfree(orig_node);
 }
 
@@ -297,18 +297,13 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 /* this function finds or creates an originator entry for the given
  * address if it does not exits
  */
-struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
+struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 					      const uint8_t *addr)
 {
 	struct batadv_orig_node *orig_node;
 	struct batadv_orig_node_vlan *vlan;
-	int size, i;
-	int hash_added;
 	unsigned long reset_time;
-
-	orig_node = batadv_orig_hash_find(bat_priv, addr);
-	if (orig_node)
-		return orig_node;
+	int i, hash_added;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Creating new originator: %pM\n", addr);
@@ -320,8 +315,6 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
 	INIT_LIST_HEAD(&orig_node->bond_list);
 	INIT_LIST_HEAD(&orig_node->vlan_list);
-	spin_lock_init(&orig_node->ogm_cnt_lock);
-	spin_lock_init(&orig_node->bcast_seqno_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
 	spin_lock_init(&orig_node->tt_buff_lock);
 	spin_lock_init(&orig_node->vlan_list_lock);
@@ -339,11 +332,6 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	atomic_set(&orig_node->last_ttvn, 0);
 	orig_node->tt_buff = NULL;
 	orig_node->tt_buff_len = 0;
-	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
-	orig_node->bcast_seqno_reset = reset_time;
-	orig_node->batman_seqno_reset = reset_time;
-
-	atomic_set(&orig_node->bond_candidates, 0);
 
 	/* create a vlan object for the "untagged" LAN */
 	vlan = batadv_orig_node_vlan_new(orig_node, BATADV_NO_FLAGS);
@@ -352,14 +340,7 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	/* there is nothing else to do with the vlan.. */
 	batadv_orig_node_vlan_free_ref(vlan);
 
-	size = bat_priv->num_ifaces * sizeof(unsigned long) * BATADV_NUM_WORDS;
-
-	orig_node->bcast_own = kzalloc(size, GFP_ATOMIC);
-	if (!orig_node->bcast_own)
-		goto free_vlan;
-
-	size = bat_priv->num_ifaces * sizeof(uint8_t);
-	orig_node->bcast_own_sum = kzalloc(size, GFP_ATOMIC);
+	atomic_set(&orig_node->bond_candidates, 0);
 
 	for (i = 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
 		INIT_HLIST_HEAD(&orig_node->fragments[i].head);
@@ -367,22 +348,20 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 		orig_node->fragments[i].size = 0;
 	}
 
-	if (!orig_node->bcast_own_sum)
-		goto free_bcast_own;
+	spin_lock_init(&orig_node->bcast_seqno_lock);
+	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
+	orig_node->bcast_seqno_reset = reset_time;
+	orig_node->batman_seqno_reset = reset_time;
 
 	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
 				     batadv_choose_orig, orig_node,
 				     &orig_node->hash_entry);
-	if (hash_added != 0)
-		goto free_bcast_own_sum;
+	if (hash_added != 0) {
+		kfree(orig_node);
+		return NULL;
+	}
 
 	return orig_node;
-free_bcast_own_sum:
-	kfree(orig_node->bcast_own_sum);
-free_bcast_own:
-	kfree(orig_node->bcast_own);
-free_vlan:
-	batadv_orig_node_vlan_free_ref(vlan);
 free_orig_node:
 	kfree(orig_node);
 	return NULL;
@@ -606,18 +585,18 @@ static int batadv_orig_node_add_if(struct batadv_orig_node *orig_node,
 	if (!data_ptr)
 		return -ENOMEM;
 
-	memcpy(data_ptr, orig_node->bcast_own, old_size);
-	kfree(orig_node->bcast_own);
-	orig_node->bcast_own = data_ptr;
+	memcpy(data_ptr, orig_node->bat_iv.bcast_own, old_size);
+	kfree(orig_node->bat_iv.bcast_own);
+	orig_node->bat_iv.bcast_own = data_ptr;
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr)
 		return -ENOMEM;
 
-	memcpy(data_ptr, orig_node->bcast_own_sum,
+	memcpy(data_ptr, orig_node->bat_iv.bcast_own_sum,
 	       (max_if_num - 1) * sizeof(uint8_t));
-	kfree(orig_node->bcast_own_sum);
-	orig_node->bcast_own_sum = data_ptr;
+	kfree(orig_node->bat_iv.bcast_own_sum);
+	orig_node->bat_iv.bcast_own_sum = data_ptr;
 
 	return 0;
 }
@@ -640,9 +619,9 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			spin_lock_bh(&orig_node->ogm_cnt_lock);
+			spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 			ret = batadv_orig_node_add_if(orig_node, max_if_num);
-			spin_unlock_bh(&orig_node->ogm_cnt_lock);
+			spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 
 			if (ret == -ENOMEM)
 				goto err;
@@ -673,16 +652,16 @@ static int batadv_orig_node_del_if(struct batadv_orig_node *orig_node,
 		return -ENOMEM;
 
 	/* copy first part */
-	memcpy(data_ptr, orig_node->bcast_own, del_if_num * chunk_size);
+	memcpy(data_ptr, orig_node->bat_iv.bcast_own, del_if_num * chunk_size);
 
 	/* copy second part */
 	memcpy((char *)data_ptr + del_if_num * chunk_size,
-	       orig_node->bcast_own + ((del_if_num + 1) * chunk_size),
+	       orig_node->bat_iv.bcast_own + ((del_if_num + 1) * chunk_size),
 	       (max_if_num - del_if_num) * chunk_size);
 
 free_bcast_own:
-	kfree(orig_node->bcast_own);
-	orig_node->bcast_own = data_ptr;
+	kfree(orig_node->bat_iv.bcast_own);
+	orig_node->bat_iv.bcast_own = data_ptr;
 
 	if (max_if_num == 0)
 		goto free_own_sum;
@@ -691,16 +670,16 @@ free_bcast_own:
 	if (!data_ptr)
 		return -ENOMEM;
 
-	memcpy(data_ptr, orig_node->bcast_own_sum,
+	memcpy(data_ptr, orig_node->bat_iv.bcast_own_sum,
 	       del_if_num * sizeof(uint8_t));
 
 	memcpy((char *)data_ptr + del_if_num * sizeof(uint8_t),
-	       orig_node->bcast_own_sum + ((del_if_num + 1) * sizeof(uint8_t)),
+	       orig_node->bat_iv.bcast_own_sum + ((del_if_num + 1) * sizeof(uint8_t)),
 	       (max_if_num - del_if_num) * sizeof(uint8_t));
 
 free_own_sum:
-	kfree(orig_node->bcast_own_sum);
-	orig_node->bcast_own_sum = data_ptr;
+	kfree(orig_node->bat_iv.bcast_own_sum);
+	orig_node->bat_iv.bcast_own_sum = data_ptr;
 
 	return 0;
 }
@@ -724,10 +703,10 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			spin_lock_bh(&orig_node->ogm_cnt_lock);
+			spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 			ret = batadv_orig_node_del_if(orig_node, max_if_num,
 						      hard_iface->if_num);
-			spin_unlock_bh(&orig_node->ogm_cnt_lock);
+			spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 
 			if (ret == -ENOMEM)
 				goto err;
diff --git a/originator.h b/originator.h
index 06e5a68..a765a2f 100644
--- a/originator.h
+++ b/originator.h
@@ -27,7 +27,7 @@ void batadv_originator_free(struct batadv_priv *bat_priv);
 void batadv_purge_orig_ref(struct batadv_priv *bat_priv);
 void batadv_orig_node_free_ref(struct batadv_orig_node *orig_node);
 void batadv_orig_node_free_ref_now(struct batadv_orig_node *orig_node);
-struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
+struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 					      const uint8_t *addr);
 struct batadv_neigh_node *
 batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
diff --git a/routing.c b/routing.c
index 99f6844..46de5c7 100644
--- a/routing.c
+++ b/routing.c
@@ -1075,6 +1075,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	int hdr_size = sizeof(*bcast_packet);
 	int ret = NET_RX_DROP;
 	int32_t seq_diff;
+	uint32_t seqno;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
@@ -1111,11 +1112,13 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	spin_lock_bh(&orig_node->bcast_seqno_lock);
 
 	/* check whether the packet is a duplicate */
-	if (batadv_test_bit(orig_node->bcast_bits, orig_node->last_bcast_seqno,
+	if (batadv_test_bit(orig_node->bcast_bits,
+			    orig_node->last_bcast_seqno,
 			    ntohl(bcast_packet->seqno)))
 		goto spin_unlock;
 
-	seq_diff = ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
+	seqno = orig_node->last_bcast_seqno;
+	seq_diff = ntohl(bcast_packet->seqno) - seqno;
 
 	/* check whether the packet is old and the host just restarted. */
 	if (batadv_window_protected(bat_priv, seq_diff,
@@ -1125,7 +1128,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	/* mark broadcast in flood history, update window position
 	 * if required.
 	 */
-	if (batadv_bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
+	if (batadv_bit_get_packet(bat_priv, orig_node->bcast_bits,
+				  seq_diff, 1))
 		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
 
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
diff --git a/types.h b/types.h
index c7d5fa1..fde4d68 100644
--- a/types.h
+++ b/types.h
@@ -133,18 +133,29 @@ struct batadv_orig_node_vlan {
 };
 
 /**
+ * struct batadv_orig_bat_iv - B.A.T.M.A.N. IV private orig_node members
+ * @bcast_own: bitfield containing the number of our OGMs this orig_node
+ *  rebroadcasted "back" to us (relative to last_real_seqno)
+ * @bcast_own_sum: counted result of bcast_own
+ * @ogm_cnt_lock: lock protecting bcast_own, bcast_own_sum,
+ *  neigh_node->real_bits & neigh_node->real_packet_count
+ */
+struct batadv_orig_bat_iv {
+	unsigned long *bcast_own;
+	uint8_t *bcast_own_sum;
+	spinlock_t ogm_cnt_lock;
+};
+
+/**
  * struct batadv_orig_node - structure for orig_list maintaining nodes of mesh
  * @orig: originator ethernet address
  * @primary_addr: hosts primary interface address
  * @router: router that should be used to reach this originator
- * @batadv_dat_addr_t:  address of the orig node in the distributed hash
- * @bcast_own: bitfield containing the number of our OGMs this orig_node
- *  rebroadcasted "back" to us (relative to last_real_seqno)
- * @bcast_own_sum: counted result of bcast_own
  * @last_seen: time when last packet from this node was received
- * @bcast_seqno_reset: time when the broadcast seqno window was reset
- * @batman_seqno_reset: time when the batman seqno window was reset
+ * @last_ttl: ttl of last received packet
+ * @batadv_dat_addr_t:  address of the orig node in the distributed hash
  * @capabilities: announced capabilities of this originator
+ * @last_real_seqno: last and best known sequence number
  * @last_ttvn: last seen translation table version number
  * @tt_buff: last tt changeset this node received from the orig node
  * @tt_buff_len: length of the last tt changeset this node received from the
@@ -152,19 +163,17 @@ struct batadv_orig_node_vlan {
  * @tt_buff_lock: lock that protects tt_buff and tt_buff_len
  * @tt_initialised: bool keeping track of whether or not this node have received
  *  any translation table information from the orig node yet
- * @last_real_seqno: last and best known sequence number
- * @last_ttl: ttl of last received packet
  * @bcast_bits: bitfield containing the info which payload broadcast originated
  *  from this orig node this host already has seen (relative to
  *  last_bcast_seqno)
  * @last_bcast_seqno: last broadcast sequence number received by this host
+ * @bcast_seqno_lock: lock protecting bcast_bits & last_bcast_seqno
+ * @bcast_seqno_reset: time when the broadcast seqno window was reset
+ * @batman_seqno_reset: time when the batman seqno window was reset
  * @neigh_list: list of potential next hop neighbor towards this orig node
  * @neigh_list_lock: lock protecting neigh_list, router and bonding_list
  * @hash_entry: hlist node for batadv_priv::orig_hash
  * @bat_priv: pointer to soft_iface this orig node belongs to
- * @ogm_cnt_lock: lock protecting bcast_own, bcast_own_sum,
- *  neigh_node->real_bits & neigh_node->real_packet_count
- * @bcast_seqno_lock: lock protecting bcast_bits & last_bcast_seqno
  * @bond_candidates: how many candidates are available
  * @bond_list: list of bonding candidates
  * @refcount: number of contexts the object is used
@@ -177,29 +186,30 @@ struct batadv_orig_node_vlan {
  * @vlan_list: a list of orig_node_vlan structs, one per VLAN served by the
  *  originator represented by this object
  * @vlan_list_lock: lock protecting vlan_list
+ * @bat_iv: B.A.T.M.A.N. IV private structure
  */
 struct batadv_orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
 	struct batadv_neigh_node __rcu *router; /* rcu protected pointer */
+	unsigned long last_seen;
+	uint8_t last_ttl;
 #ifdef CONFIG_BATMAN_ADV_DAT
 	batadv_dat_addr_t dat_addr;
 #endif
-	unsigned long *bcast_own;
-	uint8_t *bcast_own_sum;
-	unsigned long last_seen;
-	unsigned long bcast_seqno_reset;
-	unsigned long batman_seqno_reset;
 	uint8_t capabilities;
+	uint32_t last_real_seqno;
 	atomic_t last_ttvn;
 	unsigned char *tt_buff;
 	int16_t tt_buff_len;
 	spinlock_t tt_buff_lock; /* protects tt_buff & tt_buff_len */
 	bool tt_initialised;
-	uint32_t last_real_seqno;
-	uint8_t last_ttl;
 	DECLARE_BITMAP(bcast_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
 	uint32_t last_bcast_seqno;
+	/* bcast_seqno_lock protects: bcast_bits & last_bcast_seqno */
+	spinlock_t bcast_seqno_lock;
+	unsigned long bcast_seqno_reset;
+	unsigned long batman_seqno_reset;
 	struct hlist_head neigh_list;
 	/* neigh_list_lock protects: neigh_list, router & bonding_list */
 	spinlock_t neigh_list_lock;
@@ -208,9 +218,6 @@ struct batadv_orig_node {
 	/* ogm_cnt_lock protects: bcast_own, bcast_own_sum,
 	 * neigh_node->real_bits & neigh_node->real_packet_count
 	 */
-	spinlock_t ogm_cnt_lock;
-	/* bcast_seqno_lock protects: bcast_bits & last_bcast_seqno */
-	spinlock_t bcast_seqno_lock;
 	atomic_t bond_candidates;
 	struct list_head bond_list;
 	atomic_t refcount;
@@ -224,6 +231,7 @@ struct batadv_orig_node {
 	struct batadv_frag_table_entry fragments[BATADV_FRAG_BUFFER_COUNT];
 	struct list_head vlan_list;
 	spinlock_t vlan_list_lock; /* protects vlan_list */
+	struct batadv_orig_bat_iv bat_iv;
 };
 
 /**
-- 
1.8.1.5

