Return-Path: <andrew.lunn@ascom.ch>
Date: Sat, 18 Jul 2009 16:52:36 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090718145236.GN4656@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv] Cleanup proc.[ch]
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Make proc.[ch] clean with respect to the 2.6.29 checkpatch
script. Exceptions are long lines with printk/seq_print.

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: batman-adv-kernelland/proc.c
===================================================================
--- batman-adv-kernelland/proc.c	(revision 1351)
+++ batman-adv-kernelland/proc.c	(working copy)
@@ -17,282 +17,52 @@
  *
  */
 
-
-
-
-
 #include "main.h"
 #include "proc.h"
 #include "log.h"
 #include "routing.h"
 #include "translation-table.h"
 #include "hard-interface.h"
-#include "vis.h"
 #include "types.h"
 #include "hash.h"
+#include "vis.h"
 
-static uint8_t vis_format = DOT_DRAW;
+uint8_t vis_format = DOT_DRAW;
 
+static struct proc_dir_entry *proc_batman_dir, *proc_interface_file;
+static struct proc_dir_entry *proc_orig_interval_file, *proc_originators_file;
+static struct proc_dir_entry *proc_log_file, *proc_log_level_file;
+static struct proc_dir_entry *proc_transt_local_file;
+static struct proc_dir_entry *proc_transt_global_file;
+static struct proc_dir_entry *proc_vis_file, *proc_vis_format_file;
+static struct proc_dir_entry *proc_aggr_file;
 
