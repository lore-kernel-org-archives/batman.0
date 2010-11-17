Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 17 Nov 2010 02:26:31 +0100
Message-Id: <1289957194-5455-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201011170226.09739.lindner_marek@yahoo.de>
References: <201011170226.09739.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/8] batman-adv: protect each hash row with
	rcu locks
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/hash.c              |   46 +++++++++++----
 batman-adv/hash.h              |  125 ++++++++++++++++++++++++++--------------
 batman-adv/icmp_socket.c       |    2 +
 batman-adv/originator.c        |    2 +
 batman-adv/routing.c           |   12 ++++
 batman-adv/translation-table.c |   15 +++++
 batman-adv/unicast.c           |    7 ++-
 batman-adv/vis.c               |    4 +
 8 files changed, 157 insertions(+), 56 deletions(-)

diff --git a/batman-adv/hash.c b/batman-adv/hash.c
index 8605e2f..e2266f6 100644
--- a/batman-adv/hash.c
+++ b/batman-adv/hash.c
@@ -29,13 +29,16 @@ static void hash_init(struct hashtable_t *hash)
 
 	hash->elements = 0;
 
-	for (i = 0 ; i < hash->size; i++)
+	for (i = 0 ; i < hash->size; i++) {
 		INIT_HLIST_HEAD(&hash->table[i]);
+		spin_lock_init(&hash->list_locks[i]);
+	}
 }
 
 /* free only the hashtable and the hash itself. */
 void hash_destroy(struct hashtable_t *hash)
 {
+	kfree(hash->list_locks);
 	kfree(hash->table);
 	kfree(hash);
 }
@@ -45,22 +48,35 @@ struct hashtable_t *hash_new(int size)
 {
 	struct hashtable_t *hash;
 
-	hash = kmalloc(sizeof(struct hashtable_t) , GFP_ATOMIC);
-
-	if (hash == NULL)
+	hash = kmalloc(sizeof(struct hashtable_t), GFP_ATOMIC);
+	if (!hash)
 		return NULL;
 
-	hash->size = size;
 	hash->table = kmalloc(sizeof(struct element_t *) * size, GFP_ATOMIC);
+	if (!hash->table)
+		goto free_hash;
 
-	if (hash->table == NULL) {
-		kfree(hash);
-		return NULL;
-	}
+	hash->list_locks = kmalloc(sizeof(spinlock_t) * size, GFP_ATOMIC);
+	if (!hash->list_locks)
+		goto free_table;
 
+	hash->size = size;
 	hash_init(hash);
-
 	return hash;
+
+free_table:
+	kfree(hash->table);
+free_hash:
+	kfree(hash);
+	return NULL;
+}
+
+void bucket_free_rcu(struct rcu_head *rcu)
+{
+	struct element_t *bucket;
+
+	bucket = container_of(rcu, struct element_t, rcu);
+	kfree(bucket);
 }
 
 /* remove bucket (this might be used in hash_iterate() if you already found the
@@ -71,12 +87,18 @@ void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t)
 {
 	void *data_save;
 	struct element_t *bucket;
+	spinlock_t *list_lock;
+
+	list_lock = &hash->list_locks[hash_it_t->index];
 
 	bucket = hlist_entry(hash_it_t->walk, struct element_t, hlist);
 	data_save = bucket->data;
 
-	hlist_del(hash_it_t->walk);
-	kfree(bucket);
+	spin_lock_bh(list_lock);
+	hlist_del_rcu(hash_it_t->walk);
+	spin_unlock_bh(list_lock);
+
+	call_rcu(&bucket->rcu, bucket_free_rcu);
 	hash->elements--;
 
 	return data_save;
diff --git a/batman-adv/hash.h b/batman-adv/hash.h
index ab67dcf..3ebfe5a 100644
--- a/batman-adv/hash.h
+++ b/batman-adv/hash.h
@@ -43,6 +43,7 @@ typedef void (*hashdata_free_cb)(void *, void *);
 struct element_t {
 	void *data;		/* pointer to the data */
 	struct hlist_node hlist;	/* bucket list pointer */
