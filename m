Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri,  4 Feb 2011 16:21:32 +0100
Message-Id: <1296832896-30081-4-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <201102031802.52134.lindner_marek@yahoo.de>
References: <201102031802.52134.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/7] batman-adv: Correct rcu refcounting for
	batman_if
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

From: Sven Eckelmann <sven@narfation.org>

It might be possible that 2 threads access the same data in the same
rcu grace period. The first thread calls call_rcu() to decrement the
refcount and free the data while the second thread increases the
refcount to use the data. To avoid this race condition all refcount
operations have to be atomic.

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_sysfs.c      |   20 +++++++++-----------
 hard-interface.c |   40 +++++++++++++++++++---------------------
 hard-interface.h |    9 ++++-----
 types.h          |    2 +-
 4 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index f7b93a0..93ae20a 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -450,7 +450,7 @@ static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	length = sprintf(buff, "%s\n", batman_if->if_status == IF_NOT_IN_USE ?
 			 "none" : batman_if->soft_iface->name);
 
-	kref_put(&batman_if->refcount, hardif_free_ref);
+	hardif_free_ref(batman_if);
 
 	return length;
 }
@@ -461,7 +461,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	struct net_device *net_dev = kobj_to_netdev(kobj);
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
 	int status_tmp = -1;
-	int ret;
+	int ret = count;
 
 	if (!batman_if)
 		return count;
@@ -472,7 +472,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	if (strlen(buff) >= IFNAMSIZ) {
 		pr_err("Invalid parameter for 'mesh_iface' setting received: "
 		       "interface name too long '%s'\n", buff);
-		kref_put(&batman_if->refcount, hardif_free_ref);
+		hardif_free_ref(batman_if);
 		return -EINVAL;
 	}
 
@@ -482,17 +482,14 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 		status_tmp = IF_I_WANT_YOU;
 
 	if ((batman_if->if_status == status_tmp) || ((batman_if->soft_iface) &&
-	    (strncmp(batman_if->soft_iface->name, buff, IFNAMSIZ) == 0))) {
-		kref_put(&batman_if->refcount, hardif_free_ref);
-		return count;
-	}
+	    (strncmp(batman_if->soft_iface->name, buff, IFNAMSIZ) == 0)))
+		goto out;
 
 	if (status_tmp == IF_NOT_IN_USE) {
 		rtnl_lock();
 		hardif_disable_interface(batman_if);
 		rtnl_unlock();
-		kref_put(&batman_if->refcount, hardif_free_ref);
-		return count;
+		goto out;
 	}
 
 	/* if the interface already is in use */
@@ -503,8 +500,9 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	}
 
 	ret = hardif_enable_interface(batman_if, buff);
-	kref_put(&batman_if->refcount, hardif_free_ref);
 
+out:
+	hardif_free_ref(batman_if);
 	return ret;
 }
 
@@ -537,7 +535,7 @@ static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
 		break;
 	}
 
-	kref_put(&batman_if->refcount, hardif_free_ref);
+	hardif_free_ref(batman_if);
 
 	return length;
 }
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index e2b001a..8982485 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -40,13 +40,13 @@ static int batman_skb_recv(struct sk_buff *skb,
 			   struct packet_type *ptype,
 			   struct net_device *orig_dev);
 
-static void hardif_free_rcu(struct rcu_head *rcu)
+void hardif_free_rcu(struct rcu_head *rcu)
 {
 	struct batman_if *batman_if;
 
 	batman_if = container_of(rcu, struct batman_if, rcu);
 	dev_put(batman_if->net_dev);
-	kref_put(&batman_if->refcount, hardif_free_ref);
+	kfree(batman_if);
 }
 
 struct batman_if *get_batman_if_by_netdev(struct net_device *net_dev)
@@ -55,16 +55,14 @@ struct batman_if *get_batman_if_by_netdev(struct net_device *net_dev)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		if (batman_if->net_dev == net_dev)
+		if (batman_if->net_dev == net_dev &&
+		    atomic_inc_not_zero(&batman_if->refcount))
 			goto out;
 	}
 
 	batman_if = NULL;
 
 out:
-	if (batman_if)
-		kref_get(&batman_if->refcount);
-
 	rcu_read_unlock();
 	return batman_if;
 }
@@ -105,16 +103,14 @@ static struct batman_if *get_active_batman_if(struct net_device *soft_iface)
 		if (batman_if->soft_iface != soft_iface)
 			continue;
 
-		if (batman_if->if_status == IF_ACTIVE)
+		if (batman_if->if_status == IF_ACTIVE &&
+		    atomic_inc_not_zero(&batman_if->refcount))
 			goto out;
 	}
 
 	batman_if = NULL;
 
 out:
-	if (batman_if)
-		kref_get(&batman_if->refcount);
-
 	rcu_read_unlock();
 	return batman_if;
 }
