Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu,  6 May 2010 22:18:40 +0200
Message-Id: <1273177132-8792-15-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 14/26] staging:batman-adv: convert more files
	from /proc to /sys
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

converted files:
vis_mode, vis_data

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/aggregation.c       |    6 +-
 drivers/staging/batman-adv/aggregation.h       |    8 +-
 drivers/staging/batman-adv/bat_sysfs.c         |  118 ++++++++++-------
 drivers/staging/batman-adv/main.c              |    2 -
 drivers/staging/batman-adv/main.h              |    1 -
 drivers/staging/batman-adv/originator.c        |   33 ++++-
 drivers/staging/batman-adv/originator.h        |    3 +-
 drivers/staging/batman-adv/proc.c              |  167 ------------------------
 drivers/staging/batman-adv/proc.h              |    5 -
 drivers/staging/batman-adv/routing.c           |   10 +-
 drivers/staging/batman-adv/send.c              |   16 +-
 drivers/staging/batman-adv/soft-interface.c    |    4 +
 drivers/staging/batman-adv/translation-table.c |   26 ++++
 drivers/staging/batman-adv/types.h             |    1 +
 drivers/staging/batman-adv/vis.c               |  124 +++++++++++++++---
 drivers/staging/batman-adv/vis.h               |   17 +--
 16 files changed, 265 insertions(+), 276 deletions(-)

diff --git a/drivers/staging/batman-adv/aggregation.c b/drivers/staging/batman-adv/aggregation.c
index c946839..a5818ff 100644
--- a/drivers/staging/batman-adv/aggregation.c
+++ b/drivers/staging/batman-adv/aggregation.c
@@ -165,10 +165,10 @@ static void aggregate(struct forw_packet *forw_packet_aggr,
 			(1 << forw_packet_aggr->num_packets);
 }
 