-static struct proc_dir_entry *proc_batman_dir = NULL, *proc_interface_file = NULL, *proc_orig_interval_file = NULL, *proc_originators_file = NULL;
-static struct proc_dir_entry *proc_log_file = NULL, *proc_log_level_file = NULL, *proc_transtable_local_file = NULL, *proc_transtable_global_file = NULL;
-static struct proc_dir_entry *proc_vis_file = NULL, *proc_vis_format_file = NULL, *proc_aggr_file = NULL;
-
-static const struct file_operations proc_aggr_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_aggr_open,
-	.read		= seq_read,
-	.write		= proc_aggr_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-static const struct file_operations proc_vis_format_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_vis_format_open,
-	.read		= seq_read,
-	.write		= proc_vis_format_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-static const struct file_operations proc_vis_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_vis_open,
-	.read		= seq_read,
-	.write		= proc_vis_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-static const struct file_operations proc_originators_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_originators_open,
-	.read		= seq_read,
-	.write		= proc_dummy_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-static const struct file_operations proc_transtable_local_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_transtable_local_open,
-	.read		= seq_read,
-	.write		= proc_dummy_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-static const struct file_operations proc_transtable_global_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_transtable_global_open,
-	.read		= seq_read,
-	.write		= proc_dummy_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations proc_log_level_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_log_level_open,
-	.read		= seq_read,
-	.write		= proc_log_level_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations proc_interfaces_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_interfaces_open,
-	.read		= seq_read,
-	.write		= proc_interfaces_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations proc_orig_interval_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_orig_interval_open,
-	.read		= seq_read,
-	.write		= proc_orig_interval_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-
-
-void cleanup_procfs(void)
+static int proc_interfaces_read(struct seq_file *seq, void *offset)
 {
-	if (proc_transtable_global_file)
-		remove_proc_entry(PROC_FILE_TRANSTABLE_GLOBAL, proc_batman_dir);
-
-	if (proc_transtable_local_file)
-		remove_proc_entry(PROC_FILE_TRANSTABLE_LOCAL, proc_batman_dir);
-
-	if (proc_log_file)
-		remove_proc_entry(PROC_FILE_LOG, proc_batman_dir);
-
-	if (proc_log_level_file)
-		remove_proc_entry(PROC_FILE_LOG_LEVEL, proc_batman_dir);
-
-	if (proc_originators_file)
-		remove_proc_entry(PROC_FILE_ORIGINATORS, proc_batman_dir);
-
-	if (proc_orig_interval_file)
-		remove_proc_entry(PROC_FILE_ORIG_INTERVAL, proc_batman_dir);
-
-	if (proc_interface_file)
-		remove_proc_entry(PROC_FILE_INTERFACES, proc_batman_dir);
-
-	if (proc_vis_file)
-		remove_proc_entry(PROC_FILE_VIS, proc_batman_dir);
-
-	if (proc_vis_format_file)
-		remove_proc_entry(PROC_FILE_VIS_FORMAT, proc_batman_dir);
-
-	if (proc_aggr_file)
-		remove_proc_entry(PROC_FILE_AGGR, proc_batman_dir);
-
-	if (proc_batman_dir)
-#ifdef __NET_NET_NAMESPACE_H
-		remove_proc_entry(PROC_ROOT_DIR, init_net.proc_net);
-#else
-		remove_proc_entry(PROC_ROOT_DIR, proc_net);
-#endif
-}
-
-int setup_procfs(void)
-{
-#ifdef __NET_NET_NAMESPACE_H
-	proc_batman_dir = proc_mkdir(PROC_ROOT_DIR, init_net.proc_net);
-#else
-	proc_batman_dir = proc_mkdir(PROC_ROOT_DIR, proc_net);
-#endif
-
-	if (!proc_batman_dir) {
-		printk("batman-adv: Registering the '/proc/net/%s' folder failed\n", PROC_ROOT_DIR);
-		return -EFAULT;
-	}
-
-	proc_interface_file = create_proc_entry(PROC_FILE_INTERFACES, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, proc_batman_dir);
-
-	if (proc_interface_file) {
-		proc_interface_file->proc_fops = &proc_interfaces_fops;
-	} else {
-		printk("batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_INTERFACES);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	proc_orig_interval_file = create_proc_entry(PROC_FILE_ORIG_INTERVAL, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, proc_batman_dir);
-
-	if (proc_orig_interval_file) {
-		proc_orig_interval_file->proc_fops = &proc_orig_interval_fops;
-	} else {
-		printk("batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_ORIG_INTERVAL);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	proc_log_level_file = create_proc_entry(PROC_FILE_LOG_LEVEL, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, proc_batman_dir);
-
-	if (proc_log_level_file) {
-
-		proc_log_level_file->proc_fops = &proc_log_level_fops;
-	} else {
-		printk("batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_LOG_LEVEL);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-
-	proc_originators_file = create_proc_entry(PROC_FILE_ORIGINATORS, S_IRUSR | S_IRGRP | S_IROTH, proc_batman_dir);
-
-	if (proc_originators_file) {
-		proc_originators_file->proc_fops = &proc_originators_fops;
-	} else {
-		printk("batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_ORIGINATORS);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	proc_log_file = create_proc_entry(PROC_FILE_LOG, S_IRUSR | S_IRGRP | S_IROTH, proc_batman_dir);
-	if (proc_log_file) {
-		proc_log_file->proc_fops = &proc_log_operations;
-	} else {
-		printk("batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_FILE_LOG, PROC_FILE_GATEWAYS);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	proc_transtable_local_file = create_proc_entry(PROC_FILE_TRANSTABLE_LOCAL, S_IRUSR | S_IRGRP | S_IROTH, proc_batman_dir);
-
-	if (proc_transtable_local_file) {
-		proc_transtable_local_file->proc_fops = &proc_transtable_local_fops;
-	} else {
-		printk("batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_TRANSTABLE_LOCAL);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	proc_transtable_global_file = create_proc_entry(PROC_FILE_TRANSTABLE_GLOBAL, S_IRUSR | S_IRGRP | S_IROTH, proc_batman_dir);
-
-	if (proc_transtable_global_file) {
-		proc_transtable_global_file->proc_fops = &proc_transtable_global_fops;
-	} else {
-		printk("batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_TRANSTABLE_GLOBAL);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	proc_vis_file = create_proc_entry(PROC_FILE_VIS, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, proc_batman_dir);
-
-	if (proc_vis_file) {
-		proc_vis_file->proc_fops = &proc_vis_fops;
-	} else {
-		printk("batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_VIS);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	proc_vis_format_file = create_proc_entry(PROC_FILE_VIS_FORMAT, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, proc_batman_dir);
-
-	if (proc_vis_format_file) {
-		proc_vis_format_file->proc_fops = &proc_vis_format_fops;
-	} else {
-		printk("batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_VIS_FORMAT);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	proc_aggr_file = create_proc_entry(PROC_FILE_AGGR, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, proc_batman_dir);
-
-	if (proc_aggr_file) {
-		proc_aggr_file->proc_fops = &proc_aggr_fops;
-	} else {
-		printk("batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_AGGR);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
-	return 0;
-}
-
-int proc_interfaces_read(struct seq_file *seq, void *offset)
-{
 	struct batman_if *batman_if;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		seq_printf(seq, "[%8s] %s %s \n", (batman_if->if_active == IF_ACTIVE ? "active" : "inactive"),
-			batman_if->dev, (batman_if->if_active == IF_ACTIVE ? batman_if->addr_str : " "));
+		seq_printf(seq, "[%8s] %s %s \n",
+			   (batman_if->if_active == IF_ACTIVE ?
+			    "active" : "inactive"),
+			   batman_if->dev,
+			   (batman_if->if_active == IF_ACTIVE ?
+			    batman_if->addr_str : " "));
 	}
 	rcu_read_unlock();
 
 	return 0;
 }
 
-int proc_interfaces_open(struct inode *inode, struct file *file)
+static int proc_interfaces_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, proc_interfaces_read, NULL);
 }
 
-ssize_t proc_interfaces_write(struct file *instance, const char __user *userbuffer, size_t count, loff_t *data)
+static ssize_t proc_interfaces_write(struct file *instance,
+				     const char __user *userbuffer,
+				     size_t count, loff_t *data)
 {
 	char *if_string, *colon_ptr = NULL, *cr_ptr = NULL;
 	int not_copied = 0, if_num = 0;
@@ -304,20 +74,22 @@
 		return -ENOMEM;
 
 	if (count > IFNAMSIZ - 1) {
-		debug_log(LOG_TYPE_WARN, "Can't add interface: device name is too long\n");
+		debug_log(LOG_TYPE_WARN,
+			  "Can't add interface: device name is too long\n");
 		goto end;
 	}
 
 	not_copied = copy_from_user(if_string, userbuffer, count);
 	if_string[count - not_copied - 1] = 0;
-
-	if ((colon_ptr = strchr(if_string, ':')) != NULL)
+	colon_ptr = strchr(if_string, ':');
+	if (colon_ptr != NULL)
 		*colon_ptr = 0;
-	else if ((cr_ptr = strchr(if_string, '\n')) != NULL)
-		*cr_ptr = 0;
-
+	else {
+		cr_ptr = strchr(if_string, '\n');
+		if (cr_ptr != NULL)
+			*cr_ptr = 0;
+	}
 	if (strlen(if_string) == 0) {
-
 		shutdown_module();
 
 		spin_lock(&orig_hash_lock);
@@ -327,13 +99,10 @@
 
 		num_ifs = 0;
 		goto end;
-
 	} else {
-
 		/* add interface */
 		rcu_read_lock();
 		list_for_each_entry_rcu(batman_if, &if_list, list) {
-
 			if (strncmp(batman_if->dev, if_string, count) == 0) {
 				debug_log(LOG_TYPE_WARN, "Given interface is already active: %s\n", if_string);
 				rcu_read_unlock();
@@ -374,18 +143,21 @@
 	return count;
 }
 
-int proc_orig_interval_read(struct seq_file *seq, void *offset)
+static int proc_orig_interval_read(struct seq_file *seq, void *offset)
 {
 	seq_printf(seq, "%i\n", atomic_read(&originator_interval));
 
 	return 0;
 }
 
-ssize_t proc_orig_interval_write(struct file *file, const char __user * buffer, size_t count, loff_t * ppos)
+static ssize_t proc_orig_interval_write(struct file *file,
+					const char __user *buffer,
+					size_t count, loff_t *ppos)
 {
 	char *interval_string;
 	int not_copied = 0;
-	int16_t originator_interval_tmp;
+	long originator_interval_tmp;
+	int retval;
 
 	interval_string = kmalloc(count, GFP_KERNEL);
 
@@ -395,14 +167,22 @@
 	not_copied = copy_from_user(interval_string, buffer, count);
 	interval_string[count - not_copied - 1] = 0;
 
-	originator_interval_tmp = simple_strtol(interval_string, NULL, 10);
+	retval = strict_strtol(interval_string, 10, &originator_interval_tmp);
+	if (retval) {
+		debug_log(LOG_TYPE_WARN, "New originator interval invalid\n");
+		goto end;
+	}
 
 	if (originator_interval_tmp <= JITTER * 2) {
-		debug_log(LOG_TYPE_WARN, "New originator interval too small: %i (min: %i)\n", originator_interval_tmp, JITTER * 2);
+		debug_log(LOG_TYPE_WARN,
+			  "New originator interval too small: %i (min: %i)\n",
+			  originator_interval_tmp, JITTER * 2);
 		goto end;
 	}
 
-	debug_log(LOG_TYPE_NOTICE, "Changing originator interval from: %i to: %i\n", atomic_read(&originator_interval), originator_interval_tmp);
+	debug_log(LOG_TYPE_NOTICE,
+		  "Changing originator interval from: %i to: %i\n",
+		  atomic_read(&originator_interval), originator_interval_tmp);
 
 	atomic_set(&originator_interval, originator_interval_tmp);
 
@@ -411,12 +191,12 @@
 	return count;
 }
 
-int proc_orig_interval_open(struct inode *inode, struct file *file)
+static int proc_orig_interval_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, proc_orig_interval_read, NULL);
 }
 
-int proc_originators_read(struct seq_file *seq, void *offset)
+static int proc_originators_read(struct seq_file *seq, void *offset)
 {
 	struct hash_it_t *hashit = NULL;
 	struct orig_node *orig_node;
@@ -437,12 +217,18 @@
 		goto end;
 	}
 
-	seq_printf(seq, "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s] \n", "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF", "Potential nexthops", SOURCE_VERSION, (strlen(REVISION_VERSION) > 3 ? REVISION_VERSION : ""), ((struct batman_if *)if_list.next)->dev, ((struct batman_if *)if_list.next)->addr_str);
+	seq_printf(seq,
+		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s] \n",
+		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
+		   "Potential nexthops", SOURCE_VERSION,
+		   (strlen(REVISION_VERSION) > 3 ? REVISION_VERSION : ""),
+		   ((struct batman_if *)if_list.next)->dev,
+		   ((struct batman_if *)if_list.next)->addr_str);
 
 	rcu_read_unlock();
 	spin_lock(&orig_hash_lock);
 
-	while (NULL != (hashit = hash_iterate( orig_hash, hashit))) {
+	while (NULL != (hashit = hash_iterate(orig_hash, hashit))) {
 
 		orig_node = hashit->bucket->data;
 
@@ -457,11 +243,14 @@
 		addr_to_string(orig_str, orig_node->orig);
 		addr_to_string(router_str, orig_node->router->addr);
 
-		seq_printf(seq, "%-17s  (%3i) %17s [%10s]:", orig_str, orig_node->router->tq_avg, router_str, orig_node->router->if_incoming->dev);
+		seq_printf(seq, "%-17s  (%3i) %17s [%10s]:",
+			   orig_str, orig_node->router->tq_avg,
+			   router_str, orig_node->router->if_incoming->dev);
 
 		list_for_each_entry(neigh_node, &orig_node->neigh_list, list) {
 			addr_to_string(orig_str, neigh_node->addr);
-			seq_printf(seq, " %17s (%3i)", orig_str, neigh_node->tq_avg);
+			seq_printf(seq, " %17s (%3i)",
+				   orig_str, neigh_node->tq_avg);
 		}
 
 		seq_printf(seq, "\n");
@@ -477,29 +266,38 @@
 	return 0;
 }
 
-int proc_originators_open(struct inode *inode, struct file *file)
+static int proc_originators_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, proc_originators_read, NULL);
 }
 
-int proc_log_level_read(struct seq_file *seq, void *offset)
+static int proc_log_level_read(struct seq_file *seq, void *offset)
 {
 
 	seq_printf(seq, "[x] %s (%d)\n", LOG_TYPE_CRIT_NAME, LOG_TYPE_CRIT);
-	seq_printf(seq, "[%c] %s (%d)\n", (LOG_TYPE_WARN & log_level) ? 'x' : ' ', LOG_TYPE_WARN_NAME, LOG_TYPE_WARN);
-	seq_printf(seq, "[%c] %s (%d)\n", (LOG_TYPE_NOTICE & log_level) ? 'x' : ' ', LOG_TYPE_NOTICE_NAME, LOG_TYPE_NOTICE);
-	seq_printf(seq, "[%c] %s (%d)\n", (LOG_TYPE_BATMAN & log_level) ? 'x' : ' ', LOG_TYPE_BATMAN_NAME, LOG_TYPE_BATMAN);
-	seq_printf(seq, "[%c] %s (%d)\n", (LOG_TYPE_ROUTES & log_level) ? 'x' : ' ', LOG_TYPE_ROUTES_NAME, LOG_TYPE_ROUTES);
-
+	seq_printf(seq, "[%c] %s (%d)\n",
+		   (LOG_TYPE_WARN & log_level) ? 'x' : ' ',
+		   LOG_TYPE_WARN_NAME, LOG_TYPE_WARN);
+	seq_printf(seq, "[%c] %s (%d)\n",
+		   (LOG_TYPE_NOTICE & log_level) ? 'x' : ' ',
+		   LOG_TYPE_NOTICE_NAME, LOG_TYPE_NOTICE);
+	seq_printf(seq, "[%c] %s (%d)\n",
+		   (LOG_TYPE_BATMAN & log_level) ? 'x' : ' ',
+		   LOG_TYPE_BATMAN_NAME, LOG_TYPE_BATMAN);
+	seq_printf(seq, "[%c] %s (%d)\n",
+		   (LOG_TYPE_ROUTES & log_level) ? 'x' : ' ',
+		   LOG_TYPE_ROUTES_NAME, LOG_TYPE_ROUTES);
 	return 0;
 }
 
-int proc_log_level_open(struct inode *inode, struct file *file)
+static int proc_log_level_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, proc_log_level_read, NULL);
 }
 
-ssize_t proc_log_level_write(struct file *instance, const char __user *userbuffer, size_t count, loff_t *data)
+static ssize_t proc_log_level_write(struct file *instance,
+				    const char __user *userbuffer,
+				    size_t count, loff_t *data)
 {
 	char *log_level_string, *tokptr, *cp;
 	int finished, not_copied = 0;
@@ -545,14 +343,15 @@
 		}
 	}
 
-	debug_log(LOG_TYPE_CRIT, "Changing log_level from: %i to: %i\n", log_level, log_level_tmp);
+	debug_log(LOG_TYPE_CRIT, "Changing log_level from: %i to: %i\n",
+		  log_level, log_level_tmp);
 	log_level = log_level_tmp;
 
 	kfree(log_level_string);
 	return count;
 }
 
-int proc_transtable_local_read(struct seq_file *seq, void *offset)
+static int proc_transt_local_read(struct seq_file *seq, void *offset)
 {
 	char *buf;
 
@@ -579,12 +378,12 @@
 	return 0;
 }
 
-int proc_transtable_local_open(struct inode *inode, struct file *file)
+static int proc_transt_local_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, proc_transtable_local_read, NULL);
+	return single_open(file, proc_transt_local_read, NULL);
 }
 
-int proc_transtable_global_read(struct seq_file *seq, void *offset)
+static int proc_transt_global_read(struct seq_file *seq, void *offset)
 {
 	char *buf;
 
@@ -611,63 +410,80 @@
 	return 0;
 }
 
-int proc_transtable_global_open(struct inode *inode, struct file *file)
+static int proc_transt_global_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, proc_transtable_global_read, NULL);
+	return single_open(file, proc_transt_global_read, NULL);
 }
 
-int proc_vis_read(struct seq_file *seq, void *offset)
+static void proc_vis_read_entry(struct seq_file *seq,
+				struct vis_info_entry *entry,
+				char *from,
+				uint8_t current_format,
+				uint8_t first_line)
 {
+	char to[40];
+
+	addr_to_string(to, entry->dest);
+	if (entry->quality == 0) {
+		if (current_format == DOT_DRAW) {
+			seq_printf(seq, "\t\"%s\" -> \"%s\" [label=\"HNA\"]\n",
+				   from, to);
+		} else {
+			seq_printf(seq,
+				   "%s\t{ router : \"%s\", gateway   : \"%s\", label : \"HNA\" }",
+				   (first_line ? "" : ",\n"), from, to);
+		}
+	} else {
+		/* kernel has no printf-support for %f? it'd be better to return
+		 * this in float. */
+		if (current_format == DOT_DRAW) {
+			seq_printf(seq,
+				   "\t\"%s\" -> \"%s\" [label=\"%d\"]\n",
+				   from, to, entry->quality);
+		} else {
+			seq_printf(seq,
+				   "%s\t{ router : \"%s\", neighbour : \"%s\", label : %d }",
+				   (first_line ? "" : ",\n"), from, to,
+				   entry->quality);
+		}
+	}
+}
+
+static int proc_vis_read(struct seq_file *seq, void *offset)
+{
 	struct hash_it_t *hashit = NULL;
 	struct vis_info *info;
 	struct vis_info_entry *entries;
-	char from[40], to[40];
-	int i, int_part, frac_part;
+	char from[40];
+	int i;
 	uint8_t current_format, first_line = 1;
 
-
 	current_format = vis_format;
 
 	rcu_read_lock();
 	if (list_empty(&if_list) || (!is_vis_server())) {
 		rcu_read_unlock();
 		if (current_format == DOT_DRAW)
-			seq_printf(seq, "digraph {\n}\n" );
+			seq_printf(seq, "digraph {\n}\n");
 		goto end;
 	}
 
 	rcu_read_unlock();
 
 	if (current_format == DOT_DRAW)
-		seq_printf(seq, "digraph {\n" );
+		seq_printf(seq, "digraph {\n");
 
 	spin_lock(&vis_hash_lock);
 	while (NULL != (hashit = hash_iterate(vis_hash, hashit))) {
 		info = hashit->bucket->data;
-		entries = (struct vis_info_entry *)((char *)info + sizeof(struct vis_info));
+		entries = (struct vis_info_entry *)
+			((char *)info + sizeof(struct vis_info));
 		addr_to_string(from, info->packet.vis_orig);
 		for (i = 0; i < info->packet.entries; i++) {
-			addr_to_string(to, entries[i].dest);
-			if (entries[i].quality == 0) {
-				if (current_format == DOT_DRAW) {
-					seq_printf(seq, "\t\"%s\" -> \"%s\" [label=\"HNA\"]\n", from, to);
-				} else {
-					seq_printf(seq, "%s\t{ router : \"%s\", gateway   : \"%s\", label : \"HNA\" }",
-					           (first_line ? "" : ",\n"), from, to);
-					first_line = 0;
-				}
-			} else {
-				/* kernel has no printf-support for %f? it'd be better to return this in float. */
-				int_part = 255/entries[i].quality;
-				frac_part = 1000 * 255/entries[i].quality - int_part * 1000;
-				if (current_format == DOT_DRAW) {
-					seq_printf(seq, "\t\"%s\" -> \"%s\" [label=\"%d.%d\"]\n", from, to, int_part, frac_part);
-				} else {
-					seq_printf(seq, "%s\t{ router : \"%s\", neighbour : \"%s\", label : %d.%d }",
-					           (first_line ? "" : ",\n"), from, to, int_part, frac_part);
-					first_line = 0;
-				}
-			}
+			proc_vis_read_entry(seq, &entries[i], from,
+					    current_format, first_line);
+			if (first_line)
+				first_line = 0;
 		}
 	}
 
@@ -681,7 +497,8 @@
 }
 
 /* setting the mode of the vis server by the user */
-ssize_t proc_vis_write(struct file *file, const char __user * buffer, size_t count, loff_t * ppos)
+static ssize_t proc_vis_write(struct file *file, const char __user * buffer,
+			      size_t count, loff_t *ppos)
 {
 	char *vis_mode_string;
 	int not_copied = 0;
@@ -701,33 +518,39 @@
 		debug_log(LOG_TYPE_NOTICE, "Setting VIS mode to server\n");
 		vis_set_mode(VIS_TYPE_SERVER_SYNC);
 	} else
-		debug_log(LOG_TYPE_WARN, "Unknown VIS mode: %s\n", vis_mode_string);
+		debug_log(LOG_TYPE_WARN, "Unknown VIS mode: %s\n",
+			  vis_mode_string);
 
 	kfree(vis_mode_string);
 	return count;
 }
 
-int proc_vis_open(struct inode *inode, struct file *file)
+static int proc_vis_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, proc_vis_read, NULL);
 }
 
-int proc_vis_format_read(struct seq_file *seq, void *offset)
+static int proc_vis_format_read(struct seq_file *seq, void *offset)
 {
 	uint8_t current_format = vis_format;
 
-	seq_printf(seq, "[%c] %s\n", (current_format == DOT_DRAW) ? 'x' : ' ', VIS_FORMAT_DD_NAME);
-	seq_printf(seq, "[%c] %s\n", (current_format == JSON) ? 'x' : ' ', VIS_FORMAT_JSON_NAME);
-
+	seq_printf(seq, "[%c] %s\n",
+		   (current_format == DOT_DRAW) ? 'x' : ' ',
+		   VIS_FORMAT_DD_NAME);
+	seq_printf(seq, "[%c] %s\n",
+		   (current_format == JSON) ? 'x' : ' ',
+		   VIS_FORMAT_JSON_NAME);
 	return 0;
 }
 
-int proc_vis_format_open(struct inode *inode, struct file *file)
+static int proc_vis_format_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, proc_vis_format_read, NULL);
 }
 
-ssize_t proc_vis_format_write(struct file *file, const char __user * buffer, size_t count, loff_t * ppos)
+static ssize_t proc_vis_format_write(struct file *file,
+				     const char __user *buffer,
+				     size_t count, loff_t *ppos)
 {
 	char *vis_format_string;
 	int not_copied = 0;
@@ -741,26 +564,30 @@
 	vis_format_string[count - not_copied - 1] = 0;
 
 	if (strcmp(vis_format_string, VIS_FORMAT_DD_NAME) == 0) {
-		debug_log(LOG_TYPE_NOTICE, "Setting VIS output format to: %s\n", VIS_FORMAT_DD_NAME);
+		debug_log(LOG_TYPE_NOTICE, "Setting VIS output format to: %s\n",
+			  VIS_FORMAT_DD_NAME);
 		vis_format = DOT_DRAW;
 	} else if (strcmp(vis_format_string, VIS_FORMAT_JSON_NAME) == 0) {
-		debug_log(LOG_TYPE_NOTICE, "Setting VIS output format to: %s\n", VIS_FORMAT_JSON_NAME);
+		debug_log(LOG_TYPE_NOTICE, "Setting VIS output format to: %s\n",
+			  VIS_FORMAT_JSON_NAME);
 		vis_format = JSON;
 	} else
-		debug_log(LOG_TYPE_WARN, "Unknown VIS output format: %s\n", vis_format_string);
+		debug_log(LOG_TYPE_WARN, "Unknown VIS output format: %s\n",
+			  vis_format_string);
 
 	kfree(vis_format_string);
 	return count;
 }
 
-int proc_aggr_read(struct seq_file *seq, void *offset)
+static int proc_aggr_read(struct seq_file *seq, void *offset)
 {
 	seq_printf(seq, "%i\n", atomic_read(&aggregation_enabled));
 
 	return 0;
 }
 
-ssize_t proc_aggr_write(struct file *file, const char __user * buffer, size_t count, loff_t * ppos)
+static ssize_t proc_aggr_write(struct file *file, const char __user *buffer,
+			       size_t count, loff_t *ppos)
 {
 	char *aggr_string;
 	int not_copied = 0;
@@ -781,23 +608,280 @@
 		goto end;
 	}
 
-	debug_log(LOG_TYPE_NOTICE, "Changing aggregation from: %s (%i) to: %s (%i)\n", (atomic_read(&aggregation_enabled) == 1 ? "enabled" : "disabled"), atomic_read(&aggregation_enabled), (aggregation_enabled_tmp == 1 ? "enabled" : "disabled"), aggregation_enabled_tmp);
+	debug_log(LOG_TYPE_NOTICE, "Changing aggregation from: %s (%i) to: %s (%i)\n",
+		  (atomic_read(&aggregation_enabled) == 1 ?
+		   "enabled" : "disabled"),
+		  atomic_read(&aggregation_enabled),
+		  (aggregation_enabled_tmp == 1 ? "enabled" : "disabled"),
+		  aggregation_enabled_tmp);
 
 	atomic_set(&aggregation_enabled, aggregation_enabled_tmp);
-
 end:
 	kfree(aggr_string);
 	return count;
 }
 
-int proc_aggr_open(struct inode *inode, struct file *file)
+static int proc_aggr_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, proc_aggr_read, NULL);
 }
 
 /* satisfying different prototypes ... */
