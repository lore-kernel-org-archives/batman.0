Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri,  4 Jun 2010 16:25:03 +0200
Message-Id: <1275661503-29294-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1275661264-29089-1-git-send-email-sven.eckelmann@gmx.de>
References: <1275661264-29089-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv2-maint] batman-adv: Use (pr|netdev)_<level>
	macro helpers
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
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Joe Perches <joe@perches.com>

From: Joe Perches <joe@perches.com>

Compile tested only

Add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
Remove "batman-adv:" from format strings
Use pr_<level>
Use netdev_<level>

Signed-off-by: Joe Perches <joe@perches.com>
[sven.eckelmann@gmx.de: Adapted for current batman-adv version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 Marek, can you please test it with 2.6.21?
 This patch depends on batman-adv: "Convert MAC_FMT to %pM"

 aggregation.c       |    2 +
 bat_debugfs.c       |    6 +++-
 bat_sysfs.c         |   59 ++++++++++++++++++++++++++++++--------------------
 bitarray.c          |    2 +
 compat.h            |   32 +++++++++++++++++++++++++++
 hard-interface.c    |   31 ++++++++++----------------
 icmp_socket.c       |   11 +++++----
 main.c              |   17 ++++++--------
 main.h              |   18 ++++++++-------
 originator.c        |   17 ++++++--------
 routing.c           |   14 +++++-------
 send.c              |   11 ++++-----
 translation-table.c |    8 +++---
 vis.c               |   11 +++++----
 14 files changed, 138 insertions(+), 101 deletions(-)

diff --git a/aggregation.c b/aggregation.c
index ce8b8a6..66ee09e 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "aggregation.h"
 #include "send.h"
diff --git a/bat_debugfs.c b/bat_debugfs.c
index 18dd040..2b0f66c 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/debugfs.h>
 
 #include "main.h"
@@ -120,8 +122,8 @@ int debugfs_add_meshif(struct net_device *dev)
 					  bat_priv->debug_dir,
 					  dev, &(*bat_debug)->fops);
 		if (!file) {
-			printk(KERN_ERR "batman-adv:Can't add debugfs file: "
-			       "%s/%s\n", dev->name, ((*bat_debug)->attr).name);
+			pr_err("Can't add debugfs file: %s/%s\n",
+			       dev->name, ((*bat_debug)->attr).name);
 			goto rem_attr;
 		}
 	}
diff --git a/bat_sysfs.c b/bat_sysfs.c
index 502d5e9..746e9b3 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "bat_sysfs.h"
 #include "translation-table.h"
@@ -68,18 +70,20 @@ static ssize_t store_aggr_ogms(struct kobject *kobj, struct attribute *attr,
 		if (buff[count - 1] == '\n')
 			buff[count - 1] = '\0';
 
-		printk(KERN_INFO "batman-adv:Invalid parameter for 'aggregate OGM' setting on mesh %s received: %s\n",
-		       net_dev->name, buff);
+		netdev_info(net_dev,
+			    "Invalid parameter for 'aggregate OGM' setting on"
+			    " mesh received: %s\n",
+			    buff);
 		return -EINVAL;
 	}
 
 	if (atomic_read(&bat_priv->aggregation_enabled) == aggr_tmp)
 		return count;
 
-	printk(KERN_INFO "batman-adv:Changing aggregation from: %s to: %s on mesh: %s\n",
-	       atomic_read(&bat_priv->aggregation_enabled) == 1 ?
-	       "enabled" : "disabled", aggr_tmp == 1 ? "enabled" : "disabled",
-	       net_dev->name);
+	netdev_info(net_dev, "Changing aggregation from: %s to: %s on mesh\n",
+		    atomic_read(&bat_priv->aggregation_enabled) == 1 ?
+		    "enabled" : "disabled",
+		    aggr_tmp == 1 ? "enabled" : "disabled");
 
 	atomic_set(&bat_priv->aggregation_enabled, (unsigned)aggr_tmp);
 	return count;
@@ -121,18 +125,20 @@ static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
 		if (buff[count - 1] == '\n')
 			buff[count - 1] = '\0';
 