-void add_bat_packet_to_list(unsigned char *packet_buff, int packet_len,
+void add_bat_packet_to_list(struct bat_priv *bat_priv,
+			    unsigned char *packet_buff, int packet_len,
 			    struct batman_if *if_incoming, char own_packet,
-			    unsigned long send_time,
-			    struct bat_priv *bat_priv)
+			    unsigned long send_time)
 {
 	/**
 	 * _aggr -> pointer to the packet we want to aggregate with
diff --git a/drivers/staging/batman-adv/aggregation.h b/drivers/staging/batman-adv/aggregation.h
index 29e1ffc..84401ca 100644
--- a/drivers/staging/batman-adv/aggregation.h
+++ b/drivers/staging/batman-adv/aggregation.h
@@ -30,9 +30,9 @@ static inline int aggregated_packet(int buff_pos, int packet_len, int num_hna)
 		(next_buff_pos <= MAX_AGGREGATION_BYTES);
 }
 
-void add_bat_packet_to_list(unsigned char *packet_buff, int packet_len,
-			    struct batman_if *if_outgoing, char own_packet,
-			    unsigned long send_time,
-			    struct bat_priv *bat_priv);
+void add_bat_packet_to_list(struct bat_priv *bat_priv,
+			    unsigned char *packet_buff, int packet_len,
+			    struct batman_if *if_incoming, char own_packet,
+			    unsigned long send_time);
 void receive_aggr_bat_packet(struct ethhdr *ethhdr, unsigned char *packet_buff,
 			     int packet_len, struct batman_if *if_incoming);
diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index 6293118..c14ab47 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -24,6 +24,7 @@
 #include "translation-table.h"
 #include "originator.h"
 #include "hard-interface.h"
+#include "vis.h"
 
 #define to_dev(obj)     container_of(obj, struct device, kobj)
 
@@ -99,11 +100,66 @@ static ssize_t store_aggr_ogm(struct kobject *kobj, struct attribute *attr,
 	return count;
 }
 
+static ssize_t show_vis_mode(struct kobject *kobj, struct attribute *attr,
+			     char *buff)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+	int vis_mode = atomic_read(&bat_priv->vis_mode);
+
+	return sprintf(buff, "status: %s\ncommands: client, server, %d, %d \n",
+		       vis_mode == VIS_TYPE_CLIENT_UPDATE ?
+							"client" : "server",
+		       VIS_TYPE_SERVER_SYNC, VIS_TYPE_CLIENT_UPDATE);
+}
+
+static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
+			      char *buff, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	unsigned long val;
+	int ret, vis_mode_tmp = -1;
+
+	ret = strict_strtoul(buff, 10, &val);
+
+	if (((count == 2) && (!ret) && (val == VIS_TYPE_CLIENT_UPDATE)) ||
+	    (strncmp(buff, "client", 6) == 0))
+		vis_mode_tmp = VIS_TYPE_CLIENT_UPDATE;
+
+	if (((count == 2) && (!ret) && (val == VIS_TYPE_SERVER_SYNC)) ||
+	    (strncmp(buff, "server", 6) == 0))
+		vis_mode_tmp = VIS_TYPE_SERVER_SYNC;
+
+	if (vis_mode_tmp < 0) {
+		if (buff[count - 1] == '\n')
+			buff[count - 1] = '\0';
+
+		printk(KERN_INFO "batman-adv:Invalid parameter for 'vis mode' setting on mesh %s received: %s\n",
+		       net_dev->name, buff);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&bat_priv->vis_mode) == vis_mode_tmp)
+		return count;
+
+	printk(KERN_INFO "batman-adv:Changing vis mode from: %s to: %s on mesh: %s\n",
+	       atomic_read(&bat_priv->vis_mode) == VIS_TYPE_CLIENT_UPDATE ?
+	       "client" : "server", vis_mode_tmp == VIS_TYPE_CLIENT_UPDATE ?
+	       "client" : "server", net_dev->name);
+
+	atomic_set(&bat_priv->vis_mode, (unsigned)vis_mode_tmp);
+	return count;
+}
+
 static BAT_ATTR(aggregate_ogm, S_IRUGO | S_IWUSR,
 		show_aggr_ogm, store_aggr_ogm);
+static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
 
 static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_aggregate_ogm,
+	&bat_attr_vis_mode,
 	NULL,
 };
 
@@ -114,19 +170,6 @@ static ssize_t transtable_local_read(struct kobject *kobj,
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
 
-	rcu_read_lock();
-	if (list_empty(&if_list)) {
-		rcu_read_unlock();
-
-		if (off == 0)
-			return sprintf(buff,
-				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				       net_dev->name);
-
-		return 0;
-	}
-	rcu_read_unlock();
-
 	return hna_local_fill_buffer_text(net_dev, buff, count, off);
 }
 
@@ -137,19 +180,6 @@ static ssize_t transtable_global_read(struct kobject *kobj,
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
 
-	rcu_read_lock();
-	if (list_empty(&if_list)) {
-		rcu_read_unlock();
-
-		if (off == 0)
-			return sprintf(buff,
-				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				       net_dev->name);
-
-		return 0;
-	}
-	rcu_read_unlock();
-
 	return hna_global_fill_buffer_text(net_dev, buff, count, off);
 }
 
@@ -157,45 +187,32 @@ static ssize_t originators_read(struct kobject *kobj,
 			       struct bin_attribute *bin_attr,
 			       char *buff, loff_t off, size_t count)
 {
-	/* FIXME: orig table should exist per batif */
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
 
-	rcu_read_lock();
-	if (list_empty(&if_list)) {
-		rcu_read_unlock();
-
-		if (off == 0)
-			return sprintf(buff,
-				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				       net_dev->name);
-
-		return 0;
-	}
-
-	if (((struct batman_if *)if_list.next)->if_active != IF_ACTIVE) {
-		rcu_read_unlock();
-
-		if (off == 0)
-			return sprintf(buff,
-				       "BATMAN mesh %s disabled - primary interface not active\n",
-				       net_dev->name);
+	return orig_fill_buffer_text(net_dev, buff, count, off);
+}
 
-		return 0;
-	}
-	rcu_read_unlock();
+static ssize_t vis_data_read(struct kobject *kobj,
+			     struct bin_attribute *bin_attr,
+			     char *buff, loff_t off, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
 
-	return orig_fill_buffer_text(buff, count, off);
+	return vis_fill_buffer_text(net_dev, buff, count, off);
 }
 
 static BAT_BIN_ATTR(transtable_local, S_IRUGO, transtable_local_read, NULL);
 static BAT_BIN_ATTR(transtable_global, S_IRUGO, transtable_global_read, NULL);
 static BAT_BIN_ATTR(originators, S_IRUGO, originators_read, NULL);
