Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sat, 21 May 2016 17:48:17 +0800
Message-Id: <20160521094817.401-1-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH stable-4.6] batman-adv: Fix double
	neigh_node_put in batadv_v_ogm_route_update
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: stable@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

From: Sven Eckelmann <sven@narfation.org>

The router is put down twice when it was non-NULL and either orig_ifinfo is
NULL afterwards or batman-adv receives a packet with the same sequence
number. This will end up in a use-after-free when the batadv_neigh_node is
removed because the reference counter ended up too early at 0.

Fixes: 9323158ef9f4 ("batman-adv: OGMv2 - implement originators logic")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---

This patch is skipping netdev and is being sent directly to stable in
accordance with David S. Miller[1].

The reason is that this patch applies only on linux-4.6 and not on
linux-4.7/net because it was "accidentally" fixed by a refactoring
commit (more details in [2]).

It addresses a reference imbalance which systematically leads to a
use-after-free and then a kernel crash.

Cheers,

[1] https://www.mail-archive.com/b.a.t.m.a.n@lists.open-mesh.org/msg15258.html
[2] https://www.mail-archive.com/b.a.t.m.a.n@lists.open-mesh.org/msg15252.html

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
2.8.3

