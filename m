Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue,  6 Jul 2010 21:05:17 +0200
Message-Id: <1278443118-19528-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1278443118-19528-1-git-send-email-sven.eckelmann@gmx.de>
References: <1278443118-19528-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] Staging: batman-adv: Move printk to
	simplified macros
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
Cc: b.a.t.m.a.n@lists.open-mesh.net

Each general printk which is not informative by itself for a specific
batX device were moved to pr_(info|warning|err) as it provides an easy
interface which for example resolves the problem to add the prefix
"batman-adv: " before each line.

All information which is specific to a batX device will be printed using
a bat_(info|err|warning) macro to prefix it also with "batman-adv:
batX:" in each line.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/bat_debugfs.c       |    9 ++-
 drivers/staging/batman-adv/bat_sysfs.c         |   93 ++++++++++++------------
 drivers/staging/batman-adv/hard-interface.c    |   49 ++++++-------
 drivers/staging/batman-adv/icmp_socket.c       |    5 +-
 drivers/staging/batman-adv/main.c              |   15 ++---
 drivers/staging/batman-adv/main.h              |   25 +++++++
 drivers/staging/batman-adv/originator.c        |   16 ++---
 drivers/staging/batman-adv/routing.c           |   14 ++--
 drivers/staging/batman-adv/send.c              |   10 +--
 drivers/staging/batman-adv/translation-table.c |    6 +-
 drivers/staging/batman-adv/vis.c               |    9 +--
 11 files changed, 129 insertions(+), 122 deletions(-)

diff --git a/drivers/staging/batman-adv/bat_debugfs.c b/drivers/staging/batman-adv/bat_debugfs.c
index f818d5e..8e8eef0 100644
--- a/drivers/staging/batman-adv/bat_debugfs.c
+++ b/drivers/staging/batman-adv/bat_debugfs.c
@@ -19,9 +19,10 @@
  *
  */
 
-#include <linux/debugfs.h>
-
 #include "main.h"
+
+#include <linux/debugfs.h>
+
 #include "bat_debugfs.h"
 #include "translation-table.h"
 #include "originator.h"
@@ -309,8 +310,8 @@ int debugfs_add_meshif(struct net_device *dev)
 					  bat_priv->debug_dir,
 					  dev, &(*bat_debug)->fops);
 		if (!file) {
-			printk(KERN_ERR "batman-adv:Can't add debugfs file: "
-			       "%s/%s\n", dev->name, ((*bat_debug)->attr).name);
+			bat_err(dev, "Can't add debugfs file: %s/%s\n",
+				dev->name, ((*bat_debug)->attr).name);
 			goto rem_attr;
 		}
 	}
diff --git a/drivers/staging/batman-adv/bat_sysfs.c b/drivers/staging/batman-adv/bat_sysfs.c
index 65e1465..05ca15a 100644
--- a/drivers/staging/batman-adv/bat_sysfs.c
+++ b/drivers/staging/batman-adv/bat_sysfs.c
@@ -67,18 +67,19 @@ static ssize_t store_aggr_ogms(struct kobject *kobj, struct attribute *attr,
 		if (buff[count - 1] == '\n')
 			buff[count - 1] = '\0';
 
-		printk(KERN_INFO "batman-adv:Invalid parameter for 'aggregate OGM' setting on mesh %s received: %s\n",
-		       net_dev->name, buff);
+		bat_info(net_dev,
+			 "Invalid parameter for 'aggregate OGM' setting"
+			 "received: %s\n", buff);
 		return -EINVAL;
 	}
 
 	if (atomic_read(&bat_priv->aggregation_enabled) == aggr_tmp)
 		return count;
 
