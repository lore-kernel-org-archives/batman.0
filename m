Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 27 Aug 2012 10:53:50 +0200
Message-Id: <1346057631-2382-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Write lockdep xmit class in
	late initialization phase
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

e27bb6fa916451e9eaced16e7c21d5b71a3b7f30 ("batman-adv: Set special lockdep
classes to avoid lockdep warning") introduced a lockdep class for the tx queue,
but did not set it in the correct initialization phase. The batman-adv specific
lock class could be replaced by a later netdevice registration phase.

Reported-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 soft-interface.c |   35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index a584f62..72d8767 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -352,16 +352,6 @@ out:
 	return;
 }
 
-static const struct net_device_ops batadv_netdev_ops = {
-	.ndo_open = batadv_interface_open,
-	.ndo_stop = batadv_interface_release,
-	.ndo_get_stats = batadv_interface_stats,
-	.ndo_set_mac_address = batadv_interface_set_mac_addr,
-	.ndo_change_mtu = batadv_interface_change_mtu,
-	.ndo_start_xmit = batadv_interface_tx,
-	.ndo_validate_addr = eth_validate_addr
-};
-
 /* batman-adv network devices have devices nesting below it and are a special
  * "super class" of normal network devices; split their locks off into a
  * separate class since they always nest.
@@ -382,6 +372,30 @@ static void batadv_set_lockdep_class(struct net_device *dev)
 	netdev_for_each_tx_queue(dev, batadv_set_lockdep_class_one, NULL);
 }
 
+/**
+ * batadv_softif_init - Late stage initialization of soft interface
+ * @dev: registered network device to modify
+ *
+ * Returns error code on failures
+ */
+static int batadv_softif_init(struct net_device *dev)
+{
+	batadv_set_lockdep_class(dev);
+
+	return 0;
+}
+
+static const struct net_device_ops batadv_netdev_ops = {
+	.ndo_init = batadv_softif_init,
+	.ndo_open = batadv_interface_open,
+	.ndo_stop = batadv_interface_release,
+	.ndo_get_stats = batadv_interface_stats,
+	.ndo_set_mac_address = batadv_interface_set_mac_addr,
+	.ndo_change_mtu = batadv_interface_change_mtu,
+	.ndo_start_xmit = batadv_interface_tx,
+	.ndo_validate_addr = eth_validate_addr
+};
+
 static void batadv_interface_setup(struct net_device *dev)
 {
 	struct batadv_priv *priv = netdev_priv(dev);
@@ -391,7 +405,6 @@ static void batadv_interface_setup(struct net_device *dev)
 	dev->netdev_ops = &batadv_netdev_ops;
 	dev->destructor = free_netdev;
 	dev->tx_queue_len = 0;
-	batadv_set_lockdep_class(dev);
 
 	/* can't call min_mtu, because the needed variables
 	 * have not been initialized yet
-- 
1.7.10.4

