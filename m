Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 27 Aug 2013 22:57:44 +0200
Message-Id: <1377637071-2498-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1377637071-2498-1-git-send-email-ordex@autistici.org>
References: <1377637071-2498-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 2/9] batman-adv: make struct
	batadv_orig_node algorithm agnostic
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
 bat_iv_ogm.c | 102 +++++++++++++++++++++++++++++++++++++++++++----------------
 originator.c |  82 +++++++++++++++++++----------------------------
 originator.h |   2 +-
 types.h      |  30 +++++++++++-------
 4 files changed, 127 insertions(+), 89 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index a0b11b0..5873ca9 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -87,6 +87,51 @@ static uint8_t batadv_ring_buffer_avg(const uint8_t lq_recv[])
 	return (uint8_t)(sum / count);
 }
 
+/**
+ * batadv_iv_ogm_orig_get - retrieve or create (if does not exist) an originator
+ * @bat_priv: the bat priv with all the soft interface information
+ * @addr: mac address of the originator
+ *
+ * Returns the originator object corresponding to the passed mac address or NULL
+ * on failure.
+ * If the object does not exists it is created an initialised.
+ */
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
@@ -659,20 +704,22 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 	uint32_t i;
 	size_t word_index;
 	uint8_t *w;
+	int if_num;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			spin_lock_bh(&orig_node->ogm_cnt_lock);
+			spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 			word_index = hard_iface->if_num * BATADV_NUM_WORDS;
-			word = &(orig_node->bcast_own[word_index]);
+			word = &(orig_node->bat_iv.bcast_own[word_index]);
 
 			batadv_bit_get_packet(bat_priv, word, 1, 0);
-			w = &orig_node->bcast_own_sum[hard_iface->if_num];
+			if_num = hard_iface->if_num;
+			w = &orig_node->bat_iv.bcast_own_sum[if_num];
 			*w = bitmap_weight(word, BATADV_TQ_LOCAL_WINDOW_SIZE);
-			spin_unlock_bh(&orig_node->ogm_cnt_lock);
+			spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 		}
 		rcu_read_unlock();
 	}
@@ -764,7 +811,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	if (!neigh_node) {
 		struct batadv_orig_node *orig_tmp;
 
-		orig_tmp = batadv_get_orig_node(bat_priv, ethhdr->h_source);
+		orig_tmp = batadv_iv_ogm_orig_get(bat_priv, ethhdr->h_source);
 		if (!orig_tmp)
 			goto unlock;
 
@@ -814,16 +861,16 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
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
@@ -851,7 +898,7 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	uint8_t total_count;
 	uint8_t orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
 	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
-	int tq_asym_penalty, inv_asym_penalty, ret = 0;
+	int tq_asym_penalty, inv_asym_penalty, if_num, ret = 0;
 	unsigned int combined_tq;
 
 	/* find corresponding one hop neighbor */
@@ -889,10 +936,11 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
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
@@ -976,11 +1024,11 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	uint8_t packet_count;
 	unsigned long *bitmap;
 
-	orig_node = batadv_get_orig_node(bat_priv, batadv_ogm_packet->orig);
+	orig_node = batadv_iv_ogm_orig_get(bat_priv, batadv_ogm_packet->orig);
 	if (!orig_node)
 		return BATADV_NO_DUP;
 
-	spin_lock_bh(&orig_node->ogm_cnt_lock);
+	spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 	seq_diff = seqno - orig_node->last_real_seqno;
 
 	/* signalize caller that the packet is to be dropped. */
@@ -1029,7 +1077,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	}
 
 out:
-	spin_unlock_bh(&orig_node->ogm_cnt_lock);
+	spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 	batadv_orig_node_free_ref(orig_node);
 	return ret;
 }
@@ -1125,8 +1173,8 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		int16_t if_num;
 		uint8_t *weight;
 
-		orig_neigh_node = batadv_get_orig_node(bat_priv,
-						       ethhdr->h_source);
+		orig_neigh_node = batadv_iv_ogm_orig_get(bat_priv,
+							 ethhdr->h_source);
 		if (!orig_neigh_node)
 			return;
 
@@ -1140,15 +1188,15 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
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
@@ -1171,7 +1219,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		return;
 	}
 
-	orig_node = batadv_get_orig_node(bat_priv, batadv_ogm_packet->orig);
+	orig_node = batadv_iv_ogm_orig_get(bat_priv, batadv_ogm_packet->orig);
 	if (!orig_node)
 		return;
 
@@ -1221,8 +1269,8 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 	if (is_single_hop_neigh)
 		orig_neigh_node = orig_node;
 	else
