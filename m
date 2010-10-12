Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 13 Oct 2010 00:22:05 +0200
Message-Id: <1286922125-18097-5-git-send-email-linus.luessing@web.de>
In-Reply-To: <1286922125-18097-1-git-send-email-linus.luessing@web.de>
References: <1286922125-18097-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: Ommit storing struct device
	in sysfs functions
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

We actually do not need an extra struct device variable, therefore
replacing them with defines that directly get the bat_priv or
net_device. This further reduces the code size in bat_sysfs.c and
especially shortens some macros.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 bat_sysfs.c |   40 ++++++++++++++--------------------------
 1 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 0d58e9c..c20af1f 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -29,7 +29,9 @@
 #include "vis.h"
 #include "compat.h"
 
-#define to_dev(obj)     container_of(obj, struct device, kobj)
+#define to_dev(obj)		container_of(obj, struct device, kobj)
+#define kobj_to_netdev(obj)	to_net_dev(to_dev(obj->parent))
+#define kobj_to_batpriv(obj)	netdev_priv(kobj_to_netdev(obj))
 
 /* Use this, if you have customized show and store functions */
 #define BAT_ATTR(_name, _mode, _show, _store)	\
@@ -44,8 +46,7 @@ struct bat_attribute bat_attr_##_name = {	\
 ssize_t store_##_name(struct kobject *kobj, struct attribute *attr, \
 		      char *buff, size_t count)				\
 {									\
-	struct device *dev = to_dev(kobj->parent);			\
-	struct net_device *net_dev = to_net_dev(dev);			\
+	struct net_device *net_dev = kobj_to_netdev(kobj);		\
 	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
 	return __store_bool_attr(buff, count, _post_func, attr,		\
 				 &bat_priv->_name, net_dev);	\
@@ -55,9 +56,7 @@ ssize_t store_##_name(struct kobject *kobj, struct attribute *attr, \
 ssize_t show_##_name(struct kobject *kobj, struct attribute *attr, 	\
 			    char *buff)					\
 {									\
-	struct device *dev = to_dev(kobj->parent);			\
-	struct net_device *net_dev = to_net_dev(dev);			\
-	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	struct bat_priv *bat_priv = kobj_to_batpriv(kobj);		\
 	return sprintf(buff, "%s\n",					\
 		       atomic_read(&bat_priv->_name) == 0 ?	\
 		       "disabled" : "enabled");				\
@@ -74,8 +73,7 @@ ssize_t show_##_name(struct kobject *kobj, struct attribute *attr, 	\
 ssize_t store_##_name(struct kobject *kobj, struct attribute *attr, \
 			     char *buff, size_t count)			\
 {									\
-	struct device *dev = to_dev(kobj->parent);			\
-	struct net_device *net_dev = to_net_dev(dev);			\
+	struct net_device *net_dev = kobj_to_netdev(kobj);		\
 	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
 	return __store_uint_attr(buff, count, _min, _max, _post_func,	\
 				 attr, &bat_priv->_name, net_dev);	\
@@ -85,9 +83,7 @@ ssize_t store_##_name(struct kobject *kobj, struct attribute *attr, \
 ssize_t show_##_name(struct kobject *kobj, struct attribute *attr, \
 			    char *buff)					\
 {									\
-	struct device *dev = to_dev(kobj->parent);			\
-	struct net_device *net_dev = to_net_dev(dev);			\
-	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	struct bat_priv *bat_priv = kobj_to_batpriv(kobj);		\
 	return sprintf(buff, "%i\n", atomic_read(&bat_priv->_name));	\
 }									\
 
@@ -207,8 +203,7 @@ inline static ssize_t __store_uint_attr(char *buff, size_t count,
 static ssize_t show_vis_mode(struct kobject *kobj, struct attribute *attr,
 			     char *buff)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+	struct bat_priv *bat_priv = kobj_to_batpriv(kobj);
 	int vis_mode = atomic_read(&bat_priv->vis_mode);
 
 	return sprintf(buff, "%s\n",
@@ -219,8 +214,7 @@ static ssize_t show_vis_mode(struct kobject *kobj, struct attribute *attr,
 static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
 			      char *buff, size_t count)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
+	struct net_device *net_dev = kobj_to_netdev(kobj);
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	unsigned long val;
 	int ret, vis_mode_tmp = -1;
@@ -261,8 +255,7 @@ static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
 static ssize_t show_gw_mode(struct kobject *kobj, struct attribute *attr,
 			    char *buff)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+	struct bat_priv *bat_priv = kobj_to_batpriv(kobj);
 	int down, up, bytes_written;
 	int gw_mode = atomic_read(&bat_priv->gw_mode);
 	int gw_class = atomic_read(&bat_priv->gw_class);
@@ -295,9 +288,7 @@ static ssize_t show_gw_mode(struct kobject *kobj, struct attribute *attr,
 static ssize_t store_gw_mode(struct kobject *kobj, struct attribute *attr,
 			      char *buff, size_t count)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-
+	struct net_device *net_dev = kobj_to_netdev(kobj);
 	return gw_mode_set(net_dev, buff, count);
 }
 
@@ -377,8 +368,7 @@ void sysfs_del_meshif(struct net_device *dev)
 static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 			       char *buff)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
+	struct net_device *net_dev = kobj_to_netdev(kobj);
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
 	ssize_t length;
 
@@ -396,8 +386,7 @@ static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 				char *buff, size_t count)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
+	struct net_device *net_dev = kobj_to_netdev(kobj);
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
 	int status_tmp = -1;
 	int ret;
@@ -450,8 +439,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
 				 char *buff)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
+	struct net_device *net_dev = kobj_to_netdev(kobj);
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
 	ssize_t length;
 
-- 
1.7.1

