Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:43 +0100
Message-Id: <1290383767-32602-6-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 05/29] Staging: batman-adv: convert batman_if
	custom refcounting to kref functions
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/bat_sysfs.c      |   12 +++++-----
 drivers/staging/batman-adv/hard-interface.c |   30 ++++++++++++--------------
 drivers/staging/batman-adv/hard-interface.h |   14 ++++--------
 drivers/staging/batman-adv/types.h          |    2 +-
 4 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index bc17fb8..536f651 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -413,7 +413,7 @@ static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	length = sprintf(buff, "%s\n", batman_if->if_status == IF_NOT_IN_USE ?
 			 "none" : batman_if->soft_iface->name);
 
-	hardif_put(batman_if);
+	kref_put(&batman_if->refcount, hardif_free_ref);
 
 	return length;
 }
@@ -436,7 +436,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	if (strlen(buff) >= IFNAMSIZ) {
 		pr_err("Invalid parameter for 'mesh_iface' setting received: "
 		       "interface name too long '%s'\n", buff);
-		hardif_put(batman_if);
+		kref_put(&batman_if->refcount, hardif_free_ref);
 		return -EINVAL;
 	}
 
@@ -447,7 +447,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 
 	if ((batman_if->if_status == status_tmp) || ((batman_if->soft_iface) &&
 	    (strncmp(batman_if->soft_iface->name, buff, IFNAMSIZ) == 0))) {
-		hardif_put(batman_if);
+		kref_put(&batman_if->refcount, hardif_free_ref);
 		return count;
 	}
 
@@ -455,7 +455,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 		rtnl_lock();
 		hardif_disable_interface(batman_if);
 		rtnl_unlock();
-		hardif_put(batman_if);
+		kref_put(&batman_if->refcount, hardif_free_ref);
 		return count;
 	}
 
@@ -467,7 +467,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	}
 
 	ret = hardif_enable_interface(batman_if, buff);
-	hardif_put(batman_if);
+	kref_put(&batman_if->refcount, hardif_free_ref);
 
 	return ret;
 }
@@ -502,7 +502,7 @@ static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
 		break;
 	}
 
-	hardif_put(batman_if);
+	kref_put(&batman_if->refcount, hardif_free_ref);
 
 	return length;
 }
diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index d85de82..6d5b748 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -50,7 +50,7 @@ struct batman_if *get_batman_if_by_netdev(struct net_device *net_dev)
 
 out:
 	if (batman_if)
-		hardif_hold(batman_if);
+		kref_get(&batman_if->refcount);
 
 	rcu_read_unlock();
 	return batman_if;
@@ -100,7 +100,7 @@ static struct batman_if *get_active_batman_if(struct net_device *soft_iface)
 
 out:
 	if (batman_if)
-		hardif_hold(batman_if);
+		kref_get(&batman_if->refcount);
 
 	rcu_read_unlock();
 	return batman_if;
@@ -125,13 +125,13 @@ static void set_primary_if(struct bat_priv *bat_priv,
 	struct batman_if *old_if;
 
 	if (batman_if)
-		hardif_hold(batman_if);
+		kref_get(&batman_if->refcount);
 
 	old_if = bat_priv->primary_if;
 	bat_priv->primary_if = batman_if;
 
 	if (old_if)
-		hardif_put(old_if);
+		kref_put(&old_if->refcount, hardif_free_ref);
 
 	if (!bat_priv->primary_if)
 		return;
@@ -315,7 +315,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 	batman_if->batman_adv_ptype.type = __constant_htons(ETH_P_BATMAN);
 	batman_if->batman_adv_ptype.func = batman_skb_recv;
 	batman_if->batman_adv_ptype.dev = batman_if->net_dev;
-	hardif_hold(batman_if);
+	kref_get(&batman_if->refcount);
 	dev_add_pack(&batman_if->batman_adv_ptype);
 
 	atomic_set(&batman_if->seqno, 1);
@@ -374,7 +374,7 @@ void hardif_disable_interface(struct batman_if *batman_if)
 	bat_info(batman_if->soft_iface, "Removing interface: %s\n",
 		 batman_if->net_dev->name);
 	dev_remove_pack(&batman_if->batman_adv_ptype);
-	hardif_put(batman_if);
+	kref_put(&batman_if->refcount, hardif_free_ref);
 
 	bat_priv->num_ifaces--;
 	orig_hash_del_if(batman_if, bat_priv->num_ifaces);
@@ -386,7 +386,7 @@ void hardif_disable_interface(struct batman_if *batman_if)
 		set_primary_if(bat_priv, new_if);
 
 		if (new_if)
-			hardif_put(new_if);
+			kref_put(&new_if->refcount, hardif_free_ref);
 	}
 
 	kfree(batman_if->packet_buff);
