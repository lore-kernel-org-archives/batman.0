Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:26 +0100
Message-Id: <1417519009-20699-9-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 08/31] batman-adv: hash,
	remove function implementations from header
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

These functions are too big to be implemented as inline functions in the
header file. This patch moves them to the hash c file.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 hash.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hash.h | 141 +++++------------------------------------------------------------
 2 files changed, 142 insertions(+), 131 deletions(-)

diff --git a/hash.c b/hash.c
index 7c1c63080e20..c68bb8b3e8b9 100644
--- a/hash.c
+++ b/hash.c
@@ -37,6 +37,35 @@ void batadv_hash_destroy(struct batadv_hashtable *hash)
 	kfree(hash);
 }
 
+/* remove the hash structure. if hashdata_free_cb != NULL, this function will be
+ * called to remove the elements inside of the hash.  if you don't remove the
+ * elements, memory might be leaked.
+ */
+void batadv_hash_delete(struct batadv_hashtable *hash,
+			batadv_hashdata_free_cb free_cb, void *arg)
+{
+	struct hlist_head *head;
+	struct hlist_node *node, *node_tmp;
+	spinlock_t *list_lock; /* spinlock to protect write access */
+	uint32_t i;
+
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
+
+		spin_lock_bh(list_lock);
+		hlist_for_each_safe(node, node_tmp, head) {
+			hlist_del_rcu(node);
+
+			if (free_cb)
+				free_cb(node, arg);
+		}
+		spin_unlock_bh(list_lock);
+	}
+
+	batadv_hash_destroy(hash);
+}
+
 /* allocates and clears the hash */
 struct batadv_hashtable *batadv_hash_new(uint32_t size)
 {
@@ -74,3 +103,106 @@ void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
 	for (i = 0; i < hash->size; i++)
 		lockdep_set_class(&hash->list_locks[i], key);
 }
+
+/**
+ *	batadv_hash_bytes - hash some bytes and add them to the previous hash
+ *	@hash: previous hash value
+ *	@data: data to be hashed
+ *	@size: number of bytes to be hashed
+ *
+ *	Returns the new hash value.
+ */
+uint32_t batadv_hash_bytes(uint32_t hash, const void *data, uint32_t size)
+{
+	const unsigned char *key = data;
+	int i;
+
+	for (i = 0; i < size; i++) {
+		hash += key[i];
+		hash += (hash << 10);
+		hash ^= (hash >> 6);
+	}
+
+	return hash;
+}
+
+/**
+ *	batadv_hash_add - adds data to the hashtable
+ *	@hash: storage hash table
+ *	@compare: callback to determine if 2 hash elements are identical
+ *	@choose: callback calculating the hash index
+ *	@data: data passed to the aforementioned callbacks as argument
+ *	@data_node: to be added element
+ *
+ *	Returns 0 on success, 1 if the element already is in the hash
+ *	and -1 on error.
+ */
+int batadv_hash_add(struct batadv_hashtable *hash,
+		    batadv_hashdata_compare_cb compare,
+		    batadv_hashdata_choose_cb choose, const void *data,
+		    struct hlist_node *data_node)
+{
+	uint32_t index;
+	int ret = -1;
+	struct hlist_head *head;
+	struct hlist_node *node;
+	spinlock_t *list_lock; /* spinlock to protect write access */
+
+	if (!hash)
+		goto out;
+
+	index = choose(data, hash->size);
+	head = &hash->table[index];
+	list_lock = &hash->list_locks[index];
+
+	spin_lock_bh(list_lock);
+
+	hlist_for_each(node, head) {
+		if (!compare(node, data))
+			continue;
+
+		ret = 1;
+		goto unlock;
+	}
+
+	/* no duplicate found in list, add new element */
+	hlist_add_head_rcu(data_node, head);
+
+	ret = 0;
+
+unlock:
+	spin_unlock_bh(list_lock);
+out:
+	return ret;
+}
+
+/* removes data from hash, if found. returns pointer do data on success, so you
+ * can remove the used structure yourself, or NULL on error .  data could be the
+ * structure you use with just the key filled, we just need the key for
+ * comparing.
+ */
+void *batadv_hash_remove(struct batadv_hashtable *hash,
+			 batadv_hashdata_compare_cb compare,
+			 batadv_hashdata_choose_cb choose, void *data)
+{
+	uint32_t index;
+	struct hlist_node *node;
+	struct hlist_head *head;
+	void *data_save = NULL;
+
+	index = choose(data, hash->size);
+	head = &hash->table[index];
+
+	spin_lock_bh(&hash->list_locks[index]);
+	hlist_for_each(node, head) {
+		if (!compare(node, data))
+			continue;
+
+		data_save = node;
+		hlist_del_rcu(node);
+		break;
+	}
+	spin_unlock_bh(&hash->list_locks[index]);
+
+	return data_save;
+}
diff --git a/hash.h b/hash.h
index 539fc1266793..0761b64be337 100644
--- a/hash.h
+++ b/hash.h
@@ -49,139 +49,18 @@ void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
 /* free only the hashtable and the hash itself. */
 void batadv_hash_destroy(struct batadv_hashtable *hash);
 
