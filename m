Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 23 Apr 2013 16:34:36 +0200
Message-Id: <1366727676-23233-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1366727676-23233-1-git-send-email-ordex@autistici.org>
References: <1366727676-23233-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 7/7] batman-adv: make the AP isolation
	attribute VLAN specific
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

AP isolation has to be enabled on one VLAN interface only.
This patch moves the AP isolation attribute to the per-vlan
interface attribute set, enabling it to have a different
value depending on the selected vlan.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 soft-interface.c    |  12 ++++-
 sysfs.c             | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 sysfs.h             |  10 ++++
 translation-table.c |  24 ++++++---
 translation-table.h |   2 +-
 types.h             |   2 +
 6 files changed, 182 insertions(+), 8 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 986e8e5..5104a8a 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
+#include <linux/netdevice.h>
 #include <linux/if_vlan.h>
 #include "bridge_loop_avoidance.h"
 #include "network-coding.h"
@@ -361,7 +362,8 @@ void batadv_interface_rx(struct net_device *soft_iface,
 		batadv_tt_add_temporary_global_entry(bat_priv, orig_node,
 						     ethhdr->h_source, vid);
 
-	if (batadv_is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest))
+	if (batadv_is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest,
+				  vid))
 		goto dropped;
 
 	netif_rx(skb);
@@ -385,6 +387,7 @@ static int batadv_add_vid(struct net_device *dev, unsigned short vid)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
 	struct batadv_priv_vlan *vlan;
+	int err;
 
 	vlan = kmalloc(sizeof(*vlan), GFP_ATOMIC);
 	if (!vlan)
@@ -398,6 +401,11 @@ static int batadv_add_vid(struct net_device *dev, unsigned short vid)
 	 */
 	batadv_tt_local_add(dev, dev->dev_addr, vid | BATADV_VLAN_HAS_TAG,
 			    BATADV_NULL_IFINDEX);
+	atomic_set(&vlan->ap_isolation, 0);
+
+	err = batadv_sysfs_add_vlan(dev, vlan);
+	if (err)
+		return err;
 
 	spin_lock_bh(&bat_priv->priv_vlan_list_lock);
 	list_add_rcu(&vlan->list, &bat_priv->priv_vlan_list);
@@ -430,6 +438,8 @@ static int batadv_kill_vid(struct net_device *dev, unsigned short vid)
 	list_del_rcu(&vlan->list);
 	spin_unlock_bh(&bat_priv->priv_vlan_list_lock);
 
+	batadv_sysfs_del_vlan(bat_priv, vlan);
+
 	/* explicitly remove the associated TT local entry because it is marked
 	 * with the NOPURGE flag
 	 */
diff --git a/sysfs.c b/sysfs.c
index 88f3c73..e554f70 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -39,6 +39,31 @@ static struct batadv_priv *batadv_kobj_to_batpriv(struct kobject *obj)
 	return netdev_priv(net_dev);
 }
 
+/**
+ * batadv_kobj_to_vlan - convert a kobj in the associated priv_vlan struct
+ * @obj: kobject to covert
+ *
+ * Return the associated priv_vlan struct if cound, NULL otherwise
+ */
+static struct batadv_priv_vlan *batadv_kobj_to_vlan(struct kobject *obj)
+{
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(obj->parent);
+	struct batadv_priv_vlan *vlan, *vlan_tmp = NULL;
+
+	list_for_each_entry_rcu(vlan, &bat_priv->priv_vlan_list, list) {
+		if (vlan->kobj != obj)
+			continue;
+
+		if (!atomic_inc_not_zero(&vlan->refcount))
+			continue;
+
+		vlan_tmp = vlan;
+		break;
+	}
+
+	return vlan_tmp;
+}
+
 #define BATADV_UEV_TYPE_VAR	"BATTYPE="
 #define BATADV_UEV_ACTION_VAR	"BATACTION="
 #define BATADV_UEV_DATA_VAR	"BATDATA="
@@ -53,6 +78,15 @@ static char *batadv_uev_type_str[] = {
 	"gw"
 };
 
+/* Use this, if you have customized show and store functions for vlan attrs */
+#define BATADV_ATTR_VLAN(_name, _mode, _show, _store)	\
+struct batadv_attribute batadv_attr_vlan_##_name = {	\
+	.attr = {.name = __stringify(_name),		\
+		 .mode = _mode },			\
+	.show   = _show,				\
+	.store  = _store,				\
+};
+
 /* Use this, if you have customized show and store functions */
 #define BATADV_ATTR(_name, _mode, _show, _store)	\
 struct batadv_attribute batadv_attr_##_name = {		\
