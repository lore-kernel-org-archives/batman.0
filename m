Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 30 Apr 2011 18:56:59 +0200
Message-Id: <1304182620-12637-2-git-send-email-sven@narfation.org>
In-Reply-To: <1304182620-12637-1-git-send-email-sven@narfation.org>
References: <1304182620-12637-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/3] batman-adv: Remove unnecessary
	hardif_list_lock
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

hardif_list_lock is unneccessary because we already ensure that no
multiple admin operations can take place through rtnl_lock.
hardif_list_lock only adds additional overhead and complexity.

Critical functions now check whether they are called with rtnl_lock
using ASSERT_RTNL.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Splitted the first patch to keep Linus' fame. There should be no difference
(after all patches are applied) between the first and the second version.

 hard-interface.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index c6edf0a..ebd7ef0 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -31,9 +31,6 @@
 
 #include <linux/if_arp.h>
 
-/* protect update critical side of hardif_list - but not the content */
-static DEFINE_SPINLOCK(hardif_list_lock);
-
 
 static int batman_skb_recv(struct sk_buff *skb,
 			   struct net_device *dev,
@@ -432,6 +429,8 @@ static struct hard_iface *hardif_add_interface(struct net_device *net_dev)
 	struct hard_iface *hard_iface;
 	int ret;
 
+	ASSERT_RTNL();
+
 	ret = is_valid_iface(net_dev);
 	if (ret != 1)
 		goto out;
@@ -458,10 +457,7 @@ static struct hard_iface *hardif_add_interface(struct net_device *net_dev)
 	atomic_set(&hard_iface->refcount, 2);
 
 	check_known_mac_addr(hard_iface->net_dev);
-
-	spin_lock(&hardif_list_lock);
 	list_add_tail_rcu(&hard_iface->list, &hardif_list);
-	spin_unlock(&hardif_list_lock);
 
 	return hard_iface;
 
@@ -475,6 +471,8 @@ out:
 
 static void hardif_remove_interface(struct hard_iface *hard_iface)
 {
+	ASSERT_RTNL();
+
 	/* first deactivate interface */
 	if (hard_iface->if_status != IF_NOT_IN_USE)
 		hardif_disable_interface(hard_iface);
@@ -492,13 +490,11 @@ void hardif_remove_interfaces(void)
 	struct hard_iface *hard_iface, *hard_iface_tmp;
 
 	rtnl_lock();
-	spin_lock(&hardif_list_lock);
 	list_for_each_entry_safe(hard_iface, hard_iface_tmp,
 				 &hardif_list, list) {
 		list_del_rcu(&hard_iface->list);
 		hardif_remove_interface(hard_iface);
 	}
-	spin_unlock(&hardif_list_lock);
 	rtnl_unlock();
 }
 
@@ -524,9 +520,7 @@ static int hard_if_event(struct notifier_block *this,
 		hardif_deactivate_interface(hard_iface);
 		break;
 	case NETDEV_UNREGISTER:
-		spin_lock(&hardif_list_lock);
 		list_del_rcu(&hard_iface->list);
-		spin_unlock(&hardif_list_lock);
 
 		hardif_remove_interface(hard_iface);
 		break;
-- 
1.7.4.4

