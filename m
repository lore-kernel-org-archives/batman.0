Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  3 Apr 2012 23:50:21 +0200
Message-Id: <1333489822-27692-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1333489822-27692-1-git-send-email-ordex@autistici.org>
References: <1333489822-27692-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: let
	tt_global_entry_has_orig() return the orig_entry or NULL
	instead of 1 or 0 only
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

Instead of returning only 1 or 0 this function has to return the found
orig_entry (if any). In this way, operations that have to to modify the
found orig_entry structure will not need to reiterate over the list again to
find the wanted node.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 4898e99..82711b8 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -551,25 +551,26 @@ static void tt_changes_list_free(struct bat_priv *bat_priv)
 }
 
 /* find out if an orig_node is already in the list of a tt_global_entry.
- * returns 1 if found, 0 otherwise */
-static bool tt_global_entry_has_orig(const struct tt_global_entry *entry,
-				     const struct orig_node *orig_node)
+ * returns NULL if not found, the pointer to the orig_entry otherwise */
+static struct tt_orig_list_entry *tt_global_entry_has_orig(
+					const struct tt_global_entry *entry,
+					const struct orig_node *orig_node)
 {
 	struct tt_orig_list_entry *tmp_orig_entry;
 	const struct hlist_head *head;
 	struct hlist_node *node;
-	bool found = false;
+	struct tt_orig_list_entry *orig_entry = NULL;
 
 	rcu_read_lock();
 	head = &entry->orig_list;
 	hlist_for_each_entry_rcu(tmp_orig_entry, node, head, list) {
 		if (tmp_orig_entry->orig_node == orig_node) {
-			found = true;
+			orig_entry = tmp_orig_entry;
 			break;
 		}
 	}
 	rcu_read_unlock();
-	return found;
+	return orig_entry;
 }
 
 static void tt_global_add_orig_entry(struct tt_global_entry *tt_global_entry,
-- 
1.7.9.4

