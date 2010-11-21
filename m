Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:56:02 +0100
Message-Id: <1290383767-32602-25-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 24/29] Staging: batman-adv: adding gateway
	functionality
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Via the /sys filesystem you can change the gateway mode of a node using
gw_mode. Adjustments to it can be done using gw_bandwidth for server
mode and gw_sel_class for client mode.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
[sven.eckelmann@gmx.de: Rework on top of current version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/Makefile             |   19 +-
 drivers/staging/batman-adv/bat_debugfs.c        |   10 +
 drivers/staging/batman-adv/bat_sysfs.c          |  115 +++++++
 drivers/staging/batman-adv/gateway_client.c     |  387 +++++++++++++++++++++++
 drivers/staging/batman-adv/gateway_client.h     |   35 ++
 drivers/staging/batman-adv/gateway_common.c     |  177 +++++++++++
 drivers/staging/batman-adv/gateway_common.h     |   38 +++
 drivers/staging/batman-adv/main.c               |    4 +
 drivers/staging/batman-adv/originator.c         |    6 +
 drivers/staging/batman-adv/packet.h             |    4 +-
 drivers/staging/batman-adv/routing.c            |   16 +-
 drivers/staging/batman-adv/send.c               |    8 +
 drivers/staging/batman-adv/soft-interface.c     |    4 +
 drivers/staging/batman-adv/sysfs-class-net-mesh |   21 ++
 drivers/staging/batman-adv/types.h              |   18 +-
 15 files changed, 858 insertions(+), 4 deletions(-)
 create mode 100644 drivers/staging/batman-adv/gateway_client.c
 create mode 100644 drivers/staging/batman-adv/gateway_client.h
 create mode 100644 drivers/staging/batman-adv/gateway_common.c
 create mode 100644 drivers/staging/batman-adv/gateway_common.h

diff --git a/drivers/staging/batman-adv/Makefile b/drivers/staging/batman-adv/Makefile
index 7892428..d936aec 100644
--- a/drivers/staging/batman-adv/Makefile
+++ b/drivers/staging/batman-adv/Makefile
@@ -19,4 +19,21 @@
 #
 
 obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
-batman-adv-y := main.o bat_debugfs.o bat_sysfs.o send.o routing.o soft-interface.o icmp_socket.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o unicast.o
+batman-adv-y += aggregation.o
+batman-adv-y += bat_debugfs.o
+batman-adv-y += bat_sysfs.o
+batman-adv-y += bitarray.o
+batman-adv-y += gateway_client.o
+batman-adv-y += gateway_common.o
+batman-adv-y += hard-interface.o
+batman-adv-y += hash.o
+batman-adv-y += icmp_socket.o
+batman-adv-y += main.o
+batman-adv-y += originator.o
+batman-adv-y += ring_buffer.o
+batman-adv-y += routing.o
+batman-adv-y += send.o
+batman-adv-y += soft-interface.o
+batman-adv-y += translation-table.o
+batman-adv-y += unicast.o
+batman-adv-y += vis.o
diff --git a/drivers/staging/batman-adv/bat_debugfs.c b/drivers/staging/batman-adv/bat_debugfs.c
index cbac1a5..0ae81d0 100644
--- a/drivers/staging/batman-adv/bat_debugfs.c
+++ b/drivers/staging/batman-adv/bat_debugfs.c
@@ -27,6 +27,8 @@
 #include "translation-table.h"
 #include "originator.h"
 #include "hard-interface.h"
+#include "gateway_common.h"
+#include "gateway_client.h"
 #include "soft-interface.h"
 #include "vis.h"
 #include "icmp_socket.h"
@@ -226,6 +228,12 @@ static int originators_open(struct inode *inode, struct file *file)
 	return single_open(file, orig_seq_print_text, net_dev);
 }
 
+static int gateways_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, gw_client_seq_print_text, net_dev);
+}
+
 static int softif_neigh_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -268,6 +276,7 @@ struct bat_debuginfo bat_debuginfo_##_name = {	\
 };
 
 static BAT_DEBUGINFO(originators, S_IRUGO, originators_open);
+static BAT_DEBUGINFO(gateways, S_IRUGO, gateways_open);
 static BAT_DEBUGINFO(softif_neigh, S_IRUGO, softif_neigh_open);
 static BAT_DEBUGINFO(transtable_global, S_IRUGO, transtable_global_open);
 static BAT_DEBUGINFO(transtable_local, S_IRUGO, transtable_local_open);
@@ -275,6 +284,7 @@ static BAT_DEBUGINFO(vis_data, S_IRUGO, vis_data_open);
 
 static struct bat_debuginfo *mesh_debuginfos[] = {
 	&bat_debuginfo_originators,
+	&bat_debuginfo_gateways,
 	&bat_debuginfo_softif_neigh,
 	&bat_debuginfo_transtable_global,
 	&bat_debuginfo_transtable_local,
diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index 5ff6e5e..cd7bb51 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -24,6 +24,8 @@
 #include "translation-table.h"
 #include "originator.h"
 #include "hard-interface.h"
+#include "gateway_common.h"
+#include "gateway_client.h"
 #include "vis.h"
 
 #define to_dev(obj)		container_of(obj, struct device, kobj)
@@ -249,12 +251,122 @@ static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
 	return count;
 }
 
