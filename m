Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:58 +0100
Message-Id: <1290383767-32602-21-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 20/29] Staging: batman-adv: Move hash
	callback related function to header
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

To enable inlining of the function pointers hashdata_choose_cb,
hashdata_choose_cb and hashdata_free_cb, also the hash functions which
uses them must be inlined by the called function.

This should increase the performance, but also increases the size of the
generated machine code slightly.

Reported-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/hash.c |  150 ------------------------------------
 drivers/staging/batman-adv/hash.h |  152 ++++++++++++++++++++++++++++++++++---
 2 files changed, 140 insertions(+), 162 deletions(-)

diff --git a/drivers/staging/batman-adv/hash.c b/drivers/staging/batman-adv/hash.c
index 6361a31..7d04987 100644
--- a/drivers/staging/batman-adv/hash.c
+++ b/drivers/staging/batman-adv/hash.c
@@ -33,30 +33,6 @@ static void hash_init(struct hashtable_t *hash)
 		hash->table[i] = NULL;
 }
 
-/* remove the hash structure. if hashdata_free_cb != NULL, this function will be
- * called to remove the elements inside of the hash.  if you don't remove the
- * elements, memory might be leaked. */
-void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb, void *arg)
-{
-	struct element_t *bucket, *last_bucket;
-	int i;
-
-	for (i = 0; i < hash->size; i++) {
-		bucket = hash->table[i];
-
-		while (bucket != NULL) {
-			if (free_cb != NULL)
-				free_cb(bucket->data, arg);
-
-			last_bucket = bucket;
-			bucket = bucket->next;
-			kfree(last_bucket);
-		}
-	}
-
-	hash_destroy(hash);
-}
-
 /* free only the hashtable and the hash itself. */
 void hash_destroy(struct hashtable_t *hash)
 {
@@ -159,70 +135,6 @@ struct hashtable_t *hash_new(int size)
 	return hash;
 }
 
