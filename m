Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 29 Oct 2012 09:58:07 +0100
Message-Id: <1351501097-1289-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1351501097-1289-1-git-send-email-ordex@autistici.org>
References: <1351501097-1289-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 06/16] batman-adv: Set special lockdep
	classes to avoid lockdep warning
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Transmissions over batman-adv devices always start another nested transmission
over devices attached to the batman-adv interface. These devices usually use
the ethernet lockdep class for the tx_queue lock which is also set by default
for all batman-adv devices. Lockdep will detect a nested locking attempt of two
locks with the same class and warn about a possible deadlock.

This is the default and expected behavior and should not alarm the locking
correctness prove mechanism. Therefore, the locks for all netdevice specific tx
queues get a special batman-adv lock class to avoid a false positive for each
transmission.

Reported-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/soft-interface.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index b9a28d2..948860a 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -347,7 +347,51 @@ out:
 	return;
 }
 
+/* batman-adv network devices have devices nesting below it and are a special
+ * "super class" of normal network devices; split their locks off into a
+ * separate class since they always nest.
+ */
+static struct lock_class_key batadv_netdev_xmit_lock_key;
+static struct lock_class_key batadv_netdev_addr_lock_key;
+
+/**
+ * batadv_set_lockdep_class_one - Set lockdep class for a single tx queue
+ * @dev: device which owns the tx queue
+ * @txq: tx queue to modify
+ * @_unused: always NULL
+ */
+static void batadv_set_lockdep_class_one(struct net_device *dev,
+					 struct netdev_queue *txq,
+					 void *_unused)
+{
+	lockdep_set_class(&txq->_xmit_lock, &batadv_netdev_xmit_lock_key);
+}
+
+/**
+ * batadv_set_lockdep_class - Set txq and addr_list lockdep class
+ * @dev: network device to modify
+ */
+static void batadv_set_lockdep_class(struct net_device *dev)
+{
+	lockdep_set_class(&dev->addr_list_lock, &batadv_netdev_addr_lock_key);
+	netdev_for_each_tx_queue(dev, batadv_set_lockdep_class_one, NULL);
+}
+
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
 static const struct net_device_ops batadv_netdev_ops = {
+	.ndo_init = batadv_softif_init,
 	.ndo_open = batadv_interface_open,
 	.ndo_stop = batadv_interface_release,
 	.ndo_get_stats = batadv_interface_stats,
-- 
1.7.12.4