+static BAT_BIN_ATTR(vis_data, S_IRUGO, vis_data_read, NULL);
 
 static struct bin_attribute *mesh_bin_attrs[] = {
 	&bat_attr_transtable_local,
 	&bat_attr_transtable_global,
 	&bat_attr_originators,
+	&bat_attr_vis_data,
 	NULL,
 };
 
@@ -210,6 +227,7 @@ int sysfs_add_meshif(struct net_device *dev)
 	/* FIXME: should be done in the general mesh setup
 		  routine as soon as we have it */
 	atomic_set(&bat_priv->aggregation_enabled, 1);
+	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
 
 	bat_priv->mesh_obj = kobject_create_and_add(SYSFS_IF_MESH_SUBDIR,
 						    batif_kobject);
diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index b5f8b80..54e8cd5 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -44,7 +44,6 @@ DEFINE_SPINLOCK(forw_bcast_list_lock);
 
 atomic_t originator_interval;
 atomic_t vis_interval;
-atomic_t vis_mode;
 int16_t num_hna;
 int16_t num_ifs;
 
@@ -84,7 +83,6 @@ int init_module(void)
 	atomic_set(&originator_interval, 1000);
 	atomic_set(&vis_interval, 1000);/* TODO: raise this later, this is only
 					 * for debugging now. */
-	atomic_set(&vis_mode, VIS_TYPE_CLIENT_UPDATE);
 
 	/* the name should not be longer than 10 chars - see
 	 * http://lwn.net/Articles/23634/ */
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 3e28e9e..b2283a7 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -129,7 +129,6 @@ extern spinlock_t forw_bcast_list_lock;
 
 extern atomic_t originator_interval;
 extern atomic_t vis_interval;
-extern atomic_t vis_mode;
 extern int16_t num_hna;
 extern int16_t num_ifs;
 
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 818f56e..684db75 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -26,6 +26,7 @@
 #include "hash.h"
 #include "translation-table.h"
 #include "routing.h"
+#include "hard-interface.h"
 
 static DECLARE_DELAYED_WORK(purge_orig_wq, purge_orig);
 
@@ -205,7 +206,6 @@ static bool purge_orig_neighbors(struct orig_node *orig_node,
 	return neigh_purged;
 }
 
-
 static bool purge_orig_node(struct orig_node *orig_node)
 {
 	struct neigh_node *best_neigh_node;
@@ -224,6 +224,7 @@ static bool purge_orig_node(struct orig_node *orig_node)
 				      orig_node->hna_buff,
 				      orig_node->hna_buff_len);
 	}
+
 	return false;
 }
 
@@ -249,7 +250,8 @@ void purge_orig(struct work_struct *work)
 	start_purge_timer();
 }
 
-ssize_t orig_fill_buffer_text(char *buff, size_t count, loff_t off)
+ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
+			      size_t count, loff_t off)
 {
 	HASHIT(hashit);
 	struct orig_node *orig_node;
@@ -260,12 +262,35 @@ ssize_t orig_fill_buffer_text(char *buff, size_t count, loff_t off)
 	char orig_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
 
 	rcu_read_lock();
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
+
 	hdr_len = sprintf(buff,
-		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s] \n",
+		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)] \n",
 		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
 		   "Potential nexthops", SOURCE_VERSION, REVISION_VERSION_STR,
 		   ((struct batman_if *)if_list.next)->dev,
-		   ((struct batman_if *)if_list.next)->addr_str);
+		   ((struct batman_if *)if_list.next)->addr_str,
+		   net_dev->name);
 	rcu_read_unlock();
 
 	if (off < hdr_len)
diff --git a/drivers/staging/batman-adv/originator.h b/drivers/staging/batman-adv/originator.h
index 8289a85..745b4b0 100644
--- a/drivers/staging/batman-adv/originator.h
+++ b/drivers/staging/batman-adv/originator.h
@@ -28,4 +28,5 @@ struct orig_node *get_orig_node(uint8_t *addr);
 struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming);
-ssize_t orig_fill_buffer_text(char *buff, size_t count, loff_t off);
+ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
+			      size_t count, loff_t off);
diff --git a/drivers/staging/batman-adv/proc.c b/drivers/staging/batman-adv/proc.c
index 059b2d9..cbea642 100644
--- a/drivers/staging/batman-adv/proc.c
+++ b/drivers/staging/batman-adv/proc.c
@@ -30,7 +30,6 @@
 
 static struct proc_dir_entry *proc_batman_dir, *proc_interface_file;
 static struct proc_dir_entry *proc_orig_interval_file;
