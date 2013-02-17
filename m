Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 17 Feb 2013 15:43:04 +0100
Message-Id: <1361112184-9927-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat support for the new
	netlink ops
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

This patches enable the new rtnl ops to compile on kernels starting from 2.6.32

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

Could not be uglier.
*Compile tested only* because linux-2.6.32 does not compile on my laptop



 compat.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/compat.h b/compat.h
index 885e551..de22e2b 100644
--- a/compat.h
+++ b/compat.h
@@ -71,6 +71,9 @@ static inline void batadv_this_cpu_add(uint64_t *count_ptr, size_t count)
 	put_cpu();
 }
 
+#define batadv_softif_destroy_netlink(dev, head) batadv_softif_destroy_netlink(dev)
+#define unregister_netdevice_queue(dev, head) unregister_netdevice(dev)
+
 #endif /* < KERNEL_VERSION(2, 6, 33) */
 
 
@@ -132,6 +135,43 @@ static inline int batadv_param_set_copystring(const char *val,
 #define kstrtoul strict_strtoul
 #define kstrtol  strict_strtol
 
+#define batadv_softif_slave_add(x, y) \
+batadv_softif_slave_add(struct net_device *dev, struct ifreq *rq, int cmd)\
+{\
+	return 0;\
+}\
+static int __batadv_softif_slave_add(x, y)
+
+#define batadv_softif_slave_del(x, y) \
+__batadv_softif_slave_del(struct net_device *dev, struct net_device *slave_dev);\
+static int batadv_softif_slave_del(struct net_device *dev, struct ifreq *rq, int cmd)\
+{\
+	struct batadv_priv *bat_priv = netdev_priv(dev);\
+	struct net_device *slave_dev;\
+	int ret;\
+	if (!capable(CAP_NET_ADMIN))\
+		return -EPERM;\
+	slave_dev = dev_get_by_index(&init_net, rq->ifr_ifindex);\
+	if (!dev)\
+		return -EINVAL;\
+	switch(cmd) {\
+	case SIOCBRADDIF:\
+		ret = __batadv_softif_slave_add(bat_priv->soft_iface, slave_dev);\
+	case SIOCBRDELIF:\
+		ret = __batadv_softif_slave_del(bat_priv->soft_iface, slave_dev);\
+	default:\
+		pr_debug("batman-adv does not support ioctl 0x%x\n", cmd);\
+		return -EOPNOTSUPP;\
+	}\
+\
+	dev_put(slave_dev);\
+	return ret;\
+}\
+static int __batadv_softif_slave_del(x, y)
+
+#define ndo_add_slave ndo_do_ioctl
+#define ndo_del_slave ndo_do_ioctl
+
 #endif /* < KERNEL_VERSION(2, 6, 39) */
 
 
-- 
1.8.1.2

