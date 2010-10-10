Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 10 Oct 2010 06:29:58 +0200
Message-Id: <1286685001-15227-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
References: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Introduce generic BAT_ATTR_*
	macros
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
a one-liner in the future. It also further reduces the amount of
duplicate code in bat_sysfs.c.

Additionally, the sysfs entries "aggregate_ogms" and "fragmentation"
get renamed to "aggregation" and "frag" for consistency reasons, they
match the *_enabled parts in bat_priv now.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 bat_sysfs.c |  186 ++++++++++++++++++++---------------------------------------
 1 files changed, 62 insertions(+), 124 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 60e3122..878cb8e 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -31,6 +31,7 @@
 
 #define to_dev(obj)     container_of(obj, struct device, kobj)
 
+/* Use this, if you have customized show and store functions */
 #define BAT_ATTR(_name, _mode, _show, _store)	\
 struct bat_attribute bat_attr_##_name = {	\
 	.attr = {.name = __stringify(_name),	\
@@ -39,6 +40,60 @@ struct bat_attribute bat_attr_##_name = {	\
 	.store  = _store,			\
 };
 
+/* Use this, if you are going to turn a [name]_enabled in bat_priv on or off */
+#define BAT_ATTR_SWITCH(_name, _mode, _post_func)			\
+static ssize_t store_##_name(struct kobject *kobj, struct attribute *attr, \
+		      char *buff, size_t count)				\
+{									\
+	struct device *dev = to_dev(kobj->parent);			\
+	struct net_device *net_dev = to_net_dev(dev);			\
+	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	void (*post_func)(struct net_device *) = _post_func;		\
+	int ret;							\
+	ret = store_switch_attr(buff, count, net_dev, (char *)attr->name, \
+				 &bat_priv->_name##_enabled);		\
+	if (post_func && ret)						\
+		post_func(net_dev);					\
+	return ret;							\
+}									\
+static ssize_t show_##_name(struct kobject *kobj, struct attribute *attr, \
+			    char *buff)					\
+{									\
+	struct device *dev = to_dev(kobj->parent);			\
+	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));	\
+	return sprintf(buff, "%s\n",					\
+		       atomic_read(&bat_priv->_name##_enabled) == 0 ?	\
+		       "disabled" : "enabled");				\
+}									\
+BAT_ATTR(_name, _mode, show_##_name, store_##_name)
+
+/* Use this, if you are going to set [name] in bat_priv to unsigned integer
+ * values only */
+#define BAT_ATTR_UINT(_name, _mode, _min, _max, _post_func)		\
+static ssize_t store_##_name(struct kobject *kobj, struct attribute *attr, \
+		      char *buff, size_t count)				\
+{									\
+	struct device *dev = to_dev(kobj->parent);			\
+	struct net_device *net_dev = to_net_dev(dev);			\
+	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	void (*post_func)(struct net_device *) = _post_func;		\
+	int ret;							\
+	ret = store_uint_attr(buff, count, net_dev, (char *)attr->name,	\
+			       _min, _max, &bat_priv->_name);		\
+	if (post_func && ret)						\
+		post_func(net_dev);					\
+	return ret;							\
+}									\
+static ssize_t show_##_name(struct kobject *kobj, struct attribute *attr, \
+			    char *buff)					\
+{									\
+	struct device *dev = to_dev(kobj->parent);			\
+	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));	\
+	return sprintf(buff, "%i\n", atomic_read(&bat_priv->_name));	\
+}									\
+BAT_ATTR(_name, _mode, show_##_name, store_##_name)
+
+
 static int store_switch_attr(char *buff, size_t count,
 			     struct net_device *net_dev,
 			     char *attr_name, atomic_t *attr)
@@ -114,77 +169,6 @@ static int store_uint_attr(char *buff, size_t count,
 }
 
 
-static ssize_t show_aggr_ogms(struct kobject *kobj, struct attribute *attr,
-			     char *buff)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int aggr_status = atomic_read(&bat_priv->aggregation_enabled);
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
-	return store_switch_attr(buff, count, net_dev, (char *)attr->name,
-				 &bat_priv->aggregation_enabled);
-}
-
-static ssize_t show_bond(struct kobject *kobj, struct attribute *attr,
-			     char *buff)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int bond_status = atomic_read(&bat_priv->bonding_enabled);
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
-	return store_switch_attr(buff, count, net_dev, (char *)attr->name,
-				 &bat_priv->bonding_enabled);
-}
-
-static ssize_t show_frag(struct kobject *kobj, struct attribute *attr,
-			     char *buff)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int frag_status = atomic_read(&bat_priv->frag_enabled);
-
-	return sprintf(buff, "%s\n",
-		       frag_status == 0 ? "disabled" : "enabled");
-}
-
-static ssize_t store_frag(struct kobject *kobj, struct attribute *attr,
-			  char *buff, size_t count)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	int ret;
-
-	ret = store_switch_attr(buff, count, net_dev, (char *)attr->name,
-				&bat_priv->frag_enabled);
-	if (ret)
-		update_min_mtu(net_dev);
-
-	return ret;
-}
-
 static ssize_t show_vis_mode(struct kobject *kobj, struct attribute *attr,
 			     char *buff)
 {
@@ -282,66 +266,20 @@ static ssize_t store_gw_mode(struct kobject *kobj, struct attribute *attr,
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
+BAT_ATTR_SWITCH(aggregation, S_IRUGO | S_IWUSR, NULL);
+BAT_ATTR_SWITCH(bonding, S_IRUGO | S_IWUSR, NULL);
+BAT_ATTR_SWITCH(frag, S_IRUGO | S_IWUSR, update_min_mtu);
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
-	&bat_attr_aggregated_ogms,
+	&bat_attr_aggregation,
 	&bat_attr_bonding,
-	&bat_attr_fragmentation,
+	&bat_attr_frag,
 	&bat_attr_vis_mode,
 	&bat_attr_gw_mode,
 	&bat_attr_orig_interval,
-- 
1.7.1