+static void post_gw_deselect(struct net_device *net_dev)
+{
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	gw_deselect(bat_priv);
+}
+
+static ssize_t show_gw_mode(struct kobject *kobj, struct attribute *attr,
+			    char *buff)
+{
+	struct bat_priv *bat_priv = kobj_to_batpriv(kobj);
+	int bytes_written;
+
+	switch (atomic_read(&bat_priv->gw_mode)) {
+	case GW_MODE_CLIENT:
+		bytes_written = sprintf(buff, "%s\n", GW_MODE_CLIENT_NAME);
+		break;
+	case GW_MODE_SERVER:
+		bytes_written = sprintf(buff, "%s\n", GW_MODE_SERVER_NAME);
+		break;
+	default:
+		bytes_written = sprintf(buff, "%s\n", GW_MODE_OFF_NAME);
+		break;
+	}
+
+	return bytes_written;
+}
+
+static ssize_t store_gw_mode(struct kobject *kobj, struct attribute *attr,
+			     char *buff, size_t count)
+{
+	struct net_device *net_dev = kobj_to_netdev(kobj);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	char *curr_gw_mode_str;
+	int gw_mode_tmp = -1;
+
+	if (buff[count - 1] == '\n')
+		buff[count - 1] = '\0';
+
+	if (strncmp(buff, GW_MODE_OFF_NAME, strlen(GW_MODE_OFF_NAME)) == 0)
+		gw_mode_tmp = GW_MODE_OFF;
+
+	if (strncmp(buff, GW_MODE_CLIENT_NAME,
+		   strlen(GW_MODE_CLIENT_NAME)) == 0)
+		gw_mode_tmp = GW_MODE_CLIENT;
+
+	if (strncmp(buff, GW_MODE_SERVER_NAME,
+		   strlen(GW_MODE_SERVER_NAME)) == 0)
+		gw_mode_tmp = GW_MODE_SERVER;
+
+	if (gw_mode_tmp < 0) {
+		bat_info(net_dev,
+			 "Invalid parameter for 'gw mode' setting received: "
+			 "%s\n", buff);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&bat_priv->gw_mode) == gw_mode_tmp)
+		return count;
+
+	switch (atomic_read(&bat_priv->gw_mode)) {
+	case GW_MODE_CLIENT:
+		curr_gw_mode_str = GW_MODE_CLIENT_NAME;
+		break;
+	case GW_MODE_SERVER:
+		curr_gw_mode_str = GW_MODE_SERVER_NAME;
+		break;
+	default:
+		curr_gw_mode_str = GW_MODE_OFF_NAME;
+		break;
+	}
+
+	bat_info(net_dev, "Changing gw mode from: %s to: %s\n",
+		 curr_gw_mode_str, buff);
+
+	gw_deselect(bat_priv);
+	atomic_set(&bat_priv->gw_mode, (unsigned)gw_mode_tmp);
+	return count;
+}
+
+static ssize_t show_gw_bwidth(struct kobject *kobj, struct attribute *attr,
+			      char *buff)
+{
+	struct bat_priv *bat_priv = kobj_to_batpriv(kobj);
+	int down, up;
+	int gw_bandwidth = atomic_read(&bat_priv->gw_bandwidth);
+
+	gw_bandwidth_to_kbit(gw_bandwidth, &down, &up);
+	return sprintf(buff, "%i%s/%i%s\n",
+		       (down > 2048 ? down / 1024 : down),
+		       (down > 2048 ? "MBit" : "KBit"),
+		       (up > 2048 ? up / 1024 : up),
+		       (up > 2048 ? "MBit" : "KBit"));
+}
+
+static ssize_t store_gw_bwidth(struct kobject *kobj, struct attribute *attr,
+			       char *buff, size_t count)
+{
+	struct net_device *net_dev = kobj_to_netdev(kobj);
+
+	if (buff[count - 1] == '\n')
+		buff[count - 1] = '\0';
+
+	return gw_bandwidth_set(net_dev, buff, count);
+}
+
 BAT_ATTR_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
+static BAT_ATTR(gw_mode, S_IRUGO | S_IWUSR, show_gw_mode, store_gw_mode);
 BAT_ATTR_UINT(orig_interval, S_IRUGO | S_IWUSR, 2 * JITTER, INT_MAX, NULL);
 BAT_ATTR_UINT(hop_penalty, S_IRUGO | S_IWUSR, 0, TQ_MAX_VALUE, NULL);
+BAT_ATTR_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, TQ_MAX_VALUE,
+	      post_gw_deselect);
+static BAT_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, show_gw_bwidth,
+		store_gw_bwidth);
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 BAT_ATTR_UINT(log_level, S_IRUGO | S_IWUSR, 0, 3, NULL);
 #endif
@@ -264,8 +376,11 @@ static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_bonding,
 	&bat_attr_fragmentation,
 	&bat_attr_vis_mode,
+	&bat_attr_gw_mode,
 	&bat_attr_orig_interval,
 	&bat_attr_hop_penalty,
+	&bat_attr_gw_sel_class,
+	&bat_attr_gw_bandwidth,
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 	&bat_attr_log_level,
 #endif
