Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 22 Apr 2015 21:12:42 +0200
Message-Id: <1429729962-5365-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH-next] batman-adv: Remove unused compat
	function batadv_free_rcu_softif_vlan
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
To: b.a.t.m.a.n@lists.open-mesh.org

The commit e78c16c0550c ("batman-adv: Revert "fix var name to keep
compatibility with old kernels"") should have renamed the function to
batadv_free_rcu_softif_vlan instead of adding a new function
batadv_free_rcu_vlan because it was only used in this single place.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch is complete optional and would only silence a build_test warning
until the master branch becomes the next branch. But this would create a merge
conflict because batadv_free_rcu_softif_vlan is already removed in master.
---
 compat.c | 9 ---------
 compat.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/compat.c b/compat.c
index 516d06c..f8e213f 100644
--- a/compat.c
+++ b/compat.c
@@ -33,15 +33,6 @@ void batadv_free_rcu_orig_vlan(struct rcu_head *rcu)
 	kfree(vlan);
 }
 
-void batadv_free_rcu_softif_vlan(struct rcu_head *rcu)
-{
-	struct batadv_softif_vlan *vlan;
-
-	vlan = container_of(rcu, struct batadv_softif_vlan, rcu);
-
-	kfree(vlan);
-}
-
 void batadv_free_rcu_vlan(struct rcu_head *rcu)
 {
 	struct batadv_softif_vlan *vlan;
diff --git a/compat.h b/compat.h
index 94d0e85..d6ca427 100644
--- a/compat.h
+++ b/compat.h
@@ -226,7 +226,6 @@ static const struct { \
 #define vlan_insert_tag(skb, proto, vid) __vlan_put_tag(skb, vid)
 
 void batadv_free_rcu_orig_vlan(struct rcu_head *rcu);
-void batadv_free_rcu_softif_vlan(struct rcu_head *rcu);
 void batadv_free_rcu_tt_global_entry(struct rcu_head *rcu);
 void batadv_free_rcu_gw_node(struct rcu_head *rcu);
 void batadv_free_rcu_tt_local_entry(struct rcu_head *rcu);
-- 
2.1.4

