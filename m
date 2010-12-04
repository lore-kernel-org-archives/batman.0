Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  4 Dec 2010 21:03:41 +0100
Message-Id: <1291493028-29957-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201012042042.16056.sven.eckelmann@gmx.de>
References: <201012042042.16056.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/9] batman-adv: Remove hash_iterate
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

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
Removed hash_iterate completely as promised to David. This should also help
to create the later patches in a more cleaner way.

 batman-adv/hash.c              |   18 ---
 batman-adv/hash.h              |   75 ++-------
 batman-adv/originator.c        |  132 ++++++++++------
 batman-adv/routing.c           |   24 ++-
 batman-adv/translation-table.c |  110 +++++++++-----
 batman-adv/vis.c               |  328 +++++++++++++++++++++++-----------------
 6 files changed, 372 insertions(+), 315 deletions(-)

diff --git a/batman-adv/hash.c b/batman-adv/hash.c
index 3dedb06..fec9bbd 100644
--- a/batman-adv/hash.c
+++ b/batman-adv/hash.c
@@ -60,21 +60,3 @@ struct hashtable_t *hash_new(int size)
 
 	return hash;
 }
-
-/* remove bucket (this might be used in hash_iterate() if you already found the
- * bucket you want to delete and don't need the overhead to find it again with
- * hash_remove(). But usually, you don't want to use this function, as it
- * fiddles with hash-internals. */
-void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t)
-{
-	void *data_save;
-	struct element_t *bucket;
-
-	bucket = hlist_entry(hash_it_t->walk, struct element_t, hlist);
-	data_save = bucket->data;
-
-	hlist_del(hash_it_t->walk);
-	kfree(bucket);
-
-	return data_save;
-}
diff --git a/batman-adv/hash.h b/batman-adv/hash.h
index 16b23bf..0801f9c 100644
--- a/batman-adv/hash.h
+++ b/batman-adv/hash.h
@@ -24,10 +24,6 @@
 
 #include <linux/list.h>
 
-#define HASHIT(name) struct hash_it_t name = { \
-		.index = 0, .walk = NULL, \
-		.safe = NULL}
-
 /* callback to a compare function.  should
  * compare 2 element datas for their keys,
  * return 0 if same and not 0 if not
@@ -45,12 +41,6 @@ struct element_t {
 	struct hlist_node hlist;	/* bucket list pointer */
 };
 
