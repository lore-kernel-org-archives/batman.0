Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 02:09:31 +0200
Message-Id: <1336781383-15649-11-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-1-git-send-email-sven@narfation.org>
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 11/23] batman-adv: Prefix hard-interface
	non-static functions with batadv_
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

batman-adv can be compiled as part of the kernel instead of an module. In that
case the linker will see all non-static symbols of batman-adv and all other
non-static symbols of the kernel. This could lead to symbol collisions. A
prefix for the batman-adv symbols that defines their private namespace avoids
such a problem.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_sysfs.c         |   18 +++++++++---------
 hard-interface.c    |   32 ++++++++++++++++----------------
 hard-interface.h    |   22 +++++++++++-----------
 main.c              |    6 +++---
 soft-interface.c    |    2 +-
 translation-table.c |    2 +-
 6 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index a8fb660..7fcdddb 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -122,7 +122,7 @@ ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
 		      char *buff, size_t count)				\
 {									\
 	struct net_device *net_dev = kobj_to_netdev(kobj);		\
-	struct hard_iface *hard_iface = hardif_get_by_netdev(net_dev);	\
+	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev); \
 	ssize_t length;							\
 									\
 	if (!hard_iface)						\
@@ -140,7 +140,7 @@ ssize_t show_##_name(struct kobject *kobj,				\
 		     struct attribute *attr, char *buff)		\
 {									\
 	struct net_device *net_dev = kobj_to_netdev(kobj);		\
-	struct hard_iface *hard_iface = hardif_get_by_netdev(net_dev);	\
+	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev); \
 	ssize_t length;							\
 									\
 	if (!hard_iface)						\
@@ -433,7 +433,7 @@ BAT_ATTR_SIF_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 #ifdef CONFIG_BATMAN_ADV_BLA
 BAT_ATTR_SIF_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR, NULL);
 #endif
-BAT_ATTR_SIF_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
+BAT_ATTR_SIF_BOOL(fragmentation, S_IRUGO | S_IWUSR, batadv_update_min_mtu);
 BAT_ATTR_SIF_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(routing_algo, S_IRUGO, show_bat_algo, NULL);
@@ -523,7 +523,7 @@ static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 			       char *buff)
 {
 	struct net_device *net_dev = kobj_to_netdev(kobj);
-	struct hard_iface *hard_iface = hardif_get_by_netdev(net_dev);
+	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	ssize_t length;
 
 	if (!hard_iface)
@@ -541,7 +541,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 				char *buff, size_t count)
 {
 	struct net_device *net_dev = kobj_to_netdev(kobj);
-	struct hard_iface *hard_iface = hardif_get_by_netdev(net_dev);
+	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	int status_tmp = -1;
 	int ret = count;
 
@@ -576,15 +576,15 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	}
 
 	if (status_tmp == IF_NOT_IN_USE) {
-		hardif_disable_interface(hard_iface);
+		batadv_hardif_disable_interface(hard_iface);
 		goto unlock;
 	}
 
 	/* if the interface already is in use */
 	if (hard_iface->if_status != IF_NOT_IN_USE)
-		hardif_disable_interface(hard_iface);
+		batadv_hardif_disable_interface(hard_iface);
 
-	ret = hardif_enable_interface(hard_iface, buff);
+	ret = batadv_hardif_enable_interface(hard_iface, buff);
 
 unlock:
 	rtnl_unlock();
