Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 30 Sep 2010 14:08:43 +0200
Message-Id: <1285848524-13469-4-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1285848524-13469-1-git-send-email-lindner_marek@yahoo.de>
References: <1285848524-13469-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: convert batman_if custom
	refcounting to kref functions
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

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv/bat_sysfs.c      |   12 ++++++------
 batman-adv/hard-interface.c |   30 ++++++++++++++----------------
 batman-adv/hard-interface.h |   13 ++++---------
 batman-adv/types.h          |    2 +-
 4 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index 9ab2bfe..3f551f3 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -461,7 +461,7 @@ static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	length = sprintf(buff, "%s\n", batman_if->if_status == IF_NOT_IN_USE ?
 			 "none" : batman_if->soft_iface->name);
 
-	hardif_put(batman_if);
+	kref_put(&batman_if->refcount, hardif_free_ref);
 
 	return length;
 }
@@ -484,7 +484,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	if (strlen(buff) >= IFNAMSIZ) {
 		pr_err("Invalid parameter for 'mesh_iface' setting received: "
 		       "interface name too long '%s'\n", buff);
-		hardif_put(batman_if);
+		kref_put(&batman_if->refcount, hardif_free_ref);
 		return -EINVAL;
 	}
 
@@ -495,7 +495,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 
 	if ((batman_if->if_status == status_tmp) || ((batman_if->soft_iface) &&
 	    (strncmp(batman_if->soft_iface->name, buff, IFNAMSIZ) == 0))) {
-		hardif_put(batman_if);
+		kref_put(&batman_if->refcount, hardif_free_ref);
 		return count;
 	}
 
@@ -503,7 +503,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 		rtnl_lock();
 		hardif_disable_interface(batman_if);
 		rtnl_unlock();
-		hardif_put(batman_if);
+		kref_put(&batman_if->refcount, hardif_free_ref);
 		return count;
 	}
 
@@ -515,7 +515,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	}
 
 	ret = hardif_enable_interface(batman_if, buff);
-	hardif_put(batman_if);
+	kref_put(&batman_if->refcount, hardif_free_ref);
 
 	return ret;
 }
@@ -550,7 +550,7 @@ static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
 		break;
 	}
 
-	hardif_put(batman_if);
+	kref_put(&batman_if->refcount, hardif_free_ref);
 
 	return length;
 }
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index def74cf..87693db 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -52,7 +52,7 @@ struct batman_if *get_batman_if_by_netdev(struct net_device *net_dev)
 
 out:
 	if (batman_if)
-		hardif_hold(batman_if);
+		kref_get(&batman_if->refcount);
 
 	rcu_read_unlock();
 	return batman_if;
@@ -102,7 +102,7 @@ static struct batman_if *get_active_batman_if(struct net_device *soft_iface)
 
 out:
 	if (batman_if)
-		hardif_hold(batman_if);
+		kref_get(&batman_if->refcount);
 
 	rcu_read_unlock();
 	return batman_if;
@@ -127,13 +127,13 @@ static void set_primary_if(struct bat_priv *bat_priv,
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
@@ -314,7 +314,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 	batman_if->batman_adv_ptype.type = __constant_htons(ETH_P_BATMAN);
 	batman_if->batman_adv_ptype.func = batman_skb_recv;
 	batman_if->batman_adv_ptype.dev = batman_if->net_dev;
-	hardif_hold(batman_if);
+	kref_get(&batman_if->refcount);
 	dev_add_pack(&batman_if->batman_adv_ptype);
 
 	atomic_set(&batman_if->seqno, 1);
@@ -373,7 +373,7 @@ void hardif_disable_interface(struct batman_if *batman_if)
 	bat_info(batman_if->soft_iface, "Removing interface: %s\n",
 		 batman_if->net_dev->name);
 	dev_remove_pack(&batman_if->batman_adv_ptype);
-	hardif_put(batman_if);
+	kref_put(&batman_if->refcount, hardif_free_ref);
 
 	bat_priv->num_ifaces--;
 	orig_hash_del_if(batman_if, bat_priv->num_ifaces);
@@ -385,7 +385,7 @@ void hardif_disable_interface(struct batman_if *batman_if)
 		set_primary_if(bat_priv, new_if);
 
 		if (new_if)
-			hardif_put(new_if);
+			kref_put(&new_if->refcount, hardif_free_ref);
 	}
 
 	kfree(batman_if->packet_buff);
@@ -431,8 +431,7 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	batman_if->soft_iface = NULL;
 	batman_if->if_status = IF_NOT_IN_USE;
 	INIT_LIST_HEAD(&batman_if->list);
-	atomic_set(&batman_if->refcnt, 0);
-	hardif_hold(batman_if);
+	kref_init(&batman_if->refcount);
 
 	check_known_mac_addr(batman_if->net_dev->dev_addr);
 
@@ -441,7 +440,7 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	spin_unlock(&if_list_lock);
 
 	/* extra reference for return */
-	hardif_hold(batman_if);
+	kref_get(&batman_if->refcount);
 	return batman_if;
 
 free_if:
@@ -467,7 +466,7 @@ static void hardif_remove_interface(struct batman_if *batman_if)
 	list_del_rcu(&batman_if->list);
 	synchronize_rcu();
 	sysfs_del_hardif(&batman_if->hardif_obj);
-	hardif_put(batman_if);
+	kref_put(&batman_if->refcount, hardif_free_ref);
 }
 
 void hardif_remove_interfaces(void)
@@ -514,10 +513,8 @@ static int hard_if_event(struct notifier_block *this,
 			update_min_mtu(batman_if->soft_iface);
 		break;
 	case NETDEV_CHANGEADDR:
-		if (batman_if->if_status == IF_NOT_IN_USE) {
-			hardif_put(batman_if);
-			goto out;
-		}
+		if (batman_if->if_status == IF_NOT_IN_USE)
+			goto hardif_put;
 
 		check_known_mac_addr(batman_if->net_dev->dev_addr);
 		update_mac_addresses(batman_if);
@@ -529,8 +526,9 @@ static int hard_if_event(struct notifier_block *this,
 	default:
 		break;
 	};
-	hardif_put(batman_if);
 
+hardif_put:
+	kref_put(&batman_if->refcount, hardif_free_ref);
 out:
 	return NOTIFY_DONE;
 }
diff --git a/batman-adv/hard-interface.h b/batman-adv/hard-interface.h
index d550889..30ec3b8 100644
--- a/batman-adv/hard-interface.h
+++ b/batman-adv/hard-interface.h
@@ -42,17 +42,12 @@ int batman_skb_recv(struct sk_buff *skb,
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
+	kfree(batman_if);
 }
 
 #endif /* _NET_BATMAN_ADV_HARD_INTERFACE_H_ */
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 11f1017..585647b 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -44,7 +44,7 @@ struct batman_if {
 	unsigned char *packet_buff;
 	int packet_len;
 	struct kobject *hardif_obj;
-	atomic_t refcnt;
+	struct kref refcount;
 	struct packet_type batman_adv_ptype;
 	struct net_device *soft_iface;
 };
-- 
1.7.1

