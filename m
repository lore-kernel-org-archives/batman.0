Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:57 +0100
Message-Id: <1290383767-32602-20-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 19/29] Staging: batman-adv: Remove
	hashdata_choose_cb from hash
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

Function pointers cannot be inlined by a compiler and thus always has
the overhead of an call. hashdata_choose_cb's are one of the most often
called function pointers and its overhead must kept relative low.

As first step, every function which uses this function pointer takes it
as parameter instead of storing it inside the hash abstraction
structure.

This not generate any performance gain right now. The called functions
must also be able to be inlined by the calling functions to enable
inlining of the function pointer.

Reported-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/TODO                |    1 -
 drivers/staging/batman-adv/hash.c              |   24 +++++++++---------
 drivers/staging/batman-adv/hash.h              |   19 ++++++++------
 drivers/staging/batman-adv/icmp_socket.c       |    2 +-
 drivers/staging/batman-adv/main.c              |   21 ----------------
 drivers/staging/batman-adv/main.h              |    1 -
 drivers/staging/batman-adv/originator.c        |   11 ++++++--
 drivers/staging/batman-adv/originator.h        |   21 ++++++++++++++++
 drivers/staging/batman-adv/routing.c           |   13 +++++----
 drivers/staging/batman-adv/translation-table.c |   31 ++++++++++++++----------
 drivers/staging/batman-adv/unicast.c           |    3 +-
 drivers/staging/batman-adv/vis.c               |   17 ++++++++----
 12 files changed, 91 insertions(+), 73 deletions(-)

diff --git a/drivers/staging/batman-adv/TODO b/drivers/staging/batman-adv/TODO
index a9c77d6..2c02aa1 100644
--- a/drivers/staging/batman-adv/TODO
+++ b/drivers/staging/batman-adv/TODO
@@ -1,6 +1,5 @@
  * remove own list functionality from hash
  * use hlist_head, hlist_node in hash
- * don't use callbacks for choose in hash
  * think about more efficient ways instead of abstraction of hash
  * Request a new review
  * Process the comments from the review
diff --git a/drivers/staging/batman-adv/hash.c b/drivers/staging/batman-adv/hash.c
index a4abe14..6361a31 100644
--- a/drivers/staging/batman-adv/hash.c
+++ b/drivers/staging/batman-adv/hash.c
@@ -137,7 +137,7 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 }
 
 /* allocates and clears the hash */
-struct hashtable_t *hash_new(int size, hashdata_choose_cb choose)
+struct hashtable_t *hash_new(int size)
 {
 	struct hashtable_t *hash;
 
@@ -156,13 +156,12 @@ struct hashtable_t *hash_new(int size, hashdata_choose_cb choose)
 
 	hash_init(hash);
 
-	hash->choose = choose;
-
 	return hash;
 }
 
 /* adds data to the hashtable. returns 0 on success, -1 on error */