+	struct rcu_head rcu;
 };
 
 struct hash_it_t {
@@ -52,7 +53,8 @@ struct hash_it_t {
 };
 
 struct hashtable_t {
-	struct hlist_head *table;   /* the hashtable itself, with the buckets */
+	struct hlist_head *table;   /* the hashtable itself with the buckets */
+	spinlock_t *list_locks;     /* spinlock for each hash list entry */
 	int elements;		    /* number of elements registered */
 	int size;		    /* size of hashtable */
 };
@@ -69,6 +71,8 @@ void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t);
 /* free only the hashtable and the hash itself. */
 void hash_destroy(struct hashtable_t *hash);
 
+void bucket_free_rcu(struct rcu_head *rcu);
+
 /* remove the hash structure. if hashdata_free_cb != NULL, this function will be
  * called to remove the elements inside of the hash.  if you don't remove the
  * elements, memory might be leaked. */
@@ -78,19 +82,22 @@ static inline void hash_delete(struct hashtable_t *hash,
 	struct hlist_head *head;
 	struct hlist_node *walk, *safe;
 	struct element_t *bucket;
+	spinlock_t *list_lock;
 	int i;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
 
-		hlist_for_each_safe(walk, safe, head) {
-			bucket = hlist_entry(walk, struct element_t, hlist);
-			if (free_cb != NULL)
+		spin_lock_bh(list_lock);
+		hlist_for_each_entry_safe(bucket, walk, safe, head, hlist) {
+			if (free_cb)
 				free_cb(bucket->data, arg);
 
-			hlist_del(walk);
-			kfree(bucket);
+			hlist_del_rcu(walk);
+			call_rcu(&bucket->rcu, bucket_free_rcu);
 		}
+		spin_unlock_bh(list_lock);
 	}
 
 	hash_destroy(hash);
@@ -105,30 +112,40 @@ static inline int hash_add(struct hashtable_t *hash,
 	struct hlist_head *head;
 	struct hlist_node *walk, *safe;
 	struct element_t *bucket;
+	spinlock_t *list_lock;
 
 	if (!hash)
-		return -1;
+		goto err;
 
 	index = choose(data, hash->size);
 	head = &hash->table[index];
+	list_lock = &hash->list_locks[index];
 
-	hlist_for_each_safe(walk, safe, head) {
-		bucket = hlist_entry(walk, struct element_t, hlist);
+	rcu_read_lock();
+	hlist_for_each_entry_safe(bucket, walk, safe, head, hlist) {
 		if (compare(bucket->data, data))
-			return -1;
+			goto err_unlock;
 	}
+	rcu_read_unlock();
 
 	/* no duplicate found in list, add new element */
 	bucket = kmalloc(sizeof(struct element_t), GFP_ATOMIC);
-
-	if (bucket == NULL)
-		return -1;
+	if (!bucket)
+		goto err;
 
 	bucket->data = data;
-	hlist_add_head(&bucket->hlist, head);
+
+	spin_lock_bh(list_lock);
+	hlist_add_head_rcu(&bucket->hlist, head);
+	spin_unlock_bh(list_lock);
 
 	hash->elements++;
 	return 0;
+
+err_unlock:
+	rcu_read_unlock();
+err:
+	return -1;
 }
 
 /* removes data from hash, if found. returns pointer do data on success, so you
@@ -142,21 +159,29 @@ static inline void *hash_remove(struct hashtable_t *hash,
 	struct hash_it_t hash_it_t;
 	struct element_t *bucket;
 	struct hlist_head *head;
+	void *bucket_data = NULL;
 
 	hash_it_t.index = choose(data, hash->size);
 	head = &hash->table[hash_it_t.index];
 
-	hlist_for_each(hash_it_t.walk, head) {
-		bucket = hlist_entry(hash_it_t.walk, struct element_t, hlist);
-		if (compare(bucket->data, data))
-			return hash_remove_bucket(hash, &hash_it_t);
+	rcu_read_lock();
+	hlist_for_each_entry(bucket, hash_it_t.walk, head, hlist) {
+		if (compare(bucket->data, data)) {
+			bucket_data = hash_remove_bucket(hash, &hash_it_t);
+			break;
+		}
 	}
+	rcu_read_unlock();
 
-	return NULL;
+	return bucket_data;
 }
 
-/* finds data, based on the key in keydata. returns the found data on success,
- * or NULL on error */
+/**
+ * finds data, based on the key in keydata. returns the found data on success,
+ * or NULL on error
+ *
+ * caller must lock with rcu_read_lock() / rcu_read_unlock()
+ **/
 static inline void *hash_find(struct hashtable_t *hash,
 			      hashdata_compare_cb compare,
 			      hashdata_choose_cb choose, void *keydata)
@@ -165,6 +190,7 @@ static inline void *hash_find(struct hashtable_t *hash,
 	struct hlist_head *head;
 	struct hlist_node *walk;
 	struct element_t *bucket;
+	void *bucket_data = NULL;
 
 	if (!hash)
 		return NULL;
@@ -172,50 +198,63 @@ static inline void *hash_find(struct hashtable_t *hash,
 	index = choose(keydata , hash->size);
 	head = &hash->table[index];
 
-	hlist_for_each(walk, head) {
-		bucket = hlist_entry(walk, struct element_t, hlist);
-		if (compare(bucket->data, keydata))
-			return bucket->data;
+	hlist_for_each_entry(bucket, walk, head, hlist) {
+		if (compare(bucket->data, keydata)) {
+			bucket_data = bucket->data;
+			break;
+		}
 	}
 
-	return NULL;
+	return bucket_data;
 }
 
-/* iterate though the hash. First element is selected if an iterator
+/**
+ * iterate though the hash. First element is selected if an iterator
  * initialized with HASHIT() is supplied as iter. Use the returned
  * (or supplied) iterator to access the elements until hash_iterate returns
- * NULL. */
+ * NULL.
+ *
+ * caller must lock with rcu_read_lock() / rcu_read_unlock()
+ **/
 static inline struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 					     struct hash_it_t *iter)
 {
 	if (!hash)
-		return NULL;
+		goto out;
+
 	if (!iter)
-		return NULL;
+		goto out;
 
 	iter->walk = iter->safe;
 
 	/* we search for the next head with list entries */
-	if (!iter->walk) {
-		while (iter->index < hash->size) {
-			if (hlist_empty(&hash->table[iter->index]))
-				iter->index++;
-			else {
-				iter->walk = hash->table[iter->index].first;
-
-				/* search next time */
-				++iter->index;
-				break;
-			}
+	if (iter->walk)
+		goto iter_next;
+
+	while (iter->index < hash->size) {
+		if (hlist_empty(&hash->table[iter->index])) {
+			iter->index++;
+			continue;
 		}
+
+		iter->walk =
+			rcu_dereference(hash->table[iter->index].first);
+
+		/* search next time */
+		++iter->index;
+		break;
 	}
 
 	/* return iter when we found bucket otherwise null */
 	if (!iter->walk)
-		return NULL;
+		goto out;
 
-	iter->safe = iter->walk->next;
+iter_next:
+	iter->safe = rcu_dereference(iter->walk->next);
 	return iter;
+
+out:
+	return NULL;
 }
 
 #endif /* _NET_BATMAN_ADV_HASH_H_ */
diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index ecf6d7f..a9a10ed 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
@@ -221,9 +221,11 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 		goto dst_unreach;
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
+	rcu_read_lock();
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
 						   compare_orig, choose_orig,
 						   icmp_packet->dst));
+	rcu_read_unlock();
 
 	if (!orig_node)
 		goto unlock;
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 0150566..8847bdd 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -150,9 +150,11 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	int size;
 	int hash_added;
 
+	rcu_read_lock();
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
 						   compare_orig, choose_orig,
 						   addr));
+	rcu_read_unlock();
 
 	if (orig_node)
 		return orig_node;
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 34df9c1..0b4ebfb 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -850,9 +850,11 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	/* answer echo request (ping) */
 	/* get routing information */
 	spin_lock_bh(&bat_priv->orig_hash_lock);
+	rcu_read_lock();
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
 						   compare_orig, choose_orig,
 						   icmp_packet->orig));