-/* adds data to the hashtable. returns 0 on success, -1 on error */
-int hash_add(struct hashtable_t *hash, hashdata_compare_cb compare,
-	     hashdata_choose_cb choose, void *data)
-{
-	int index;
-	struct element_t *bucket, *prev_bucket = NULL;
-
-	if (!hash)
-		return -1;
-
-	index = choose(data, hash->size);
-	bucket = hash->table[index];
-
-	while (bucket != NULL) {
-		if (compare(bucket->data, data))
-			return -1;
-
-		prev_bucket = bucket;
-		bucket = bucket->next;
-	}
-
-	/* found the tail of the list, add new element */
-	bucket = kmalloc(sizeof(struct element_t), GFP_ATOMIC);
-
-	if (bucket == NULL)
-		return -1;
-
-	bucket->data = data;
-	bucket->next = NULL;
-
-	/* and link it */
-	if (prev_bucket == NULL)
-		hash->table[index] = bucket;
-	else
-		prev_bucket->next = bucket;
-
-	hash->elements++;
-	return 0;
-}
-
-/* finds data, based on the key in keydata. returns the found data on success,
- * or NULL on error */
-void *hash_find(struct hashtable_t *hash, hashdata_compare_cb compare,
-		hashdata_choose_cb choose, void *keydata)
-{
-	int index;
-	struct element_t *bucket;
-
-	if (!hash)
-		return NULL;
-
-	index = choose(keydata , hash->size);
-	bucket = hash->table[index];
-
-	while (bucket != NULL) {
-		if (compare(bucket->data, keydata))
-			return bucket->data;
-
-		bucket = bucket->next;
-	}
-
-	return NULL;
-}
-
 /* remove bucket (this might be used in hash_iterate() if you already found the
  * bucket you want to delete and don't need the overhead to find it again with
  * hash_remove(). But usually, you don't want to use this function, as it
@@ -243,65 +155,3 @@ void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t)
 
 	return data_save;
 }
-
-/* removes data from hash, if found. returns pointer do data on success, so you
- * can remove the used structure yourself, or NULL on error .  data could be the
- * structure you use with just the key filled, we just need the key for
- * comparing. */
-void *hash_remove(struct hashtable_t *hash, hashdata_compare_cb compare,
-		  hashdata_choose_cb choose, void *data)
-{
-	struct hash_it_t hash_it_t;
-
-	hash_it_t.index = choose(data, hash->size);
-	hash_it_t.bucket = hash->table[hash_it_t.index];
-	hash_it_t.prev_bucket = NULL;
-
-	while (hash_it_t.bucket != NULL) {
-		if (compare(hash_it_t.bucket->data, data)) {
-			hash_it_t.first_bucket =
-				(hash_it_t.bucket ==
-				 hash->table[hash_it_t.index] ?
-				 &hash->table[hash_it_t.index] : NULL);
-			return hash_remove_bucket(hash, &hash_it_t);
-		}
-
-		hash_it_t.prev_bucket = hash_it_t.bucket;
-		hash_it_t.bucket = hash_it_t.bucket->next;
-	}
-
-	return NULL;
-}
-
-/* resize the hash, returns the pointer to the new hash or NULL on
- * error. removes the old hash on success. */
-struct hashtable_t *hash_resize(struct hashtable_t *hash,
-				hashdata_compare_cb compare,
-				hashdata_choose_cb choose, int size)
-{
-	struct hashtable_t *new_hash;
-	struct element_t *bucket;
-	int i;
-
-	/* initialize a new hash with the new size */
-	new_hash = hash_new(size);
-
-	if (new_hash == NULL)
-		return NULL;
-
-	/* copy the elements */
-	for (i = 0; i < hash->size; i++) {
-		bucket = hash->table[i];
-
-		while (bucket != NULL) {
-			hash_add(new_hash, compare, choose, bucket->data);
-			bucket = bucket->next;
-		}
-	}
-
-	/* remove hash and eventual overflow buckets but not the content
-	 * itself. */
-	hash_delete(hash, NULL, NULL);
-
-	return new_hash;
-}
diff --git a/drivers/staging/batman-adv/hash.h b/drivers/staging/batman-adv/hash.h
index 85ee12b..efc4c28 100644
--- a/drivers/staging/batman-adv/hash.h
+++ b/drivers/staging/batman-adv/hash.h
@@ -66,35 +66,163 @@ struct hashtable_t *hash_new(int size);
  * fiddles with hash-internals. */
 void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t);
 
+/* free only the hashtable and the hash itself. */
+void hash_destroy(struct hashtable_t *hash);
+
 /* remove the hash structure. if hashdata_free_cb != NULL, this function will be
  * called to remove the elements inside of the hash.  if you don't remove the
  * elements, memory might be leaked. */
-void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb, void *arg);
+static inline void hash_delete(struct hashtable_t *hash,
+			       hashdata_free_cb free_cb, void *arg)
+{
+	struct element_t *bucket, *last_bucket;
+	int i;
 
-/* free only the hashtable and the hash itself. */
-void hash_destroy(struct hashtable_t *hash);
+	for (i = 0; i < hash->size; i++) {
+		bucket = hash->table[i];
+
+		while (bucket != NULL) {
+			if (free_cb != NULL)
+				free_cb(bucket->data, arg);
+
+			last_bucket = bucket;
+			bucket = bucket->next;
+			kfree(last_bucket);
+		}
+	}
+
+	hash_destroy(hash);
+}
 
 /* adds data to the hashtable. returns 0 on success, -1 on error */