diff --git a/drivers/staging/batman-adv/gateway_client.c b/drivers/staging/batman-adv/gateway_client.c
new file mode 100644
index 0000000..1846a62
--- /dev/null
+++ b/drivers/staging/batman-adv/gateway_client.c
@@ -0,0 +1,387 @@
+/*
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner
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
+#include "gateway_client.h"
+#include "gateway_common.h"
+#include "hard-interface.h"
+
+static void gw_node_free_ref(struct kref *refcount)
+{
+	struct gw_node *gw_node;
+
+	gw_node = container_of(refcount, struct gw_node, refcount);
+	kfree(gw_node);
+}
+
+static void gw_node_free_rcu(struct rcu_head *rcu)
+{
+	struct gw_node *gw_node;
+
+	gw_node = container_of(rcu, struct gw_node, rcu);
+	kref_put(&gw_node->refcount, gw_node_free_ref);
+}
+
+void gw_deselect(struct bat_priv *bat_priv)
+{
+	struct gw_node *gw_node = bat_priv->curr_gw;
+
+	bat_priv->curr_gw = NULL;
+
+	if (gw_node)
+		kref_put(&gw_node->refcount, gw_node_free_ref);
+}
+
+static struct gw_node *gw_select(struct bat_priv *bat_priv,
+			  struct gw_node *new_gw_node)
+{
+	struct gw_node *curr_gw_node = bat_priv->curr_gw;
+
+	if (new_gw_node)
+		kref_get(&new_gw_node->refcount);
+
+	bat_priv->curr_gw = new_gw_node;
+	return curr_gw_node;
+}
+
+void gw_election(struct bat_priv *bat_priv)
+{
+	struct hlist_node *node;
+	struct gw_node *gw_node, *curr_gw_tmp = NULL, *old_gw_node = NULL;
+	uint8_t max_tq = 0;
+	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
+	int down, up;
+
+	/**
+	 * The batman daemon checks here if we already passed a full originator
+	 * cycle in order to make sure we don't choose the first gateway we
+	 * hear about. This check is based on the daemon's uptime which we
+	 * don't have.
+	 **/
+	if (atomic_read(&bat_priv->gw_mode) != GW_MODE_CLIENT)
+		return;
+
+	if (bat_priv->curr_gw)
+		return;
+
+	rcu_read_lock();
+	if (hlist_empty(&bat_priv->gw_list)) {
+		rcu_read_unlock();
+
+		if (bat_priv->curr_gw) {
+			bat_dbg(DBG_BATMAN, bat_priv,
+				"Removing selected gateway - "
+				"no gateway in range\n");
+			gw_deselect(bat_priv);
+		}
+
+		return;
+	}
+
+	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
+		if (!gw_node->orig_node->router)
+			continue;
+
+		if (gw_node->deleted)
+			continue;
+
+		switch (atomic_read(&bat_priv->gw_sel_class)) {
+		case 1: /* fast connection */
+			gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags,
+					     &down, &up);
+
+			tmp_gw_factor = (gw_node->orig_node->router->tq_avg *
+					 gw_node->orig_node->router->tq_avg *
+					 down * 100 * 100) /
+					 (TQ_LOCAL_WINDOW_SIZE *
+					 TQ_LOCAL_WINDOW_SIZE * 64);
+
+			if ((tmp_gw_factor > max_gw_factor) ||
+			    ((tmp_gw_factor == max_gw_factor) &&
+			     (gw_node->orig_node->router->tq_avg > max_tq)))
+				curr_gw_tmp = gw_node;
+			break;
+
+		default: /**
+			  * 2:  stable connection (use best statistic)
+			  * 3:  fast-switch (use best statistic but change as
+			  *     soon as a better gateway appears)
+			  * XX: late-switch (use best statistic but change as
+			  *     soon as a better gateway appears which has
+			  *     $routing_class more tq points)
+			  **/
+			if (gw_node->orig_node->router->tq_avg > max_tq)
+				curr_gw_tmp = gw_node;
+			break;
+		}
+
+		if (gw_node->orig_node->router->tq_avg > max_tq)
+			max_tq = gw_node->orig_node->router->tq_avg;
+
+		if (tmp_gw_factor > max_gw_factor)
+			max_gw_factor = tmp_gw_factor;
+	}
+
+	if (bat_priv->curr_gw != curr_gw_tmp) {
+		if ((bat_priv->curr_gw) && (!curr_gw_tmp))
+			bat_dbg(DBG_BATMAN, bat_priv,
+				"Removing selected gateway - "
+				"no gateway in range\n");
+		else if ((!bat_priv->curr_gw) && (curr_gw_tmp))
+			bat_dbg(DBG_BATMAN, bat_priv,
+				"Adding route to gateway %pM "
+				"(gw_flags: %i, tq: %i)\n",
+				curr_gw_tmp->orig_node->orig,
+				curr_gw_tmp->orig_node->gw_flags,
+				curr_gw_tmp->orig_node->router->tq_avg);
+		else
+			bat_dbg(DBG_BATMAN, bat_priv,
+				"Changing route to gateway %pM "
+				"(gw_flags: %i, tq: %i)\n",
+				curr_gw_tmp->orig_node->orig,
+				curr_gw_tmp->orig_node->gw_flags,
+				curr_gw_tmp->orig_node->router->tq_avg);
+
+		old_gw_node = gw_select(bat_priv, curr_gw_tmp);
+	}
+
+	rcu_read_unlock();
+
+	/* the kfree() has to be outside of the rcu lock */
+	if (old_gw_node)
+		kref_put(&old_gw_node->refcount, gw_node_free_ref);
+}
+
+void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
+{
+	struct gw_node *curr_gateway_tmp = bat_priv->curr_gw;
+	uint8_t gw_tq_avg, orig_tq_avg;
+
+	if (!curr_gateway_tmp)
+		return;
+
+	if (!curr_gateway_tmp->orig_node)
+		goto deselect;
+
+	if (!curr_gateway_tmp->orig_node->router)
+		goto deselect;
+
+	/* this node already is the gateway */
+	if (curr_gateway_tmp->orig_node == orig_node)
+		return;
+
+	if (!orig_node->router)
+		return;
+
+	gw_tq_avg = curr_gateway_tmp->orig_node->router->tq_avg;
+	orig_tq_avg = orig_node->router->tq_avg;
+
+	/* the TQ value has to be better */
+	if (orig_tq_avg < gw_tq_avg)
+		return;
+
+	/**
+	 * if the routing class is greater than 3 the value tells us how much
+	 * greater the TQ value of the new gateway must be
+	 **/
+	if ((atomic_read(&bat_priv->gw_sel_class) > 3) &&
+	    (orig_tq_avg - gw_tq_avg < atomic_read(&bat_priv->gw_sel_class)))
+		return;
+
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"Restarting gateway selection: better gateway found (tq curr: "
+		"%i, tq new: %i)\n",
+		gw_tq_avg, orig_tq_avg);
+
+deselect:
+	gw_deselect(bat_priv);
+}
+
+static void gw_node_add(struct bat_priv *bat_priv,
+			struct orig_node *orig_node, uint8_t new_gwflags)
+{
+	struct gw_node *gw_node;
+	int down, up;
+
+	gw_node = kmalloc(sizeof(struct gw_node), GFP_ATOMIC);
+	if (!gw_node)
+		return;
+
+	memset(gw_node, 0, sizeof(struct gw_node));
+	INIT_HLIST_NODE(&gw_node->list);
+	gw_node->orig_node = orig_node;
+	kref_init(&gw_node->refcount);
+
+	spin_lock_bh(&bat_priv->gw_list_lock);
+	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw_list);
+	spin_unlock_bh(&bat_priv->gw_list_lock);
+
+	gw_bandwidth_to_kbit(new_gwflags, &down, &up);
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"Found new gateway %pM -> gw_class: %i - %i%s/%i%s\n",
+		orig_node->orig, new_gwflags,
+		(down > 2048 ? down / 1024 : down),
+		(down > 2048 ? "MBit" : "KBit"),
+		(up > 2048 ? up / 1024 : up),
+		(up > 2048 ? "MBit" : "KBit"));
+}
+
+void gw_node_update(struct bat_priv *bat_priv,
+		    struct orig_node *orig_node, uint8_t new_gwflags)
+{
+	struct hlist_node *node;
+	struct gw_node *gw_node;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
+		if (gw_node->orig_node != orig_node)
+			continue;
+
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"Gateway class of originator %pM changed from "
+			"%i to %i\n",
+			orig_node->orig, gw_node->orig_node->gw_flags,
+			new_gwflags);
+
+		gw_node->deleted = 0;
+
+		if (new_gwflags == 0) {
+			gw_node->deleted = jiffies;
+			bat_dbg(DBG_BATMAN, bat_priv,
+				"Gateway %pM removed from gateway list\n",
+				orig_node->orig);
+
+			if (gw_node == bat_priv->curr_gw) {
+				rcu_read_unlock();
+				gw_deselect(bat_priv);
+				return;
+			}
+		}
+
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+
+	if (new_gwflags == 0)
+		return;
+
+	gw_node_add(bat_priv, orig_node, new_gwflags);
+}
+
+void gw_node_delete(struct bat_priv *bat_priv, struct orig_node *orig_node)
+{
+	return gw_node_update(bat_priv, orig_node, 0);
+}
+
+void gw_node_purge(struct bat_priv *bat_priv)
+{
+	struct gw_node *gw_node;
+	struct hlist_node *node, *node_tmp;
+	unsigned long timeout = 2 * PURGE_TIMEOUT * HZ;
+
+	spin_lock_bh(&bat_priv->gw_list_lock);
+
+	hlist_for_each_entry_safe(gw_node, node, node_tmp,
+				  &bat_priv->gw_list, list) {
+		if (((!gw_node->deleted) ||
+		     (time_before(jiffies, gw_node->deleted + timeout))) &&
+		    atomic_read(&bat_priv->mesh_state) == MESH_ACTIVE)
+			continue;
+
+		if (bat_priv->curr_gw == gw_node)
+			gw_deselect(bat_priv);
+
+		hlist_del_rcu(&gw_node->list);
+		call_rcu(&gw_node->rcu, gw_node_free_rcu);
+	}
+
+
+	spin_unlock_bh(&bat_priv->gw_list_lock);
+}
+
+static int _write_buffer_text(struct bat_priv *bat_priv,
+			      struct seq_file *seq, struct gw_node *gw_node)
+{
+	int down, up;
+
+	gw_bandwidth_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
+
+	return seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %3i - %i%s/%i%s\n",
+		       (bat_priv->curr_gw == gw_node ? "=>" : "  "),
+		       gw_node->orig_node->orig,
+		       gw_node->orig_node->router->tq_avg,
+		       gw_node->orig_node->router->addr,
+		       gw_node->orig_node->router->if_incoming->net_dev->name,
+		       gw_node->orig_node->gw_flags,
+		       (down > 2048 ? down / 1024 : down),
+		       (down > 2048 ? "MBit" : "KBit"),
+		       (up > 2048 ? up / 1024 : up),
+		       (up > 2048 ? "MBit" : "KBit"));
+}
+
+int gw_client_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct gw_node *gw_node;
+	struct hlist_node *node;
+	int gw_count = 0;
+
+	if (!bat_priv->primary_if) {
+
+		return seq_printf(seq, "BATMAN mesh %s disabled - please "
+				  "specify interfaces to enable it\n",
+				  net_dev->name);
+	}
+
+	if (bat_priv->primary_if->if_status != IF_ACTIVE) {
+
+		return seq_printf(seq, "BATMAN mesh %s disabled - "
+				       "primary interface not active\n",
+				       net_dev->name);
+	}
+
+	seq_printf(seq, "      %-12s (%s/%i) %17s [%10s]: gw_class ... "
+		   "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%pM (%s)]\n",
+		   "Gateway", "#", TQ_MAX_VALUE, "Nexthop",
+		   "outgoingIF", SOURCE_VERSION, REVISION_VERSION_STR,
+		   bat_priv->primary_if->net_dev->name,
+		   bat_priv->primary_if->net_dev->dev_addr, net_dev->name);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
+		if (gw_node->deleted)
+			continue;
+
+		if (!gw_node->orig_node->router)
+			continue;
+
+		_write_buffer_text(bat_priv, seq, gw_node);
+		gw_count++;
+	}
+	rcu_read_unlock();
+
+	if (gw_count == 0)
+		seq_printf(seq, "No gateways in range ...\n");
+
+	return 0;
+}
diff --git a/drivers/staging/batman-adv/gateway_client.h b/drivers/staging/batman-adv/gateway_client.h
new file mode 100644
index 0000000..7383b90
--- /dev/null
+++ b/drivers/staging/batman-adv/gateway_client.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner
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
+#ifndef _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
+#define _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
+
+void gw_deselect(struct bat_priv *bat_priv);
+void gw_election(struct bat_priv *bat_priv);
+void *gw_get_selected(struct bat_priv *bat_priv);
+void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node);
+void gw_node_update(struct bat_priv *bat_priv,
+		    struct orig_node *orig_node, uint8_t new_gwflags);
+void gw_node_delete(struct bat_priv *bat_priv, struct orig_node *orig_node);
+void gw_node_purge(struct bat_priv *bat_priv);
+int gw_client_seq_print_text(struct seq_file *seq, void *offset);
+
+#endif /* _NET_BATMAN_ADV_GATEWAY_CLIENT_H_ */
diff --git a/drivers/staging/batman-adv/gateway_common.c b/drivers/staging/batman-adv/gateway_common.c
new file mode 100644
index 0000000..b962982
--- /dev/null
+++ b/drivers/staging/batman-adv/gateway_common.c
@@ -0,0 +1,177 @@
+/*
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner
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
+#include "gateway_common.h"
+#include "gateway_client.h"
+
+/* calculates the gateway class from kbit */
+static void kbit_to_gw_bandwidth(int down, int up, long *gw_srv_class)
+{
+	int mdown = 0, tdown, tup, difference;
+	uint8_t sbit, part;
+
+	*gw_srv_class = 0;
+	difference = 0x0FFFFFFF;
+
+	/* test all downspeeds */
+	for (sbit = 0; sbit < 2; sbit++) {
+		for (part = 0; part < 16; part++) {
+			tdown = 32 * (sbit + 2) * (1 << part);
+
+			if (abs(tdown - down) < difference) {
+				*gw_srv_class = (sbit << 7) + (part << 3);
+				difference = abs(tdown - down);
+				mdown = tdown;
+			}
+		}
+	}
+
+	/* test all upspeeds */
+	difference = 0x0FFFFFFF;
+
+	for (part = 0; part < 8; part++) {
+		tup = ((part + 1) * (mdown)) / 8;
+
+		if (abs(tup - up) < difference) {
+			*gw_srv_class = (*gw_srv_class & 0xF8) | part;
+			difference = abs(tup - up);
+		}
+	}
+}
+
+/* returns the up and downspeeds in kbit, calculated from the class */
+void gw_bandwidth_to_kbit(uint8_t gw_srv_class, int *down, int *up)
+{
+	char sbit = (gw_srv_class & 0x80) >> 7;
+	char dpart = (gw_srv_class & 0x78) >> 3;
+	char upart = (gw_srv_class & 0x07);
+
+	if (!gw_srv_class) {
+		*down = 0;
+		*up = 0;
+		return;
+	}
+
+	*down = 32 * (sbit + 2) * (1 << dpart);
+	*up = ((upart + 1) * (*down)) / 8;
+}
+
+static bool parse_gw_bandwidth(struct net_device *net_dev, char *buff,
+			       long *up, long *down)
+{
+	int ret, multi = 1;
+	char *slash_ptr, *tmp_ptr;
+
+	slash_ptr = strchr(buff, '/');
+	if (slash_ptr)
+		*slash_ptr = 0;
+
+	if (strlen(buff) > 4) {
+		tmp_ptr = buff + strlen(buff) - 4;
+
+		if (strnicmp(tmp_ptr, "mbit", 4) == 0)
+			multi = 1024;
+
+		if ((strnicmp(tmp_ptr, "kbit", 4) == 0) ||
+			(multi > 1))
+			*tmp_ptr = '\0';
+	}
+
+	ret = strict_strtoul(buff, 10, down);
+	if (ret) {
+		bat_err(net_dev,
+			"Download speed of gateway mode invalid: %s\n",
+			buff);
+		return false;
+	}
+
+	*down *= multi;
+
+	/* we also got some upload info */
+	if (slash_ptr) {
+		multi = 1;
+
+		if (strlen(slash_ptr + 1) > 4) {
+			tmp_ptr = slash_ptr + 1 - 4 + strlen(slash_ptr + 1);
+
+			if (strnicmp(tmp_ptr, "mbit", 4) == 0)
+				multi = 1024;
+
+			if ((strnicmp(tmp_ptr, "kbit", 4) == 0) ||
+				(multi > 1))
+				*tmp_ptr = '\0';
+		}
+
+		ret = strict_strtoul(slash_ptr + 1, 10, up);
+		if (ret) {
+			bat_err(net_dev,
+				"Upload speed of gateway mode invalid: "
+				"%s\n", slash_ptr + 1);
+			return false;
+		}
+
+		*up *= multi;
+	}
+
+	return true;
+}
+
+ssize_t gw_bandwidth_set(struct net_device *net_dev, char *buff, size_t count)
+{
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	long gw_bandwidth_tmp = 0, up = 0, down = 0;
+	bool ret;
+
+	ret = parse_gw_bandwidth(net_dev, buff, &up, &down);
+	if (!ret)
+		goto end;
+
+	if ((!down) || (down < 256))
+		down = 2000;
+
+	if (!up)
+		up = down / 5;
+
+	kbit_to_gw_bandwidth(down, up, &gw_bandwidth_tmp);
+
+	/**
+	 * the gw bandwidth we guessed above might not match the given
+	 * speeds, hence we need to calculate it back to show the number
+	 * that is going to be propagated
+	 **/
+	gw_bandwidth_to_kbit((uint8_t)gw_bandwidth_tmp,
+			     (int *)&down, (int *)&up);
+
+	gw_deselect(bat_priv);
+	bat_info(net_dev, "Changing gateway bandwidth from: '%i' to: '%ld' "
+		 "(propagating: %ld%s/%ld%s)\n",
+		 atomic_read(&bat_priv->gw_bandwidth), gw_bandwidth_tmp,
+		 (down > 2048 ? down / 1024 : down),
+		 (down > 2048 ? "MBit" : "KBit"),
+		 (up > 2048 ? up / 1024 : up),
+		 (up > 2048 ? "MBit" : "KBit"));
+
+	atomic_set(&bat_priv->gw_bandwidth, gw_bandwidth_tmp);
+
+end:
+	return count;
+}
diff --git a/drivers/staging/batman-adv/gateway_common.h b/drivers/staging/batman-adv/gateway_common.h
new file mode 100644
index 0000000..5e728d0
--- /dev/null
+++ b/drivers/staging/batman-adv/gateway_common.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner
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
+#ifndef _NET_BATMAN_ADV_GATEWAY_COMMON_H_
+#define _NET_BATMAN_ADV_GATEWAY_COMMON_H_
+
+enum gw_modes {
+	GW_MODE_OFF,
+	GW_MODE_CLIENT,
+	GW_MODE_SERVER,
+};
+
+#define GW_MODE_OFF_NAME	"off"
+#define GW_MODE_CLIENT_NAME	"client"
+#define GW_MODE_SERVER_NAME	"server"
+
+void gw_bandwidth_to_kbit(uint8_t gw_class, int *down, int *up);
+ssize_t gw_bandwidth_set(struct net_device *net_dev, char *buff, size_t count);
+
+#endif /* _NET_BATMAN_ADV_GATEWAY_COMMON_H_ */
diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index 61d1aa6..c91e635 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -29,6 +29,7 @@
 #include "icmp_socket.h"
 #include "translation-table.h"
 #include "hard-interface.h"
