Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  8 Dec 2015 21:35:14 +0100
Message-Id: <1449606915-6457-2-git-send-email-sven@narfation.org>
In-Reply-To: <1449606915-6457-1-git-send-email-sven@narfation.org>
References: <1449606915-6457-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH-next 2/3] net: add possibility to pass
	information about upper device via notifier
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

Sometimes the drivers and other code would find it handy to know some
internal information about upper device being changed. So allow upper-code
to pass information down to notifier listeners during linking.

Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 compat-include/linux/netdevice.h | 2 +-
 net/batman-adv/hard-interface.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index a8da7bf..34e5ac7 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -119,7 +119,7 @@ static inline int batadv_netdev_set_master(struct net_device *slave,
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 5, 0)
 
-#define netdev_master_upper_dev_link(dev, upper_dev, upper_priv) \
+#define netdev_master_upper_dev_link(dev, upper_dev, upper_priv, upper_info) \
 	netdev_master_upper_dev_link(dev, upper_dev)
 
 #endif /* < KERNEL_VERSION(4, 5, 0) */
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 484c50e..2d1470f 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -467,7 +467,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
 	ret = netdev_master_upper_dev_link(hard_iface->net_dev,
-					   soft_iface, NULL);
+					   soft_iface, NULL, NULL);
 	if (ret)
 		goto err_dev;
 
-- 
2.6.2

