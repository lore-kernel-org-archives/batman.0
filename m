Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  4 May 2011 10:06:32 +0200
Message-Id: <1304496393-16405-5-git-send-email-sven@narfation.org>
In-Reply-To: <1304496393-16405-1-git-send-email-sven@narfation.org>
References: <1304496393-16405-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: convert
	call_rcu(neigh_node_free_rcu) to kfree()
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

From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

The RCU callback neigh_node_free_rcu() just calls kfree(), so we can use
kfree_rcu() instead of call_rcu().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Marek Lindner <lindner_marek@yahoo.de>
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Cc: Sven Eckelmann <sven@narfation.org>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 originator.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/originator.c b/originator.c
index ef4a9be..05cc738 100644
--- a/originator.c
+++ b/originator.c
@@ -56,18 +56,10 @@ err:
 	return 0;
 }
 
-static void neigh_node_free_rcu(struct rcu_head *rcu)
-{
-	struct neigh_node *neigh_node;
-
-	neigh_node = container_of(rcu, struct neigh_node, rcu);
-	kfree(neigh_node);
-}
-
 void neigh_node_free_ref(struct neigh_node *neigh_node)
 {
 	if (atomic_dec_and_test(&neigh_node->refcount))
-		call_rcu(&neigh_node->rcu, neigh_node_free_rcu);
+		kfree_rcu(neigh_node, rcu);
 }
 
 /* increases the refcounter of a found router */
-- 
1.7.4.4

