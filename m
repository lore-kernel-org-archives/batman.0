Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Mar 2015 18:46:02 +0100
Message-Id: <1427219162-3070-4-git-send-email-sven@narfation.org>
In-Reply-To: <1427219162-3070-1-git-send-email-sven@narfation.org>
References: <1427219162-3070-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 4/4] batman-adv: Automatically create
	nested kfree_rcu helper functions
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

The kfree_rcu compat helper for old kernels require a special function that
knows how to calculate the offsets to the actual data pointer to call kfree.
These can either be manually provided or the GCC extension for nested functions
can be used to automatically create a local function using a macro.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2: no change

 compat-include/linux/rcupdate.h | 15 +++++++
 compat.c                        | 89 -----------------------------------------
 compat.h                        | 20 ---------
 3 files changed, 15 insertions(+), 109 deletions(-)

diff --git a/compat-include/linux/rcupdate.h b/compat-include/linux/rcupdate.h
index f3ed948..12a1c2a 100644
--- a/compat-include/linux/rcupdate.h
+++ b/compat-include/linux/rcupdate.h
@@ -36,4 +36,19 @@
 
 #endif /* < KERNEL_VERSION(2, 6, 34) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
+
+#define kfree_rcu(ptr, rcuhead_name) \
+	do { \
+		void batadv_free_rcu_##ptr(struct rcu_head *rcu) \
+		{ \
+			void *container_ptr; \
+			container_ptr = container_of(rcu, typeof(*(ptr)), rcuhead_name); \
+			kfree(container_ptr); \
+		} \
+		call_rcu(&(ptr)->rcuhead_name, batadv_free_rcu_##ptr); \
+	} while (0)
+
+#endif /* < KERNEL_VERSION(3, 0, 0) */
+
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_RCUPDATE_H_ */
diff --git a/compat.c b/compat.c
index 3dbf9d2..967f28c 100644
--- a/compat.c
+++ b/compat.c
@@ -18,94 +18,5 @@
  * of the Linux kernel.
  */
 
-#include <linux/in.h>
 #include <linux/version.h>
 #include "main.h"
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
-
-void batadv_free_rcu_orig_vlan(struct rcu_head *rcu)
-{
-	struct batadv_orig_node_vlan *vlan;
-
-	vlan = container_of(rcu, struct batadv_orig_node_vlan, rcu);
-
-	kfree(vlan);
-}
-
-void batadv_free_rcu_softif_vlan(struct rcu_head *rcu)
-{
-	struct batadv_softif_vlan *vlan;
-
-	vlan = container_of(rcu, struct batadv_softif_vlan, rcu);
-
-	kfree(vlan);
-}
-
-void batadv_free_rcu_tt_global_entry(struct rcu_head *rcu)
-{
-	struct batadv_tt_global_entry *global;
-
-	global = container_of(rcu, struct batadv_tt_global_entry, common.rcu);
-
-	kfree(global);
-}
-
-void batadv_free_rcu_gw_node(struct rcu_head *rcu)
-{
-	struct batadv_gw_node *gw_node;
-
-	gw_node = container_of(rcu, struct batadv_gw_node, rcu);
-	kfree(gw_node);
-}
-
-void batadv_free_rcu_tt_local_entry(struct rcu_head *rcu)
-{
-	struct batadv_tt_common_entry *tt_common_entry;
-	struct batadv_tt_local_entry *tt_local_entry;
-
-	tt_common_entry = container_of(rcu, struct batadv_tt_common_entry, rcu);
-	tt_local_entry = container_of(tt_common_entry,
-				      struct batadv_tt_local_entry, common);
-	kfree(tt_local_entry);
-}
-
-#ifdef CONFIG_BATMAN_ADV_BLA
-void batadv_free_rcu_backbone_gw(struct rcu_head *rcu)
-{
-	struct batadv_bla_backbone_gw *backbone_gw;
-
-	backbone_gw = container_of(rcu, struct batadv_bla_backbone_gw, rcu);
-	kfree(backbone_gw);
-}
-#endif
-
-#ifdef CONFIG_BATMAN_ADV_DAT
-void batadv_free_rcu_dat_entry(struct rcu_head *rcu)
-{
-	struct batadv_dat_entry *dat_entry;
-
-	dat_entry = container_of(rcu, struct batadv_dat_entry, rcu);
-	kfree(dat_entry);
-}
-#endif
-
-#ifdef CONFIG_BATMAN_ADV_NC
-void batadv_free_rcu_nc_path(struct rcu_head *rcu)
-{
-	struct batadv_nc_path *nc_path;
-
-	nc_path = container_of(rcu, struct batadv_nc_path, rcu);
-	kfree(nc_path);
-}
-#endif
-
-void batadv_free_rcu_tvlv_handler(struct rcu_head *rcu)
-{
-	struct batadv_tvlv_handler *tvlv_handler;
-
-	tvlv_handler = container_of(rcu, struct batadv_tvlv_handler, rcu);
-	kfree(tvlv_handler);
-}
-
-#endif /* < KERNEL_VERSION(3, 0, 0) */
diff --git a/compat.h b/compat.h
index 80a1543..dd0c40f 100644
--- a/compat.h
+++ b/compat.h
@@ -87,26 +87,6 @@ static const struct { \
 
 #endif /* < KERNEL_VERSION(2, 6, 39) */
 
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
-
-#define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head, batadv_free_rcu_##ptr)
-
-struct rcu_head;
-
-void batadv_free_rcu_orig_vlan(struct rcu_head *rcu);
-void batadv_free_rcu_softif_vlan(struct rcu_head *rcu);
-void batadv_free_rcu_tt_global_entry(struct rcu_head *rcu);
-void batadv_free_rcu_gw_node(struct rcu_head *rcu);
-void batadv_free_rcu_tt_local_entry(struct rcu_head *rcu);
-void batadv_free_rcu_backbone_gw(struct rcu_head *rcu);
-void batadv_free_rcu_dat_entry(struct rcu_head *rcu);
-void batadv_free_rcu_nc_path(struct rcu_head *rcu);
-void batadv_free_rcu_tvlv_handler(struct rcu_head *rcu);
-
-#endif /* < KERNEL_VERSION(3, 0, 0) */
-
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
 
 #define batadv_interface_add_vid(x, y, z) \
-- 
2.1.4

