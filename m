Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 30 Oct 2011 20:09:01 +0100
Message-Id: <1320001741-18351-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: generalise tt_local_reset_flags()
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
To: b.a.t.m.a.n@lists.open-mesh.org

The tt_local_reset_flags() is actually used for one use case only. It is not
generalised enough to be used indifferent situations. This patch make it general
enough in order to let other code use it whenever a flag flip is requested over
the whole hash table (passed as parameter).

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

This patch depends on:

batman-adv: create a common substructure for tt_global/local_entry


 translation-table.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 76134bc..5b60aba 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1695,19 +1695,20 @@ void tt_free(struct bat_priv *bat_priv)
 	kfree(bat_priv->tt_buff);
 }
 
-/* This function will reset the specified flags from all the entries in
- * the given hash table and will increment num_local_tt for each involved
- * entry */
-static void tt_local_reset_flags(struct bat_priv *bat_priv, uint16_t flags)
+/* This function will flip to new_value (if not already) the specified flags for
+ * all the entries in the given hash table and returns the number of modified
+ * entries */
+static uint16_t tt_flip_flags(struct hashtable_t *hash, uint16_t flags,
+			     uint8_t new_value)
 {
 	uint32_t i;
-	struct hashtable_t *hash = bat_priv->tt_local_hash;
+	uint16_t changed_num = 0;
 	struct hlist_head *head;
 	struct hlist_node *node;
 	struct tt_common_entry *tt_common_entry;
 
 	if (!hash)
-		return;
+		goto out;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -1715,14 +1716,18 @@ static void tt_local_reset_flags(struct bat_priv *bat_priv, uint16_t flags)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry, node,
 					 head, hash_entry) {
-			if (!(tt_common_entry->flags & flags))
+			if ((tt_common_entry->flags & flags) != new_value)
 				continue;
-			tt_common_entry->flags &= ~flags;
-			atomic_inc(&bat_priv->num_local_tt);
+			/* depending on 'new_value', enable or disable the flags
+			 * pointed by 'flags' */
+			tt_common_entry->flags &=
+				(~flags | (new_value ? flags : NO_FLAGS));
+			changed_num++;
 		}
 		rcu_read_unlock();
 	}
-
+out:
+	return changed_num;
 }
 
 /* Purge out all the tt local entries marked with TT_CLIENT_PENDING */
@@ -1766,7 +1771,11 @@ static void tt_local_purge_pending_clients(struct bat_priv *bat_priv)
 
 void tt_commit_changes(struct bat_priv *bat_priv)
 {
-	tt_local_reset_flags(bat_priv, TT_CLIENT_NEW);
+	uint16_t changed_num = tt_flip_flags(bat_priv->tt_local_hash,
+					    TT_CLIENT_NEW, 0);
+	/* all the reset entries have now to be effectively counted as local
+	 * entries */
+	atomic_add(changed_num, &bat_priv->num_local_tt);
 	tt_local_purge_pending_clients(bat_priv);
 
 	/* Increment the TTVN only once per OGM interval */
-- 
1.7.3.4

