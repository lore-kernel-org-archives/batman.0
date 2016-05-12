Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Fri, 13 May 2016 05:11:18 +0800
Message-Id: <1463087478-7101-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: B.A.T.M.A.N. V - implement
	hard-iface init function
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
Cc: Antonio Quartulli <a@unstable.cc>

Some fields in the hard-interface data structure are specific to the
B.A.T.M.A.N. V protocol and have to be initialized only when such
protocol is compiled in.
Instead of having a #ifdef block in the middle of the hard-interface.c
code it is better to have an algorithm private function that hides the
precompiler logic in its own header file (like other functions).

Fixes: ffd2f27908e5 ("batman-adv: Only init ELP tweaking options when BATMAN_V is enabled")
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---

Changes from v1:
- move bat_algo.h include line to the right location


 net/batman-adv/bat_algo.h       |  5 +++++
 net/batman-adv/bat_v.c          | 14 ++++++++++++++
 net/batman-adv/hard-interface.c | 10 ++--------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index b727762..3654296 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -25,6 +25,7 @@ int batadv_iv_init(void);
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 
 int batadv_v_init(void);
+void batadv_v_hardif_init(struct batadv_hard_iface *hardif);
 int batadv_v_mesh_init(struct batadv_priv *bat_priv);
 void batadv_v_mesh_free(struct batadv_priv *bat_priv);
 
@@ -35,6 +36,10 @@ static inline int batadv_v_init(void)
 	return 0;
 }
 
+static inline void batadv_v_hardif_init(struct batadv_hard_iface *hardif)
+{
+}
+
 static inline int batadv_v_mesh_init(struct batadv_priv *bat_priv)
 {
 	return 0;
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index b9c2850..fb2d29d 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -333,6 +333,20 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 };
 
 /**
+ * batadv_v_hardif_init - initialize the algorithm specific fields in the
+ *  hard-interface object
+ * @hard_iface: the hard-interface to initialize
+ */
+void batadv_v_hardif_init(struct batadv_hard_iface *hard_iface)
+{
+	/* enable link throughput auto-detection by setting the throughput
+	 * override to zero
+	 */
+	atomic_set(&hard_iface->bat_v.throughput_override, 0);
+	atomic_set(&hard_iface->bat_v.elp_interval, 500);
+}
+
+/**
  * batadv_v_mesh_init - initialize the B.A.T.M.A.N. V private resources for a
  *  mesh
  * @bat_priv: the object representing the mesh interface to initialise
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index a8cda76..3696929 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -37,6 +37,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
+#include "bat_algo.h"
 #include "bridge_loop_avoidance.h"
 #include "debugfs.h"
 #include "distributed-arp-table.h"
@@ -683,14 +684,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	if (batadv_is_wifi_netdev(net_dev))
 		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 
-#ifdef CONFIG_BATMAN_ADV_BATMAN_V
-	/* enable link throughput auto-detection by setting the throughput
-	 * override to zero
-	 */
-	atomic_set(&hard_iface->bat_v.throughput_override, 0);
-
-	atomic_set(&hard_iface->bat_v.elp_interval, 500);
-#endif
+	batadv_v_hardif_init(hard_iface);
 
 	/* extra reference for return */
 	kref_init(&hard_iface->refcount);
-- 
2.8.2

