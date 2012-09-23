Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 23 Sep 2012 22:38:36 +0200
Message-Id: <1348432717-20913-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1348432717-20913-1-git-send-email-ordex@autistici.org>
References: <1348432717-20913-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: refactor
	tt_global_del_struct()
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

batadv_tt_global_del_struct() function is not properly named.
Having a more meaningful name which reflects the current behavior helps other
developers to easily understand what it does.

A parameter has also been renamed in order to let the function header better fit
the 80-chars line-width

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 290c80b..919bc41 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -927,18 +927,17 @@ batadv_tt_global_del_orig_entry(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&tt_global_entry->list_lock);
 }
 
-static void
-batadv_tt_global_del_struct(struct batadv_priv *bat_priv,
-			    struct batadv_tt_global_entry *tt_global_entry,
-			    const char *message)
+static void batadv_tt_global_free(struct batadv_priv *bat_priv,
+				  struct batadv_tt_global_entry *tt_global,
+				  const char *message)
 {
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Deleting global tt entry %pM: %s\n",
-		   tt_global_entry->common.addr, message);
+		   tt_global->common.addr, message);
 
 	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
-			   batadv_choose_orig, tt_global_entry->common.addr);
-	batadv_tt_global_entry_free_ref(tt_global_entry);
+			   batadv_choose_orig, tt_global->common.addr);
+	batadv_tt_global_entry_free_ref(tt_global);
 
 }
 
@@ -1002,8 +1001,8 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 						orig_node, message);
 
 		if (hlist_empty(&tt_global_entry->orig_list))
-			batadv_tt_global_del_struct(bat_priv, tt_global_entry,
-						    message);
+			batadv_tt_global_free(bat_priv, tt_global_entry,
+					      message);
 
 		goto out;
 	}
@@ -1026,7 +1025,7 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 	if (local_entry) {
 		/* local entry exists, case 2: client roamed to us. */
 		batadv_tt_global_del_orig_list(tt_global_entry);
-		batadv_tt_global_del_struct(bat_priv, tt_global_entry, message);
+		batadv_tt_global_free(bat_priv, tt_global_entry, message);
 	} else
 		/* no local entry exists, case 1: check for roaming */
 		batadv_tt_global_del_roaming(bat_priv, tt_global_entry,
-- 
1.7.12

