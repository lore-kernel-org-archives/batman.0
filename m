Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  6 May 2010 22:18:39 +0200
Message-Id: <1273177132-8792-14-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 13/26] staging:batman-adv: convert multiple
	/proc files to use sysfs
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

This is the first patch in a series of patches which aim to convert
all batman-adv /proc files to sysfs. To keep the changes in a
digestable size it has been split up into smaller chunks. During
the transition period batman-adv will use /proc as well as sysfs.

As a first step the following files have been converted:
aggregate_ogm, originators, transtable_global, transtable_local

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/Makefile            |    2 +-
 drivers/staging/batman-adv/aggregation.c       |    7 +-
 drivers/staging/batman-adv/aggregation.h       |    3 +-
 drivers/staging/batman-adv/bat_sysfs.c         |  272 +++++++++++++++++++++++
 drivers/staging/batman-adv/bat_sysfs.h         |   26 +++
 drivers/staging/batman-adv/main.c              |   11 +-
 drivers/staging/batman-adv/main.h              |    1 -
 drivers/staging/batman-adv/originator.c        |   73 ++++++
 drivers/staging/batman-adv/originator.h        |    2 +-
 drivers/staging/batman-adv/proc.c              |  279 +-----------------------
 drivers/staging/batman-adv/proc.h              |    4 -
 drivers/staging/batman-adv/send.c              |   15 +-
 drivers/staging/batman-adv/translation-table.c |   42 +++-
 drivers/staging/batman-adv/translation-table.h |    6 +-
 drivers/staging/batman-adv/types.h             |    2 +
 15 files changed, 439 insertions(+), 306 deletions(-)
 create mode 100644 drivers/staging/batman-adv/bat_sysfs.c
 create mode 100644 drivers/staging/batman-adv/bat_sysfs.h

diff --git a/drivers/staging/batman-adv/Makefile b/drivers/staging/batman-adv/Makefile
index cf2915d..9ad0429 100644
--- a/drivers/staging/batman-adv/Makefile
+++ b/drivers/staging/batman-adv/Makefile
@@ -19,4 +19,4 @@
 #
 
 obj-m += batman-adv.o