-int hash_add(struct hashtable_t *hash, hashdata_compare_cb compare, void *data)
+int hash_add(struct hashtable_t *hash, hashdata_compare_cb compare,
+	     hashdata_choose_cb choose, void *data)
 {
 	int index;
 	struct element_t *bucket, *prev_bucket = NULL;
@@ -170,7 +169,7 @@ int hash_add(struct hashtable_t *hash, hashdata_compare_cb compare, void *data)
 	if (!hash)
 		return -1;
 
-	index = hash->choose(data, hash->size);
+	index = choose(data, hash->size);
 	bucket = hash->table[index];
 
 	while (bucket != NULL) {
@@ -203,7 +202,7 @@ int hash_add(struct hashtable_t *hash, hashdata_compare_cb compare, void *data)
 /* finds data, based on the key in keydata. returns the found data on success,
  * or NULL on error */
 void *hash_find(struct hashtable_t *hash, hashdata_compare_cb compare,
-		void *keydata)
+		hashdata_choose_cb choose, void *keydata)
 {
 	int index;
 	struct element_t *bucket;
@@ -211,7 +210,7 @@ void *hash_find(struct hashtable_t *hash, hashdata_compare_cb compare,
 	if (!hash)
 		return NULL;
 
-	index = hash->choose(keydata , hash->size);
+	index = choose(keydata , hash->size);
 	bucket = hash->table[index];
 
 	while (bucket != NULL) {
@@ -250,11 +249,11 @@ void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t)
  * structure you use with just the key filled, we just need the key for
  * comparing. */
 void *hash_remove(struct hashtable_t *hash, hashdata_compare_cb compare,
-		  void *data)
+		  hashdata_choose_cb choose, void *data)
 {
 	struct hash_it_t hash_it_t;
 
-	hash_it_t.index = hash->choose(data, hash->size);
+	hash_it_t.index = choose(data, hash->size);
 	hash_it_t.bucket = hash->table[hash_it_t.index];
 	hash_it_t.prev_bucket = NULL;
 
@@ -277,14 +276,15 @@ void *hash_remove(struct hashtable_t *hash, hashdata_compare_cb compare,
 /* resize the hash, returns the pointer to the new hash or NULL on
  * error. removes the old hash on success. */
 struct hashtable_t *hash_resize(struct hashtable_t *hash,
-				hashdata_compare_cb compare, int size)
+				hashdata_compare_cb compare,
+				hashdata_choose_cb choose, int size)
 {
 	struct hashtable_t *new_hash;
 	struct element_t *bucket;
 	int i;
 
 	/* initialize a new hash with the new size */
-	new_hash = hash_new(size, hash->choose);
+	new_hash = hash_new(size);
 
 	if (new_hash == NULL)
 		return NULL;
@@ -294,7 +294,7 @@ struct hashtable_t *hash_resize(struct hashtable_t *hash,
 		bucket = hash->table[i];
 
 		while (bucket != NULL) {
-			hash_add(new_hash, compare, bucket->data);
+			hash_add(new_hash, compare, choose, bucket->data);
 			bucket = bucket->next;
 		}
 	}
diff --git a/drivers/staging/batman-adv/hash.h b/drivers/staging/batman-adv/hash.h
index 742277e..85ee12b 100644
--- a/drivers/staging/batman-adv/hash.h
+++ b/drivers/staging/batman-adv/hash.h
@@ -32,6 +32,10 @@
  * return 0 if same and not 0 if not
  * same */
 typedef int (*hashdata_compare_cb)(void *, void *);
+
+/* the hashfunction, should return an index
+ * based on the key in the data of the first
+ * argument and the size the second */
 typedef int (*hashdata_choose_cb)(void *, int);
 typedef void (*hashdata_free_cb)(void *, void *);
 
@@ -51,13 +55,10 @@ struct hashtable_t {
 	struct element_t **table;   /* the hashtable itself, with the buckets */
 	int elements;		    /* number of elements registered */
 	int size;		    /* size of hashtable */
-	hashdata_choose_cb choose;  /* the hashfunction, should return an index
-				     * based on the key in the data of the first
-				     * argument and the size the second */
 };
 
 /* allocates and clears the hash */
-struct hashtable_t *hash_new(int size, hashdata_choose_cb choose);
+struct hashtable_t *hash_new(int size);
 
 /* remove bucket (this might be used in hash_iterate() if you already found the
  * bucket you want to delete and don't need the overhead to find it again with
@@ -74,24 +75,26 @@ void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb, void *arg);
 void hash_destroy(struct hashtable_t *hash);
 
 /* adds data to the hashtable. returns 0 on success, -1 on error */
-int hash_add(struct hashtable_t *hash, hashdata_compare_cb compare, void *data);
+int hash_add(struct hashtable_t *hash, hashdata_compare_cb compare,
+	     hashdata_choose_cb choose, void *data);
 
 /* removes data from hash, if found. returns pointer do data on success, so you
  * can remove the used structure yourself, or NULL on error .  data could be the
  * structure you use with just the key filled, we just need the key for
  * comparing. */
 void *hash_remove(struct hashtable_t *hash, hashdata_compare_cb compare,
-		  void *data);
+		  hashdata_choose_cb choose, void *data);
 
 /* finds data, based on the key in keydata. returns the found data on success,
  * or NULL on error */
 void *hash_find(struct hashtable_t *hash, hashdata_compare_cb compare,
-		void *keydata);
+		hashdata_choose_cb choose, void *keydata);
 
 /* resize the hash, returns the pointer to the new hash or NULL on
  * error. removes the old hash on success */
 struct hashtable_t *hash_resize(struct hashtable_t *hash,
-				hashdata_compare_cb compare, int size);
+				hashdata_compare_cb compare,
+				hashdata_choose_cb choose, int size);
 
 /* iterate though the hash. first element is selected with iter_in NULL.  use
  * the returned iterator to access the elements until hash_it_t returns NULL. */
diff --git a/drivers/staging/batman-adv/icmp_socket.c b/drivers/staging/batman-adv/icmp_socket.c
index a7b98ce..a8c98aa 100644
--- a/drivers/staging/batman-adv/icmp_socket.c
+++ b/drivers/staging/batman-adv/icmp_socket.c
@@ -226,7 +226,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
-						   compare_orig,
+						   compare_orig, choose_orig,
 						   icmp_packet->dst));
 
 	if (!orig_node)
diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index 2ed77dd..61d1aa6 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -149,27 +149,6 @@ void dec_module_count(void)
 	module_put(THIS_MODULE);
 }
 
-/* hashfunction to choose an entry in a hash table of given size */
-/* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
-int choose_orig(void *data, int32_t size)
-{
-	unsigned char *key = data;
-	uint32_t hash = 0;
-	size_t i;
-
-	for (i = 0; i < 6; i++) {
-		hash += key[i];
-		hash += (hash << 10);
-		hash ^= (hash >> 6);
-	}
-
-	hash += (hash << 3);
-	hash ^= (hash >> 11);
-	hash += (hash << 15);
-
-	return hash % size;
-}
-
 int is_my_mac(uint8_t *addr)
 {
 	struct batman_if *batman_if;
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 97a74b0..3ee1eb0 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -135,7 +135,6 @@ int mesh_init(struct net_device *soft_iface);
 void mesh_free(struct net_device *soft_iface);
 void inc_module_count(void);
 void dec_module_count(void);
-int choose_orig(void *data, int32_t size);
 int is_my_mac(uint8_t *addr);
 int is_bcast(uint8_t *addr);
 int is_mcast(uint8_t *addr);
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 7735b7f..7c1fae7 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -45,7 +45,7 @@ int originator_init(struct bat_priv *bat_priv)
 		return 1;
 
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
-	bat_priv->orig_hash = hash_new(128, choose_orig);
+	bat_priv->orig_hash = hash_new(128);
 
 	if (!bat_priv->orig_hash)
 		goto err;
@@ -128,9 +128,11 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	struct orig_node *orig_node;
 	struct hashtable_t *swaphash;
 	int size;
+	int hash_added;
 
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
-						   compare_orig, addr));
+						   compare_orig, choose_orig,
+						   addr));
 
 	if (orig_node)
 		return orig_node;
@@ -167,11 +169,14 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	if (!orig_node->bcast_own_sum)
 		goto free_bcast_own;
 
-	if (hash_add(bat_priv->orig_hash, compare_orig, orig_node) < 0)
+	hash_added = hash_add(bat_priv->orig_hash, compare_orig, choose_orig,
+			      orig_node);
+	if (hash_added < 0)
 		goto free_bcast_own_sum;
 
 	if (bat_priv->orig_hash->elements * 4 > bat_priv->orig_hash->size) {
 		swaphash = hash_resize(bat_priv->orig_hash, compare_orig,
+				       choose_orig,
 				       bat_priv->orig_hash->size * 2);
 
 		if (!swaphash)
diff --git a/drivers/staging/batman-adv/originator.h b/drivers/staging/batman-adv/originator.h
index ed903dc..d474ceb 100644
--- a/drivers/staging/batman-adv/originator.h
+++ b/drivers/staging/batman-adv/originator.h
@@ -40,4 +40,25 @@ static inline int compare_orig(void *data1, void *data2)
 	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
 }
 
+/* hashfunction to choose an entry in a hash table of given size */
+/* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
+static inline int choose_orig(void *data, int32_t size)
+{
+	unsigned char *key = data;
+	uint32_t hash = 0;
+	size_t i;
+
+	for (i = 0; i < 6; i++) {
+		hash += key[i];
+		hash += (hash << 10);
+		hash ^= (hash >> 6);
+	}
+
+	hash += (hash << 3);
+	hash ^= (hash >> 11);
+	hash += (hash << 15);
+
+	return hash % size;
+}
+
 #endif /* _NET_BATMAN_ADV_ORIGINATOR_H_ */
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index bb0bd78..9cbb195 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -811,7 +811,7 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	/* get routing information */
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
-						   compare_orig,
+						   compare_orig, choose_orig,
 						   icmp_packet->orig));
 	ret = NET_RX_DROP;
 
