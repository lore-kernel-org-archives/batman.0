Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:54 +0100
Message-Id: <1290383767-32602-17-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 16/29] Staging: batman-adv: Ommit storing
	struct device in sysfs functions
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

From: Linus Lüssing <linus.luessing@web.de>

We actually do not need an extra struct device variable, therefore
replacing them with defines that directly get the bat_priv or
net_device. This further reduces the code size in bat_sysfs.c and
especially shortens some macros.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/bat_sysfs.c |   33 +++++++++++--------------------
 1 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index 19be531..9bec60d 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -26,7 +26,9 @@
 #include "hard-interface.h"
 #include "vis.h"
 
-#define to_dev(obj)     container_of(obj, struct device, kobj)
+#define to_dev(obj)		container_of(obj, struct device, kobj)
+#define kobj_to_netdev(obj)	to_net_dev(to_dev(obj->parent))
+#define kobj_to_batpriv(obj)	netdev_priv(kobj_to_netdev(obj))
 
 /* Use this, if you have customized show and store functions */
 #define BAT_ATTR(_name, _mode, _show, _store)	\
@@ -41,8 +43,7 @@ struct bat_attribute bat_attr_##_name = {	\
 ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
 		      char *buff, size_t count)				\
 {									\
-	struct device *dev = to_dev(kobj->parent);			\
-	struct net_device *net_dev = to_net_dev(dev);			\
+	struct net_device *net_dev = kobj_to_netdev(kobj);		\
 	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
 	return __store_bool_attr(buff, count, _post_func, attr,		\
 				 &bat_priv->_name, net_dev);		\
@@ -52,9 +53,7 @@ ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
 ssize_t show_##_name(struct kobject *kobj, struct attribute *attr,	\
 			    char *buff)					\
 {									\
-	struct device *dev = to_dev(kobj->parent);			\
-	struct net_device *net_dev = to_net_dev(dev);			\
-	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	struct bat_priv *bat_priv = kobj_to_batpriv(kobj);		\
 	return sprintf(buff, "%s\n",					\
 		       atomic_read(&bat_priv->_name) == 0 ?		\
 		       "disabled" : "enabled");				\
@@ -71,8 +70,7 @@ ssize_t show_##_name(struct kobject *kobj, struct attribute *attr,	\
 ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
 			     char *buff, size_t count)			\
 {									\
-	struct device *dev = to_dev(kobj->parent);			\
-	struct net_device *net_dev = to_net_dev(dev);			\
+	struct net_device *net_dev = kobj_to_netdev(kobj);		\
 	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
 	return __store_uint_attr(buff, count, _min, _max, _post_func,	\
 				 attr, &bat_priv->_name, net_dev);	\
@@ -82,9 +80,7 @@ ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
 ssize_t show_##_name(struct kobject *kobj, struct attribute *attr,	\
 			    char *buff)					\
 {									\
-	struct device *dev = to_dev(kobj->parent);			\
-	struct net_device *net_dev = to_net_dev(dev);			\
-	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	struct bat_priv *bat_priv = kobj_to_batpriv(kobj);		\
 	return sprintf(buff, "%i\n", atomic_read(&bat_priv->_name));	\
 }									\
 
@@ -204,8 +200,7 @@ static inline ssize_t __store_uint_attr(char *buff, size_t count,
 static ssize_t show_vis_mode(struct kobject *kobj, struct attribute *attr,
 			     char *buff)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+	struct bat_priv *bat_priv = kobj_to_batpriv(kobj);
 	int vis_mode = atomic_read(&bat_priv->vis_mode);
 
 	return sprintf(buff, "%s\n",
@@ -216,8 +211,7 @@ static ssize_t show_vis_mode(struct kobject *kobj, struct attribute *attr,
 static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
 			      char *buff, size_t count)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
+	struct net_device *net_dev = kobj_to_netdev(kobj);
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	unsigned long val;
 	int ret, vis_mode_tmp = -1;
@@ -329,8 +323,7 @@ void sysfs_del_meshif(struct net_device *dev)
 static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 			       char *buff)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
+	struct net_device *net_dev = kobj_to_netdev(kobj);
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
 	ssize_t length;
 
@@ -348,8 +341,7 @@ static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 				char *buff, size_t count)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
+	struct net_device *net_dev = kobj_to_netdev(kobj);
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
 	int status_tmp = -1;
 	int ret;
@@ -402,8 +394,7 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 static ssize_t show_iface_status(struct kobject *kobj, struct attribute *attr,
 				 char *buff)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
+	struct net_device *net_dev = kobj_to_netdev(kobj);
 	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
 	ssize_t length;
 
-- 
1.7.2.3