-batman-adv-objs := main.o proc.o send.o routing.o soft-interface.o device.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o
+batman-adv-objs := main.o proc.o send.o routing.o soft-interface.o device.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o bat_sysfs.o
diff --git a/drivers/staging/batman-adv/aggregation.c b/drivers/staging/batman-adv/aggregation.c
index b8338ce..c946839 100644
--- a/drivers/staging/batman-adv/aggregation.c
+++ b/drivers/staging/batman-adv/aggregation.c
@@ -167,7 +167,8 @@ static void aggregate(struct forw_packet *forw_packet_aggr,
 
 void add_bat_packet_to_list(unsigned char *packet_buff, int packet_len,
 			    struct batman_if *if_incoming, char own_packet,
-			    unsigned long send_time)
+			    unsigned long send_time,
+			    struct bat_priv *bat_priv)
 {
 	/**
 	 * _aggr -> pointer to the packet we want to aggregate with
@@ -183,7 +184,7 @@ void add_bat_packet_to_list(unsigned char *packet_buff, int packet_len,
 	/* find position for the packet in the forward queue */
 	spin_lock_irqsave(&forw_bat_list_lock, flags);
 	/* own packets are not to be aggregated */
-	if ((atomic_read(&aggregation_enabled)) && (!own_packet)) {
+	if ((atomic_read(&bat_priv->aggregation_enabled)) && (!own_packet)) {
 		hlist_for_each_entry(forw_packet_pos, tmp_node, &forw_bat_list,
 				     list) {
 			if (can_aggregate_with(batman_packet,
@@ -210,7 +211,7 @@ void add_bat_packet_to_list(unsigned char *packet_buff, int packet_len,
 		 * later on
 		 */
 		if ((!own_packet) &&
-		    (atomic_read(&aggregation_enabled)))
+		    (atomic_read(&bat_priv->aggregation_enabled)))
 			send_time += msecs_to_jiffies(MAX_AGGREGATION_MS);
 
 		new_aggregated_packet(packet_buff, packet_len,
diff --git a/drivers/staging/batman-adv/aggregation.h b/drivers/staging/batman-adv/aggregation.h
index bcd32c1..29e1ffc 100644
--- a/drivers/staging/batman-adv/aggregation.h
+++ b/drivers/staging/batman-adv/aggregation.h
@@ -32,6 +32,7 @@ static inline int aggregated_packet(int buff_pos, int packet_len, int num_hna)
 
 void add_bat_packet_to_list(unsigned char *packet_buff, int packet_len,
 			    struct batman_if *if_outgoing, char own_packet,
-			    unsigned long send_time);
+			    unsigned long send_time,
+			    struct bat_priv *bat_priv);
 void receive_aggr_bat_packet(struct ethhdr *ethhdr, unsigned char *packet_buff,
 			     int packet_len, struct batman_if *if_incoming);
diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
new file mode 100644
index 0000000..6293118
--- /dev/null
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -0,0 +1,272 @@
+/*
+ * Copyright (C) 2010 B.A.T.M.A.N. contributors:
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
+#include "bat_sysfs.h"
+#include "translation-table.h"
+#include "originator.h"
+#include "hard-interface.h"
+
+#define to_dev(obj)     container_of(obj, struct device, kobj)
+
+struct bat_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct kobject *kobj, struct attribute *attr,
+			char *buf);
+	ssize_t (*store)(struct kobject *kobj, struct attribute *attr,
+			 char *buf, size_t count);
+};
+
+#define BAT_ATTR(_name, _mode, _show, _store)	\
+struct bat_attribute bat_attr_##_name = {	\
+	.attr = {.name = __stringify(_name),	\
+		 .mode = _mode },		\
+	.show   = _show,			\
+	.store  = _store,			\
+};
+
+#define BAT_BIN_ATTR(_name, _mode, _read, _write)	\
+struct bin_attribute bat_attr_##_name = {		\
+	.attr = { .name = __stringify(_name),		\
+		  .mode = _mode, },			\
+	.read = _read,					\
+	.write = _write,				\
+};
+
+static ssize_t show_aggr_ogm(struct kobject *kobj, struct attribute *attr,
+			     char *buff)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+	int aggr_status = atomic_read(&bat_priv->aggregation_enabled);
+
+	return sprintf(buff, "status: %s\ncommands: enable, disable, 0, 1 \n",
+		       aggr_status == 0 ? "disabled" : "enabled");
+}
+
+static ssize_t store_aggr_ogm(struct kobject *kobj, struct attribute *attr,
+			      char *buff, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	int aggr_tmp = -1;
+
+	if (((count == 2) && (buff[0] == '1')) ||
+	    (strncmp(buff, "enable", 6) == 0))
+		aggr_tmp = 1;
+
+	if (((count == 2) && (buff[0] == '0')) ||
+	    (strncmp(buff, "disable", 7) == 0))
+		aggr_tmp = 0;
+
+	if (aggr_tmp < 0) {
+		if (buff[count - 1] == '\n')
+			buff[count - 1] = '\0';
+
+		printk(KERN_INFO "batman-adv:Invalid parameter for 'aggregate OGM' setting on mesh %s received: %s\n",
+		       net_dev->name, buff);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&bat_priv->aggregation_enabled) == aggr_tmp)
+		return count;
+
+	printk(KERN_INFO "batman-adv:Changing aggregation from: %s to: %s on mesh: %s\n",
+	       atomic_read(&bat_priv->aggregation_enabled) == 1 ?
+	       "enabled" : "disabled", aggr_tmp == 1 ? "enabled" : "disabled",
+	       net_dev->name);
+
+	atomic_set(&bat_priv->aggregation_enabled, (unsigned)aggr_tmp);
+	return count;
+}
+
+static BAT_ATTR(aggregate_ogm, S_IRUGO | S_IWUSR,
+		show_aggr_ogm, store_aggr_ogm);
+
+static struct bat_attribute *mesh_attrs[] = {
+	&bat_attr_aggregate_ogm,
+	NULL,
+};
+
+static ssize_t transtable_local_read(struct kobject *kobj,
+			       struct bin_attribute *bin_attr,
+			       char *buff, loff_t off, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+
+	rcu_read_lock();
+	if (list_empty(&if_list)) {
+		rcu_read_unlock();
+
+		if (off == 0)
+			return sprintf(buff,
+				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
+				       net_dev->name);
+
+		return 0;
+	}
+	rcu_read_unlock();
+
+	return hna_local_fill_buffer_text(net_dev, buff, count, off);
+}
+
+static ssize_t transtable_global_read(struct kobject *kobj,
+			       struct bin_attribute *bin_attr,
+			       char *buff, loff_t off, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+
+	rcu_read_lock();
+	if (list_empty(&if_list)) {
+		rcu_read_unlock();
+
+		if (off == 0)
+			return sprintf(buff,
+				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
+				       net_dev->name);
+
+		return 0;
+	}
+	rcu_read_unlock();
+
+	return hna_global_fill_buffer_text(net_dev, buff, count, off);
+}
+
+static ssize_t originators_read(struct kobject *kobj,
+			       struct bin_attribute *bin_attr,
+			       char *buff, loff_t off, size_t count)
+{
+	/* FIXME: orig table should exist per batif */
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+
+	rcu_read_lock();
+	if (list_empty(&if_list)) {
+		rcu_read_unlock();
+
+		if (off == 0)
+			return sprintf(buff,
+				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
+				       net_dev->name);
+
+		return 0;
+	}
+
+	if (((struct batman_if *)if_list.next)->if_active != IF_ACTIVE) {
+		rcu_read_unlock();
+
+		if (off == 0)
+			return sprintf(buff,
+				       "BATMAN mesh %s disabled - primary interface not active\n",
+				       net_dev->name);
+
+		return 0;
+	}
+	rcu_read_unlock();
+
+	return orig_fill_buffer_text(buff, count, off);
+}
+
+static BAT_BIN_ATTR(transtable_local, S_IRUGO, transtable_local_read, NULL);
+static BAT_BIN_ATTR(transtable_global, S_IRUGO, transtable_global_read, NULL);
+static BAT_BIN_ATTR(originators, S_IRUGO, originators_read, NULL);
+
+static struct bin_attribute *mesh_bin_attrs[] = {
+	&bat_attr_transtable_local,
+	&bat_attr_transtable_global,
+	&bat_attr_originators,
+	NULL,
+};
+
+int sysfs_add_meshif(struct net_device *dev)
+{
+	struct kobject *batif_kobject = &dev->dev.kobj;
+	struct bat_priv *bat_priv = netdev_priv(dev);
+	struct bat_attribute **bat_attr;
+	struct bin_attribute **bin_attr;
+	int err;
+
+	/* FIXME: should be done in the general mesh setup
+		  routine as soon as we have it */
+	atomic_set(&bat_priv->aggregation_enabled, 1);
+
+	bat_priv->mesh_obj = kobject_create_and_add(SYSFS_IF_MESH_SUBDIR,
+						    batif_kobject);
+	if (!bat_priv->mesh_obj) {
+		printk(KERN_ERR "batman-adv:Can't add sysfs directory: %s/%s\n",
+		       dev->name, SYSFS_IF_MESH_SUBDIR);
+		goto out;
+	}
+
+	for (bat_attr = mesh_attrs; *bat_attr; ++bat_attr) {
+		err = sysfs_create_file(bat_priv->mesh_obj,
+					&((*bat_attr)->attr));
+		if (err) {
+			printk(KERN_ERR "batman-adv:Can't add sysfs file: %s/%s/%s\n",
+			       dev->name, SYSFS_IF_MESH_SUBDIR,
+			       ((*bat_attr)->attr).name);
+			goto rem_attr;
+		}
+	}
+
+	for (bin_attr = mesh_bin_attrs; *bin_attr; ++bin_attr) {
+		err = sysfs_create_bin_file(bat_priv->mesh_obj, (*bin_attr));
+		if (err) {
+			printk(KERN_ERR "batman-adv:Can't add sysfs file: %s/%s/%s\n",
+			       dev->name, SYSFS_IF_MESH_SUBDIR,
+			       ((*bin_attr)->attr).name);
+			goto rem_bin_attr;
+		}
+	}
+
+	return 0;
+
+rem_bin_attr:
+	for (bin_attr = mesh_bin_attrs; *bin_attr; ++bin_attr)
+		sysfs_remove_bin_file(bat_priv->mesh_obj, (*bin_attr));
+rem_attr:
+	for (bat_attr = mesh_attrs; *bat_attr; ++bat_attr)
+		sysfs_remove_file(bat_priv->mesh_obj, &((*bat_attr)->attr));
+
+	kobject_put(bat_priv->mesh_obj);
+	bat_priv->mesh_obj = NULL;
+out:
+	return -ENOMEM;
+}
+
+void sysfs_del_meshif(struct net_device *dev)
+{
+	struct bat_priv *bat_priv = netdev_priv(dev);
+	struct bat_attribute **bat_attr;
+	struct bin_attribute **bin_attr;
+
+	for (bin_attr = mesh_bin_attrs; *bin_attr; ++bin_attr)
+		sysfs_remove_bin_file(bat_priv->mesh_obj, (*bin_attr));
+
+	for (bat_attr = mesh_attrs; *bat_attr; ++bat_attr)
+		sysfs_remove_file(bat_priv->mesh_obj, &((*bat_attr)->attr));
+
+	kobject_put(bat_priv->mesh_obj);
+	bat_priv->mesh_obj = NULL;
+}
diff --git a/drivers/staging/batman-adv/bat_sysfs.h b/drivers/staging/batman-adv/bat_sysfs.h
new file mode 100644
index 0000000..671ebd1
--- /dev/null
+++ b/drivers/staging/batman-adv/bat_sysfs.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2010 B.A.T.M.A.N. contributors:
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
+
+#define SYSFS_IF_MESH_SUBDIR "mesh"
+
+int sysfs_add_meshif(struct net_device *dev);
+void sysfs_del_meshif(struct net_device *dev);
diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index 881aaa9..b5f8b80 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -21,6 +21,7 @@
 
 #include "main.h"
 #include "proc.h"
+#include "bat_sysfs.h"
 #include "routing.h"
 #include "send.h"
 #include "originator.h"
@@ -44,7 +45,6 @@ DEFINE_SPINLOCK(forw_bcast_list_lock);
 atomic_t originator_interval;
 atomic_t vis_interval;
 atomic_t vis_mode;
-atomic_t aggregation_enabled;
 int16_t num_hna;
 int16_t num_ifs;
 
@@ -85,7 +85,6 @@ int init_module(void)
 	atomic_set(&vis_interval, 1000);/* TODO: raise this later, this is only
 					 * for debugging now. */
 	atomic_set(&vis_mode, VIS_TYPE_CLIENT_UPDATE);
-	atomic_set(&aggregation_enabled, 1);
 
 	/* the name should not be longer than 10 chars - see
 	 * http://lwn.net/Articles/23634/ */
@@ -116,6 +115,11 @@ int init_module(void)
 		goto free_soft_device;
 	}
 
+	retval = sysfs_add_meshif(soft_device);
+
+	if (retval < 0)
+		goto unreg_soft_device;
+
 	register_netdevice_notifier(&hard_if_notifier);
 	dev_add_pack(&batman_adv_packet_type);
 
@@ -124,6 +128,8 @@ int init_module(void)
 
 	return 0;
 
+unreg_soft_device:
+	unregister_netdevice(soft_device);
 free_soft_device:
 	free_netdev(soft_device);
 	soft_device = NULL;
@@ -136,6 +142,7 @@ void cleanup_module(void)
 	shutdown_module();
 
 	if (soft_device) {
+		sysfs_del_meshif(soft_device);
 		unregister_netdev(soft_device);
 		soft_device = NULL;
 	}
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 6221b85..3e28e9e 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -130,7 +130,6 @@ extern spinlock_t forw_bcast_list_lock;
 extern atomic_t originator_interval;
 extern atomic_t vis_interval;
 extern atomic_t vis_mode;
-extern atomic_t aggregation_enabled;
 extern int16_t num_hna;
 extern int16_t num_ifs;
 
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index f3d8cc3..818f56e 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -249,4 +249,77 @@ void purge_orig(struct work_struct *work)
 	start_purge_timer();
 }
 
+ssize_t orig_fill_buffer_text(char *buff, size_t count, loff_t off)
+{
+	HASHIT(hashit);
+	struct orig_node *orig_node;
+	struct neigh_node *neigh_node;
+	size_t hdr_len, tmp_len;
+	int batman_count = 0, bytes_written = 0;
+	unsigned long flags;
+	char orig_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
+
+	rcu_read_lock();
+	hdr_len = sprintf(buff,
+		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s] \n",
+		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
+		   "Potential nexthops", SOURCE_VERSION, REVISION_VERSION_STR,
+		   ((struct batman_if *)if_list.next)->dev,
+		   ((struct batman_if *)if_list.next)->addr_str);
+	rcu_read_unlock();
+
+	if (off < hdr_len)
+		bytes_written = hdr_len;
+
+	spin_lock_irqsave(&orig_hash_lock, flags);
+
+	while (hash_iterate(orig_hash, &hashit)) {
+
+		orig_node = hashit.bucket->data;
+
+		if (!orig_node->router)
+			continue;
+
+		if (orig_node->router->tq_avg == 0)
+			continue;
+
+		/* estimated line length */
+		if (count < bytes_written + 200)
+			break;
+
+		addr_to_string(orig_str, orig_node->orig);
+		addr_to_string(router_str, orig_node->router->addr);
+
+		tmp_len = sprintf(buff + bytes_written,
+				  "%-17s  (%3i) %17s [%10s]:",
+				   orig_str, orig_node->router->tq_avg,
+				   router_str,
+				   orig_node->router->if_incoming->dev);
+
+		list_for_each_entry(neigh_node, &orig_node->neigh_list, list) {
+			addr_to_string(orig_str, neigh_node->addr);
+			tmp_len += sprintf(buff + bytes_written + tmp_len,
+					   " %17s (%3i)", orig_str,
+					   neigh_node->tq_avg);
+		}
+
+		tmp_len += sprintf(buff + bytes_written + tmp_len, "\n");
+
+		batman_count++;
+		hdr_len += tmp_len;
+
+		if (off >= hdr_len)
+			continue;
+
+		bytes_written += tmp_len;
+	}
+
+	spin_unlock_irqrestore(&orig_hash_lock, flags);
+
+	if ((batman_count == 0) && (off == 0))
+		bytes_written += sprintf(buff + bytes_written,
+					"No batman nodes in range ... \n");
+
+	return bytes_written;
+}
 
diff --git a/drivers/staging/batman-adv/originator.h b/drivers/staging/batman-adv/originator.h
index 8acebc1..8289a85 100644
--- a/drivers/staging/batman-adv/originator.h
+++ b/drivers/staging/batman-adv/originator.h
@@ -28,4 +28,4 @@ struct orig_node *get_orig_node(uint8_t *addr);
 struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming);
-
+ssize_t orig_fill_buffer_text(char *buff, size_t count, loff_t off);
diff --git a/drivers/staging/batman-adv/proc.c b/drivers/staging/batman-adv/proc.c
index dfa85c4..059b2d9 100644
--- a/drivers/staging/batman-adv/proc.c
+++ b/drivers/staging/batman-adv/proc.c
@@ -29,11 +29,8 @@
 #include "vis.h"
 
 static struct proc_dir_entry *proc_batman_dir, *proc_interface_file;
-static struct proc_dir_entry *proc_orig_interval_file, *proc_originators_file;
-static struct proc_dir_entry *proc_transt_local_file;
-static struct proc_dir_entry *proc_transt_global_file;
+static struct proc_dir_entry *proc_orig_interval_file;
 static struct proc_dir_entry *proc_vis_srv_file, *proc_vis_data_file;
-static struct proc_dir_entry *proc_aggr_file;
 
 static int proc_interfaces_read(struct seq_file *seq, void *offset)
 {
@@ -176,145 +173,6 @@ static int proc_orig_interval_open(struct inode *inode, struct file *file)
 	return single_open(file, proc_orig_interval_read, NULL);
 }
 
-static int proc_originators_read(struct seq_file *seq, void *offset)
-{
-	HASHIT(hashit);
-	struct orig_node *orig_node;
-	struct neigh_node *neigh_node;
-	int batman_count = 0;
-	char orig_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
-	unsigned long flags;
-
-	rcu_read_lock();
-	if (list_empty(&if_list)) {
-		rcu_read_unlock();
-		seq_printf(seq, "BATMAN disabled - please specify interfaces to enable it\n");
-		goto end;
-	}
-
-	if (((struct batman_if *)if_list.next)->if_active != IF_ACTIVE) {
-		rcu_read_unlock();
-		seq_printf(seq, "BATMAN disabled - primary interface not active\n");
-		goto end;
-	}
-
-	seq_printf(seq,
-		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s]\n",
-		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
-		   "Potential nexthops", SOURCE_VERSION, REVISION_VERSION_STR,
-		   ((struct batman_if *)if_list.next)->dev,
-		   ((struct batman_if *)if_list.next)->addr_str);
-
-	rcu_read_unlock();
-	spin_lock_irqsave(&orig_hash_lock, flags);
-
-	while (hash_iterate(orig_hash, &hashit)) {
-
-		orig_node = hashit.bucket->data;
-
-		if (!orig_node->router)
-			continue;
-
-		if (orig_node->router->tq_avg == 0)
-			continue;
-
-		batman_count++;
-
-		addr_to_string(orig_str, orig_node->orig);
-		addr_to_string(router_str, orig_node->router->addr);
-
-		seq_printf(seq, "%-17s  (%3i) %17s [%10s]:",
-			   orig_str, orig_node->router->tq_avg,
-			   router_str, orig_node->router->if_incoming->dev);
-
-		list_for_each_entry(neigh_node, &orig_node->neigh_list, list) {
-			addr_to_string(orig_str, neigh_node->addr);
-			seq_printf(seq, " %17s (%3i)",
-				   orig_str, neigh_node->tq_avg);
-		}
-
-		seq_printf(seq, "\n");
-
-	}
-
-	spin_unlock_irqrestore(&orig_hash_lock, flags);
-
-	if (batman_count == 0)
-		seq_printf(seq, "No batman nodes in range ...\n");
-
-end:
-	return 0;
-}
-
-static int proc_originators_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_originators_read, NULL);
-}
-
-static int proc_transt_local_read(struct seq_file *seq, void *offset)
-{
-	char *buf;
-
-	buf = kmalloc(4096, GFP_KERNEL);
-	if (!buf)
-		return 0;
-
-	rcu_read_lock();
-	if (list_empty(&if_list)) {
-		rcu_read_unlock();
-		seq_printf(seq, "BATMAN disabled - please specify interfaces to enable it\n");
-		goto end;
-	}
-
-	rcu_read_unlock();
-
-	seq_printf(seq, "Locally retrieved addresses (from %s) announced via HNA:\n", soft_device->name);
-
-	hna_local_fill_buffer_text(buf, 4096);
-	seq_printf(seq, "%s", buf);
-
-end:
-	kfree(buf);
-	return 0;
-}
-
-static int proc_transt_local_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_transt_local_read, NULL);
-}
-
-static int proc_transt_global_read(struct seq_file *seq, void *offset)
-{
-	char *buf;
-
-	buf = kmalloc(4096, GFP_KERNEL);
-	if (!buf)
-		return 0;
-
-	rcu_read_lock();
-	if (list_empty(&if_list)) {
-		rcu_read_unlock();
-		seq_printf(seq, "BATMAN disabled - please specify interfaces to enable it\n");
-		goto end;
-	}
-	rcu_read_unlock();
-
-
-	seq_printf(seq, "Globally announced HNAs received via the mesh (translation table):\n");
-
-	hna_global_fill_buffer_text(buf, 4096);
-	seq_printf(seq, "%s", buf);
-
-end:
-	kfree(buf);
-	return 0;
-}
-
-static int proc_transt_global_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_transt_global_read, NULL);
-}
-
 /* setting the mode of the vis server by the user */
 static ssize_t proc_vis_srv_write(struct file *file, const char __user * buffer,
 			      size_t count, loff_t *ppos)
