Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 18 Sep 2010 21:01:15 +0200
Message-Id: <1284836482-23431-6-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 05/12] Staging: batman-adv: Introduce
	if_list_lock to protect if_list
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

The update critical sections of if_list must be protected by a locking
primitive other than RCU. The iterator must also be protected by the
chosen locking mechanism.

The rtnl_lock in hardif_remove_interfaces must also be moved outside the
iterator primitive to ensure that we don't deadlock the kernel due to
differently nested locks in hardif_remove_interfaces and hard_if_event.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/hard-interface.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index a587da9..35b198c 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -33,6 +33,9 @@
 
 #define MIN(x, y) ((x) < (y) ? (x) : (y))
 
+/* protect update critical side of if_list - but not the content */
+static DEFINE_SPINLOCK(if_list_lock);
+
 struct batman_if *get_batman_if_by_netdev(struct net_device *net_dev)
 {
 	struct batman_if *batman_if;
@@ -400,7 +403,11 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	INIT_LIST_HEAD(&batman_if->list);
 
 	check_known_mac_addr(batman_if->net_dev->dev_addr);
+
+	spin_lock(&if_list_lock);
 	list_add_tail_rcu(&batman_if->list, &if_list);
+	spin_unlock(&if_list_lock);
+
 	return batman_if;
 
 free_if:
@@ -428,6 +435,8 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 		return;
 
 	batman_if->if_status = IF_TO_BE_REMOVED;
+
+	/* caller must take if_list_lock */
 	list_del_rcu(&batman_if->list);
 	sysfs_del_hardif(&batman_if->hardif_obj);
 	dev_put(batman_if->net_dev);
@@ -438,11 +447,13 @@ void hardif_remove_interfaces(void)
 {
 	struct batman_if *batman_if, *batman_if_tmp;
 
+	rtnl_lock();
+	spin_lock(&if_list_lock);
 	list_for_each_entry_safe(batman_if, batman_if_tmp, &if_list, list) {
-		rtnl_lock();
 		hardif_remove_interface(batman_if);
-		rtnl_unlock();
 	}
+	spin_unlock(&if_list_lock);
+	rtnl_unlock();
 }
 
 static int hard_if_event(struct notifier_block *this,
@@ -467,7 +478,9 @@ static int hard_if_event(struct notifier_block *this,
 		hardif_deactivate_interface(batman_if);
 		break;
 	case NETDEV_UNREGISTER:
+		spin_lock(&if_list_lock);
 		hardif_remove_interface(batman_if);
+		spin_unlock(&if_list_lock);
 		break;
 	case NETDEV_CHANGEMTU:
 		if (batman_if->soft_iface)
-- 
1.7.2.3

