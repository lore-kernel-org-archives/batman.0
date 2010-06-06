Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  6 Jun 2010 21:28:15 +0200
Message-Id: <1275852501-28523-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de>
References: <1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/9] Staging: batman-adv: Move tables from
	sysfs to debugfs
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
To: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net

Files which represent more than a single attribute aren't allowed in
sysfs. As we have some files which aren't essential and are lists or
tables aggregated from data from different places inside batman-adv, we
must place them in a filesystem without such a restriction.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/bat_debugfs.c       |   71 +++++++++++
 drivers/staging/batman-adv/bat_sysfs.c         |   79 ------------
 drivers/staging/batman-adv/main.h              |    3 +-
 drivers/staging/batman-adv/originator.c        |   64 +++-------
 drivers/staging/batman-adv/originator.h        |    3 +-
 drivers/staging/batman-adv/translation-table.c |  153 ++++++++++++------------
 drivers/staging/batman-adv/translation-table.h |    6 +-
 drivers/staging/batman-adv/vis.c               |  111 ++++++++++++-----
 drivers/staging/batman-adv/vis.h               |    3 +-
 9 files changed, 253 insertions(+), 240 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_debugfs.c b/drivers/staging/batman-adv/bat_debugfs.c
index d5b28eb..a8fe1c9 100644
--- a/drivers/staging/batman-adv/bat_debugfs.c
+++ b/drivers/staging/batman-adv/bat_debugfs.c
@@ -31,6 +31,60 @@
 
 static struct dentry *bat_debugfs;
 
