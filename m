Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 10 Oct 2010 06:29:57 +0200
Message-Id: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Wrapper functions for sysfs
	storing
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

Sysfs configuration options that just took a boolean value
(enable(d)/disable(d)/0/1) and integer setting basically all had the same
structure.

To avoid even more copy and pasting in the future and to make introducing
new configuration parameters for batman-adv simpler, more generic
wrapper functions are being introduced with this commit. They can deal with
boolean and unsigned integer parameters, storing them in the specified
atomic_t variables.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 bat_sysfs.c |  224 +++++++++++++++++++++++-----------------------------------
 1 files changed, 89 insertions(+), 135 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 3f551f3..60e3122 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -39,6 +39,81 @@ struct bat_attribute bat_attr_##_name = {	\
 	.store  = _store,			\
 };
 
+static int store_switch_attr(char *buff, size_t count,
+			     struct net_device *net_dev,
+			     char *attr_name, atomic_t *attr)
+{
+	int enabled = -1;
+
+	if (buff[count - 1] == '\n')
+		buff[count - 1] = '\0';
+
+	if ((strncmp(buff, "1", 2) == 0) ||
+	    (strncmp(buff, "enable", 7) == 0) ||
+	    (strncmp(buff, "enabled", 8) == 0))
+		enabled = 1;
+
+	if ((strncmp(buff, "0", 2) == 0) ||
+	    (strncmp(buff, "disable", 8) == 0) ||
+	    (strncmp(buff, "disabled", 9) == 0))
+		enabled = 0;
+
+	if (enabled < 0) {
+		bat_info(net_dev,
+			 "%s: Invalid parameter received: %s\n",
+			 attr_name, buff);
+		return -EINVAL;
+	}
+
+	if (atomic_read(attr) == enabled)
+		return count;
+
+	bat_info(net_dev, "%s: Changing from: %s to: %s\n", attr_name,
+		 atomic_read(attr) == 1 ? "enabled" : "disabled",
+		 enabled == 1 ? "enabled" : "disabled");
+
+	atomic_set(attr, (unsigned)enabled);
+	return count;
+}
+
+static int store_uint_attr(char *buff, size_t count,
+			   struct net_device *net_dev, char *attr_name,
+			   unsigned int min, unsigned int max, atomic_t *attr)
+{
+	unsigned long uint_val;
+	int ret;
+
+	ret = strict_strtoul(buff, 10, &uint_val);
+	if (ret) {
+		bat_info(net_dev,
+			 "%s: Invalid parameter received: %s\n",
+			 attr_name, buff);
+		return -EINVAL;
+	}
+
+	if (uint_val < min) {
+		bat_info(net_dev, "%s: Value is too small: %lu min: %u\n",
+			 attr_name, uint_val, min);
+		return -EINVAL;
+	}
+
+	if (uint_val > max) {
+		bat_info(net_dev, "%s: Value is too big: %lu max: %u\n",
+			 attr_name, uint_val, max);
+		return -EINVAL;
+	}
+
+	if (atomic_read(attr) == uint_val)
+		return count;
+
+	bat_info(net_dev, "%s: Changing from: %i to: %lu\n",
+		 attr_name, atomic_read(attr), uint_val);
+
+	atomic_set(attr, uint_val);
+	return count;
+}
+
+
 static ssize_t show_aggr_ogms(struct kobject *kobj, struct attribute *attr,
 			     char *buff)
 {
@@ -56,36 +131,9 @@ static ssize_t store_aggr_ogms(struct kobject *kobj, struct attribute *attr,
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	int aggr_tmp = -1;
-
-	if (((count == 2) && (buff[0] == '1')) ||
-	    (strncmp(buff, "enable", 6) == 0))
-		aggr_tmp = 1;
-
-	if (((count == 2) && (buff[0] == '0')) ||
-	    (strncmp(buff, "disable", 7) == 0))
-		aggr_tmp = 0;
-
-	if (aggr_tmp < 0) {
-		if (buff[count - 1] == '\n')
-			buff[count - 1] = '\0';
-
-		bat_info(net_dev,
-			 "Invalid parameter for 'aggregate OGM' setting"
-			 "received: %s\n", buff);
-		return -EINVAL;
-	}
-
-	if (atomic_read(&bat_priv->aggregation_enabled) == aggr_tmp)
-		return count;
-
-	bat_info(net_dev, "Changing aggregation from: %s to: %s\n",
-		 atomic_read(&bat_priv->aggregation_enabled) == 1 ?
-		 "enabled" : "disabled", aggr_tmp == 1 ? "enabled" :
-		 "disabled");
 
-	atomic_set(&bat_priv->aggregation_enabled, (unsigned)aggr_tmp);
-	return count;
+	return store_switch_attr(buff, count, net_dev, (char *)attr->name,
+				 &bat_priv->aggregation_enabled);
 }
 
 static ssize_t show_bond(struct kobject *kobj, struct attribute *attr,
@@ -105,36 +153,9 @@ static ssize_t store_bond(struct kobject *kobj, struct attribute *attr,
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	int bonding_enabled_tmp = -1;
-
-	if (((count == 2) && (buff[0] == '1')) ||
-	    (strncmp(buff, "enable", 6) == 0))
-		bonding_enabled_tmp = 1;
 
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
-		return -EINVAL;
-	}
-
-	if (atomic_read(&bat_priv->bonding_enabled) == bonding_enabled_tmp)
-		return count;
-
-	bat_info(net_dev, "Changing bonding from: %s to: %s\n",
-		 atomic_read(&bat_priv->bonding_enabled) == 1 ?
-		 "enabled" : "disabled",
-		 bonding_enabled_tmp == 1 ? "enabled" : "disabled");
-
-	atomic_set(&bat_priv->bonding_enabled, (unsigned)bonding_enabled_tmp);
-	return count;
+	return store_switch_attr(buff, count, net_dev, (char *)attr->name,
+				 &bat_priv->bonding_enabled);
 }
 
 static ssize_t show_frag(struct kobject *kobj, struct attribute *attr,
@@ -154,37 +175,14 @@ static ssize_t store_frag(struct kobject *kobj, struct attribute *attr,
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
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
-
-	if (atomic_read(&bat_priv->frag_enabled) == frag_enabled_tmp)
-		return count;
+	int ret;
 
-	bat_info(net_dev, "Changing fragmentation from: %s to: %s\n",
-		 atomic_read(&bat_priv->frag_enabled) == 1 ?
-		 "enabled" : "disabled",
-		 frag_enabled_tmp == 1 ? "enabled" : "disabled");
+	ret = store_switch_attr(buff, count, net_dev, (char *)attr->name,
+				&bat_priv->frag_enabled);
+	if (ret)
+		update_min_mtu(net_dev);
 
-	atomic_set(&bat_priv->frag_enabled, (unsigned)frag_enabled_tmp);
-	update_min_mtu(net_dev);
-	return count;
+	return ret;
 }
 
 static ssize_t show_vis_mode(struct kobject *kobj, struct attribute *attr,
@@ -300,31 +298,9 @@ static ssize_t store_orig_interval(struct kobject *kobj, struct attribute *attr,
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
-	unsigned long orig_interval_tmp;
-	int ret;
 
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
+	return store_uint_attr(buff, count, net_dev, (char *)attr->name,
+			       2 * JITTER, UINT_MAX, &bat_priv->orig_interval);
 }
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
@@ -344,31 +320,9 @@ static ssize_t store_log_level(struct kobject *kobj, struct attribute *attr,
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
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
 
-	atomic_set(&bat_priv->log_level, (unsigned)log_level_tmp);
-	return count;
+	return store_uint_attr(buff, count, net_dev, (char *)attr->name,
+			       0, 3, &bat_priv->log_level);
 }
 #endif
 
-- 
1.7.1

