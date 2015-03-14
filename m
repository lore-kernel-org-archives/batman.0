Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Mar 2015 12:42:56 +0100
Message-Id: <1426333379-17777-12-git-send-email-sven@narfation.org>
In-Reply-To: <1426333379-17777-1-git-send-email-sven@narfation.org>
References: <1426333379-17777-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 11/14] alfred: Simplify comparison of pointer
	with NULL
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 hash.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/hash.c b/hash.c
index 20034d6..13372fa 100644
--- a/hash.c
+++ b/hash.c
@@ -46,9 +46,9 @@ void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb)
 	for (i = 0; i < hash->size; i++) {
 
 		bucket = hash->table[i];
-		while (bucket != NULL) {
+		while (bucket) {
 
-			if (free_cb != NULL)
+			if (free_cb)
 				free_cb(bucket->data);
 
 			last_bucket = bucket;
@@ -73,7 +73,7 @@ static int hash_add_bucket(struct hashtable_t *hash, void *data,
 	index = hash->choose(data, hash->size);
 	bucket_it = hash->table[index];
 
-	while (bucket_it != NULL) {
+	while (bucket_it) {
 		if (check_duplicate &&
 		    hash->compare(bucket_it->data, data))
 			return -1;
@@ -87,7 +87,7 @@ static int hash_add_bucket(struct hashtable_t *hash, void *data,
 	bucket->next = NULL;
 
 	/* and link it */
-	if (prev_bucket == NULL)
+	if (!prev_bucket)
 		hash->table[index] = bucket;
 	else
 		prev_bucket->next = bucket;
@@ -117,7 +117,7 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 {
 	struct hash_it_t *iter;
 
-	if (iter_in == NULL) {
+	if (!iter_in) {
 		iter = debugMalloc(sizeof(struct hash_it_t), 301);
 		iter->index =  -1;
 		iter->bucket = NULL;
@@ -128,15 +128,15 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 
 	/* sanity checks first (if our bucket got deleted in the last
 	 * iteration): */
-	if (iter->bucket != NULL) {
-		if (iter->first_bucket != NULL) {
+	if (iter->bucket) {
+		if (iter->first_bucket) {
 
 			/* we're on the first element and it got removed after
 			 * the last iteration. */
 			if ((*iter->first_bucket) != iter->bucket) {
 
 				/* there are still other elements in the list */
-				if ((*iter->first_bucket) != NULL) {
+				if (*iter->first_bucket) {
 					iter->prev_bucket = NULL;
 					iter->bucket = (*iter->first_bucket);
 					iter->first_bucket = &hash->table[iter->index];
@@ -146,7 +146,7 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 				iter->bucket = NULL;
 			}
 
-		} else if (iter->prev_bucket != NULL) {
+		} else if (iter->prev_bucket) {
 
 			/* we're not on the first element, and the bucket got
 			 * removed after the last iteration. The last bucket's
@@ -160,8 +160,8 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 	}
 
 	/* now as we are sane, select the next one if there is some */
-	if (iter->bucket != NULL) {
-		if (iter->bucket->next != NULL) {
+	if (iter->bucket) {
+		if (iter->bucket->next) {
 			iter->prev_bucket = iter->bucket;
 			iter->bucket = iter->bucket->next;
 			iter->first_bucket = NULL;
@@ -175,7 +175,7 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 	/* go through the entries of the hash table */
 	while (iter->index < hash->size) {
 
-		if ((hash->table[iter->index]) == NULL) {
+		if (!hash->table[iter->index]) {
 			iter->index++;
 			continue;
 		}
@@ -244,7 +244,7 @@ void *hash_find(struct hashtable_t *hash, void *keydata)
 	index = hash->choose(keydata , hash->size);
 	bucket = hash->table[index];
 
-	while (bucket != NULL) {
+	while (bucket) {
 		if (hash->compare(bucket->data, keydata))
 			return bucket->data;
 
@@ -265,9 +265,9 @@ void *hash_remove_bucket(struct hashtable_t *hash, struct hash_it_t *hash_it_t)
 	/* save the pointer to the data */
 	data_save = hash_it_t->bucket->data;
 
-	if (hash_it_t->prev_bucket != NULL)
+	if (hash_it_t->prev_bucket)
 		hash_it_t->prev_bucket->next = hash_it_t->bucket->next;
-	else if (hash_it_t->first_bucket != NULL)
+	else if (hash_it_t->first_bucket)
 		(*hash_it_t->first_bucket) = hash_it_t->bucket->next;
 
 	debugFree(hash_it_t->bucket, 1306);
@@ -288,7 +288,7 @@ void *hash_remove(struct hashtable_t *hash, void *data)
 	hash_it_t.bucket = hash->table[hash_it_t.index];
 	hash_it_t.prev_bucket = NULL;
 
-	while (hash_it_t.bucket != NULL) {
+	while (hash_it_t.bucket) {
 		if (hash->compare(hash_it_t.bucket->data, data)) {
 			struct element_t **first_bucket = NULL;
 
-- 
2.1.4

