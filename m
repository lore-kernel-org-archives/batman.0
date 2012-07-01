Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  1 Jul 2012 14:09:12 +0200
Message-Id: <1341144554-27900-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1341144554-27900-1-git-send-email-ordex@autistici.org>
References: <1341144554-27900-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 1/3] batman-adv: add reference counting for
	type batadv_tt_orig_list_entry
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

The batadv_tt_orig_list_entry structure didn't have any refcounting mechanism so
far. This patch introduces it and makes the structure being usable in much more
complex context.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   73 +++++++++++++++++++++++++++++++++++----------------
 types.h             |    1 +
 2 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index a438f4b..19de1de 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -152,6 +152,8 @@ static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
 static void
 batadv_tt_orig_list_entry_free_ref(struct batadv_tt_orig_list_entry *orig_entry)
 {
+	if (!atomic_dec_and_test(&orig_entry->refcount))
+		return;
 	/* to avoid race conditions, immediately decrease the tt counter */
 	atomic_dec(&orig_entry->orig_node->tt_size);
 	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
@@ -624,50 +626,80 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->tt_changes_list_lock);
 }
 
-/* find out if an orig_node is already in the list of a tt_global_entry.
- * returns 1 if found, 0 otherwise
+/* finds out if an orig_node is already in the list of a tt_global_entry and
+ * returns it with an increased refcounter, NULL otherwise.
  */
-static bool
-batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
-				const struct batadv_orig_node *orig_node)
+static struct batadv_tt_orig_list_entry *
+batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
+				 const struct batadv_orig_node *orig_node)
 {
-	struct batadv_tt_orig_list_entry *tmp_orig_entry;
+	struct batadv_tt_orig_list_entry *tmp_orig_entry, *orig_entry = NULL;
 	const struct hlist_head *head;
 	struct hlist_node *node;
-	bool found = false;
 
 	rcu_read_lock();
 	head = &entry->orig_list;
 	hlist_for_each_entry_rcu(tmp_orig_entry, node, head, list) {
-		if (tmp_orig_entry->orig_node == orig_node) {
-			found = true;
-			break;
-		}
+		if (tmp_orig_entry->orig_node != orig_node)
+			continue;
+		if (!atomic_inc_not_zero(&tmp_orig_entry->refcount))
+			continue;
+
+		orig_entry = tmp_orig_entry;
+		break;
 	}
 	rcu_read_unlock();
+
+	return orig_entry;
+}
+
+/* find out if an orig_node is already in the list of a tt_global_entry.
+ * returns true if found, false otherwise
+ */
+static bool
+batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
+				const struct batadv_orig_node *orig_node)
+{
+	struct batadv_tt_orig_list_entry *orig_entry;
+	bool found = false;
+
+	orig_entry = batadv_tt_global_orig_entry_find(entry, orig_node);
+	if (orig_entry) {
+		found = true;
+		batadv_tt_orig_list_entry_free_ref(orig_entry);
+	}
+
 	return found;
 }
 
 static void
-batadv_tt_global_add_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
+batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 				struct batadv_orig_node *orig_node, int ttvn)
 {
 	struct batadv_tt_orig_list_entry *orig_entry;
 
+	orig_entry = batadv_tt_global_orig_entry_find(tt_global, orig_node);
+	if (orig_entry)
+		goto out;
+
 	orig_entry = kzalloc(sizeof(*orig_entry), GFP_ATOMIC);
 	if (!orig_entry)
-		return;
+		goto out;
 
 	INIT_HLIST_NODE(&orig_entry->list);
 	atomic_inc(&orig_node->refcount);
 	atomic_inc(&orig_node->tt_size);
 	orig_entry->orig_node = orig_node;
 	orig_entry->ttvn = ttvn;
+	atomic_set(&orig_entry->refcount, 2);
 
-	spin_lock_bh(&tt_global_entry->list_lock);
+	spin_lock_bh(&tt_global->list_lock);
 	hlist_add_head_rcu(&orig_entry->list,
-			   &tt_global_entry->orig_list);
-	spin_unlock_bh(&tt_global_entry->list_lock);
+			   &tt_global->orig_list);
+	spin_unlock_bh(&tt_global->list_lock);
+out:
+	if (orig_entry)
+		batadv_tt_orig_list_entry_free_ref(orig_entry);
 }
 
 /* caller must hold orig_node refcount */
@@ -708,9 +740,6 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 			batadv_tt_global_entry_free_ref(tt_global_entry);
 			goto out_remove;
 		}
-
-		batadv_tt_global_add_orig_entry(tt_global_entry, orig_node,
-						ttvn);
 	} else {
 		/* there is already a global entry, use this one. */
 
@@ -727,11 +756,9 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 			tt_global_entry->roam_at = 0;
 		}
 
-		if (!batadv_tt_global_entry_has_orig(tt_global_entry,
-						     orig_node))
-			batadv_tt_global_add_orig_entry(tt_global_entry,
-							orig_node, ttvn);
 	}
+	/* add the new orig_entry (if needed) */
+	batadv_tt_global_orig_entry_add(tt_global_entry, orig_node, ttvn);
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Creating new global tt entry: %pM (via %pM)\n",
diff --git a/types.h b/types.h
index 64b4317..82b97c3 100644
--- a/types.h
+++ b/types.h
@@ -281,6 +281,7 @@ struct batadv_tt_global_entry {
 struct batadv_tt_orig_list_entry {
 	struct batadv_orig_node *orig_node;
 	uint8_t ttvn;
+	atomic_t refcount;
 	struct rcu_head rcu;
 	struct hlist_node list;
 };
-- 
1.7.9.4

