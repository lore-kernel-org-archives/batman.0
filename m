Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 18 Sep 2010 21:01:20 +0200
Message-Id: <1284836482-23431-11-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 10/12] Staging: batman-adv: count batman_if
	list queries as reference
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

The return of get_batman_if_by_netdev and get_active_batman_if leaks a
pointer from the rcu protected list of interfaces. We must protect it to
prevent a too early release of the memory. Those functions must increase
the reference counter before rcu_read_unlock or it may be to late to
prevent a free.

hardif_add_interface must also increase the reference count for the
returned batman_if to make the behaviour consistent.

Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/TODO             |    4 --
 drivers/staging/batman-adv/bat_sysfs.c      |   42 ++++++++++++++++++++------
 drivers/staging/batman-adv/hard-interface.c |   29 +++++++++++++++---
 3 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/batman-adv/TODO b/drivers/staging/batman-adv/TODO
index cb6b026..5913731 100644
--- a/drivers/staging/batman-adv/TODO
+++ b/drivers/staging/batman-adv/TODO
@@ -1,7 +1,3 @@
- * Rework usage of RCU
-    - don't leak pointers from rcu out of rcu critical area which may
-      get freed
-    - go through Documentation/RCU/checklist.txt
  * Request a new review
  * Process the comments from the review
  * Move into mainline proper
diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index 0610169..bc17fb8 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -405,13 +405,17 @@ static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
+	ssize_t length;
 
 	if (!batman_if)
 		return 0;
 
-	return sprintf(buff, "%s\n",
-		       batman_if->if_status == IF_NOT_IN_USE ?
-					"none" : batman_if->soft_iface->name);
+	length = sprintf(buff, "%s\n", batman_if->if_status == IF_NOT_IN_USE ?
+			 "none" : batman_if->soft_iface->name);
+
+	hardif_put(batman_if);
+
+	return length;
 }
 
 static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
@@ -421,6 +425,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	struct net_device *net_dev = to_net_dev(dev);
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
 	int status_tmp = -1;
+	int ret;
 
 	if (!batman_if)
 		return count;
@@ -431,6 +436,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	if (strlen(buff) >= IFNAMSIZ) {
 		pr_err("Invalid parameter for 'mesh_iface' setting received: "
 		       "interface name too long '%s'\n", buff);
+		hardif_put(batman_if);
 		return -EINVAL;
 	}
 
@@ -440,13 +446,16 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 		status_tmp = IF_I_WANT_YOU;
 
 	if ((batman_if->if_status == status_tmp) || ((batman_if->soft_iface) &&
-	    (strncmp(batman_if->soft_iface->name, buff, IFNAMSIZ) == 0)))
+	    (strncmp(batman_if->soft_iface->name, buff, IFNAMSIZ) == 0))) {
+		hardif_put(batman_if);
 		return count;
+	}
 
 	if (status_tmp == IF_NOT_IN_USE) {
 		rtnl_lock();
 		hardif_disable_interface(batman_if);
 		rtnl_unlock();
+		hardif_put(batman_if);
 		return count;
 	}
 
@@ -457,7 +466,10 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 		rtnl_unlock();
 	}
 
-	return hardif_enable_interface(batman_if, buff);
+	ret = hardif_enable_interface(batman_if, buff);
+	hardif_put(batman_if);
+
+	return ret;
 }
 
 static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
@@ -466,23 +478,33 @@ static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
+	ssize_t length;
 
 	if (!batman_if)
 		return 0;
 
 	switch (batman_if->if_status) {
 	case IF_TO_BE_REMOVED:
-		return sprintf(buff, "disabling\n");
+		length = sprintf(buff, "disabling\n");
+		break;
 	case IF_INACTIVE:
-		return sprintf(buff, "inactive\n");
+		length = sprintf(buff, "inactive\n");
+		break;
 	case IF_ACTIVE:
-		return sprintf(buff, "active\n");
+		length = sprintf(buff, "active\n");
+		break;
 	case IF_TO_BE_ACTIVATED:
-		return sprintf(buff, "enabling\n");
+		length = sprintf(buff, "enabling\n");
+		break;
 	case IF_NOT_IN_USE:
 	default:
-		return sprintf(buff, "not in use\n");
+		length = sprintf(buff, "not in use\n");
+		break;
 	}
