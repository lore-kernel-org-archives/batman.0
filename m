Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 13 Jan 2013 17:51:03 +0800
Message-Id: <1358070663-8226-6-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1358070663-8226-1-git-send-email-lindner_marek@yahoo.de>
References: <201301131750.39338.lindner_marek@yahoo.de>
 <1358070663-8226-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCHv2 6/6] batman-adv: Allow to modify slaves of
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
 soft-interface.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/soft-interface.c b/soft-interface.c
index d9f27d5..ac34c55 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -506,6 +506,41 @@ free_bat_counters:
 	return ret;
 }
 
+/**
+ * batadv_softif_slave_add - Add a slave interface to a batadv_soft_interface
+ * @dev: batadv_soft_interface used as master interface
+ * @slave_dev: net_device which should become the slave interface
+ */
+static int batadv_softif_slave_add(struct net_device *dev,
+				   struct net_device *slave_dev)
+{
+	struct batadv_hard_iface *hard_iface;
+
+	hard_iface = batadv_hardif_get_by_netdev(slave_dev);
+	if (!hard_iface || hard_iface->soft_iface != NULL)
+		return -EINVAL;
+
+	return batadv_hardif_enable_interface(hard_iface, dev->name);
+}
+
+/**
+ * batadv_softif_slave_del - Delete a slave iface from a batadv_soft_interface
+ * @dev: batadv_soft_interface used as master interface
+ * @slave_dev: net_device which should be removed from the master interface
+ */
+static int batadv_softif_slave_del(struct net_device *dev,
+				   struct net_device *slave_dev)
+{
+	struct batadv_hard_iface *hard_iface;
+
+	hard_iface = batadv_hardif_get_by_netdev(slave_dev);
+	if (!hard_iface || hard_iface->soft_iface != dev)
+		return -EINVAL;
+
+	batadv_hardif_disable_interface(hard_iface, BATADV_IF_CLEANUP_KEEP);
+	return 0;
+}
+
 static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_init = batadv_softif_init_late,
 	.ndo_open = batadv_interface_open,
@@ -514,7 +549,9 @@ static const struct net_device_ops batadv_netdev_ops = {
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

