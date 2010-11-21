Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:53 +0100
Message-Id: <1290383767-32602-16-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 15/29] Staging: batman-adv: Wrapper functions
	for sysfs storing
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

Sysfs configuration options that just took a boolean value
(enable(d)/disable(d)/0/1) and integer setting basically all had the same
structure.

To avoid even more copy and pasting in the future and to make introducing
new configuration parameters for batman-adv simpler, more generic
wrapper functions are being introduced with this commit. They can deal with
boolean and unsigned integer parameters, storing them in the specified
atomic_t variables.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/bat_sysfs.c |  339 +++++++++++++-------------------
 1 files changed, 133 insertions(+), 206 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index a67c54c..19be531 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -28,6 +28,7 @@
 
 #define to_dev(obj)     container_of(obj, struct device, kobj)
 
+/* Use this, if you have customized show and store functions */
 #define BAT_ATTR(_name, _mode, _show, _store)	\
 struct bat_attribute bat_attr_##_name = {	\
 	.attr = {.name = __stringify(_name),	\
@@ -36,152 +37,168 @@ struct bat_attribute bat_attr_##_name = {	\
 	.store  = _store,			\
 };
 
-static ssize_t show_aggr_ogms(struct kobject *kobj, struct attribute *attr,
-			     char *buff)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int aggr_status = atomic_read(&bat_priv->aggregated_ogms);
+#define BAT_ATTR_STORE_BOOL(_name, _post_func)				\
+ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
+		      char *buff, size_t count)				\
+{									\
+	struct device *dev = to_dev(kobj->parent);			\
+	struct net_device *net_dev = to_net_dev(dev);			\
+	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	return __store_bool_attr(buff, count, _post_func, attr,		\
+				 &bat_priv->_name, net_dev);		\
+}
 
-	return sprintf(buff, "%s\n",
-		       aggr_status == 0 ? "disabled" : "enabled");
+#define BAT_ATTR_SHOW_BOOL(_name)					\
+ssize_t show_##_name(struct kobject *kobj, struct attribute *attr,	\
+			    char *buff)					\
+{									\
+	struct device *dev = to_dev(kobj->parent);			\
+	struct net_device *net_dev = to_net_dev(dev);			\
+	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	return sprintf(buff, "%s\n",					\
+		       atomic_read(&bat_priv->_name) == 0 ?		\
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
+ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
+			     char *buff, size_t count)			\
+{									\
+	struct device *dev = to_dev(kobj->parent);			\
+	struct net_device *net_dev = to_net_dev(dev);			\
+	struct bat_priv *bat_priv = netdev_priv(net_dev);		\
+	return __store_uint_attr(buff, count, _min, _max, _post_func,	\
+				 attr, &bat_priv->_name, net_dev);	\
 }
 
-static ssize_t store_aggr_ogms(struct kobject *kobj, struct attribute *attr,
-			      char *buff, size_t count)
+#define BAT_ATTR_SHOW_UINT(_name)					\
+ssize_t show_##_name(struct kobject *kobj, struct attribute *attr,	\
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
+static int store_bool_attr(char *buff, size_t count,
+			   struct net_device *net_dev,
+			   char *attr_name, atomic_t *attr)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	int aggr_tmp = -1;
+	int enabled = -1;
 
-	if (((count == 2) && (buff[0] == '1')) ||
-	    (strncmp(buff, "enable", 6) == 0))
-		aggr_tmp = 1;
+	if (buff[count - 1] == '\n')
+		buff[count - 1] = '\0';
 
-	if (((count == 2) && (buff[0] == '0')) ||
-	    (strncmp(buff, "disable", 7) == 0))
-		aggr_tmp = 0;
+	if ((strncmp(buff, "1", 2) == 0) ||
+	    (strncmp(buff, "enable", 7) == 0) ||
+	    (strncmp(buff, "enabled", 8) == 0))
+		enabled = 1;
 
-	if (aggr_tmp < 0) {
-		if (buff[count - 1] == '\n')
-			buff[count - 1] = '\0';
+	if ((strncmp(buff, "0", 2) == 0) ||
+	    (strncmp(buff, "disable", 8) == 0) ||
+	    (strncmp(buff, "disabled", 9) == 0))
+		enabled = 0;
 
+	if (enabled < 0) {
 		bat_info(net_dev,
-			 "Invalid parameter for 'aggregate OGM' setting"
-			 "received: %s\n", buff);
+			 "%s: Invalid parameter received: %s\n",
+			 attr_name, buff);
 		return -EINVAL;
 	}
 
-	if (atomic_read(&bat_priv->aggregated_ogms) == aggr_tmp)
+	if (atomic_read(attr) == enabled)
 		return count;
 
-	bat_info(net_dev, "Changing aggregation from: %s to: %s\n",
-		 atomic_read(&bat_priv->aggregated_ogms) == 1 ?
-		 "enabled" : "disabled", aggr_tmp == 1 ? "enabled" :
-		 "disabled");
+	bat_info(net_dev, "%s: Changing from: %s to: %s\n", attr_name,
+		 atomic_read(attr) == 1 ? "enabled" : "disabled",
+		 enabled == 1 ? "enabled" : "disabled");
 
-	atomic_set(&bat_priv->aggregated_ogms, (unsigned)aggr_tmp);
+	atomic_set(attr, (unsigned)enabled);
 	return count;
 }
 
