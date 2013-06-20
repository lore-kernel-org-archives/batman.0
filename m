Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 20 Jun 2013 15:00:27 +0200
Message-Id: <1371733228-3295-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1371733228-3295-1-git-send-email-ordex@autistici.org>
References: <1371733228-3295-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv7 2/3] batman-adv: add sysfs framework for
	VLAN
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

Each VLAN can now have its own set of attributes.
Export them through a new subfolder in the sysfs tree.
Each VLAN created on top of a soft_iface will have its own
subfolder.

The subfolder is named "vlan%VID" and it is created inside
the "mesh" sysfs folder belonging to batman-adv.

Attributes corresponding to the untagged LAN are stored in
the root sysfs folder as before.

Create all the needed macros and data structures to easily
handle new VLAN spacific attributes.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 soft-interface.c |   7 +++
 sysfs.c          | 155 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sysfs.h          |  10 ++++
 3 files changed, 172 insertions(+)

diff --git a/soft-interface.c b/soft-interface.c
index 1f17383..2d1ea48 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -434,6 +434,7 @@ batadv_softif_vlan_get(struct batadv_priv *bat_priv, unsigned short vid)
 int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 {
 	struct batadv_softif_vlan *vlan;
+	int err;
 
 	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
 	if (!vlan)
@@ -449,6 +450,10 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 			    bat_priv->soft_iface->dev_addr, vid,
 			    BATADV_NULL_IFINDEX);
 
+	err = batadv_sysfs_add_vlan(bat_priv->soft_iface, vlan);
+	if (err)
+		return err;
+
 	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
 	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
 	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
@@ -463,6 +468,8 @@ static void batadv_softif_destroy_vlan(struct batadv_priv *bat_priv,
 	hlist_del_rcu(&vlan->list);
 	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
 
+	batadv_sysfs_del_vlan(bat_priv, vlan);
+
 	/* explicitly remove the associated TT local entry because it is marked
 	 * with the NOPURGE flag
 	 */
diff --git a/sysfs.c b/sysfs.c
index b70ae52..6a04fb3 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -39,6 +39,41 @@ static struct batadv_priv *batadv_kobj_to_batpriv(struct kobject *obj)
 	return netdev_priv(net_dev);
 }
 
+/**
+ * batadv_kobj_to_vlan - convert a kobj in the associated softif_vlan struct
+ * @obj: kobject to covert
+ *
+ * Return the associated softif_vlan struct if cound, NULL otherwise
+ */
+static struct batadv_softif_vlan *batadv_kobj_to_vlan(struct kobject *obj)
+{
+	struct batadv_softif_vlan *vlan;
+	struct batadv_priv *bat_priv;
+
+	/* VLAN specific attributes are located in the root sysfs folder if they
+	 * refer to the untagged VLAN..
+	 */
+	if (!strcmp(BATADV_SYSFS_IF_MESH_SUBDIR, obj->name))
+		bat_priv = batadv_kobj_to_batpriv(obj);
+	else
+		/* ..while the attributed for the tagged vlans are located in
+		 * the in the corresponding "vlan%VID" subfolder
+		 */
+		bat_priv = batadv_kobj_to_batpriv(obj->parent);
+
+	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+		if (vlan->kobj != obj)
+			continue;
+
+		if (!atomic_inc_not_zero(&vlan->refcount))
+			continue;
+
+		return vlan;
+	}
+
+	return NULL;
+}
+
 #define BATADV_UEV_TYPE_VAR	"BATTYPE="
 #define BATADV_UEV_ACTION_VAR	"BATACTION="
 #define BATADV_UEV_DATA_VAR	"BATDATA="
@@ -53,6 +88,15 @@ static char *batadv_uev_type_str[] = {
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
@@ -122,6 +166,38 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 	static BATADV_ATTR(_name, _mode, batadv_show_##_name,		\
 			   batadv_store_##_name)
 
+#define BATADV_ATTR_VLAN_STORE_BOOL(_name, _post_func)			\
+ssize_t batadv_store_vlan_##_name(struct kobject *kobj,			\
+				  struct attribute *attr, char *buff,	\
+				  size_t count)				\
+{									\
+	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj->parent);\
+	struct batadv_softif_vlan *vlan = batadv_kobj_to_vlan(kobj);	\
+	size_t res = __batadv_store_bool_attr(buff, count, _post_func, attr,\
+					      &vlan->_name,		\
+					      bat_priv->soft_iface);	\
+	batadv_softif_vlan_free_ref(vlan);				\
+	return res;							\
+}
+
+#define BATADV_ATTR_VLAN_SHOW_BOOL(_name)				\
+ssize_t batadv_show_vlan_##_name(struct kobject *kobj,			\
+			    struct attribute *attr, char *buff)		\
+{									\
+	struct batadv_softif_vlan *vlan = batadv_kobj_to_vlan(kobj);	\
+	size_t res = sprintf(buff, "%s\n",				\
+			     atomic_read(&vlan->_name) == 0 ?		\
+			     "disabled" : "enabled");			\
+	batadv_softif_vlan_free_ref(vlan);				\
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
@@ -403,6 +479,13 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 	NULL,
 };
 
+/**
+ * batadv_vlan_attrs - array of vlan specific sysfs attributes
+ */
+static struct batadv_attribute *batadv_vlan_attrs[] = {
+	NULL,
+};
+
 int batadv_sysfs_add_meshif(struct net_device *dev)
 {
 	struct kobject *batif_kobject = &dev->dev.kobj;
@@ -453,6 +536,78 @@ void batadv_sysfs_del_meshif(struct net_device *dev)
 	bat_priv->mesh_obj = NULL;
 }
 
+/**
+ * batadv_sysfs_add_vlan - add all the needed sysfs objects for the new vlan
+ * @dev: netdev of the mesh interface
+ * @vlan: private data of the newly added VLAN interface
+ *
+ * Return 0 on success and -ENOMEM if any of the structure allocations fails
+ */
+int batadv_sysfs_add_vlan(struct net_device *dev,
+			  struct batadv_softif_vlan *vlan)
+{
+	char vlan_subdir[sizeof(BATADV_SYSFS_VLAN_SUBDIR_PREFIX) + 4];
+	struct batadv_priv *bat_priv = netdev_priv(dev);
+	struct batadv_attribute **bat_attr;
+	int err;
+
+	if (vlan->vid & BATADV_VLAN_HAS_TAG) {
+		sprintf(vlan_subdir, BATADV_SYSFS_VLAN_SUBDIR_PREFIX "%u",
+			vlan->vid & VLAN_VID_MASK);
+
+		vlan->kobj = kobject_create_and_add(vlan_subdir, bat_priv->mesh_obj);
+		if (!vlan->kobj) {
+			batadv_err(dev, "Can't add sysfs directory: %s/%s\n",
+				   dev->name, vlan_subdir);
+			goto out;
+		}
+	} else {
+		/* the untagged LAN uses the root folder to store its "VLAN
+		 * specific attributes"
+		 */
+		vlan->kobj = bat_priv->mesh_obj;
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
+			   struct batadv_softif_vlan *vlan)
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
index 479acf4..c4f96c1 100644
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
+			  struct batadv_softif_vlan *vlan);
+void batadv_sysfs_del_vlan(struct batadv_priv *bat_priv,
+			   struct batadv_softif_vlan *vlan);
 int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 			enum batadv_uev_action action, const char *data);
 
-- 
1.8.1.5

