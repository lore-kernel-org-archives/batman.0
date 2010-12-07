Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Tue,  7 Dec 2010 23:32:12 +0100
Message-Id: <1291761150-29818-2-git-send-email-linus.luessing@saxnet.de>
In-Reply-To: <20101207221351.GA19474@Sellars>
References: <20101207221351.GA19474@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 02/20] batman-adv: Adding configurable
	variables for multicast optimizations
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>

This commit adds the needed configurable variables in bat_priv and
according user interfaces in sysfs for the future multicast
optimizations.

Signed-off-by: Linus Lüssing <linus.luessing@saxnet.de>
---
 Makefile.kbuild  |    1 +
 bat_sysfs.c      |  160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 multicast.c      |  121 +++++++++++++++++++++++++++++++++++++++++
 multicast.h      |   30 ++++++++++
 packet.h         |    4 ++
 soft-interface.c |    4 ++
 types.h          |    4 ++
 7 files changed, 324 insertions(+), 0 deletions(-)
 create mode 100644 multicast.c
 create mode 100644 multicast.h

diff --git a/Makefile.kbuild b/Makefile.kbuild
index e99c198..56296c4 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -49,5 +49,6 @@ batman-adv-y += send.o
 batman-adv-y += soft-interface.o
 batman-adv-y += translation-table.o
 batman-adv-y += unicast.o
+batman-adv-y += multicast.o
 batman-adv-y += vis.o
 batman-adv-y += bat_printk.o
diff --git a/bat_sysfs.c b/bat_sysfs.c
index cd7bb51..f627d70 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -27,6 +27,7 @@
 #include "gateway_common.h"
 #include "gateway_client.h"
 #include "vis.h"
+#include "multicast.h"
 
 #define to_dev(obj)		container_of(obj, struct device, kobj)
 #define kobj_to_netdev(obj)	to_net_dev(to_dev(obj->parent))
@@ -356,6 +357,153 @@ static ssize_t store_gw_bwidth(struct kobject *kobj, struct attribute *attr,
 	return gw_bandwidth_set(net_dev, buff, count);
 }
 
+static ssize_t show_mcast_mode(struct kobject *kobj, struct attribute *attr,
+				 char *buff)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+	int mcast_mode = atomic_read(&bat_priv->mcast_mode);
+	int ret;
+
+	switch (mcast_mode) {
+	case MCAST_MODE_CLASSIC_FLOODING:
+		ret = sprintf(buff, "classic_flooding\n");
+		break;
+	case MCAST_MODE_PROACT_TRACKING:
+		ret = sprintf(buff, "proactive_tracking\n");
+		break;
+	default:
+		ret = -1;
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t store_mcast_mode(struct kobject *kobj, struct attribute *attr,
+			      char *buff, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	unsigned long val;
+	int ret, mcast_mode_tmp = -1;
+
+	ret = strict_strtoul(buff, 10, &val);
+
+	if (((count == 2) && (!ret) && (val == MCAST_MODE_CLASSIC_FLOODING)) ||
+	    (strncmp(buff, "classic_flooding", 16) == 0))
+		mcast_mode_tmp = MCAST_MODE_CLASSIC_FLOODING;
+
+	if (((count == 2) && (!ret) && (val == MCAST_MODE_PROACT_TRACKING)) ||
+	    (strncmp(buff, "proact_tracking", 15) == 0))
+		mcast_mode_tmp = MCAST_MODE_PROACT_TRACKING;
+
+	if (mcast_mode_tmp < 0) {
+		if (buff[count - 1] == '\n')
+			buff[count - 1] = '\0';
+
+		bat_info(net_dev,
+			 "Invalid parameter for 'mcast mode' setting received: "
+			 "%s\n", buff);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&bat_priv->mcast_mode) == mcast_mode_tmp)
+		return count;
+
+	bat_info(net_dev, "Changing mcast mode from: %s to: %s\n",
+		 atomic_read(&bat_priv->mcast_mode) ==
+			MCAST_MODE_CLASSIC_FLOODING ?
+		 "classic_flooding" : "proact_tracking",
+		 mcast_mode_tmp == MCAST_MODE_CLASSIC_FLOODING ?
+		 "classic_flooding" : "proact_tracking");
+
+	atomic_set(&bat_priv->mcast_mode, (unsigned)mcast_mode_tmp);
+	return count;
+}
+
+static ssize_t show_mcast_tracker_interval(struct kobject *kobj,
+			struct attribute *attr, char *buff)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+	int tracker_interval = atomic_read(&bat_priv->mcast_tracker_interval);
+
+	if (!tracker_interval)
+		return sprintf(buff, "auto\n");
+	else
+		return sprintf(buff, "%i\n", tracker_interval);
+}
+
+static ssize_t store_mcast_tracker_interval(struct kobject *kobj,
+			struct attribute *attr, char *buff, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+
+	return mcast_tracker_interval_set(net_dev, buff, count);
+}
+
+static ssize_t show_mcast_tracker_timeout(struct kobject *kobj,
+			struct attribute *attr, char *buff)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+	int tracker_timeout = atomic_read(&bat_priv->mcast_tracker_timeout);
+
+	if (!tracker_timeout)
+		return sprintf(buff, "auto\n");
+	else
+		return sprintf(buff, "%i\n", tracker_timeout);
+}
+
+static ssize_t store_mcast_tracker_timeout(struct kobject *kobj,
+			struct attribute *attr, char *buff, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+
+	return mcast_tracker_timeout_set(net_dev, buff, count);
+}
+
+static ssize_t show_mcast_fanout(struct kobject *kobj,
+			struct attribute *attr, char *buff)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+
+	return sprintf(buff, "%i\n",
+		       atomic_read(&bat_priv->mcast_fanout));
+}
+
+static ssize_t store_mcast_fanout(struct kobject *kobj,
+			struct attribute *attr, char *buff, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	unsigned long mcast_fanout_tmp;
+	int ret;
+
+	ret = strict_strtoul(buff, 10, &mcast_fanout_tmp);
+	if (ret) {
+		bat_info(net_dev, "Invalid parameter for 'mcast_fanout' "
+			 "setting received: %s\n", buff);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&bat_priv->mcast_fanout) == mcast_fanout_tmp)
+		return count;
+
+	bat_info(net_dev, "Changing mcast fanout interval from: %i to: %li\n",
+		 atomic_read(&bat_priv->mcast_fanout),
+		 mcast_fanout_tmp);
+
+	atomic_set(&bat_priv->mcast_fanout, mcast_fanout_tmp);
+	return count;
+}
+
 BAT_ATTR_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
