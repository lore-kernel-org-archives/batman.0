Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  7 Oct 2017 14:18:53 +0200
Message-Id: <20171007121853.6278-2-sven@narfation.org>
In-Reply-To: <20171007121853.6278-1-sven@narfation.org>
References: <20171007121853.6278-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: Add extack to upper device
 linking
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

From: David Ahern <dsahern@gmail.com>

Add extack arg to netdev_upper_dev_link and netdev_master_upper_dev_link

Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[sven@narfation.org: Add compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/netdevice.h | 11 ++++++++---
 net/batman-adv/hard-interface.c  |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 00ed5e40..c29d6d21 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -66,15 +66,20 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
 
-#define netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info) \
+#define netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info, extack) \
 	netdev_set_master(dev, upper_dev)
 
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(4, 5, 0)
 
-#define netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info) \
+#define netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info, extack) \
 	netdev_master_upper_dev_link(dev, upper_dev)
 
-#endif /* < KERNEL_VERSION(4, 5, 0) */
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
+
+#define netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info, extack) \
+	netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info)
+
+#endif /* < KERNEL_VERSION(4, 15, 0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 7, 0)
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index d4aa99c0..4e3d5340 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -738,7 +738,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
 	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
-					   soft_iface, NULL, NULL);
+					   soft_iface, NULL, NULL, NULL);
 	if (ret)
 		goto err_dev;
 
-- 
2.11.0

