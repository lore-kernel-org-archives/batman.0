Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 27 May 2014 16:19:42 +0200
Message-Id: <1401200382-19453-1-git-send-email-sven@narfation.org>
In-Reply-To: <1400940034-13406-1-git-send-email-sven@narfation.org>
References: <1400940034-13406-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] alfred: Use memleak/error path free
	implementation of hash_resize
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

The current implementation of hash_resize uses hash_add directly to initialize
a new hash table. But hash_add has two possible situations when it returns an
error

 * data already exists
 * malloc fails

The check for the duplicated data is not really harmful (beside increasing the
time to re-add elements) but the malloc can potentially return an error. This
malloc is unnecessary and just takes extra time. Instead the bucket from the
old hash table can be re-used.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2
 * fixed comit message

 hash.c | 72 ++++++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/hash.c b/hash.c
index 4b3106e..fd85a0f 100644
--- a/hash.c
+++ b/hash.c
@@ -63,6 +63,40 @@ void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb)
 	hash_destroy(hash);
 }
 
+/* adds data to the hashtable and reuse bucket.
+ * returns 0 on success, -1 on error  */
+static int hash_add_bucket(struct hashtable_t *hash, void *data,
+			   struct element_t *bucket, int check_duplicate)
+{
+	int index;
+	struct element_t *bucket_it, *prev_bucket = NULL;
+
+	index = hash->choose(data, hash->size);
+	bucket_it = hash->table[index];
+
+	while (bucket_it != NULL) {
+		if (check_duplicate &&
+		    hash->compare(bucket_it->data, data))
+			return -1;
+
+		prev_bucket = bucket_it;
+		bucket_it = bucket_it->next;
+	}
+
+	/* init the new bucket */
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
+
 /* free only the hashtable and the hash itself. */
 void hash_destroy(struct hashtable_t *hash)
 {
@@ -186,19 +220,8 @@ struct hashtable_t *hash_new(int size, hashdata_compare_cb compare,
 /* adds data to the hashtable. returns 0 on success, -1 on error */
 int hash_add(struct hashtable_t *hash, void *data)
 {
-	int index;
-	struct element_t *bucket, *prev_bucket = NULL;
-
-	index = hash->choose(data, hash->size);
-	bucket = hash->table[index];
-
-	while (bucket != NULL) {
-		if (hash->compare(bucket->data, data))
-			return -1;
-
-		prev_bucket = bucket;
-		bucket = bucket->next;
-	}
+	int ret;
+	struct element_t *bucket;
 
 	/* found the tail of the list, add new element */
 	bucket = debugMalloc(sizeof(struct element_t), 304);
@@ -206,18 +229,11 @@ int hash_add(struct hashtable_t *hash, void *data)
 	if (!bucket)
 		return -1;
 
-	/* init the new bucket */
-	bucket->data = data;
-	bucket->next = NULL;
-
-	/* and link it */
-	if (prev_bucket == NULL)
-		hash->table[index] = bucket;
-	else
-		prev_bucket->next = bucket;
+	ret = hash_add_bucket(hash, data, bucket, 1);
+	if (ret < 0)
+		debugFree(bucket, 1307);
 
-	hash->elements++;
-	return 0;
+	return ret;
 }
 
 /* finds data, based on the key in keydata. returns the found data on success,
@@ -307,10 +323,10 @@ struct hashtable_t *hash_resize(struct hashtable_t *hash, int size)
 
 	/* copy the elements */
 	for (i = 0; i < hash->size; i++) {
-		bucket = hash->table[i];
-		while (bucket != NULL) {
-			hash_add(new_hash, bucket->data);
-			bucket = bucket->next;
+		while (hash->table[i]) {
+			bucket = hash->table[i];
+			hash->table[i] = bucket->next;
+			hash_add_bucket(new_hash, bucket->data, bucket, 0);
 		}
 	}
 	/* remove hash and eventual overflow buckets but not the
-- 
2.0.0.rc4

