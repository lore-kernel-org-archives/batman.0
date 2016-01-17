Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sun, 17 Jan 2016 13:24:34 +0800
Message-Id: <1453008281-15396-2-git-send-email-a@unstable.cc>
In-Reply-To: <1453008281-15396-1-git-send-email-a@unstable.cc>
References: <1453008281-15396-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: Avoid recursive call_rcu for
	batadv_bla_claim
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

The batadv_claim_free_ref function uses call_rcu to delay the free of the
batadv_bla_claim object until no (already started) rcu_read_lock is enabled
anymore. This makes sure that no context is still trying to access the
object which should be removed. But batadv_bla_claim also contains a
reference to backbone_gw which must be removed.

The reference drop of backbone_gw was done in the call_rcu function
batadv_claim_free_rcu but should actually be done in the
batadv_claim_release function to avoid nested call_rcus. This is important
because rcu_barrier (e.g. batadv_softif_free or batadv_exit) will not
detect the inner call_rcu as relevant for its execution. Otherwise this
barrier will most likely be inserted in the queue before the callback of
the first call_rcu was executed. The caller of rcu_barrier will therefore
continue to run before the inner call_rcu callback finished.

Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bridge_loop_avoidance.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index d5d71ac96c8a..c24c481b666f 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -127,21 +127,17 @@ batadv_backbone_gw_free_ref(struct batadv_bla_backbone_gw *backbone_gw)
 }
 
 /* finally deinitialize the claim */
-static void batadv_claim_free_rcu(struct rcu_head *rcu)
+static void batadv_claim_release(struct batadv_bla_claim *claim)
 {
-	struct batadv_bla_claim *claim;
-
-	claim = container_of(rcu, struct batadv_bla_claim, rcu);
-
 	batadv_backbone_gw_free_ref(claim->backbone_gw);
-	kfree(claim);
+	kfree_rcu(claim, rcu);
 }
 
 /* free a claim, call claim_free_rcu if its the last reference */
 static void batadv_claim_free_ref(struct batadv_bla_claim *claim)
 {
 	if (atomic_dec_and_test(&claim->refcount))
-		call_rcu(&claim->rcu, batadv_claim_free_rcu);
+		batadv_claim_release(claim);
 }
 
 /**
-- 
2.7.0

