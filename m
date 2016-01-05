Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jan 2016 12:06:18 +0100
Message-Id: <1451992006-13191-3-git-send-email-sven@narfation.org>
In-Reply-To: <1451992006-13191-1-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v4 03/31] batman-adv: Avoid recursive
	call_rcu for batadv_bla_claim
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

The batadv_hardif_neigh_free_ref function uses call_rcu to delay the free
of the batadv_bla_claim object until no (already started) rcu_read_lock is
enabled anymore. This makes sure that no context is still trying to access
the object which should be removed. But batadv_bla_claim also contains a
reference to backbone_gw which must be removed.

The reference drop of backbone_gw was done in the call_rcu function
batadv_claim_free_rcu but should actually be done in the
batadv_claim_release function to avoid nested call_rcus. This is important
because rcu_barrier (e.g. batadv_softif_free or batadv_exit) will not
detect the inner call_rcu as relevant for its execution. Otherwise this
barrier will most likely be inserted in the queue before the callback of
the first call_rcu was executed. The caller of rcu_barrier will therefore
continue to run before the inner call_rcu callback finished.

Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v4:
 - fix function names in commit messages
 - fix double whitespace in batadv_tt_orig_list_entry_release kerneldoc
 - add extra patch for batadv_claim_free_ref kerneldoc fix
 - change the phrase "free it" in all *_free_ref/*_put functions to "release it"
v3:
 - update copyright year
v2:
 - split patchset into fixes and kref migration to make it easier when the
   decision is made where each patch will be applied

 net/batman-adv/bridge_loop_avoidance.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index fc1b898..a840d7d 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -154,17 +154,14 @@ batadv_backbone_gw_free_ref(struct batadv_bla_backbone_gw *backbone_gw)
 }
 
 /**
- * batadv_claim_free_rcu - finally deinitialize the claim
- * @rcu: rcu pointer within the claim structure
+ * batadv_claim_release - release claim from lists and queue for free after rcu
+ *  grace period
+ * @claim: claim to be free'd
  */
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
 
 /**
@@ -175,7 +172,7 @@ static void batadv_claim_free_rcu(struct rcu_head *rcu)
 static void batadv_claim_free_ref(struct batadv_bla_claim *claim)
 {
 	if (atomic_dec_and_test(&claim->refcount))
-		call_rcu(&claim->rcu, batadv_claim_free_rcu);
+		batadv_claim_release(claim);
 }
 
 /**
-- 
2.6.4