-ssize_t proc_dummy_write(struct file *file, const char __user * buffer, size_t count, loff_t * ppos)
+static ssize_t proc_dummy_write(struct file *file, const char __user *buffer,
+				size_t count, loff_t *ppos)
 {
 	return count;
 }
 
+static const struct file_operations proc_aggr_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_aggr_open,
+	.read		= seq_read,
+	.write		= proc_aggr_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static const struct file_operations proc_vis_format_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_vis_format_open,
+	.read		= seq_read,
+	.write		= proc_vis_format_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static const struct file_operations proc_vis_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_vis_open,
+	.read		= seq_read,
+	.write		= proc_vis_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static const struct file_operations proc_originators_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_originators_open,
+	.read		= seq_read,
+	.write		= proc_dummy_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static const struct file_operations proc_transt_local_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_transt_local_open,
+	.read		= seq_read,
+	.write		= proc_dummy_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static const struct file_operations proc_transt_global_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_transt_global_open,
+	.read		= seq_read,
+	.write		= proc_dummy_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static const struct file_operations proc_log_level_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_log_level_open,
+	.read		= seq_read,
+	.write		= proc_log_level_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static const struct file_operations proc_interfaces_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_interfaces_open,
+	.read		= seq_read,
+	.write		= proc_interfaces_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static const struct file_operations proc_orig_interval_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_orig_interval_open,
+	.read		= seq_read,
+	.write		= proc_orig_interval_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+void cleanup_procfs(void)
+{
+	if (proc_transt_global_file)
+		remove_proc_entry(PROC_FILE_TRANST_GLOBAL, proc_batman_dir);
+
+	if (proc_transt_local_file)
+		remove_proc_entry(PROC_FILE_TRANST_LOCAL, proc_batman_dir);
+
+	if (proc_log_file)
+		remove_proc_entry(PROC_FILE_LOG, proc_batman_dir);
+
+	if (proc_log_level_file)
+		remove_proc_entry(PROC_FILE_LOG_LEVEL, proc_batman_dir);
+
+	if (proc_originators_file)
+		remove_proc_entry(PROC_FILE_ORIGINATORS, proc_batman_dir);
+
+	if (proc_orig_interval_file)
+		remove_proc_entry(PROC_FILE_ORIG_INTERVAL, proc_batman_dir);
+
+	if (proc_interface_file)
+		remove_proc_entry(PROC_FILE_INTERFACES, proc_batman_dir);
+
+	if (proc_vis_file)
+		remove_proc_entry(PROC_FILE_VIS, proc_batman_dir);
+
+	if (proc_vis_format_file)
+		remove_proc_entry(PROC_FILE_VIS_FORMAT, proc_batman_dir);
+
+	if (proc_aggr_file)
+		remove_proc_entry(PROC_FILE_AGGR, proc_batman_dir);
+
+	if (proc_batman_dir)
+#ifdef __NET_NET_NAMESPACE_H
+		remove_proc_entry(PROC_ROOT_DIR, init_net.proc_net);
+#else
+		remove_proc_entry(PROC_ROOT_DIR, proc_net);
+#endif
+}
+
+int setup_procfs(void)
+{
+#ifdef __NET_NET_NAMESPACE_H
+	proc_batman_dir = proc_mkdir(PROC_ROOT_DIR, init_net.proc_net);
+#else
+	proc_batman_dir = proc_mkdir(PROC_ROOT_DIR, proc_net);
+#endif
+
+	if (!proc_batman_dir) {
+		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s' folder failed\n", PROC_ROOT_DIR);
+		return -EFAULT;
+	}
+
+	proc_interface_file = create_proc_entry(PROC_FILE_INTERFACES,
+						S_IWUSR | S_IRUGO,
+						proc_batman_dir);
+
+	if (proc_interface_file) {
+		proc_interface_file->proc_fops = &proc_interfaces_fops;
+	} else {
+		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_INTERFACES);
+		cleanup_procfs();
+		return -EFAULT;
+	}
+
+	proc_orig_interval_file = create_proc_entry(PROC_FILE_ORIG_INTERVAL,
+						    S_IWUSR | S_IRUGO,
+						    proc_batman_dir);
+
+	if (proc_orig_interval_file) {
+		proc_orig_interval_file->proc_fops = &proc_orig_interval_fops;
+	} else {
+		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_ORIG_INTERVAL);
+		cleanup_procfs();
+		return -EFAULT;
+	}
+
+	proc_log_level_file = create_proc_entry(PROC_FILE_LOG_LEVEL,
+						S_IWUSR | S_IRUGO,
+						proc_batman_dir);
+
+	if (proc_log_level_file) {
+
+		proc_log_level_file->proc_fops = &proc_log_level_fops;
+	} else {
+		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_LOG_LEVEL);
+		cleanup_procfs();
+		return -EFAULT;
+	}
+
+	proc_originators_file = create_proc_entry(PROC_FILE_ORIGINATORS,
+						  S_IRUGO, proc_batman_dir);
+
+	if (proc_originators_file) {
+		proc_originators_file->proc_fops = &proc_originators_fops;
+	} else {
+		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_ORIGINATORS);
+		cleanup_procfs();
+		return -EFAULT;
+	}
+
+	proc_log_file = create_proc_entry(PROC_FILE_LOG,
+					  S_IRUGO, proc_batman_dir);
+	if (proc_log_file) {
+		proc_log_file->proc_fops = &proc_log_operations;
+	} else {
+		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_FILE_LOG, PROC_FILE_GATEWAYS);
+		cleanup_procfs();
+		return -EFAULT;
+	}
+
+	proc_transt_local_file = create_proc_entry(PROC_FILE_TRANST_LOCAL,
+						   S_IRUGO, proc_batman_dir);
+
+	if (proc_transt_local_file) {
+		proc_transt_local_file->proc_fops = &proc_transt_local_fops;
+	} else {
+		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_TRANST_LOCAL);
+		cleanup_procfs();
+		return -EFAULT;
+	}
+
+	proc_transt_global_file = create_proc_entry(PROC_FILE_TRANST_GLOBAL,
+						    S_IRUGO, proc_batman_dir);
+
+	if (proc_transt_global_file) {
+		proc_transt_global_file->proc_fops = &proc_transt_global_fops;
+	} else {
+		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_TRANST_GLOBAL);
+		cleanup_procfs();
+		return -EFAULT;
+	}
+
+	proc_vis_file = create_proc_entry(PROC_FILE_VIS, S_IWUSR | S_IRUGO,
+					  proc_batman_dir);
+
+	if (proc_vis_file) {
+		proc_vis_file->proc_fops = &proc_vis_fops;
+	} else {
+		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_VIS);
+		cleanup_procfs();
+		return -EFAULT;
+	}
+
+	proc_vis_format_file = create_proc_entry(PROC_FILE_VIS_FORMAT,
+						 S_IWUSR | S_IRUGO,
+						 proc_batman_dir);
+
+	if (proc_vis_format_file) {
+		proc_vis_format_file->proc_fops = &proc_vis_format_fops;
+	} else {
+		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_VIS_FORMAT);
+		cleanup_procfs();
+		return -EFAULT;
+	}
+
+	proc_aggr_file = create_proc_entry(PROC_FILE_AGGR, S_IWUSR | S_IRUGO,
+					   proc_batman_dir);
+
+	if (proc_aggr_file) {
+		proc_aggr_file->proc_fops = &proc_aggr_fops;
+	} else {
+		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_AGGR);
+		cleanup_procfs();
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+
Index: batman-adv-kernelland/proc.h
===================================================================
--- batman-adv-kernelland/proc.h	(revision 1351)
+++ batman-adv-kernelland/proc.h	(working copy)
@@ -17,10 +17,6 @@
  *
  */
 