@@ -429,53 +287,6 @@ static int proc_vis_data_open(struct inode *inode, struct file *file)
 	return single_open(file, proc_vis_data_read, NULL);
 }
 
-static int proc_aggr_read(struct seq_file *seq, void *offset)
-{
-	seq_printf(seq, "%i\n", atomic_read(&aggregation_enabled));
-
-	return 0;
-}
-
-static ssize_t proc_aggr_write(struct file *file, const char __user *buffer,
-			       size_t count, loff_t *ppos)
-{
-	char *aggr_string;
-	int not_copied = 0;
-	unsigned long aggregation_enabled_tmp;
-	int retval;
-
-	aggr_string = kmalloc(count, GFP_KERNEL);
-
-	if (!aggr_string)
-		return -ENOMEM;
-
-	not_copied = copy_from_user(aggr_string, buffer, count);
-	aggr_string[count - not_copied - 1] = 0;
-
-	retval = strict_strtoul(aggr_string, 10, &aggregation_enabled_tmp);
-
-	if (retval || aggregation_enabled_tmp > 1) {
-		printk(KERN_ERR "batman-adv:Aggregation can only be enabled (1) or disabled (0), given value: %li\n", aggregation_enabled_tmp);
-	} else {
-		printk(KERN_INFO "batman-adv:Changing aggregation from: %s (%i) to: %s (%li)\n",
-		       (atomic_read(&aggregation_enabled) == 1 ?
-			"enabled" : "disabled"),
-		       atomic_read(&aggregation_enabled),
-		       (aggregation_enabled_tmp == 1 ? "enabled" : "disabled"),
-		       aggregation_enabled_tmp);
-		atomic_set(&aggregation_enabled,
-			   (unsigned)aggregation_enabled_tmp);
-	}
-
-	kfree(aggr_string);
-	return count;
-}
-
-static int proc_aggr_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_aggr_read, NULL);
-}
-
 /* satisfying different prototypes ... */
 static ssize_t proc_dummy_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos)