-	printk(KERN_INFO "batman-adv:Changing aggregation from: %s to: %s on mesh: %s\n",
-	       atomic_read(&bat_priv->aggregation_enabled) == 1 ?
-	       "enabled" : "disabled", aggr_tmp == 1 ? "enabled" : "disabled",
-	       net_dev->name);
+	bat_info(net_dev, "Changing aggregation from: %s to: %s\n",
+		 atomic_read(&bat_priv->aggregation_enabled) == 1 ?
+		 "enabled" : "disabled", aggr_tmp == 1 ? "enabled" :
+		 "disabled");
 
 	atomic_set(&bat_priv->aggregation_enabled, (unsigned)aggr_tmp);
 	return count;
@@ -115,19 +116,19 @@ static ssize_t store_bond(struct kobject *kobj, struct attribute *attr,
 		if (buff[count - 1] == '\n')
 			buff[count - 1] = '\0';
 
-		printk(KERN_ERR "batman-adv:Invalid parameter for 'bonding' setting on mesh %s received: %s\n",
-		       net_dev->name, buff);
+		bat_err(net_dev,
+			"Invalid parameter for 'bonding' setting received: "
+			"%s\n", buff);
 		return -EINVAL;
 	}
 
 	if (atomic_read(&bat_priv->bonding_enabled) == bonding_enabled_tmp)
 		return count;
 
-	printk(KERN_INFO "batman-adv:Changing bonding from: %s to: %s on mesh: %s\n",
-	       atomic_read(&bat_priv->bonding_enabled) == 1 ?
-	       "enabled" : "disabled",
-	       bonding_enabled_tmp == 1 ? "enabled" : "disabled",
-	       net_dev->name);
+	bat_info(net_dev, "Changing bonding from: %s to: %s\n",
+		 atomic_read(&bat_priv->bonding_enabled) == 1 ?
+		 "enabled" : "disabled",
+		 bonding_enabled_tmp == 1 ? "enabled" : "disabled");
 
 	atomic_set(&bat_priv->bonding_enabled, (unsigned)bonding_enabled_tmp);
 	return count;
@@ -169,18 +170,19 @@ static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
 		if (buff[count - 1] == '\n')
 			buff[count - 1] = '\0';
 
-		printk(KERN_INFO "batman-adv:Invalid parameter for 'vis mode' setting on mesh %s received: %s\n",
-		       net_dev->name, buff);
+		bat_info(net_dev,
+			 "Invalid parameter for 'vis mode' setting received: "
+			 "%s\n", buff);
 		return -EINVAL;
 	}
 
 	if (atomic_read(&bat_priv->vis_mode) == vis_mode_tmp)
 		return count;
 
-	printk(KERN_INFO "batman-adv:Changing vis mode from: %s to: %s on mesh: %s\n",
-	       atomic_read(&bat_priv->vis_mode) == VIS_TYPE_CLIENT_UPDATE ?
-	       "client" : "server", vis_mode_tmp == VIS_TYPE_CLIENT_UPDATE ?
-	       "client" : "server", net_dev->name);
+	bat_info(net_dev, "Changing vis mode from: %s to: %s\n",
+		 atomic_read(&bat_priv->vis_mode) == VIS_TYPE_CLIENT_UPDATE ?
+		 "client" : "server", vis_mode_tmp == VIS_TYPE_CLIENT_UPDATE ?
+		 "client" : "server");
 
 	atomic_set(&bat_priv->vis_mode, (unsigned)vis_mode_tmp);
 	return count;
