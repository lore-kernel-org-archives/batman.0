Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 28 Aug 2013 22:54:51 +0200
Message-Id: <1377723291-3335-10-git-send-email-ordex@autistici.org>
In-Reply-To: <1377723291-3335-1-git-send-email-ordex@autistici.org>
References: <1377723291-3335-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv5 9/9] batman-adv: adapt the TT component to
	use the new API functions
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 translation-table.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 2dc214c..364a661 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1280,18 +1280,20 @@ out:
 }
 
 /* batadv_transtable_best_orig - Get best originator list entry from tt entry
+ * @bat_priv: the bat priv with all the soft interface information
  * @tt_global_entry: global translation table entry to be analyzed
  *
  * This functon assumes the caller holds rcu_read_lock().
  * Returns best originator list entry or NULL on errors.
  */
 static struct batadv_tt_orig_list_entry *
-batadv_transtable_best_orig(struct batadv_tt_global_entry *tt_global_entry)
+batadv_transtable_best_orig(struct batadv_priv *bat_priv,
+			    struct batadv_tt_global_entry *tt_global_entry)
 {
-	struct batadv_neigh_node *router = NULL;
+	struct batadv_neigh_node *router, *best_router = NULL;
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry, *best_entry = NULL;
-	int best_tq = 0;
 
 	head = &tt_global_entry->orig_list;
 	hlist_for_each_entry_rcu(orig_entry, head, list) {
@@ -1299,26 +1301,37 @@ batadv_transtable_best_orig(struct batadv_tt_global_entry *tt_global_entry)
 		if (!router)
 			continue;
 
-		if (router->bat_iv.tq_avg > best_tq) {
-			best_entry = orig_entry;
-			best_tq = router->bat_iv.tq_avg;
+		if (best_router &&
+		    bao->bat_neigh_cmp(router, best_router) <= 0) {
+			batadv_neigh_node_free_ref(router);
+			continue;
 		}
 
-		batadv_neigh_node_free_ref(router);
+		/* release the refcount for the "old" best */
+		if (best_router)
+			batadv_neigh_node_free_ref(best_router);
+
+		best_entry = orig_entry;
+		best_router = router;
 	}
 
+	if (best_router)
+		batadv_neigh_node_free_ref(best_router);
+
 	return best_entry;
 }
 
 /* batadv_tt_global_print_entry - print all orig nodes who announce the address
  * for this global entry
+ * @bat_priv: the bat priv with all the soft interface information
  * @tt_global_entry: global translation table entry to be printed
  * @seq: debugfs table seq_file struct
  *
  * This functon assumes the caller holds rcu_read_lock().
  */
 static void
-batadv_tt_global_print_entry(struct batadv_tt_global_entry *tt_global_entry,
+batadv_tt_global_print_entry(struct batadv_priv *bat_priv,
+			     struct batadv_tt_global_entry *tt_global_entry,
 			     struct seq_file *seq)
 {
 	struct batadv_tt_orig_list_entry *orig_entry, *best_entry;
@@ -1331,7 +1344,7 @@ batadv_tt_global_print_entry(struct batadv_tt_global_entry *tt_global_entry,
 	tt_common_entry = &tt_global_entry->common;
 	flags = tt_common_entry->flags;
 
-	best_entry = batadv_transtable_best_orig(tt_global_entry);
+	best_entry = batadv_transtable_best_orig(bat_priv, tt_global_entry);
 	if (best_entry) {
 		vlan = batadv_orig_node_vlan_get(best_entry->orig_node,
 						 tt_common_entry->vid);
@@ -1420,7 +1433,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 			tt_global = container_of(tt_common_entry,
 						 struct batadv_tt_global_entry,
 						 common);
-			batadv_tt_global_print_entry(tt_global, seq);
+			batadv_tt_global_print_entry(bat_priv, tt_global, seq);
 		}
 		rcu_read_unlock();
 	}
@@ -1808,7 +1821,7 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 		goto out;
 
 	rcu_read_lock();
-	best_entry = batadv_transtable_best_orig(tt_global_entry);
+	best_entry = batadv_transtable_best_orig(bat_priv, tt_global_entry);
 	/* found anything? */
 	if (best_entry)
 		orig_node = best_entry->orig_node;
-- 
1.8.1.5

