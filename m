Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jul 2011 13:11:19 +0200
Message-Id: <1310901079-14967-1-git-send-email-sven@narfation.org>
In-Reply-To: <1310899392-1941-1-git-send-email-sven@narfation.org>
References: <1310899392-1941-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: Start to fiddle with compat stuff
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

 README           |    2 +-
 compat.c         |    8 ++++++++
 compat.h         |   17 +++++++++++++++++
 soft-interface.c |   31 ++++++++++++++++++++++++++++++-
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/README b/README
index f590c99..34fda4f 100644
--- a/README
+++ b/README
@@ -18,7 +18,7 @@ Batman advanced was implemented as a Linux kernel driver  to  re-
 duce the overhead to a minimum. It does not depend on any (other)
 network driver, and can be used on wifi as well as ethernet  lan,
 vpn,  etc ... (anything with ethernet-style layer 2). It compiles
-against and should work with Linux 2.6.29 -  3.1.   Supporting
+against and should work with Linux 2.6.21 -  3.1.   Supporting
 older versions is not planned, but it's probably easy to backport
 it.  If you work on a backport, feel free to contact us.  :-)
 
diff --git a/compat.c b/compat.c
index ebedae8..98da315 100644
--- a/compat.c
+++ b/compat.c
@@ -32,6 +32,14 @@ ssize_t bat_wrapper_store(struct kobject *kobj, struct attribute *attr,
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29)
 
+int eth_validate_addr(struct net_device *dev)
+{
+	if (!is_valid_ether_addr(dev->dev_addr))
+		return -EADDRNOTAVAIL;
+
+	return 0;
+}
+
 /*
  *  linux/lib/vsprintf.c
  *
diff --git a/compat.h b/compat.h
index 66a8adc..3f21e1a 100644
--- a/compat.h
+++ b/compat.h
@@ -242,6 +242,23 @@ next_sibling:
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29)
 
+#include <linux/netdevice.h>
+
+struct net_device_ops {
+	int			(*ndo_open)(struct net_device *dev);
+	int			(*ndo_stop)(struct net_device *dev);
+	int			(*ndo_start_xmit) (struct sk_buff *skb,
+						   struct net_device *dev);
+	int			(*ndo_set_mac_address)(struct net_device *dev,
+						       void *addr);
+	int			(*ndo_validate_addr)(struct net_device *dev);
+	int			(*ndo_change_mtu)(struct net_device *dev,
+						  int new_mtu);
+	struct net_device_stats* (*ndo_get_stats)(struct net_device *dev);
+};
+
+int eth_validate_addr(struct net_device *dev);
+
 int bat_vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
 #define vscnprintf bat_vscnprintf
 
diff --git a/soft-interface.c b/soft-interface.c
index 3e2f91f..26f7323 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -760,6 +760,25 @@ static const struct net_device_ops bat_netdev_ops = {
 	.ndo_validate_addr = eth_validate_addr
 };
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29)
+static void set_net_device_ops(struct net_device *dev,
+			       const struct net_device_ops *netdev_ops)
+{
+	dev->open = netdev_ops->ndo_open;
+	dev->stop = netdev_ops->ndo_stop;
+	dev->get_stats = netdev_ops->ndo_get_stats;
+	dev->set_mac_address = netdev_ops->ndo_set_mac_address;
+	dev->change_mtu = netdev_ops->ndo_change_mtu;
+	dev->hard_start_xmit = netdev_ops->ndo_start_xmit;
+}
+#else
+static void set_net_device_ops(struct net_device *dev,
+			       const struct net_device_ops *netdev_ops)
+{
+	dev->netdev_ops = netdev_ops;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29) */
+
 static void interface_setup(struct net_device *dev)
 {
 	struct bat_priv *priv = netdev_priv(dev);
@@ -767,7 +786,7 @@ static void interface_setup(struct net_device *dev)
 
 	ether_setup(dev);
 
-	dev->netdev_ops = &bat_netdev_ops;
+	set_net_device_ops(dev, &bat_netdev_ops);
 	dev->destructor = free_netdev;
 	dev->tx_queue_len = 0;
 
@@ -872,6 +891,15 @@ void softif_destroy(struct net_device *soft_iface)
 	unregister_netdevice(soft_iface);
 }
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29)
+int softif_is_valid(const struct net_device *net_dev)
+{
+	if (net_dev->hard_start_xmit == interface_tx)
+		return 1;
+
+	return 0;
+}
+#else /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29) */
 int softif_is_valid(const struct net_device *net_dev)
 {
 	if (net_dev->netdev_ops->ndo_start_xmit == interface_tx)
@@ -879,6 +907,7 @@ int softif_is_valid(const struct net_device *net_dev)
 
 	return 0;
 }
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29) */
 
 /* ethtool */
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
-- 
1.7.5.4