-static struct proc_dir_entry *proc_vis_srv_file, *proc_vis_data_file;
 
 static int proc_interfaces_read(struct seq_file *seq, void *offset)
 {
@@ -173,145 +172,6 @@ static int proc_orig_interval_open(struct inode *inode, struct file *file)
 	return single_open(file, proc_orig_interval_read, NULL);
 }
 
-/* setting the mode of the vis server by the user */
-static ssize_t proc_vis_srv_write(struct file *file, const char __user * buffer,
-			      size_t count, loff_t *ppos)
-{
-	char *vis_mode_string;
-	int not_copied = 0;
-
-	vis_mode_string = kmalloc(count, GFP_KERNEL);
-
-	if (!vis_mode_string)
-		return -ENOMEM;
-
-	not_copied = copy_from_user(vis_mode_string, buffer, count);
-	vis_mode_string[count - not_copied - 1] = 0;
-
-	if ((strcmp(vis_mode_string, "client") == 0) ||
-			(strcmp(vis_mode_string, "disabled") == 0)) {
-		printk(KERN_INFO "batman-adv:Setting VIS mode to client (disabling vis server)\n");
-		atomic_set(&vis_mode, VIS_TYPE_CLIENT_UPDATE);
-	} else if ((strcmp(vis_mode_string, "server") == 0) ||
-			(strcmp(vis_mode_string, "enabled") == 0)) {
-		printk(KERN_INFO "batman-adv:Setting VIS mode to server (enabling vis server)\n");
-		atomic_set(&vis_mode, VIS_TYPE_SERVER_SYNC);
-	} else
-		printk(KERN_ERR "batman-adv:Unknown VIS mode: %s\n",
-		       vis_mode_string);
-
-	kfree(vis_mode_string);
-	return count;
-}
-
-static int proc_vis_srv_read(struct seq_file *seq, void *offset)
-{
-	int vis_server = atomic_read(&vis_mode);
-
-	seq_printf(seq, "[%c] client mode (server disabled)\n",
-			(vis_server == VIS_TYPE_CLIENT_UPDATE) ? 'x' : ' ');
-	seq_printf(seq, "[%c] server mode (server enabled)\n",
-			(vis_server == VIS_TYPE_SERVER_SYNC) ? 'x' : ' ');
-
-	return 0;
-}
-
-static int proc_vis_srv_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_vis_srv_read, NULL);
-}
-
-static int proc_vis_data_read(struct seq_file *seq, void *offset)
-{
-	HASHIT(hashit);
-	struct vis_info *info;
-	struct vis_info_entry *entries;
-	HLIST_HEAD(vis_if_list);
-	struct if_list_entry *entry;
-	struct hlist_node *pos, *n;
-	int i;
-	char tmp_addr_str[ETH_STR_LEN];
-	unsigned long flags;
-	int vis_server = atomic_read(&vis_mode);
-
-	rcu_read_lock();
-	if (list_empty(&if_list) || (vis_server == VIS_TYPE_CLIENT_UPDATE)) {
-		rcu_read_unlock();
-		goto end;
-	}
-
-	rcu_read_unlock();
-
-	spin_lock_irqsave(&vis_hash_lock, flags);
-	while (hash_iterate(vis_hash, &hashit)) {
-		info = hashit.bucket->data;
-		entries = (struct vis_info_entry *)
-			((char *)info + sizeof(struct vis_info));
-
-		for (i = 0; i < info->packet.entries; i++) {
-			if (entries[i].quality == 0)
-				continue;
-			proc_vis_insert_interface(entries[i].src, &vis_if_list,
-				compare_orig(entries[i].src,
-						info->packet.vis_orig));
-		}
-
-		hlist_for_each_entry(entry, pos, &vis_if_list, list) {
-			addr_to_string(tmp_addr_str, entry->addr);
-			seq_printf(seq, "%s,", tmp_addr_str);
-
-			for (i = 0; i < info->packet.entries; i++)
-				proc_vis_read_entry(seq, &entries[i],
-						entry->addr, entry->primary);
-
-			/* add primary/secondary records */
-			if (compare_orig(entry->addr, info->packet.vis_orig))
-				proc_vis_read_prim_sec(seq, &vis_if_list);
-
-			seq_printf(seq, "\n");
-		}
-
-		hlist_for_each_entry_safe(entry, pos, n, &vis_if_list, list) {
-			hlist_del(&entry->list);
-			kfree(entry);
-		}
-	}
-	spin_unlock_irqrestore(&vis_hash_lock, flags);
-
-end:
-	return 0;
-}
-
-static int proc_vis_data_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_vis_data_read, NULL);
-}
-
-/* satisfying different prototypes ... */
-static ssize_t proc_dummy_write(struct file *file, const char __user *buffer,
-				size_t count, loff_t *ppos)
-{
-	return count;
-}
-
-static const struct file_operations proc_vis_srv_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_vis_srv_open,
-	.read		= seq_read,
-	.write		= proc_vis_srv_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations proc_vis_data_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_vis_data_open,
-	.read		= seq_read,
-	.write		= proc_dummy_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static const struct file_operations proc_interfaces_fops = {
 	.owner		= THIS_MODULE,
 	.open		= proc_interfaces_open,
@@ -338,12 +198,6 @@ void cleanup_procfs(void)
 	if (proc_interface_file)
 		remove_proc_entry(PROC_FILE_INTERFACES, proc_batman_dir);
 
-	if (proc_vis_data_file)
-		remove_proc_entry(PROC_FILE_VIS_DATA, proc_batman_dir);
-
-	if (proc_vis_srv_file)
-		remove_proc_entry(PROC_FILE_VIS_SRV, proc_batman_dir);
-
 	if (proc_batman_dir)
 #ifdef __NET_NET_NAMESPACE_H
 		remove_proc_entry(PROC_ROOT_DIR, init_net.proc_net);
@@ -387,26 +241,5 @@ int setup_procfs(void)
 		return -EFAULT;
 	}
 