@@ -207,23 +209,23 @@ static ssize_t store_orig_interval(struct kobject *kobj, struct attribute *attr,
 
 	ret = strict_strtoul(buff, 10, &orig_interval_tmp);
 	if (ret) {
-		printk(KERN_INFO "batman-adv:Invalid parameter for 'orig_interval' setting on mesh %s received: %s\n",
-		       net_dev->name, buff);
+		bat_info(net_dev, "Invalid parameter for 'orig_interval' "
+			 "setting received: %s\n", buff);
 		return -EINVAL;
 	}
 
 	if (orig_interval_tmp < JITTER * 2) {
-		printk(KERN_INFO "batman-adv:New originator interval too small: %li (min: %i)\n",
-		       orig_interval_tmp, JITTER * 2);
+		bat_info(net_dev, "New originator interval too small: %li "
+			 "(min: %i)\n", orig_interval_tmp, JITTER * 2);
 		return -EINVAL;
 	}
 
 	if (atomic_read(&bat_priv->orig_interval) == orig_interval_tmp)
 		return count;
 
-	printk(KERN_INFO "batman-adv:Changing originator interval from: %i to: %li on mesh: %s\n",
-	       atomic_read(&bat_priv->orig_interval),
-	       orig_interval_tmp, net_dev->name);
+	bat_info(net_dev, "Changing originator interval from: %i to: %li\n",
+		 atomic_read(&bat_priv->orig_interval),
+		 orig_interval_tmp);
 
 	atomic_set(&bat_priv->orig_interval, orig_interval_tmp);
 	return count;
@@ -251,24 +253,23 @@ static ssize_t store_log_level(struct kobject *kobj, struct attribute *attr,
 
 	ret = strict_strtoul(buff, 10, &log_level_tmp);
 	if (ret) {
-		printk(KERN_INFO "batman-adv:Invalid parameter for 'log_level' setting on mesh %s received: %s\n",
-		       net_dev->name, buff);
+		bat_info(net_dev, "Invalid parameter for 'log_level' "
+			 "setting received: %s\n", buff);
 		return -EINVAL;
 	}
 
 	if (log_level_tmp > 3) {
-		printk(KERN_INFO "batman-adv:New log level too big: %li (max: %i)\n",
-		       log_level_tmp, 3);
+		bat_info(net_dev, "New log level too big: %li "
+			 "(max: %i)\n", log_level_tmp, 3);
 		return -EINVAL;
 	}
 
 	if (atomic_read(&bat_priv->log_level) == log_level_tmp)
 		return count;
 
-	printk(KERN_INFO
-	       "batman-adv:Changing log level from: %i to: %li on mesh: %s\n",
-	       atomic_read(&bat_priv->log_level),
-	       log_level_tmp, net_dev->name);
+	bat_info(net_dev, "Changing log level from: %i to: %li\n",
+		 atomic_read(&bat_priv->log_level),
+		 log_level_tmp);
 
 	atomic_set(&bat_priv->log_level, (unsigned)log_level_tmp);
 	return count;
@@ -317,8 +318,8 @@ int sysfs_add_meshif(struct net_device *dev)
 	bat_priv->mesh_obj = kobject_create_and_add(SYSFS_IF_MESH_SUBDIR,
 						    batif_kobject);
 	if (!bat_priv->mesh_obj) {
-		printk(KERN_ERR "batman-adv:Can't add sysfs directory: %s/%s\n",
-		       dev->name, SYSFS_IF_MESH_SUBDIR);
+		bat_err(dev, "Can't add sysfs directory: %s/%s\n", dev->name,
+			SYSFS_IF_MESH_SUBDIR);
 		goto out;
 	}
 
@@ -326,9 +327,9 @@ int sysfs_add_meshif(struct net_device *dev)
 		err = sysfs_create_file(bat_priv->mesh_obj,
 					&((*bat_attr)->attr));
 		if (err) {
-			printk(KERN_ERR "batman-adv:Can't add sysfs file: %s/%s/%s\n",
-			       dev->name, SYSFS_IF_MESH_SUBDIR,
-			       ((*bat_attr)->attr).name);
+			bat_err(dev, "Can't add sysfs file: %s/%s/%s\n",
+				dev->name, SYSFS_IF_MESH_SUBDIR,
+				((*bat_attr)->attr).name);
 			goto rem_attr;
 		}
 	}
@@ -393,8 +394,8 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 		if (buff[count - 1] == '\n')
 			buff[count - 1] = '\0';
 
-		printk(KERN_ERR "batman-adv:Invalid parameter for 'mesh_iface' setting received: %s\n",
-		       buff);
+		pr_err("Invalid parameter for 'mesh_iface' setting received: "
+		       "%s\n", buff);
 		return -EINVAL;
 	}
 
