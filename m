Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Aug 2012 01:22:39 +0200
Message-Id: <1345418559-27150-1-git-send-email-sven@narfation.org>
In-Reply-To: <1345361393-8759-1-git-send-email-sven@narfation.org>
References: <1345361393-8759-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Set special lockdep classes to
	avoid lockdep warning
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

Transmissions over batman-adv devices always start another nested transmission
over devices attached to the batman-adv interface. These devices usually use
the ethernet lockdep class for the tx_queue lock which is also set by default
for all batman-adv devices. Lockdep will detect a nested locking attempt of two
locks with the same class and warn about a possible deadlock.

This is the default and expected behavior and should not alarm the locking
correctness prove mechanism. Therefore, the locks for all netdevice specific
lock get a special batman-adv lock class to avoid a false positive for each
transmission.

Reported-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 soft-interface.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/soft-interface.c b/soft-interface.c
index 1aee7db..513d50a 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -354,6 +354,27 @@ static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_validate_addr = eth_validate_addr
 };
 
+/*
+ * batman-adv network devices have devices nesting below it and are a special
+ * "super class" of normal network devices; split their locks off into a
+ * separate class since they always nest.
+ */
+static struct lock_class_key batadv_netdev_xmit_lock_key;
+static struct lock_class_key batadv_netdev_addr_lock_key;
+
+static void batadv_set_lockdep_class_one(struct net_device *dev,
+					 struct netdev_queue *txq,
+					 void *_unused)
+{
+	lockdep_set_class(&txq->_xmit_lock, &batadv_netdev_xmit_lock_key);
+}
+
+static void batadv_set_lockdep_class(struct net_device *dev)
+{
+	lockdep_set_class(&dev->addr_list_lock, &batadv_netdev_addr_lock_key);
+	netdev_for_each_tx_queue(dev, batadv_set_lockdep_class_one, NULL);
+}
+
 static void batadv_interface_setup(struct net_device *dev)
 {
 	struct batadv_priv *priv = netdev_priv(dev);
@@ -363,6 +384,7 @@ static void batadv_interface_setup(struct net_device *dev)
 	dev->netdev_ops = &batadv_netdev_ops;
 	dev->destructor = free_netdev;
 	dev->tx_queue_len = 0;
+	batadv_set_lockdep_class(dev);
 
 	/* can't call min_mtu, because the needed variables
 	 * have not been initialized yet
-- 
1.7.10.4