-static ssize_t show_bond(struct kobject *kobj, struct attribute *attr,
-			     char *buff)
+static inline ssize_t __store_bool_attr(char *buff, size_t count,
+			void (*post_func)(struct net_device *),
+			struct attribute *attr,
+			atomic_t *attr_store, struct net_device *net_dev)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int bond_status = atomic_read(&bat_priv->bonding);
+	int ret;
+
+	ret = store_bool_attr(buff, count, net_dev, (char *)attr->name,
+			      attr_store);
+	if (post_func && ret)
+		post_func(net_dev);
 
-	return sprintf(buff, "%s\n",
-		       bond_status == 0 ? "disabled" : "enabled");
+	return ret;
 }
 
-static ssize_t store_bond(struct kobject *kobj, struct attribute *attr,
-			  char *buff, size_t count)
+static int store_uint_attr(char *buff, size_t count,
+			   struct net_device *net_dev, char *attr_name,
+			   unsigned int min, unsigned int max, atomic_t *attr)
 {
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	int bonding_enabled_tmp = -1;
-
-	if (((count == 2) && (buff[0] == '1')) ||
-	    (strncmp(buff, "enable", 6) == 0))
-		bonding_enabled_tmp = 1;
-
-	if (((count == 2) && (buff[0] == '0')) ||
-	    (strncmp(buff, "disable", 7) == 0))
-		bonding_enabled_tmp = 0;
-
-	if (bonding_enabled_tmp < 0) {
-		if (buff[count - 1] == '\n')
-			buff[count - 1] = '\0';
-
-		bat_err(net_dev,
-			"Invalid parameter for 'bonding' setting received: "
-			"%s\n", buff);
+	unsigned long uint_val;
+	int ret;
+
+	ret = strict_strtoul(buff, 10, &uint_val);
+	if (ret) {
+		bat_info(net_dev,
+			 "%s: Invalid parameter received: %s\n",
+			 attr_name, buff);
 		return -EINVAL;
 	}
 
-	if (atomic_read(&bat_priv->bonding) == bonding_enabled_tmp)
-		return count;
+	if (uint_val < min) {
+		bat_info(net_dev, "%s: Value is too small: %lu min: %u\n",
+			 attr_name, uint_val, min);
+		return -EINVAL;
+	}
 
-	bat_info(net_dev, "Changing bonding from: %s to: %s\n",
-		 atomic_read(&bat_priv->bonding) == 1 ?
-		 "enabled" : "disabled",
-		 bonding_enabled_tmp == 1 ? "enabled" : "disabled");
+	if (uint_val > max) {
+		bat_info(net_dev, "%s: Value is too big: %lu max: %u\n",
+			 attr_name, uint_val, max);
+		return -EINVAL;
+	}
 
-	atomic_set(&bat_priv->bonding, (unsigned)bonding_enabled_tmp);
-	return count;
-}
+	if (atomic_read(attr) == uint_val)
+		return count;
 
-static ssize_t show_frag(struct kobject *kobj, struct attribute *attr,
-			     char *buff)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
-	int frag_status = atomic_read(&bat_priv->fragmentation);
+	bat_info(net_dev, "%s: Changing from: %i to: %lu\n",
+		 attr_name, atomic_read(attr), uint_val);
 
-	return sprintf(buff, "%s\n",
-		       frag_status == 0 ? "disabled" : "enabled");
+	atomic_set(attr, uint_val);
+	return count;
 }
 
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
-	int frag_enabled_tmp = -1;
-
-	if (((count == 2) && (buff[0] == '1')) ||
-	    (strncmp(buff, "enable", 6) == 0))
-		frag_enabled_tmp = 1;
-
-	if (((count == 2) && (buff[0] == '0')) ||
-	    (strncmp(buff, "disable", 7) == 0))
-		frag_enabled_tmp = 0;
-
-	if (frag_enabled_tmp < 0) {
-		if (buff[count - 1] == '\n')
-			buff[count - 1] = '\0';
-
-		bat_err(net_dev,
-			"Invalid parameter for 'fragmentation' setting on mesh"
-			"received: %s\n", buff);
-		return -EINVAL;
-	}
+	int ret;
 