+static int originators_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, orig_seq_print_text, net_dev);
+}
+
+static int transtable_global_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, hna_global_seq_print_text, net_dev);
+}
+
+static int transtable_local_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, hna_local_seq_print_text, net_dev);
+}
+
+static int vis_data_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, vis_seq_print_text, net_dev);
+}
+
+struct bat_debuginfo {
+	struct attribute attr;
+	const struct file_operations fops;
+};
+
+#define BAT_DEBUGINFO(_name, _mode, _open)	\
+struct bat_debuginfo bat_debuginfo_##_name = {	\
+	.attr = { .name = __stringify(_name),	\
+		  .mode = _mode, },		\
+	.fops = { .owner = THIS_MODULE,		\
+		  .open = _open,		\
+		  .read	= seq_read,		\
+		  .llseek = seq_lseek,		\
+		  .release = single_release,	\
+		}				\
+};
+
+static BAT_DEBUGINFO(originators, S_IRUGO, originators_open);
+static BAT_DEBUGINFO(transtable_global, S_IRUGO, transtable_global_open);
+static BAT_DEBUGINFO(transtable_local, S_IRUGO, transtable_local_open);
+static BAT_DEBUGINFO(vis_data, S_IRUGO, vis_data_open);
+
+static struct bat_debuginfo *mesh_debuginfos[] = {
+	&bat_debuginfo_originators,
+	&bat_debuginfo_transtable_global,
+	&bat_debuginfo_transtable_local,
+	&bat_debuginfo_vis_data,
+	NULL,
+};
+
 void debugfs_init(void)
 {
 	bat_debugfs = debugfs_create_dir(DEBUGFS_BAT_SUBDIR, NULL);
@@ -47,6 +101,8 @@ void debugfs_destroy(void)
 int debugfs_add_meshif(struct net_device *dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
+	struct bat_debuginfo **bat_debug;
+	struct dentry *file;
 
 	if (!bat_debugfs)
 		goto out;
@@ -57,7 +113,22 @@ int debugfs_add_meshif(struct net_device *dev)
 
 	bat_socket_setup(bat_priv);
 
+	for (bat_debug = mesh_debuginfos; *bat_debug; ++bat_debug) {
+		file = debugfs_create_file(((*bat_debug)->attr).name,
+					  S_IFREG | ((*bat_debug)->attr).mode,
+					  bat_priv->debug_dir,
+					  dev, &(*bat_debug)->fops);
+		if (!file) {
+			printk(KERN_ERR "batman-adv:Can't add debugfs file: "
+			       "%s/%s\n", dev->name, ((*bat_debug)->attr).name);
+			goto rem_attr;
+		}
+	}
+
 	return 0;
+rem_attr:
+	debugfs_remove_recursive(bat_priv->debug_dir);
+	bat_priv->debug_dir = NULL;
 out:
 #ifdef CONFIG_DEBUG_FS
 	return -ENOMEM;
diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index ffb8ea2..651bdb4 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -36,14 +36,6 @@ struct bat_attribute bat_attr_##_name = {	\
 	.store  = _store,			\
 };
 
-#define BAT_BIN_ATTR(_name, _mode, _read, _write)	\
-struct bin_attribute bat_attr_##_name = {		\
-	.attr = { .name = __stringify(_name),		\
-		  .mode = _mode, },			\
-	.read = _read,					\
-	.write = _write,				\
-};
-
 static ssize_t show_aggr_ogm(struct kobject *kobj, struct attribute *attr,
 			     char *buff)
 {
@@ -201,65 +193,11 @@ static struct bat_attribute *mesh_attrs[] = {
 	NULL,
 };
 
-static ssize_t transtable_local_read(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *bin_attr,
-				  char *buff, loff_t off, size_t count)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-
-	return hna_local_fill_buffer_text(net_dev, buff, count, off);
-}
-
-static ssize_t transtable_global_read(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *bin_attr,
-				  char *buff, loff_t off, size_t count)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-
-	return hna_global_fill_buffer_text(net_dev, buff, count, off);
-}
-
-static ssize_t originators_read(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *bin_attr,
-				  char *buff, loff_t off, size_t count)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-
-	return orig_fill_buffer_text(net_dev, buff, count, off);
-}
-
-static ssize_t vis_data_read(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *bin_attr,
-				  char *buff, loff_t off, size_t count)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-
-	return vis_fill_buffer_text(net_dev, buff, count, off);
-}
-
-static BAT_BIN_ATTR(transtable_local, S_IRUGO, transtable_local_read, NULL);
-static BAT_BIN_ATTR(transtable_global, S_IRUGO, transtable_global_read, NULL);
-static BAT_BIN_ATTR(originators, S_IRUGO, originators_read, NULL);
-static BAT_BIN_ATTR(vis_data, S_IRUGO, vis_data_read, NULL);
-
-static struct bin_attribute *mesh_bin_attrs[] = {
-	&bat_attr_transtable_local,
-	&bat_attr_transtable_global,
-	&bat_attr_originators,
-	&bat_attr_vis_data,
-	NULL,
-};
-
 int sysfs_add_meshif(struct net_device *dev)
 {
 	struct kobject *batif_kobject = &dev->dev.kobj;
 	struct bat_priv *bat_priv = netdev_priv(dev);
 	struct bat_attribute **bat_attr;
-	struct bin_attribute **bin_attr;
 	int err;
 
 	/* FIXME: should be done in the general mesh setup
@@ -289,21 +227,8 @@ int sysfs_add_meshif(struct net_device *dev)
 		}
 	}
 
-	for (bin_attr = mesh_bin_attrs; *bin_attr; ++bin_attr) {
-		err = sysfs_create_bin_file(bat_priv->mesh_obj, (*bin_attr));
-		if (err) {
-			printk(KERN_ERR "batman-adv:Can't add sysfs file: %s/%s/%s\n",
-			       dev->name, SYSFS_IF_MESH_SUBDIR,
-			       ((*bin_attr)->attr).name);
-			goto rem_bin_attr;
-		}
-	}
-
 	return 0;
 
-rem_bin_attr:
-	for (bin_attr = mesh_bin_attrs; *bin_attr; ++bin_attr)
-		sysfs_remove_bin_file(bat_priv->mesh_obj, (*bin_attr));
 rem_attr:
 	for (bat_attr = mesh_attrs; *bat_attr; ++bat_attr)
 		sysfs_remove_file(bat_priv->mesh_obj, &((*bat_attr)->attr));
@@ -318,10 +243,6 @@ void sysfs_del_meshif(struct net_device *dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
 	struct bat_attribute **bat_attr;
-	struct bin_attribute **bin_attr;
-
-	for (bin_attr = mesh_bin_attrs; *bin_attr; ++bin_attr)
-		sysfs_remove_bin_file(bat_priv->mesh_obj, (*bin_attr));
 
 	for (bat_attr = mesh_attrs; *bat_attr; ++bat_attr)
 		sysfs_remove_file(bat_priv->mesh_obj, &((*bat_attr)->attr));
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 5f8343d..232fc25 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -70,7 +70,7 @@
 #define MODULE_ACTIVE 1
 #define MODULE_DEACTIVATING 2
 
-#define BCAST_QUEUE_LEN 256
+#define BCAST_QUEUE_LEN		256
 #define BATMAN_QUEUE_LEN	256
 
 /*
@@ -117,6 +117,7 @@ extern int bat_debug_type(int type);
 #include <linux/slab.h>
 #include <net/sock.h>		/* struct sock */
 #include <linux/jiffies.h>
+#include <linux/seq_file.h>
 #include "types.h"
 
 #ifndef REVISION_VERSION
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 568aef8..c159707 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -271,39 +271,31 @@ void purge_orig(struct work_struct *work)
 		start_purge_timer();
 }
 
-ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
-			      size_t count, loff_t off)
+int orig_seq_print_text(struct seq_file *seq, void *offset)
 {
 	HASHIT(hashit);
+	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	struct orig_node *orig_node;
 	struct neigh_node *neigh_node;
-	size_t hdr_len, tmp_len;
-	int batman_count = 0, bytes_written = 0;
+	int batman_count = 0;
 	unsigned long flags;
 	char orig_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
 
-	if (!bat_priv->primary_if) {
-		if (off == 0)
-			return sprintf(buff,
-				     "BATMAN mesh %s disabled - "
+	if ((!bat_priv->primary_if) ||
+	    (bat_priv->primary_if->if_status != IF_ACTIVE)) {
+		if (!bat_priv->primary_if)
+			return seq_printf(seq, "BATMAN mesh %s disabled - "
 				     "please specify interfaces to enable it\n",
 				     net_dev->name);
 
-		return 0;
+		return seq_printf(seq, "BATMAN mesh %s "
+				  "disabled - primary interface not active\n",
+				  net_dev->name);
 	}
 
-	if (bat_priv->primary_if->if_status != IF_ACTIVE && off == 0)
-		return sprintf(buff,
-			       "BATMAN mesh %s "
-			       "disabled - primary interface not active\n",
-			       net_dev->name);
-	else if (bat_priv->primary_if->if_status != IF_ACTIVE)
-		return 0;
-
 	rcu_read_lock();
-	hdr_len = sprintf(buff,
-		   "  %-14s (%s/%i) %17s [%10s]: %20s "
+	seq_printf(seq, "  %-14s (%s/%i) %17s [%10s]: %20s "
 		   "... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
 		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
 		   "Potential nexthops", SOURCE_VERSION, REVISION_VERSION_STR,
@@ -311,9 +303,6 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 		   net_dev->name);
 	rcu_read_unlock();
 
-	if (off < hdr_len)
-		bytes_written = hdr_len;
-
 	spin_lock_irqsave(&orig_hash_lock, flags);
 
 	while (hash_iterate(orig_hash, &hashit)) {
@@ -326,44 +315,29 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 		if (orig_node->router->tq_avg == 0)
 			continue;
 
-		/* estimated line length */
-		if (count < bytes_written + 200)
-			break;
-
 		addr_to_string(orig_str, orig_node->orig);
 		addr_to_string(router_str, orig_node->router->addr);
 
-		tmp_len = sprintf(buff + bytes_written,
-				  "%-17s  (%3i) %17s [%10s]:",
-				   orig_str, orig_node->router->tq_avg,
-				   router_str,
-				   orig_node->router->if_incoming->dev);
+		seq_printf(seq, "%-17s  (%3i) %17s [%10s]:",
+			   orig_str, orig_node->router->tq_avg, router_str,
+			   orig_node->router->if_incoming->dev);
 
 		list_for_each_entry(neigh_node, &orig_node->neigh_list, list) {
 			addr_to_string(orig_str, neigh_node->addr);
-			tmp_len += sprintf(buff + bytes_written + tmp_len,
-					   " %17s (%3i)", orig_str,
+			seq_printf(seq, " %17s (%3i)", orig_str,
 					   neigh_node->tq_avg);
 		}
 
-		tmp_len += sprintf(buff + bytes_written + tmp_len, "\n");
-
+		seq_printf(seq, "\n");
 		batman_count++;
-		hdr_len += tmp_len;
-
-		if (off >= hdr_len)
-			continue;
-
-		bytes_written += tmp_len;
 	}
 
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 
-	if ((batman_count == 0) && (off == 0))
-		bytes_written += sprintf(buff + bytes_written,
-					"No batman nodes in range ...\n");
+	if ((batman_count == 0))
+		seq_printf(seq, "No batman nodes in range ...\n");
 
-	return bytes_written;
+	return 0;
 }
 
 static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
diff --git a/drivers/staging/batman-adv/originator.h b/drivers/staging/batman-adv/originator.h
index afbc7c0..e91e8a1 100644
--- a/drivers/staging/batman-adv/originator.h
+++ b/drivers/staging/batman-adv/originator.h
@@ -28,7 +28,6 @@ struct orig_node *get_orig_node(uint8_t *addr);
 struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming);
-ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
-			      size_t count, loff_t off);
+int orig_seq_print_text(struct seq_file *seq, void *offset);
 int orig_hash_add_if(struct batman_if *batman_if, int max_if_num);
 int orig_hash_del_if(struct batman_if *batman_if, int max_if_num);
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index e01ff21..604122c 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -160,59 +160,59 @@ int hna_local_fill_buffer(unsigned char *buff, int buff_len)
 	return i;
 }
 
-int hna_local_fill_buffer_text(struct net_device *net_dev, char *buff,
-			       size_t count, loff_t off)
+int hna_local_seq_print_text(struct seq_file *seq, void *offset)
 {
+	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	struct hna_local_entry *hna_local_entry;
 	HASHIT(hashit);
-	int bytes_written = 0;
+	HASHIT(hashit_count);
 	unsigned long flags;
-	size_t hdr_len;
+	size_t buf_size, pos;
+	char *buff;
 
 	if (!bat_priv->primary_if) {
-		if (off == 0)
-			return sprintf(buff,
-				     "BATMAN mesh %s disabled - "
-				     "please specify interfaces to enable it\n",
-				     net_dev->name);
-
-		return 0;
+		return seq_printf(seq, "BATMAN mesh %s disabled - "
+			       "please specify interfaces to enable it\n",
+			       net_dev->name);
 	}
 
-	hdr_len = sprintf(buff,
-			  "Locally retrieved addresses (from %s) "
-			  "announced via HNA:\n",
-			  net_dev->name);
-
-	if (off < hdr_len)
-		bytes_written = hdr_len;
+	seq_printf(seq, "Locally retrieved addresses (from %s) "
+		   "announced via HNA:\n",
+		   net_dev->name);
 
 	spin_lock_irqsave(&hna_local_hash_lock, flags);
 
+	buf_size = 1;
+	/* Estimate length for: " * xx:xx:xx:xx:xx:xx\n" */
+	while (hash_iterate(hna_local_hash, &hashit_count))
+		buf_size += 21;
+
+	buff = kmalloc(buf_size, GFP_ATOMIC);
+	if (!buff) {
+		spin_unlock_irqrestore(&hna_local_hash_lock, flags);
+		return -ENOMEM;
+	}
+	buff[0] = '\0';
+	pos = 0;
+
 	while (hash_iterate(hna_local_hash, &hashit)) {
-		hdr_len += 21;
-
-		if (count < bytes_written + 22)
-			break;
-
-		if (off >= hdr_len)
-			continue;
-
 		hna_local_entry = hashit.bucket->data;
 
-		bytes_written += snprintf(buff + bytes_written, 22,
-					  " * " MAC_FMT "\n",
-					  hna_local_entry->addr[0],
-					  hna_local_entry->addr[1],
-					  hna_local_entry->addr[2],
-					  hna_local_entry->addr[3],
-					  hna_local_entry->addr[4],
-					  hna_local_entry->addr[5]);
+		pos += snprintf(buff + pos, 22, " * " MAC_FMT "\n",
+				hna_local_entry->addr[0],
+				hna_local_entry->addr[1],
+				hna_local_entry->addr[2],
+				hna_local_entry->addr[3],
+				hna_local_entry->addr[4],
+				hna_local_entry->addr[5]);
 	}
 
 	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
-	return bytes_written;
+
+	seq_printf(seq, "%s", buff);
+	kfree(buff);
+	return 0;
 }
 
 static void _hna_local_del(void *data)
@@ -378,65 +378,66 @@ void hna_global_add_orig(struct orig_node *orig_node,
 	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
 }
 
-int hna_global_fill_buffer_text(struct net_device *net_dev, char *buff,
-				size_t count, loff_t off)
+int hna_global_seq_print_text(struct seq_file *seq, void *offset)
 {
+	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	struct hna_global_entry *hna_global_entry;
 	HASHIT(hashit);
-	int bytes_written = 0;
+	HASHIT(hashit_count);
 	unsigned long flags;
-	size_t hdr_len;
+	size_t buf_size, pos;
+	char *buff;
 
 	if (!bat_priv->primary_if) {
-		if (off == 0)
-			return sprintf(buff,
-				     "BATMAN mesh %s disabled - "
-				     "please specify interfaces to enable it\n",
-				     net_dev->name);
-
-		return 0;
+		return seq_printf(seq, "BATMAN mesh %s disabled - "
+				  "please specify interfaces to enable it\n",
+				  net_dev->name);
 	}
 
-	hdr_len = sprintf(buff,
-			  "Globally announced HNAs received via the mesh %s "
-			  "(translation table):\n",
-			  net_dev->name);
-
-	if (off < hdr_len)
-		bytes_written = hdr_len;
+	seq_printf(seq, "Globally announced HNAs received via the mesh %s "
+			"(translation table):\n",
+		   net_dev->name);
 
 	spin_lock_irqsave(&hna_global_hash_lock, flags);
 
+	buf_size = 1;
+	/* Estimate length for: " * xx:xx:xx:xx:xx:xx via xx:xx:xx:xx:xx:xx\n"*/
+	while (hash_iterate(hna_global_hash, &hashit_count))
+		buf_size += 43;
+
+	buff = kmalloc(buf_size, GFP_ATOMIC);
+	if (!buff) {
+		spin_unlock_irqrestore(&hna_global_hash_lock, flags);
+		return -ENOMEM;
+	}
+	buff[0] = '\0';
+	pos = 0;
+
 	while (hash_iterate(hna_global_hash, &hashit)) {
-		hdr_len += 43;
-
-		if (count < bytes_written + 44)
-			break;
-
-		if (off >= hdr_len)
-			continue;
-
 		hna_global_entry = hashit.bucket->data;
 
-		bytes_written += snprintf(buff + bytes_written, 44,
-					  " * " MAC_FMT " via " MAC_FMT "\n",
-					  hna_global_entry->addr[0],
-					  hna_global_entry->addr[1],
-					  hna_global_entry->addr[2],
-					  hna_global_entry->addr[3],
-					  hna_global_entry->addr[4],
-					  hna_global_entry->addr[5],
-					  hna_global_entry->orig_node->orig[0],
-					  hna_global_entry->orig_node->orig[1],
-					  hna_global_entry->orig_node->orig[2],
-					  hna_global_entry->orig_node->orig[3],
-					  hna_global_entry->orig_node->orig[4],
-					  hna_global_entry->orig_node->orig[5]);
+		pos += snprintf(buff + pos, 44,
+				" * " MAC_FMT " via " MAC_FMT "\n",
+				hna_global_entry->addr[0],
+				hna_global_entry->addr[1],
+				hna_global_entry->addr[2],
+				hna_global_entry->addr[3],
+				hna_global_entry->addr[4],
+				hna_global_entry->addr[5],
+				hna_global_entry->orig_node->orig[0],
+				hna_global_entry->orig_node->orig[1],
+				hna_global_entry->orig_node->orig[2],
+				hna_global_entry->orig_node->orig[3],
+				hna_global_entry->orig_node->orig[4],
+				hna_global_entry->orig_node->orig[5]);
 	}
 
 	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
-	return bytes_written;
+
+	seq_printf(seq, "%s", buff);
+	kfree(buff);
+	return 0;
 }
 
 void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
diff --git a/drivers/staging/batman-adv/translation-table.h b/drivers/staging/batman-adv/translation-table.h
index 8f412fc..8b3429e 100644
--- a/drivers/staging/batman-adv/translation-table.h
+++ b/drivers/staging/batman-adv/translation-table.h
@@ -25,15 +25,13 @@ int hna_local_init(void);
 void hna_local_add(uint8_t *addr);
 void hna_local_remove(uint8_t *addr, char *message);
 int hna_local_fill_buffer(unsigned char *buff, int buff_len);
-int hna_local_fill_buffer_text(struct net_device *net_dev, char *buff,
-			       size_t count, loff_t off);
+int hna_local_seq_print_text(struct seq_file *seq, void *offset);
 void hna_local_purge(struct work_struct *work);
 void hna_local_free(void);
 int hna_global_init(void);
 void hna_global_add_orig(struct orig_node *orig_node, unsigned char *hna_buff,
 			 int hna_buff_len);
-int hna_global_fill_buffer_text(struct net_device *net_dev, char *buff,
-				size_t count, loff_t off);
+int hna_global_seq_print_text(struct seq_file *seq, void *offset);
 void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
 			  char *orig_str);
 void hna_global_del_orig(struct orig_node *orig_node, char *message);
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index 1d3d954..2b109db 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -115,7 +115,7 @@ static void vis_data_insert_interface(const uint8_t *interface,
 	}
 
 	/* its a new address, add it to the list */
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
 		return;
 	memcpy(entry->addr, interface, ETH_ALEN);
