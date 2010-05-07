Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri,  7 May 2010 21:47:20 +0200
Message-Id: <1273261651-21378-16-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
References: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 15/26] Staging: batman-adv: move originator
	interval setting from /proc to /sys
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/bat_sysfs.c |   47 ++++++++++++++++++++
 drivers/staging/batman-adv/main.c      |    2 -
 drivers/staging/batman-adv/main.h      |    1 -
 drivers/staging/batman-adv/proc.c      |   75 --------------------------------
 drivers/staging/batman-adv/proc.h      |    1 -
 drivers/staging/batman-adv/send.c      |    6 +-
 drivers/staging/batman-adv/types.h     |    1 +
 7 files changed, 51 insertions(+), 82 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index c14ab47..ea7ce77 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -153,13 +153,59 @@ static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
 	return count;
 }
 
+static ssize_t show_orig_interval(struct kobject *kobj, struct attribute *attr,
+				 char *buff)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
+
+	return sprintf(buff, "status: %i\n",
+		       atomic_read(&bat_priv->orig_interval));
+}
+
+static ssize_t store_orig_interval(struct kobject *kobj, struct attribute *attr,
+				  char *buff, size_t count)
+{
+	struct device *dev = to_dev(kobj->parent);
+	struct net_device *net_dev = to_net_dev(dev);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	unsigned long orig_interval_tmp;
+	int ret;
+
+	ret = strict_strtoul(buff, 10, &orig_interval_tmp);
+	if (ret) {
+		printk(KERN_INFO "batman-adv:Invalid parameter for 'orig_interval' setting on mesh %s received: %s\n",
+		       net_dev->name, buff);
+		return -EINVAL;
+	}
+
+	if (orig_interval_tmp <= JITTER * 2) {
+		printk(KERN_INFO "batman-adv:New originator interval too small: %li (min: %i)\n",
+		       orig_interval_tmp, JITTER * 2);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&bat_priv->orig_interval) == orig_interval_tmp)
+		return count;
+
+	printk(KERN_INFO "batman-adv:Changing originator interval from: %i to: %li on mesh: %s\n",
+	       atomic_read(&bat_priv->orig_interval),
+	       orig_interval_tmp, net_dev->name);
+
+	atomic_set(&bat_priv->orig_interval, orig_interval_tmp);
+	return count;
+}
+
 static BAT_ATTR(aggregate_ogm, S_IRUGO | S_IWUSR,
 		show_aggr_ogm, store_aggr_ogm);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
+static BAT_ATTR(orig_interval, S_IRUGO | S_IWUSR,
+		show_orig_interval, store_orig_interval);
 
 static struct bat_attribute *mesh_attrs[] = {
 	&bat_attr_aggregate_ogm,
 	&bat_attr_vis_mode,
+	&bat_attr_orig_interval,
 	NULL,
 };
 
@@ -228,6 +274,7 @@ int sysfs_add_meshif(struct net_device *dev)
 		  routine as soon as we have it */
 	atomic_set(&bat_priv->aggregation_enabled, 1);
 	atomic_set(&bat_priv->vis_mode, VIS_TYPE_CLIENT_UPDATE);
+	atomic_set(&bat_priv->orig_interval, 1000);
 
 	bat_priv->mesh_obj = kobject_create_and_add(SYSFS_IF_MESH_SUBDIR,
 						    batif_kobject);
diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index 54e8cd5..7d72685 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -42,7 +42,6 @@ DEFINE_SPINLOCK(orig_hash_lock);
 DEFINE_SPINLOCK(forw_bat_list_lock);
 DEFINE_SPINLOCK(forw_bcast_list_lock);
 
-atomic_t originator_interval;
 atomic_t vis_interval;
 int16_t num_hna;
 int16_t num_ifs;
@@ -80,7 +79,6 @@ int init_module(void)
 
 	atomic_set(&module_state, MODULE_INACTIVE);
 
-	atomic_set(&originator_interval, 1000);
 	atomic_set(&vis_interval, 1000);/* TODO: raise this later, this is only
 					 * for debugging now. */
 
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index b2283a7..59a70c7 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -127,7 +127,6 @@ extern spinlock_t orig_hash_lock;
 extern spinlock_t forw_bat_list_lock;
 extern spinlock_t forw_bcast_list_lock;
 
-extern atomic_t originator_interval;
 extern atomic_t vis_interval;
 extern int16_t num_hna;
 extern int16_t num_ifs;
diff --git a/drivers/staging/batman-adv/proc.c b/drivers/staging/batman-adv/proc.c
index cbea642..25b24fe 100644
--- a/drivers/staging/batman-adv/proc.c
+++ b/drivers/staging/batman-adv/proc.c
@@ -29,7 +29,6 @@
 #include "vis.h"
 
 static struct proc_dir_entry *proc_batman_dir, *proc_interface_file;