@@ -367,6 +515,14 @@ BAT_ATTR_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, TQ_MAX_VALUE,
 	      post_gw_deselect);
 static BAT_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, show_gw_bwidth,
 		store_gw_bwidth);
+static BAT_ATTR(mcast_mode, S_IRUGO | S_IWUSR,
+		show_mcast_mode, store_mcast_mode);
+static BAT_ATTR(mcast_tracker_interval, S_IRUGO | S_IWUSR,
+		show_mcast_tracker_interval, store_mcast_tracker_interval);
+static BAT_ATTR(mcast_tracker_timeout, S_IRUGO | S_IWUSR,
+		show_mcast_tracker_timeout, store_mcast_tracker_timeout);
+static BAT_ATTR(mcast_fanout, S_IRUGO | S_IWUSR,
+		show_mcast_fanout, store_mcast_fanout);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 3, NULL);
 #endif
@@ -381,6 +537,10 @@ static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_hop_penalty,
 	&bat_attr_gw_sel_class,
 	&bat_attr_gw_bandwidth,
+	&bat_attr_mcast_mode,
+	&bat_attr_mcast_tracker_interval,
+	&bat_attr_mcast_tracker_timeout,
+	&bat_attr_mcast_fanout,
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	&bat_attr_log_level,
 #endif
