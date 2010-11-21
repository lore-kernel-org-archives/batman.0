Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:56 +0100
Message-Id: <1290383767-32602-19-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 18/29] Staging: batman-adv: Remove
	hashdata_compare_cb from hash
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
the overhead of an call. hashdata_compare_cb's are one of the most often
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
 drivers/staging/batman-adv/TODO                |    2 +-
 drivers/staging/batman-adv/hash.c              |   25 ++++++++-------
 drivers/staging/batman-adv/hash.h              |   23 +++++++-------
 drivers/staging/batman-adv/icmp_socket.c       |    2 +
 drivers/staging/batman-adv/main.c              |    7 ----
 drivers/staging/batman-adv/main.h              |    1 -
 drivers/staging/batman-adv/originator.c        |    9 +++--
 drivers/staging/batman-adv/originator.h        |    7 ++++
 drivers/staging/batman-adv/routing.c           |   15 ++++++---
 drivers/staging/batman-adv/send.c              |    1 +
 drivers/staging/batman-adv/translation-table.c |   39 ++++++++++++++---------
 drivers/staging/batman-adv/unicast.c           |    5 ++-
 drivers/staging/batman-adv/vis.c               |   15 ++++++---
 13 files changed, 89 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/batman-adv/TODO b/drivers/staging/batman-adv/TODO
index 7967ffa..a9c77d6 100644
--- a/drivers/staging/batman-adv/TODO
+++ b/drivers/staging/batman-adv/TODO
@@ -1,6 +1,6 @@
  * remove own list functionality from hash
  * use hlist_head, hlist_node in hash
- * don't use callbacks for compare+choose in hash
+ * don't use callbacks for choose in hash
  * think about more efficient ways instead of abstraction of hash
  * Request a new review
  * Process the comments from the review
diff --git a/drivers/staging/batman-adv/hash.c b/drivers/staging/batman-adv/hash.c
index 8ef26eb..a4abe14 100644
--- a/drivers/staging/batman-adv/hash.c
+++ b/drivers/staging/batman-adv/hash.c
@@ -137,8 +137,7 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 }
 
 /* allocates and clears the hash */
