Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  4 May 2011 10:06:33 +0200
Message-Id: <1304496393-16405-6-git-send-email-sven@narfation.org>
In-Reply-To: <1304496393-16405-1-git-send-email-sven@narfation.org>
References: <1304496393-16405-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: convert
	call_rcu(softif_neigh_free_rcu) to kfree_rcu
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

The RCU callback softif_neigh_free_rcu() just calls kfree(), so we can
use kfree_rcu() instead of call_rcu().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Marek Lindner <lindner_marek@yahoo.de>
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Cc: Sven Eckelmann <sven@narfation.org>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 soft-interface.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 9e5fcd1..85ae42d 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -72,18 +72,10 @@ int my_skb_head_push(struct sk_buff *skb, unsigned int len)
 	return 0;
 }
 
-static void softif_neigh_free_rcu(struct rcu_head *rcu)
-{
-	struct softif_neigh *softif_neigh;
-
-	softif_neigh = container_of(rcu, struct softif_neigh, rcu);
-	kfree(softif_neigh);
-}
-
 static void softif_neigh_free_ref(struct softif_neigh *softif_neigh)
 {
 	if (atomic_dec_and_test(&softif_neigh->refcount))
-		call_rcu(&softif_neigh->rcu, softif_neigh_free_rcu);
+		kfree_rcu(softif_neigh, rcu);
 }
 
 static struct softif_neigh *softif_neigh_get_selected(struct bat_priv *bat_priv)
-- 
1.7.4.4

