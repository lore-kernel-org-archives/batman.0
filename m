Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  6 May 2016 22:27:09 +0200
Message-Id: <1462566429-26709-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix double neigh_node_put
	in batadv_v_ogm_route_update
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

The router is put down twice when it was non-NULL and either orig_ifinfo is
NULL afterwards or batman-adv receives a packet with the same sequence
number. This will end up in a use-after-free when the batadv_neigh_node is
removed because the reference counter ended up too early at 0.

Fixes: 667996ebeab4 ("batman-adv: OGMv2 - implement originators logic")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
It looks like this bug was solved in next/master by refactoring in
30c96bc7870f ("batman-adv: move and restructure batadv_v_ogm_forward")

only compile tested. Please add so many reported by as you want - 
just don't know it it is *the* bug and who actually reported it.
---
 net/batman-adv/bat_v_ogm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index d9bcbe6..91df28a 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -529,8 +529,10 @@ static void batadv_v_ogm_route_update(struct batadv_priv *bat_priv,
 		goto out;
 	}
 
-	if (router)
+	if (router) {
 		batadv_neigh_node_put(router);
+		router = NULL;
+	}
 
 	/* Update routes, and check if the OGM is from the best next hop */
 	batadv_v_ogm_orig_update(bat_priv, orig_node, neigh_node, ogm2,
-- 
2.8.1

