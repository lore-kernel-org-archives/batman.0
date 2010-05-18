Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 18 May 2010 22:37:08 +0200
Message-Id: <1274215029-7733-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201005182235.22328.sven.eckelmann@gmx.de>
References: <201005182235.22328.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv1 3/4] batman-adv: Move tables from sysfs to
	debugfs
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

Files which represent more than a single attribute aren't allowed in
sysfs. As we have some files which aren't essential and are lists or
tables aggregated from data from different places inside batman-adv, we
must place them in a filesystem without such a restriction.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/bat_debugfs.c       |   79 ++++++++++++++++++++
 batman-adv-kernelland/bat_sysfs.c         |   91 -----------------------
 batman-adv-kernelland/gateway_client.c    |   64 +++++-----------
 batman-adv-kernelland/gateway_client.h    |    3 +-
 batman-adv-kernelland/main.h              |    1 +
 batman-adv-kernelland/originator.c        |   61 +++++-----------
 batman-adv-kernelland/originator.h        |    3 +-
 batman-adv-kernelland/translation-table.c |  114 ++++++++++-------------------
 batman-adv-kernelland/translation-table.h |    6 +-
 batman-adv-kernelland/vis.c               |   59 +++++----------
 batman-adv-kernelland/vis.h               |    3 +-
 11 files changed, 181 insertions(+), 303 deletions(-)

diff --git a/batman-adv-kernelland/bat_debugfs.c b/batman-adv-kernelland/bat_debugfs.c
index 19e7bee..9113601 100644
--- a/batman-adv-kernelland/bat_debugfs.c
+++ b/batman-adv-kernelland/bat_debugfs.c
@@ -34,6 +34,68 @@
 
 static struct dentry *bat_debugfs;
 
