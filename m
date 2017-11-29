Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Wed, 29 Nov 2017 10:50:42 +0100
Message-Id: <20171129095042.12587-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix check of retrieved orig_gw
 in batadv_v_gw_is_eligible
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
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>, Antonio Quartulli <a@unstable.cc>

The batadv_v_gw_is_eligible function already assumes that orig_node is not
NULL. But batadv_gw_node_get may have failed to find the originator. It
must therefore be checked whether the batadv_gw_node_get failed and not
whether orig_node is NULL to detect this error.

Fixes: 80b2d47be2c7 ("batman-adv: B.A.T.M.A.N. V - implement GW selection logic")
Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
Cc: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bat_v.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 341ceab8338d829d14a48831bef805bb04af0a8f..e0e2bfcd6b3efd73f2567d23ce304951c9e2c3f0 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -814,7 +814,7 @@ static bool batadv_v_gw_is_eligible(struct batadv_priv *bat_priv,
 	}
 
 	orig_gw = batadv_gw_node_get(bat_priv, orig_node);
-	if (!orig_node)
+	if (!orig_gw)
 		goto out;
 
 	if (batadv_v_gw_throughput_get(orig_gw, &orig_throughput) < 0)
