Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 Jun 2014 21:55:58 +0200
Message-Id: <1403034964-6737-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/7] batmand: Import hash table version from
	alfred
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
Cc: Sven Eckelmann <sven@narfation.org>

All new functionality, cleanup and similar things to the hash implementation
were done in alfred. So import the newest version to keep it in sync.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 hash.c | 88 +++++++++++++++++++++++++++++++++++++++++-------------------------
 hash.h | 69 ++++++++++++++++++++++++++++++---------------------
 2 files changed, 96 insertions(+), 61 deletions(-)

diff --git a/hash.c b/hash.c
index 2a9f557..7271b89 100644
--- a/hash.c
+++ b/hash.c
@@ -20,11 +20,11 @@
  */
 
 
-#include <stdio.h>	/* NULL */
 #include "hash.h"
+#include <stdlib.h>
+#include <stdio.h>
 #include "allocate.h"
 
-
 /* clears the hash */
 void hash_init(struct hashtable_t *hash)
 {
@@ -70,9 +70,17 @@ void hash_destroy(struct hashtable_t *hash)
 	debugFree(hash, 1303);
 }
 
+/* free hash_it_t pointer when stopping hash_iterate early */
+void hash_iterate_free(struct hash_it_t *iter_in)
+{
+	debugFree(iter_in, 1304);
+}
+
 /* iterate though the hash. first element is selected with iter_in NULL.
- * use the returned iterator to access the elements until hash_it_t returns NULL. */
-struct hash_it_t *hash_iterate(struct hashtable_t *hash, struct hash_it_t *iter_in)
+ * use the returned iterator to access the elements until hash_it_t returns
+ * NULL. */
+struct hash_it_t *hash_iterate(struct hashtable_t *hash,
+			       struct hash_it_t *iter_in)
 {
 	struct hash_it_t *iter;
 
@@ -81,14 +89,17 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash, struct hash_it_t *iter_
 		iter->index =  -1;
 		iter->bucket = NULL;
 		iter->prev_bucket = NULL;
-	} else
-		iter= iter_in;
+	} else {
+		iter = iter_in;
+	}
 
-	/* sanity checks first (if our bucket got deleted in the last iteration): */
+	/* sanity checks first (if our bucket got deleted in the last
+	 * iteration): */
 	if (iter->bucket != NULL) {
 		if (iter->first_bucket != NULL) {
 
-			/* we're on the first element and it got removed after the last iteration. */
+			/* we're on the first element and it got removed after
+			 * the last iteration. */
 			if ((*iter->first_bucket) != iter->bucket) {
 
 				/* there are still other elements in the list */
@@ -105,9 +116,10 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash, struct hash_it_t *iter_
 
 		} else if (iter->prev_bucket != NULL) {
 
-			/* we're not on the first element, and the bucket got removed after the last iteration.
-			* the last bucket's next pointer is not pointing to our actual bucket anymore.
-			* select the next. */
+			/* we're not on the first element, and the bucket got
+			 * removed after the last iteration. The last bucket's
+			 * next pointer is not pointing to our actual bucket
+			 * anymore. Select the next. */
 			if (iter->prev_bucket->next != iter->bucket)
 				iter->bucket = iter->prev_bucket;
 
@@ -124,7 +136,8 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash, struct hash_it_t *iter_
 			return iter;
 		}
 	}
-	/* if not returned yet, we've reached the last one on the index and have to search forward */
+	/* if not returned yet, we've reached the last one on the index and
+	 * have to search forward */
 
 	iter->index++;
 	/* go through the entries of the hash table */
@@ -142,12 +155,13 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash, struct hash_it_t *iter_
 	}
 
 	/* nothing to iterate over anymore */
-	debugFree(iter, 1304);
+	hash_iterate_free(iter);
 	return NULL;
 }
 
 /* allocates and clears the hash */