+#include "gateway_client.h"
 #include "types.h"
 #include "vis.h"
 #include "hash.h"
@@ -84,12 +85,14 @@ int mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->forw_bcast_list_lock);
 	spin_lock_init(&bat_priv->hna_lhash_lock);
 	spin_lock_init(&bat_priv->hna_ghash_lock);
+	spin_lock_init(&bat_priv->gw_list_lock);
 	spin_lock_init(&bat_priv->vis_hash_lock);
 	spin_lock_init(&bat_priv->vis_list_lock);
 	spin_lock_init(&bat_priv->softif_neigh_lock);
 
 	INIT_HLIST_HEAD(&bat_priv->forw_bat_list);
 	INIT_HLIST_HEAD(&bat_priv->forw_bcast_list);
+	INIT_HLIST_HEAD(&bat_priv->gw_list);
 	INIT_HLIST_HEAD(&bat_priv->softif_neigh_list);
 
 	if (originator_init(bat_priv) < 1)
@@ -129,6 +132,7 @@ void mesh_free(struct net_device *soft_iface)
 
 	vis_quit(bat_priv);
 
+	gw_node_purge(bat_priv);
 	originator_free(bat_priv);
 
 	hna_local_free(bat_priv);
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 8bef468..89ec021 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -26,6 +26,7 @@
 #include "hash.h"
 #include "translation-table.h"
 #include "routing.h"
