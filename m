Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 20 Dec 2009 01:11:05 +0800
Message-Id: <1261242667-11525-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1261242667-11525-2-git-send-email-lindner_marek@yahoo.de>
References: <200912200101.55746.lindner_marek@yahoo.de>
	<1261242667-11525-1-git-send-email-lindner_marek@yahoo.de>
	<1261242667-11525-2-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: remove obsoleted vis_format
	/proc file
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
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

batman-adv used to export the vis data using different formats that were
switchable via /proc/net/batman-adv/vis_format. The various formats moved
to user space and rendered this configuration switch useless.

Signed-off-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batman-adv-kernelland/proc.c |   79 +-----------------------------------------
 batman-adv-kernelland/vis.h  |    5 ---
 2 files changed, 1 insertions(+), 83 deletions(-)

diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
index 60eec83..d98f86a 100644
--- a/batman-adv-kernelland/proc.c
+++ b/batman-adv-kernelland/proc.c
@@ -29,13 +29,11 @@
 #include "vis.h"
 #include "compat.h"
 
-static uint8_t vis_format = DOT_DRAW;
-
 static struct proc_dir_entry *proc_batman_dir, *proc_interface_file;
 static struct proc_dir_entry *proc_orig_interval_file, *proc_originators_file;
 static struct proc_dir_entry *proc_transt_local_file;
 static struct proc_dir_entry *proc_transt_global_file;
-static struct proc_dir_entry *proc_vis_file, *proc_vis_format_file;
+static struct proc_dir_entry *proc_vis_file;
 static struct proc_dir_entry *proc_aggr_file;
 
 static int proc_interfaces_read(struct seq_file *seq, void *offset)
@@ -401,11 +399,8 @@ static int proc_vis_read(struct seq_file *seq, void *offset)
 	struct vis_info_entry *entries;
 	HLIST_HEAD(vis_if_list);
 	int i;
-	uint8_t current_format;
 	char tmp_addr_str[ETH_STR_LEN];
 
-	current_format = vis_format;
-
 	rcu_read_lock();
 	if (list_empty(&if_list) || (!is_vis_server())) {
 		rcu_read_unlock();
@@ -471,55 +466,6 @@ static int proc_vis_open(struct inode *inode, struct file *file)
 	return single_open(file, proc_vis_read, NULL);
 }
 
-static int proc_vis_format_read(struct seq_file *seq, void *offset)
-{
-	uint8_t current_format = vis_format;
-
-	seq_printf(seq, "[%c] %s\n",
-		   (current_format == DOT_DRAW) ? 'x' : ' ',
-		   VIS_FORMAT_DD_NAME);
-	seq_printf(seq, "[%c] %s\n",
-		   (current_format == JSON) ? 'x' : ' ',
-		   VIS_FORMAT_JSON_NAME);
-	return 0;
-}
-
-static int proc_vis_format_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_vis_format_read, NULL);
-}
-
-static ssize_t proc_vis_format_write(struct file *file,
-				     const char __user *buffer,
-				     size_t count, loff_t *ppos)
-{
-	char *vis_format_string;
-	int not_copied = 0;
-
-	vis_format_string = kmalloc(count, GFP_KERNEL);
-
-	if (!vis_format_string)
-		return -ENOMEM;
-
-	not_copied = copy_from_user(vis_format_string, buffer, count);
-	vis_format_string[count - not_copied - 1] = 0;
-
-	if (strcmp(vis_format_string, VIS_FORMAT_DD_NAME) == 0) {
-		printk(KERN_INFO "batman-adv:Setting VIS output format to: %s\n",
-		       VIS_FORMAT_DD_NAME);
-		vis_format = DOT_DRAW;
-	} else if (strcmp(vis_format_string, VIS_FORMAT_JSON_NAME) == 0) {
-		printk(KERN_INFO "batman-adv:Setting VIS output format to: %s\n",
-		       VIS_FORMAT_JSON_NAME);
-		vis_format = JSON;
-	} else
-		printk(KERN_ERR "batman-adv:Unknown VIS output format: %s\n",
-		       vis_format_string);
-
-	kfree(vis_format_string);
-	return count;
-}
-
 static int proc_aggr_read(struct seq_file *seq, void *offset)
 {
 	seq_printf(seq, "%i\n", atomic_read(&aggregation_enabled));
@@ -583,15 +529,6 @@ static const struct file_operations proc_aggr_fops = {
 	.release	= single_release,
 };
 
-static const struct file_operations proc_vis_format_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_vis_format_open,
-	.read		= seq_read,
-	.write		= proc_vis_format_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static const struct file_operations proc_vis_fops = {
 	.owner		= THIS_MODULE,
 	.open		= proc_vis_open,
@@ -666,9 +603,6 @@ void cleanup_procfs(void)
 	if (proc_vis_file)
 		remove_proc_entry(PROC_FILE_VIS, proc_batman_dir);
 
-	if (proc_vis_format_file)
-		remove_proc_entry(PROC_FILE_VIS_FORMAT, proc_batman_dir);
-
 	if (proc_aggr_file)
 		remove_proc_entry(PROC_FILE_AGGR, proc_batman_dir);
 
@@ -755,17 +689,6 @@ int setup_procfs(void)
 		return -EFAULT;
 	}
 
-	proc_vis_format_file = create_proc_entry(PROC_FILE_VIS_FORMAT,
-						 S_IWUSR | S_IRUGO,
-						 proc_batman_dir);
-	if (proc_vis_format_file) {
-		proc_vis_format_file->proc_fops = &proc_vis_format_fops;
-	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_VIS_FORMAT);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
 	proc_aggr_file = create_proc_entry(PROC_FILE_AGGR, S_IWUSR | S_IRUGO,
 					   proc_batman_dir);
 	if (proc_aggr_file) {
diff --git a/batman-adv-kernelland/vis.h b/batman-adv-kernelland/vis.h
index 276faba..ff88a43 100644
--- a/batman-adv-kernelland/vis.h
+++ b/batman-adv-kernelland/vis.h
@@ -45,11 +45,6 @@ struct recvlist_node {
 	uint8_t mac[ETH_ALEN];
 };
 
-enum vis_formats {
-	DOT_DRAW,
-	JSON,
-};
-
 extern struct hashtable_t *vis_hash;
 extern spinlock_t vis_hash_lock;
 
-- 
1.6.5.7