-int hash_add(struct hashtable_t *hash, hashdata_compare_cb compare,
-	     hashdata_choose_cb choose, void *data);
+static inline int hash_add(struct hashtable_t *hash,
+			   hashdata_compare_cb compare,
+			   hashdata_choose_cb choose, void *data)
+{
+	int index;
+	struct element_t *bucket, *prev_bucket = NULL;
+
+	if (!hash)
+		return -1;
+
+	index = choose(data, hash->size);
+	bucket = hash->table[index];
+
+	while (bucket != NULL) {
+		if (compare(bucket->data, data))
+			return -1;
+
+		prev_bucket = bucket;
+		bucket = bucket->next;
+	}
+
+	/* found the tail of the list, add new element */
+	bucket = kmalloc(sizeof(struct element_t), GFP_ATOMIC);
+
+	if (bucket == NULL)
+		return -1;
+
+	bucket->data = data;
+	bucket->next = NULL;
+
+	/* and link it */
+	if (prev_bucket == NULL)
+		hash->table[index] = bucket;
+	else
+		prev_bucket->next = bucket;
+
+	hash->elements++;
+	return 0;
+}
 
 /* removes data from hash, if found. returns pointer do data on success, so you
  * can remove the used structure yourself, or NULL on error .  data could be the
  * structure you use with just the key filled, we just need the key for
  * comparing. */
-void *hash_remove(struct hashtable_t *hash, hashdata_compare_cb compare,
-		  hashdata_choose_cb choose, void *data);
+static inline void *hash_remove(struct hashtable_t *hash,
+				hashdata_compare_cb compare,
+				hashdata_choose_cb choose, void *data)
+{
+	struct hash_it_t hash_it_t;
+
+	hash_it_t.index = choose(data, hash->size);
+	hash_it_t.bucket = hash->table[hash_it_t.index];
+	hash_it_t.prev_bucket = NULL;
+
+	while (hash_it_t.bucket != NULL) {
+		if (compare(hash_it_t.bucket->data, data)) {
+			hash_it_t.first_bucket =
+				(hash_it_t.bucket ==
+				 hash->table[hash_it_t.index] ?
+				 &hash->table[hash_it_t.index] : NULL);
+			return hash_remove_bucket(hash, &hash_it_t);
+		}
+
+		hash_it_t.prev_bucket = hash_it_t.bucket;
+		hash_it_t.bucket = hash_it_t.bucket->next;
+	}
+
+	return NULL;
+}
 
 /* finds data, based on the key in keydata. returns the found data on success,
  * or NULL on error */
-void *hash_find(struct hashtable_t *hash, hashdata_compare_cb compare,
-		hashdata_choose_cb choose, void *keydata);
+static inline void *hash_find(struct hashtable_t *hash,
+			      hashdata_compare_cb compare,
+			      hashdata_choose_cb choose, void *keydata)
+{
+	int index;
+	struct element_t *bucket;
+
+	if (!hash)
+		return NULL;
+
+	index = choose(keydata , hash->size);
+	bucket = hash->table[index];
+
+	while (bucket != NULL) {
+		if (compare(bucket->data, keydata))
+			return bucket->data;
+
+		bucket = bucket->next;
+	}
+
+	return NULL;
+}
 
 /* resize the hash, returns the pointer to the new hash or NULL on
  * error. removes the old hash on success */
-struct hashtable_t *hash_resize(struct hashtable_t *hash,
-				hashdata_compare_cb compare,
-				hashdata_choose_cb choose, int size);
+static inline struct hashtable_t *hash_resize(struct hashtable_t *hash,
+					      hashdata_compare_cb compare,
+					      hashdata_choose_cb choose,
+					      int size)
+{
+	struct hashtable_t *new_hash;
+	struct element_t *bucket;
+	int i;
+
+	/* initialize a new hash with the new size */
+	new_hash = hash_new(size);
+
+	if (new_hash == NULL)
+		return NULL;
+
+	/* copy the elements */
+	for (i = 0; i < hash->size; i++) {
+		bucket = hash->table[i];
+
+		while (bucket != NULL) {
+			hash_add(new_hash, compare, choose, bucket->data);
+			bucket = bucket->next;
+		}
+	}
+
+	/* remove hash and eventual overflow buckets but not the content
+	 * itself. */
+	hash_delete(hash, NULL, NULL);
+
+	return new_hash;
+}
 
 /* iterate though the hash. first element is selected with iter_in NULL.  use
  * the returned iterator to access the elements until hash_it_t returns NULL. */
-- 
1.7.2.3

