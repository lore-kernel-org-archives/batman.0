Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 17 Oct 2010 19:31:04 +0200
Message-Id: <1287336664-4329-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <201010160411.08260.sven.eckelmann@gmx.de>
References: <201010160411.08260.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: Introduce generic
	BAT_ATTR_* macros
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

This makes exposing bat_priv's atomic_ts storing boolean or uint values
possible with only two additional lines of code in the future. It also
further reduces the amount of duplicate code in bat_sysfs.c.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 bat_sysfs.c |  205 ++++++++++++++++++++++++++---------------------------------
 1 files changed, 89 insertions(+), 116 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 6a60561..7efe1dd 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -31,6 +31,7 @@
 
 #define to_dev(obj)     container_of(obj, struct device, kobj)
 
+/* Use this, if you have customized show and store functions */
 #define BAT_ATTR(_name, _mode, _show, _store)	\
 struct bat_attribute bat_attr_##_name = {	\
 	.attr = {.name = __stringify(_name),	\
@@ -39,6 +40,65 @@ struct bat_attribute bat_attr_##_name = {	\
 	.store  = _store,			\
 };
 
+#define BAT_ATTR_STORE_BOOL(_name, _post_func)			\
+ssize_t store_##_name(struct kobject *kobj, struct attribute *attr, \
+		      char *buff, size_t count)				\
+{									\
+	struct device *dev = to_dev(kobj->parent);			\
+	struct net_device *net_dev = to_net_dev(dev);			\
+	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	return __store_bool_attr(buff, count, _post_func, attr,		\
+				 &bat_priv->_name, net_dev);	\
+}
+
+#define BAT_ATTR_SHOW_BOOL(_name)					\
+ssize_t show_##_name(struct kobject *kobj, struct attribute *attr,	\
+			    char *buff)					\
+{									\
+	struct device *dev = to_dev(kobj->parent);			\
+	struct net_device *net_dev = to_net_dev(dev);			\
+	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	return sprintf(buff, "%s\n",					\
+		       atomic_read(&bat_priv->_name) == 0 ?	\
+		       "disabled" : "enabled");				\
+}									\
+
+/* Use this, if you are going to turn a [name] in bat_priv on or off */
+#define BAT_ATTR_BOOL(_name, _mode, _post_func)				\
+	static BAT_ATTR_STORE_BOOL(_name, _post_func)			\
+	static BAT_ATTR_SHOW_BOOL(_name)				\
+	static BAT_ATTR(_name, _mode, show_##_name, store_##_name)
+
+
+#define BAT_ATTR_STORE_UINT(_name, _min, _max, _post_func)		\
+ssize_t store_##_name(struct kobject *kobj, struct attribute *attr, \
+			     char *buff, size_t count)			\
+{									\
+	struct device *dev = to_dev(kobj->parent);			\
+	struct net_device *net_dev = to_net_dev(dev);			\
+	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	return __store_uint_attr(buff, count, _min, _max, _post_func,	\
+				 attr, &bat_priv->_name, net_dev);	\
+}
+
+#define BAT_ATTR_SHOW_UINT(_name)					\
+ssize_t show_##_name(struct kobject *kobj, struct attribute *attr, \
+			    char *buff)					\
+{									\
+	struct device *dev = to_dev(kobj->parent);			\
+	struct net_device *net_dev = to_net_dev(dev);			\
+	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	return sprintf(buff, "%i\n", atomic_read(&bat_priv->_name));	\
+}									\
+
+/* Use this, if you are going to set [name] in bat_priv to unsigned integer
+ * values only */
+#define BAT_ATTR_UINT(_name, _mode, _min, _max, _post_func)		\
+	static BAT_ATTR_STORE_UINT(_name, _min, _max, _post_func)	\
+	static BAT_ATTR_SHOW_UINT(_name)				\
+	static BAT_ATTR(_name, _mode, show_##_name, store_##_name)
+
+
 static int store_bool_attr(char *buff, size_t count,
 			   struct net_device *net_dev,
 			   char *attr_name, atomic_t *attr)
@@ -76,6 +136,21 @@ static int store_bool_attr(char *buff, size_t count,
 	return count;
 }
 
+static inline ssize_t __store_bool_attr(char *buff, size_t count,
+			void (*post_func)(struct net_device *),
+			struct attribute *attr,
+			atomic_t *attr_store, struct net_device *net_dev)
+{
+	int ret;
+
+	ret = store_bool_attr(buff, count, net_dev, (char *)attr->name,
+			      attr_store);
+	if (post_func && ret)
+		post_func(net_dev);
+
+	return ret;
+}
+
 static int store_uint_attr(char *buff, size_t count,
 			   struct net_device *net_dev, char *attr_name,
 			   unsigned int min, unsigned int max, atomic_t *attr)
@@ -113,74 +188,18 @@ static int store_uint_attr(char *buff, size_t count,
 	return count;
 }
 
-
-static ssize_t show_aggr_ogms(struct kobject *kobj, struct attribute *attr,
-			     char *buff)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int aggr_status = atomic_read(&bat_priv->aggregated_ogms);
-
-	return sprintf(buff, "%s\n",
-		       aggr_status == 0 ? "disabled" : "enabled");
-}
-
-static ssize_t store_aggr_ogms(struct kobject *kobj, struct attribute *attr,
-			      char *buff, size_t count)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
-
-	return store_bool_attr(buff, count, net_dev, (char *)attr->name,
-			       &bat_priv->aggregated_ogms);
-}
-
-static ssize_t show_bond(struct kobject *kobj, struct attribute *attr,
-			     char *buff)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int bond_status = atomic_read(&bat_priv->bonding);
-
-	return sprintf(buff, "%s\n",
-		       bond_status == 0 ? "disabled" : "enabled");
-}
-
-static ssize_t store_bond(struct kobject *kobj, struct attribute *attr,
-			  char *buff, size_t count)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
-
-	return store_bool_attr(buff, count, net_dev, (char *)attr->name,
-			       &bat_priv->bonding);
-}
-
-static ssize_t show_frag(struct kobject *kobj, struct attribute *attr,
-			     char *buff)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int frag_status = atomic_read(&bat_priv->fragmentation);
-
-	return sprintf(buff, "%s\n",
-		       frag_status == 0 ? "disabled" : "enabled");
-}
-
-static ssize_t store_frag(struct kobject *kobj, struct attribute *attr,
-			  char *buff, size_t count)
+static inline ssize_t __store_uint_attr(char *buff, size_t count,
+			int min, int max,
+			void (*post_func)(struct net_device *),
+			struct attribute *attr,
+			atomic_t *attr_store, struct net_device *net_dev)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	int ret;
 
