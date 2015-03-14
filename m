Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Mar 2015 12:42:58 +0100
Message-Id: <1426333379-17777-14-git-send-email-sven@narfation.org>
In-Reply-To: <1426333379-17777-1-git-send-email-sven@narfation.org>
References: <1426333379-17777-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 13/14] alfred: Remove empty lines after '{'
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
 hash.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/hash.c b/hash.c
index 4c90a8b..f2c8b9c 100644
--- a/hash.c
+++ b/hash.c
@@ -44,19 +44,16 @@ void hash_delete(struct hashtable_t *hash, hashdata_free_cb free_cb)
 	int i;
 
 	for (i = 0; i < hash->size; i++) {
-
 		bucket = hash->table[i];
-		while (bucket) {
 
+		while (bucket) {
 			if (free_cb)
 				free_cb(bucket->data);
 
 			last_bucket = bucket;
 			bucket = bucket->next;
 			debugFree(last_bucket, 1301);
-
 		}
-
 	}
 
 	hash_destroy(hash);
@@ -130,11 +127,9 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 	 * iteration): */
 	if (iter->bucket) {
 		if (iter->first_bucket) {
-
 			/* we're on the first element and it got removed after
 			 * the last iteration. */
 			if ((*iter->first_bucket) != iter->bucket) {
-
 				/* there are still other elements in the list */
 				if (*iter->first_bucket) {
 					iter->prev_bucket = NULL;
@@ -145,18 +140,14 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 
 				iter->bucket = NULL;
 			}
-
 		} else if (iter->prev_bucket) {
-
 			/* we're not on the first element, and the bucket got
 			 * removed after the last iteration. The last bucket's
 			 * next pointer is not pointing to our actual bucket
 			 * anymore. Select the next. */
 			if (iter->prev_bucket->next != iter->bucket)
 				iter->bucket = iter->prev_bucket;
-
 		}
-
 	}
 
 	/* now as we are sane, select the next one if there is some */
@@ -174,7 +165,6 @@ struct hash_it_t *hash_iterate(struct hashtable_t *hash,
 	iter->index++;
 	/* go through the entries of the hash table */
 	while (iter->index < hash->size) {
-
 		if (!hash->table[iter->index]) {
 			iter->index++;
 			continue;
-- 
2.1.4

