Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 29 Oct 2012 09:58:10 +0100
Message-Id: <1351501097-1289-10-git-send-email-ordex@autistici.org>
In-Reply-To: <1351501097-1289-1-git-send-email-ordex@autistici.org>
References: <1351501097-1289-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 09/16] batman-adv: Only increase refcounter
	once for alternate router
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

From: Sven Eckelmann <sven@narfation.org>

The test whether we can use a router for alternating bonding should only be
done once because it is already known that it is still usable and will not be
deleted from the list soon.

This patch addresses Coverity #712285: Unchecked return value

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/routing.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 8bdafc8..1ac072d 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -549,25 +549,18 @@ batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
 		if (tmp_neigh_node->if_incoming == recv_if)
 			continue;
 
+		if (router && tmp_neigh_node->tq_avg <= router->tq_avg)
+			continue;
+
 		if (!atomic_inc_not_zero(&tmp_neigh_node->refcount))
 			continue;
 
-		/* if we don't have a router yet
-		 * or this one is better, choose it.
-		 */
-		if ((!router) ||
-		    (tmp_neigh_node->tq_avg > router->tq_avg)) {
-			/* decrement refcount of
-			 * previously selected router
-			 */
-			if (router)
-				batadv_neigh_node_free_ref(router);
+		/* decrement refcount of previously selected router */
+		if (router)
+			batadv_neigh_node_free_ref(router);
 
-			router = tmp_neigh_node;
-			atomic_inc_not_zero(&router->refcount);
-		}
-
-		batadv_neigh_node_free_ref(tmp_neigh_node);
+		/* we found a better router (or at least one valid router) */
+		router = tmp_neigh_node;
 	}
 
 	/* use the first candidate if nothing was found. */
-- 
1.7.12.4