-struct hash_it_t {
-	size_t index;
-	struct hlist_node *walk;
-	struct hlist_node *safe;
-};
-
 struct hashtable_t {
 	struct hlist_head *table;   /* the hashtable itself, with the buckets */
 	int size;		    /* size of hashtable */
@@ -59,11 +49,10 @@ struct hashtable_t {
 /* allocates and clears the hash */
 struct hashtable_t *hash_new(int size);
 
-/* remove bucket (this might be used in hash_iterate() if you already found the
- * bucket you want to delete and don't need the overhead to find it again with
- * hash_remove().  But usually, you don't want to use this function, as it
- * fiddles with hash-internals. */
-void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t);
+/* remove element if you already found the element you want to delete and don't
+ * need the overhead to find it again with hash_remove().  But usually, you
+ * don't want to use this function, as it fiddles with hash-internals. */
+void *hash_remove_element(struct hashtable_t *hash, struct element_t *elem);
 
 /* free only the hashtable and the hash itself. */
 void hash_destroy(struct hashtable_t *hash);
@@ -137,17 +126,22 @@ static inline void *hash_remove(struct hashtable_t *hash,
 				hashdata_compare_cb compare,
 				hashdata_choose_cb choose, void *data)
 {
-	struct hash_it_t hash_it_t;
+	size_t index;
+	struct hlist_node *walk;
 	struct element_t *bucket;
 	struct hlist_head *head;
+	void *data_save;
 
-	hash_it_t.index = choose(data, hash->size);
-	head = &hash->table[hash_it_t.index];
+	index = choose(data, hash->size);
+	head = &hash->table[index];
 
-	hlist_for_each(hash_it_t.walk, head) {
-		bucket = hlist_entry(hash_it_t.walk, struct element_t, hlist);
-		if (compare(bucket->data, data))
-			return hash_remove_bucket(hash, &hash_it_t);
+	hlist_for_each_entry(bucket, walk, head, hlist) {
+		if (compare(bucket->data, data)) {
+			data_save = bucket->data;
+			hlist_del(walk);
+			kfree(bucket);
+			return data_save;
+		}
 	}
 
 	return NULL;
@@ -179,41 +173,4 @@ static inline void *hash_find(struct hashtable_t *hash,
 	return NULL;
 }
 
-/* iterate though the hash. First element is selected if an iterator
- * initialized with HASHIT() is supplied as iter. Use the returned
- * (or supplied) iterator to access the elements until hash_iterate returns
- * NULL. */
-static inline struct hash_it_t *hash_iterate(struct hashtable_t *hash,
-					     struct hash_it_t *iter)
-{
-	if (!hash)
-		return NULL;
-	if (!iter)
-		return NULL;
-
-	iter->walk = iter->safe;
-
-	/* we search for the next head with list entries */
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
-		}
-	}
-
-	/* return iter when we found bucket otherwise null */
-	if (!iter->walk)
-		return NULL;
-
-	iter->safe = iter->walk->next;
-	return iter;
-}
-
 #endif /* _NET_BATMAN_ADV_HASH_H_ */
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index a5612e6..7b1fc52 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -256,27 +256,37 @@ static bool purge_orig_node(struct bat_priv *bat_priv,
 
 static void _purge_orig(struct bat_priv *bat_priv)
 {
-	HASHIT(hashit);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk, *safe;
+	struct hlist_head *head;
 	struct element_t *bucket;
 	struct orig_node *orig_node;
+	int i;
+
+	if (!hash)
+		return;
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 
 	/* for all origins... */
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		if (purge_orig_node(bat_priv, orig_node)) {
-			if (orig_node->gw_flags)
-				gw_node_delete(bat_priv, orig_node);
-			hash_remove_bucket(bat_priv->orig_hash, &hashit);
-			free_orig_node(orig_node, bat_priv);
+		hlist_for_each_entry_safe(bucket, walk, safe, head, hlist) {
+			orig_node = bucket->data;
+
+			if (purge_orig_node(bat_priv, orig_node)) {
+				if (orig_node->gw_flags)
+					gw_node_delete(bat_priv, orig_node);
+				hlist_del(walk);
+				kfree(bucket);
+				free_orig_node(orig_node, bat_priv);
+			}
+
+			if (time_after(jiffies, orig_node->last_frag_packet +
+						msecs_to_jiffies(FRAG_TIMEOUT)))
+				frag_list_free(&orig_node->frag_list);
 		}
-
-		if (time_after(jiffies, (orig_node->last_frag_packet +
-					msecs_to_jiffies(FRAG_TIMEOUT))))
-			frag_list_free(&orig_node->frag_list);
 	}
 
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
@@ -305,15 +315,18 @@ void purge_orig_ref(struct bat_priv *bat_priv)
 
 int orig_seq_print_text(struct seq_file *seq, void *offset)
 {
-	HASHIT(hashit);
-	struct element_t *bucket;
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk;
+	struct hlist_head *head;
+	struct element_t *bucket;
 	struct orig_node *orig_node;
 	struct neigh_node *neigh_node;
 	int batman_count = 0;
 	int last_seen_secs;
 	int last_seen_msecs;
+	int i;
 
 	if ((!bat_priv->primary_if) ||
 	    (bat_priv->primary_if->if_status != IF_ACTIVE)) {
@@ -337,33 +350,39 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		if (!orig_node->router)
-			continue;
+		hlist_for_each_entry(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
 
-		if (orig_node->router->tq_avg == 0)
-			continue;
+			if (!orig_node->router)
+				continue;
 
-		last_seen_secs = jiffies_to_msecs(jiffies -
+			if (orig_node->router->tq_avg == 0)
+				continue;
+
+			last_seen_secs = jiffies_to_msecs(jiffies -
 						orig_node->last_valid) / 1000;
-		last_seen_msecs = jiffies_to_msecs(jiffies -
+			last_seen_msecs = jiffies_to_msecs(jiffies -
 						orig_node->last_valid) % 1000;
 
-		seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
-			   orig_node->orig, last_seen_secs, last_seen_msecs,
-			   orig_node->router->tq_avg, orig_node->router->addr,
-			   orig_node->router->if_incoming->net_dev->name);
+			neigh_node = orig_node->router;
+			seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
+				   orig_node->orig, last_seen_secs,
+				   last_seen_msecs, neigh_node->tq_avg,
+				   neigh_node->addr,
+				   neigh_node->if_incoming->net_dev->name);
 
-		list_for_each_entry(neigh_node, &orig_node->neigh_list, list) {
-			seq_printf(seq, " %pM (%3i)", neigh_node->addr,
-					   neigh_node->tq_avg);
+			list_for_each_entry(neigh_node, &orig_node->neigh_list,
+					    list) {
+				seq_printf(seq, " %pM (%3i)", neigh_node->addr,
+						neigh_node->tq_avg);
+			}
+
+			seq_printf(seq, "\n");
+			batman_count++;
 		}
-
-		seq_printf(seq, "\n");
-		batman_count++;
 	}
 
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
@@ -407,20 +426,26 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 int orig_hash_add_if(struct batman_if *batman_if, int max_if_num)
 {
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
-	struct orig_node *orig_node;
-	HASHIT(hashit);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk;
+	struct hlist_head *head;
 	struct element_t *bucket;
+	struct orig_node *orig_node;
+	int i;
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		if (orig_node_add_if(orig_node, max_if_num) == -1)
-			goto err;
+		hlist_for_each_entry(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
+
+			if (orig_node_add_if(orig_node, max_if_num) == -1)
+				goto err;
+		}
 	}
 
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
@@ -486,25 +511,30 @@ free_own_sum:
 int orig_hash_del_if(struct batman_if *batman_if, int max_if_num)
 {
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk;
+	struct hlist_head *head;
+	struct element_t *bucket;
 	struct batman_if *batman_if_tmp;
 	struct orig_node *orig_node;
-	HASHIT(hashit);
-	struct element_t *bucket;
-	int ret;
+	int i, ret;
 
 	/* resize all orig nodes because orig_node->bcast_own(_sum) depend on
 	 * if_num */
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		ret = orig_node_del_if(orig_node, max_if_num,
-				       batman_if->if_num);
+		hlist_for_each_entry(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
 
-		if (ret == -1)
-			goto err;
+			ret = orig_node_del_if(orig_node, max_if_num,
+					batman_if->if_num);
+
+			if (ret == -1)
+				goto err;
+		}
 	}
 
 	/* renumber remaining batman interfaces _inside_ of orig_hash_lock */
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index d8b0c5a..8cec99b 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -39,21 +39,29 @@
 void slide_own_bcast_window(struct batman_if *batman_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
-	HASHIT(hashit);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk;
+	struct hlist_head *head;
 	struct element_t *bucket;
 	struct orig_node *orig_node;
 	TYPE_OF_WORD *word;
+	int i;
+	size_t word_index;
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
-		word = &(orig_node->bcast_own[batman_if->if_num * NUM_WORDS]);
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		bit_get_packet(bat_priv, word, 1, 0);
-		orig_node->bcast_own_sum[batman_if->if_num] =
-			bit_packet_count(word);
+		hlist_for_each_entry(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
+			word_index = batman_if->if_num * NUM_WORDS;
+			word = &(orig_node->bcast_own[word_index]);
+
+			bit_get_packet(bat_priv, word, 1, 0);
+			orig_node->bcast_own_sum[batman_if->if_num] =
+				bit_packet_count(word);
+		}
 	}
 
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
diff --git a/batman-adv/translation-table.c b/batman-adv/translation-table.c
index 72448c9..a19e16c 100644
--- a/batman-adv/translation-table.c
+++ b/batman-adv/translation-table.c
@@ -131,27 +131,34 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 int hna_local_fill_buffer(struct bat_priv *bat_priv,
 			  unsigned char *buff, int buff_len)
 {
+	struct hashtable_t *hash = bat_priv->hna_local_hash;
 	struct hna_local_entry *hna_local_entry;
 	struct element_t *bucket;
-	HASHIT(hashit);
-	int i = 0;
+	int i;
+	struct hlist_node *walk;
+	struct hlist_head *head;
+	int count = 0;
 
 	spin_lock_bh(&bat_priv->hna_lhash_lock);
 
-	while (hash_iterate(bat_priv->hna_local_hash, &hashit)) {
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		if (buff_len < (i + 1) * ETH_ALEN)
-			break;
+		hlist_for_each_entry(bucket, walk, head, hlist) {
 
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		hna_local_entry = bucket->data;
-		memcpy(buff + (i * ETH_ALEN), hna_local_entry->addr, ETH_ALEN);
+			if (buff_len < (count + 1) * ETH_ALEN)
+				break;
 
-		i++;
+			hna_local_entry = bucket->data;
+			memcpy(buff + (count * ETH_ALEN), hna_local_entry->addr,
+			       ETH_ALEN);
+
+			count++;
+		}
 	}
 
 	/* if we did not get all new local hnas see you next time  ;-) */
-	if (i == bat_priv->num_local_hna)
+	if (count == bat_priv->num_local_hna)
 		atomic_set(&bat_priv->hna_local_changed, 0);
 
 	spin_unlock_bh(&bat_priv->hna_lhash_lock);
@@ -162,9 +169,11 @@ int hna_local_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct hashtable_t *hash = bat_priv->hna_local_hash;
 	struct hna_local_entry *hna_local_entry;
-	HASHIT(hashit);
-	HASHIT(hashit_count);
+	int i;
+	struct hlist_node *walk;
+	struct hlist_head *head;
 	struct element_t *bucket;
 	size_t buf_size, pos;
 	char *buff;
@@ -183,8 +192,12 @@ int hna_local_seq_print_text(struct seq_file *seq, void *offset)
 
 	buf_size = 1;
 	/* Estimate length for: " * xx:xx:xx:xx:xx:xx\n" */
-	while (hash_iterate(bat_priv->hna_local_hash, &hashit_count))
-		buf_size += 21;
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		hlist_for_each(walk, head)
+			buf_size += 21;
+	}
 
 	buff = kmalloc(buf_size, GFP_ATOMIC);
 	if (!buff) {
@@ -194,12 +207,15 @@ int hna_local_seq_print_text(struct seq_file *seq, void *offset)
 	buff[0] = '\0';
 	pos = 0;
 
-	while (hash_iterate(bat_priv->hna_local_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		hna_local_entry = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		pos += snprintf(buff + pos, 22, " * %pM\n",
-				hna_local_entry->addr);
+		hlist_for_each_entry(bucket, walk, head, hlist) {
+			hna_local_entry = bucket->data;
+
+			pos += snprintf(buff + pos, 22, " * %pM\n",
+					hna_local_entry->addr);
+		}
 	}
 
 	spin_unlock_bh(&bat_priv->hna_lhash_lock);
@@ -240,6 +256,7 @@ void hna_local_remove(struct bat_priv *bat_priv,
 	hna_local_entry = (struct hna_local_entry *)
 		hash_find(bat_priv->hna_local_hash, compare_orig, choose_orig,
 			  addr);
+
 	if (hna_local_entry)
 		hna_local_del(bat_priv, hna_local_entry, message);
 
@@ -252,23 +269,30 @@ static void hna_local_purge(struct work_struct *work)
 		container_of(work, struct delayed_work, work);
 	struct bat_priv *bat_priv =
 		container_of(delayed_work, struct bat_priv, hna_work);
+	struct hashtable_t *hash = bat_priv->hna_local_hash;
 	struct hna_local_entry *hna_local_entry;
-	HASHIT(hashit);
+	int i;
+	struct hlist_node *walk, *safe;
+	struct hlist_head *head;
 	struct element_t *bucket;
 	unsigned long timeout;
 
 	spin_lock_bh(&bat_priv->hna_lhash_lock);
 
-	while (hash_iterate(bat_priv->hna_local_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		hna_local_entry = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		timeout = hna_local_entry->last_seen + LOCAL_HNA_TIMEOUT * HZ;
+		hlist_for_each_entry_safe(bucket, walk, safe, head, hlist) {
+			hna_local_entry = bucket->data;
 
-		if ((!hna_local_entry->never_purge) &&
-		    time_after(jiffies, timeout))
-			hna_local_del(bat_priv, hna_local_entry,
-				      "address timed out");
+			timeout = hna_local_entry->last_seen;
+			timeout += LOCAL_HNA_TIMEOUT * HZ;
+
+			if ((!hna_local_entry->never_purge) &&
+			    time_after(jiffies, timeout))
+				hna_local_del(bat_priv, hna_local_entry,
+					"address timed out");
+		}
 	}
 
 	spin_unlock_bh(&bat_priv->hna_lhash_lock);
@@ -375,9 +399,11 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct hashtable_t *hash = bat_priv->hna_global_hash;
 	struct hna_global_entry *hna_global_entry;
-	HASHIT(hashit);
-	HASHIT(hashit_count);
+	int i;
+	struct hlist_node *walk;
+	struct hlist_head *head;
 	struct element_t *bucket;
 	size_t buf_size, pos;
 	char *buff;
@@ -395,8 +421,12 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 
 	buf_size = 1;
 	/* Estimate length for: " * xx:xx:xx:xx:xx:xx via xx:xx:xx:xx:xx:xx\n"*/
-	while (hash_iterate(bat_priv->hna_global_hash, &hashit_count))
-		buf_size += 43;
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		hlist_for_each(walk, head)
+			buf_size += 43;
+	}
 
 	buff = kmalloc(buf_size, GFP_ATOMIC);
 	if (!buff) {
@@ -406,13 +436,17 @@ int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 	buff[0] = '\0';
 	pos = 0;
 
-	while (hash_iterate(bat_priv->hna_global_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		hna_global_entry = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		pos += snprintf(buff + pos, 44,
-				" * %pM via %pM\n", hna_global_entry->addr,
-				hna_global_entry->orig_node->orig);
+		hlist_for_each_entry(bucket, walk, head, hlist) {
+			hna_global_entry = bucket->data;
+
+			pos += snprintf(buff + pos, 44,
+					" * %pM via %pM\n",
+					hna_global_entry->addr,
+					hna_global_entry->orig_node->orig);
+		}
 	}
 
 	spin_unlock_bh(&bat_priv->hna_ghash_lock);
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index 957a086..d7f5b6b 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -174,21 +174,23 @@ static ssize_t vis_data_read_entry(char *buff, struct vis_info_entry *entry,
 
 int vis_seq_print_text(struct seq_file *seq, void *offset)
 {
-	HASHIT(hashit);
-	HASHIT(hashit_count);
+	struct hlist_node *walk;
+	struct hlist_head *head;
 	struct element_t *bucket;
 	struct vis_info *info;
 	struct vis_packet *packet;
 	struct vis_info_entry *entries;
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct hashtable_t *hash = bat_priv->vis_hash;
 	HLIST_HEAD(vis_if_list);
 	struct if_list_entry *entry;
 	struct hlist_node *pos, *n;
-	int i;
+	int i, j;
 	int vis_server = atomic_read(&bat_priv->vis_mode);
 	size_t buff_pos, buf_size;
 	char *buff;
+	int compare;
 
 	if ((!bat_priv->primary_if) ||
 	    (vis_server == VIS_TYPE_CLIENT_UPDATE))
@@ -197,35 +199,41 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 	buf_size = 1;
 	/* Estimate length */
 	spin_lock_bh(&bat_priv->vis_hash_lock);
-	while (hash_iterate(bat_priv->vis_hash, &hashit_count)) {
-		bucket = hlist_entry(hashit_count.walk, struct element_t,
-				     hlist);
-		info = bucket->data;
-		packet = (struct vis_packet *)info->skb_packet->data;
-		entries = (struct vis_info_entry *)
-			  ((char *)packet + sizeof(struct vis_packet));
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		for (i = 0; i < packet->entries; i++) {
-			if (entries[i].quality == 0)
-				continue;
-			vis_data_insert_interface(entries[i].src, &vis_if_list,
-				compare_orig(entries[i].src, packet->vis_orig));
-		}
+		hlist_for_each_entry(bucket, walk, head, hlist) {
+			info = bucket->data;
+			packet = (struct vis_packet *)info->skb_packet->data;
+			entries = (struct vis_info_entry *)
+				((char *)packet + sizeof(struct vis_packet));
 
-		hlist_for_each_entry(entry, pos, &vis_if_list, list) {
-			buf_size += 18 + 26 * packet->entries;
+			for (j = 0; j < packet->entries; j++) {
+				if (entries[j].quality == 0)
+					continue;
+				compare =
+				 compare_orig(entries[j].src, packet->vis_orig);
+				vis_data_insert_interface(entries[j].src,
+							  &vis_if_list,
+							  compare);
+			}
 
-			/* add primary/secondary records */
-			if (compare_orig(entry->addr, packet->vis_orig))
-				buf_size +=
-					vis_data_count_prim_sec(&vis_if_list);
+			hlist_for_each_entry(entry, pos, &vis_if_list, list) {
+				buf_size += 18 + 26 * packet->entries;
 
-			buf_size += 1;
-		}
+				/* add primary/secondary records */
+				if (compare_orig(entry->addr, packet->vis_orig))
+					buf_size +=
+					  vis_data_count_prim_sec(&vis_if_list);
 
-		hlist_for_each_entry_safe(entry, pos, n, &vis_if_list, list) {
-			hlist_del(&entry->list);
-			kfree(entry);
+				buf_size += 1;
+			}
+
+			hlist_for_each_entry_safe(entry, pos, n, &vis_if_list,
+						  list) {
+				hlist_del(&entry->list);
+				kfree(entry);
+			}
 		}
 	}
 
@@ -237,42 +245,50 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 	buff[0] = '\0';
 	buff_pos = 0;
 
-	while (hash_iterate(bat_priv->vis_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		info = bucket->data;
-		packet = (struct vis_packet *)info->skb_packet->data;
-		entries = (struct vis_info_entry *)
-			  ((char *)packet + sizeof(struct vis_packet));
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		for (i = 0; i < packet->entries; i++) {
-			if (entries[i].quality == 0)
-				continue;
-			vis_data_insert_interface(entries[i].src, &vis_if_list,
-				compare_orig(entries[i].src, packet->vis_orig));
-		}
+		hlist_for_each_entry(bucket, walk, head, hlist) {
+			info = bucket->data;
+			packet = (struct vis_packet *)info->skb_packet->data;
+			entries = (struct vis_info_entry *)
+				((char *)packet + sizeof(struct vis_packet));
 
-		hlist_for_each_entry(entry, pos, &vis_if_list, list) {
-			buff_pos += sprintf(buff + buff_pos, "%pM,",
-					    entry->addr);
+			for (j = 0; j < packet->entries; j++) {
+				if (entries[j].quality == 0)
+					continue;
+				compare =
+				 compare_orig(entries[j].src, packet->vis_orig);
+				vis_data_insert_interface(entries[j].src,
+							  &vis_if_list,
+							  compare);
+			}
 
-			for (i = 0; i < packet->entries; i++)
-				buff_pos += vis_data_read_entry(buff + buff_pos,
-								&entries[i],
-								entry->addr,
-								entry->primary);
+			hlist_for_each_entry(entry, pos, &vis_if_list, list) {
+				buff_pos += sprintf(buff + buff_pos, "%pM,",
+						entry->addr);
 
-			/* add primary/secondary records */
-			if (compare_orig(entry->addr, packet->vis_orig))
-				buff_pos +=
-					vis_data_read_prim_sec(buff + buff_pos,
-							       &vis_if_list);
+				for (i = 0; i < packet->entries; i++)
+					buff_pos += vis_data_read_entry(
+							buff + buff_pos,
+							&entries[i],
+							entry->addr,
+							entry->primary);
 
-			buff_pos += sprintf(buff + buff_pos, "\n");
-		}
+				/* add primary/secondary records */
+				if (compare_orig(entry->addr, packet->vis_orig))
+					buff_pos +=
+					 vis_data_read_prim_sec(buff + buff_pos,
+								&vis_if_list);
 
-		hlist_for_each_entry_safe(entry, pos, n, &vis_if_list, list) {
-			hlist_del(&entry->list);
-			kfree(entry);
+				buff_pos += sprintf(buff + buff_pos, "\n");
+			}
+
+			hlist_for_each_entry_safe(entry, pos, n, &vis_if_list,
+						  list) {
+				hlist_del(&entry->list);
+				kfree(entry);
+			}
 		}
 	}
 
@@ -511,24 +527,31 @@ end:
 static int find_best_vis_server(struct bat_priv *bat_priv,
 				struct vis_info *info)
 {
-	HASHIT(hashit);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk;
+	struct hlist_head *head;
 	struct element_t *bucket;
 	struct orig_node *orig_node;
 	struct vis_packet *packet;
-	int best_tq = -1;
+	int best_tq = -1, i;
 
 	packet = (struct vis_packet *)info->skb_packet->data;
 
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
-		if ((orig_node) && (orig_node->router) &&
-		    (orig_node->flags & VIS_SERVER) &&
-		    (orig_node->router->tq_avg > best_tq)) {
-			best_tq = orig_node->router->tq_avg;
-			memcpy(packet->target_orig, orig_node->orig, ETH_ALEN);
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		hlist_for_each_entry(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
+			if ((orig_node) && (orig_node->router) &&
+			(orig_node->flags & VIS_SERVER) &&
+			(orig_node->router->tq_avg > best_tq)) {
+				best_tq = orig_node->router->tq_avg;
+				memcpy(packet->target_orig, orig_node->orig,
+				       ETH_ALEN);
+			}
 		}
 	}
+
 	return best_tq;
 }
 
@@ -548,15 +571,17 @@ static bool vis_packet_full(struct vis_info *info)
  * returns 0 on success, -1 if no packet could be generated */
 static int generate_vis_packet(struct bat_priv *bat_priv)
 {
-	HASHIT(hashit_local);
-	HASHIT(hashit_global);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk;
+	struct hlist_head *head;
 	struct element_t *bucket;
 	struct orig_node *orig_node;
+	struct neigh_node *neigh_node;
 	struct vis_info *info = (struct vis_info *)bat_priv->my_vis_info;
 	struct vis_packet *packet = (struct vis_packet *)info->skb_packet->data;
 	struct vis_info_entry *entry;
 	struct hna_local_entry *hna_local_entry;
-	int best_tq = -1;
+	int best_tq = -1, i;
 
 	info->first_seen = jiffies;
 	packet->vis_type = atomic_read(&bat_priv->vis_mode);
@@ -577,56 +602,64 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 		}
 	}
 
-	while (hash_iterate(bat_priv->orig_hash, &hashit_global)) {
-		bucket = hlist_entry(hashit_global.walk, struct element_t,
-				     hlist);
-		orig_node = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		if (!orig_node->router)
-			continue;
+		hlist_for_each_entry(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
+			neigh_node = orig_node->router;
 
-		if (!compare_orig(orig_node->router->addr, orig_node->orig))
-			continue;
+			if (!neigh_node)
+				continue;
 
-		if (orig_node->router->if_incoming->if_status != IF_ACTIVE)
-			continue;
+			if (!compare_orig(neigh_node->addr, orig_node->orig))
+				continue;
 
-		if (orig_node->router->tq_avg < 1)
-			continue;
+			if (neigh_node->if_incoming->if_status != IF_ACTIVE)
+				continue;
 
-		/* fill one entry into buffer. */
-		entry = (struct vis_info_entry *)
-				skb_put(info->skb_packet, sizeof(*entry));
-		memcpy(entry->src,
-		       orig_node->router->if_incoming->net_dev->dev_addr,
-		       ETH_ALEN);
-		memcpy(entry->dest, orig_node->orig, ETH_ALEN);
-		entry->quality = orig_node->router->tq_avg;
-		packet->entries++;
+			if (neigh_node->tq_avg < 1)
+				continue;
 
-		if (vis_packet_full(info)) {
-			spin_unlock_bh(&bat_priv->orig_hash_lock);
-			return 0;
+			/* fill one entry into buffer. */
+			entry = (struct vis_info_entry *)
+				      skb_put(info->skb_packet, sizeof(*entry));
+			memcpy(entry->src,
+			       neigh_node->if_incoming->net_dev->dev_addr,
+			       ETH_ALEN);
+			memcpy(entry->dest, orig_node->orig, ETH_ALEN);
+			entry->quality = neigh_node->tq_avg;
+			packet->entries++;
+
+			if (vis_packet_full(info)) {
+				spin_unlock_bh(&bat_priv->orig_hash_lock);
+				return 0;
+			}
 		}
 	}
 
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
+	hash = bat_priv->hna_local_hash;
+
 	spin_lock_bh(&bat_priv->hna_lhash_lock);
-	while (hash_iterate(bat_priv->hna_local_hash, &hashit_local)) {
-		bucket = hlist_entry(hashit_local.walk, struct element_t,
-				     hlist);
-		hna_local_entry = bucket->data;
-		entry = (struct vis_info_entry *)skb_put(info->skb_packet,
-							 sizeof(*entry));
-		memset(entry->src, 0, ETH_ALEN);
-		memcpy(entry->dest, hna_local_entry->addr, ETH_ALEN);
-		entry->quality = 0; /* 0 means HNA */
-		packet->entries++;
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		if (vis_packet_full(info)) {
-			spin_unlock_bh(&bat_priv->hna_lhash_lock);
-			return 0;
+		hlist_for_each_entry(bucket, walk, head, hlist) {
+			hna_local_entry = bucket->data;
+			entry = (struct vis_info_entry *)
+					skb_put(info->skb_packet,
+						sizeof(*entry));
+			memset(entry->src, 0, ETH_ALEN);
+			memcpy(entry->dest, hna_local_entry->addr, ETH_ALEN);
+			entry->quality = 0; /* 0 means HNA */
+			packet->entries++;
+
+			if (vis_packet_full(info)) {
+				spin_unlock_bh(&bat_priv->hna_lhash_lock);
+				return 0;
+			}
 		}
 	}
 
@@ -638,23 +671,30 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
  * held */
 static void purge_vis_packets(struct bat_priv *bat_priv)
 {
-	HASHIT(hashit);
+	int i;
+	struct hashtable_t *hash = bat_priv->vis_hash;
+	struct hlist_node *walk, *safe;
+	struct hlist_head *head;
 	struct element_t *bucket;
 	struct vis_info *info;
 
-	while (hash_iterate(bat_priv->vis_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		info = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		/* never purge own data. */
-		if (info == bat_priv->my_vis_info)
-			continue;
+		hlist_for_each_entry_safe(bucket, walk, safe, head, hlist) {
+			info = bucket->data;
 
-		if (time_after(jiffies,
-			       info->first_seen + VIS_TIMEOUT * HZ)) {
-			hash_remove_bucket(bat_priv->vis_hash, &hashit);
-			send_list_del(info);
-			kref_put(&info->refcount, free_info);
+			/* never purge own data. */
+			if (info == bat_priv->my_vis_info)
+				continue;
+
+			if (time_after(jiffies,
+				       info->first_seen + VIS_TIMEOUT * HZ)) {
+				hlist_del(walk);
+				kfree(bucket);
+				send_list_del(info);
+				kref_put(&info->refcount, free_info);
+			}
 		}
 	}
 }
@@ -662,44 +702,50 @@ static void purge_vis_packets(struct bat_priv *bat_priv)
 static void broadcast_vis_packet(struct bat_priv *bat_priv,
 				 struct vis_info *info)
 {
-	HASHIT(hashit);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+	struct hlist_node *walk;
+	struct hlist_head *head;
 	struct element_t *bucket;
 	struct orig_node *orig_node;
 	struct vis_packet *packet;
 	struct sk_buff *skb;
 	struct batman_if *batman_if;
 	uint8_t dstaddr[ETH_ALEN];
+	int i;
 
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
 	packet = (struct vis_packet *)info->skb_packet->data;
 
 	/* send to all routers in range. */
-	while (hash_iterate(bat_priv->orig_hash, &hashit)) {
-		bucket = hlist_entry(hashit.walk, struct element_t, hlist);
-		orig_node = bucket->data;
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
 
-		/* if it's a vis server and reachable, send it. */
-		if ((!orig_node) || (!orig_node->router))
-			continue;
-		if (!(orig_node->flags & VIS_SERVER))
-			continue;
-		/* don't send it if we already received the packet from
-		 * this node. */
-		if (recv_list_is_in(bat_priv, &info->recv_list,
-							orig_node->orig))
-			continue;
+		hlist_for_each_entry(bucket, walk, head, hlist) {
+			orig_node = bucket->data;
 
-		memcpy(packet->target_orig, orig_node->orig, ETH_ALEN);
-		batman_if = orig_node->router->if_incoming;
-		memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
-		spin_unlock_bh(&bat_priv->orig_hash_lock);
+			/* if it's a vis server and reachable, send it. */
+			if ((!orig_node) || (!orig_node->router))
+				continue;
+			if (!(orig_node->flags & VIS_SERVER))
+				continue;
+			/* don't send it if we already received the packet from
+			* this node. */
+			if (recv_list_is_in(bat_priv, &info->recv_list,
+					    orig_node->orig))
+				continue;
 
-		skb = skb_clone(info->skb_packet, GFP_ATOMIC);
-		if (skb)
-			send_skb_packet(skb, batman_if, dstaddr);
+			memcpy(packet->target_orig, orig_node->orig, ETH_ALEN);
+			batman_if = orig_node->router->if_incoming;
+			memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+			spin_unlock_bh(&bat_priv->orig_hash_lock);
 
-		spin_lock_bh(&bat_priv->orig_hash_lock);
+			skb = skb_clone(info->skb_packet, GFP_ATOMIC);
+			if (skb)
+				send_skb_packet(skb, batman_if, dstaddr);
+
+			spin_lock_bh(&bat_priv->orig_hash_lock);
+		}
 
 	}
 
-- 
1.7.2.3

