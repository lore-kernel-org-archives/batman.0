Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 May 2011 09:16:59 +0200
Message-Id: <1305011821-5411-2-git-send-email-sven@narfation.org>
In-Reply-To: <1305011821-5411-1-git-send-email-sven@narfation.org>
References: <1304496393-16405-1-git-send-email-sven@narfation.org>
	<1305011821-5411-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/4] batman-adv: convert
	call_rcu(gw_node_free_rcu) to kfree_rcu
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

The RCU callback gw_node_free_rcu() just calls kfree(), so we can use
kfree_rcu() instead of call_rcu().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Marek Lindner <lindner_marek@yahoo.de>
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Acked-by: David S. Miller <davem@davemloft.net>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Rebased on top of current master + newest version from Paul E. McKenney

 gateway_client.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 65f3953..61605a0 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -29,18 +29,10 @@
 #include <linux/udp.h>
 #include <linux/if_vlan.h>
 
-static void gw_node_free_rcu(struct rcu_head *rcu)
-{
-	struct gw_node *gw_node;
-
-	gw_node = container_of(rcu, struct gw_node, rcu);
-	kfree(gw_node);
-}
-
 static void gw_node_free_ref(struct gw_node *gw_node)
 {
 	if (atomic_dec_and_test(&gw_node->refcount))
-		call_rcu(&gw_node->rcu, gw_node_free_rcu);
+		kfree_rcu(gw_node, rcu);
 }
 
 static struct gw_node *gw_get_selected_gw_node(struct bat_priv *bat_priv)
-- 
1.7.5.1

