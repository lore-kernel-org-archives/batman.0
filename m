Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu,  5 May 2011 14:19:09 +0200
Message-Id: <1304597949-17173-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1304597757-17035-1-git-send-email-lindner_marek@yahoo.de>
References: <1304597757-17035-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Fix refcount imbalance in
	find_router
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
Fixed wrong subject.

 routing.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/routing.c b/routing.c
index 49f5715..d8cde2b 100644
--- a/routing.c
+++ b/routing.c
@@ -1213,7 +1213,7 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 
 	router = orig_node_get_router(orig_node);
 	if (!router)
-		return NULL;
+		goto err;
 
 	/* without bonding, the first node should
 	 * always choose the default router. */
@@ -1222,10 +1222,8 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 	rcu_read_lock();
 	/* select default router to output */
 	router_orig = router->orig_node;
-	if (!router_orig) {
-		rcu_read_unlock();
-		return NULL;
-	}
+	if (!router_orig)
+		goto err_unlock;
 
 	if ((!recv_if) && (!bonding_enabled))
 		goto return_router;
@@ -1268,6 +1266,12 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 return_router:
 	rcu_read_unlock();
 	return router;
+err_unlock:
+	rcu_read_unlock();
+err:
+	if (router)
+		neigh_node_free_ref(router);
+	return NULL;
 }
 
 static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
-- 
1.7.2.3