@@ -456,17 +457,17 @@ int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
 						    hardif_kobject);
 
 	if (!*hardif_obj) {
-		printk(KERN_ERR "batman-adv:Can't add sysfs directory: %s/%s\n",
-		       dev->name, SYSFS_IF_BAT_SUBDIR);
+		bat_err(dev, "Can't add sysfs directory: %s/%s\n", dev->name,
+			SYSFS_IF_BAT_SUBDIR);
 		goto out;
 	}
 
 	for (bat_attr = batman_attrs; *bat_attr; ++bat_attr) {
 		err = sysfs_create_file(*hardif_obj, &((*bat_attr)->attr));
 		if (err) {
-			printk(KERN_ERR "batman-adv:Can't add sysfs file: %s/%s/%s\n",
-			       dev->name, SYSFS_IF_BAT_SUBDIR,
-			       ((*bat_attr)->attr).name);
+			bat_err(dev, "Can't add sysfs file: %s/%s/%s\n",
+				dev->name, SYSFS_IF_BAT_SUBDIR,
+				((*bat_attr)->attr).name);
 			goto rem_attr;
 		}
 	}
diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index b5a0f1b..5cc369c 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -150,12 +150,10 @@ static void check_known_mac_addr(uint8_t *addr)
 		if (!compare_orig(batman_if->net_dev->dev_addr, addr))
 			continue;
 
-		printk(KERN_WARNING "batman-adv:"
-		    "The newly added mac address (%pM) already exists on: %s\n",
-		    addr, batman_if->dev);
-		printk(KERN_WARNING "batman-adv:"
-		    "It is strongly recommended to keep mac addresses unique"
-		    "to avoid problems!\n");
+		pr_warning("The newly added mac address (%pM) already exists "
+			   "on: %s\n", addr, batman_if->dev);
+		pr_warning("It is strongly recommended to keep mac addresses "
+			   "unique to avoid problems!\n");
 	}
 	rcu_read_unlock();
 }
@@ -189,7 +187,8 @@ void update_min_mtu(void)
 		soft_device->mtu = min_mtu;
 }
 
