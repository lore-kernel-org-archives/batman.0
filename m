Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jan 2016 12:06:16 +0100
Message-Id: <1451992006-13191-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v4 01/31] batman-adv: Fix kernel-doc for
	batadv_claim_free_ref
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

 net/batman-adv/bridge_loop_avoidance.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index d9b034a..fc1b898 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -168,7 +168,8 @@ static void batadv_claim_free_rcu(struct rcu_head *rcu)
 }
 
 /**
- * batadv_claim_free_rcu - free a claim
+ * batadv_claim_free_ref - decrement the claim refcounter and possibly
+ *  release it
  * @claim: claim to be free'd
  */
 static void batadv_claim_free_ref(struct batadv_bla_claim *claim)
-- 
2.6.4