-
-
-
-
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
@@ -31,37 +27,11 @@
 #define PROC_FILE_GATEWAYS "gateways"
 #define PROC_FILE_LOG "log"
 #define PROC_FILE_LOG_LEVEL "log_level"
-#define PROC_FILE_TRANSTABLE_LOCAL "transtable_local"
-#define PROC_FILE_TRANSTABLE_GLOBAL "transtable_global"
+#define PROC_FILE_TRANST_LOCAL "transtable_local"
+#define PROC_FILE_TRANST_GLOBAL "transtable_global"
 #define PROC_FILE_VIS "vis"
 #define PROC_FILE_VIS_FORMAT "vis_format"
 #define PROC_FILE_AGGR "aggregate_ogm"
 
-
-
 void cleanup_procfs(void);
 int setup_procfs(void);
-int proc_interfaces_open(struct inode *inode, struct file *file);
-int proc_interfaces_read(struct seq_file *seq, void *offset);
-ssize_t proc_interfaces_write(struct file *instance, const char __user *userbuffer, size_t count, loff_t *data);
-int proc_orig_interval_open(struct inode *inode, struct file *file);
-int proc_orig_interval_read(struct seq_file *seq, void *offset);
-ssize_t proc_orig_interval_write(struct file *file, const char __user * buffer, size_t count, loff_t * ppos);
-int proc_originators_open(struct inode *inode, struct file *file);
-int proc_originators_read(struct seq_file *seq, void *offset);
-int proc_log_level_open(struct inode *inode, struct file *file);
-int proc_log_level_read(struct seq_file *seq, void *offset);
-ssize_t proc_log_level_write(struct file *instance, const char __user *userbuffer, size_t count, loff_t *data);
-int proc_transtable_local_open(struct inode *inode, struct file *file);
-int proc_transtable_local_read(struct seq_file *seq, void *offset);
-int proc_transtable_global_open(struct inode *inode, struct file *file);
-int proc_transtable_global_read(struct seq_file *seq, void *offset);
-int proc_vis_open(struct inode *inode, struct file *file);
-int proc_vis_read(struct seq_file *seq, void *offset);
-int proc_vis_format_open(struct inode *inode, struct file *file);
-int proc_aggr_open(struct inode *inode, struct file *file);
-int proc_aggr_read(struct seq_file *seq, void *offset);
-ssize_t proc_vis_write(struct file *file, const char __user * buffer, size_t count, loff_t * ppos);
-ssize_t proc_vis_format_write(struct file *file, const char __user * buffer, size_t count, loff_t * ppos);
-ssize_t proc_aggr_write(struct file *file, const char __user * buffer, size_t count, loff_t * ppos);
-ssize_t proc_dummy_write(struct file *file, const char __user * buffer, size_t count, loff_t * ppos);