@@ -597,7 +597,7 @@ static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
 				 char *buff)
 {
 	struct net_device *net_dev = kobj_to_netdev(kobj);
-	struct hard_iface *hard_iface = hardif_get_by_netdev(net_dev);
+	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	ssize_t length;
 
 	if (!hard_iface)
diff --git a/hard-interface.c b/hard-interface.c
index 6cf9c13..44206b6 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -33,7 +33,7 @@
 
 #include <linux/if_arp.h>
 
-void hardif_free_rcu(struct rcu_head *rcu)
+void batadv_hardif_free_rcu(struct rcu_head *rcu)
 {
 	struct hard_iface *hard_iface;
 
@@ -42,7 +42,7 @@ void hardif_free_rcu(struct rcu_head *rcu)
 	kfree(hard_iface);
 }
 
-struct hard_iface *hardif_get_by_netdev(const struct net_device *net_dev)
+struct hard_iface *batadv_hardif_get_by_netdev(const struct net_device *net_dev)
 {
 	struct hard_iface *hard_iface;
 
@@ -183,7 +183,7 @@ static void check_known_mac_addr(const struct net_device *net_dev)
 	rcu_read_unlock();
 }
 
-int hardif_min_mtu(struct net_device *soft_iface)
+int batadv_hardif_min_mtu(struct net_device *soft_iface)
 {
 	const struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	const struct hard_iface *hard_iface;
@@ -212,11 +212,11 @@ out:
 }
 
 /* adjusts the MTU if a new interface with a smaller MTU appeared. */
-void update_min_mtu(struct net_device *soft_iface)
+void batadv_update_min_mtu(struct net_device *soft_iface)
 {
 	int min_mtu;
 
-	min_mtu = hardif_min_mtu(soft_iface);
+	min_mtu = batadv_hardif_min_mtu(soft_iface);
 	if (soft_iface->mtu != min_mtu)
 		soft_iface->mtu = min_mtu;
 }
@@ -245,7 +245,7 @@ static void hardif_activate_interface(struct hard_iface *hard_iface)
 	bat_info(hard_iface->soft_iface, "Interface activated: %s\n",
 		 hard_iface->net_dev->name);
 
-	update_min_mtu(hard_iface->soft_iface);
+	batadv_update_min_mtu(hard_iface->soft_iface);
 
 out:
 	if (primary_if)
@@ -263,11 +263,11 @@ static void hardif_deactivate_interface(struct hard_iface *hard_iface)
 	bat_info(hard_iface->soft_iface, "Interface deactivated: %s\n",
 		 hard_iface->net_dev->name);
 
-	update_min_mtu(hard_iface->soft_iface);
+	batadv_update_min_mtu(hard_iface->soft_iface);
 }
 
-int hardif_enable_interface(struct hard_iface *hard_iface,
-			    const char *iface_name)
+int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
+				   const char *iface_name)
 {
 	struct bat_priv *bat_priv;
 	struct net_device *soft_iface;
@@ -360,7 +360,7 @@ err:
 	return ret;
 }
 
-void hardif_disable_interface(struct hard_iface *hard_iface)
+void batadv_hardif_disable_interface(struct hard_iface *hard_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct hard_iface *primary_if = NULL;
@@ -464,7 +464,7 @@ static void hardif_remove_interface(struct hard_iface *hard_iface)
 
 	/* first deactivate interface */
 	if (hard_iface->if_status != IF_NOT_IN_USE)
-		hardif_disable_interface(hard_iface);
+		batadv_hardif_disable_interface(hard_iface);
 
 	if (hard_iface->if_status != IF_NOT_IN_USE)
 		return;
@@ -474,7 +474,7 @@ static void hardif_remove_interface(struct hard_iface *hard_iface)
 	hardif_free_ref(hard_iface);
 }
 
