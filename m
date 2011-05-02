Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  2 May 2011 21:19:37 +0200
Message-Id: <1304363978-16164-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4 1/2] batman-adv: Remove unnecessary
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

It indirectly fixes the problem that orig_hash_del_if() expects that
only one interface is deleted from hardif_list at a time, but
hardif_remove_interfaces() removes all at once and then calls
orig_hash_del_if().

Reported-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Addressed Linus' comments:
 * Merged patch 1/3 and 2/3 again
 * Ensure that primary_if_select is only called with rtnl_lock through
   hardif_enable_interface (was fixed in patch 3/3... but now in a
   patch earlier)
 * Add a comment above hardif_list to inform about needed locking

 bat_sysfs.c      |    2 ++
 hard-interface.c |   30 +++++++-----------------------
 main.c           |    3 +++
 3 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index e449bf6..85ba20d 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -502,7 +502,9 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 		rtnl_unlock();
 	}
 
+	rtnl_lock();
 	ret = hardif_enable_interface(hard_iface, buff);
+	rtnl_unlock();
 
 out:
 	hardif_free_ref(hard_iface);
diff --git a/hard-interface.c b/hard-interface.c
index 3e888f1..7e2f772 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -31,9 +31,6 @@
 
 #include <linux/if_arp.h>
 
-/* protect update critical side of hardif_list - but not the content */
-static DEFINE_SPINLOCK(hardif_list_lock);
-
 
 static int batman_skb_recv(struct sk_buff *skb,
 			   struct net_device *dev,
@@ -136,7 +133,7 @@ static void primary_if_select(struct bat_priv *bat_priv,
 	struct hard_iface *curr_hard_iface;
 	struct batman_packet *batman_packet;
 
-	spin_lock_bh(&hardif_list_lock);
+	ASSERT_RTNL();
 
 	if (new_hard_iface && !atomic_inc_not_zero(&new_hard_iface->refcount))
 		new_hard_iface = NULL;
@@ -148,7 +145,7 @@ static void primary_if_select(struct bat_priv *bat_priv,
 		hardif_free_ref(curr_hard_iface);
 
 	if (!new_hard_iface)
-		goto out;
+		return;
 
 	batman_packet = (struct batman_packet *)(new_hard_iface->packet_buff);
 	batman_packet->flags = PRIMARIES_FIRST_HOP;
@@ -161,9 +158,6 @@ static void primary_if_select(struct bat_priv *bat_priv,
 	 * our new primary interface
 	 */
 	atomic_set(&bat_priv->hna_local_changed, 1);
-
-out:
-	spin_unlock_bh(&hardif_list_lock);
 }
 
 static bool hardif_is_iface_up(struct hard_iface *hard_iface)
@@ -456,6 +450,8 @@ static struct hard_iface *hardif_add_interface(struct net_device *net_dev)
 	struct hard_iface *hard_iface;
 	int ret;
 
+	ASSERT_RTNL();
+
 	ret = is_valid_iface(net_dev);
 	if (ret != 1)
 		goto out;
@@ -482,10 +478,7 @@ static struct hard_iface *hardif_add_interface(struct net_device *net_dev)
 	atomic_set(&hard_iface->refcount, 2);
 
 	check_known_mac_addr(hard_iface->net_dev);
-
-	spin_lock(&hardif_list_lock);
 	list_add_tail_rcu(&hard_iface->list, &hardif_list);
-	spin_unlock(&hardif_list_lock);
 
 	return hard_iface;
 
@@ -499,6 +492,8 @@ out:
 
 static void hardif_remove_interface(struct hard_iface *hard_iface)
 {
+	ASSERT_RTNL();
+
 	/* first deactivate interface */
 	if (hard_iface->if_status != IF_NOT_IN_USE)
 		hardif_disable_interface(hard_iface);
@@ -514,20 +509,11 @@ static void hardif_remove_interface(struct hard_iface *hard_iface)
 void hardif_remove_interfaces(void)
 {
 	struct hard_iface *hard_iface, *hard_iface_tmp;
-	struct list_head if_queue;
 
-	INIT_LIST_HEAD(&if_queue);
-
-	spin_lock(&hardif_list_lock);
+	rtnl_lock();
 	list_for_each_entry_safe(hard_iface, hard_iface_tmp,
 				 &hardif_list, list) {
 		list_del_rcu(&hard_iface->list);
-		list_add_tail(&hard_iface->list, &if_queue);
-	}
-	spin_unlock(&hardif_list_lock);
-
-	rtnl_lock();
-	list_for_each_entry_safe(hard_iface, hard_iface_tmp, &if_queue, list) {
 		hardif_remove_interface(hard_iface);
 	}
 	rtnl_unlock();
@@ -556,9 +542,7 @@ static int hard_if_event(struct notifier_block *this,
 		hardif_deactivate_interface(hard_iface);
 		break;
 	case NETDEV_UNREGISTER:
-		spin_lock(&hardif_list_lock);
 		list_del_rcu(&hard_iface->list);
-		spin_unlock(&hardif_list_lock);
 
 		hardif_remove_interface(hard_iface);
 		break;
diff --git a/main.c b/main.c
index 709b33b..39feb5a 100644
--- a/main.c
+++ b/main.c
@@ -33,6 +33,9 @@
 #include "vis.h"
 #include "hash.h"
 
+
+/* List manipulations on hardif_list have to be rtnl_lock()'ed,
+ * list traversals just rcu-locked */
 struct list_head hardif_list;
 
 unsigned char broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-- 
1.7.4.4