+#include "gateway_client.h"
 #include "hard-interface.h"
 #include "unicast.h"
 #include "soft-interface.h"
@@ -279,6 +280,8 @@ static void _purge_orig(struct bat_priv *bat_priv)
 		orig_node = bucket->data;
 
 		if (purge_orig_node(bat_priv, orig_node)) {
+			if (orig_node->gw_flags)
+				gw_node_delete(bat_priv, orig_node);
 			hash_remove_bucket(bat_priv->orig_hash, &hashit);
 			free_orig_node(orig_node, bat_priv);
 		}
@@ -290,6 +293,9 @@ static void _purge_orig(struct bat_priv *bat_priv)
 
 	spin_unlock_bh(&bat_priv->orig_hash_lock);
 
+	gw_node_purge(bat_priv);
+	gw_election(bat_priv);
+
 	softif_neigh_purge(bat_priv);
 }
 
diff --git a/drivers/staging/batman-adv/packet.h b/drivers/staging/batman-adv/packet.h
index 2693383..b49fdf7 100644
--- a/drivers/staging/batman-adv/packet.h
+++ b/drivers/staging/batman-adv/packet.h
@@ -32,7 +32,7 @@
 #define BAT_UNICAST_FRAG 0x06
 
 /* this file is included by batctl which needs these defines */
