Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  7 Oct 2012 13:34:15 +0200
Message-Id: <1349609655-15988-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Mark best gateway in
	transtable_global debugfs
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

The transtable_global debug file can show multiple entries for a single client
when multiple gateways exist. The chosen gateway isn't marked in the list and
therefore the user cannot easily debug the situation when there is a problem
with the currently used gateway.

The best gateway is now marked with "*" and secondary gateways are marked with
"+".

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 translation-table.c |   80 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 41613b7..ddef48d 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -912,6 +912,36 @@ out:
 	return ret;
 }
 
+/* batadv_transtable_best_orig - Get best originator list entry from tt entry
+ * @tt_global_entry: global translation table entry to be analyzed
+ *
+ * Returns best originator list entry or NULL on errors.
+ */
+static struct batadv_tt_orig_list_entry *
+batadv_transtable_best_orig(struct batadv_tt_global_entry *tt_global_entry)
+{
+	struct batadv_neigh_node *router = NULL;
+	struct hlist_head *head;
+	struct hlist_node *node;
+	struct batadv_tt_orig_list_entry *orig_entry, *best_entry = NULL;
+	int best_tq = 0;
+
+	head = &tt_global_entry->orig_list;
+	hlist_for_each_entry_rcu(orig_entry, node, head, list) {
+		router = batadv_orig_node_get_router(orig_entry->orig_node);
+		if (!router)
+			continue;
+
+		if (router->tq_avg > best_tq) {
+			best_entry = orig_entry;
+			best_tq = router->tq_avg;
+		}
+		batadv_neigh_node_free_ref(router);
+	}
+
+	return best_entry;
+}
+
 /* print all orig nodes who announce the address for this global entry.
  * it is assumed that the caller holds rcu_read_lock();
  */
@@ -921,21 +951,37 @@ batadv_tt_global_print_entry(struct batadv_tt_global_entry *tt_global_entry,
 {
 	struct hlist_head *head;
 	struct hlist_node *node;
-	struct batadv_tt_orig_list_entry *orig_entry;
+	struct batadv_tt_orig_list_entry *orig_entry, *best_entry;
 	struct batadv_tt_common_entry *tt_common_entry;
 	uint16_t flags;
 	uint8_t last_ttvn;
 
 	tt_common_entry = &tt_global_entry->common;
+	flags = tt_common_entry->flags;
+
+	best_entry = batadv_transtable_best_orig(tt_global_entry);
+	if (best_entry) {
+		last_ttvn = atomic_read(&best_entry->orig_node->last_ttvn);
+		seq_printf(seq,	" %c %pM  (%3u) via %pM     (%3u)   [%c%c%c]\n",
+			   '*', tt_global_entry->common.addr,
+			   best_entry->ttvn, best_entry->orig_node->orig,
+			   last_ttvn,
+			   (flags & BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
+			   (flags & BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
+			   (flags & BATADV_TT_CLIENT_TEMP ? 'T' : '.'));
+	}
 
 	head = &tt_global_entry->orig_list;
 
 	hlist_for_each_entry_rcu(orig_entry, node, head, list) {
-		flags = tt_common_entry->flags;
+		if (best_entry == orig_entry)
+			continue;
+
 		last_ttvn = atomic_read(&orig_entry->orig_node->last_ttvn);
-		seq_printf(seq,	" * %pM  (%3u) via %pM     (%3u)   [%c%c%c]\n",
-			   tt_global_entry->common.addr, orig_entry->ttvn,
-			   orig_entry->orig_node->orig, last_ttvn,
+		seq_printf(seq,	" %c %pM  (%3u) via %pM     (%3u)   [%c%c%c]\n",
+			   '+', tt_global_entry->common.addr,
+			   orig_entry->ttvn, orig_entry->orig_node->orig,
+			   last_ttvn,
 			   (flags & BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
 			   (flags & BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
 			   (flags & BATADV_TT_CLIENT_TEMP ? 'T' : '.'));
@@ -1281,11 +1327,7 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 	struct batadv_tt_local_entry *tt_local_entry = NULL;
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
 	struct batadv_orig_node *orig_node = NULL;
-	struct batadv_neigh_node *router = NULL;
-	struct hlist_head *head;
-	struct hlist_node *node;
-	struct batadv_tt_orig_list_entry *orig_entry;
-	int best_tq;
+	struct batadv_tt_orig_list_entry *best_entry;
 
 	if (src && atomic_read(&bat_priv->ap_isolation)) {
 		tt_local_entry = batadv_tt_local_hash_find(bat_priv, src);
@@ -1305,25 +1347,15 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 	    _batadv_is_ap_isolated(tt_local_entry, tt_global_entry))
 		goto out;
 
-	best_tq = 0;
-
 	rcu_read_lock();
-	head = &tt_global_entry->orig_list;
-	hlist_for_each_entry_rcu(orig_entry, node, head, list) {
-		router = batadv_orig_node_get_router(orig_entry->orig_node);
-		if (!router)
-			continue;
-
-		if (router->tq_avg > best_tq) {
-			orig_node = orig_entry->orig_node;
-			best_tq = router->tq_avg;
-		}
-		batadv_neigh_node_free_ref(router);
-	}
+	best_entry = batadv_transtable_best_orig(tt_global_entry);
 	/* found anything? */
+	if (best_entry)
+		orig_node = best_entry->orig_node;
 	if (orig_node && !atomic_inc_not_zero(&orig_node->refcount))
 		orig_node = NULL;
 	rcu_read_unlock();
+
 out:
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
-- 
1.7.10.4

