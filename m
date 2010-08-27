Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 27 Aug 2010 13:53:45 +0200
Message-Id: <1282910025-30645-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't call unregister_netdev
	with locked rtnl semaphore
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
To: b.a.t.m.a.n@lists.open-mesh.org

We currently try to call unregister_netdev when we can destroy a softif
after all corresponding hard-interfaces announced that they will be
removed.

This will be done when we receive a hard_if_event which already takes
the rtnl semaphore and thus we try to get it again in unregister_netdev.
This results in a deadlock. This call to unregister_netdev cannot easily
replaced by unregister_netdevice, because other parts of the batman-adv
module still call that code indirectly without holding the rtnl
semaphore.

                    (needs rtln_unlocked)
                     unregister_netdev
                             ^
                             |
                       softif_destroy
                             ^
                             |
                  hardif_disable_interface
                 ^           ^
                /            |
store_mesh_iface   hardif_remove_interface
(rtln_unlocked)              ^            ^
                             |             \
                 hardif_remove_interfaces   hard_if_event
                             ^              (rtln_locked)
                             |
                        batman_exit
                      (rtln_unlocked)

A consistent workaround is to change store_mesh_iface and
hardif_remove_interfaces to call rtnl_lock before they call the
mentioned child function, release the semaphore afterwards and change
unregister_netdev in softif_destroy to unregister_netdevice.

Reported-by: Kazuki Shimada <zukky@bb.banban.jp>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/bat_sysfs.c      |    7 ++++++-
 batman-adv/hard-interface.c |    5 ++++-
 batman-adv/soft-interface.c |    2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index 1331a02..8e180ba 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -492,13 +492,18 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 		return count;
 
 	if (status_tmp == IF_NOT_IN_USE) {
+		rtnl_lock();
 		hardif_disable_interface(batman_if);
+		rtnl_unlock();
 		return count;
 	}
 
 	/* if the interface already is in use */
-	if (batman_if->if_status != IF_NOT_IN_USE)
+	if (batman_if->if_status != IF_NOT_IN_USE) {
+		rtnl_lock();
 		hardif_disable_interface(batman_if);
+		rtnl_unlock();
+	}
 
 	return hardif_enable_interface(batman_if, buff);
 }
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index a437ec3..b12f63b 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -441,8 +441,11 @@ void hardif_remove_interfaces(void)
 {
 	struct batman_if *batman_if, *batman_if_tmp;
 
-	list_for_each_entry_safe(batman_if, batman_if_tmp, &if_list, list)
+	list_for_each_entry_safe(batman_if, batman_if_tmp, &if_list, list) {
+		rtnl_lock();
 		hardif_remove_interface(batman_if);
+		rtnl_unlock();
+	}
 }
 
 static int hard_if_event(struct notifier_block *this,
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index a45626e..38134ae 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -351,7 +351,7 @@ void softif_destroy(struct net_device *soft_iface)
 	debugfs_del_meshif(soft_iface);
 	sysfs_del_meshif(soft_iface);
 	mesh_free(soft_iface);
-	unregister_netdev(soft_iface);
+	unregister_netdevice(soft_iface);
 }
 
 /* ethtool */
-- 
1.7.1

