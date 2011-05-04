Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  4 May 2011 21:11:06 +0200
Message-Id: <1304536266-21116-1-git-send-email-sven@narfation.org>
In-Reply-To: <201105041351.35006.lindner_marek@yahoo.de>
References: <201105041351.35006.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH-Marek 2/5] batman-adv: Add compatibility code
	for kfree_rcu
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.c |   30 +++++++++++++++++++++++++++++-
 compat.h |   10 ++++++++++
 2 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/compat.c b/compat.c
index f4561c3..67c5126 100644
--- a/compat.c
+++ b/compat.c
@@ -1,4 +1,4 @@
-#include <linux/version.h>
+#include "main.h"
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29)
 
@@ -959,3 +959,31 @@ int bat_seq_printf(struct seq_file *m, const char *f, ...)
 }
 
 #endif /* < KERNEL_VERSION(2, 6, 29) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 1234)
+
+void free_rcu_gw_node(struct rcu_head *rcu)
+{
+	struct gw_node *gw_node;
+
+	gw_node = container_of(rcu, struct gw_node, rcu);
+	kfree(gw_node);
+}
+
+void free_rcu_neigh_node(struct rcu_head *rcu)
+{
+	struct neigh_node *neigh_node;
+
+	neigh_node = container_of(rcu, struct neigh_node, rcu);
+	kfree(neigh_node);
+}
+
+void free_rcu_softif_neigh(struct rcu_head *rcu)
+{
+	struct softif_neigh *softif_neigh;
+
+	softif_neigh = container_of(rcu, struct softif_neigh, rcu);
+	kfree(softif_neigh);
+}
+
+#endif /* < KERNEL_VERSION(2, 6, 1234) */
diff --git a/compat.h b/compat.h
index c3fd2cd..62fd968 100644
--- a/compat.h
+++ b/compat.h
@@ -291,4 +291,14 @@ int bat_seq_printf(struct seq_file *m, const char *f, ...);
 
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 1234)
+
+#define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head, free_rcu_##ptr)
+
+void free_rcu_gw_node(struct rcu_head *rcu);
+void free_rcu_neigh_node(struct rcu_head *rcu);
+void free_rcu_softif_neigh(struct rcu_head *rcu);
+
+#endif /* < KERNEL_VERSION(2, 6, 1234) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
1.7.4.4