-struct hashtable_t *hash_new(int size, hashdata_compare_cb compare, hashdata_choose_cb choose)
+struct hashtable_t *hash_new(int size, hashdata_compare_cb compare,
+			     hashdata_choose_cb choose)
 {
 	struct hashtable_t *hash;
 
@@ -155,8 +169,8 @@ struct hashtable_t *hash_new(int size, hashdata_compare_cb compare, hashdata_cho
 	if (!hash)
 		return NULL;
 
-	hash->size= size;
-	hash->table= debugMalloc(sizeof(struct element_t *) * size, 303);
+	hash->size = size;
+	hash->table = debugMalloc(sizeof(struct element_t *)*size, 303);
 
 	if (!hash->table) {
 		debugFree(hash, 1305);
@@ -183,11 +197,11 @@ int hash_add(struct hashtable_t *hash, void *data)
 			return -1;
 
 		prev_bucket = bucket;
-		bucket= bucket->next;
+		bucket = bucket->next;
 	}
 
 	/* found the tail of the list, add new element */
-	bucket = debugMalloc(sizeof(struct element_t),304);
+	bucket = debugMalloc(sizeof(struct element_t), 304);
 
 	if (!bucket)
 		return -1;
@@ -197,17 +211,17 @@ int hash_add(struct hashtable_t *hash, void *data)
 	bucket->next = NULL;
 
 	/* and link it */
-	if (prev_bucket == NULL) {
+	if (prev_bucket == NULL)
 		hash->table[index] = bucket;
-	} else {
+	else
 		prev_bucket->next = bucket;
-	}
 
 	hash->elements++;
 	return 0;
 }
 
-/* finds data, based on the key in keydata. returns the found data on success, or NULL on error */
+/* finds data, based on the key in keydata. returns the found data on success,
+ * or NULL on error */
 void *hash_find(struct hashtable_t *hash, void *keydata)
 {
 	int index;
@@ -226,20 +240,21 @@ void *hash_find(struct hashtable_t *hash, void *keydata)
 	return NULL;
 }
 
-/* remove bucket (this might be used in hash_iterate() if you already found the bucket
- * you want to delete and don't need the overhead to find it again with hash_remove().
- * But usually, you don't want to use this function, as it fiddles with hash-internals. */
+/* remove bucket (this might be used in hash_iterate() if you already found
+ * the bucket you want to delete and don't need the overhead to find it again
+ * with hash_remove(). But usually, you don't want to use this function, as it
+ * fiddles with hash-internals. */
 void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t)
 {
 	void *data_save;
 
-	data_save = hash_it_t->bucket->data;	/* save the pointer to the data */
+	/* save the pointer to the data */
+	data_save = hash_it_t->bucket->data;
 
-	if (hash_it_t->prev_bucket != NULL) {
+	if (hash_it_t->prev_bucket != NULL)
 		hash_it_t->prev_bucket->next = hash_it_t->bucket->next;
-	} else if (hash_it_t->first_bucket != NULL) {
+	else if (hash_it_t->first_bucket != NULL)
 		(*hash_it_t->first_bucket) = hash_it_t->bucket->next;
-	}
 
 	debugFree(hash_it_t->bucket, 1306);
 
@@ -261,7 +276,12 @@ void *hash_remove(struct hashtable_t *hash, void *data)
 
 	while (hash_it_t.bucket != NULL) {
 		if (hash->compare(hash_it_t.bucket->data, data)) {
-			hash_it_t.first_bucket = (hash_it_t.bucket == hash->table[hash_it_t.index] ? &hash->table[ hash_it_t.index ] : NULL);
+			int bucket_same;
+			bucket_same = (hash_it_t.bucket ==
+				       hash->table[hash_it_t.index]);
+			hash_it_t.first_bucket = (bucket_same ?
+						  &hash->table[hash_it_t.index] :
+						  NULL);
 			return hash_remove_bucket(hash, &hash_it_t);
 		}
 
@@ -272,7 +292,8 @@ void *hash_remove(struct hashtable_t *hash, void *data)
 	return NULL;
 }
 
-/* resize the hash, returns the pointer to the new hash or NULL on error. removes the old hash on success. */
+/* resize the hash, returns the pointer to the new hash or NULL on error.
+ * removes the old hash on success. */
 struct hashtable_t *hash_resize(struct hashtable_t *hash, int size)
 {
 	struct hashtable_t *new_hash;
@@ -292,8 +313,9 @@ struct hashtable_t *hash_resize(struct hashtable_t *hash, int size)
 			bucket = bucket->next;
 		}
 	}
-
-	hash_delete(hash, NULL);	/* remove hash and eventual overflow buckets but not the content itself. */
+	/* remove hash and eventual overflow buckets but not the
+	 * content itself. */
+	hash_delete(hash, NULL);
 	return new_hash;
 }
 
