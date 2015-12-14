Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 Dec 2015 09:48:31 +0100
Message-Id: <1450082911-3976-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix build with linux < 3.9.0
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

netdev_master_upper_dev_link already had a compat layer definition for
linux < 3.9. Move these two different definitions to the same block to
avoid using redefinitions which can break the build.

Fixes: e19f387b9538 ("batman-adv: add possibility to pass information about upper device via notifier")
Fixes: d794c1cd9d4f ("batman-adv: propagate upper priv via netdev_master_upper_dev_link")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/netdevice.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 10253e0..eca7668 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -84,7 +84,6 @@ static inline int batadv_netdev_set_master(struct net_device *slave,
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
 
-#define netdev_master_upper_dev_link netdev_set_master
 #define netdev_upper_dev_unlink(slave, master) netdev_set_master(slave, NULL)
 #define netdev_master_upper_dev_get(dev) \
 ({\
@@ -120,7 +119,12 @@ static inline int batadv_netdev_set_master(struct net_device *slave,
 
 #endif /* < KERNEL_VERSION(3, 19, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 5, 0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
+
+#define netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info) \
+	netdev_set_master(dev, upper_dev)
+
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(4, 5, 0)
 
 #define netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info) \
 	netdev_master_upper_dev_link(dev, upper_dev)
-- 
2.6.4

