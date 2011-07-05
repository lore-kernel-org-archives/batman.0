Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  5 Jul 2011 17:23:04 +0200
Message-Id: <1309879385-21224-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1309879385-21224-1-git-send-email-ordex@autistici.org>
References: <1309879385-21224-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: commit changes and clean the
	transtable on ttvn increment
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

On ttvn increment all the collected changes have to be commited:
- local clients marked with TT_CLIENT_ROAM have to be unmarked.
- local clients marked with TT_CLIENT_PENDING have to be deleted.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 send.c              |    4 +--
 translation-table.c |   80 ++++++++++++++++++++++++++++++++++++++++----------
 translation-table.h |    1 +
 3 files changed, 66 insertions(+), 19 deletions(-)

diff --git a/send.c b/send.c
index 4b8e11b..6071599 100644
--- a/send.c
+++ b/send.c
@@ -310,9 +310,7 @@ void schedule_own_packet(struct hard_iface *hard_iface)
 		/* if at least one change happened */
 		if (atomic_read(&bat_priv->tt_local_changes) > 0) {
 			prepare_packet_buffer(bat_priv, hard_iface);
-			/* Increment the TTVN only once per OGM interval */
-			atomic_inc(&bat_priv->ttvn);
-			bat_priv->tt_poss_change = false;
+			tt_commit_changes(bat_priv);
 		}
 
 		/* if the changes have been sent enough times */
diff --git a/translation-table.c b/translation-table.c
index cf26ee3..fb48f04 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -358,21 +358,6 @@ out:
 	return ret;
 }
 
-static void tt_local_del(struct bat_priv *bat_priv,
-			 struct tt_local_entry *tt_local_entry,
-			 const char *message)
-{
-	bat_dbg(DBG_TT, bat_priv, "Deleting local tt entry (%pM): %s\n",
-		tt_local_entry->addr, message);
-
-	atomic_dec(&bat_priv->num_local_tt);
-
-	hash_remove(bat_priv->tt_local_hash, compare_ltt, choose_orig,
-		    tt_local_entry->addr);
-
-	tt_local_entry_free_ref(tt_local_entry);
-}
-
 void tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
 		     const char *message, bool roaming)
 {
@@ -381,7 +366,7 @@ void tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
 	tt_local_entry = tt_local_hash_find(bat_priv, addr);
 
 	if (!tt_local_entry)
-		goto out;
+		return;
 
 	tt_local_event(bat_priv, tt_local_entry->addr,
 		       tt_local_entry->flags | TT_CLIENT_DEL |
@@ -1636,3 +1621,66 @@ void tt_free(struct bat_priv *bat_priv)
 
 	kfree(bat_priv->tt_buff);
 }
+
+/* This function will purge out the specified flags from all the entries in
+ * the given hash table */
+static void tt_purge_flags(struct hashtable_t *hash, uint16_t flags)
+{
+	int i;
+	struct hlist_head *head;
+	struct hlist_node *node;
+	struct tt_local_entry *tt_local_entry;
+
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(tt_local_entry, node,
+					 head, hash_entry) {
+			tt_local_entry->flags &= ~flags;
+		}
+		rcu_read_unlock();
+	}
+
+}
+
+static void tt_purge_local_pending_clients(struct bat_priv *bat_priv)
+{
+	struct hashtable_t *hash = bat_priv->tt_local_hash;
+	struct tt_local_entry *tt_local_entry;
+	struct hlist_node *node, *node_tmp;
+	struct hlist_head *head;
+	spinlock_t *list_lock; /* protects write access to the hash lists */
+	int i;
+
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
+
+		spin_lock_bh(list_lock);
+		hlist_for_each_entry_safe(tt_local_entry, node, node_tmp,
+					  head, hash_entry) {
+			if (!(tt_local_entry->flags & TT_CLIENT_PENDING))
+				continue;
+
+			bat_dbg(DBG_TT, bat_priv, "Deleting local tt entry "
+				"(%pM): pending\n", tt_local_entry->addr);
+
+			atomic_dec(&bat_priv->num_local_tt);
+			hlist_del_rcu(node);
+			tt_local_entry_free_ref(tt_local_entry);
+		}
+		spin_unlock_bh(list_lock);
+	}
+
+}
+
+void tt_commit_changes(struct bat_priv *bat_priv)
+{
+	tt_purge_flags(bat_priv->tt_local_hash, TT_CLIENT_ROAM);
+	tt_purge_local_pending_clients(bat_priv);
+
+	/* Increment the TTVN only once per OGM interval */
+	atomic_inc(&bat_priv->ttvn);
+	bat_priv->tt_poss_change = false;
+}
diff --git a/translation-table.h b/translation-table.h
index 460e583..d4122cb 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -61,5 +61,6 @@ void handle_tt_response(struct bat_priv *bat_priv,
 			struct tt_query_packet *tt_response);
 void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 		   struct orig_node *orig_node);
+void tt_commit_changes(struct bat_priv *bat_priv);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
-- 
1.7.3.4