@@ -874,7 +874,7 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 	/* get routing information */
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, compare_orig,
+		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			       icmp_packet->orig));
 	ret = NET_RX_DROP;
 
@@ -969,7 +969,7 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	/* get routing information */
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, compare_orig,
+		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			       icmp_packet->dst));
 
 	if ((orig_node != NULL) &&
@@ -1042,7 +1042,8 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 		primary_orig_node = router_orig;
 	} else {
 		primary_orig_node = hash_find(bat_priv->orig_hash, compare_orig,
-						router_orig->primary_addr);
+					       choose_orig,
+					       router_orig->primary_addr);
 
 		if (!primary_orig_node)
 			return orig_node->router;
@@ -1147,7 +1148,7 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 	/* get routing information */
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, compare_orig,
+		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			       unicast_packet->dest));
 
 	router = find_router(bat_priv, orig_node, recv_if);
@@ -1294,7 +1295,7 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, compare_orig,
+		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			       bcast_packet->orig));
 
 	if (orig_node == NULL) {
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index 33cd5daa..96d59b1 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -42,7 +42,7 @@ int hna_local_init(struct bat_priv *bat_priv)
 	if (bat_priv->hna_local_hash)
 		return 1;
 
-	bat_priv->hna_local_hash = hash_new(128, choose_orig);
+	bat_priv->hna_local_hash = hash_new(128);
 
 	if (!bat_priv->hna_local_hash)
 		return 0;
@@ -65,7 +65,8 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 	hna_local_entry =
 		((struct hna_local_entry *)hash_find(bat_priv->hna_local_hash,
-						     compare_orig, addr));
+						     compare_orig, choose_orig,
+						     addr));
 	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
 
 	if (hna_local_entry) {
@@ -108,13 +109,15 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 
 	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 
-	hash_add(bat_priv->hna_local_hash, compare_orig, hna_local_entry);
+	hash_add(bat_priv->hna_local_hash, compare_orig, choose_orig,
+		 hna_local_entry);
 	bat_priv->num_local_hna++;
 	atomic_set(&bat_priv->hna_local_changed, 1);
 
 	if (bat_priv->hna_local_hash->elements * 4 >
 					bat_priv->hna_local_hash->size) {
 		swaphash = hash_resize(bat_priv->hna_local_hash, compare_orig,
+				       choose_orig,
 				       bat_priv->hna_local_hash->size * 2);
 
 		if (!swaphash)
@@ -130,7 +133,7 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 
 	hna_global_entry = ((struct hna_global_entry *)
 				hash_find(bat_priv->hna_global_hash,
-					  compare_orig, addr));
+					  compare_orig, choose_orig, addr));
 
 	if (hna_global_entry)
 		_hna_global_del_orig(bat_priv, hna_global_entry,
@@ -234,7 +237,7 @@ static void hna_local_del(struct bat_priv *bat_priv,
 	bat_dbg(DBG_ROUTES, bat_priv, "Deleting local hna entry (%pM): %s\n",
 		hna_local_entry->addr, message);
 
-	hash_remove(bat_priv->hna_local_hash, compare_orig,
+	hash_remove(bat_priv->hna_local_hash, compare_orig, choose_orig,
 		    hna_local_entry->addr);
 	_hna_local_del(hna_local_entry, bat_priv);
 }
@@ -248,7 +251,8 @@ void hna_local_remove(struct bat_priv *bat_priv,
 	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 
 	hna_local_entry = (struct hna_local_entry *)
-		hash_find(bat_priv->hna_local_hash, compare_orig, addr);
+		hash_find(bat_priv->hna_local_hash, compare_orig, choose_orig,
+			  addr);
 	if (hna_local_entry)
 		hna_local_del(bat_priv, hna_local_entry, message);
 
@@ -298,7 +302,7 @@ int hna_global_init(struct bat_priv *bat_priv)
 	if (bat_priv->hna_global_hash)
 		return 1;
 
-	bat_priv->hna_global_hash = hash_new(128, choose_orig);
+	bat_priv->hna_global_hash = hash_new(128);
 
 	if (!bat_priv->hna_global_hash)
 		return 0;
@@ -323,7 +327,7 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 		hna_ptr = hna_buff + (hna_buff_count * ETH_ALEN);
 		hna_global_entry = (struct hna_global_entry *)
 			hash_find(bat_priv->hna_global_hash, compare_orig,
-				  hna_ptr);
+				  choose_orig, hna_ptr);
 
 		if (!hna_global_entry) {
 			spin_unlock_irqrestore(&bat_priv->hna_ghash_lock,
@@ -345,7 +349,7 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 
 			spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
 			hash_add(bat_priv->hna_global_hash, compare_orig,
-				 hna_global_entry);
+				 choose_orig, hna_global_entry);
 
 		}
 
@@ -358,7 +362,7 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 		hna_ptr = hna_buff + (hna_buff_count * ETH_ALEN);
 		hna_local_entry = (struct hna_local_entry *)
 			hash_find(bat_priv->hna_local_hash, compare_orig,
-				  hna_ptr);
+				  choose_orig, hna_ptr);
 
 		if (hna_local_entry)
 			hna_local_del(bat_priv, hna_local_entry,
@@ -386,6 +390,7 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 	if (bat_priv->hna_global_hash->elements * 4 >
 					bat_priv->hna_global_hash->size) {
 		swaphash = hash_resize(bat_priv->hna_global_hash, compare_orig,
+				       choose_orig,
 				       bat_priv->hna_global_hash->size * 2);
 
 		if (!swaphash)
@@ -456,7 +461,7 @@ static void _hna_global_del_orig(struct bat_priv *bat_priv,
 		hna_global_entry->addr, hna_global_entry->orig_node->orig,
 		message);
 
-	hash_remove(bat_priv->hna_global_hash, compare_orig,
+	hash_remove(bat_priv->hna_global_hash, compare_orig, choose_orig,
 		    hna_global_entry->addr);
 	kfree(hna_global_entry);
 }
@@ -478,7 +483,7 @@ void hna_global_del_orig(struct bat_priv *bat_priv,
 		hna_ptr = orig_node->hna_buff + (hna_buff_count * ETH_ALEN);
 		hna_global_entry = (struct hna_global_entry *)
 			hash_find(bat_priv->hna_global_hash, compare_orig,
-				  hna_ptr);
+				  choose_orig, hna_ptr);
 
 		if ((hna_global_entry) &&
 		    (hna_global_entry->orig_node == orig_node))
@@ -517,7 +522,7 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv, uint8_t *addr)
 	spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
 	hna_global_entry = (struct hna_global_entry *)
 				hash_find(bat_priv->hna_global_hash,
-					  compare_orig, addr);
+					  compare_orig, choose_orig, addr);
 	spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
 
 	if (!hna_global_entry)
diff --git a/drivers/staging/batman-adv/unicast.c b/drivers/staging/batman-adv/unicast.c
index 1f4d911..1328750 100644
--- a/drivers/staging/batman-adv/unicast.c
+++ b/drivers/staging/batman-adv/unicast.c
@@ -180,7 +180,7 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	*new_skb = NULL;
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		    hash_find(bat_priv->orig_hash, compare_orig,
+		    hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
 			      unicast_packet->orig));
 
 	if (!orig_node) {
@@ -286,6 +286,7 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	/* get routing information */
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
 						   compare_orig,
+						   choose_orig,
 						   ethhdr->h_dest));
 
 	/* check for hna host */
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index ff0abe9..dccd296 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -350,6 +350,7 @@ static struct vis_info *add_packet(struct bat_priv *bat_priv,
 	struct vis_packet *search_packet, *old_packet;
 	struct vis_info search_elem;
 	struct vis_packet *packet;
+	int hash_added;
 
 	*is_new = 0;
 	/* sanity check */
@@ -364,7 +365,8 @@ static struct vis_info *add_packet(struct bat_priv *bat_priv,
 						     sizeof(struct vis_packet));
 
 	memcpy(search_packet->vis_orig, vis_packet->vis_orig, ETH_ALEN);
-	old_info = hash_find(bat_priv->vis_hash, vis_info_cmp, &search_elem);
+	old_info = hash_find(bat_priv->vis_hash, vis_info_cmp, vis_info_choose,
+			     &search_elem);
 	kfree_skb(search_elem.skb_packet);
 
 	if (old_info != NULL) {
@@ -381,7 +383,8 @@ static struct vis_info *add_packet(struct bat_priv *bat_priv,
 			}
 		}
 		/* remove old entry */
-		hash_remove(bat_priv->vis_hash, vis_info_cmp, old_info);
+		hash_remove(bat_priv->vis_hash, vis_info_cmp, vis_info_choose,
+			    old_info);
 		send_list_del(old_info);
 		kref_put(&old_info->refcount, free_info);
 	}
