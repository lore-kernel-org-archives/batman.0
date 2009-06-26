Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 27 Jun 2009 01:11:10 +0200
Message-Id: <1246057870-1880-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1246057870-1880-1-git-send-email-sven.eckelmann@gmx.de>
References: <1246057870-1880-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] [batman] Convert to new net_device_ops
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

The current version of batman-gateway uses the netdevice structure
instead of netdevice ops introduced by v2.6.28-rc5-510-gd314774. The
compatibility version was removed in v2.6.30-rc6-851-ge3804cb. We need
to change now change to this new structure to be able to compile it
against linux-2.6.31.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/linux/modules/gateway.c |   19 ++++++++++++++++---
 batman/linux/modules/gateway.h |    1 +
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/batman/linux/modules/gateway.c b/batman/linux/modules/gateway.c
index bbe48e0..aa58688 100644
--- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -503,15 +503,31 @@ static int packet_recv_thread(void *data)
 }
 
 /* bat_netdev part */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 29)
+static const struct net_device_ops bat_netdev_ops = {
+	.ndo_open = bat_netdev_open,
+	.ndo_stop = bat_netdev_close,
+	.ndo_start_xmit = bat_netdev_xmit,
+	.ndo_set_mac_address = eth_mac_addr,
+	.ndo_change_mtu = eth_change_mtu
+};
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 29) */
 
 static void bat_netdev_setup( struct net_device *dev )
 {
 	struct gate_priv *priv;
 
 	ether_setup(dev);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29)
 	dev->open = bat_netdev_open;
 	dev->stop = bat_netdev_close;
 	dev->hard_start_xmit = bat_netdev_xmit;
+#ifdef HAVE_VALIDATE_ADDR
+	dev->validate_addr = NULL;
+#endif
+#else
+	dev->netdev_ops = &bat_netdev_ops;
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29) */
 	dev->destructor = free_netdev;
 
 	dev->features        |= NETIF_F_NO_CSUM;
@@ -520,9 +536,6 @@ static void bat_netdev_setup( struct net_device *dev )
 #endif
 	dev->mtu = 1471;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
-#ifdef HAVE_VALIDATE_ADDR
-	dev->validate_addr = NULL;
-#endif
 
 	priv = netdev_priv( dev );
 	memset( priv, 0, sizeof( struct gate_priv ) );
diff --git a/batman/linux/modules/gateway.h b/batman/linux/modules/gateway.h
index de2fecd..238b518 100644
--- a/batman/linux/modules/gateway.h
+++ b/batman/linux/modules/gateway.h
@@ -36,6 +36,7 @@
 #include <net/sock.h>		/* sock */
 #include <net/pkt_sched.h>	/* class_create, class_destroy, class_device_create */
 #include <linux/list.h>		/* list handling */
+#include <linux/etherdevice.h>	/* ethernet device standard functions */
 //#include <linux/netdevice.h> /* init_net */
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
-- 
1.6.3.1