-static struct proc_dir_entry *proc_orig_interval_file;
 
 static int proc_interfaces_read(struct seq_file *seq, void *offset)
 {
@@ -121,57 +120,6 @@ end:
 	return count;
 }
 
-static int proc_orig_interval_read(struct seq_file *seq, void *offset)
-{
-	seq_printf(seq, "%i\n", atomic_read(&originator_interval));
-
-	return 0;
-}
-
-static ssize_t proc_orig_interval_write(struct file *file,
-					const char __user *buffer,
-					size_t count, loff_t *ppos)
-{
-	char *interval_string;
-	int not_copied = 0;
-	unsigned long originator_interval_tmp;
-	int retval;
-
-	interval_string = kmalloc(count, GFP_KERNEL);
-
-	if (!interval_string)
-		return -ENOMEM;
-
-	not_copied = copy_from_user(interval_string, buffer, count);
-	interval_string[count - not_copied - 1] = 0;
-
-	retval = strict_strtoul(interval_string, 10, &originator_interval_tmp);
-	if (retval) {
-		printk(KERN_ERR "batman-adv:New originator interval invalid\n");
-		goto end;
-	}
-
-	if (originator_interval_tmp <= JITTER * 2) {
-		printk(KERN_WARNING "batman-adv:New originator interval too small: %li (min: %i)\n",
-		       originator_interval_tmp, JITTER * 2);
-		goto end;
-	}
-
-	printk(KERN_INFO "batman-adv:Changing originator interval from: %i to: %li\n",
-	       atomic_read(&originator_interval), originator_interval_tmp);
-
-	atomic_set(&originator_interval, originator_interval_tmp);
-
-end:
-	kfree(interval_string);
-	return count;
-}
-
-static int proc_orig_interval_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_orig_interval_read, NULL);
-}
-
 static const struct file_operations proc_interfaces_fops = {
 	.owner		= THIS_MODULE,
 	.open		= proc_interfaces_open,
@@ -181,20 +129,8 @@ static const struct file_operations proc_interfaces_fops = {
 	.release	= single_release,
 };
 
-static const struct file_operations proc_orig_interval_fops = {
-	.owner		= THIS_MODULE,
-	.open		= proc_orig_interval_open,
-	.read		= seq_read,
-	.write		= proc_orig_interval_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 void cleanup_procfs(void)
 {
-	if (proc_orig_interval_file)
-		remove_proc_entry(PROC_FILE_ORIG_INTERVAL, proc_batman_dir);
-
 	if (proc_interface_file)
 		remove_proc_entry(PROC_FILE_INTERFACES, proc_batman_dir);
 
@@ -230,16 +166,5 @@ int setup_procfs(void)
 		return -EFAULT;
 	}
 
-	proc_orig_interval_file = create_proc_entry(PROC_FILE_ORIG_INTERVAL,
-						    S_IWUSR | S_IRUGO,
-						    proc_batman_dir);
-	if (proc_orig_interval_file) {
-		proc_orig_interval_file->proc_fops = &proc_orig_interval_fops;
-	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_ORIG_INTERVAL);
-		cleanup_procfs();
-		return -EFAULT;
-	}
-
 	return 0;
 }
diff --git a/drivers/staging/batman-adv/proc.h b/drivers/staging/batman-adv/proc.h
index 6a972a6..6f4f5b3 100644
--- a/drivers/staging/batman-adv/proc.h
+++ b/drivers/staging/batman-adv/proc.h
@@ -24,7 +24,6 @@
 
 #define PROC_ROOT_DIR "batman-adv"
 #define PROC_FILE_INTERFACES "interfaces"
-#define PROC_FILE_ORIG_INTERVAL "orig_interval"
 
 void cleanup_procfs(void);
 int setup_procfs(void);
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index a00aa88..de2344a 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -36,10 +36,10 @@ static uint8_t hop_penalty(const uint8_t tq)
 }
 
 /* when do we schedule our own packet to be sent */
-static unsigned long own_send_time(void)
+static unsigned long own_send_time(struct bat_priv *bat_priv)
 {
 	return jiffies +
-		(((atomic_read(&originator_interval) - JITTER +
+		(((atomic_read(&bat_priv->orig_interval) - JITTER +
 		   (random32() % 2*JITTER)) * HZ) / 1000);
 }
 
@@ -277,7 +277,7 @@ void schedule_own_packet(struct batman_if *batman_if)
 	atomic_inc(&batman_if->seqno);
 
 	slide_own_bcast_window(batman_if);
-	send_time = own_send_time();
+	send_time = own_send_time(bat_priv);
 	add_bat_packet_to_list(bat_priv,
 			       batman_if->packet_buff,
 			       batman_if->packet_len,
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index e8d2e8c..a8c6ad7 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -84,6 +84,7 @@ struct bat_priv {
 	struct net_device_stats stats;
 	atomic_t aggregation_enabled;
 	atomic_t vis_mode;
+	atomic_t orig_interval;
 	struct kobject *mesh_obj;
 };
 
-- 
1.7.1

