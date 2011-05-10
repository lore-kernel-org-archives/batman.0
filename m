Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 May 2011 09:17:01 +0200
Message-Id: <1305011821-5411-4-git-send-email-sven@narfation.org>
In-Reply-To: <1305011821-5411-1-git-send-email-sven@narfation.org>
References: <1304496393-16405-1-git-send-email-sven@narfation.org>
	<1305011821-5411-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: convert
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
Acked-by: David S. Miller <davem@davemloft.net>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Rebased on top of current master + newest version from Paul E. McKenney

 soft-interface.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index c76a33e..d5aa609 100644
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
 
 static void softif_neigh_vid_free_rcu(struct rcu_head *rcu)
-- 
1.7.5.1

