Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 31 Jul 2013 22:47:47 +0200
Message-Id: <1375303667-3018-11-git-send-email-ordex@autistici.org>
In-Reply-To: <1375303667-3018-1-git-send-email-ordex@autistici.org>
References: <1375303667-3018-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [RFCv2 10/10] batman-adv: adapt the TT component to
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
 translation-table.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 0064423..abbc0fe 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1280,18 +1280,21 @@ out:
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
+	struct batadv_neigh_node *router;
+	struct batadv_algo_ops *bao = bat_priv->bat_algo_ops;
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry, *best_entry = NULL;
-	int best_tq = 0;
+	uint16_t metric, best_metric = 0;
 
 	head = &tt_global_entry->orig_list;
 	hlist_for_each_entry_rcu(orig_entry, head, list) {
@@ -1299,12 +1302,14 @@ batadv_transtable_best_orig(struct batadv_tt_global_entry *tt_global_entry)
 		if (!router)
 			continue;
 
-		if (router->bat_iv.tq_avg > best_tq) {
-			best_entry = orig_entry;
-			best_tq = router->bat_iv.tq_avg;
-		}
-
+		metric = bao->bat_metric_get(router);
 		batadv_neigh_node_free_ref(router);
+
+		if (metric <= best_metric)
+			continue;
+
+		best_entry = orig_entry;
+		best_metric = metric;
 	}
 
 	return best_entry;
@@ -1312,13 +1317,15 @@ batadv_transtable_best_orig(struct batadv_tt_global_entry *tt_global_entry)
 
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
@@ -1331,7 +1338,7 @@ batadv_tt_global_print_entry(struct batadv_tt_global_entry *tt_global_entry,
 	tt_common_entry = &tt_global_entry->common;
 	flags = tt_common_entry->flags;
 
-	best_entry = batadv_transtable_best_orig(tt_global_entry);
+	best_entry = batadv_transtable_best_orig(bat_priv, tt_global_entry);
 	if (best_entry) {
 		vlan = batadv_orig_node_vlan_get(best_entry->orig_node,
 						 tt_common_entry->vid);
@@ -1420,7 +1427,7 @@ int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset)
 			tt_global = container_of(tt_common_entry,
 						 struct batadv_tt_global_entry,
 						 common);
-			batadv_tt_global_print_entry(tt_global, seq);
+			batadv_tt_global_print_entry(bat_priv, tt_global, seq);
 		}
 		rcu_read_unlock();
 	}
@@ -1808,7 +1815,7 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 		goto out;
 
 	rcu_read_lock();
-	best_entry = batadv_transtable_best_orig(tt_global_entry);
+	best_entry = batadv_transtable_best_orig(bat_priv, tt_global_entry);
 	/* found anything? */
 	if (best_entry)
 		orig_node = best_entry->orig_node;
-- 
1.8.1.5

