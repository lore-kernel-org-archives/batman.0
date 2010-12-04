Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  4 Dec 2010 21:03:40 +0100
Message-Id: <1291493028-29957-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201012042042.16056.sven.eckelmann@gmx.de>
References: <201012042042.16056.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/9] batman-adv: remove hash resize functions
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

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
Removed hashtable_t::elements

 batman-adv/hash.c              |    3 ---
 batman-adv/hash.h              |   40 ----------------------------------------
 batman-adv/originator.c        |   14 +-------------
 batman-adv/translation-table.c |   32 ++------------------------------
 4 files changed, 3 insertions(+), 86 deletions(-)

diff --git a/batman-adv/hash.c b/batman-adv/hash.c
index 8605e2f..3dedb06 100644
--- a/batman-adv/hash.c
+++ b/batman-adv/hash.c
@@ -27,8 +27,6 @@ static void hash_init(struct hashtable_t *hash)
 {
 	int i;
 
-	hash->elements = 0;
-
 	for (i = 0 ; i < hash->size; i++)
 		INIT_HLIST_HEAD(&hash->table[i]);
 }
@@ -77,7 +75,6 @@ void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t)
 
 	hlist_del(hash_it_t->walk);
 	kfree(bucket);
-	hash->elements--;
 
 	return data_save;
 }
diff --git a/batman-adv/hash.h b/batman-adv/hash.h
index 0b61c6e..16b23bf 100644
--- a/batman-adv/hash.h
+++ b/batman-adv/hash.h
@@ -53,7 +53,6 @@ struct hash_it_t {
 
 struct hashtable_t {
 	struct hlist_head *table;   /* the hashtable itself, with the buckets */
-	int elements;		    /* number of elements registered */
 	int size;		    /* size of hashtable */
 };
 
@@ -127,7 +126,6 @@ static inline int hash_add(struct hashtable_t *hash,
 	bucket->data = data;
 	hlist_add_head(&bucket->hlist, head);
 
-	hash->elements++;
 	return 0;
 }
 
@@ -181,44 +179,6 @@ static inline void *hash_find(struct hashtable_t *hash,
 	return NULL;
 }
 
-/* resize the hash, returns the pointer to the new hash or NULL on
- * error. removes the old hash on success */
-static inline struct hashtable_t *hash_resize(struct hashtable_t *hash,
-					      hashdata_choose_cb choose,
-					      int size)
-{
-	struct hashtable_t *new_hash;
-	struct hlist_head *head, *new_head;
-	struct hlist_node *walk, *safe;
-	struct element_t *bucket;
-	int i, new_index;
-
-	/* initialize a new hash with the new size */
-	new_hash = hash_new(size);
-
-	if (new_hash == NULL)
-		return NULL;
-
-	/* copy the elements */
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-
-		hlist_for_each_safe(walk, safe, head) {
-			bucket = hlist_entry(walk, struct element_t, hlist);
-
-			new_index = choose(bucket->data, size);
-			new_head = &new_hash->table[new_index];
-
-			hlist_del(walk);
-			hlist_add_head(walk, new_head);
-		}
-	}
-
-	hash_destroy(hash);
-
-	return new_hash;
-}
-
 /* iterate though the hash. First element is selected if an iterator
  * initialized with HASHIT() is supplied as iter. Use the returned
  * (or supplied) iterator to access the elements until hash_iterate returns
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 89ec021..a5612e6 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -45,7 +45,7 @@ int originator_init(struct bat_priv *bat_priv)
 		return 1;
 
 	spin_lock_bh(&bat_priv->orig_hash_lock);
-	bat_priv->orig_hash = hash_new(128);
+	bat_priv->orig_hash = hash_new(1024);
 
 	if (!bat_priv->orig_hash)
 		goto err;
@@ -124,7 +124,6 @@ void originator_free(struct bat_priv *bat_priv)
 struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 {
 	struct orig_node *orig_node;
-	struct hashtable_t *swaphash;
 	int size;
 	int hash_added;
 
@@ -172,17 +171,6 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	if (hash_added < 0)
 		goto free_bcast_own_sum;
 
-	if (bat_priv->orig_hash->elements * 4 > bat_priv->orig_hash->size) {
-		swaphash = hash_resize(bat_priv->orig_hash, choose_orig,
-				       bat_priv->orig_hash->size * 2);
-
-		if (!swaphash)
-			bat_dbg(DBG_BATMAN, bat_priv,
-				"Couldn't resize orig hash table\n");
-		else
-			bat_priv->orig_hash = swaphash;
-	}
-
 	return orig_node;
 free_bcast_own_sum:
 	kfree(orig_node->bcast_own_sum);
diff --git a/batman-adv/translation-table.c b/batman-adv/translation-table.c
index 4b0a107..72448c9 100644
--- a/batman-adv/translation-table.c
+++ b/batman-adv/translation-table.c
@@ -42,7 +42,7 @@ int hna_local_init(struct bat_priv *bat_priv)
 	if (bat_priv->hna_local_hash)
 		return 1;
 
-	bat_priv->hna_local_hash = hash_new(128);
+	bat_priv->hna_local_hash = hash_new(1024);
 
 	if (!bat_priv->hna_local_hash)
 		return 0;
@@ -58,7 +58,6 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct hna_local_entry *hna_local_entry;
 	struct hna_global_entry *hna_global_entry;
-	struct hashtable_t *swaphash;
 	int required_bytes;
 
 	spin_lock_bh(&bat_priv->hna_lhash_lock);
@@ -113,17 +112,6 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	bat_priv->num_local_hna++;
 	atomic_set(&bat_priv->hna_local_changed, 1);
 
-	if (bat_priv->hna_local_hash->elements * 4 >
-					bat_priv->hna_local_hash->size) {
-		swaphash = hash_resize(bat_priv->hna_local_hash, choose_orig,
-				       bat_priv->hna_local_hash->size * 2);
-
-		if (!swaphash)
-			pr_err("Couldn't resize local hna hash table\n");
-		else
-			bat_priv->hna_local_hash = swaphash;
-	}
-
 	spin_unlock_bh(&bat_priv->hna_lhash_lock);
 
 	/* remove address from global hash if present */
@@ -302,7 +290,7 @@ int hna_global_init(struct bat_priv *bat_priv)
 	if (bat_priv->hna_global_hash)
 		return 1;
 
-	bat_priv->hna_global_hash = hash_new(128);
+	bat_priv->hna_global_hash = hash_new(1024);
 
 	if (!bat_priv->hna_global_hash)
 		return 0;
@@ -316,7 +304,6 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 {
 	struct hna_global_entry *hna_global_entry;
 	struct hna_local_entry *hna_local_entry;
-	struct hashtable_t *swaphash;
 	int hna_buff_count = 0;
 	unsigned char *hna_ptr;
 
@@ -382,21 +369,6 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 			orig_node->hna_buff_len = hna_buff_len;
 		}
 	}
-
-	spin_lock_bh(&bat_priv->hna_ghash_lock);
-
-	if (bat_priv->hna_global_hash->elements * 4 >
-					bat_priv->hna_global_hash->size) {
-		swaphash = hash_resize(bat_priv->hna_global_hash, choose_orig,
-				       bat_priv->hna_global_hash->size * 2);
-
-		if (!swaphash)
-			pr_err("Couldn't resize global hna hash table\n");
-		else
-			bat_priv->hna_global_hash = swaphash;
-	}
-
-	spin_unlock_bh(&bat_priv->hna_ghash_lock);
 }
 
 int hna_global_seq_print_text(struct seq_file *seq, void *offset)
-- 
1.7.2.3