-	if (atomic_read(&bat_priv->fragmentation) == frag_enabled_tmp)
-		return count;
+	ret = store_uint_attr(buff, count, net_dev, (char *)attr->name,
+			      min, max, attr_store);
+	if (post_func && ret)
+		post_func(net_dev);
 
-	bat_info(net_dev, "Changing fragmentation from: %s to: %s\n",
-		 atomic_read(&bat_priv->fragmentation) == 1 ?
-		 "enabled" : "disabled",
-		 frag_enabled_tmp == 1 ? "enabled" : "disabled");
-
-	atomic_set(&bat_priv->fragmentation, (unsigned)frag_enabled_tmp);
-	update_min_mtu(net_dev);
-	return count;
+	return ret;
 }
 
 static ssize_t show_vis_mode(struct kobject *kobj, struct attribute *attr,
@@ -238,103 +255,13 @@ static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
 	return count;
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
-	unsigned long orig_interval_tmp;
-	int ret;
-
-	ret = strict_strtoul(buff, 10, &orig_interval_tmp);
-	if (ret) {
-		bat_info(net_dev, "Invalid parameter for 'orig_interval' "
-			 "setting received: %s\n", buff);
-		return -EINVAL;
-	}
-
-	if (orig_interval_tmp < JITTER * 2) {
-		bat_info(net_dev, "New originator interval too small: %li "
-			 "(min: %i)\n", orig_interval_tmp, JITTER * 2);
-		return -EINVAL;
-	}
-
-	if (atomic_read(&bat_priv->orig_interval) == orig_interval_tmp)
-		return count;
-
-	bat_info(net_dev, "Changing originator interval from: %i to: %li\n",
-		 atomic_read(&bat_priv->orig_interval),
-		 orig_interval_tmp);
-
-	atomic_set(&bat_priv->orig_interval, orig_interval_tmp);
-	return count;
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
-	unsigned long log_level_tmp;
-	int ret;
-
-	ret = strict_strtoul(buff, 10, &log_level_tmp);
-	if (ret) {
-		bat_info(net_dev, "Invalid parameter for 'log_level' "
-			 "setting received: %s\n", buff);
-		return -EINVAL;
-	}
-
-	if (log_level_tmp > 3) {
-		bat_info(net_dev, "New log level too big: %li "
-			 "(max: %i)\n", log_level_tmp, 3);
-		return -EINVAL;
-	}
-
-	if (atomic_read(&bat_priv->log_level) == log_level_tmp)
-		return count;
-
-	bat_info(net_dev, "Changing log level from: %i to: %li\n",
-		 atomic_read(&bat_priv->log_level),
-		 log_level_tmp);
-
-	atomic_set(&bat_priv->log_level, (unsigned)log_level_tmp);
-	return count;
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
-static BAT_ATTR(orig_interval, S_IRUGO | S_IWUSR,
-		show_orig_interval, store_orig_interval);
+BAT_ATTR_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
-static BAT_ATTR(log_level, S_IRUGO | S_IWUSR, show_log_level, store_log_level);
+BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 3, NULL);
 #endif
 
 static struct bat_attribute *mesh_attrs[] = {
-- 
1.7.2.3