+	rcu_read_unlock();
 	ret = NET_RX_DROP;
 
 	if ((orig_node != NULL) &&
@@ -912,9 +914,11 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 
 	/* get routing information */
 	spin_lock_bh(&bat_priv->orig_hash_lock);
+	rcu_read_lock();
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			       icmp_packet->orig));
+	rcu_read_unlock();
 	ret = NET_RX_DROP;
 
 	if ((orig_node != NULL) &&
@@ -1006,9 +1010,11 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 	/* get routing information */
 	spin_lock_bh(&bat_priv->orig_hash_lock);
+	rcu_read_lock();
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			       icmp_packet->dst));
+	rcu_read_unlock();
 
 	if ((orig_node != NULL) &&
 	    (orig_node->router != NULL)) {
@@ -1079,9 +1085,11 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 				router_orig->orig, ETH_ALEN) == 0) {
 		primary_orig_node = router_orig;
 	} else {
+		rcu_read_lock();
 		primary_orig_node = hash_find(bat_priv->orig_hash, compare_orig,
 					       choose_orig,
 					       router_orig->primary_addr);
+		rcu_read_unlock();
 
 		if (!primary_orig_node)
 			return orig_node->router;
@@ -1184,9 +1192,11 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 
 	/* get routing information */
 	spin_lock_bh(&bat_priv->orig_hash_lock);
+	rcu_read_lock();
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			       unicast_packet->dest));
+	rcu_read_unlock();
 
 	router = find_router(bat_priv, orig_node, recv_if);
 
