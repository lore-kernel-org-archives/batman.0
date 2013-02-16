Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 16 Feb 2013 13:47:34 +0100
Message-Id: <1361018855-10657-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: free an hard-interface
	before adding it
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

When adding a new hard interface (e.h. wlan0) to a soft interface (e.g. bat0)
and the former is already enslaved in another virtual interface (e.g. a software
bridge) batman-adv has to free the it first and then continue with the
adding mechanism.

In this way the behaviour becomes consistent with what "ip link set master"
does. At the moment batman-adv enslaves the hard interface without checking for
the master device, possibly causing strange behaviours which are never wanted by
the users.

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2:
 - added compat code for netdev_master_upper_dev_get()


 compat.h         |  9 +++++++++
 hard-interface.c | 14 ++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/compat.h b/compat.h
index 425b3d9..787cbcc 100644
--- a/compat.h
+++ b/compat.h
@@ -197,6 +197,8 @@ static inline void eth_hw_addr_random(struct net_device *dev)
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
 
+#include <linux/netdevice.h>
+
 #define prandom_u32() random32()
 
 #define batadv_interface_set_mac_addr(x, y) \
@@ -214,6 +216,13 @@ static int __batadv_interface_set_mac_addr(x, y)
 
 #define netdev_master_upper_dev_link netdev_set_master
 #define netdev_upper_dev_unlink(slave, master) netdev_set_master(slave, NULL)
+static inline struct net_device *
+netdev_master_upper_dev_get(struct net_device *dev)
+{
+	ASSERT_RTNL();
+
+	return dev->master;
+}
 
 #endif /* < KERNEL_VERSION(3, 9, 0) */
 
diff --git a/hard-interface.c b/hard-interface.c
index c08e39e..fd99e42 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -311,7 +311,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 				   const char *iface_name)
 {
 	struct batadv_priv *bat_priv;
-	struct net_device *soft_iface;
+	struct net_device *soft_iface, *master;
 	__be16 ethertype = __constant_htons(ETH_P_BATMAN);
 	int ret;
 
@@ -321,11 +321,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (!atomic_inc_not_zero(&hard_iface->refcount))
 		goto out;
 
-	/* hard-interface is part of a bridge */
-	if (hard_iface->net_dev->priv_flags & IFF_BRIDGE_PORT)
-		pr_err("You are about to enable batman-adv on '%s' which already is part of a bridge. Unless you know exactly what you are doing this is probably wrong and won't work the way you think it would.\n",
-		       hard_iface->net_dev->name);
-
 	soft_iface = dev_get_by_name(&init_net, iface_name);
 
 	if (!soft_iface) {
@@ -347,6 +342,13 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 		goto err_dev;
 	}
 
+	/* check if the interface is enslaved in another virtual one and
+	 * in that case unlink it first
+	 */
+	master = netdev_master_upper_dev_get(hard_iface->net_dev);
+	if (master)
+		netdev_upper_dev_unlink(hard_iface->net_dev, master);
+
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-- 
1.8.1.2