-/* remove the hash structure. if hashdata_free_cb != NULL, this function will be
- * called to remove the elements inside of the hash.  if you don't remove the
- * elements, memory might be leaked.
- */
-static inline void batadv_hash_delete(struct batadv_hashtable *hash,
-				      batadv_hashdata_free_cb free_cb,
-				      void *arg)
-{
-	struct hlist_head *head;
-	struct hlist_node *node, *node_tmp;
-	spinlock_t *list_lock; /* spinlock to protect write access */
-	uint32_t i;
-
-	for (i = 0; i < hash->size; i++) {
-		head = &hash->table[i];
-		list_lock = &hash->list_locks[i];
-
-		spin_lock_bh(list_lock);
-		hlist_for_each_safe(node, node_tmp, head) {
-			hlist_del_rcu(node);
-
-			if (free_cb)
-				free_cb(node, arg);
-		}
-		spin_unlock_bh(list_lock);
-	}
-
-	batadv_hash_destroy(hash);
-}
-
-/**
- *	batadv_hash_bytes - hash some bytes and add them to the previous hash
- *	@hash: previous hash value
- *	@data: data to be hashed
- *	@size: number of bytes to be hashed
- *
- *	Returns the new hash value.
- */
-static inline uint32_t batadv_hash_bytes(uint32_t hash, const void *data,
-					 uint32_t size)
-{
-	const unsigned char *key = data;
-	int i;
-
-	for (i = 0; i < size; i++) {
-		hash += key[i];
-		hash += (hash << 10);
-		hash ^= (hash >> 6);
-	}
-	return hash;
-}
-
-/**
- *	batadv_hash_add - adds data to the hashtable
- *	@hash: storage hash table
- *	@compare: callback to determine if 2 hash elements are identical
- *	@choose: callback calculating the hash index
- *	@data: data passed to the aforementioned callbacks as argument
- *	@data_node: to be added element
- *
- *	Returns 0 on success, 1 if the element already is in the hash
- *	and -1 on error.
- */
-static inline int batadv_hash_add(struct batadv_hashtable *hash,
-				  batadv_hashdata_compare_cb compare,
-				  batadv_hashdata_choose_cb choose,
-				  const void *data,
-				  struct hlist_node *data_node)
-{
-	uint32_t index;
-	int ret = -1;
-	struct hlist_head *head;
-	struct hlist_node *node;
-	spinlock_t *list_lock; /* spinlock to protect write access */
-
-	if (!hash)
-		goto out;
-
-	index = choose(data, hash->size);
-	head = &hash->table[index];
-	list_lock = &hash->list_locks[index];
-
-	spin_lock_bh(list_lock);
-
-	hlist_for_each(node, head) {
-		if (!compare(node, data))
-			continue;
-
-		ret = 1;
-		goto unlock;
-	}
-
-	/* no duplicate found in list, add new element */
-	hlist_add_head_rcu(data_node, head);
-
-	ret = 0;
-
-unlock:
-	spin_unlock_bh(list_lock);
-out:
-	return ret;
-}
-
-/* removes data from hash, if found. returns pointer do data on success, so you
- * can remove the used structure yourself, or NULL on error .  data could be the
- * structure you use with just the key filled, we just need the key for
- * comparing.
- */
-static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
-				       batadv_hashdata_compare_cb compare,
-				       batadv_hashdata_choose_cb choose,
-				       void *data)
-{
-	uint32_t index;
-	struct hlist_node *node;
-	struct hlist_head *head;
-	void *data_save = NULL;
-
-	index = choose(data, hash->size);
-	head = &hash->table[index];
+uint32_t batadv_hash_bytes(uint32_t hash, const void *data, uint32_t size);
 
-	spin_lock_bh(&hash->list_locks[index]);
-	hlist_for_each(node, head) {
-		if (!compare(node, data))
-			continue;
+int batadv_hash_add(struct batadv_hashtable *hash,
+		    batadv_hashdata_compare_cb compare,
+		    batadv_hashdata_choose_cb choose, const void *data,
+		    struct hlist_node *data_node);
 
-		data_save = node;
-		hlist_del_rcu(node);
-		break;
-	}
-	spin_unlock_bh(&hash->list_locks[index]);
+void batadv_hash_delete(struct batadv_hashtable *hash,
+			batadv_hashdata_free_cb free_cb, void *arg);
 
-	return data_save;
-}
+void *batadv_hash_remove(struct batadv_hashtable *hash,
+			 batadv_hashdata_compare_cb compare,
+			 batadv_hashdata_choose_cb choose, void *data);
 
 #endif /* _NET_BATMAN_ADV_HASH_H_ */
-- 
2.1.3

