Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 28 Mar 2013 08:50:23 +0100
Message-Id: <1364457031-3194-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1364457031-3194-1-git-send-email-ordex@autistici.org>
References: <1364457031-3194-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 03/11] batman-adv: Move deinitialization of
	soft-interface to destructor
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Sven Eckelmann <sven@narfation.org>

From: Sven Eckelmann <sven@narfation.org>

The deinitialization of the soft-interface created in ndo_init/constructor
should be done in the destructor and not directly before calling
unregister_netdevice

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Acked-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/soft-interface.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index c5cb0a7..e889bfb 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -417,7 +417,6 @@ static void batadv_softif_destroy_finish(struct work_struct *work)
 				cleanup_work);
 	soft_iface = bat_priv->soft_iface;
 
-	batadv_debugfs_del_meshif(soft_iface);
 	batadv_sysfs_del_meshif(soft_iface);
 
 	rtnl_lock();
@@ -522,6 +521,17 @@ static const struct net_device_ops batadv_netdev_ops = {
 };
 
 /**
+ * batadv_softif_free - Deconstructor of batadv_soft_interface
+ * @dev: Device to cleanup and remove
+ */
+static void batadv_softif_free(struct net_device *dev)
+{
+	batadv_debugfs_del_meshif(dev);
+	batadv_mesh_free(dev);
+	free_netdev(dev);
+}
+
+/**
  * batadv_softif_init_early - early stage initialization of soft interface
  * @dev: registered network device to modify
  */
@@ -532,7 +542,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 	ether_setup(dev);
 
 	dev->netdev_ops = &batadv_netdev_ops;
-	dev->destructor = free_netdev;
+	dev->destructor = batadv_softif_free;
 	dev->tx_queue_len = 0;
 
 	/* can't call min_mtu, because the needed variables
@@ -575,7 +585,6 @@ void batadv_softif_destroy(struct net_device *soft_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 
-	batadv_mesh_free(soft_iface);
 	queue_work(batadv_event_workqueue, &bat_priv->cleanup_work);
 }
 
-- 
1.8.1.5