@@ -142,12 +142,29 @@ static ssize_t vis_data_read_prim_sec(char *buff, struct hlist_head *if_list)
 	return len;
 }
 
+static size_t vis_data_count_prim_sec(struct hlist_head *if_list)
+{
+	struct if_list_entry *entry;
+	struct hlist_node *pos;
+	size_t count = 0;
+
+	hlist_for_each_entry(entry, pos, if_list, list) {
+		if (entry->primary)
+			count += 9;
+		else
+			count += 23;
+	}
+
+	return count;
+}
+
 /* read an entry  */
 static ssize_t vis_data_read_entry(char *buff, struct vis_info_entry *entry,
 				   uint8_t *src, bool primary)
 {
-	char to[40];
+	char to[18];
 
+	/* maximal length: max(4+17+2, 3+17+1+3+2) == 26 */
 	addr_to_string(to, entry->dest);
 	if (primary && entry->quality == 0)
 		return sprintf(buff, "HNA %s, ", to);
@@ -157,38 +174,74 @@ static ssize_t vis_data_read_entry(char *buff, struct vis_info_entry *entry,
 	return 0;
 }
 
-ssize_t vis_fill_buffer_text(struct net_device *net_dev, char *buff,
-			      size_t count, loff_t off)
+int vis_seq_print_text(struct seq_file *seq, void *offset)
 {
 	HASHIT(hashit);
+	HASHIT(hashit_count);
 	struct vis_info *info;
 	struct vis_info_entry *entries;
+	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	HLIST_HEAD(vis_if_list);
 	struct if_list_entry *entry;
 	struct hlist_node *pos, *n;
-	size_t hdr_len, tmp_len;
-	int i, bytes_written = 0;
+	int i;
 	char tmp_addr_str[ETH_STR_LEN];
 	unsigned long flags;
 	int vis_server = atomic_read(&bat_priv->vis_mode);
+	size_t buff_pos, buf_size;
+	char *buff;
 
 	if ((!bat_priv->primary_if) ||
 	    (vis_server == VIS_TYPE_CLIENT_UPDATE))
 		return 0;
 
-	hdr_len = 0;
-
+	buf_size = 1;
+	/* Estimate length */
 	spin_lock_irqsave(&vis_hash_lock, flags);
+	while (hash_iterate(vis_hash, &hashit_count)) {
+		info = hashit_count.bucket->data;
+		entries = (struct vis_info_entry *)
+			((char *)info + sizeof(struct vis_info));
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
+			buf_size += 18 + 26 * info->packet.entries;
+
+			/* add primary/secondary records */
+			if (compare_orig(entry->addr, info->packet.vis_orig))
+				buf_size +=
+					vis_data_count_prim_sec(&vis_if_list);
+
+			buf_size += 1;
+		}
+
+		hlist_for_each_entry_safe(entry, pos, n, &vis_if_list, list) {
+			hlist_del(&entry->list);
+			kfree(entry);
+		}
+	}
+
+	buff = kmalloc(buf_size, GFP_ATOMIC);
+	if (!buff) {
+		spin_unlock_irqrestore(&vis_hash_lock, flags);
+		return -ENOMEM;
+	}
+	buff[0] = '\0';
+	buff_pos = 0;
+
 	while (hash_iterate(vis_hash, &hashit)) {
 		info = hashit.bucket->data;
 		entries = (struct vis_info_entry *)
 			((char *)info + sizeof(struct vis_info));
 
-		/* estimated line length */
-		if (count < bytes_written + 200)
-			break;
-
 		for (i = 0; i < info->packet.entries; i++) {
 			if (entries[i].quality == 0)
 				continue;
@@ -199,30 +252,22 @@ ssize_t vis_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 		hlist_for_each_entry(entry, pos, &vis_if_list, list) {
 			addr_to_string(tmp_addr_str, entry->addr);
-			tmp_len = sprintf(buff + bytes_written,
-					  "%s,", tmp_addr_str);
+			buff_pos += sprintf(buff + buff_pos, "%s,",
+					    tmp_addr_str);
 
 			for (i = 0; i < info->packet.entries; i++)
-				tmp_len += vis_data_read_entry(
-						buff + bytes_written + tmp_len,
-						&entries[i], entry->addr,
-						entry->primary);
+				buff_pos += vis_data_read_entry(buff + buff_pos,
+								&entries[i],
+								entry->addr,
+								entry->primary);
 
 			/* add primary/secondary records */
 			if (compare_orig(entry->addr, info->packet.vis_orig))
-				tmp_len += vis_data_read_prim_sec(
-						buff + bytes_written + tmp_len,
-						&vis_if_list);
+				buff_pos +=
+					vis_data_read_prim_sec(buff + buff_pos,
+							       &vis_if_list);
 
-			tmp_len += sprintf(buff + bytes_written + tmp_len,
-					  "\n");
-
-			hdr_len += tmp_len;
-
-			if (off >= hdr_len)
-				continue;
-
-			bytes_written += tmp_len;
+			buff_pos += sprintf(buff + buff_pos, "\n");
 		}
 
 		hlist_for_each_entry_safe(entry, pos, n, &vis_if_list, list) {
@@ -230,9 +275,13 @@ ssize_t vis_fill_buffer_text(struct net_device *net_dev, char *buff,
 			kfree(entry);
 		}
 	}
+
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
 
-	return bytes_written;
+	seq_printf(seq, "%s", buff);
+	kfree(buff);
+
+	return 0;
 }
 
 /* add the info packet to the send list, if it was not
diff --git a/drivers/staging/batman-adv/vis.h b/drivers/staging/batman-adv/vis.h
index 9c1fd77..5dd6521 100644
--- a/drivers/staging/batman-adv/vis.h
+++ b/drivers/staging/batman-adv/vis.h
@@ -47,8 +47,7 @@ struct recvlist_node {
 extern struct hashtable_t *vis_hash;
 extern spinlock_t vis_hash_lock;
 
-ssize_t vis_fill_buffer_text(struct net_device *net_dev, char *buff,
-			      size_t count, loff_t off);
+int vis_seq_print_text(struct seq_file *seq, void *offset);
 void receive_server_sync_packet(struct bat_priv *bat_priv,
 				struct vis_packet *vis_packet,
 				int vis_info_len);
-- 
1.7.1

