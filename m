Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 22 Jun 2015 00:41:51 +0800
Message-Id: <1434904911-12504-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCHv3 maint] batman-adv: protect tt request from
	double deletion
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

The list_del() calls were changed to list_del_init() to prevent
an accidental double deletion in batadv_tt_req_node_new().

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
v3: rebase on maint & removed hlist conversion
v2: removed redundant hlist_unhashed() check & reword commit message

 translation-table.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index dfe8896..b6c0f52 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2194,7 +2194,7 @@ static void batadv_tt_req_list_free(struct batadv_priv *bat_priv)
 	spin_lock_bh(&bat_priv->tt.req_list_lock);
 
 	list_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
-		list_del(&node->list);
+		list_del_init(&node->list);
 		kfree(node);
 	}
 
@@ -2230,7 +2230,7 @@ static void batadv_tt_req_purge(struct batadv_priv *bat_priv)
 	list_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
 		if (batadv_has_timed_out(node->issued_at,
 					 BATADV_TT_REQUEST_TIMEOUT)) {
-			list_del(&node->list);
+			list_del_init(&node->list);
 			kfree(node);
 		}
 	}
@@ -2512,7 +2512,8 @@ out:
 		batadv_hardif_free_ref(primary_if);
 	if (ret && tt_req_node) {
 		spin_lock_bh(&bat_priv->tt.req_list_lock);
-		list_del(&tt_req_node->list);
+		/* list_del_init() verifies tt_req_node still is in the list */
+		list_del_init(&tt_req_node->list);
 		spin_unlock_bh(&bat_priv->tt.req_list_lock);
 		kfree(tt_req_node);
 	}
@@ -2949,7 +2950,7 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	list_for_each_entry_safe(node, safe, &bat_priv->tt.req_list, list) {
 		if (!batadv_compare_eth(node->addr, resp_src))
 			continue;
-		list_del(&node->list);
+		list_del_init(&node->list);
 		kfree(node);
 	}
 
-- 
2.1.4