-void hardif_remove_interfaces(void)
+void batadv_hardif_remove_interfaces(void)
 {
 	struct hard_iface *hard_iface, *hard_iface_tmp;
 
@@ -491,7 +491,7 @@ static int hard_if_event(struct notifier_block *this,
 			 unsigned long event, void *ptr)
 {
 	struct net_device *net_dev = ptr;
-	struct hard_iface *hard_iface = hardif_get_by_netdev(net_dev);
+	struct hard_iface *hard_iface = batadv_hardif_get_by_netdev(net_dev);
 	struct hard_iface *primary_if = NULL;
 	struct bat_priv *bat_priv;
 
@@ -516,7 +516,7 @@ static int hard_if_event(struct notifier_block *this,
 		break;
 	case NETDEV_CHANGEMTU:
 		if (hard_iface->soft_iface)
-			update_min_mtu(hard_iface->soft_iface);
+			batadv_update_min_mtu(hard_iface->soft_iface);
 		break;
 	case NETDEV_CHANGEADDR:
 		if (hard_iface->if_status == IF_NOT_IN_USE)
@@ -548,7 +548,7 @@ out:
 
 /* This function returns true if the interface represented by ifindex is a
  * 802.11 wireless device */
-bool is_wifi_iface(int ifindex)
+bool batadv_is_wifi_iface(int ifindex)
 {
 	struct net_device *net_device = NULL;
 	bool ret = false;
@@ -576,6 +576,6 @@ out:
 	return ret;
 }
 
-struct notifier_block hard_if_notifier = {
+struct notifier_block batadv_hard_if_notifier = {
 	.notifier_call = hard_if_event,
 };
diff --git a/hard-interface.h b/hard-interface.h
index e68c565..20e09db 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -31,23 +31,23 @@ enum hard_if_state {
 	IF_I_WANT_YOU
 };
 
-extern struct notifier_block hard_if_notifier;
+extern struct notifier_block batadv_hard_if_notifier;
 
 struct hard_iface*
-hardif_get_by_netdev(const struct net_device *net_dev);
-int hardif_enable_interface(struct hard_iface *hard_iface,
-			    const char *iface_name);
-void hardif_disable_interface(struct hard_iface *hard_iface);
-void hardif_remove_interfaces(void);
-int hardif_min_mtu(struct net_device *soft_iface);
-void update_min_mtu(struct net_device *soft_iface);
-void hardif_free_rcu(struct rcu_head *rcu);
-bool is_wifi_iface(int ifindex);
+batadv_hardif_get_by_netdev(const struct net_device *net_dev);
+int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
+				   const char *iface_name);
+void batadv_hardif_disable_interface(struct hard_iface *hard_iface);
+void batadv_hardif_remove_interfaces(void);
+int batadv_hardif_min_mtu(struct net_device *soft_iface);
+void batadv_update_min_mtu(struct net_device *soft_iface);
+void batadv_hardif_free_rcu(struct rcu_head *rcu);
+bool batadv_is_wifi_iface(int ifindex);
 
 static inline void hardif_free_ref(struct hard_iface *hard_iface)
 {
 	if (atomic_dec_and_test(&hard_iface->refcount))
-		call_rcu(&hard_iface->rcu, hardif_free_rcu);
+		call_rcu(&hard_iface->rcu, batadv_hardif_free_rcu);
 }
 
 static inline struct hard_iface *primary_if_get_selected(
diff --git a/main.c b/main.c
index 81d9718..0d42edf 100644
--- a/main.c
+++ b/main.c
@@ -68,7 +68,7 @@ static int __init batman_init(void)
 	bat_socket_init();
 	batadv_debugfs_init();
 
-	register_netdevice_notifier(&hard_if_notifier);
+	register_netdevice_notifier(&batadv_hard_if_notifier);
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
 		SOURCE_VERSION, COMPAT_VERSION);
@@ -79,8 +79,8 @@ static int __init batman_init(void)
 static void __exit batman_exit(void)
 {
 	batadv_debugfs_destroy();
-	unregister_netdevice_notifier(&hard_if_notifier);
-	hardif_remove_interfaces();
+	unregister_netdevice_notifier(&batadv_hard_if_notifier);
+	batadv_hardif_remove_interfaces();
 
 	flush_workqueue(bat_event_workqueue);
 	destroy_workqueue(bat_event_workqueue);
diff --git a/soft-interface.c b/soft-interface.c
index ee8a309..eb9e759 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -123,7 +123,7 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 static int interface_change_mtu(struct net_device *dev, int new_mtu)
 {
 	/* check ranges */
-	if ((new_mtu < 68) || (new_mtu > hardif_min_mtu(dev)))
+	if ((new_mtu < 68) || (new_mtu > batadv_hardif_min_mtu(dev)))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
diff --git a/translation-table.c b/translation-table.c
index 9b8107a..60a2771 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -221,7 +221,7 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 
 	memcpy(tt_local_entry->common.addr, addr, ETH_ALEN);
 	tt_local_entry->common.flags = NO_FLAGS;
-	if (is_wifi_iface(ifindex))
+	if (batadv_is_wifi_iface(ifindex))
 		tt_local_entry->common.flags |= TT_CLIENT_WIFI;
 	atomic_set(&tt_local_entry->common.refcount, 2);
 	tt_local_entry->last_seen = jiffies;
-- 
1.7.10

