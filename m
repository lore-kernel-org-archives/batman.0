Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  8 Dec 2015 21:35:13 +0100
Message-Id: <1449606915-6457-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH-next 1/3] net: propagate upper priv via
	netdev_master_upper_dev_link
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

From: Jiri Pirko <jiri@mellanox.com>

Eliminate netdev_master_upper_dev_link_private and pass priv directly as
a parameter of netdev_master_upper_dev_link.

Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 compat-include/linux/netdevice.h | 7 +++++++
 net/batman-adv/hard-interface.c  | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index f19f624..a8da7bf 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -117,4 +117,11 @@ static inline int batadv_netdev_set_master(struct net_device *slave,
 
 #endif /* < KERNEL_VERSION(3, 19, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 5, 0)
+
+#define netdev_master_upper_dev_link(dev, upper_dev, upper_priv) \
+	netdev_master_upper_dev_link(dev, upper_dev)
+
+#endif /* < KERNEL_VERSION(4, 5, 0) */
+
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NETDEVICE_H_ */
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index bef9147..484c50e 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -466,7 +466,8 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	ret = netdev_master_upper_dev_link(hard_iface->net_dev, soft_iface);
+	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
+					   soft_iface, NULL);
 	if (ret)
 		goto err_dev;
 
-- 
2.6.2

