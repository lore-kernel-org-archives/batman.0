Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:59 +0100
Message-Id: <1290383767-32602-22-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 21/29] Staging: batman-adv: Make hash_iterate
	inlineable
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

hash_iterate is next to the function pointers the most called function
related to hashes which benefits from inlining as it is uses in loops.

Reported-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/TODO   |    1 -
 drivers/staging/batman-adv/hash.c |   72 ------------------------------------
 drivers/staging/batman-adv/hash.h |   74 +++++++++++++++++++++++++++++++++++--
 3 files changed, 70 insertions(+), 77 deletions(-)

diff --git a/drivers/staging/batman-adv/TODO b/drivers/staging/batman-adv/TODO
index 2c02aa1..91b5e9c 100644
--- a/drivers/staging/batman-adv/TODO
+++ b/drivers/staging/batman-adv/TODO
@@ -1,6 +1,5 @@
  * remove own list functionality from hash
  * use hlist_head, hlist_node in hash
- * think about more efficient ways instead of abstraction of hash
  * Request a new review
  * Process the comments from the review
  * Move into mainline proper
diff --git a/drivers/staging/batman-adv/hash.c b/drivers/staging/batman-adv/hash.c
index 7d04987..bfe943c 100644
--- a/drivers/staging/batman-adv/hash.c
+++ b/drivers/staging/batman-adv/hash.c
@@ -40,78 +40,6 @@ void hash_destroy(struct hashtable_t *hash)
 	kfree(hash);
 }
 
-/* iterate though the hash. First element is selected if an iterator
- * initialized with HASHIT() is supplied as iter. Use the returned
- * (or supplied) iterator to access the elements until hash_iterate returns
- * NULL. */
-
-struct hash_it_t *hash_iterate(struct hashtable_t *hash,
-			       struct hash_it_t *iter)
-{
-	if (!hash)
-		return NULL;
-	if (!iter)
-		return NULL;
-
-	/* sanity checks first (if our bucket got deleted in the last
-	 * iteration): */
-	if (iter->bucket != NULL) {
-		if (iter->first_bucket != NULL) {
-			/* we're on the first element and it got removed after
-			 * the last iteration. */
-			if ((*iter->first_bucket) != iter->bucket) {
-				/* there are still other elements in the list */
-				if ((*iter->first_bucket) != NULL) {
-					iter->prev_bucket = NULL;
-					iter->bucket = (*iter->first_bucket);
-					iter->first_bucket =
-						&hash->table[iter->index];
-					return iter;
-				} else {
-					iter->bucket = NULL;
-				}
-			}
-		} else if (iter->prev_bucket != NULL) {
-			/*
-			* we're not on the first element, and the bucket got
-			* removed after the last iteration.  the last bucket's
-			* next pointer is not pointing to our actual bucket
-			* anymore.  select the next.
-			*/
-			if (iter->prev_bucket->next != iter->bucket)
-				iter->bucket = iter->prev_bucket;
-		}
-	}
-
-	/* now as we are sane, select the next one if there is some */
-	if (iter->bucket != NULL) {
-		if (iter->bucket->next != NULL) {
-			iter->prev_bucket = iter->bucket;
-			iter->bucket = iter->bucket->next;
-			iter->first_bucket = NULL;
-			return iter;
-		}
-	}
-
-	/* if not returned yet, we've reached the last one on the index and have
-	 * to search forward */
-	iter->index++;
-	/* go through the entries of the hash table */
-	while (iter->index < hash->size) {
-		if ((hash->table[iter->index]) != NULL) {
-			iter->prev_bucket = NULL;
-			iter->bucket = hash->table[iter->index];
-			iter->first_bucket = &hash->table[iter->index];
-			return iter;
-		} else {
-			iter->index++;
-		}
-	}
-
-	/* nothing to iterate over anymore */
-	return NULL;
-}
-
 /* allocates and clears the hash */
 struct hashtable_t *hash_new(int size)
 {
diff --git a/drivers/staging/batman-adv/hash.h b/drivers/staging/batman-adv/hash.h
index efc4c28..a8e4dd1 100644
--- a/drivers/staging/batman-adv/hash.h
+++ b/drivers/staging/batman-adv/hash.h
@@ -224,9 +224,75 @@ static inline struct hashtable_t *hash_resize(struct hashtable_t *hash,
 	return new_hash;
 }
 
-/* iterate though the hash. first element is selected with iter_in NULL.  use
- * the returned iterator to access the elements until hash_it_t returns NULL. */
-struct hash_it_t *hash_iterate(struct hashtable_t *hash,
-			       struct hash_it_t *iter_in);
+/* iterate though the hash. First element is selected if an iterator
+ * initialized with HASHIT() is supplied as iter. Use the returned
+ * (or supplied) iterator to access the elements until hash_iterate returns
+ * NULL. */
+static inline struct hash_it_t *hash_iterate(struct hashtable_t *hash,
+					     struct hash_it_t *iter)
+{
+	if (!hash)
+		return NULL;
+	if (!iter)
+		return NULL;
+
+	/* sanity checks first (if our bucket got deleted in the last
+	 * iteration): */
+	if (iter->bucket != NULL) {
+		if (iter->first_bucket != NULL) {
+			/* we're on the first element and it got removed after
+			 * the last iteration. */
+			if ((*iter->first_bucket) != iter->bucket) {
+				/* there are still other elements in the list */
+				if ((*iter->first_bucket) != NULL) {
+					iter->prev_bucket = NULL;
+					iter->bucket = (*iter->first_bucket);
+					iter->first_bucket =
+						&hash->table[iter->index];
+					return iter;
+				} else {
+					iter->bucket = NULL;
+				}
+			}
+		} else if (iter->prev_bucket != NULL) {
+			/*
+			* we're not on the first element, and the bucket got
+			* removed after the last iteration.  the last bucket's
+			* next pointer is not pointing to our actual bucket
+			* anymore.  select the next.
+			*/
+			if (iter->prev_bucket->next != iter->bucket)
+				iter->bucket = iter->prev_bucket;
+		}
+	}
+
+	/* now as we are sane, select the next one if there is some */
+	if (iter->bucket != NULL) {
+		if (iter->bucket->next != NULL) {
+			iter->prev_bucket = iter->bucket;
+			iter->bucket = iter->bucket->next;
+			iter->first_bucket = NULL;
+			return iter;
+		}
+	}
+
+	/* if not returned yet, we've reached the last one on the index and have
+	 * to search forward */
+	iter->index++;
+	/* go through the entries of the hash table */
+	while (iter->index < hash->size) {
+		if ((hash->table[iter->index]) != NULL) {
+			iter->prev_bucket = NULL;
+			iter->bucket = hash->table[iter->index];
+			iter->first_bucket = &hash->table[iter->index];
+			return iter;
+		} else {
+			iter->index++;
+		}
+	}
+
+	/* nothing to iterate over anymore */
+	return NULL;
+}
 
 #endif /* _NET_BATMAN_ADV_HASH_H_ */
-- 
1.7.2.3