@@ -122,6 +156,38 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 	static BATADV_ATTR(_name, _mode, batadv_show_##_name,		\
 			   batadv_store_##_name)
 
+#define BATADV_ATTR_VLAN_STORE_BOOL(_name, _post_func)			\
+ssize_t batadv_store_vlan_##_name(struct kobject *kobj,			\
+				  struct attribute *attr, char *buff,	\
+				  size_t count)				\
+{									\
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj->parent);\
+	struct batadv_priv_vlan *vlan = batadv_kobj_to_vlan(kobj);	\
+	size_t res = __batadv_store_bool_attr(buff, count, _post_func, attr,\
+					      &vlan->_name,		\
+					      bat_priv->soft_iface);	\
+	batadv_priv_vlan_free_ref(vlan);				\
+	return res;							\
+}
+
+#define BATADV_ATTR_VLAN_SHOW_BOOL(_name)				\
+ssize_t batadv_show_vlan_##_name(struct kobject *kobj,			\
+			    struct attribute *attr, char *buff)		\
+{									\
+	struct batadv_priv_vlan *vlan = batadv_kobj_to_vlan(kobj);	\
+	size_t res =  sprintf(buff, "%s\n",				\
+			      atomic_read(&vlan->_name) == 0 ?		\
+			      "disabled" : "enabled");			\
+	batadv_priv_vlan_free_ref(vlan);				\
+	return res;							\
+}
+
+/* Use this, if you are going to turn a [name] in the vlan struct on or off */
+#define BATADV_ATTR_VLAN_BOOL(_name, _mode, _post_func)			\
+	static BATADV_ATTR_VLAN_STORE_BOOL(_name, _post_func)		\
+	static BATADV_ATTR_VLAN_SHOW_BOOL(_name)			\
+	static BATADV_ATTR_VLAN(_name, _mode, batadv_show_vlan_##_name,	\
+				batadv_store_vlan_##_name)
 
 static int batadv_store_bool_attr(char *buff, size_t count,
 				  struct net_device *net_dev,
@@ -405,6 +471,17 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 	NULL,
 };
 
+/* vlan attributes below */
+BATADV_ATTR_VLAN_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
+
+/**
+ * batadv_vlan_attrs - array of vlan specific sysfs attributes
+ */
+static struct batadv_attribute *batadv_vlan_attrs[] = {
+	&batadv_attr_vlan_ap_isolation,
+	NULL,
+};
+
 int batadv_sysfs_add_meshif(struct net_device *dev)
 {
 	struct kobject *batif_kobject = &dev->dev.kobj;
@@ -455,6 +532,69 @@ void batadv_sysfs_del_meshif(struct net_device *dev)
 	bat_priv->mesh_obj = NULL;
 }
 
+/**
+ * batadv_sysfs_add_vlan - add all the needed sysfs objects for the new vlan
+ * @dev: netdev of the mesh interface
+ * @vlan: private data of the newly added VLAN interface
+ *
+ * Return 0 on success and -ENOMEM if any of the structure allocations fails
+ */
+int batadv_sysfs_add_vlan(struct net_device *dev, struct batadv_priv_vlan *vlan)
+{
+	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct batadv_attribute **bat_attr;
+	char vlan_subdir[256];
+	int err;
+
+	sprintf(vlan_subdir, BATADV_SYSFS_VLAN_SUBDIR_PREFIX "%u", vlan->vid);
+
+	vlan->kobj = kobject_create_and_add(vlan_subdir, bat_priv->mesh_obj);
+	if (!vlan->kobj) {
+		batadv_err(dev, "Can't add sysfs directory: %s/%s\n", dev->name,
+			   vlan_subdir);
+		goto out;
+	}
+
+	for (bat_attr = batadv_vlan_attrs; *bat_attr; ++bat_attr) {
+		err = sysfs_create_file(vlan->kobj,
+					&((*bat_attr)->attr));
+		if (err) {
+			batadv_err(dev, "Can't add sysfs file: %s/%s/%s\n",
+				   dev->name, vlan_subdir,
+				   ((*bat_attr)->attr).name);
+			goto rem_attr;
+		}
+	}
+
+	return 0;
+
+rem_attr:
+	for (bat_attr = batadv_vlan_attrs; *bat_attr; ++bat_attr)
+		sysfs_remove_file(vlan->kobj, &((*bat_attr)->attr));
+
+	kobject_put(vlan->kobj);
+	vlan->kobj = NULL;
+out:
+	return -ENOMEM;
+}
+
+/**
+ * batadv_sysfs_del_vlan - remove all the sysfs objects for a given VLAN
+ * @bat_priv: the bat priv with all the soft interface information
+ * @vlan: the private data of the VLAN to destroy
+ */
+void batadv_sysfs_del_vlan(struct batadv_priv *bat_priv,
+			   struct batadv_priv_vlan *vlan)
+{
+	struct batadv_attribute **bat_attr;
+
+	for (bat_attr = batadv_vlan_attrs; *bat_attr; ++bat_attr)
+		sysfs_remove_file(vlan->kobj, &((*bat_attr)->attr));
+
+	kobject_put(vlan->kobj);
+	vlan->kobj = NULL;
+}
+
 static ssize_t batadv_show_mesh_iface(struct kobject *kobj,
 				      struct attribute *attr, char *buff)
 {
diff --git a/sysfs.h b/sysfs.h
index 479acf4..d105e4b 100644
--- a/sysfs.h
+++ b/sysfs.h
@@ -22,6 +22,12 @@
 
 #define BATADV_SYSFS_IF_MESH_SUBDIR "mesh"
 #define BATADV_SYSFS_IF_BAT_SUBDIR "batman_adv"
+/**
+ * BATADV_SYSFS_VLAN_SUBDIR_PREFIX - prefix of the subfolder that will be
+ *  created in the sysfs hierarchy for each VLAN interface. The subfolder will
+ *  be named "BATADV_SYSFS_VLAN_SUBDIR_PREFIX%vid"
+ */
+#define BATADV_SYSFS_VLAN_SUBDIR_PREFIX "vlan"
 
 struct batadv_attribute {
 	struct attribute attr;
@@ -36,6 +42,10 @@ void batadv_sysfs_del_meshif(struct net_device *dev);
 int batadv_sysfs_add_hardif(struct kobject **hardif_obj,
 			    struct net_device *dev);
 void batadv_sysfs_del_hardif(struct kobject **hardif_obj);
+int batadv_sysfs_add_vlan(struct net_device *dev,
+			  struct batadv_priv_vlan *vlan);
+void batadv_sysfs_del_vlan(struct batadv_priv *bat_priv,
+			   struct batadv_priv_vlan *vlan);
 int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 			enum batadv_uev_action action, const char *data);
 
diff --git a/translation-table.c b/translation-table.c
index fc4d10e..87c4a44 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1468,12 +1468,26 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 						  const uint8_t *addr,
 						  unsigned short vid)
 {
+	bool ap_isolation_enabled = atomic_read(&bat_priv->ap_isolation);
 	struct batadv_tt_local_entry *tt_local_entry = NULL;
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tt_orig_list_entry *best_entry;
+	struct batadv_priv_vlan *vlan;
 
-	if (src && atomic_read(&bat_priv->ap_isolation)) {
+	/* if the AP isolation is requested on a VLAN, then check for the
+	 * its setting in the proper VLAN private data structure
+	 */
+	if (vid & BATADV_VLAN_HAS_TAG) {
+		ap_isolation_enabled = false;
+		vlan = batadv_get_priv_vlan(bat_priv, vid);
+		if (vlan) {
+			ap_isolation_enabled = atomic_read(&vlan->ap_isolation);
+			batadv_priv_vlan_free_ref(vlan);
+		}
+	}
+
+	if (src && ap_isolation_enabled) {
 		tt_local_entry = batadv_tt_local_hash_find(bat_priv, src, vid);
 		if (!tt_local_entry ||
 		    (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING))
@@ -2515,7 +2529,7 @@ void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv)
 }
 
 bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, uint8_t *src,
-			   uint8_t *dst)
+			   uint8_t *dst, unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry = NULL;
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
@@ -2524,13 +2538,11 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, uint8_t *src,
 	if (!atomic_read(&bat_priv->ap_isolation))
 		goto out;
 
-	tt_local_entry = batadv_tt_local_hash_find(bat_priv, dst,
-						   BATADV_NO_FLAGS);
+	tt_local_entry = batadv_tt_local_hash_find(bat_priv, dst, vid);
 	if (!tt_local_entry)
 		goto out;
 
-	tt_global_entry = batadv_tt_global_hash_find(bat_priv, src,
-						     BATADV_NO_FLAGS);
+	tt_global_entry = batadv_tt_global_hash_find(bat_priv, src, vid);
 	if (!tt_global_entry)
 		goto out;
 
diff --git a/translation-table.h b/translation-table.h
index 1944ba5..e86df9b 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -46,7 +46,7 @@ void batadv_tt_free(struct batadv_priv *bat_priv);
 bool batadv_is_my_client(struct batadv_priv *bat_priv, const uint8_t *addr,
 			 unsigned short vid);
 bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, uint8_t *src,
-			   uint8_t *dst);
+			   uint8_t *dst, unsigned short vid);
 void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv);
 bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 					uint8_t *addr, unsigned short vid);
diff --git a/types.h b/types.h
index 956d66b..8329202 100644
--- a/types.h
+++ b/types.h
@@ -530,6 +530,7 @@ struct batadv_priv_nc {
  * struct batadv_priv_vlan - per VLAN attributes set
  * @vid: VLAN identifier
  * @kobj: kobject for sysfs vlan subdirectory
+ * @ap_isolation: AP isolation state
  * @list: list node for bat_priv::priv_vlan_list
  * @refcount: number of context where this object is currently in use
  * @rcu: struct used for freeing in a RCU-safe manner
@@ -537,6 +538,7 @@ struct batadv_priv_nc {
 struct batadv_priv_vlan {
 	unsigned short vid;
 	struct kobject *kobj;
+	atomic_t ap_isolation;		/* boolean */
 	struct list_head list;
 	atomic_t refcount;
 	struct rcu_head rcu;
-- 
1.8.1.5