@@ -483,15 +294,6 @@ static ssize_t proc_dummy_write(struct file *file, const char __user *buffer,
 	return count;
 }
 
-static const struct file_operations proc_aggr_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_aggr_open,
-	.read		= seq_read,
-	.write		= proc_aggr_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static const struct file_operations proc_vis_srv_fops = {
 	.owner		= THIS_MODULE,
 	.open		= proc_vis_srv_open,
@@ -510,33 +312,6 @@ static const struct file_operations proc_vis_data_fops = {
 	.release	= single_release,
 };
 
-static const struct file_operations proc_originators_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_originators_open,
-	.read		= seq_read,
-	.write		= proc_dummy_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations proc_transt_local_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_transt_local_open,
-	.read		= seq_read,
-	.write		= proc_dummy_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations proc_transt_global_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_transt_global_open,
-	.read		= seq_read,
-	.write		= proc_dummy_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static const struct file_operations proc_interfaces_fops = {
 	.owner		= THIS_MODULE,
 	.open		= proc_interfaces_open,
@@ -557,15 +332,6 @@ static const struct file_operations proc_orig_interval_fops = {
 
 void cleanup_procfs(void)
 {
-	if (proc_transt_global_file)
-		remove_proc_entry(PROC_FILE_TRANST_GLOBAL, proc_batman_dir);
-
-	if (proc_transt_local_file)
-		remove_proc_entry(PROC_FILE_TRANST_LOCAL, proc_batman_dir);
-
-	if (proc_originators_file)
-		remove_proc_entry(PROC_FILE_ORIGINATORS, proc_batman_dir);
-
 	if (proc_orig_interval_file)
 		remove_proc_entry(PROC_FILE_ORIG_INTERVAL, proc_batman_dir);
 
@@ -578,9 +344,6 @@ void cleanup_procfs(void)
 	if (proc_vis_srv_file)
 		remove_proc_entry(PROC_FILE_VIS_SRV, proc_batman_dir);
 
-	if (proc_aggr_file)
-		remove_proc_entry(PROC_FILE_AGGR, proc_batman_dir);
-
 	if (proc_batman_dir)
 #ifdef __NET_NET_NAMESPACE_H
 		remove_proc_entry(PROC_ROOT_DIR, init_net.proc_net);
@@ -624,36 +387,6 @@ int setup_procfs(void)
 		return -EFAULT;
 	}
 
-	proc_originators_file = create_proc_entry(PROC_FILE_ORIGINATORS,
-						  S_IRUGO, proc_batman_dir);
-	if (proc_originators_file) {
-		proc_originators_file->proc_fops = &proc_originators_fops;
-	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_ORIGINATORS);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	proc_transt_local_file = create_proc_entry(PROC_FILE_TRANST_LOCAL,
-						   S_IRUGO, proc_batman_dir);
-	if (proc_transt_local_file) {
-		proc_transt_local_file->proc_fops = &proc_transt_local_fops;
-	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_TRANST_LOCAL);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	proc_transt_global_file = create_proc_entry(PROC_FILE_TRANST_GLOBAL,
-						    S_IRUGO, proc_batman_dir);
-	if (proc_transt_global_file) {
-		proc_transt_global_file->proc_fops = &proc_transt_global_fops;
-	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_TRANST_GLOBAL);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
 	proc_vis_srv_file = create_proc_entry(PROC_FILE_VIS_SRV,
 						S_IWUSR | S_IRUGO,
 						proc_batman_dir);
@@ -675,15 +408,5 @@ int setup_procfs(void)
 		return -EFAULT;
 	}
 
-	proc_aggr_file = create_proc_entry(PROC_FILE_AGGR, S_IWUSR | S_IRUGO,
-					   proc_batman_dir);
-	if (proc_aggr_file) {
-		proc_aggr_file->proc_fops = &proc_aggr_fops;
-	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_AGGR);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
 	return 0;
 }
diff --git a/drivers/staging/batman-adv/proc.h b/drivers/staging/batman-adv/proc.h
index cf71264..68a255a 100644
--- a/drivers/staging/batman-adv/proc.h
+++ b/drivers/staging/batman-adv/proc.h
@@ -25,15 +25,11 @@
 #define PROC_ROOT_DIR "batman-adv"
 #define PROC_FILE_INTERFACES "interfaces"
 #define PROC_FILE_ORIG_INTERVAL "orig_interval"
-#define PROC_FILE_ORIGINATORS "originators"
 #define PROC_FILE_GATEWAYS "gateways"
 #define PROC_FILE_LOG "log"
 #define PROC_FILE_LOG_LEVEL "log_level"
-#define PROC_FILE_TRANST_LOCAL "transtable_local"
-#define PROC_FILE_TRANST_GLOBAL "transtable_global"
 #define PROC_FILE_VIS_SRV "vis_server"
 #define PROC_FILE_VIS_DATA "vis_data"
-#define PROC_FILE_AGGR "aggregate_ogm"
 
 void cleanup_procfs(void);
 int setup_procfs(void);
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index 29b684b..32d1756 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -44,7 +44,7 @@ static unsigned long own_send_time(void)
 }
 
 /* when do we schedule a forwarded packet to be sent */