-		orig_neigh_node = batadv_get_orig_node(bat_priv,
-						       ethhdr->h_source);
+		orig_neigh_node = batadv_iv_ogm_orig_get(bat_priv,
+							 ethhdr->h_source);
 
 	if (!orig_neigh_node)
 		goto out;
diff --git a/originator.c b/originator.c
index ed87861..06bec79 100644
--- a/originator.c
+++ b/originator.c
@@ -244,8 +244,8 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 				  "originator timed out");
 
 	kfree(orig_node->tt_buff);
-	kfree(orig_node->bcast_own);
-	kfree(orig_node->bcast_own_sum);
+	kfree(orig_node->bat_iv.bcast_own);
+	kfree(orig_node->bat_iv.bcast_own_sum);
 	kfree(orig_node);
 }
 
@@ -303,21 +303,21 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
 	batadv_hash_destroy(hash);
 }
 
-/* this function finds or creates an originator entry for the given
- * address if it does not exits
+/**
+ * batadv_orig_node_new - creates a new orig_node
+ * @bat_priv: the bat priv with all the soft interface information
+ * @addr: the mac address of the originator
+ *
+ * Creates a new originator object and initialise all the generic fields.
+ * Returns the newly created object or NULL on failure.
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
@@ -329,7 +329,6 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
 	INIT_LIST_HEAD(&orig_node->bond_list);
 	INIT_LIST_HEAD(&orig_node->vlan_list);
-	spin_lock_init(&orig_node->ogm_cnt_lock);
 	spin_lock_init(&orig_node->bcast_seqno_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
 	spin_lock_init(&orig_node->tt_buff_lock);
@@ -365,37 +364,19 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	 */
 	batadv_orig_node_vlan_free_ref(vlan);
 
-	size = bat_priv->num_ifaces * sizeof(unsigned long) * BATADV_NUM_WORDS;
-
-	orig_node->bcast_own = kzalloc(size, GFP_ATOMIC);
-	if (!orig_node->bcast_own)
-		goto free_vlan;
-
-	size = bat_priv->num_ifaces * sizeof(uint8_t);
-	orig_node->bcast_own_sum = kzalloc(size, GFP_ATOMIC);
-
 	for (i = 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
 		INIT_HLIST_HEAD(&orig_node->fragments[i].head);
 		spin_lock_init(&orig_node->fragments[i].lock);
 		orig_node->fragments[i].size = 0;
 	}
 
-	if (!orig_node->bcast_own_sum)
-		goto free_bcast_own;
-
 	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
 				     batadv_choose_orig, orig_node,
 				     &orig_node->hash_entry);
 	if (hash_added != 0)