-		printk(KERN_INFO "batman-adv:Invalid parameter for 'vis mode' setting on mesh %s received: %s\n",
-		       net_dev->name, buff);
+		netdev_info(net_dev, "Invalid parameter for 'vis mode' setting"
+			    " on mesh received: %s\n",
+			    buff);
 		return -EINVAL;
 	}
 
 	if (atomic_read(&bat_priv->vis_mode) == vis_mode_tmp)
 		return count;
 
-	printk(KERN_INFO "batman-adv:Changing vis mode from: %s to: %s on mesh: %s\n",
-	       atomic_read(&bat_priv->vis_mode) == VIS_TYPE_CLIENT_UPDATE ?
-	       "client" : "server", vis_mode_tmp == VIS_TYPE_CLIENT_UPDATE ?
-	       "client" : "server", net_dev->name);
+	netdev_info(net_dev, "Changing vis mode from: %s to: %s on mesh\n",
+		    atomic_read(&bat_priv->vis_mode) == VIS_TYPE_CLIENT_UPDATE ?
+		    "client" : "server",
+		    vis_mode_tmp == VIS_TYPE_CLIENT_UPDATE ?
+		    "client" : "server");
 
 	atomic_set(&bat_priv->vis_mode, (unsigned)vis_mode_tmp);
 	return count;
