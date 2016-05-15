Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sun, 15 May 2016 23:11:32 +0800
Message-Id: <1463325093-3927-4-git-send-email-a@unstable.cc>
In-Reply-To: <1463325093-3927-1-git-send-email-a@unstable.cc>
References: <1463325093-3927-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Fix double neigh_node_put in
	batadv_v_ogm_route_update
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

From: Sven Eckelmann <sven@narfation.org>

The router is put down twice when it was non-NULL and either orig_ifinfo is
NULL afterwards or batman-adv receives a packet with the same sequence
number. This will end up in a use-after-free when the batadv_neigh_node is
removed because the reference counter ended up too early at 0.

Fixes: 9323158ef9f4 ("batman-adv: OGMv2 - implement originators logic")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bat_v_ogm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index d9bcbe6e7d65..91df28a100f9 100644
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
2.8.2