-		goto free_bcast_own_sum;
+		goto free_orig_node;
 
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
@@ -621,18 +602,18 @@ static int batadv_orig_node_add_if(struct batadv_orig_node *orig_node,
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
@@ -655,9 +636,9 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
-			spin_lock_bh(&orig_node->ogm_cnt_lock);
+			spin_lock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 			ret = batadv_orig_node_add_if(orig_node, max_if_num);
-			spin_unlock_bh(&orig_node->ogm_cnt_lock);
+			spin_unlock_bh(&orig_node->bat_iv.ogm_cnt_lock);
 
 			if (ret == -ENOMEM)
 				goto err;
@@ -675,8 +656,8 @@ err:
 static int batadv_orig_node_del_if(struct batadv_orig_node *orig_node,
 				   int max_if_num, int del_if_num)
 {
+	int chunk_size, if_offset;
 	void *data_ptr = NULL;
-	int chunk_size;
 
 	/* last interface was removed */
 	if (max_if_num == 0)
@@ -688,16 +669,16 @@ static int batadv_orig_node_del_if(struct batadv_orig_node *orig_node,
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
@@ -706,16 +687,17 @@ free_bcast_own:
 	if (!data_ptr)
 		return -ENOMEM;
 
-	memcpy(data_ptr, orig_node->bcast_own_sum,
+	memcpy(data_ptr, orig_node->bat_iv.bcast_own_sum,
 	       del_if_num * sizeof(uint8_t));
 
+	if_offset = ((del_if_num + 1) * sizeof(uint8_t));
 	memcpy((char *)data_ptr + del_if_num * sizeof(uint8_t),
-	       orig_node->bcast_own_sum + ((del_if_num + 1) * sizeof(uint8_t)),
+	       orig_node->bat_iv.bcast_own_sum + if_offset,
 	       (max_if_num - del_if_num) * sizeof(uint8_t));
 
 free_own_sum:
-	kfree(orig_node->bcast_own_sum);
-	orig_node->bcast_own_sum = data_ptr;
+	kfree(orig_node->bat_iv.bcast_own_sum);
+	orig_node->bat_iv.bcast_own_sum = data_ptr;
 
 	return 0;
 }
@@ -739,10 +721,10 @@ int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 
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
diff --git a/types.h b/types.h
index b08c3c7..0159cde 100644
--- a/types.h
+++ b/types.h
@@ -133,14 +133,28 @@ struct batadv_orig_node_vlan {
 };
 
 /**
+ * struct batadv_orig_bat_iv - B.A.T.M.A.N. IV private orig_node members
+ * @bcast_own: bitfield containing the number of our OGMs this orig_node
+ *  rebroadcasted "back" to us (relative to last_real_seqno)
+ * @bcast_own_sum: counted result of bcast_own
+ * @ogm_cnt_lock: lock protecting bcast_own, bcast_own_sum,
+ *  neigh_node->bat_iv.real_bits & neigh_node->bat_iv.real_packet_count
+ */
+struct batadv_orig_bat_iv {
+	unsigned long *bcast_own;
+	uint8_t *bcast_own_sum;
+	/* ogm_cnt_lock protects: bcast_own, bcast_own_sum,
+	 * neigh_node->bat_iv.real_bits & neigh_node->bat_iv.real_packet_count
+	 */
+	spinlock_t ogm_cnt_lock;
+};
+
+/**
  * struct batadv_orig_node - structure for orig_list maintaining nodes of mesh
  * @orig: originator ethernet address
  * @primary_addr: hosts primary interface address
  * @router: router that should be used to reach this originator
  * @batadv_dat_addr_t:  address of the orig node in the distributed hash
- * @bcast_own: bitfield containing the number of our OGMs this orig_node
- *  rebroadcasted "back" to us (relative to last_real_seqno)
- * @bcast_own_sum: counted result of bcast_own
  * @last_seen: time when last packet from this node was received
  * @bcast_seqno_reset: time when the broadcast seqno window was reset
  * @batman_seqno_reset: time when the batman seqno window was reset
@@ -166,8 +180,6 @@ struct batadv_orig_node_vlan {
  * @neigh_list_lock: lock protecting neigh_list, router and bonding_list
  * @hash_entry: hlist node for batadv_priv::orig_hash
  * @bat_priv: pointer to soft_iface this orig node belongs to
- * @ogm_cnt_lock: lock protecting bcast_own, bcast_own_sum,
- *  neigh_node->real_bits & neigh_node->real_packet_count
  * @bcast_seqno_lock: lock protecting bcast_bits & last_bcast_seqno
  * @bond_candidates: how many candidates are available
  * @bond_list: list of bonding candidates
@@ -181,6 +193,7 @@ struct batadv_orig_node_vlan {
  * @vlan_list: a list of orig_node_vlan structs, one per VLAN served by the
  *  originator represented by this object
  * @vlan_list_lock: lock protecting vlan_list
+ * @bat_iv: B.A.T.M.A.N. IV private structure
  */
 struct batadv_orig_node {
 	uint8_t orig[ETH_ALEN];
@@ -189,8 +202,6 @@ struct batadv_orig_node {
 #ifdef CONFIG_BATMAN_ADV_DAT
 	batadv_dat_addr_t dat_addr;
 #endif
-	unsigned long *bcast_own;
-	uint8_t *bcast_own_sum;
 	unsigned long last_seen;
 	unsigned long bcast_seqno_reset;
 	unsigned long batman_seqno_reset;
@@ -211,10 +222,6 @@ struct batadv_orig_node {
 	spinlock_t neigh_list_lock;
 	struct hlist_node hash_entry;
 	struct batadv_priv *bat_priv;
-	/* ogm_cnt_lock protects: bcast_own, bcast_own_sum,
-	 * neigh_node->real_bits & neigh_node->real_packet_count
-	 */
-	spinlock_t ogm_cnt_lock;
 	/* bcast_seqno_lock protects: bcast_bits & last_bcast_seqno */
 	spinlock_t bcast_seqno_lock;
 	atomic_t bond_candidates;
@@ -230,6 +237,7 @@ struct batadv_orig_node {
 	struct batadv_frag_table_entry fragments[BATADV_FRAG_BUFFER_COUNT];
 	struct list_head vlan_list;
 	spinlock_t vlan_list_lock; /* protects vlan_list */
+	struct batadv_orig_bat_iv bat_iv;
 };
 
 /**
-- 
1.8.1.5

