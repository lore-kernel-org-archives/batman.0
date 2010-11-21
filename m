Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:42 +0100
Message-Id: <1290383767-32602-5-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 04/29] Staging: batman-adv: Don't remove
	interface with spinlock held
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

We call a lot of the netdevice code when holding if_list_lock which will
spin the whole time. This is not necessary because we only want to
protect the access to the list to be serialized. An extra queue can be
used which hold all interfaces which should be removed and then use that
queue without any locks for netdevice cleanup.

Reported-by: Rafal Lesniak <lesniak@eresi-project.org>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/hard-interface.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index b68a7e5..d85de82 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -463,9 +463,6 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 		return;
 
 	batman_if->if_status = IF_TO_BE_REMOVED;
-
-	/* caller must take if_list_lock */
-	list_del_rcu(&batman_if->list);
 	synchronize_rcu();
 	sysfs_del_hardif(&batman_if->hardif_obj);
 	hardif_put(batman_if);
@@ -474,13 +471,21 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 void hardif_remove_interfaces(void)
 {
 	struct batman_if *batman_if, *batman_if_tmp;
+	struct list_head if_queue;
+
+	INIT_LIST_HEAD(&if_queue);
 
-	rtnl_lock();
 	spin_lock(&if_list_lock);
 	list_for_each_entry_safe(batman_if, batman_if_tmp, &if_list, list) {
-		hardif_remove_interface(batman_if);
+		list_del_rcu(&batman_if->list);
+		list_add_tail(&batman_if->list, &if_queue);
 	}
 	spin_unlock(&if_list_lock);
+
+	rtnl_lock();
+	list_for_each_entry_safe(batman_if, batman_if_tmp, &if_queue, list) {
+		hardif_remove_interface(batman_if);
+	}
 	rtnl_unlock();
 }
 
@@ -507,8 +512,10 @@ static int hard_if_event(struct notifier_block *this,
 		break;
 	case NETDEV_UNREGISTER:
 		spin_lock(&if_list_lock);
-		hardif_remove_interface(batman_if);
+		list_del_rcu(&batman_if->list);
 		spin_unlock(&if_list_lock);
+
+		hardif_remove_interface(batman_if);
 		break;
 	case NETDEV_CHANGEMTU:
 		if (batman_if->soft_iface)
-- 
1.7.2.3