-static unsigned long forward_send_time(void)
+static unsigned long forward_send_time(struct bat_priv *bat_priv)
 {
 	return jiffies + (((random32() % (JITTER/2)) * HZ) / 1000);
 }
@@ -239,6 +239,8 @@ static void rebuild_batman_packet(struct batman_if *batman_if)
 
 void schedule_own_packet(struct batman_if *batman_if)
 {
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	unsigned long send_time;
 	struct batman_packet *batman_packet;
 	int vis_server = atomic_read(&vis_mode);
@@ -277,7 +279,9 @@ void schedule_own_packet(struct batman_if *batman_if)
 	slide_own_bcast_window(batman_if);
 	send_time = own_send_time();
 	add_bat_packet_to_list(batman_if->packet_buff,
-			       batman_if->packet_len, batman_if, 1, send_time);
+			       batman_if->packet_len,
+			       batman_if, 1, send_time,
+			       bat_priv);
 }
 
 void schedule_forward_packet(struct orig_node *orig_node,
@@ -286,6 +290,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 			     uint8_t directlink, int hna_buff_len,
 			     struct batman_if *if_incoming)
 {
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	unsigned char in_tq, in_ttl, tq_avg = 0;
 	unsigned long send_time;
 
@@ -329,10 +335,11 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	else
 		batman_packet->flags &= ~DIRECTLINK;
 
-	send_time = forward_send_time();
+	send_time = forward_send_time(bat_priv);
 	add_bat_packet_to_list((unsigned char *)batman_packet,
 			       sizeof(struct batman_packet) + hna_buff_len,
-			       if_incoming, 0, send_time);
+			       if_incoming, 0, send_time,
+			       bat_priv);
 }
 
 static void forw_packet_free(struct forw_packet *forw_packet)
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index 5537846..d43b1ad 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -156,23 +156,36 @@ int hna_local_fill_buffer(unsigned char *buff, int buff_len)
 	return i;
 }
 