diff --git a/hash.h b/hash.h
index 66d7162..1682eb8 100644
--- a/hash.h
+++ b/hash.h
@@ -28,8 +28,8 @@ typedef int (*hashdata_choose_cb)(void *, int);
 typedef void (*hashdata_free_cb)(void *);
 
 struct element_t {
-	void *data;						/* pointer to the data */
-	struct element_t *next;			/* overflow bucket pointer */
+	void *data;		/* pointer to the data */
+	struct element_t *next;	/* overflow bucket pointer */
 };
 
 struct hash_it_t {
@@ -40,56 +40,69 @@ struct hash_it_t {
 };
 
 struct hashtable_t {
-	struct element_t **table;					/* the hashtable itself, with the buckets */
-	int elements;								/* number of elements registered */
-	int size;									/* size of hashtable */
-	hashdata_compare_cb compare;			    /* callback to a compare function.
-												 * should compare 2 element datas for their keys,
-												 * return 0 if same and not 0 if not same */
-	hashdata_choose_cb choose;					/* the hashfunction, should return an index based
-												 * on the key in the data of the first argument
-												 * and the size the second */
+	struct element_t **table;	/* the hashtable itself, with the
+					 * buckets */
+	int elements;			/* number of elements registered */
+	int size;			/* size of hashtable */
+	hashdata_compare_cb compare;	/* callback to a compare function.
+					 * should compare 2 element datas for
+					 * their keys, return 0 if same and not
+					 *  0 if not same */
+	hashdata_choose_cb choose;	/* the hashfunction, should return an
+					 * index based on the key in the data
+					 * of the first argument and the size
+					 * the second */
 };
 
 /* clears the hash */
-void 				 hash_init(struct hashtable_t *hash);
+void hash_init(struct hashtable_t *hash);
 
 /* allocates and clears the hash */
-struct hashtable_t	*hash_new(int size, hashdata_compare_cb compare, hashdata_choose_cb choose);
+struct hashtable_t *hash_new(int size, hashdata_compare_cb compare,
+				 hashdata_choose_cb choose);
 
-/* remove bucket (this might be used in hash_iterate() if you already found the bucket
- * you want to delete and don't need the overhead to find it again with hash_remove().
- * But usually, you don't want to use this function, as it fiddles with hash-internals. */
-void 				*hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t);
+/* remove bucket (this might be used in hash_iterate() if you already found
+ * the bucket you want to delete and don't need the overhead to find it again
+ * with hash_remove(). But usually, you don't want to use this function, as it
+ * fiddles with hash-internals. */
+void *hash_remove_bucket(struct hashtable_t *hash,
+			 struct hash_it_t *hash_it_t);
 
 /* remove the hash structure. if hashdata_free_cb != NULL,
  * this function will be called to remove the elements inside of the hash.
  * if you don't remove the elements, memory might be leaked. */
-void 				 hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb);
+void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb);
 
 /* free only the hashtable and the hash itself. */
-void 				 hash_destroy(struct hashtable_t *hash);
+void hash_destroy(struct hashtable_t *hash);
 
 /* adds data to the hashtable. returns 0 on success, -1 on error */
-int 				 hash_add(struct hashtable_t *hash, void *data);
+int hash_add(struct hashtable_t *hash, void *data);
 
 /* removes data from hash, if found. returns pointer do data on success,
  * so you can remove the used structure yourself, or NULL on error .
  * data could be the structure you use with just the key filled,
  * we just need the key for comparing. */
-void 				*hash_remove(struct hashtable_t *hash, void *data);
+void *hash_remove(struct hashtable_t *hash, void *data);
 
-/* finds data, based on the key in keydata. returns the found data on success, or NULL on error */
-void 				*hash_find(struct hashtable_t *hash, void *keydata);
+/* finds data, based on the key in keydata. returns the found data on success,
+ * or NULL on error */
+void *hash_find(struct hashtable_t *hash, void *keydata);
 
-/* resize the hash, returns the pointer to the new hash or NULL on error. removes the old hash on success */
-struct hashtable_t	*hash_resize(struct hashtable_t *hash, int size);
+/* resize the hash, returns the pointer to the new hash or NULL on error.
+ * removes the old hash on success */
+struct hashtable_t *hash_resize(struct hashtable_t *hash, int size);
 
 /* print the hash table for debugging */
-void 				 hash_debug( struct hashtable_t *hash);
+void hash_debug(struct hashtable_t *hash);
 
 /* iterate though the hash. first element is selected with iter_in NULL.
- * use the returned iterator to access the elements until hash_it_t returns NULL. */
-struct hash_it_t 	*hash_iterate(struct hashtable_t *hash, struct hash_it_t *iter_in);
+ * use the returned iterator to access the elements until hash_it_t
+ * returns NULL. */
+struct hash_it_t *hash_iterate(struct hashtable_t *hash,
+			       struct hash_it_t *iter_in);
+
+/* free hash_it_t pointer when stopping hash_iterate early */
+void hash_iterate_free(struct hash_it_t *iter_in);
 
 #endif
-- 
2.0.0