-struct hashtable_t *hash_new(int size, hashdata_compare_cb compare,
-			     hashdata_choose_cb choose)
+struct hashtable_t *hash_new(int size, hashdata_choose_cb choose)
 {
 	struct hashtable_t *hash;
 
@@ -157,14 +156,13 @@ struct hashtable_t *hash_new(int size, hashdata_compare_cb compare,
 
 	hash_init(hash);
 
-	hash->compare = compare;
 	hash->choose = choose;
 
 	return hash;
 }
 
 /* adds data to the hashtable. returns 0 on success, -1 on error */
-int hash_add(struct hashtable_t *hash, void *data)
+int hash_add(struct hashtable_t *hash, hashdata_compare_cb compare, void *data)
 {
 	int index;
 	struct element_t *bucket, *prev_bucket = NULL;
@@ -176,7 +174,7 @@ int hash_add(struct hashtable_t *hash, void *data)
 	bucket = hash->table[index];
 
 	while (bucket != NULL) {
-		if (hash->compare(bucket->data, data))
+		if (compare(bucket->data, data))
 			return -1;
 
 		prev_bucket = bucket;
@@ -204,7 +202,8 @@ int hash_add(struct hashtable_t *hash, void *data)
 
 /* finds data, based on the key in keydata. returns the found data on success,
  * or NULL on error */
-void *hash_find(struct hashtable_t *hash, void *keydata)
+void *hash_find(struct hashtable_t *hash, hashdata_compare_cb compare,
+		void *keydata)
 {
 	int index;
 	struct element_t *bucket;
@@ -216,7 +215,7 @@ void *hash_find(struct hashtable_t *hash, void *keydata)
 	bucket = hash->table[index];
 
 	while (bucket != NULL) {
-		if (hash->compare(bucket->data, keydata))
+		if (compare(bucket->data, keydata))
 			return bucket->data;
 
 		bucket = bucket->next;
@@ -250,7 +249,8 @@ void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t)
  * can remove the used structure yourself, or NULL on error .  data could be the
  * structure you use with just the key filled, we just need the key for
  * comparing. */
-void *hash_remove(struct hashtable_t *hash, void *data)
+void *hash_remove(struct hashtable_t *hash, hashdata_compare_cb compare,
+		  void *data)
 {
 	struct hash_it_t hash_it_t;
 
@@ -259,7 +259,7 @@ void *hash_remove(struct hashtable_t *hash, void *data)
 	hash_it_t.prev_bucket = NULL;
 
 	while (hash_it_t.bucket != NULL) {
-		if (hash->compare(hash_it_t.bucket->data, data)) {
+		if (compare(hash_it_t.bucket->data, data)) {
 			hash_it_t.first_bucket =
 				(hash_it_t.bucket ==
 				 hash->table[hash_it_t.index] ?
@@ -276,14 +276,15 @@ void *hash_remove(struct hashtable_t *hash, void *data)
 
 /* resize the hash, returns the pointer to the new hash or NULL on
  * error. removes the old hash on success. */
-struct hashtable_t *hash_resize(struct hashtable_t *hash, int size)
+struct hashtable_t *hash_resize(struct hashtable_t *hash,
+				hashdata_compare_cb compare, int size)
 {
 	struct hashtable_t *new_hash;
 	struct element_t *bucket;
 	int i;
 
 	/* initialize a new hash with the new size */
-	new_hash = hash_new(size, hash->compare, hash->choose);
+	new_hash = hash_new(size, hash->choose);
 
 	if (new_hash == NULL)
 		return NULL;
@@ -293,7 +294,7 @@ struct hashtable_t *hash_resize(struct hashtable_t *hash, int size)
 		bucket = hash->table[i];
 
 		while (bucket != NULL) {
-			hash_add(new_hash, bucket->data);
+			hash_add(new_hash, compare, bucket->data);
 			bucket = bucket->next;
 		}
 	}
diff --git a/drivers/staging/batman-adv/hash.h b/drivers/staging/batman-adv/hash.h
index 2c8e176..742277e 100644
--- a/drivers/staging/batman-adv/hash.h
+++ b/drivers/staging/batman-adv/hash.h
@@ -27,7 +27,10 @@
 		.prev_bucket = NULL, \
 		.first_bucket = NULL }
 
-
+/* callback to a compare function.  should
+ * compare 2 element datas for their keys,
+ * return 0 if same and not 0 if not
+ * same */
 typedef int (*hashdata_compare_cb)(void *, void *);
 typedef int (*hashdata_choose_cb)(void *, int);
 typedef void (*hashdata_free_cb)(void *, void *);
@@ -48,18 +51,13 @@ struct hashtable_t {
 	struct element_t **table;   /* the hashtable itself, with the buckets */
 	int elements;		    /* number of elements registered */
 	int size;		    /* size of hashtable */
-	hashdata_compare_cb compare;/* callback to a compare function.  should
-				     * compare 2 element datas for their keys,
-				     * return 0 if same and not 0 if not
-				     * same */
 	hashdata_choose_cb choose;  /* the hashfunction, should return an index
 				     * based on the key in the data of the first
 				     * argument and the size the second */
 };
 
 /* allocates and clears the hash */
-struct hashtable_t *hash_new(int size, hashdata_compare_cb compare,
-			     hashdata_choose_cb choose);
+struct hashtable_t *hash_new(int size, hashdata_choose_cb choose);
 
 /* remove bucket (this might be used in hash_iterate() if you already found the
  * bucket you want to delete and don't need the overhead to find it again with
@@ -76,21 +74,24 @@ void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb, void *arg);
 void hash_destroy(struct hashtable_t *hash);
 
 /* adds data to the hashtable. returns 0 on success, -1 on error */
-int hash_add(struct hashtable_t *hash, void *data);
+int hash_add(struct hashtable_t *hash, hashdata_compare_cb compare, void *data);
 
 /* removes data from hash, if found. returns pointer do data on success, so you
  * can remove the used structure yourself, or NULL on error .  data could be the
  * structure you use with just the key filled, we just need the key for
  * comparing. */
-void *hash_remove(struct hashtable_t *hash, void *data);
+void *hash_remove(struct hashtable_t *hash, hashdata_compare_cb compare,
+		  void *data);
 
 /* finds data, based on the key in keydata. returns the found data on success,
  * or NULL on error */
-void *hash_find(struct hashtable_t *hash, void *keydata);
+void *hash_find(struct hashtable_t *hash, hashdata_compare_cb compare,
+		void *keydata);
 
 /* resize the hash, returns the pointer to the new hash or NULL on
  * error. removes the old hash on success */
-struct hashtable_t *hash_resize(struct hashtable_t *hash, int size);
+struct hashtable_t *hash_resize(struct hashtable_t *hash,
+				hashdata_compare_cb compare, int size);
 
 /* iterate though the hash. first element is selected with iter_in NULL.  use
  * the returned iterator to access the elements until hash_it_t returns NULL. */
diff --git a/drivers/staging/batman-adv/icmp_socket.c b/drivers/staging/batman-adv/icmp_socket.c
index 48856ca..a7b98ce 100644
--- a/drivers/staging/batman-adv/icmp_socket.c
+++ b/drivers/staging/batman-adv/icmp_socket.c
@@ -26,6 +26,7 @@
 #include "send.h"
 #include "types.h"
 #include "hash.h"
+#include "originator.h"
 #include "hard-interface.h"
 
 
@@ -225,6 +226,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
+						   compare_orig,
 						   icmp_packet->dst));
 
 	if (!orig_node)
diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index f7d6733..2ed77dd 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -149,13 +149,6 @@ void dec_module_count(void)
 	module_put(THIS_MODULE);
 }
 
-/* returns 1 if they are the same originator */
-
-int compare_orig(void *data1, void *data2)
-{
-	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
-}
-
 /* hashfunction to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
 int choose_orig(void *data, int32_t size)
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index d8d50f3..97a74b0 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -135,7 +135,6 @@ int mesh_init(struct net_device *soft_iface);
 void mesh_free(struct net_device *soft_iface);
 void inc_module_count(void);
 void dec_module_count(void);
-int compare_orig(void *data1, void *data2);
 int choose_orig(void *data, int32_t size);
 int is_my_mac(uint8_t *addr);
 int is_bcast(uint8_t *addr);
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index fc7fb31..7735b7f 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -45,7 +45,7 @@ int originator_init(struct bat_priv *bat_priv)
 		return 1;
 
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
-	bat_priv->orig_hash = hash_new(128, compare_orig, choose_orig);
+	bat_priv->orig_hash = hash_new(128, choose_orig);
 
 	if (!bat_priv->orig_hash)
 		goto err;
@@ -129,7 +129,8 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	struct hashtable_t *swaphash;
 	int size;
 
-	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash, addr));
+	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
+						   compare_orig, addr));
 
 	if (orig_node)
 		return orig_node;
@@ -166,11 +167,11 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	if (!orig_node->bcast_own_sum)
 		goto free_bcast_own;
 
-	if (hash_add(bat_priv->orig_hash, orig_node) < 0)
+	if (hash_add(bat_priv->orig_hash, compare_orig, orig_node) < 0)
 		goto free_bcast_own_sum;
 
 	if (bat_priv->orig_hash->elements * 4 > bat_priv->orig_hash->size) {
-		swaphash = hash_resize(bat_priv->orig_hash,
+		swaphash = hash_resize(bat_priv->orig_hash, compare_orig,
 				       bat_priv->orig_hash->size * 2);
 
 		if (!swaphash)
diff --git a/drivers/staging/batman-adv/originator.h b/drivers/staging/batman-adv/originator.h
index a97c4004..ed903dc 100644
--- a/drivers/staging/batman-adv/originator.h
+++ b/drivers/staging/batman-adv/originator.h
@@ -33,4 +33,11 @@ int orig_seq_print_text(struct seq_file *seq, void *offset);
 int orig_hash_add_if(struct batman_if *batman_if, int max_if_num);
 int orig_hash_del_if(struct batman_if *batman_if, int max_if_num);
 
+
+/* returns 1 if they are the same originator */
+static inline int compare_orig(void *data1, void *data2)
+{
+	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
+}
+
 #endif /* _NET_BATMAN_ADV_ORIGINATOR_H_ */
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 1b35486..bb0bd78 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -811,6 +811,7 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	/* get routing information */
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
+						   compare_orig,
 						   icmp_packet->orig));
 	ret = NET_RX_DROP;
 
@@ -873,7 +874,8 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 	/* get routing information */
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, icmp_packet->orig));
+		     hash_find(bat_priv->orig_hash, compare_orig,
+			       icmp_packet->orig));
 	ret = NET_RX_DROP;
 
 	if ((orig_node != NULL) &&
@@ -967,7 +969,8 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	/* get routing information */
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, icmp_packet->dst));
+		     hash_find(bat_priv->orig_hash, compare_orig,
+			       icmp_packet->dst));
 
 	if ((orig_node != NULL) &&
 	    (orig_node->router != NULL)) {
@@ -1038,7 +1041,7 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 				router_orig->orig, ETH_ALEN) == 0) {
 		primary_orig_node = router_orig;
 	} else {
-		primary_orig_node = hash_find(bat_priv->orig_hash,
+		primary_orig_node = hash_find(bat_priv->orig_hash, compare_orig,
 						router_orig->primary_addr);
 
 		if (!primary_orig_node)
@@ -1144,7 +1147,8 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 	/* get routing information */
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, unicast_packet->dest));
+		     hash_find(bat_priv->orig_hash, compare_orig,
+			       unicast_packet->dest));
 
 	router = find_router(bat_priv, orig_node, recv_if);
 