-int hna_local_fill_buffer_text(unsigned char *buff, int buff_len)
+int hna_local_fill_buffer_text(struct net_device *net_dev, char *buff,
+			       size_t count, loff_t off)
 {
 	struct hna_local_entry *hna_local_entry;
 	HASHIT(hashit);
 	int bytes_written = 0;
 	unsigned long flags;
+	size_t hdr_len;
+
+	hdr_len = sprintf(buff,
+			  "Locally retrieved addresses (from %s) announced via HNA:\n",
+			  net_dev->name);
+
+	if (off < hdr_len)
+		bytes_written = hdr_len;
 
 	spin_lock_irqsave(&hna_local_hash_lock, flags);
 
 	while (hash_iterate(hna_local_hash, &hashit)) {
+		hdr_len += 21;
 
-		if (buff_len < bytes_written + ETH_STR_LEN + 4)
+		if (count < bytes_written + 22)
 			break;
 
+		if (off >= hdr_len)
+			continue;
+
 		hna_local_entry = hashit.bucket->data;
 
-		bytes_written += snprintf(buff + bytes_written, ETH_STR_LEN + 4,
+		bytes_written += snprintf(buff + bytes_written, 22,
 					  " * %02x:%02x:%02x:%02x:%02x:%02x\n",
 					  hna_local_entry->addr[0],
 					  hna_local_entry->addr[1],
@@ -183,7 +196,6 @@ int hna_local_fill_buffer_text(unsigned char *buff, int buff_len)
 	}
 
 	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
-
 	return bytes_written;
 }
 
@@ -348,23 +360,36 @@ void hna_global_add_orig(struct orig_node *orig_node,
 	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
 }
 
-int hna_global_fill_buffer_text(unsigned char *buff, int buff_len)
+int hna_global_fill_buffer_text(struct net_device *net_dev, char *buff,
+				size_t count, loff_t off)
 {
 	struct hna_global_entry *hna_global_entry;
 	HASHIT(hashit);
 	int bytes_written = 0;
 	unsigned long flags;
+	size_t hdr_len;
+
+	hdr_len = sprintf(buff,
+			  "Globally announced HNAs received via the mesh %s (translation table):\n",
+			  net_dev->name);
+
+	if (off < hdr_len)
+		bytes_written = hdr_len;
 
 	spin_lock_irqsave(&hna_global_hash_lock, flags);
 
 	while (hash_iterate(hna_global_hash, &hashit)) {
-		if (buff_len < bytes_written + (2 * ETH_STR_LEN) + 10)
+		hdr_len += 43;
+
+		if (count < bytes_written + 44)
 			break;
 
+		if (off >= hdr_len)
+			continue;
+
 		hna_global_entry = hashit.bucket->data;
 
-		bytes_written += snprintf(buff + bytes_written,
-					  (2 * ETH_STR_LEN) + 10,
+		bytes_written += snprintf(buff + bytes_written, 44,
 					  " * %02x:%02x:%02x:%02x:%02x:%02x via %02x:%02x:%02x:%02x:%02x:%02x\n",
 					  hna_global_entry->addr[0],
 					  hna_global_entry->addr[1],
@@ -381,7 +406,6 @@ int hna_global_fill_buffer_text(unsigned char *buff, int buff_len)
 	}
 
 	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
-
 	return bytes_written;
 }
 
diff --git a/drivers/staging/batman-adv/translation-table.h b/drivers/staging/batman-adv/translation-table.h
index 8568d80..8f412fc 100644
--- a/drivers/staging/batman-adv/translation-table.h
+++ b/drivers/staging/batman-adv/translation-table.h
@@ -25,13 +25,15 @@ int hna_local_init(void);
 void hna_local_add(uint8_t *addr);
 void hna_local_remove(uint8_t *addr, char *message);
 int hna_local_fill_buffer(unsigned char *buff, int buff_len);
-int hna_local_fill_buffer_text(unsigned char *buff, int buff_len);
+int hna_local_fill_buffer_text(struct net_device *net_dev, char *buff,
+			       size_t count, loff_t off);
 void hna_local_purge(struct work_struct *work);
 void hna_local_free(void);
 int hna_global_init(void);
 void hna_global_add_orig(struct orig_node *orig_node, unsigned char *hna_buff,
 			 int hna_buff_len);
-int hna_global_fill_buffer_text(unsigned char *buff, int buff_len);
+int hna_global_fill_buffer_text(struct net_device *net_dev, char *buff,
+				size_t count, loff_t off);
 void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
 			  char *orig_str);
 void hna_global_del_orig(struct orig_node *orig_node, char *message);
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 4e77141..db1bb0b 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -82,6 +82,8 @@ struct neigh_node {
 
 struct bat_priv {
 	struct net_device_stats stats;
+	atomic_t aggregation_enabled;
+	struct kobject *mesh_obj;
 };
 
 struct device_client {
-- 
1.7.1

