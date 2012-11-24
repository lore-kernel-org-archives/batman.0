Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Nov 2012 01:02:07 +0100
Message-Id: <1353715332-4284-2-git-send-email-sven@narfation.org>
In-Reply-To: <1353715332-4284-1-git-send-email-sven@narfation.org>
References: <1353715332-4284-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: Move deinitialization of
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, davem@davemloft.net

The deinitialization of the soft-interface created in ndo_init/constructor
should be done in the destructor and not directly before calling
unregister_netdevice

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index b545595..8467b9f 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -487,6 +487,17 @@ static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_validate_addr = eth_validate_addr
 };
 
+/**
+ * batadv_interface_free - Deconstructor of batadv_soft_interface
+ * @dev: Device to cleanup and remove
+ */
+static void batadv_interface_free(struct net_device *dev)
+{
+	batadv_debugfs_del_meshif(dev);
+	batadv_mesh_free(dev);
+	free_netdev(dev);
+}
+
 static void batadv_interface_setup(struct net_device *dev)
 {
 	struct batadv_priv *priv = netdev_priv(dev);
@@ -494,7 +505,7 @@ static void batadv_interface_setup(struct net_device *dev)
 	ether_setup(dev);
 
 	dev->netdev_ops = &batadv_netdev_ops;
-	dev->destructor = free_netdev;
+	dev->destructor = batadv_interface_free;
 	dev->tx_queue_len = 0;
 
 	/* can't call min_mtu, because the needed variables
@@ -535,9 +546,7 @@ struct net_device *batadv_softif_create(const char *name)
 
 void batadv_softif_destroy(struct net_device *soft_iface)
 {
-	batadv_debugfs_del_meshif(soft_iface);
 	batadv_sysfs_del_meshif(soft_iface);
-	batadv_mesh_free(soft_iface);
 	unregister_netdevice(soft_iface);
 }
 
-- 
1.7.10.4