@@ -137,14 +133,14 @@ static void set_primary_if(struct bat_priv *bat_priv,
 	struct batman_packet *batman_packet;
 	struct batman_if *old_if;
 
-	if (batman_if)
-		kref_get(&batman_if->refcount);
+	if (batman_if && !atomic_inc_not_zero(&batman_if->refcount))
+		batman_if = NULL;
 
 	old_if = bat_priv->primary_if;
 	bat_priv->primary_if = batman_if;
 
 	if (old_if)
-		kref_put(&old_if->refcount, hardif_free_ref);
+		hardif_free_ref(old_if);
 
 	if (!bat_priv->primary_if)
 		return;
@@ -290,6 +286,9 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 	if (batman_if->if_status != IF_NOT_IN_USE)
 		goto out;
 
+	if (!atomic_inc_not_zero(&batman_if->refcount))
+		goto out;
+
 	batman_if->soft_iface = dev_get_by_name(&init_net, iface_name);
 
 	if (!batman_if->soft_iface) {
@@ -328,7 +327,6 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 	batman_if->batman_adv_ptype.type = __constant_htons(ETH_P_BATMAN);
 	batman_if->batman_adv_ptype.func = batman_skb_recv;
 	batman_if->batman_adv_ptype.dev = batman_if->net_dev;
-	kref_get(&batman_if->refcount);
 	dev_add_pack(&batman_if->batman_adv_ptype);
 
 	atomic_set(&batman_if->seqno, 1);
@@ -371,6 +369,7 @@ out:
 	return 0;
 
 err:
+	hardif_free_ref(batman_if);
 	return -ENOMEM;
 }
 
@@ -387,7 +386,6 @@ void hardif_disable_interface(struct batman_if *batman_if)
 	bat_info(batman_if->soft_iface, "Removing interface: %s\n",
 		 batman_if->net_dev->name);
 	dev_remove_pack(&batman_if->batman_adv_ptype);
-	kref_put(&batman_if->refcount, hardif_free_ref);
 
 	bat_priv->num_ifaces--;
 	orig_hash_del_if(batman_if, bat_priv->num_ifaces);
@@ -399,7 +397,7 @@ void hardif_disable_interface(struct batman_if *batman_if)
 		set_primary_if(bat_priv, new_if);
 
 		if (new_if)
-			kref_put(&new_if->refcount, hardif_free_ref);
+			hardif_free_ref(new_if);
 	}
 
 	kfree(batman_if->packet_buff);
@@ -416,6 +414,7 @@ void hardif_disable_interface(struct batman_if *batman_if)
 		softif_destroy(batman_if->soft_iface);
 
 	batman_if->soft_iface = NULL;
+	hardif_free_ref(batman_if);
 }
 
 static struct batman_if *hardif_add_interface(struct net_device *net_dev)
@@ -445,7 +444,8 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	batman_if->soft_iface = NULL;
 	batman_if->if_status = IF_NOT_IN_USE;
 	INIT_LIST_HEAD(&batman_if->list);
-	kref_init(&batman_if->refcount);
+	/* extra reference for return */
+	atomic_set(&batman_if->refcount, 2);
 
 	check_known_mac_addr(batman_if->net_dev);
 
@@ -453,8 +453,6 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	list_add_tail_rcu(&batman_if->list, &if_list);
 	spin_unlock(&if_list_lock);
 
-	/* extra reference for return */
-	kref_get(&batman_if->refcount);
 	return batman_if;
 
 free_if:
@@ -476,7 +474,7 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 
 	batman_if->if_status = IF_TO_BE_REMOVED;
 	sysfs_del_hardif(&batman_if->hardif_obj);
-	call_rcu(&batman_if->rcu, hardif_free_rcu);
+	hardif_free_ref(batman_if);
 }
 
 void hardif_remove_interfaces(void)
@@ -548,7 +546,7 @@ static int hard_if_event(struct notifier_block *this,
 	};
 
 hardif_put:
-	kref_put(&batman_if->refcount, hardif_free_ref);
+	hardif_free_ref(batman_if);
 out:
 	return NOTIFY_DONE;
 }
diff --git a/batman-adv/hard-interface.h b/batman-adv/hard-interface.h
index ad19543..e488b90 100644
--- a/batman-adv/hard-interface.h
+++ b/batman-adv/hard-interface.h
@@ -37,13 +37,12 @@ void hardif_disable_interface(struct batman_if *batman_if);
 void hardif_remove_interfaces(void);
 int hardif_min_mtu(struct net_device *soft_iface);
 void update_min_mtu(struct net_device *soft_iface);
+void hardif_free_rcu(struct rcu_head *rcu);
 
-static inline void hardif_free_ref(struct kref *refcount)
+static inline void hardif_free_ref(struct batman_if *batman_if)
 {
-	struct batman_if *batman_if;
-
-	batman_if = container_of(refcount, struct batman_if, refcount);
-	kfree(batman_if);
+	if (atomic_dec_and_test(&batman_if->refcount))
+		call_rcu(&batman_if->rcu, hardif_free_rcu);
 }
 
 #endif /* _NET_BATMAN_ADV_HARD_INTERFACE_H_ */
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 8df6d9d..317ede8 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -43,7 +43,7 @@ struct batman_if {
 	unsigned char *packet_buff;
 	int packet_len;
 	struct kobject *hardif_obj;
-	struct kref refcount;
+	atomic_t refcount;
 	struct packet_type batman_adv_ptype;
 	struct net_device *soft_iface;
 	struct rcu_head rcu;
-- 
1.7.2.3