@@ -1330,9 +1340,11 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		return NET_RX_DROP;
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
+	rcu_read_lock();
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			       bcast_packet->orig));
+	rcu_read_unlock();
 
 	if (orig_node == NULL) {
 		spin_unlock_bh(&bat_priv->orig_hash_lock);
diff --git a/batman-adv/translation-table.c b/batman-adv/translation-table.c
index 72448c9..9592782 100644
--- a/batman-adv/translation-table.c
+++ b/batman-adv/translation-table.c
@@ -61,10 +61,12 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	int required_bytes;
 
 	spin_lock_bh(&bat_priv->hna_lhash_lock);
+	rcu_read_lock();
 	hna_local_entry =
 		((struct hna_local_entry *)hash_find(bat_priv->hna_local_hash,
 						     compare_orig, choose_orig,
 						     addr));
+	rcu_read_unlock();
 	spin_unlock_bh(&bat_priv->hna_lhash_lock);
 
 	if (hna_local_entry) {
@@ -117,9 +119,11 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	/* remove address from global hash if present */
 	spin_lock_bh(&bat_priv->hna_ghash_lock);
 
+	rcu_read_lock();
 	hna_global_entry = ((struct hna_global_entry *)
 				hash_find(bat_priv->hna_global_hash,
 					  compare_orig, choose_orig, addr));
+	rcu_read_unlock();
 
 	if (hna_global_entry)
 		_hna_global_del_orig(bat_priv, hna_global_entry,
@@ -237,9 +241,12 @@ void hna_local_remove(struct bat_priv *bat_priv,
 
 	spin_lock_bh(&bat_priv->hna_lhash_lock);
 
+	rcu_read_lock();
 	hna_local_entry = (struct hna_local_entry *)
 		hash_find(bat_priv->hna_local_hash, compare_orig, choose_orig,
 			  addr);
+	rcu_read_unlock();
+
 	if (hna_local_entry)
 		hna_local_del(bat_priv, hna_local_entry, message);
 
@@ -311,9 +318,11 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 		spin_lock_bh(&bat_priv->hna_ghash_lock);
 
 		hna_ptr = hna_buff + (hna_buff_count * ETH_ALEN);
+		rcu_read_lock();
 		hna_global_entry = (struct hna_global_entry *)
 			hash_find(bat_priv->hna_global_hash, compare_orig,
 				  choose_orig, hna_ptr);
+		rcu_read_unlock();
 
 		if (!hna_global_entry) {
 			spin_unlock_bh(&bat_priv->hna_ghash_lock);
@@ -345,9 +354,11 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 		spin_lock_bh(&bat_priv->hna_lhash_lock);
 
 		hna_ptr = hna_buff + (hna_buff_count * ETH_ALEN);
+		rcu_read_lock();
 		hna_local_entry = (struct hna_local_entry *)
 			hash_find(bat_priv->hna_local_hash, compare_orig,
 				  choose_orig, hna_ptr);
+		rcu_read_unlock();
 
 		if (hna_local_entry)
 			hna_local_del(bat_priv, hna_local_entry,
@@ -450,9 +461,11 @@ void hna_global_del_orig(struct bat_priv *bat_priv,
 
 	while ((hna_buff_count + 1) * ETH_ALEN <= orig_node->hna_buff_len) {
 		hna_ptr = orig_node->hna_buff + (hna_buff_count * ETH_ALEN);
+		rcu_read_lock();
 		hna_global_entry = (struct hna_global_entry *)
 			hash_find(bat_priv->hna_global_hash, compare_orig,
 				  choose_orig, hna_ptr);
+		rcu_read_unlock();
 
 		if ((hna_global_entry) &&
 		    (hna_global_entry->orig_node == orig_node))
@@ -488,9 +501,11 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv, uint8_t *addr)
 	struct hna_global_entry *hna_global_entry;
 
 	spin_lock_bh(&bat_priv->hna_ghash_lock);
+	rcu_read_lock();
 	hna_global_entry = (struct hna_global_entry *)
 				hash_find(bat_priv->hna_global_hash,
 					  compare_orig, choose_orig, addr);
+	rcu_read_unlock();
 	spin_unlock_bh(&bat_priv->hna_ghash_lock);
 
 	if (!hna_global_entry)
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 7b9385b..9df1c40 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -179,9 +179,11 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 
 	*new_skb = NULL;
 	spin_lock_bh(&bat_priv->orig_hash_lock);
+	rcu_read_lock();
 	orig_node = ((struct orig_node *)
 		    hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			      unicast_packet->orig));
+	rcu_read_unlock();
 
 	if (!orig_node) {
 		pr_debug("couldn't find originator in orig_hash\n");
@@ -285,11 +287,14 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	/* get routing information */
 	if (is_bcast(ethhdr->h_dest) || is_mcast(ethhdr->h_dest))
 		orig_node = (struct orig_node *)gw_get_selected(bat_priv);
-	else
+	else {
+		rcu_read_lock();
 		orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
 							   compare_orig,
 							   choose_orig,
 							   ethhdr->h_dest));
+		rcu_read_lock();
+	}
 
 	/* check for hna host */
 	if (!orig_node)
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index 65676dc..ff3fabf 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -364,8 +364,10 @@ static struct vis_info *add_packet(struct bat_priv *bat_priv,
 						     sizeof(struct vis_packet));
 
 	memcpy(search_packet->vis_orig, vis_packet->vis_orig, ETH_ALEN);
+	rcu_read_lock();
 	old_info = hash_find(bat_priv->vis_hash, vis_info_cmp, vis_info_choose,
 			     &search_elem);
+	rcu_read_unlock();
 	kfree_skb(search_elem.skb_packet);
 
 	if (old_info != NULL) {
@@ -717,9 +719,11 @@ static void unicast_vis_packet(struct bat_priv *bat_priv,
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 	packet = (struct vis_packet *)info->skb_packet->data;
+	rcu_read_lock();
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
 						   compare_orig, choose_orig,
 						   packet->target_orig));
+	rcu_read_unlock();
 
 	if ((!orig_node) || (!orig_node->router))
 		goto out;
-- 
1.7.2.3