-#define COMPAT_VERSION 13
+#define COMPAT_VERSION 12
 #define DIRECTLINK 0x40
 #define VIS_SERVER 0x20
 #define PRIMARIES_FIRST_HOP 0x10
@@ -61,6 +61,8 @@ struct batman_packet {
 	uint8_t  prev_sender[6];
 	uint8_t  ttl;
 	uint8_t  num_hna;
+	uint8_t  gw_flags;  /* flags related to gateway class */
+	uint8_t  align;
 } __attribute__((packed));
 
 #define BAT_PACKET_LEN sizeof(struct batman_packet)
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 1536963..9f31167 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -32,6 +32,8 @@
 #include "ring_buffer.h"
 #include "vis.h"
 #include "aggregation.h"
+#include "gateway_common.h"
+#include "gateway_client.h"
 #include "unicast.h"
 
 void slide_own_bcast_window(struct batman_if *batman_if)
@@ -316,11 +318,23 @@ static void update_orig(struct bat_priv *bat_priv,
 
 	update_routes(bat_priv, orig_node, neigh_node,
 		      hna_buff, tmp_hna_buff_len);
-	return;
+	goto update_gw;
 
 update_hna:
 	update_routes(bat_priv, orig_node, orig_node->router,
 		      hna_buff, tmp_hna_buff_len);
+
+update_gw:
+	if (orig_node->gw_flags != batman_packet->gw_flags)
+		gw_node_update(bat_priv, orig_node, batman_packet->gw_flags);
+
+	orig_node->gw_flags = batman_packet->gw_flags;
+
+	/* restart gateway selection if fast or late switching was enabled */
+	if ((orig_node->gw_flags) &&
+	    (atomic_read(&bat_priv->gw_mode) == GW_MODE_CLIENT) &&
+	    (atomic_read(&bat_priv->gw_sel_class) > 2))
+		gw_check_election(bat_priv, orig_node);
 }
 
 /* checks whether the host restarted and is in the protection time.
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index 9ed77d7..36945dc 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -28,6 +28,7 @@
 #include "types.h"
 #include "vis.h"
 #include "aggregation.h"
+#include "gateway_common.h"
 #include "originator.h"
 
 
@@ -284,6 +285,13 @@ void schedule_own_packet(struct batman_if *batman_if)
 	else
 		batman_packet->flags &= ~VIS_SERVER;
 
+	if ((batman_if == bat_priv->primary_if) &&
+	    (atomic_read(&bat_priv->gw_mode) == GW_MODE_SERVER))
+		batman_packet->gw_flags =
+				(uint8_t)atomic_read(&bat_priv->gw_bandwidth);
+	else
+		batman_packet->gw_flags = 0;
+
 	atomic_inc(&batman_if->seqno);
 
 	slide_own_bcast_window(batman_if);
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index 28ffe34..64eaf2a 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -28,6 +28,7 @@
 #include "translation-table.h"
 #include "types.h"
 #include "hash.h"
+#include "gateway_common.h"
 #include "send.h"
 #include "bat_sysfs.h"
 #include <linux/slab.h>
@@ -579,6 +580,9 @@ struct net_device *softif_create(char *name)
 	atomic_set(&bat_priv->aggregated_ogms, 1);
 	atomic_set(&bat_priv->bonding, 0);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
+	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
+	atomic_set(&bat_priv->gw_sel_class, 20);
+	atomic_set(&bat_priv->gw_bandwidth, 41);
 	atomic_set(&bat_priv->orig_interval, 1000);
 	atomic_set(&bat_priv->hop_penalty, 10);
 	atomic_set(&bat_priv->log_level, 0);
diff --git a/drivers/staging/batman-adv/sysfs-class-net-mesh b/drivers/staging/batman-adv/sysfs-class-net-mesh
index bd20e14..748fe17 100644
--- a/drivers/staging/batman-adv/sysfs-class-net-mesh
+++ b/drivers/staging/batman-adv/sysfs-class-net-mesh
@@ -22,6 +22,27 @@ Description:
                 mesh will be fragmented or silently discarded if the
                 packet size exceeds the outgoing interface MTU.
 
+What:           /sys/class/net/<mesh_iface>/mesh/gw_bandwidth
+Date:           October 2010
+Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Description:
+                Defines the bandwidth which is propagated by this
+                node if gw_mode was set to 'server'.
+
+What:           /sys/class/net/<mesh_iface>/mesh/gw_mode
+Date:           October 2010
+Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Description:
+                Defines the state of the gateway features. Can be
+                either 'off', 'client' or 'server'.
+
+What:           /sys/class/net/<mesh_iface>/mesh/gw_sel_class
+Date:           October 2010
+Contact:        Marek Lindner <lindner_marek@yahoo.de>
+Description:
+                Defines the selection criteria this node will use
+                to choose a gateway if gw_mode was set to 'client'.
+
 What:           /sys/class/net/<mesh_iface>/mesh/orig_interval
 Date:           May 2010
 Contact:        Marek Lindner <lindner_marek@yahoo.de>
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index e41f95f..1d00849 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -55,6 +55,7 @@ struct batman_if {
  *	@last_valid: when last packet from this node was received
  *	@bcast_seqno_reset: time when the broadcast seqno window was reset
  *	@batman_seqno_reset: time when the batman seqno window was reset
+ *	@gw_flags: flags related to gateway class
  *	@flags: for now only VIS_SERVER flag
  *	@last_real_seqno: last and best known squence number
  *	@last_ttl: ttl of last received packet
@@ -74,7 +75,8 @@ struct orig_node {
 	unsigned long last_valid;
 	unsigned long bcast_seqno_reset;
 	unsigned long batman_seqno_reset;
-	uint8_t  flags;
+	uint8_t gw_flags;
+	uint8_t flags;
 	unsigned char *hna_buff;
 	int16_t hna_buff_len;
 	uint32_t last_real_seqno;
@@ -90,6 +92,14 @@ struct orig_node {
 	} bond;
 };
 
+struct gw_node {
+	struct hlist_node list;
+	struct orig_node *orig_node;
+	unsigned long deleted;
+	struct kref refcount;
+	struct rcu_head rcu;
+};
+
 /**
  *	neigh_node
  *	@last_valid: when last packet via this neighbor was received
@@ -117,6 +127,9 @@ struct bat_priv {
 	atomic_t bonding;		/* boolean */
 	atomic_t fragmentation;		/* boolean */
 	atomic_t vis_mode;		/* VIS_TYPE_* */
