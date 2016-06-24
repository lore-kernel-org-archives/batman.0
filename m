Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 24 Jun 2016 21:43:32 +0200
Message-Id: <1466797412-1312-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Avoid tt_req_node list put
	for unhashed entry
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

It can happen that a tt_req_node list entry was already removed from
tt.req_list when batadv_send_tt_request reaches the end of the function.
The reference counter was already reduced by 1 for the list entry and thus
the reference counter is not allowed to be reduced again. Otherwise, the
entry is freed too early and the next batadv_tt_req_node_put in this
function will operate on freed memory.

Fixes: cea194d90b11 ("batman-adv: improved client announcement mechanism")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 3c32f5f..7e6df7a 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2639,11 +2639,13 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 out:
 	if (primary_if)
 		batadv_hardif_put(primary_if);
+
 	if (ret && tt_req_node) {
 		spin_lock_bh(&bat_priv->tt.req_list_lock);
-		/* hlist_del_init() verifies tt_req_node still is in the list */
-		hlist_del_init(&tt_req_node->list);
-		batadv_tt_req_node_put(tt_req_node);
+		if (!hlist_unhashed(&tt_req_node->list)) {
+			hlist_del_init(&tt_req_node->list);
+			batadv_tt_req_node_put(tt_req_node);
+		}
 		spin_unlock_bh(&bat_priv->tt.req_list_lock);
 	}
 