-	proc_vis_srv_file = create_proc_entry(PROC_FILE_VIS_SRV,
-						S_IWUSR | S_IRUGO,
-						proc_batman_dir);
-	if (proc_vis_srv_file) {
-		proc_vis_srv_file->proc_fops = &proc_vis_srv_fops;
-	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_VIS_SRV);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	proc_vis_data_file = create_proc_entry(PROC_FILE_VIS_DATA, S_IRUGO,
-					  proc_batman_dir);
-	if (proc_vis_data_file) {
-		proc_vis_data_file->proc_fops = &proc_vis_data_fops;
-	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_VIS_DATA);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
 	return 0;
 }
diff --git a/drivers/staging/batman-adv/proc.h b/drivers/staging/batman-adv/proc.h
index 68a255a..6a972a6 100644
--- a/drivers/staging/batman-adv/proc.h
+++ b/drivers/staging/batman-adv/proc.h
@@ -25,11 +25,6 @@
 #define PROC_ROOT_DIR "batman-adv"
 #define PROC_FILE_INTERFACES "interfaces"
 #define PROC_FILE_ORIG_INTERVAL "orig_interval"
-#define PROC_FILE_GATEWAYS "gateways"
-#define PROC_FILE_LOG "log"
-#define PROC_FILE_LOG_LEVEL "log_level"
-#define PROC_FILE_VIS_SRV "vis_server"
-#define PROC_FILE_VIS_DATA "vis_data"
 
 void cleanup_procfs(void);
 int setup_procfs(void);
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index a78ae5c..8c055a1 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -946,6 +946,7 @@ int recv_vis_packet(struct sk_buff *skb)
 {
 	struct vis_packet *vis_packet;
 	struct ethhdr *ethhdr;
+	struct bat_priv *bat_priv;
 	int hdr_size = sizeof(struct vis_packet);
 
 	if (skb_headlen(skb) < hdr_size)
@@ -965,15 +966,20 @@ int recv_vis_packet(struct sk_buff *skb)
 	if (is_my_mac(vis_packet->sender_orig))
 		return NET_RX_DROP;
 
+	/* FIXME: each batman_if will be attached to a softif */
+	bat_priv = netdev_priv(soft_device);
+
 	switch (vis_packet->vis_type) {
 	case VIS_TYPE_SERVER_SYNC:
 		/* TODO: handle fragmented skbs properly */
-		receive_server_sync_packet(vis_packet, skb_headlen(skb));
+		receive_server_sync_packet(bat_priv, vis_packet,
+					   skb_headlen(skb));
 		break;
 
 	case VIS_TYPE_CLIENT_UPDATE:
 		/* TODO: handle fragmented skbs properly */
-		receive_client_update_packet(vis_packet, skb_headlen(skb));
+		receive_client_update_packet(bat_priv, vis_packet,
+					     skb_headlen(skb));
 		break;
 
 	default:	/* ignore unknown packet */
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index 32d1756..a00aa88 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -243,7 +243,7 @@ void schedule_own_packet(struct batman_if *batman_if)
 	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	unsigned long send_time;
 	struct batman_packet *batman_packet;
-	int vis_server = atomic_read(&vis_mode);
+	int vis_server = atomic_read(&bat_priv->vis_mode);
 
 	/**
 	 * the interface gets activated here to avoid race conditions between
@@ -271,17 +271,17 @@ void schedule_own_packet(struct batman_if *batman_if)
 	if (vis_server == VIS_TYPE_SERVER_SYNC)
 		batman_packet->flags = VIS_SERVER;
 	else
-		batman_packet->flags = 0;
+		batman_packet->flags &= ~VIS_SERVER;
 
 	/* could be read by receive_bat_packet() */
 	atomic_inc(&batman_if->seqno);
 
 	slide_own_bcast_window(batman_if);
 	send_time = own_send_time();
-	add_bat_packet_to_list(batman_if->packet_buff,
+	add_bat_packet_to_list(bat_priv,
+			       batman_if->packet_buff,
 			       batman_if->packet_len,
-			       batman_if, 1, send_time,
-			       bat_priv);
+			       batman_if, 1, send_time);
 }
 
 void schedule_forward_packet(struct orig_node *orig_node,
@@ -336,10 +336,10 @@ void schedule_forward_packet(struct orig_node *orig_node,
 		batman_packet->flags &= ~DIRECTLINK;
 
 	send_time = forward_send_time(bat_priv);
-	add_bat_packet_to_list((unsigned char *)batman_packet,
+	add_bat_packet_to_list(bat_priv,
+			       (unsigned char *)batman_packet,
 			       sizeof(struct batman_packet) + hna_buff_len,
-			       if_incoming, 0, send_time,
-			       bat_priv);
+			       if_incoming, 0, send_time);
 }
 
 static void forw_packet_free(struct forw_packet *forw_packet)
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index 0dff959..829deb6 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -182,6 +182,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct bat_priv *priv = netdev_priv(dev);
 	struct batman_if *batman_if;
+	struct bat_priv *bat_priv;
 	uint8_t dstaddr[6];
 	int data_len = skb->len;
 	unsigned long flags;
@@ -189,6 +190,9 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 	if (atomic_read(&module_state) != MODULE_ACTIVE)
 		goto dropped;
 
+	/* FIXME: each batman_if will be attached to a softif */
+	bat_priv = netdev_priv(soft_device);
+
 	dev->trans_start = jiffies;
 	/* TODO: check this for locks */
 	hna_local_add(ethhdr->h_source);
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index d43b1ad..b735200 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -165,6 +165,19 @@ int hna_local_fill_buffer_text(struct net_device *net_dev, char *buff,
 	unsigned long flags;
 	size_t hdr_len;
 
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
 	hdr_len = sprintf(buff,
 			  "Locally retrieved addresses (from %s) announced via HNA:\n",
 			  net_dev->name);
@@ -369,6 +382,19 @@ int hna_global_fill_buffer_text(struct net_device *net_dev, char *buff,
 	unsigned long flags;
 	size_t hdr_len;
 
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
 	hdr_len = sprintf(buff,
 			  "Globally announced HNAs received via the mesh %s (translation table):\n",
 			  net_dev->name);
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index db1bb0b..e8d2e8c 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -83,6 +83,7 @@ struct neigh_node {
 struct bat_priv {
 	struct net_device_stats stats;
 	atomic_t aggregation_enabled;
+	atomic_t vis_mode;
 	struct kobject *mesh_obj;
 };
 
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index 0bfc083..5edeb32 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -102,7 +102,7 @@ static int vis_info_choose(void *data, int size)
 
 /* insert interface to the list of interfaces of one originator, if it
  * does not already exist in the list */
-void proc_vis_insert_interface(const uint8_t *interface,
+static void vis_data_insert_interface(const uint8_t *interface,
 				      struct hlist_head *if_list,
 				      bool primary)
 {
@@ -123,36 +123,119 @@ void proc_vis_insert_interface(const uint8_t *interface,
 	hlist_add_head(&entry->list, if_list);
 }
 
-void proc_vis_read_prim_sec(struct seq_file *seq,
-			    struct hlist_head *if_list)
+static ssize_t vis_data_read_prim_sec(char *buff, struct hlist_head *if_list)
 {
 	struct if_list_entry *entry;
 	struct hlist_node *pos;
 	char tmp_addr_str[ETH_STR_LEN];
+	size_t len = 0;
 
 	hlist_for_each_entry(entry, pos, if_list, list) {
 		if (entry->primary)
-			seq_printf(seq, "PRIMARY, ");
+			len += sprintf(buff + len, "PRIMARY, ");
 		else {
 			addr_to_string(tmp_addr_str, entry->addr);
-			seq_printf(seq, "SEC %s, ", tmp_addr_str);
+			len += sprintf(buff + len,  "SEC %s, ", tmp_addr_str);
 		}
 	}
+
+	return len;
 }
 
 /* read an entry  */
-void proc_vis_read_entry(struct seq_file *seq,
-				struct vis_info_entry *entry,
-				uint8_t *src,
-				bool primary)
+static ssize_t vis_data_read_entry(char *buff, struct vis_info_entry *entry,
+				   uint8_t *src, bool primary)
 {
 	char to[40];
 
 	addr_to_string(to, entry->dest);
 	if (primary && entry->quality == 0)
-		seq_printf(seq, "HNA %s, ", to);
+		return sprintf(buff, "HNA %s, ", to);
 	else if (compare_orig(entry->src, src))
-		seq_printf(seq, "TQ %s %d, ", to, entry->quality);
+		return sprintf(buff, "TQ %s %d, ", to, entry->quality);
+
+	return 0;
+}
+
+ssize_t vis_fill_buffer_text(struct net_device *net_dev, char *buff,
+			      size_t count, loff_t off)
+{
+	HASHIT(hashit);
+	struct vis_info *info;
+	struct vis_info_entry *entries;
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	HLIST_HEAD(vis_if_list);
+	struct if_list_entry *entry;
+	struct hlist_node *pos, *n;
+	size_t hdr_len, tmp_len;
+	int i, bytes_written = 0;
+	char tmp_addr_str[ETH_STR_LEN];
+	unsigned long flags;
+	int vis_server = atomic_read(&bat_priv->vis_mode);
+
+	rcu_read_lock();
+	if (list_empty(&if_list) || (vis_server == VIS_TYPE_CLIENT_UPDATE)) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	rcu_read_unlock();
+	hdr_len = 0;
+
+	spin_lock_irqsave(&vis_hash_lock, flags);
+	while (hash_iterate(vis_hash, &hashit)) {
+		info = hashit.bucket->data;
+		entries = (struct vis_info_entry *)
+			((char *)info + sizeof(struct vis_info));
+
+		/* estimated line length */
+		if (count < bytes_written + 200)
+			break;
+
+		for (i = 0; i < info->packet.entries; i++) {
+			if (entries[i].quality == 0)
+				continue;
+			vis_data_insert_interface(entries[i].src, &vis_if_list,
+				compare_orig(entries[i].src,
+						info->packet.vis_orig));
+		}
+
+		hlist_for_each_entry(entry, pos, &vis_if_list, list) {
+			addr_to_string(tmp_addr_str, entry->addr);
+			tmp_len = sprintf(buff + bytes_written,
+					  "%s,", tmp_addr_str);
+
+			for (i = 0; i < info->packet.entries; i++)
+				tmp_len += vis_data_read_entry(
+						buff + bytes_written + tmp_len,
+						&entries[i], entry->addr,
+						entry->primary);
+
+			/* add primary/secondary records */
+			if (compare_orig(entry->addr, info->packet.vis_orig))
+				tmp_len += vis_data_read_prim_sec(
+						buff + bytes_written + tmp_len,
+						&vis_if_list);
+
+			tmp_len += sprintf(buff + bytes_written + tmp_len,
+					  "\n");
+
+			hdr_len += tmp_len;
+
+			if (off >= hdr_len)
+				continue;
+
+			bytes_written += tmp_len;
+		}
+
+		hlist_for_each_entry_safe(entry, pos, n, &vis_if_list, list) {
+			hlist_del(&entry->list);
+			kfree(entry);
+		}
+	}
+	spin_unlock_irqrestore(&vis_hash_lock, flags);
+
+	return bytes_written;
 }
 
 /* add the info packet to the send list, if it was not
@@ -280,12 +363,14 @@ static struct vis_info *add_packet(struct vis_packet *vis_packet,
 }
 
 /* handle the server sync packet, forward if needed. */
-void receive_server_sync_packet(struct vis_packet *vis_packet, int vis_info_len)
+void receive_server_sync_packet(struct bat_priv *bat_priv,
+				struct vis_packet *vis_packet,
+				int vis_info_len)
 {
 	struct vis_info *info;
 	int is_new, make_broadcast;
 	unsigned long flags;
-	int vis_server = atomic_read(&vis_mode);
+	int vis_server = atomic_read(&bat_priv->vis_mode);
 
 	make_broadcast = (vis_server == VIS_TYPE_SERVER_SYNC);
 
@@ -303,13 +388,14 @@ end:
 }
 
 /* handle an incoming client update packet and schedule forward if needed. */
-void receive_client_update_packet(struct vis_packet *vis_packet,
+void receive_client_update_packet(struct bat_priv *bat_priv,
+				  struct vis_packet *vis_packet,
 				  int vis_info_len)
 {
 	struct vis_info *info;
 	int is_new;
 	unsigned long flags;
-	int vis_server = atomic_read(&vis_mode);
+	int vis_server = atomic_read(&bat_priv->vis_mode);
 	int are_target = 0;
 
 	/* clients shall not broadcast. */
@@ -376,7 +462,7 @@ static bool vis_packet_full(struct vis_info *info)
 
 /* generates a packet of own vis data,
  * returns 0 on success, -1 if no packet could be generated */
-static int generate_vis_packet(void)
+static int generate_vis_packet(struct bat_priv *bat_priv)
 {
 	HASHIT(hashit_local);
 	HASHIT(hashit_global);
@@ -388,7 +474,7 @@ static int generate_vis_packet(void)
 	unsigned long flags;
 
 	info->first_seen = jiffies;
-	info->packet.vis_type = atomic_read(&vis_mode);
+	info->packet.vis_type = atomic_read(&bat_priv->vis_mode);
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
 	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
@@ -568,12 +654,14 @@ static void send_vis_packets(struct work_struct *work)
 {
 	struct vis_info *info, *temp;
 	unsigned long flags;
+	/* FIXME: each batman_if will be attached to a softif */
+	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
 	spin_lock_irqsave(&vis_hash_lock, flags);
 
 	purge_vis_packets();
 
-	if (generate_vis_packet() == 0) {
+	if (generate_vis_packet(bat_priv) == 0) {
 		/* schedule if generation was successful */
 		send_list_add(my_vis_info);
 	}
diff --git a/drivers/staging/batman-adv/vis.h b/drivers/staging/batman-adv/vis.h
index 4e417fb..9c1fd77 100644
--- a/drivers/staging/batman-adv/vis.h
+++ b/drivers/staging/batman-adv/vis.h
@@ -47,18 +47,13 @@ struct recvlist_node {
 extern struct hashtable_t *vis_hash;
 extern spinlock_t vis_hash_lock;
 
-void proc_vis_insert_interface(const uint8_t *interface,
-				      struct hlist_head *if_list,
-				      bool primary);
-void proc_vis_read_entry(struct seq_file *seq,
-				struct vis_info_entry *entry,
-				uint8_t *src,
-				bool primary);
-void proc_vis_read_prim_sec(struct seq_file *seq,
-			    struct hlist_head *if_list);
-void receive_server_sync_packet(struct vis_packet *vis_packet,
+ssize_t vis_fill_buffer_text(struct net_device *net_dev, char *buff,
+			      size_t count, loff_t off);
+void receive_server_sync_packet(struct bat_priv *bat_priv,
+				struct vis_packet *vis_packet,
 				int vis_info_len);
-void receive_client_update_packet(struct vis_packet *vis_packet,
+void receive_client_update_packet(struct bat_priv *bat_priv,
+				  struct vis_packet *vis_packet,
 				  int vis_info_len);
 int vis_init(void);
 void vis_quit(void);
-- 
1.7.1

