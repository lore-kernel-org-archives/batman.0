Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 22 Jul 2016 01:30:09 +0200
Message-Id: <1469143811-15498-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unused function
	batadv_hash_delete
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/hash.h | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index cbbf870..557a704 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -61,36 +61,6 @@ void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
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
-	u32 i;
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
 /**
  *	batadv_hash_add - adds data to the hashtable
  *	@hash: storage hash table