@@ -1290,7 +1294,8 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, bcast_packet->orig));
+		     hash_find(bat_priv->orig_hash, compare_orig,
+			       bcast_packet->orig));
 
 	if (orig_node == NULL) {
 		spin_unlock_irqrestore(&bat_priv->orig_hash_lock, flags);
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index 1489b6c..1840ef0 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -28,6 +28,7 @@
 #include "types.h"
 #include "vis.h"
 #include "aggregation.h"
+#include "originator.h"
 
 
 static void send_outstanding_bcast_packet(struct work_struct *work);
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index 3bc7521..33cd5daa 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -24,6 +24,7 @@
 #include "soft-interface.h"
 #include "types.h"
 #include "hash.h"
+#include "originator.h"
 
 static void hna_local_purge(struct work_struct *work);
 static void _hna_global_del_orig(struct bat_priv *bat_priv,
@@ -41,7 +42,7 @@ int hna_local_init(struct bat_priv *bat_priv)
 	if (bat_priv->hna_local_hash)
 		return 1;
 
-	bat_priv->hna_local_hash = hash_new(128, compare_orig, choose_orig);
+	bat_priv->hna_local_hash = hash_new(128, choose_orig);
 
 	if (!bat_priv->hna_local_hash)
 		return 0;
@@ -64,7 +65,7 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 	hna_local_entry =
 		((struct hna_local_entry *)hash_find(bat_priv->hna_local_hash,
-						     addr));
+						     compare_orig, addr));
 	spin_unlock_irqrestore(&bat_priv->hna_lhash_lock, flags);
 
 	if (hna_local_entry) {
@@ -107,13 +108,13 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 
 	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 
-	hash_add(bat_priv->hna_local_hash, hna_local_entry);
+	hash_add(bat_priv->hna_local_hash, compare_orig, hna_local_entry);
 	bat_priv->num_local_hna++;
 	atomic_set(&bat_priv->hna_local_changed, 1);
 
 	if (bat_priv->hna_local_hash->elements * 4 >
 					bat_priv->hna_local_hash->size) {
-		swaphash = hash_resize(bat_priv->hna_local_hash,
+		swaphash = hash_resize(bat_priv->hna_local_hash, compare_orig,
 				       bat_priv->hna_local_hash->size * 2);
 
 		if (!swaphash)
@@ -128,7 +129,8 @@ void hna_local_add(struct net_device *soft_iface, uint8_t *addr)
 	spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
 
 	hna_global_entry = ((struct hna_global_entry *)
-				hash_find(bat_priv->hna_global_hash, addr));
+				hash_find(bat_priv->hna_global_hash,
+					  compare_orig, addr));
 
 	if (hna_global_entry)
 		_hna_global_del_orig(bat_priv, hna_global_entry,
@@ -232,7 +234,8 @@ static void hna_local_del(struct bat_priv *bat_priv,
 	bat_dbg(DBG_ROUTES, bat_priv, "Deleting local hna entry (%pM): %s\n",
 		hna_local_entry->addr, message);
 
-	hash_remove(bat_priv->hna_local_hash, hna_local_entry->addr);
+	hash_remove(bat_priv->hna_local_hash, compare_orig,
+		    hna_local_entry->addr);
 	_hna_local_del(hna_local_entry, bat_priv);
 }
 
@@ -245,7 +248,7 @@ void hna_local_remove(struct bat_priv *bat_priv,
 	spin_lock_irqsave(&bat_priv->hna_lhash_lock, flags);
 
 	hna_local_entry = (struct hna_local_entry *)
-		hash_find(bat_priv->hna_local_hash, addr);
+		hash_find(bat_priv->hna_local_hash, compare_orig, addr);
 	if (hna_local_entry)
 		hna_local_del(bat_priv, hna_local_entry, message);
 
@@ -295,7 +298,7 @@ int hna_global_init(struct bat_priv *bat_priv)
 	if (bat_priv->hna_global_hash)
 		return 1;
 
-	bat_priv->hna_global_hash = hash_new(128, compare_orig, choose_orig);
+	bat_priv->hna_global_hash = hash_new(128, choose_orig);
 
 	if (!bat_priv->hna_global_hash)
 		return 0;
@@ -319,7 +322,8 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 
 		hna_ptr = hna_buff + (hna_buff_count * ETH_ALEN);
 		hna_global_entry = (struct hna_global_entry *)
-			hash_find(bat_priv->hna_global_hash, hna_ptr);
+			hash_find(bat_priv->hna_global_hash, compare_orig,
+				  hna_ptr);
 
 		if (!hna_global_entry) {
 			spin_unlock_irqrestore(&bat_priv->hna_ghash_lock,
@@ -340,7 +344,8 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 				hna_global_entry->addr, orig_node->orig);
 
 			spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
-			hash_add(bat_priv->hna_global_hash, hna_global_entry);
+			hash_add(bat_priv->hna_global_hash, compare_orig,
+				 hna_global_entry);
 
 		}
 
@@ -352,7 +357,8 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 
 		hna_ptr = hna_buff + (hna_buff_count * ETH_ALEN);
 		hna_local_entry = (struct hna_local_entry *)
-			hash_find(bat_priv->hna_local_hash, hna_ptr);
+			hash_find(bat_priv->hna_local_hash, compare_orig,
+				  hna_ptr);
 
 		if (hna_local_entry)
 			hna_local_del(bat_priv, hna_local_entry,
@@ -379,7 +385,7 @@ void hna_global_add_orig(struct bat_priv *bat_priv,
 
 	if (bat_priv->hna_global_hash->elements * 4 >
 					bat_priv->hna_global_hash->size) {
-		swaphash = hash_resize(bat_priv->hna_global_hash,
+		swaphash = hash_resize(bat_priv->hna_global_hash, compare_orig,
 				       bat_priv->hna_global_hash->size * 2);
 
 		if (!swaphash)
@@ -450,7 +456,8 @@ static void _hna_global_del_orig(struct bat_priv *bat_priv,
 		hna_global_entry->addr, hna_global_entry->orig_node->orig,
 		message);
 
-	hash_remove(bat_priv->hna_global_hash, hna_global_entry->addr);
+	hash_remove(bat_priv->hna_global_hash, compare_orig,
+		    hna_global_entry->addr);
 	kfree(hna_global_entry);
 }
 
@@ -470,7 +477,8 @@ void hna_global_del_orig(struct bat_priv *bat_priv,
 	while ((hna_buff_count + 1) * ETH_ALEN <= orig_node->hna_buff_len) {
 		hna_ptr = orig_node->hna_buff + (hna_buff_count * ETH_ALEN);
 		hna_global_entry = (struct hna_global_entry *)
-			hash_find(bat_priv->hna_global_hash, hna_ptr);
+			hash_find(bat_priv->hna_global_hash, compare_orig,
+				  hna_ptr);
 
 		if ((hna_global_entry) &&
 		    (hna_global_entry->orig_node == orig_node))
@@ -508,7 +516,8 @@ struct orig_node *transtable_search(struct bat_priv *bat_priv, uint8_t *addr)
 
 	spin_lock_irqsave(&bat_priv->hna_ghash_lock, flags);
 	hna_global_entry = (struct hna_global_entry *)
-				hash_find(bat_priv->hna_global_hash, addr);
+				hash_find(bat_priv->hna_global_hash,
+					  compare_orig, addr);
 	spin_unlock_irqrestore(&bat_priv->hna_ghash_lock, flags);
 
 	if (!hna_global_entry)
diff --git a/drivers/staging/batman-adv/unicast.c b/drivers/staging/batman-adv/unicast.c
index 5ae9593..1f4d911 100644
--- a/drivers/staging/batman-adv/unicast.c
+++ b/drivers/staging/batman-adv/unicast.c
@@ -23,6 +23,7 @@
 #include "unicast.h"
 #include "send.h"
 #include "soft-interface.h"
+#include "originator.h"
 #include "hash.h"
 #include "translation-table.h"
 #include "routing.h"
@@ -179,7 +180,8 @@ int frag_reassemble_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	*new_skb = NULL;
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
-		    hash_find(bat_priv->orig_hash, unicast_packet->orig));
+		    hash_find(bat_priv->orig_hash, compare_orig,
+			      unicast_packet->orig));
 
 	if (!orig_node) {
 		pr_debug("couldn't find originator in orig_hash\n");
@@ -283,6 +285,7 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 
 	/* get routing information */
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
+						   compare_orig,
 						   ethhdr->h_dest));
 
 	/* check for hna host */
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index 4473cc8..ff0abe9 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -26,6 +26,7 @@
 #include "soft-interface.h"
 #include "hard-interface.h"
 #include "hash.h"
+#include "originator.h"
 
 #define MAX_VIS_PACKET_SIZE 1000
 
@@ -363,7 +364,7 @@ static struct vis_info *add_packet(struct bat_priv *bat_priv,
 						     sizeof(struct vis_packet));
 
 	memcpy(search_packet->vis_orig, vis_packet->vis_orig, ETH_ALEN);
-	old_info = hash_find(bat_priv->vis_hash, &search_elem);
+	old_info = hash_find(bat_priv->vis_hash, vis_info_cmp, &search_elem);
 	kfree_skb(search_elem.skb_packet);
 
 	if (old_info != NULL) {
@@ -380,7 +381,7 @@ static struct vis_info *add_packet(struct bat_priv *bat_priv,
 			}
 		}
 		/* remove old entry */
-		hash_remove(bat_priv->vis_hash, old_info);
+		hash_remove(bat_priv->vis_hash, vis_info_cmp, old_info);
 		send_list_del(old_info);
 		kref_put(&old_info->refcount, free_info);
 	}
@@ -421,7 +422,7 @@ static struct vis_info *add_packet(struct bat_priv *bat_priv,
 	recv_list_add(bat_priv, &info->recv_list, packet->sender_orig);
 
 	/* try to add it */
-	if (hash_add(bat_priv->vis_hash, info) < 0) {
+	if (hash_add(bat_priv->vis_hash, vis_info_cmp, info) < 0) {
 		/* did not work (for some reason) */
 		kref_put(&old_info->refcount, free_info);
 		info = NULL;
@@ -710,6 +711,7 @@ static void unicast_vis_packet(struct bat_priv *bat_priv,
 	spin_lock_irqsave(&bat_priv->orig_hash_lock, flags);
 	packet = (struct vis_packet *)info->skb_packet->data;
 	orig_node = ((struct orig_node *)hash_find(bat_priv->orig_hash,
+						   compare_orig,
 						   packet->target_orig));
 
 	if ((!orig_node) || (!orig_node->router))
@@ -794,13 +796,14 @@ int vis_init(struct bat_priv *bat_priv)
 {
 	struct vis_packet *packet;
 	unsigned long flags;
+	int hash_added;
 
 	if (bat_priv->vis_hash)
 		return 1;
 
 	spin_lock_irqsave(&bat_priv->vis_hash_lock, flags);
 
-	bat_priv->vis_hash = hash_new(256, vis_info_cmp, vis_info_choose);
+	bat_priv->vis_hash = hash_new(256, vis_info_choose);
 	if (!bat_priv->vis_hash) {
 		pr_err("Can't initialize vis_hash\n");
 		goto err;
@@ -839,7 +842,9 @@ int vis_init(struct bat_priv *bat_priv)
 
 	INIT_LIST_HEAD(&bat_priv->vis_send_list);
 
-	if (hash_add(bat_priv->vis_hash, bat_priv->my_vis_info) < 0) {
+	hash_added = hash_add(bat_priv->vis_hash, vis_info_cmp,
+			      bat_priv->my_vis_info);
+	if (hash_added < 0) {
 		pr_err("Can't add own vis packet into hash\n");
 		/* not in hash, need to remove it manually. */
 		kref_put(&bat_priv->my_vis_info->refcount, free_info);
-- 
1.7.2.3