@@ -432,8 +432,7 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	batman_if->soft_iface = NULL;
 	batman_if->if_status = IF_NOT_IN_USE;
 	INIT_LIST_HEAD(&batman_if->list);
-	atomic_set(&batman_if->refcnt, 0);
-	hardif_hold(batman_if);
+	kref_init(&batman_if->refcount);
 
 	check_known_mac_addr(batman_if->net_dev);
 
@@ -442,7 +441,7 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	spin_unlock(&if_list_lock);
 
 	/* extra reference for return */
-	hardif_hold(batman_if);
+	kref_get(&batman_if->refcount);
 	return batman_if;
 
 free_if:
@@ -465,7 +464,7 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 	batman_if->if_status = IF_TO_BE_REMOVED;
 	synchronize_rcu();
 	sysfs_del_hardif(&batman_if->hardif_obj);
-	hardif_put(batman_if);
+	kref_put(&batman_if->refcount, hardif_free_ref);
 }
 
 void hardif_remove_interfaces(void)
@@ -522,10 +521,8 @@ static int hard_if_event(struct notifier_block *this,
 			update_min_mtu(batman_if->soft_iface);
 		break;
 	case NETDEV_CHANGEADDR:
-		if (batman_if->if_status == IF_NOT_IN_USE) {
-			hardif_put(batman_if);
-			goto out;
-		}
+		if (batman_if->if_status == IF_NOT_IN_USE)
+			goto hardif_put;
 
 		check_known_mac_addr(batman_if->net_dev);
 		update_mac_addresses(batman_if);
@@ -537,8 +534,9 @@ static int hard_if_event(struct notifier_block *this,
 	default:
 		break;
 	};
-	hardif_put(batman_if);
 
+hardif_put:
+	kref_put(&batman_if->refcount, hardif_free_ref);
 out:
 	return NOTIFY_DONE;
 }
diff --git a/drivers/staging/batman-adv/hard-interface.h b/drivers/staging/batman-adv/hard-interface.h
index d550889..1d1cd9f 100644
--- a/drivers/staging/batman-adv/hard-interface.h
+++ b/drivers/staging/batman-adv/hard-interface.h
@@ -42,17 +42,13 @@ int batman_skb_recv(struct sk_buff *skb,
 int hardif_min_mtu(struct net_device *soft_iface);
 void update_min_mtu(struct net_device *soft_iface);
 
-static inline void hardif_hold(struct batman_if *batman_if)
+static inline void hardif_free_ref(struct kref *refcount)
 {
-	atomic_inc(&batman_if->refcnt);
-}
+	struct batman_if *batman_if;
 
-static inline void hardif_put(struct batman_if *batman_if)
-{
-	if (atomic_dec_and_test(&batman_if->refcnt)) {
-		dev_put(batman_if->net_dev);
-		kfree(batman_if);
-	}
+	batman_if = container_of(refcount, struct batman_if, refcount);
+	dev_put(batman_if->net_dev);
+	kfree(batman_if);
 }
 
 #endif /* _NET_BATMAN_ADV_HARD_INTERFACE_H_ */
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index f3f7366..d89ec70 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -43,7 +43,7 @@ struct batman_if {
 	unsigned char *packet_buff;
 	int packet_len;
 	struct kobject *hardif_obj;
-	atomic_t refcnt;
+	struct kref refcount;
 	struct packet_type batman_adv_ptype;
 	struct net_device *soft_iface;
 };
-- 
1.7.2.3