+
+	hardif_put(batman_if);
+
+	return length;
 }
 
 static BAT_ATTR(mesh_iface, S_IRUGO | S_IWUSR,
diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index df6e5bd..eef5631 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -49,6 +49,9 @@ struct batman_if *get_batman_if_by_netdev(struct net_device *net_dev)
 	batman_if = NULL;
 
 out:
+	if (batman_if)
+		hardif_hold(batman_if);
+
 	rcu_read_unlock();
 	return batman_if;
 }
@@ -96,6 +99,9 @@ static struct batman_if *get_active_batman_if(struct net_device *soft_iface)
 	batman_if = NULL;
 
 out:
+	if (batman_if)
+		hardif_hold(batman_if);
+
 	rcu_read_unlock();
 	return batman_if;
 }
@@ -292,6 +298,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 	batman_if->batman_adv_ptype.type = __constant_htons(ETH_P_BATMAN);
 	batman_if->batman_adv_ptype.func = batman_skb_recv;
 	batman_if->batman_adv_ptype.dev = batman_if->net_dev;
+	hardif_hold(batman_if);
 	dev_add_pack(&batman_if->batman_adv_ptype);
 
 	atomic_set(&batman_if->seqno, 1);
@@ -350,13 +357,20 @@ void hardif_disable_interface(struct batman_if *batman_if)
 	bat_info(batman_if->soft_iface, "Removing interface: %s\n",
 		 batman_if->net_dev->name);
 	dev_remove_pack(&batman_if->batman_adv_ptype);
+	hardif_put(batman_if);
 
 	bat_priv->num_ifaces--;
 	orig_hash_del_if(batman_if, bat_priv->num_ifaces);
 
-	if (batman_if == bat_priv->primary_if)
-		set_primary_if(bat_priv,
-			       get_active_batman_if(batman_if->soft_iface));
+	if (batman_if == bat_priv->primary_if) {
+		struct batman_if *new_if;
+
+		new_if = get_active_batman_if(batman_if->soft_iface);
+		set_primary_if(bat_priv, new_if);
+
+		if (new_if)
+			hardif_put(new_if);
+	}
 
 	kfree(batman_if->packet_buff);
 	batman_if->packet_buff = NULL;
@@ -410,6 +424,8 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	list_add_tail_rcu(&batman_if->list, &if_list);
 	spin_unlock(&if_list_lock);
 
+	/* extra reference for return */
+	hardif_hold(batman_if);
 	return batman_if;
 
 free_if:
@@ -459,7 +475,7 @@ static int hard_if_event(struct notifier_block *this,
 	struct bat_priv *bat_priv;
 
 	if (!batman_if && event == NETDEV_REGISTER)
-			batman_if = hardif_add_interface(net_dev);
+		batman_if = hardif_add_interface(net_dev);
 
 	if (!batman_if)
 		goto out;
@@ -482,8 +498,10 @@ static int hard_if_event(struct notifier_block *this,
 			update_min_mtu(batman_if->soft_iface);
 		break;
 	case NETDEV_CHANGEADDR:
-		if (batman_if->if_status == IF_NOT_IN_USE)
+		if (batman_if->if_status == IF_NOT_IN_USE) {
+			hardif_put(batman_if);
 			goto out;
+		}
 
 		check_known_mac_addr(batman_if->net_dev->dev_addr);
 		update_mac_addresses(batman_if);
@@ -495,6 +513,7 @@ static int hard_if_event(struct notifier_block *this,
 	default:
 		break;
 	};
+	hardif_put(batman_if);
 
 out:
 	return NOTIFY_DONE;
-- 
1.7.2.3

