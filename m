Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed, 11 May 2016 03:30:02 +0800
Message-Id: <1462908605-27412-15-git-send-email-a@unstable.cc>
In-Reply-To: <1462908605-27412-1-git-send-email-a@unstable.cc>
References: <1462908605-27412-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 14/17] batman-adv: Use kref_get for
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

_batadv_update_route requires that the caller already has a valid reference
for neigh_node. It is therefore not possible that it has an reference
counter of 0 and was still given to this function

The kref_get function instead WARNs (with debug information) when the
reference counter would still be 0. This makes a bug in batman-adv better
visible because kref_get_unless_zero would have ignored this problem.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/routing.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 2ecfca246be4..b494e435686f 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -100,10 +100,6 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
 	if (curr_router)
 		batadv_neigh_node_put(curr_router);
 
-	/* increase refcount of new best neighbor */
-	if (neigh_node && !kref_get_unless_zero(&neigh_node->refcount))
-		neigh_node = NULL;
-
 	spin_lock_bh(&orig_node->neigh_list_lock);
 	/* curr_router used earlier may not be the current orig_ifinfo->router
 	 * anymore because it was dereferenced outside of the neigh_list_lock
@@ -114,6 +110,10 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
 	 */
 	curr_router = rcu_dereference_protected(orig_ifinfo->router, true);
 
+	/* increase refcount of new best neighbor */
+	if (neigh_node)
+		kref_get(&neigh_node->refcount);
+
 	rcu_assign_pointer(orig_ifinfo->router, neigh_node);
 	spin_unlock_bh(&orig_node->neigh_list_lock);
 	batadv_orig_ifinfo_put(orig_ifinfo);
-- 
2.8.2

