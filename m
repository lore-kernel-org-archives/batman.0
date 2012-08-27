Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 27 Aug 2012 10:53:51 +0200
Message-Id: <1346057631-2382-2-git-send-email-sven@narfation.org>
In-Reply-To: <1346057631-2382-1-git-send-email-sven@narfation.org>
References: <1346057631-2382-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Add KernelDoc for
	soft-interface lockdep functions
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
classes to avoid lockdep warning") added new functions, but no new documentation
for these functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 soft-interface.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/soft-interface.c b/soft-interface.c
index 72d8767..5fd3e30 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -359,6 +359,12 @@ out:
 static struct lock_class_key batadv_netdev_xmit_lock_key;
 static struct lock_class_key batadv_netdev_addr_lock_key;
 
+/**
+ * batadv_set_lockdep_class_one - Set lockdep class for a single tx queue
+ * @dev: device which owns the tx queue
+ * @txq: tx queue to modify
+ * @_unused: always NULL
+ */
 static void batadv_set_lockdep_class_one(struct net_device *dev,
 					 struct netdev_queue *txq,
 					 void *_unused)
@@ -366,6 +372,10 @@ static void batadv_set_lockdep_class_one(struct net_device *dev,
 	lockdep_set_class(&txq->_xmit_lock, &batadv_netdev_xmit_lock_key);
 }
 
+/**
+ * batadv_set_lockdep_class - Set txq and addr_list lockdep class
+ * @dev: network device to modify
+ */
 static void batadv_set_lockdep_class(struct net_device *dev)
 {
 	lockdep_set_class(&dev->addr_list_lock, &batadv_netdev_addr_lock_key);
-- 
1.7.10.4