-static void hardif_activate_interface(struct bat_priv *bat_priv,
+static void hardif_activate_interface(struct net_device *net_dev,
+				      struct bat_priv *bat_priv,
 				      struct batman_if *batman_if)
 {
 	if (batman_if->if_status != IF_INACTIVE)
@@ -207,8 +206,7 @@ static void hardif_activate_interface(struct bat_priv *bat_priv,
 	if (!bat_priv->primary_if)
 		set_primary_if(bat_priv, batman_if);
 
-	printk(KERN_INFO "batman-adv:Interface activated: %s\n",
-	       batman_if->dev);
+	bat_info(net_dev, "Interface activated: %s\n", batman_if->dev);
 
 	if (atomic_read(&module_state) == MODULE_INACTIVE)
 		activate_module();
@@ -217,7 +215,8 @@ static void hardif_activate_interface(struct bat_priv *bat_priv,
 	return;
 }
 
-static void hardif_deactivate_interface(struct batman_if *batman_if)
+static void hardif_deactivate_interface(struct net_device *net_dev,
+					struct batman_if *batman_if)
 {
 	if ((batman_if->if_status != IF_ACTIVE) &&
 	   (batman_if->if_status != IF_TO_BE_ACTIVATED))
@@ -227,8 +226,7 @@ static void hardif_deactivate_interface(struct batman_if *batman_if)
 
 	batman_if->if_status = IF_INACTIVE;
 
-	printk(KERN_INFO "batman-adv:Interface deactivated: %s\n",
-	       batman_if->dev);
+	bat_info(net_dev, "Interface deactivated: %s\n", batman_if->dev);
 
 	update_min_mtu();
 }
@@ -246,9 +244,8 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	batman_if->packet_buff = kmalloc(batman_if->packet_len, GFP_ATOMIC);
 
 	if (!batman_if->packet_buff) {
-		printk(KERN_ERR "batman-adv:"
-		       "Can't add interface packet (%s): out of memory\n",
-		       batman_if->dev);
+		bat_err(soft_device, "Can't add interface packet (%s): "
+			"out of memory\n", batman_if->dev);
 		goto err;
 	}
 
@@ -266,15 +263,14 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	orig_hash_add_if(batman_if, bat_priv->num_ifaces);
 
 	atomic_set(&batman_if->seqno, 1);
-	printk(KERN_INFO "batman-adv:Adding interface: %s\n", batman_if->dev);
+	bat_info(soft_device, "Adding interface: %s\n", batman_if->dev);
 
 	if (hardif_is_iface_up(batman_if))
-		hardif_activate_interface(bat_priv, batman_if);
+		hardif_activate_interface(soft_device, bat_priv, batman_if);
 	else
-		printk(KERN_ERR "batman-adv:"
-		       "Not using interface %s "
-		       "(retrying later): interface not active\n",
-		       batman_if->dev);
+		bat_err(soft_device, "Not using interface %s "
+			"(retrying later): interface not active\n",
+			batman_if->dev);
 
 	/* begin scheduling originator messages on that interface */
 	schedule_own_packet(batman_if);
@@ -292,12 +288,12 @@ void hardif_disable_interface(struct batman_if *batman_if)
 	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
 	if (batman_if->if_status == IF_ACTIVE)
-		hardif_deactivate_interface(batman_if);
+		hardif_deactivate_interface(soft_device, batman_if);
 
 	if (batman_if->if_status != IF_INACTIVE)
 		return;
 
-	printk(KERN_INFO "batman-adv:Removing interface: %s\n", batman_if->dev);
+	bat_info(soft_device, "Removing interface: %s\n", batman_if->dev);
 	bat_priv->num_ifaces--;
 	orig_hash_del_if(batman_if, bat_priv->num_ifaces);
 
@@ -324,8 +320,7 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 
 	batman_if = kmalloc(sizeof(struct batman_if), GFP_ATOMIC);
 	if (!batman_if) {
-		printk(KERN_ERR "batman-adv:"
-		       "Can't add interface (%s): out of memory\n",
+		pr_err("Can't add interface (%s): out of memory\n",
 		       net_dev->name);
 		goto out;
 	}
@@ -408,11 +403,11 @@ static int hard_if_event(struct notifier_block *this,
 	case NETDEV_REGISTER:
 		break;
 	case NETDEV_UP:
-		hardif_activate_interface(bat_priv, batman_if);
+		hardif_activate_interface(soft_device, bat_priv, batman_if);
 		break;
 	case NETDEV_GOING_DOWN:
 	case NETDEV_DOWN:
-		hardif_deactivate_interface(batman_if);
+		hardif_deactivate_interface(soft_device, batman_if);
 		break;
 	case NETDEV_UNREGISTER:
 		hardif_remove_interface(batman_if);
diff --git a/drivers/staging/batman-adv/icmp_socket.c b/drivers/staging/batman-adv/icmp_socket.c
index eea4ed7..532f246 100644
--- a/drivers/staging/batman-adv/icmp_socket.c
+++ b/drivers/staging/batman-adv/icmp_socket.c
@@ -19,9 +19,9 @@
  *
  */
 
+#include "main.h"
 #include <linux/debugfs.h>
 #include <linux/slab.h>
-#include "main.h"
 #include "icmp_socket.h"
 #include "send.h"
 #include "types.h"
@@ -58,8 +58,7 @@ static int bat_socket_open(struct inode *inode, struct file *file)
 	}
 
 	if (i == ARRAY_SIZE(socket_client_hash)) {
-		printk(KERN_ERR "batman-adv:"
-		       "Error - can't add another packet client: "
+		pr_err("Error - can't add another packet client: "
 		       "maximum number of clients reached\n");
 		kfree(socket_client);
 		return -EXFULL;
diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index 5477d42..a4d238b 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -87,16 +87,14 @@ int init_module(void)
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
 
@@ -113,9 +111,9 @@ int init_module(void)
 	register_netdevice_notifier(&hard_if_notifier);
 	dev_add_pack(&batman_adv_packet_type);
 
-	printk(KERN_INFO "batman-adv:"
-	       "B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded\n",
-	       SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
+	pr_info("B.A.T.M.A.N. advanced %s%s (compatibility version %i) "
+		"loaded\n", SOURCE_VERSION, REVISION_VERSION_STR,
+		COMPAT_VERSION);
 
 	return 0;
 
@@ -176,8 +174,7 @@ void activate_module(void)
 	goto end;
 
 err:
-	printk(KERN_ERR "batman-adv:"
-	       "Unable to allocate memory for mesh information structures: "
+	pr_err("Unable to allocate memory for mesh information structures: "
 	       "out of mem ?\n");
 	deactivate_module();
 end:
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index dc42d44..8513261 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -86,10 +86,13 @@
 /*
  * Debug Messages
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt /* Append 'batman-adv: ' before
+					     * kernel messages */
 
 #define DBG_BATMAN 1	/* all messages related to routing / flooding /
 			 * broadcasting / etc */
 #define DBG_ROUTES 2	/* route or hna added / changed / deleted */
+#define DBG_ALL 3
 
 #define LOG_BUF_LEN 8192          /* has to be a power of 2 */
 
@@ -171,4 +174,26 @@ static inline void bat_dbg(char type __attribute__((unused)),
 }
 #endif
 
+#define bat_warning(net_dev, fmt, arg...)				\
+	do {								\
+		struct net_device *_netdev = (net_dev);                 \
+		struct bat_priv *_batpriv = netdev_priv(_netdev);       \
+		bat_dbg(DBG_ALL, _batpriv, fmt, ## arg);		\
+		pr_warning("%s: " fmt, _netdev->name, ## arg);		\
+	} while (0)
+#define bat_info(net_dev, fmt, arg...)					\
+	do {								\
+		struct net_device *_netdev = (net_dev);                 \
+		struct bat_priv *_batpriv = netdev_priv(_netdev);       \
+		bat_dbg(DBG_ALL, _batpriv, fmt, ## arg);		\
+		pr_info("%s: " fmt, _netdev->name, ## arg);		\
+	} while (0)
+#define bat_err(net_dev, fmt, arg...)					\
+	do {								\
+		struct net_device *_netdev = (net_dev);                 \
+		struct bat_priv *_batpriv = netdev_priv(_netdev);       \
+		bat_dbg(DBG_ALL, _batpriv, fmt, ## arg);		\
+		pr_err("%s: " fmt, _netdev->name, ## arg);		\
+	} while (0)
+
 #endif /* _NET_BATMAN_ADV_MAIN_H_ */
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 3febdb8..d2a5f20 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -167,8 +167,8 @@ struct orig_node *get_orig_node(uint8_t *addr)
 		swaphash = hash_resize(orig_hash, orig_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR
-			       "batman-adv:Couldn't resize orig hash table\n");
+			bat_err(soft_device,
+				"Couldn't resize orig hash table\n");
 		else
 			orig_hash = swaphash;
 	}
@@ -357,8 +357,7 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 	data_ptr = kmalloc(max_if_num * sizeof(TYPE_OF_WORD) * NUM_WORDS,
 			   GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -369,8 +368,7 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -419,8 +417,7 @@ static int orig_node_del_if(struct orig_node *orig_node,
 	chunk_size = sizeof(TYPE_OF_WORD) * NUM_WORDS;
 	data_ptr = kmalloc(max_if_num * chunk_size, GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -441,8 +438,7 @@ free_bcast_own:
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 418ae09..066cc91 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -859,10 +859,9 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 
 	/* send TTL exceeded if packet is an echo request (traceroute) */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
-		printk(KERN_WARNING "batman-adv:"
-		       "Warning - can't forward icmp packet from %pM to %pM: "
-		       "ttl exceeded\n",
-		       icmp_packet->orig, icmp_packet->dst);
+		pr_warning("Warning - can't forward icmp packet from %pM to "
+			   "%pM: ttl exceeded\n", icmp_packet->orig,
+			   icmp_packet->dst);
 		return NET_RX_DROP;
 	}
 
@@ -1134,10 +1133,9 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
-		printk(KERN_WARNING "batman-adv:Warning - "
-		       "can't forward unicast packet from %pM to %pM: "
-		       "ttl exceeded\n",
-		       ethhdr->h_source, unicast_packet->dest);
+		pr_warning("Warning - can't forward unicast packet from %pM to "
+			   "%pM: ttl exceeded\n", ethhdr->h_source,
+			   unicast_packet->dest);
 		return NET_RX_DROP;
 	}
 
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index 8e8c0b6..055edee 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -68,10 +68,8 @@ int send_skb_packet(struct sk_buff *skb,
 		goto send_skb_err;
 
 	if (!(batman_if->net_dev->flags & IFF_UP)) {
-		printk(KERN_WARNING
-		       "batman-adv:Interface %s "
-		       "is not up - can't send packet via that interface!\n",
-		       batman_if->dev);
+		pr_warning("Interface %s is not up - can't send packet via "
+			   "that interface!\n", batman_if->dev);
 		goto send_skb_err;
 	}
 
@@ -190,8 +188,8 @@ static void send_packet(struct forw_packet *forw_packet)
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
 
 	if (!forw_packet->if_incoming) {
-		printk(KERN_ERR "batman-adv: Error - can't forward packet: "
-		       "incoming iface not specified\n");
+		pr_err("Error - can't forward packet: incoming iface not "
+		       "specified\n");
 		return;
 	}
 
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index 992fc7c..b233377 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -116,8 +116,7 @@ void hna_local_add(uint8_t *addr)
 				       hna_local_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR "batman-adv:"
-			       "Couldn't resize local hna hash table\n");
+			pr_err("Couldn't resize local hna hash table\n");
 		else
 			hna_local_hash = swaphash;
 	}
@@ -372,8 +371,7 @@ void hna_global_add_orig(struct orig_node *orig_node,
 				       hna_global_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR "batman-adv:"
-			       "Couldn't resize global hna hash table\n");
+			pr_err("Couldn't resize global hna hash table\n");
 		else
 			hna_global_hash = swaphash;
 	}
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index ddee0f2..4b6a504 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -678,7 +678,7 @@ static void send_vis_packet(struct vis_info *info)
 	int packet_length;
 
 	if (info->packet.ttl < 2) {
-		printk(KERN_WARNING "batman-adv: Error - can't send vis packet: ttl exceeded\n");
+		pr_warning("Error - can't send vis packet: ttl exceeded\n");
 		return;
 	}
 
@@ -740,13 +740,13 @@ int vis_init(void)
 
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
 
@@ -767,8 +767,7 @@ int vis_init(void)
 	memcpy(my_vis_info->packet.sender_orig, main_if_addr, ETH_ALEN);
 
 	if (hash_add(vis_hash, my_vis_info) < 0) {
-		printk(KERN_ERR
-		       "batman-adv:Can't add own vis packet into hash\n");
+		pr_err("Can't add own vis packet into hash\n");
 		/* not in hash, need to remove it manually. */
 		kref_put(&my_vis_info->refcount, free_info);
 		goto err;
-- 
1.7.1

