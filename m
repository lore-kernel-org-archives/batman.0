Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 27 Oct 2010 10:02:25 +0200
Message-Id: <1288166545-8252-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Correct sparse warning about
	different lock contexts for basic block
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

sparse noticed that if_list_lock is taken in some situations with bottom
halfes disabled in some SMP kernels and that we must always lock it with
spin_lock_bh.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/hard-interface.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 37f0f8b..b5514e3 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -441,9 +441,9 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 
 	check_known_mac_addr(batman_if->net_dev->dev_addr);
 
-	spin_lock(&if_list_lock);
+	spin_lock_bh(&if_list_lock);
 	list_add_tail_rcu(&batman_if->list, &if_list);
-	spin_unlock(&if_list_lock);
+	spin_unlock_bh(&if_list_lock);
 
 	/* extra reference for return */
 	kref_get(&batman_if->refcount);
@@ -478,11 +478,11 @@ void hardif_remove_interfaces(void)
 	struct batman_if *batman_if, *batman_if_tmp;
 
 	rtnl_lock();
-	spin_lock(&if_list_lock);
+	spin_lock_bh(&if_list_lock);
 	list_for_each_entry_safe(batman_if, batman_if_tmp, &if_list, list) {
 		hardif_remove_interface(batman_if);
 	}
-	spin_unlock(&if_list_lock);
+	spin_unlock_bh(&if_list_lock);
 	rtnl_unlock();
 }
 
@@ -508,9 +508,9 @@ static int hard_if_event(struct notifier_block *this,
 		hardif_deactivate_interface(batman_if);
 		break;
 	case NETDEV_UNREGISTER:
-		spin_lock(&if_list_lock);
+		spin_lock_bh(&if_list_lock);
 		hardif_remove_interface(batman_if);
-		spin_unlock(&if_list_lock);
+		spin_unlock_bh(&if_list_lock);
 		break;
 	case NETDEV_CHANGEMTU:
 		if (batman_if->soft_iface)
-- 
1.7.2.3

