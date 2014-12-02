Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:36 +0100
Message-Id: <1417519009-20699-19-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 18/31] batman-adv: iv_ogm_orig_update,
	remove unnecessary brackets
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Remove these unnecessary brackets inside a condition.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index f8fd535dbdc9..232cd9ab3e6e 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1081,7 +1081,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	 * won't consider it either
 	 */
 	if (router_ifinfo &&
-	    (neigh_ifinfo->bat_iv.tq_avg == router_ifinfo->bat_iv.tq_avg)) {
+	    neigh_ifinfo->bat_iv.tq_avg == router_ifinfo->bat_iv.tq_avg) {
 		orig_node_tmp = router->orig_node;
 		spin_lock_bh(&orig_node_tmp->bat_iv.ogm_cnt_lock);
 		if_num = router->if_incoming->if_num;
-- 
2.1.3

