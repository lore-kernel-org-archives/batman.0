Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 26 Jun 2012 22:00:19 +0200
Message-Id: <1340740822-4516-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1340740822-4516-1-git-send-email-ordex@autistici.org>
References: <1340740822-4516-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: implement
	batadv_tt_global_entry_get_orig()
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

batadv_tt_global_entry_get_orig() searches the originator list associated to a
given tt_global_entry and possibly for the tt_orig_list_entry associated to the
orig_node passed as argument.

batadv_tt_global_entry_has_orig() has been modified in order to use the new
function and avoid code duplication. Now it also returns bool instead of int.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 0f02514..2e90a97 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -627,17 +627,17 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->tt_changes_list_lock);
 }
 
-/* find out if an orig_node is already in the list of a tt_global_entry.
- * returns 1 if found, 0 otherwise
+/* find out if an orig_node is already in the list of a tt_global_entry and
+ * returns it with an increased refcounter if found, NULL otherwise.
+ *
  */
-static bool
-batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
+static struct batadv_tt_orig_list_entry *
+batadv_tt_global_entry_get_orig(const struct batadv_tt_global_entry *entry,
 				const struct batadv_orig_node *orig_node)
 {
-	struct batadv_tt_orig_list_entry *tmp_orig_entry;
+	struct batadv_tt_orig_list_entry *tmp_orig_entry, *orig_entry = NULL;
 	const struct hlist_head *head;
 	struct hlist_node *node;
-	bool found = false;
 
 	rcu_read_lock();
 	head = &entry->orig_list;
@@ -647,13 +647,30 @@ batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
 		if (!atomic_inc_not_zero(&tmp_orig_entry->refcount))
 			continue;
 
-			found = true;
-			batadv_tt_orig_list_entry_free_ref(tmp_orig_entry);
-			break;
+		orig_entry = tmp_orig_entry;
+		break;
 	}
 	rcu_read_unlock();
 
-	return found;
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
+	bool res = false;
+	struct batadv_tt_orig_list_entry *orig_entry;
+
+	orig_entry = batadv_tt_global_entry_get_orig(entry, orig_node);
+	if (orig_entry) {
+		res = true;
+		batadv_tt_orig_list_entry_free_ref(orig_entry);
+	}
+	return res;
 }
 
 static void
-- 
1.7.9.4