+static int originators_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, orig_seq_print_text, net_dev);
+}
+
+static int gateways_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, gw_client_seq_print_text, net_dev);
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
+static BAT_DEBUGINFO(gateways, S_IRUGO, gateways_open);
+static BAT_DEBUGINFO(transtable_global, S_IRUGO, transtable_global_open);
+static BAT_DEBUGINFO(transtable_local, S_IRUGO, transtable_local_open);
+static BAT_DEBUGINFO(vis_data, S_IRUGO, vis_data_open);
+
+static struct bat_debuginfo *mesh_debuginfos[] = {
+	&bat_debuginfo_originators,
+	&bat_debuginfo_gateways,
+	&bat_debuginfo_transtable_global,
+	&bat_debuginfo_transtable_local,
+	&bat_debuginfo_vis_data,
+	NULL,
+};
+
 void debugfs_init(void)
 {
 	bat_debugfs = debugfs_create_dir(DEBUGFS_BAT_SUBDIR, NULL);
@@ -50,6 +112,8 @@ void debugfs_destroy(void)
 int debugfs_add_meshif(struct net_device *dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
+	struct bat_debuginfo **bat_debug;
+	struct dentry *file;
 
 	if (!bat_debugfs)
 		goto out;
@@ -60,7 +124,22 @@ int debugfs_add_meshif(struct net_device *dev)
 
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
 	return -ENOMEM;
 }
diff --git a/batman-adv-kernelland/bat_sysfs.c b/batman-adv-kernelland/bat_sysfs.c
index 7690368..a689aec 100644
--- a/batman-adv-kernelland/bat_sysfs.c
+++ b/batman-adv-kernelland/bat_sysfs.c
@@ -39,14 +39,6 @@ struct bat_attribute bat_attr_##_name = {	\
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
@@ -305,77 +297,11 @@ static struct bat_attribute *mesh_attrs[] = {
 	NULL,
 };
 
-static ssize_t transtable_local_read(struct kobject *kobj,
-			       struct bin_attribute *bin_attr,
-			       char *buff, loff_t off, size_t count)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-
-	return hna_local_fill_buffer_text(net_dev, buff, count, off);
-}
-
-static ssize_t transtable_global_read(struct kobject *kobj,
-			       struct bin_attribute *bin_attr,
-			       char *buff, loff_t off, size_t count)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-
-	return hna_global_fill_buffer_text(net_dev, buff, count, off);
-}
-
-static ssize_t originators_read(struct kobject *kobj,
-			       struct bin_attribute *bin_attr,
-			       char *buff, loff_t off, size_t count)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-
-	return orig_fill_buffer_text(net_dev, buff, count, off);
-}
-
-static ssize_t gateways_read(struct kobject *kobj,
-			     struct bin_attribute *bin_attr,
-			     char *buff, loff_t off, size_t count)
-{
-	struct device *dev = to_dev(kobj->parent);
-	struct net_device *net_dev = to_net_dev(dev);
-
-	return gw_client_fill_buffer_text(net_dev, buff, count, off);
-}
-
-static ssize_t vis_data_read(struct kobject *kobj,
-			     struct bin_attribute *bin_attr,
-			     char *buff, loff_t off, size_t count)
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
-static BAT_BIN_ATTR(gateways, S_IRUGO, gateways_read, NULL);
-static BAT_BIN_ATTR(vis_data, S_IRUGO, vis_data_read, NULL);
-
-static struct bin_attribute *mesh_bin_attrs[] = {
-	&bat_attr_transtable_local,
-	&bat_attr_transtable_global,
-	&bat_attr_originators,
-	&bat_attr_gateways,
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
@@ -411,21 +337,8 @@ int sysfs_add_meshif(struct net_device *dev)
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
@@ -440,10 +353,6 @@ void sysfs_del_meshif(struct net_device *dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
 	struct bat_attribute **bat_attr;
-	struct bin_attribute **bin_attr;
-
-	for (bin_attr = mesh_bin_attrs; *bin_attr; ++bin_attr)
-		sysfs_remove_bin_file(bat_priv->mesh_obj, (*bin_attr));
 
 	for (bat_attr = mesh_attrs; *bat_attr; ++bat_attr)
 		sysfs_remove_file(bat_priv->mesh_obj, &((*bat_attr)->attr));
diff --git a/batman-adv-kernelland/gateway_client.c b/batman-adv-kernelland/gateway_client.c
index a5e4f5f..552ef6f 100644
--- a/batman-adv-kernelland/gateway_client.c
+++ b/batman-adv-kernelland/gateway_client.c
@@ -317,8 +317,7 @@ void gw_node_list_free(void)
 	spin_unlock(&gw_list_lock);
 }
 
-static int _write_buffer_text(unsigned char *buff, int bytes_written,
-			      struct gw_node *gw_node)
+static int _write_buffer_text(struct seq_file *seq, struct gw_node *gw_node)
 {
 	int down, up;
 	char gw_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
@@ -327,8 +326,7 @@ static int _write_buffer_text(unsigned char *buff, int bytes_written,
 	addr_to_string(router_str, gw_node->orig_node->router->addr);
 	gw_srv_class_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
 
-	return sprintf(buff + bytes_written,
-		       "%s %-17s (%3i) %17s [%10s]: %3i - %i%s/%i%s\n",
+	return seq_printf(seq, "%s %-17s (%3i) %17s [%10s]: %3i - %i%s/%i%s\n",
 		       (curr_gateway == gw_node ? "=>" : "  "),
 		       gw_str,
 		       gw_node->orig_node->router->tq_avg,
@@ -341,51 +339,38 @@ static int _write_buffer_text(unsigned char *buff, int bytes_written,
 		       (up > 2048 ? "MBit" : "KBit"));
 }
 
-int gw_client_fill_buffer_text(struct net_device *net_dev, char *buff,
-			       size_t count, loff_t off)
+int gw_client_seq_print_text(struct seq_file *seq, void *offset)
 {
+	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	struct gw_node *gw_node;
-	size_t hdr_len, tmp_len;
-	int bytes_written = 0, gw_count = 0;
+	int gw_count = 0;
 
 	rcu_read_lock();
 	if (!bat_priv->primary_if) {
 		rcu_read_unlock();
 
-		if (off == 0)
-			return sprintf(buff,
-				       "BATMAN mesh %s disabled - please "
-				       "specify interfaces to enable it\n",
-				       net_dev->name);
-
-		return 0;
+		return seq_printf(seq, "BATMAN mesh %s disabled - please "
+				  "specify interfaces to enable it\n",
+				  net_dev->name);
 	}
 
 	if (bat_priv->primary_if->if_status != IF_ACTIVE) {
 		rcu_read_unlock();
 
-		if (off == 0)
-			return sprintf(buff,
-				       "BATMAN mesh %s disabled - "
+		return seq_printf(seq, "BATMAN mesh %s disabled - "
 				       "primary interface not active\n",
 				       net_dev->name);
-
-		return 0;
 	}
 
-	hdr_len = sprintf(buff, "      %-12s (%s/%i) %17s [%10s]: gw_class ... "
-			  "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
-			  "Gateway", "#", TQ_MAX_VALUE, "Nexthop",
-			  "outgoingIF", SOURCE_VERSION, REVISION_VERSION_STR,
-			  bat_priv->primary_if->dev,
-			  bat_priv->primary_if->addr_str,
-			  net_dev->name);
+	seq_printf(seq, "      %-12s (%s/%i) %17s [%10s]: gw_class ... "
+		   "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
+		   "Gateway", "#", TQ_MAX_VALUE, "Nexthop",
+		   "outgoingIF", SOURCE_VERSION, REVISION_VERSION_STR,
+		   bat_priv->primary_if->dev, bat_priv->primary_if->addr_str,
+		   net_dev->name);
 	rcu_read_unlock();
 
-	if (off < hdr_len)
-		bytes_written = hdr_len;
-
 	rcu_read_lock();
 	list_for_each_entry_rcu(gw_node, &gw_list, list) {
 		if (gw_node->deleted)
@@ -394,26 +379,15 @@ int gw_client_fill_buffer_text(struct net_device *net_dev, char *buff,
 		if (!gw_node->orig_node->router)
 			continue;
 
-		if (count < bytes_written + (2 * ETH_STR_LEN) + 30)
-			break;
-
-		tmp_len = _write_buffer_text(buff, bytes_written, gw_node);
+		_write_buffer_text(seq, gw_node);
 		gw_count++;
-
-		hdr_len += tmp_len;
-
-		if (off >= hdr_len)
-			continue;
-
-		bytes_written += tmp_len;
 	}
 	rcu_read_unlock();
 
-	if ((gw_count == 0) && (off == 0))
-		bytes_written += sprintf(buff + bytes_written,
-					 "No gateways in range ...\n");
+	if (gw_count == 0)
+		seq_printf(seq, "No gateways in range ...\n");
 
-	return bytes_written;
+	return 0;
 }
 
 bool gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb)
diff --git a/batman-adv-kernelland/gateway_client.h b/batman-adv-kernelland/gateway_client.h
index 38dc142..6a71cee 100644
--- a/batman-adv-kernelland/gateway_client.h
+++ b/batman-adv-kernelland/gateway_client.h
@@ -27,6 +27,5 @@ void gw_node_update(struct orig_node *orig_node, uint8_t new_gwflags);
 void gw_node_delete(struct orig_node *orig_node);
 void gw_node_purge_deleted(void);
 void gw_node_list_free(void);
-int gw_client_fill_buffer_text(struct net_device *net_dev, char *buff,
-			       size_t count, loff_t off);
+int gw_client_seq_print_text(struct seq_file *seq, void *offset);
 bool gw_is_target(struct bat_priv *bat_priv, struct sk_buff *skb);
diff --git a/batman-adv-kernelland/main.h b/batman-adv-kernelland/main.h
index 730343e..ef2cbfd 100644
--- a/batman-adv-kernelland/main.h
+++ b/batman-adv-kernelland/main.h
@@ -123,6 +123,7 @@ extern int bat_debug_type(int type);
 #include <linux/workqueue.h>	/* workqueue */
 #include <net/sock.h>		/* struct sock */
 #include <linux/jiffies.h>
+#include <linux/seq_file.h>
 #include "types.h"
 
 #ifndef REVISION_VERSION
diff --git a/batman-adv-kernelland/originator.c b/batman-adv-kernelland/originator.c
index 2c84f0d..28e35b6 100644
--- a/batman-adv-kernelland/originator.c
+++ b/batman-adv-kernelland/originator.c
@@ -284,38 +284,31 @@ void purge_orig(struct work_struct *work)
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
 
 	if ((!bat_priv->primary_if) ||
 	    (bat_priv->primary_if->if_status != IF_ACTIVE)) {
-		if (off > 0)
-			return 0;
-
 		if (!bat_priv->primary_if)
-			return sprintf(buff,
-				    "BATMAN mesh %s disabled - "
-				    "please specify interfaces to enable it\n",
-				    net_dev->name);
+			return seq_printf(seq, "BATMAN mesh %s disabled - "
+				     "please specify interfaces to enable it\n",
+				     net_dev->name);
 
-		return sprintf(buff,
-			       "BATMAN mesh %s "
-			       "disabled - primary interface not active\n",
-			       net_dev->name);
+		return seq_printf(seq, "BATMAN mesh %s "
+				  "disabled - primary interface not active\n",
+				  net_dev->name);
 	}
 
 	rcu_read_lock();
-	hdr_len = sprintf(buff,
-		   "  %-14s (%s/%i) %17s [%10s]: %20s "
+	seq_printf(seq, "  %-14s (%s/%i) %17s [%10s]: %20s "
 		   "... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
 		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
 		   "Potential nexthops", SOURCE_VERSION, REVISION_VERSION_STR,
@@ -323,9 +316,6 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 		   net_dev->name);
 	rcu_read_unlock();
 
-	if (off < hdr_len)
-		bytes_written = hdr_len;
-
 	spin_lock_irqsave(&orig_hash_lock, flags);
 
 	while (hash_iterate(orig_hash, &hashit)) {
@@ -338,44 +328,29 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
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
diff --git a/batman-adv-kernelland/originator.h b/batman-adv-kernelland/originator.h
index afbc7c0..e91e8a1 100644
--- a/batman-adv-kernelland/originator.h
+++ b/batman-adv-kernelland/originator.h
@@ -28,7 +28,6 @@ struct orig_node *get_orig_node(uint8_t *addr);
 struct neigh_node *
 create_neighbor(struct orig_node *orig_node, struct orig_node *orig_neigh_node,
 		uint8_t *neigh, struct batman_if *if_incoming);
-ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
-			      size_t count, loff_t off);
+int orig_seq_print_text(struct seq_file *seq, void *offset);
 int orig_hash_add_if(struct batman_if *batman_if, int max_if_num);
 int orig_hash_del_if(struct batman_if *batman_if, int max_if_num);
diff --git a/batman-adv-kernelland/translation-table.c b/batman-adv-kernelland/translation-table.c
index 12880d5..21425b0 100644
--- a/batman-adv-kernelland/translation-table.c
+++ b/batman-adv-kernelland/translation-table.c
@@ -161,59 +161,41 @@ int hna_local_fill_buffer(unsigned char *buff, int buff_len)
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
 	unsigned long flags;
-	size_t hdr_len;
 
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
 
+	/* BUG cannot take irqlock and then call function which may sleep */
 	spin_lock_irqsave(&hna_local_hash_lock, flags);
 
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
+		seq_printf(seq, " * " MAC_FMT "\n",
+			   hna_local_entry->addr[0],
+			   hna_local_entry->addr[1],
+			   hna_local_entry->addr[2],
+			   hna_local_entry->addr[3],
+			   hna_local_entry->addr[4],
+			   hna_local_entry->addr[5]);
 	}
 
 	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
-	return bytes_written;
+	return 0;
 }
 
 static void _hna_local_del(void *data)
@@ -379,64 +361,46 @@ void hna_global_add_orig(struct orig_node *orig_node,
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
 	unsigned long flags;
-	size_t hdr_len;
 
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
-			  "Globally announced HNAs received via the mesh %s\n",
-			  net_dev->name);
-
-	if (off < hdr_len)
-		bytes_written = hdr_len;
+	seq_printf(seq, "Globally announced HNAs received via the mesh %s\n",
+		   net_dev->name);
 
+	/* BUG cannot take irqlock and then call function which may sleep */
 	spin_lock_irqsave(&hna_global_hash_lock, flags);
 
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
+		seq_printf(seq, " * " MAC_FMT " via " MAC_FMT "\n",
+			   hna_global_entry->addr[0],
+			   hna_global_entry->addr[1],
+			   hna_global_entry->addr[2],
+			   hna_global_entry->addr[3],
+			   hna_global_entry->addr[4],
+			   hna_global_entry->addr[5],
+			   hna_global_entry->orig_node->orig[0],
+			   hna_global_entry->orig_node->orig[1],
+			   hna_global_entry->orig_node->orig[2],
+			   hna_global_entry->orig_node->orig[3],
+			   hna_global_entry->orig_node->orig[4],
+			   hna_global_entry->orig_node->orig[5]);
 	}
 
 	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
-	return bytes_written;
+	return 0;
 }
 
 void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
diff --git a/batman-adv-kernelland/translation-table.h b/batman-adv-kernelland/translation-table.h
index 8f412fc..8b3429e 100644
--- a/batman-adv-kernelland/translation-table.h
+++ b/batman-adv-kernelland/translation-table.h
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
diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
index 6b719bd..cb811ad 100644
--- a/batman-adv-kernelland/vis.c
+++ b/batman-adv-kernelland/vis.c
@@ -124,52 +124,50 @@ static void vis_data_insert_interface(const uint8_t *interface,
 	hlist_add_head(&entry->list, if_list);
 }
 
-static ssize_t vis_data_read_prim_sec(char *buff, struct hlist_head *if_list)
+static void vis_data_read_prim_sec(struct seq_file *seq,
+				      struct hlist_head *if_list)
 {
 	struct if_list_entry *entry;
 	struct hlist_node *pos;
 	char tmp_addr_str[ETH_STR_LEN];
-	size_t len = 0;
 
 	hlist_for_each_entry(entry, pos, if_list, list) {
 		if (entry->primary)
-			len += sprintf(buff + len, "PRIMARY, ");
+			seq_printf(seq, "PRIMARY, ");
 		else {
 			addr_to_string(tmp_addr_str, entry->addr);
-			len += sprintf(buff + len,  "SEC %s, ", tmp_addr_str);
+			seq_printf(seq, "SEC %s, ", tmp_addr_str);
 		}
 	}
-
-	return len;
 }
 
 /* read an entry  */
-static ssize_t vis_data_read_entry(char *buff, struct vis_info_entry *entry,
-				   uint8_t *src, bool primary)
+static int vis_data_read_entry(struct seq_file *seq,
+						  struct vis_info_entry *entry,
+						  uint8_t *src, bool primary)
 {
 	char to[40];
 
 	addr_to_string(to, entry->dest);
 	if (primary && entry->quality == 0)
-		return sprintf(buff, "HNA %s, ", to);
+		return seq_printf(seq, "HNA %s, ", to);
 	else if (compare_orig(entry->src, src))
-		return sprintf(buff, "TQ %s %d, ", to, entry->quality);
+		return seq_printf(seq, "TQ %s %d, ", to, entry->quality);
 
 	return 0;
 }
 
-ssize_t vis_fill_buffer_text(struct net_device *net_dev, char *buff,
-			      size_t count, loff_t off)
+ssize_t vis_seq_print_text(struct seq_file *seq, void *offset)
 {
 	HASHIT(hashit);
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
@@ -178,18 +176,13 @@ ssize_t vis_fill_buffer_text(struct net_device *net_dev, char *buff,
 	    (vis_server == VIS_TYPE_CLIENT_UPDATE))
 		return 0;
 
-	hdr_len = 0;
-
+	/* BUG cannot take irqlock and then call function which may sleep */
 	spin_lock_irqsave(&vis_hash_lock, flags);
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
@@ -200,30 +193,18 @@ ssize_t vis_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 		hlist_for_each_entry(entry, pos, &vis_if_list, list) {
 			addr_to_string(tmp_addr_str, entry->addr);
-			tmp_len = sprintf(buff + bytes_written,
-					  "%s,", tmp_addr_str);
+			seq_printf(seq, "%s,", tmp_addr_str);
 
 			for (i = 0; i < info->packet.entries; i++)
-				tmp_len += vis_data_read_entry(
-						buff + bytes_written + tmp_len,
-						&entries[i], entry->addr,
-						entry->primary);
+				vis_data_read_entry(seq, &entries[i],
+						    entry->addr,
+						    entry->primary);
 
 			/* add primary/secondary records */
 			if (compare_orig(entry->addr, info->packet.vis_orig))
-				tmp_len += vis_data_read_prim_sec(
-						buff + bytes_written + tmp_len,
-						&vis_if_list);
+				vis_data_read_prim_sec(seq, &vis_if_list);
 
-			tmp_len += sprintf(buff + bytes_written + tmp_len,
-					  "\n");
-
-			hdr_len += tmp_len;
-
-			if (off >= hdr_len)
-				continue;
-
-			bytes_written += tmp_len;
+			seq_printf(seq, "\n");
 		}
 
 		hlist_for_each_entry_safe(entry, pos, n, &vis_if_list, list) {
@@ -233,7 +214,7 @@ ssize_t vis_fill_buffer_text(struct net_device *net_dev, char *buff,
 	}
 	spin_unlock_irqrestore(&vis_hash_lock, flags);
 
-	return bytes_written;
+	return 0;
 }
 
 /* add the info packet to the send list, if it was not
diff --git a/batman-adv-kernelland/vis.h b/batman-adv-kernelland/vis.h
index 9c1fd77..5f5751c 100644
--- a/batman-adv-kernelland/vis.h
+++ b/batman-adv-kernelland/vis.h
@@ -47,8 +47,7 @@ struct recvlist_node {
 extern struct hashtable_t *vis_hash;
 extern spinlock_t vis_hash_lock;
 
-ssize_t vis_fill_buffer_text(struct net_device *net_dev, char *buff,
-			      size_t count, loff_t off);
+ssize_t vis_seq_print_text(struct seq_file *seq, void *offset);
 void receive_server_sync_packet(struct bat_priv *bat_priv,
 				struct vis_packet *vis_packet,
 				int vis_info_len);
-- 
1.7.1

