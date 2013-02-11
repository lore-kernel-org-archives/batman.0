Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 11 Feb 2013 17:10:27 +0800
Message-Id: <1360573828-24399-6-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1360573828-24399-1-git-send-email-lindner_marek@yahoo.de>
References: <201302111710.04911.lindner_marek@yahoo.de>
 <1360573828-24399-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv3 6/6] batman-adv: Allow to modify slaves of
	soft-interfaces through rntl_link
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
Cc: Sven Eckelmann <sven@narfation.org>

From: Sven Eckelmann <sven@narfation.org>

The sysfs configuration interface of batman-adv to add/remove slaves of an
soft-iface is not deadlock free and doesn't follow the currently common way to
modify slaves of an interface.

An additional configuration interface though rtnl_link is introduced which
provides easy device adding/removing with tools like "ip":
$ ip link set dev eth0 master bat0
$ ip link set dev eth0 nomaster

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.h         |    3 +++
 hard-interface.c |   11 +++++++++--
 soft-interface.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/compat.h b/compat.h
index 48180e2..425b3d9 100644
--- a/compat.h
+++ b/compat.h
@@ -212,6 +212,9 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p) \
 }\
 static int __batadv_interface_set_mac_addr(x, y)
 
+#define netdev_master_upper_dev_link netdev_set_master
+#define netdev_upper_dev_unlink(slave, master) netdev_set_master(slave, NULL)
+
 #endif /* < KERNEL_VERSION(3, 9, 0) */
 
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/hard-interface.c b/hard-interface.c
index 6c32607..c08e39e 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -350,9 +350,13 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
+	ret = netdev_master_upper_dev_link(hard_iface->net_dev, soft_iface);
+	if (ret)
+		goto err_dev;
+
 	ret = bat_priv->bat_algo_ops->bat_iface_enable(hard_iface);
 	if (ret < 0)
-		goto err_dev;
+		goto err_upper;
 
 	hard_iface->if_num = bat_priv->num_ifaces;
 	bat_priv->num_ifaces++;
@@ -362,7 +366,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 		bat_priv->bat_algo_ops->bat_iface_disable(hard_iface);
 		bat_priv->num_ifaces--;
 		hard_iface->if_status = BATADV_IF_NOT_IN_USE;
-		goto err_dev;
+		goto err_upper;
 	}
 
 	hard_iface->batman_adv_ptype.type = ethertype;
@@ -401,6 +405,8 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 out:
 	return 0;
 
+err_upper:
+	netdev_upper_dev_unlink(hard_iface->net_dev, soft_iface);
 err_dev:
 	dev_put(soft_iface);
 err:
@@ -450,6 +456,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 	if (!bat_priv->num_ifaces && autodel == BATADV_IF_CLEANUP_AUTO)
 		batadv_softif_destroy_sysfs(hard_iface->soft_iface);
 
+	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->soft_iface);
 	hard_iface->soft_iface = NULL;
 	batadv_hardif_free_ref(hard_iface);
 
diff --git a/soft-interface.c b/soft-interface.c
index 4ef1649..39caefa 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -509,6 +509,58 @@ free_bat_counters:
 	return ret;
 }
 
+/**
+ * batadv_softif_slave_add - Add a slave interface to a batadv_soft_interface
+ * @dev: batadv_soft_interface used as master interface
+ * @slave_dev: net_device which should become the slave interface
+ *
+ * Return 0 if successful or error otherwise.
+ */
+static int batadv_softif_slave_add(struct net_device *dev,
+				   struct net_device *slave_dev)
+{
+	struct batadv_hard_iface *hard_iface;
+	int ret = -EINVAL;
+
+	hard_iface = batadv_hardif_get_by_netdev(slave_dev);
+	if (!hard_iface || hard_iface->soft_iface != NULL)
+		goto out;
+
+	ret = batadv_hardif_enable_interface(hard_iface, dev->name);
+
+out:
+	if (hard_iface)
+		batadv_hardif_free_ref(hard_iface);
+	return ret;
+}
+
+/**
+ * batadv_softif_slave_del - Delete a slave iface from a batadv_soft_interface
+ * @dev: batadv_soft_interface used as master interface
+ * @slave_dev: net_device which should be removed from the master interface
+ *
+ * Return 0 if successful or error otherwise.
+ */
+static int batadv_softif_slave_del(struct net_device *dev,
+				   struct net_device *slave_dev)
+{
+	struct batadv_hard_iface *hard_iface;
+	int ret = -EINVAL;
+
+	hard_iface = batadv_hardif_get_by_netdev(slave_dev);
+
+	if (!hard_iface || hard_iface->soft_iface != dev)
+		goto out;
+
+	batadv_hardif_disable_interface(hard_iface, BATADV_IF_CLEANUP_KEEP);
+	ret = 0;
+
+out:
+	if (hard_iface)
+		batadv_hardif_free_ref(hard_iface);
+	return ret;
+}
+
 static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_init = batadv_softif_init_late,
 	.ndo_open = batadv_interface_open,
@@ -517,7 +569,9 @@ static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_set_mac_address = batadv_interface_set_mac_addr,
 	.ndo_change_mtu = batadv_interface_change_mtu,
 	.ndo_start_xmit = batadv_interface_tx,
-	.ndo_validate_addr = eth_validate_addr
+	.ndo_validate_addr = eth_validate_addr,
+	.ndo_add_slave = batadv_softif_slave_add,
+	.ndo_del_slave = batadv_softif_slave_del,
 };
 
 /**
-- 
1.7.10.4

