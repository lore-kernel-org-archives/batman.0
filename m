Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 27 Jun 2009 01:11:09 +0200
Message-Id: <1246057870-1880-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] [batman-adv] Convert to new net_device_ops
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

The current version of batman-adv-kernelland uses the netdevice
structure instead of netdevice ops introduced by
v2.6.28-rc5-510-gd314774. The compatibility version was removed in
v2.6.30-rc6-851-ge3804cb. We need to change now change to this new
structure to be able to compile it against linux-2.6.31.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/soft-interface.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/batman-adv-kernelland/soft-interface.c b/batman-adv-kernelland/soft-interface.c
index bb95501..4600017 100644
--- a/batman-adv-kernelland/soft-interface.c
+++ b/batman-adv-kernelland/soft-interface.c
@@ -31,6 +31,7 @@
 #include "hash.h"
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
+#include "compat.h"
 
 
 
@@ -98,6 +99,18 @@ int my_skb_push(struct sk_buff *skb, unsigned int len)
 	return 0;
 }
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 29)
+static const struct net_device_ops bat_netdev_ops = {
+	.ndo_open = interface_open,
+	.ndo_stop = interface_release,
+	.ndo_get_stats = interface_stats,
+	.ndo_set_mac_address = interface_set_mac_addr,
+	.ndo_change_mtu = interface_change_mtu,
+	.ndo_start_xmit = interface_tx,
+	.ndo_validate_addr = eth_validate_addr
+};
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 29) */
+
 void interface_setup(struct net_device *dev)
 {
 	struct bat_priv *priv = netdev_priv(dev);
@@ -105,12 +118,16 @@ void interface_setup(struct net_device *dev)
 
 	ether_setup(dev);
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29)
 	dev->open = interface_open;
 	dev->stop = interface_release;
 	dev->get_stats = interface_stats;
 	dev->set_mac_address = interface_set_mac_addr;
 	dev->change_mtu = interface_change_mtu;
 	dev->hard_start_xmit = interface_tx;
+#else
+	dev->netdev_ops = &bat_netdev_ops;
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29) */
 	dev->destructor = free_netdev;
 
 	dev->features |= NETIF_F_NO_CSUM;
-- 
1.6.3.1