diff --git a/multicast.c b/multicast.c
new file mode 100644
index 0000000..0598873
--- /dev/null
+++ b/multicast.c
@@ -0,0 +1,121 @@
+/*
+ * Copyright (C) 2010 B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#include "main.h"
+#include "multicast.h"
+
+int mcast_tracker_interval_set(struct net_device *net_dev, char *buff,
+			       size_t count)
+{
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	unsigned long new_tracker_interval;
+	int cur_tracker_interval;
+	int ret;
+
+	ret = strict_strtoul(buff, 10, &new_tracker_interval);
+
+	if (ret && !strncmp(buff, "auto", 4)) {
+		new_tracker_interval = 0;
+		goto ok;
+	}
+
+	else if (ret) {
+		bat_info(net_dev, "Invalid parameter for "
+			 "'mcast_tracker_interval' setting received: %s\n",
+			 buff);
+		return -EINVAL;
+	}
+
+	if (new_tracker_interval < JITTER) {
+		bat_info(net_dev, "New mcast tracker interval too small: %li "
+			 "(min: %i or auto)\n", new_tracker_interval, JITTER);
+		return -EINVAL;
+	}
+
+ok:
+	cur_tracker_interval = atomic_read(&bat_priv->mcast_tracker_interval);
+
+	if (cur_tracker_interval == new_tracker_interval)
+		return count;
+
+	if (!cur_tracker_interval && new_tracker_interval)
+		bat_info(net_dev, "Tracker interval change from: %s to: %li\n",
+			 "auto", new_tracker_interval);
+	else if (cur_tracker_interval && !new_tracker_interval)
+		bat_info(net_dev, "Tracker interval change from: %i to: %s\n",
+			 cur_tracker_interval, "auto");
+	else
+		bat_info(net_dev, "Tracker interval change from: %i to: %li\n",
+			 cur_tracker_interval, new_tracker_interval);
+
+	atomic_set(&bat_priv->mcast_tracker_interval, new_tracker_interval);
+
+	return count;
+}
+
+int mcast_tracker_timeout_set(struct net_device *net_dev, char *buff,
+			       size_t count)
+{
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	unsigned long new_tracker_timeout;
+	int cur_tracker_timeout;
+	int ret;
+
+	ret = strict_strtoul(buff, 10, &new_tracker_timeout);
+
+	if (ret && !strncmp(buff, "auto", 4)) {
+		new_tracker_timeout = 0;
+		goto ok;
+	}
+
+	else if (ret) {
+		bat_info(net_dev, "Invalid parameter for "
+			 "'mcast_tracker_timeout' setting received: %s\n",
+			 buff);
+		return -EINVAL;
+	}
+
+	if (new_tracker_timeout < JITTER) {
+		bat_info(net_dev, "New mcast tracker timeout too small: %li "
+			 "(min: %i or auto)\n", new_tracker_timeout, JITTER);
+		return -EINVAL;
+	}
+
+ok:
+	cur_tracker_timeout = atomic_read(&bat_priv->mcast_tracker_timeout);
+
+	if (cur_tracker_timeout == new_tracker_timeout)
+		return count;
+
+	if (!cur_tracker_timeout && new_tracker_timeout)
+		bat_info(net_dev, "Tracker timeout change from: %s to: %li\n",
+			 "auto", new_tracker_timeout);
+	else if (cur_tracker_timeout && !new_tracker_timeout)
+		bat_info(net_dev, "Tracker timeout change from: %i to: %s\n",
+			 cur_tracker_timeout, "auto");
+	else
+		bat_info(net_dev, "Tracker timeout change from: %i to: %li\n",
+			 cur_tracker_timeout, new_tracker_timeout);
+
+	atomic_set(&bat_priv->mcast_tracker_timeout, new_tracker_timeout);
+
+	return count;
+}
diff --git a/multicast.h b/multicast.h
new file mode 100644
index 0000000..12a3376
--- /dev/null
+++ b/multicast.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2010 B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#ifndef _NET_BATMAN_ADV_MULTICAST_H_
+#define _NET_BATMAN_ADV_MULTICAST_H_
+
+int mcast_tracker_interval_set(struct net_device *net_dev, char *buff,
+			       size_t count);
+int mcast_tracker_timeout_set(struct net_device *net_dev, char *buff,
+			       size_t count);
+
+#endif /* _NET_BATMAN_ADV_MULTICAST_H_ */
diff --git a/packet.h b/packet.h
index bf87ef6..6926ca4 100644
--- a/packet.h
+++ b/packet.h
@@ -50,6 +50,10 @@
 #define VIS_TYPE_SERVER_SYNC		0
 #define VIS_TYPE_CLIENT_UPDATE		1
 
+/* mcast defines */
+#define MCAST_MODE_CLASSIC_FLOODING	0
+#define MCAST_MODE_PROACT_TRACKING	1
+
 /* fragmentation defines */
 #define UNI_FRAG_HEAD 0x01
 
diff --git a/soft-interface.c b/soft-interface.c
index e89ede1..7cea678 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -597,6 +597,10 @@ struct net_device *softif_create(char *name)
 	atomic_set(&bat_priv->gw_bandwidth, 41);
 	atomic_set(&bat_priv->orig_interval, 1000);
 	atomic_set(&bat_priv->hop_penalty, 10);
+	atomic_set(&bat_priv->mcast_mode, MCAST_MODE_CLASSIC_FLOODING);
+	atomic_set(&bat_priv->mcast_tracker_interval, 0);	/* = auto */
+	atomic_set(&bat_priv->mcast_tracker_timeout, 0);	/* = auto */
+	atomic_set(&bat_priv->mcast_fanout, 2);
 	atomic_set(&bat_priv->log_level, 0);
 	atomic_set(&bat_priv->fragmentation, 1);
 	atomic_set(&bat_priv->bcast_queue_left, BCAST_QUEUE_LEN);
diff --git a/types.h b/types.h
index 1d00849..b61d5a8 100644
--- a/types.h
+++ b/types.h
@@ -132,6 +132,10 @@ struct bat_priv {
 	atomic_t gw_bandwidth;		/* gw bandwidth */
 	atomic_t orig_interval;		/* uint */
 	atomic_t hop_penalty;		/* uint */
+	atomic_t mcast_mode;		/* MCAST_MODE_* */
+	atomic_t mcast_tracker_interval;/* uint, auto */
+	atomic_t mcast_tracker_timeout; /* uint, auto */
+	atomic_t mcast_fanout;		/* uint */
 	atomic_t log_level;		/* uint */
 	atomic_t bcast_seqno;
 	atomic_t bcast_queue_left;
-- 
1.7.1

