Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 30 Apr 2011 22:54:14 +0200
Message-Id: <1304196854-28141-1-git-send-email-sven@narfation.org>
In-Reply-To: <1304182620-12637-2-git-send-email-sven@narfation.org>
References: <1304182620-12637-2-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 2/3] batman-adv: Remove unnecessary
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
Rebased patch on top of "batman-adv: Make bat_priv->primary_if an rcu
protected pointer"


 hard-interface.c |   21 ++++++---------------
 1 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 6636d2f..7e2f772 100644
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
@@ -516,13 +511,11 @@ void hardif_remove_interfaces(void)
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
 
@@ -549,9 +542,7 @@ static int hard_if_event(struct notifier_block *this,
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