-	ret = store_bool_attr(buff, count, net_dev, (char *)attr->name,
-			      &bat_priv->fragmentation);
-	if (ret)
-		update_min_mtu(net_dev);
+	ret = store_uint_attr(buff, count, net_dev, (char *)attr->name,
+			      min, max, attr_store);
+	if (post_func && ret)
+		post_func(net_dev);
 
 	return ret;
 }
@@ -282,60 +301,14 @@ static ssize_t store_gw_mode(struct kobject *kobj, struct attribute *attr,
 	return gw_mode_set(net_dev, buff, count);
 }
 
-static ssize_t show_orig_interval(struct kobject *kobj, struct attribute *attr,
-				 char *buff)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-
-	return sprintf(buff, "%i\n",
-		       atomic_read(&bat_priv->orig_interval));
-}
-
-static ssize_t store_orig_interval(struct kobject *kobj, struct attribute *attr,
-				  char *buff, size_t count)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
-
-	return store_uint_attr(buff, count, net_dev, (char *)attr->name,
-			       2 * JITTER, UINT_MAX, &bat_priv->orig_interval);
-}
-
-#ifdef CONFIG_BATMAN_ADV_DEBUG
-static ssize_t show_log_level(struct kobject *kobj, struct attribute *attr,
-			     char *buff)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int log_level = atomic_read(&bat_priv->log_level);
-
-	return sprintf(buff, "%d\n", log_level);
-}
-
-static ssize_t store_log_level(struct kobject *kobj, struct attribute *attr,
-			      char *buff, size_t count)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
-
-	return store_uint_attr(buff, count, net_dev, (char *)attr->name,
-			       0, 3, &bat_priv->log_level);
-}
-#endif
-
-static BAT_ATTR(aggregated_ogms, S_IRUGO | S_IWUSR,
-		show_aggr_ogms, store_aggr_ogms);
-static BAT_ATTR(bonding, S_IRUGO | S_IWUSR, show_bond, store_bond);
-static BAT_ATTR(fragmentation, S_IRUGO | S_IWUSR, show_frag, store_frag);
+BAT_ATTR_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
+BAT_ATTR_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
+BAT_ATTR_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
-static BAT_ATTR(orig_interval, S_IRUGO | S_IWUSR,
-		show_orig_interval, store_orig_interval);
+BAT_ATTR_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-static BAT_ATTR(log_level, S_IRUGO | S_IWUSR, show_log_level, store_log_level);
+BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 3, NULL);
 #endif
 
 static struct bat_attribute *mesh_attrs[] = {
-- 
1.7.1