+	atomic_t gw_mode;		/* GW_MODE_* */
+	atomic_t gw_sel_class;		/* uint */
+	atomic_t gw_bandwidth;		/* gw bandwidth */
 	atomic_t orig_interval;		/* uint */
 	atomic_t hop_penalty;		/* uint */
 	atomic_t log_level;		/* uint */
@@ -132,6 +145,7 @@ struct bat_priv {
 	struct dentry *debug_dir;
 	struct hlist_head forw_bat_list;
 	struct hlist_head forw_bcast_list;
+	struct hlist_head gw_list;
 	struct list_head vis_send_list;
 	struct hashtable_t *orig_hash;
 	struct hashtable_t *hna_local_hash;
@@ -142,6 +156,7 @@ struct bat_priv {
 	spinlock_t forw_bcast_list_lock; /* protects  */
 	spinlock_t hna_lhash_lock; /* protects hna_local_hash */
 	spinlock_t hna_ghash_lock; /* protects hna_global_hash */
+	spinlock_t gw_list_lock; /* protects gw_list */
 	spinlock_t vis_hash_lock; /* protects vis_hash */
 	spinlock_t vis_list_lock; /* protects vis_info::recv_list */
 	spinlock_t softif_neigh_lock; /* protects soft-interface neigh list */
@@ -150,6 +165,7 @@ struct bat_priv {
 	struct delayed_work hna_work;
 	struct delayed_work orig_work;
 	struct delayed_work vis_work;
+	struct gw_node *curr_gw;
 	struct vis_info *my_vis_info;
 };
 
-- 
1.7.2.3

