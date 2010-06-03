Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu,  3 Jun 2010 17:53:13 +0200
Message-Id: <1275580393-8071-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1275509466.23599.43.camel@Joe-Laptop.home>
References: <1275509466.23599.43.camel@Joe-Laptop.home>
Subject: [B.A.T.M.A.N.] [PATCH-trunk] batman-adv: Use (pr|netdev)_<level>
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
 This version is just for trunk because I haven't checked if it really works.
 (not on 2.6.34 nor on 2.6.21).

 batman-adv-kernelland/aggregation.c       |    2 +
 batman-adv-kernelland/bat_debugfs.c       |    6 ++-
 batman-adv-kernelland/bat_sysfs.c         |   68 ++++++++++++++++------------
 batman-adv-kernelland/bitarray.c          |    2 +
 batman-adv-kernelland/compat.h            |   32 +++++++++++++
 batman-adv-kernelland/gateway_client.c    |    2 +
 batman-adv-kernelland/gateway_common.c    |   54 ++++++++++-------------
 batman-adv-kernelland/hard-interface.c    |   31 +++++--------
 batman-adv-kernelland/icmp_socket.c       |   11 +++--
 batman-adv-kernelland/main.c              |   17 +++----
 batman-adv-kernelland/main.h              |   18 ++++---
 batman-adv-kernelland/originator.c        |   17 +++----
 batman-adv-kernelland/routing.c           |   14 +++---
 batman-adv-kernelland/send.c              |   11 ++---
 batman-adv-kernelland/translation-table.c |    8 ++--
 batman-adv-kernelland/vis.c               |   11 +++--
 16 files changed, 168 insertions(+), 136 deletions(-)

diff --git a/batman-adv-kernelland/aggregation.c b/batman-adv-kernelland/aggregation.c
index 61b6192..2c3c2a1 100644
--- a/batman-adv-kernelland/aggregation.c
+++ b/batman-adv-kernelland/aggregation.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "aggregation.h"
 #include "send.h"
diff --git a/batman-adv-kernelland/bat_debugfs.c b/batman-adv-kernelland/bat_debugfs.c
index bc1591f..cf2545a 100644
--- a/batman-adv-kernelland/bat_debugfs.c
+++ b/batman-adv-kernelland/bat_debugfs.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/debugfs.h>
 
 #include "main.h"
@@ -130,8 +132,8 @@ int debugfs_add_meshif(struct net_device *dev)
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
diff --git a/batman-adv-kernelland/bat_sysfs.c b/batman-adv-kernelland/bat_sysfs.c
index 180023e..0832200 100644
--- a/batman-adv-kernelland/bat_sysfs.c
+++ b/batman-adv-kernelland/bat_sysfs.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "bat_sysfs.h"
 #include "translation-table.h"
