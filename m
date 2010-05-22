Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 22 May 2010 17:54:39 +0200
Message-Id: <1274543684-4919-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201005221753.54176.sven.eckelmann@gmx.de>
References: <201005221753.54176.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/6] Staging: batman-adv: remove redundant
	struct declaration
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
To: gregkh@suse.de
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

The hardif_attr and the bat_attr struct share the same attributes,
hence it is not necessary to specify 2 different structs.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/bat_sysfs.c |   48 ++++++++------------------------
 drivers/staging/batman-adv/bat_sysfs.h |   13 ++++++++
 2 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index e2c000b..065a212 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -28,22 +28,6 @@
 
 #define to_dev(obj)     container_of(obj, struct device, kobj)
 
-struct bat_attribute {
-	struct attribute attr;
-	ssize_t (*show)(struct kobject *kobj, struct attribute *attr,
-			char *buf);
-	ssize_t (*store)(struct kobject *kobj, struct attribute *attr,
-			 char *buf, size_t count);
-};
-
-struct hardif_attribute {
-	struct attribute attr;
-	ssize_t (*show)(struct kobject *kobj, struct attribute *attr,
-			char *buf);
-	ssize_t (*store)(struct kobject *kobj, struct attribute *attr,
-			 char *buf, size_t count);
-};
-
 #define BAT_ATTR(_name, _mode, _show, _store)	\
 struct bat_attribute bat_attr_##_name = {	\
 	.attr = {.name = __stringify(_name),	\
@@ -60,14 +44,6 @@ struct bin_attribute bat_attr_##_name = {		\
 	.write = _write,				\
 };
 
-#define HARDIF_ATTR(_name, _mode, _show, _store)	\
-struct hardif_attribute hardif_attr_##_name = {		\
-	.attr = {.name = __stringify(_name),		\
-		 .mode = _mode },			\
-	.show   = _show,				\
-	.store  = _store,				\
-};
-
 static ssize_t show_aggr_ogm(struct kobject *kobj, struct attribute *attr,
 			     char *buff)
 {
@@ -433,20 +409,20 @@ static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
 	}
 }
 
-static HARDIF_ATTR(mesh_iface, S_IRUGO | S_IWUSR,
-		   show_mesh_iface, store_mesh_iface);
-static HARDIF_ATTR(iface_status, S_IRUGO, show_iface_status, NULL);
+static BAT_ATTR(mesh_iface, S_IRUGO | S_IWUSR,
+		show_mesh_iface, store_mesh_iface);
+static BAT_ATTR(iface_status, S_IRUGO, show_iface_status, NULL);
 
-static struct hardif_attribute *batman_attrs[] = {
-	&hardif_attr_mesh_iface,
-	&hardif_attr_iface_status,
+static struct bat_attribute *batman_attrs[] = {
+	&bat_attr_mesh_iface,
+	&bat_attr_iface_status,
 	NULL,
 };
 
 int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
 {
 	struct kobject *hardif_kobject = &dev->dev.kobj;
-	struct hardif_attribute **hardif_attr;
+	struct bat_attribute **bat_attr;
 	int err;
 
 	*hardif_obj = kobject_create_and_add(SYSFS_IF_BAT_SUBDIR,
@@ -458,12 +434,12 @@ int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
 		goto out;
 	}
 
-	for (hardif_attr = batman_attrs; *hardif_attr; ++hardif_attr) {
-		err = sysfs_create_file(*hardif_obj, &((*hardif_attr)->attr));
+	for (bat_attr = batman_attrs; *bat_attr; ++bat_attr) {
+		err = sysfs_create_file(*hardif_obj, &((*bat_attr)->attr));
 		if (err) {
 			printk(KERN_ERR "batman-adv:Can't add sysfs file: %s/%s/%s\n",
 			       dev->name, SYSFS_IF_BAT_SUBDIR,
-			       ((*hardif_attr)->attr).name);
+			       ((*bat_attr)->attr).name);
 			goto rem_attr;
 		}
 	}
@@ -471,8 +447,8 @@ int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
 	return 0;
 
 rem_attr:
-	for (hardif_attr = batman_attrs; *hardif_attr; ++hardif_attr)
-		sysfs_remove_file(*hardif_obj, &((*hardif_attr)->attr));
+	for (bat_attr = batman_attrs; *bat_attr; ++bat_attr)
+		sysfs_remove_file(*hardif_obj, &((*bat_attr)->attr));
 out:
 	return -ENOMEM;
 }
diff --git a/drivers/staging/batman-adv/bat_sysfs.h b/drivers/staging/batman-adv/bat_sysfs.h
index e189341..cb45a91 100644
--- a/drivers/staging/batman-adv/bat_sysfs.h
+++ b/drivers/staging/batman-adv/bat_sysfs.h
@@ -20,10 +20,23 @@
  */
 
 
+#ifndef BAT_SYSFS_H
+#define BAT_SYSFS_H
+
 #define SYSFS_IF_MESH_SUBDIR "mesh"
 #define SYSFS_IF_BAT_SUBDIR "batman_adv"
 
+struct bat_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct kobject *kobj, struct attribute *attr,
+			char *buf);
+	ssize_t (*store)(struct kobject *kobj, struct attribute *attr,
+			 char *buf, size_t count);
+};
+
 int sysfs_add_meshif(struct net_device *dev);
 void sysfs_del_meshif(struct net_device *dev);
 int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev);
 void sysfs_del_hardif(struct kobject **hardif_obj);
+
+#endif
-- 
1.7.1

