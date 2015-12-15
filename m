Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Dec 2015 00:31:40 +0100
Message-Id: <1450222316-1764-7-git-send-email-sven@narfation.org>
In-Reply-To: <1450222316-1764-1-git-send-email-sven@narfation.org>
References: <1450222316-1764-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 07/23] batman-adv: Convert batadv_softif_vlan
	to kref
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

So switch to kref instead of using the self-made, atomic_t-based
implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c              |  2 +-
 net/batman-adv/soft-interface.c    | 45 ++++++++++++++++++++++++--------------
 net/batman-adv/soft-interface.h    |  2 +-
 net/batman-adv/sysfs.c             |  7 +++---
 net/batman-adv/translation-table.c | 20 ++++++++---------
 net/batman-adv/types.h             |  2 +-
 6 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 9d34be6..cfcc448 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1234,7 +1234,7 @@ bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid)
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
 	if (vlan) {
 		ap_isolation_enabled = atomic_read(&vlan->ap_isolation);
-		batadv_softif_vlan_free_ref(vlan);
+		batadv_softif_vlan_put(vlan);
 	}
 
 	return ap_isolation_enabled;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 6c65de9..7268feb 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -30,6 +30,7 @@
 #include <linux/if_vlan.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
@@ -478,22 +479,34 @@ out:
 }
 
 /**
- * batadv_softif_vlan_free_ref - decrease the vlan object refcounter and
+ * batadv_softif_vlan_release - release vlan from lists and queue for free after
+ *  rcu grace period
+ * * @ref: kref pointer of the vlan object
+ */
+static void batadv_softif_vlan_release(struct kref *ref)
+{
+	struct batadv_softif_vlan *vlan;
+
+	vlan = container_of(ref, struct batadv_softif_vlan, refcount);
+
+	spin_lock_bh(&vlan->bat_priv->softif_vlan_list_lock);
+	hlist_del_rcu(&vlan->list);
+	spin_unlock_bh(&vlan->bat_priv->softif_vlan_list_lock);
+
+	kfree_rcu(vlan, rcu);
+}
+
+/**
+ * batadv_softif_vlan_put - decrease the vlan object refcounter and
  *  possibly free it
  * @vlan: the vlan object to release
  */
-void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *vlan)
+void batadv_softif_vlan_put(struct batadv_softif_vlan *vlan)
 {
 	if (!vlan)
 		return;
 
-	if (atomic_dec_and_test(&vlan->refcount)) {
-		spin_lock_bh(&vlan->bat_priv->softif_vlan_list_lock);
-		hlist_del_rcu(&vlan->list);
-		spin_unlock_bh(&vlan->bat_priv->softif_vlan_list_lock);
-
-		kfree_rcu(vlan, rcu);
-	}
+	kref_put(&vlan->refcount, batadv_softif_vlan_release);
 }
 
 /**
@@ -514,7 +527,7 @@ struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 		if (vlan_tmp->vid != vid)
 			continue;
 
-		if (!atomic_inc_not_zero(&vlan_tmp->refcount))
+		if (!kref_get_unless_zero(&vlan_tmp->refcount))
 			continue;
 
 		vlan = vlan_tmp;
@@ -539,7 +552,7 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
 	if (vlan) {
-		batadv_softif_vlan_free_ref(vlan);
+		batadv_softif_vlan_put(vlan);
 		return -EEXIST;
 	}
 
@@ -549,7 +562,7 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 
 	vlan->bat_priv = bat_priv;
 	vlan->vid = vid;
-	atomic_set(&vlan->refcount, 1);
+	kref_init(&vlan->refcount);
 
 	atomic_set(&vlan->ap_isolation, 0);
 
@@ -588,7 +601,7 @@ static void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
 			       vlan->vid, "vlan interface destroyed", false);
 
 	batadv_sysfs_del_vlan(bat_priv, vlan);
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
 }
 
 /**
@@ -633,7 +646,7 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 	if (!vlan->kobj) {
 		ret = batadv_sysfs_add_vlan(bat_priv->soft_iface, vlan);
 		if (ret) {
-			batadv_softif_vlan_free_ref(vlan);
+			batadv_softif_vlan_put(vlan);
 			return ret;
 		}
 	}
@@ -680,7 +693,7 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 	batadv_softif_destroy_vlan(bat_priv, vlan);
 
 	/* finally free the vlan object */
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
 
 	return 0;
 }
@@ -736,7 +749,7 @@ static void batadv_softif_destroy_finish(struct work_struct *work)
 	vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
 	if (vlan) {
 		batadv_softif_destroy_vlan(bat_priv, vlan);
-		batadv_softif_vlan_free_ref(vlan);
+		batadv_softif_vlan_put(vlan);
 	}
 
 	batadv_sysfs_del_meshif(soft_iface);
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 8e82176..3fc7392 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -34,7 +34,7 @@ void batadv_softif_destroy_sysfs(struct net_device *soft_iface);
 int batadv_softif_is_valid(const struct net_device *net_dev);
 extern struct rtnl_link_ops batadv_link_ops;
 int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid);
