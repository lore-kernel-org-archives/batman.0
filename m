Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2016 16:09:24 +0100
Message-Id: <1457190564-11419-9-git-send-email-sven@narfation.org>
In-Reply-To: <1457190564-11419-1-git-send-email-sven@narfation.org>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 9/9] batman-adv: Use kref_get for
	_batadv_update_route
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

_batadv_update_route requires that the caller already has a valid reference
for neigh_node. It is therefore not possible that it has an reference
counter of 0 and was still given to this function

The kref_get function instead WARNs (with debug information) when the
reference counter would still be 0. This makes a bug in batman-adv better
visible because kref_get_unless_zero would have ignored this problem.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch requires https://patchwork.open-mesh.org/patch/15888/

 net/batman-adv/routing.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index ffc4c09..acfd313 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -100,13 +100,12 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
 	if (curr_router)
 		batadv_neigh_node_put(curr_router);
 
-	/* increase refcount of new best neighbor */
-	if (neigh_node && !kref_get_unless_zero(&neigh_node->refcount))
-		neigh_node = NULL;
 
 	spin_lock_bh(&orig_node->neigh_list_lock);
 	curr_router = rcu_dereference_protected(orig_ifinfo->router, true);
 
+	if (neigh_node)
+		kref_get(&neigh_node->refcount);
 	rcu_assign_pointer(orig_ifinfo->router, neigh_node);
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 	batadv_orig_ifinfo_put(orig_ifinfo);
-- 
2.7.0