@@ -159,23 +165,27 @@ static ssize_t store_orig_interval(struct kobject *kobj, struct attribute *attr,
 
 	ret = strict_strtoul(buff, 10, &orig_interval_tmp);
 	if (ret) {
-		printk(KERN_INFO "batman-adv:Invalid parameter for 'orig_interval' setting on mesh %s received: %s\n",
-		       net_dev->name, buff);
+		netdev_info(net_dev,
+			    "Invalid parameter for 'orig_interval' setting on "
+			    "mesh received: %s\n",
+			    buff);
 		return -EINVAL;
 	}
 
 	if (orig_interval_tmp <= JITTER * 2) {
-		printk(KERN_INFO "batman-adv:New originator interval too small: %li (min: %i)\n",
-		       orig_interval_tmp, JITTER * 2);
+		netdev_info(net_dev, "New originator interval too small: %li"
+			    " (min: %i)\n",
+			    orig_interval_tmp, JITTER * 2);
 		return -EINVAL;
 	}
 
 	if (atomic_read(&bat_priv->orig_interval) == orig_interval_tmp)
 		return count;
 
-	printk(KERN_INFO "batman-adv:Changing originator interval from: %i to: %li on mesh: %s\n",
-	       atomic_read(&bat_priv->orig_interval),
-	       orig_interval_tmp, net_dev->name);
+	netdev_info(net_dev,
+		    "Changing originator interval from: %i to: %li"" on mesh\n",
+		    atomic_read(&bat_priv->orig_interval),
+		    orig_interval_tmp);
 
 	atomic_set(&bat_priv->orig_interval, orig_interval_tmp);
 	return count;
@@ -212,7 +222,7 @@ int sysfs_add_meshif(struct net_device *dev)
 	bat_priv->mesh_obj = kobject_create_and_add(SYSFS_IF_MESH_SUBDIR,
 						    batif_kobject);
 	if (!bat_priv->mesh_obj) {
-		printk(KERN_ERR "batman-adv:Can't add sysfs directory: %s/%s\n",
+		pr_err("Can't add sysfs directory: %s/%s\n",
 		       dev->name, SYSFS_IF_MESH_SUBDIR);
 		goto out;
 	}
@@ -221,7 +231,7 @@ int sysfs_add_meshif(struct net_device *dev)
 		err = sysfs_create_file(bat_priv->mesh_obj,
 					&((*bat_attr)->attr));
 		if (err) {
-			printk(KERN_ERR "batman-adv:Can't add sysfs file: %s/%s/%s\n",
+			pr_err("Can't add sysfs file: %s/%s/%s\n",
 			       dev->name, SYSFS_IF_MESH_SUBDIR,
 			       ((*bat_attr)->attr).name);
 			goto rem_attr;
@@ -288,7 +298,8 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 		if (buff[count - 1] == '\n')
 			buff[count - 1] = '\0';
 
-		printk(KERN_ERR "batman-adv:Invalid parameter for 'mesh_iface' setting received: %s\n",
+		pr_err("Invalid parameter for 'mesh_iface' setting received: "
+		       "%s\n",
 		       buff);
 		return -EINVAL;
 	}
@@ -351,7 +362,7 @@ int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
 						    hardif_kobject);
 
 	if (!*hardif_obj) {
-		printk(KERN_ERR "batman-adv:Can't add sysfs directory: %s/%s\n",
+		pr_err("Can't add sysfs directory: %s/%s\n",
 		       dev->name, SYSFS_IF_BAT_SUBDIR);
 		goto out;
 	}
@@ -359,7 +370,7 @@ int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
 	for (bat_attr = batman_attrs; *bat_attr; ++bat_attr) {
 		err = sysfs_create_file(*hardif_obj, &((*bat_attr)->attr));
 		if (err) {
-			printk(KERN_ERR "batman-adv:Can't add sysfs file: %s/%s/%s\n",
+			pr_err("Can't add sysfs file: %s/%s/%s\n",
 			       dev->name, SYSFS_IF_BAT_SUBDIR,
 			       ((*bat_attr)->attr).name);
 			goto rem_attr;
diff --git a/bitarray.c b/bitarray.c
index 2fef6e3..d493625 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "bitarray.h"
 
diff --git a/compat.h b/compat.h
index 144e25a..80db785 100644
--- a/compat.h
+++ b/compat.h
@@ -70,6 +70,19 @@ static inline int skb_clone_writable(struct sk_buff *skb, unsigned int len)
 
 #endif /* < KERNEL_VERSION(2, 6, 23) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 24)
+
+#ifndef pr_fmt
+#define pr_fmt(fmt) fmt
+#endif
+
+#define pr_err(fmt, ...) \
+	printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_warning(fmt, ...) \
+	printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
+
+#endif /* < KERNEL_VERSION(2, 6, 24) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 25)
 
 #define strict_strtoul(cp, base, res) \
@@ -240,3 +253,22 @@ static inline struct net_device_stats *dev_get_stats(struct net_device *dev)
 }
 
 #endif /* < KERNEL_VERSION(2, 6, 29) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 34)
+
+static inline const char *netdev_name(const struct net_device *dev)
+{
+	if (dev->reg_state != NETREG_REGISTERED)
+		return "(unregistered net_device)";
+	return dev->name;
+}
+
+#define netdev_printk(level, netdev, format, args...)		\
+	dev_printk(level, (netdev)->dev.parent,			\
+		   "%s: " format,				\
+		   netdev_name(netdev), ##args)
+
+#define netdev_info(dev, format, args...)			\
+	netdev_printk(KERN_INFO, dev, format, ##args)
+
+#endif /* < KERNEL_VERSION(2, 6, 34) */
diff --git a/hard-interface.c b/hard-interface.c
index 55a8da8..99b2375 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "hard-interface.h"
 #include "soft-interface.h"
@@ -152,12 +154,9 @@ static void check_known_mac_addr(uint8_t *addr)
 		if (!compare_orig(batman_if->net_dev->dev_addr, addr))
 			continue;
 
-		printk(KERN_WARNING "batman-adv:"
-		    "The newly added mac address (%pM) already exists on: %s\n",
-		    addr, batman_if->dev);
-		printk(KERN_WARNING "batman-adv:"
-		    "It is strongly recommended to keep mac addresses unique"
-		    "to avoid problems!\n");
+		pr_warning("The newly added mac address (%pM) already exists on: %s\n",
+			   addr, batman_if->dev);
+		pr_warning("It is strongly recommended to keep mac addresses unique to avoid problems!\n");
 	}
 	rcu_read_unlock();
 }
@@ -209,8 +208,7 @@ static void hardif_activate_interface(struct bat_priv *bat_priv,
 	if (!bat_priv->primary_if)
 		set_primary_if(bat_priv, batman_if);
 
-	printk(KERN_INFO "batman-adv:Interface activated: %s\n",
-	       batman_if->dev);
+	pr_info("Interface activated: %s\n", batman_if->dev);
 
 	if (atomic_read(&module_state) == MODULE_INACTIVE)
 		activate_module();
@@ -229,8 +227,7 @@ static void hardif_deactivate_interface(struct batman_if *batman_if)
 
 	batman_if->if_status = IF_INACTIVE;
 
-	printk(KERN_INFO "batman-adv:Interface deactivated: %s\n",
-	       batman_if->dev);
+	pr_info("Interface deactivated: %s\n", batman_if->dev);
 
 	update_min_mtu();
 }
@@ -248,8 +245,7 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	batman_if->packet_buff = kmalloc(batman_if->packet_len, GFP_ATOMIC);
 
 	if (!batman_if->packet_buff) {
-		printk(KERN_ERR "batman-adv:"
-		       "Can't add interface packet (%s): out of memory\n",
+		pr_err("Can't add interface packet (%s): out of memory\n",
 		       batman_if->dev);
 		goto err;
 	}
@@ -268,14 +264,12 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	orig_hash_add_if(batman_if, bat_priv->num_ifaces);
 
 	atomic_set(&batman_if->seqno, 1);
-	printk(KERN_INFO "batman-adv:Adding interface: %s\n", batman_if->dev);
+	pr_info("Adding interface: %s\n", batman_if->dev);
 
 	if (hardif_is_iface_up(batman_if))
 		hardif_activate_interface(bat_priv, batman_if);
 	else
-		printk(KERN_ERR "batman-adv:"
-		       "Not using interface %s "
-		       "(retrying later): interface not active\n",
+		pr_err("Not using interface %s (retrying later): interface not active\n",
 		       batman_if->dev);
 
 	/* begin scheduling originator messages on that interface */
@@ -299,7 +293,7 @@ void hardif_disable_interface(struct batman_if *batman_if)
 	if (batman_if->if_status != IF_INACTIVE)
 		return;
 
-	printk(KERN_INFO "batman-adv:Removing interface: %s\n", batman_if->dev);
+	pr_info("Removing interface: %s\n", batman_if->dev);
 	bat_priv->num_ifaces--;
 	orig_hash_del_if(batman_if, bat_priv->num_ifaces);
 
@@ -326,8 +320,7 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 
 	batman_if = kmalloc(sizeof(struct batman_if), GFP_ATOMIC);
 	if (!batman_if) {
-		printk(KERN_ERR "batman-adv:"
-		       "Can't add interface (%s): out of memory\n",
+		pr_err("Can't add interface (%s): out of memory\n",
 		       net_dev->name);
 		goto out;
 	}
diff --git a/icmp_socket.c b/icmp_socket.c
index ca82b15..97fa3af 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/debugfs.h>
 #include <linux/slab.h>
 #include "main.h"
@@ -59,8 +61,7 @@ static int bat_socket_open(struct inode *inode, struct file *file)
 	}
 
 	if (i == ARRAY_SIZE(socket_client_hash)) {
-		printk(KERN_ERR "batman-adv:"
-		       "Error - can't add another packet client: "
+		pr_err("Error - can't add another packet client: "
 		       "maximum number of clients reached\n");
 		kfree(socket_client);
 		return -EXFULL;
@@ -162,7 +163,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	unsigned long flags;
 
 	if (len < sizeof(struct icmp_packet)) {
-		bat_dbg(DBG_BATMAN, "batman-adv:"
+		bat_dbg(DBG_BATMAN,
 			"Error - can't send packet from char device: "
 			"invalid packet size\n");
 		return -EINVAL;
@@ -175,14 +176,14 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 		return -EFAULT;
 
 	if (icmp_packet.packet_type != BAT_ICMP) {
-		bat_dbg(DBG_BATMAN, "batman-adv:"
+		bat_dbg(DBG_BATMAN,
 			"Error - can't send packet from char device: "
 			"got bogus packet type (expected: BAT_ICMP)\n");
 		return -EINVAL;
 	}
 
 	if (icmp_packet.msg_type != ECHO_REQUEST) {
-		bat_dbg(DBG_BATMAN, "batman-adv:"
+		bat_dbg(DBG_BATMAN,
 			"Error - can't send packet from char device: "
 			"got bogus message type (expected: ECHO_REQUEST)\n");
 		return -EINVAL;
diff --git a/main.c b/main.c
index 05744e7..cdf3991 100644
--- a/main.c
+++ b/main.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "bat_sysfs.h"
 #include "bat_debugfs.h"
@@ -99,16 +101,14 @@ int init_module(void)
 				   interface_setup);
 
 	if (!soft_device) {
-		printk(KERN_ERR "batman-adv:"
-		       "Unable to allocate the batman interface\n");
+		pr_err("Unable to allocate the batman interface\n");
 		goto end;
 	}
 
 	retval = register_netdev(soft_device);
 
 	if (retval < 0) {
-		printk(KERN_ERR "batman-adv:"
-		       "Unable to register the batman interface: %i\n", retval);
+		pr_err("Unable to register the batman interface: %i\n", retval);
 		goto free_soft_device;
 	}
 
@@ -125,9 +125,8 @@ int init_module(void)
 	register_netdevice_notifier(&hard_if_notifier);
 	dev_add_pack(&batman_adv_packet_type);
 
-	printk(KERN_INFO "batman-adv:"
-	       "B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded\n",
-	       SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
+	pr_info("B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded\n",
+		SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
 
 	return 0;
 
@@ -187,9 +186,7 @@ void activate_module(void)
 	goto end;
 
 err:
-	printk(KERN_ERR "batman-adv:"
-	       "Unable to allocate memory for mesh information structures: "
-	       "out of mem ?\n");
+	pr_err("Unable to allocate memory for mesh information structures: out of mem ?\n");
 	deactivate_module();
 end:
 	return;
diff --git a/main.h b/main.h
index 7cb0b18..e338cbb 100644
--- a/main.h
+++ b/main.h
@@ -87,15 +87,17 @@
 extern int debug;
 
 extern int bat_debug_type(int type);
-#define bat_dbg(type, fmt, arg...) do {					\
-		if (bat_debug_type(type))				\
-			printk(KERN_DEBUG "batman-adv:" fmt, ## arg);	\
-	}								\
-	while (0)
+#define bat_dbg(type, fmt, arg...)				\
+do {								\
+	if (bat_debug_type(type))				\
+		printk(KERN_DEBUG pr_fmt(fmt), ##arg);		\
+} while (0)
 #else /* !CONFIG_BATMAN_ADV_DEBUG */
-#define bat_dbg(type, fmt, arg...) do {		\
-	}					\
-	while (0)
+#define bat_dbg(type, fmt, arg...)				\
+do {								\
+	if (0)							\
+		printk(KERN_DEBUG pr_fmt(fmt), ##arg);		\
+} while (0)
 #endif
 
 /*
diff --git a/originator.c b/originator.c
index 183b7a1..fc36d88 100644
--- a/originator.c
+++ b/originator.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 /* increase the reference counter for this originator */
 
 #include "main.h"
@@ -164,8 +166,7 @@ struct orig_node *get_orig_node(uint8_t *addr)
 		swaphash = hash_resize(orig_hash, orig_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR
-			       "batman-adv:Couldn't resize orig hash table\n");
+			pr_err("Couldn't resize orig hash table\n");
 		else
 			orig_hash = swaphash;
 	}
@@ -348,8 +349,7 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 	data_ptr = kmalloc(max_if_num * sizeof(TYPE_OF_WORD) * NUM_WORDS,
 			   GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -360,8 +360,7 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -410,8 +409,7 @@ static int orig_node_del_if(struct orig_node *orig_node,
 	chunk_size = sizeof(TYPE_OF_WORD) * NUM_WORDS;
 	data_ptr = kmalloc(max_if_num * chunk_size, GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -432,8 +430,7 @@ free_bcast_own:
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
diff --git a/routing.c b/routing.c
index e9b0377..5bacbf6 100644
--- a/routing.c
+++ b/routing.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "routing.h"
 #include "send.h"
@@ -732,10 +734,8 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
 
 	/* send TTL exceeded if packet is an echo request (traceroute) */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
-		printk(KERN_WARNING "batman-adv:"
-		       "Warning - can't forward icmp packet from %pM to %pM: "
-		       "ttl exceeded\n",
-		       icmp_packet->orig, icmp_packet->dst);
+		pr_warning("Warning - can't forward icmp packet from %pM to %pM: ttl exceeded\n",
+			   icmp_packet->orig, icmp_packet->dst);
 		return NET_RX_DROP;
 	}
 
@@ -900,10 +900,8 @@ int recv_unicast_packet(struct sk_buff *skb)
 
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
-		printk(KERN_WARNING "batman-adv:Warning - "
-		       "can't forward unicast packet from %pM to %pM: "
-		       "ttl exceeded\n",
-		       ethhdr->h_source, unicast_packet->dest);
+		pr_warning("Warning - can't forward unicast packet from %pM to %pM: ttl exceeded\n",
+			   ethhdr->h_source, unicast_packet->dest);
 		return NET_RX_DROP;
 	}
 
diff --git a/send.c b/send.c
index 197fce1..c5e5efd 100644
--- a/send.c
+++ b/send.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "send.h"
 #include "routing.h"
@@ -68,10 +70,8 @@ int send_skb_packet(struct sk_buff *skb,
 		goto send_skb_err;
 
 	if (!(batman_if->net_dev->flags & IFF_UP)) {
-		printk(KERN_WARNING
-		       "batman-adv:Interface %s "
-		       "is not up - can't send packet via that interface!\n",
-		       batman_if->dev);
+		pr_warning("Interface %s is not up - can't send packet via that interface!\n",
+			   batman_if->dev);
 		goto send_skb_err;
 	}
 
@@ -186,8 +186,7 @@ static void send_packet(struct forw_packet *forw_packet)
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
 
 	if (!forw_packet->if_incoming) {
-		printk(KERN_ERR "batman-adv: Error - can't forward packet: "
-		       "incoming iface not specified\n");
+		pr_err("Error - can't forward packet: incoming iface not specified\n");
 		return;
 	}
 
diff --git a/translation-table.c b/translation-table.c
index 8edc175..e4c5055 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "translation-table.h"
 #include "soft-interface.h"
@@ -112,8 +114,7 @@ void hna_local_add(uint8_t *addr)
 				       hna_local_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR "batman-adv:"
-			       "Couldn't resize local hna hash table\n");
+			pr_err("Couldn't resize local hna hash table\n");
 		else
 			hna_local_hash = swaphash;
 	}
@@ -365,8 +366,7 @@ void hna_global_add_orig(struct orig_node *orig_node,
 				       hna_global_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR "batman-adv:"
-			       "Couldn't resize global hna hash table\n");
+			pr_err("Couldn't resize global hna hash table\n");
 		else
 			hna_global_hash = swaphash;
 	}
diff --git a/vis.c b/vis.c
index ba9a055..8c14fff 100644
--- a/vis.c
+++ b/vis.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "send.h"
 #include "translation-table.h"
@@ -678,7 +680,7 @@ static void send_vis_packet(struct vis_info *info)
 	int packet_length;
 
 	if (info->packet.ttl < 2) {
-		printk(KERN_WARNING "batman-adv: Error - can't send vis packet: ttl exceeded\n");
+		pr_warning("Error - can't send vis packet: ttl exceeded\n");
 		return;
 	}
 
@@ -740,13 +742,13 @@ int vis_init(void)
 
 	vis_hash = hash_new(256, vis_info_cmp, vis_info_choose);
 	if (!vis_hash) {
-		printk(KERN_ERR "batman-adv:Can't initialize vis_hash\n");
+		pr_err("Can't initialize vis_hash\n");
 		goto err;
 	}
 
 	my_vis_info = kmalloc(1000, GFP_ATOMIC);
 	if (!my_vis_info) {
-		printk(KERN_ERR "batman-adv:Can't initialize vis packet\n");
+		pr_err("Can't initialize vis packet\n");
 		goto err;
 	}
 
@@ -767,8 +769,7 @@ int vis_init(void)
 	memcpy(my_vis_info->packet.sender_orig, mainIfAddr, ETH_ALEN);
 
 	if (hash_add(vis_hash, my_vis_info) < 0) {
-		printk(KERN_ERR
-		       "batman-adv:Can't add own vis packet into hash\n");
+		pr_err("Can't add own vis packet into hash\n");
 		/* not in hash, need to remove it manually. */
 		kref_put(&my_vis_info->refcount, free_info);
 		goto err;
-- 
1.7.1