@@ -422,7 +425,9 @@ static struct vis_info *add_packet(struct bat_priv *bat_priv,
 	recv_list_add(bat_priv, &info->recv_list, packet->sender_orig);
 
 	/* try to add it */
-	if (hash_add(bat_priv->vis_hash, vis_info_cmp, info) < 0) {
+	hash_added = hash_add(bat_priv->vis_hash, vis_info_cmp, vis_info_choose,
+			      info);
+	if (hash_added < 0) {
 		/* did not work (for some reason) */
 		kref_put(&old_info->refcount, free_info);
 		info = NULL;
@@ -711,7 +716,7 @@ static void unicast_vis_packet(struct bat_priv *bat_priv,
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	packet = (struct vis_packet *)info->skb_packet->data;
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
-						   compare_orig,
+						   compare_orig, choose_orig,
 						   packet->target_orig));
 
 	if ((!orig_node) || (!orig_node->router))
@@ -803,7 +808,7 @@ int vis_init(struct bat_priv *bat_priv)
 
 	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
 
-	bat_priv->vis_hash = hash_new(256, vis_info_choose);
+	bat_priv->vis_hash = hash_new(256);
 	if (!bat_priv->vis_hash) {
 		pr_err("Can't initialize vis_hash\n");
 		goto err;
@@ -842,7 +847,7 @@ int vis_init(struct bat_priv *bat_priv)
 
 	INIT_LIST_HEAD(&bat_priv->vis_send_list);
 
-	hash_added = hash_add(bat_priv->vis_hash, vis_info_cmp,
+	hash_added = hash_add(bat_priv->vis_hash, vis_info_cmp, vis_info_choose,
 			      bat_priv->my_vis_info);
 	if (hash_added < 0) {
 		pr_err("Can't add own vis packet into hash\n");
-- 
1.7.2.3