@@ -70,18 +72,20 @@ static ssize_t store_aggr_ogms(struct kobject *kobj, struct attribute *attr,
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
@@ -125,17 +129,16 @@ static ssize_t store_bond(struct kobject *kobj, struct attribute *attr,
 		if (buff[count - 1] == '\n')
 			buff[count - 1] = '\0';
 
-		printk(KERN_ERR "batman-adv:Invalid parameter for 'bonding' setting on mesh %s received: %s\n",
-		       net_dev->name, buff);
+		netdev_info(net_dev, "Invalid parameter for 'bonding' setting"
+			    "on mesh received: %s\n", buff);
 		return -EINVAL;
 	}
 
 	if (atomic_read(&bat_priv->bonding_mode) == bonding_mode_tmp)
 		return count;
 
-	printk(KERN_INFO "batman-adv:Changing bonding from: %d to: %d on mesh: %s\n",
-	       atomic_read(&bat_priv->bonding_mode), bonding_mode_tmp,
-	       net_dev->name);
+	netdev_info(net_dev, "Changing bonding from: %d to: %d on mesh\n",
+		    atomic_read(&bat_priv->bonding_mode), bonding_mode_tmp);
 
 	atomic_set(&bat_priv->bonding_mode, (unsigned)bonding_mode_tmp);
 	return count;
@@ -177,18 +180,20 @@ static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
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
@@ -259,23 +264,27 @@ static ssize_t store_orig_interval(struct kobject *kobj, struct attribute *attr,
 
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
@@ -322,7 +331,7 @@ int sysfs_add_meshif(struct net_device *dev)
 	bat_priv->mesh_obj = kobject_create_and_add(SYSFS_IF_MESH_SUBDIR,
 						    batif_kobject);
 	if (!bat_priv->mesh_obj) {
-		printk(KERN_ERR "batman-adv:Can't add sysfs directory: %s/%s\n",
+		pr_err("Can't add sysfs directory: %s/%s\n",
 		       dev->name, SYSFS_IF_MESH_SUBDIR);
 		goto out;
 	}
@@ -331,7 +340,7 @@ int sysfs_add_meshif(struct net_device *dev)
 		err = sysfs_create_file(bat_priv->mesh_obj,
 					&((*bat_attr)->attr));
 		if (err) {
-			printk(KERN_ERR "batman-adv:Can't add sysfs file: %s/%s/%s\n",
+			pr_err("Can't add sysfs file: %s/%s/%s\n",
 			       dev->name, SYSFS_IF_MESH_SUBDIR,
 			       ((*bat_attr)->attr).name);
 			goto rem_attr;
@@ -398,7 +407,8 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
 		if (buff[count - 1] == '\n')
 			buff[count - 1] = '\0';
 
-		printk(KERN_ERR "batman-adv:Invalid parameter for 'mesh_iface' setting received: %s\n",
+		pr_err("Invalid parameter for 'mesh_iface' setting received: "
+		       "%s\n",
 		       buff);
 		return -EINVAL;
 	}
@@ -461,7 +471,7 @@ int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
 						    hardif_kobject);
 
 	if (!*hardif_obj) {
-		printk(KERN_ERR "batman-adv:Can't add sysfs directory: %s/%s\n",
+		pr_err("Can't add sysfs directory: %s/%s\n",
 		       dev->name, SYSFS_IF_BAT_SUBDIR);
 		goto out;
 	}
@@ -469,7 +479,7 @@ int sysfs_add_hardif(struct kobject **hardif_obj, struct net_device *dev)
 	for (bat_attr = batman_attrs; *bat_attr; ++bat_attr) {
 		err = sysfs_create_file(*hardif_obj, &((*bat_attr)->attr));
 		if (err) {
-			printk(KERN_ERR "batman-adv:Can't add sysfs file: %s/%s/%s\n",
+			pr_err("Can't add sysfs file: %s/%s/%s\n",
 			       dev->name, SYSFS_IF_BAT_SUBDIR,
 			       ((*bat_attr)->attr).name);
 			goto rem_attr;
diff --git a/batman-adv-kernelland/bitarray.c b/batman-adv-kernelland/bitarray.c
index a607827..ac9ae97 100644
--- a/batman-adv-kernelland/bitarray.c
+++ b/batman-adv-kernelland/bitarray.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "bitarray.h"
 
diff --git a/batman-adv-kernelland/compat.h b/batman-adv-kernelland/compat.h
index 614d116..e9a0a20 100644
--- a/batman-adv-kernelland/compat.h
+++ b/batman-adv-kernelland/compat.h
@@ -74,6 +74,19 @@ static inline int skb_clone_writable(struct sk_buff *skb, unsigned int len)
 
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
@@ -244,3 +257,22 @@ static inline struct net_device_stats *dev_get_stats(struct net_device *dev)
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
diff --git a/batman-adv-kernelland/gateway_client.c b/batman-adv-kernelland/gateway_client.c
index 552ef6f..d975d15 100644
--- a/batman-adv-kernelland/gateway_client.c
+++ b/batman-adv-kernelland/gateway_client.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "gateway_client.h"
 #include "gateway_common.h"
diff --git a/batman-adv-kernelland/gateway_common.c b/batman-adv-kernelland/gateway_common.c
index 270cf3d..09b76bc 100644
--- a/batman-adv-kernelland/gateway_common.c
+++ b/batman-adv-kernelland/gateway_common.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "gateway_common.h"
 #include "gateway_client.h"
@@ -87,16 +89,14 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 	case GW_MODE_CLIENT:
 		ret = strict_strtoul(tokptr, 10, gw_class_tmp);
 		if (ret) {
-			printk(KERN_ERR "batman-adv: "
-			       "Client class of gateway mode invalid: %s\n",
+			pr_err("Client class of gateway mode invalid: %s\n",
 			       tokptr);
 			return false;
 		}
 
 		if (*gw_class_tmp > TQ_MAX_VALUE) {
-			printk(KERN_ERR "batman-adv: Client class of gateway "
-					"mode greater than %i: %ld\n",
-					TQ_MAX_VALUE, *gw_class_tmp);
+			pr_err("Client class of gateway mode greater than "
+			       "%i: %ld\n", TQ_MAX_VALUE, *gw_class_tmp);
 			return false;
 		}
 
@@ -121,8 +121,7 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 
 		ret = strict_strtoul(tokptr, 10, down);
 		if (ret) {
-			printk(KERN_ERR "batman-adv: "
-			       "Download speed of gateway mode invalid: %s\n",
+			pr_err("Download speed of gateway mode invalid: %s\n",
 			       tokptr);
 			return false;
 		}
@@ -147,9 +146,8 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 
 			ret = strict_strtoul(slash_ptr + 1, 10, up);
 			if (ret) {
-				printk(KERN_ERR "batman-adv: Upload speed of "
-				       "gateway mode invalid: %s\n",
-				       slash_ptr + 1);
+				pr_err("Upload speed of gateway mode invalid: "
+				       "%s\n", slash_ptr + 1);
 				return false;
 			}
 
@@ -217,11 +215,10 @@ next:
 	}
 
 	if (!gw_mode_tmp_str) {
-		printk(KERN_INFO "batman-adv: "
-		       "Gateway mode can only be set to: '%s', '%s' or '%s' - "
-		       "given value: %s\n",
-		       GW_MODE_OFF_NAME, GW_MODE_CLIENT_NAME,
-		       GW_MODE_SERVER_NAME, buff);
+		pr_info("Gateway mode can only be set to: '%s', '%s' or '%s' - "
+			"given value: %s\n",
+			GW_MODE_OFF_NAME, GW_MODE_CLIENT_NAME,
+			GW_MODE_SERVER_NAME, buff);
 		goto end;
 	}
 
@@ -242,10 +239,9 @@ next:
 		if ((gw_mode_tmp == GW_MODE_CLIENT) && (!gw_class_tmp))
 			gw_class_tmp = 20;
 
-		printk(KERN_INFO "batman-adv: "
-		       "Changing gateway mode from: '%s' to: '%s' "
-		       "(gw_class: %ld)\n",
-		       gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp);
+		pr_info("Changing gateway mode from: '%s' to: '%s' "
+			"(gw_class: %ld)\n",
+			gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp);
 		break;
 	case GW_MODE_SERVER:
 		if (!down)
@@ -265,19 +261,17 @@ next:
 				     (int *)&down, (int *)&up);
 
 		gw_deselect();
-		printk(KERN_INFO
-		       "batman-adv: Changing gateway mode from: '%s' to: '%s' "
-		       "(gw_class: %ld -> propagating: %ld%s/%ld%s)\n",
-		       gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp,
-		       (down > 2048 ? down / 1024 : down),
-		       (down > 2048 ? "MBit" : "KBit"),
-		       (up > 2048 ? up / 1024 : up),
-		       (up > 2048 ? "MBit" : "KBit"));
+		pr_info("Changing gateway mode from: '%s' to: '%s' "
+			"(gw_class: %ld -> propagating: %ld%s/%ld%s)\n",
+			gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp,
+			(down > 2048 ? down / 1024 : down),
+			(down > 2048 ? "MBit" : "KBit"),
+			(up > 2048 ? up / 1024 : up),
+			(up > 2048 ? "MBit" : "KBit"));
 		break;
 	default:
-		printk(KERN_INFO "batman-adv: "
-			  "Changing gateway mode from: '%s' to: '%s'\n",
-			  gw_mode_curr_str, gw_mode_tmp_str);
+		pr_info("Changing gateway mode from: '%s' to: '%s'\n",
+			gw_mode_curr_str, gw_mode_tmp_str);
 		break;
 	}
 
diff --git a/batman-adv-kernelland/hard-interface.c b/batman-adv-kernelland/hard-interface.c
index ad2e496..9c637b0 100644
--- a/batman-adv-kernelland/hard-interface.c
+++ b/batman-adv-kernelland/hard-interface.c
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
diff --git a/batman-adv-kernelland/icmp_socket.c b/batman-adv-kernelland/icmp_socket.c
index 08cca22..d75e8af 100644
--- a/batman-adv-kernelland/icmp_socket.c
+++ b/batman-adv-kernelland/icmp_socket.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/debugfs.h>
 #include <linux/slab.h>
 #include "main.h"
@@ -60,8 +62,7 @@ static int bat_socket_open(struct inode *inode, struct file *file)
 	}
 
 	if (i == ARRAY_SIZE(socket_client_hash)) {
-		printk(KERN_ERR "batman-adv:"
-		       "Error - can't add another packet client: "
+		pr_err("Error - can't add another packet client: "
 		       "maximum number of clients reached\n");
 		kfree(socket_client);
 		return -EXFULL;
@@ -166,7 +167,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	unsigned long flags;
 
 	if (len < sizeof(struct icmp_packet)) {
-		bat_dbg(DBG_BATMAN, "batman-adv:"
+		bat_dbg(DBG_BATMAN,
 			"Error - can't send packet from char device: "
 			"invalid packet size\n");
 		return -EINVAL;
@@ -182,14 +183,14 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
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
diff --git a/batman-adv-kernelland/main.c b/batman-adv-kernelland/main.c
index 20a0d54..0b14f07 100644
--- a/batman-adv-kernelland/main.c
+++ b/batman-adv-kernelland/main.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "bat_sysfs.h"
 #include "bat_debugfs.h"
@@ -94,16 +96,14 @@ int init_module(void)
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
 
@@ -120,9 +120,8 @@ int init_module(void)
 	register_netdevice_notifier(&hard_if_notifier);
 	dev_add_pack(&batman_adv_packet_type);
 
-	printk(KERN_INFO "batman-adv:"
-	       "B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded\n",
-	       SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
+	pr_info("B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded\n",
+		SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
 
 	return 0;
 
@@ -182,9 +181,7 @@ void activate_module(void)
 	goto end;
 
 err:
-	printk(KERN_ERR "batman-adv:"
-	       "Unable to allocate memory for mesh information structures: "
-	       "out of mem ?\n");
+	pr_err("Unable to allocate memory for mesh information structures: out of mem ?\n");
 	deactivate_module();
 end:
 	return;
diff --git a/batman-adv-kernelland/main.h b/batman-adv-kernelland/main.h
index e2b086b..f5dbe78 100644
--- a/batman-adv-kernelland/main.h
+++ b/batman-adv-kernelland/main.h
@@ -96,15 +96,17 @@
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
diff --git a/batman-adv-kernelland/originator.c b/batman-adv-kernelland/originator.c
index 28e35b6..c86a92d 100644
--- a/batman-adv-kernelland/originator.c
+++ b/batman-adv-kernelland/originator.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 /* increase the reference counter for this originator */
 
 #include "main.h"
@@ -165,8 +167,7 @@ struct orig_node *get_orig_node(uint8_t *addr)
 		swaphash = hash_resize(orig_hash, orig_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR
-			       "batman-adv:Couldn't resize orig hash table\n");
+			pr_err("Couldn't resize orig hash table\n");
 		else
 			orig_hash = swaphash;
 	}
@@ -360,8 +361,7 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 	data_ptr = kmalloc(max_if_num * sizeof(TYPE_OF_WORD) * NUM_WORDS,
 			   GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -372,8 +372,7 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -422,8 +421,7 @@ static int orig_node_del_if(struct orig_node *orig_node,
 	chunk_size = sizeof(TYPE_OF_WORD) * NUM_WORDS;
 	data_ptr = kmalloc(max_if_num * chunk_size, GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -444,8 +442,7 @@ free_bcast_own:
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index 62699ca..3ff0c67 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "routing.h"
 #include "send.h"
@@ -863,10 +865,8 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 
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
 
@@ -1138,10 +1138,8 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
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
 
diff --git a/batman-adv-kernelland/send.c b/batman-adv-kernelland/send.c
index 8df44a6..fcfa639 100644
--- a/batman-adv-kernelland/send.c
+++ b/batman-adv-kernelland/send.c
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
 
diff --git a/batman-adv-kernelland/translation-table.c b/batman-adv-kernelland/translation-table.c
index 8edc175..e4c5055 100644
--- a/batman-adv-kernelland/translation-table.c
+++ b/batman-adv-kernelland/translation-table.c
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
diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
index 68ee903..8308ce2 100644
--- a/batman-adv-kernelland/vis.c
+++ b/batman-adv-kernelland/vis.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include "main.h"
 #include "send.h"
 #include "translation-table.h"
@@ -679,7 +681,7 @@ static void send_vis_packet(struct vis_info *info)
 	int packet_length;
 
 	if (info->packet.ttl < 2) {
-		printk(KERN_WARNING "batman-adv: Error - can't send vis packet: ttl exceeded\n");
+		pr_warning("Error - can't send vis packet: ttl exceeded\n");
 		return;
 	}
 
@@ -741,13 +743,13 @@ int vis_init(void)
 
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
 
@@ -768,8 +770,7 @@ int vis_init(void)
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

