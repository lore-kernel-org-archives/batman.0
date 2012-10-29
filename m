Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 29 Oct 2012 09:58:06 +0100
Message-Id: <1351501097-1289-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1351501097-1289-1-git-send-email-ordex@autistici.org>
References: <1351501097-1289-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 05/16] batman-adv: return proper value in
	case of hash_add failure
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

In case of hash_add failure tt_global_add() must return 0 (which means on entry
insertion).

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d87d9b4..42a74e3 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -776,13 +776,13 @@ int batadv_tt_global_add(struct batadv_priv *bat_priv,
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Creating new global tt entry: %pM (via %pM)\n",
 		   tt_global_entry->common.addr, orig_node->orig);
+	ret = 1;
 
 out_remove:
 	/* remove address from local hash if present */
 	batadv_tt_local_remove(bat_priv, tt_global_entry->common.addr,
 			       "global tt received",
 			       flags & BATADV_TT_CLIENT_ROAM);
-	ret = 1;
 out:
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
-- 
1.7.12.4

