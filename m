Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 29 Jun 2016 23:45:57 +0200
Message-Id: <1467236757-6273-1-git-send-email-sven@narfation.org>
In-Reply-To: <1467236695-6180-1-git-send-email-sven@narfation.org>
References: <1467236695-6180-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix consistency of update
	route messages
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

The debug messages of _batadv_update_route were printed before the actual
route change is done. At this point it is not really known which
curr_router will be replaced. Thus the messages could print the wrong
operation.

Printing the debug messages after the operation was done avoids this
problem.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 2bc9645..bba9276 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -74,11 +74,23 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
 	if (!orig_ifinfo)
 		return;
 
-	rcu_read_lock();
-	curr_router = rcu_dereference(orig_ifinfo->router);
-	if (curr_router && !kref_get_unless_zero(&curr_router->refcount))
-		curr_router = NULL;
-	rcu_read_unlock();
+	spin_lock_bh(&orig_node->neigh_list_lock);
+	/* curr_router used earlier may not be the current orig_ifinfo->router
+	 * anymore because it was dereferenced outside of the neigh_list_lock
+	 * protected region. After the new best neighbor has replace the current
+	 * best neighbor the reference counter needs to decrease. Consequently,
+	 * the code needs to ensure the curr_router variable contains a pointer
+	 * to the replaced best neighbor.
+	 */
+	curr_router = rcu_dereference_protected(orig_ifinfo->router, true);
+
+	/* increase refcount of new best neighbor */
+	if (neigh_node)
+		kref_get(&neigh_node->refcount);
+
+	rcu_assign_pointer(orig_ifinfo->router, neigh_node);
+	spin_unlock_bh(&orig_node->neigh_list_lock);
+	batadv_orig_ifinfo_put(orig_ifinfo);
 
 	/* route deleted */
 	if ((curr_router) && (!neigh_node)) {
@@ -100,27 +112,6 @@ static void _batadv_update_route(struct batadv_priv *bat_priv,
 			   curr_router->addr);
 	}
 
-	if (curr_router)
-		batadv_neigh_node_put(curr_router);
-
-	spin_lock_bh(&orig_node->neigh_list_lock);
-	/* curr_router used earlier may not be the current orig_ifinfo->router
-	 * anymore because it was dereferenced outside of the neigh_list_lock
-	 * protected region. After the new best neighbor has replace the current
-	 * best neighbor the reference counter needs to decrease. Consequently,
-	 * the code needs to ensure the curr_router variable contains a pointer
-	 * to the replaced best neighbor.
-	 */
-	curr_router = rcu_dereference_protected(orig_ifinfo->router, true);
-
-	/* increase refcount of new best neighbor */
-	if (neigh_node)
-		kref_get(&neigh_node->refcount);
-
-	rcu_assign_pointer(orig_ifinfo->router, neigh_node);
-	spin_unlock_bh(&orig_node->neigh_list_lock);
-	batadv_orig_ifinfo_put(orig_ifinfo);
-
 	/* decrease refcount of previous best neighbor */
 	if (curr_router)
 		batadv_neigh_node_put(curr_router);
-- 
2.8.1

