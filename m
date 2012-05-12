Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 02:09:27 +0200
Message-Id: <1336781383-15649-7-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-1-git-send-email-sven@narfation.org>
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 07/23] batman-adv: Prefix compat non-static
	functions with batadv_
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

batman-adv can be compiled as part of the kernel instead of an module. In that
case the linker will see all non-static symbols of batman-adv and all other
non-static symbols of the kernel. This could lead to symbol collisions. A
prefix for the batman-adv symbols that defines their private namespace avoids
such a problem.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.c |    8 ++++----
 compat.h |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/compat.c b/compat.c
index 35ad397..702c7c1 100644
--- a/compat.c
+++ b/compat.c
@@ -28,7 +28,7 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
 
-void free_rcu_gw_node(struct rcu_head *rcu)
+void batadv_free_rcu_gw_node(struct rcu_head *rcu)
 {
 	struct gw_node *gw_node;
 
@@ -36,7 +36,7 @@ void free_rcu_gw_node(struct rcu_head *rcu)
 	kfree(gw_node);
 }
 
-void free_rcu_neigh_node(struct rcu_head *rcu)
+void batadv_free_rcu_neigh_node(struct rcu_head *rcu)
 {
 	struct neigh_node *neigh_node;
 
@@ -44,7 +44,7 @@ void free_rcu_neigh_node(struct rcu_head *rcu)
 	kfree(neigh_node);
 }
 
-void free_rcu_tt_local_entry(struct rcu_head *rcu)
+void batadv_free_rcu_tt_local_entry(struct rcu_head *rcu)
 {
 	struct tt_common_entry *tt_common_entry;
 	struct tt_local_entry *tt_local_entry;
@@ -56,7 +56,7 @@ void free_rcu_tt_local_entry(struct rcu_head *rcu)
 }
 
 #ifdef CONFIG_BATMAN_ADV_BLA
-void free_rcu_backbone_gw(struct rcu_head *rcu)
+void batadv_free_rcu_backbone_gw(struct rcu_head *rcu)
 {
 	struct backbone_gw *backbone_gw;
 
diff --git a/compat.h b/compat.h
index 33c52d3..f4ec1b8 100644
--- a/compat.h
+++ b/compat.h
@@ -138,7 +138,7 @@ static inline int __param_set_copystring(const char *val,
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
 
-#define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head, free_rcu_##ptr)
+#define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head, batadv_free_rcu_##ptr)
 #define vlan_insert_tag(skb, vid) __vlan_put_tag(skb, vid)
 
 void free_rcu_gw_node(struct rcu_head *rcu);
-- 
1.7.10