-void batadv_softif_vlan_free_ref(struct batadv_softif_vlan *softif_vlan);
+void batadv_softif_vlan_put(struct batadv_softif_vlan *softif_vlan);
 struct batadv_softif_vlan *batadv_softif_vlan_get(struct batadv_priv *bat_priv,
 						  unsigned short vid);
 
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index f38d7b7..63a86c2 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -25,6 +25,7 @@
 #include <linux/fs.h>
 #include <linux/if.h>
 #include <linux/if_vlan.h>
+#include <linux/kref.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
@@ -97,7 +98,7 @@ batadv_kobj_to_vlan(struct batadv_priv *bat_priv, struct kobject *obj)
 		if (vlan_tmp->kobj != obj)
 			continue;
 
-		if (!atomic_inc_not_zero(&vlan_tmp->refcount))
+		if (!kref_get_unless_zero(&vlan_tmp->refcount))
 			continue;
 
 		vlan = vlan_tmp;
@@ -215,7 +216,7 @@ ssize_t batadv_store_vlan_##_name(struct kobject *kobj,			\
 					      attr, &vlan->_name,	\
 					      bat_priv->soft_iface);	\
 									\
-	batadv_softif_vlan_free_ref(vlan);				\
+	batadv_softif_vlan_put(vlan);					\
 	return res;							\
 }
 
@@ -230,7 +231,7 @@ ssize_t batadv_show_vlan_##_name(struct kobject *kobj,			\
 			     atomic_read(&vlan->_name) == 0 ?		\
 			     "disabled" : "enabled");			\
 									\
-	batadv_softif_vlan_free_ref(vlan);				\
+	batadv_softif_vlan_put(vlan);					\
 	return res;							\
 }
 
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 1ca8831..3cac667 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -280,7 +280,7 @@ static void batadv_tt_local_size_mod(struct batadv_priv *bat_priv,
 
 	atomic_add(v, &vlan->tt.num_entries);
 
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
 }
 
 /**
@@ -646,7 +646,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 	if (unlikely(hash_added != 0)) {
 		/* remove the reference for the hash */
 		batadv_tt_local_entry_free_ref(tt_local);
-		batadv_softif_vlan_free_ref(vlan);
+		batadv_softif_vlan_put(vlan);
 		goto out;
 	}
 
@@ -1012,7 +1012,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 				   no_purge ? 0 : last_seen_msecs,
 				   vlan->tt.crc);
 
-			batadv_softif_vlan_free_ref(vlan);
+			batadv_softif_vlan_put(vlan);
 		}
 		rcu_read_unlock();
 	}
@@ -1102,8 +1102,8 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!vlan)
 		goto out;
 
-	batadv_softif_vlan_free_ref(vlan);
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
+	batadv_softif_vlan_put(vlan);
 
 out:
 	if (tt_local_entry)
@@ -1203,8 +1203,8 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 			vlan = batadv_softif_vlan_get(bat_priv,
 						      tt_common_entry->vid);
 			if (vlan) {
-				batadv_softif_vlan_free_ref(vlan);
-				batadv_softif_vlan_free_ref(vlan);
+				batadv_softif_vlan_put(vlan);
+				batadv_softif_vlan_put(vlan);
 			}
 
 			batadv_tt_local_entry_free_ref(tt_local);
@@ -3298,8 +3298,8 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 			/* decrease the reference held for this vlan */
 			vlan = batadv_softif_vlan_get(bat_priv, tt_common->vid);
 			if (vlan) {
-				batadv_softif_vlan_free_ref(vlan);
-				batadv_softif_vlan_free_ref(vlan);
+				batadv_softif_vlan_put(vlan);
+				batadv_softif_vlan_put(vlan);
 			}
 
 			batadv_tt_local_entry_free_ref(tt_local);
@@ -3385,7 +3385,7 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 	ret = true;
 
 out:
-	batadv_softif_vlan_free_ref(vlan);
+	batadv_softif_vlan_put(vlan);
 	if (tt_global_entry)
 		batadv_tt_global_entry_free_ref(tt_global_entry);
 	if (tt_local_entry)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0b3cbdb..c6c3f0f 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -746,7 +746,7 @@ struct batadv_softif_vlan {
 	atomic_t ap_isolation;		/* boolean */
 	struct batadv_vlan_tt tt;
 	struct hlist_node list;
-	atomic_t refcount;
+	struct kref refcount;
 	struct rcu_head rcu;
 };
 
-- 
2.6.4

