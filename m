Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 23 Jun 2010 22:00:13 +0200
Message-Id: <1277323213-26460-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1277307412-27661-1-git-send-email-sven.eckelmann@gmx.de>
References: <1277307412-27661-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Move printk to simplified
	macros
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
This patch replaces the slightly different named patch
"Move printk to pr_* macros". It should provide the needed information to get
the private information of each batX device and print those informations also
in the private debugfs log. There are ~18 pr_* which may or may not suitable
for bat_

 batman-adv/bat_debugfs.c       |    7 ++-
 batman-adv/bat_sysfs.c         |   81 ++++++++++++++++++++--------------------
 batman-adv/compat.h            |   13 ++++++
 batman-adv/gateway_common.c    |   69 ++++++++++++++++------------------
 batman-adv/gateway_common.h    |    2 +-
 batman-adv/hard-interface.c    |   49 +++++++++++-------------
 batman-adv/icmp_socket.c       |    5 +-
 batman-adv/main.c              |   15 +++----
 batman-adv/main.h              |    9 ++++
 batman-adv/originator.c        |   16 +++-----
 batman-adv/routing.c           |   14 +++----
 batman-adv/send.c              |   10 ++---
 batman-adv/translation-table.c |    6 +--
 batman-adv/vis.c               |    9 ++--
 14 files changed, 152 insertions(+), 153 deletions(-)

diff --git a/batman-adv/bat_debugfs.c b/batman-adv/bat_debugfs.c
index 6fe2900..b0dfc2a 100644
--- a/batman-adv/bat_debugfs.c
+++ b/batman-adv/bat_debugfs.c
@@ -19,9 +19,10 @@
  *
  */
 
+#include "main.h"
+
 #include <linux/debugfs.h>
 
-#include "main.h"
 #include "bat_debugfs.h"
 #include "translation-table.h"
 #include "originator.h"
@@ -132,8 +133,8 @@ int debugfs_add_meshif(struct net_device *dev)
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
diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index 68ce453..dae1ced 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -70,18 +70,19 @@ static ssize_t store_aggr_ogms(struct kobject *kobj, struct attribute *attr,
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
@@ -118,19 +119,19 @@ static ssize_t store_bond(struct kobject *kobj, struct attribute *attr,
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
@@ -172,18 +173,19 @@ static ssize_t store_vis_mode(struct kobject *kobj, struct attribute *attr,
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
@@ -228,9 +230,8 @@ static ssize_t store_gw_mode(struct kobject *kobj, struct attribute *attr,
 {
 	struct device *dev = to_dev(kobj->parent);
 	struct net_device *net_dev = to_net_dev(dev);
-	struct bat_priv *bat_priv = netdev_priv(net_dev);
 
-	return gw_mode_set(bat_priv, buff, count);
+	return gw_mode_set(net_dev, buff, count);
 }
 
 static ssize_t show_orig_interval(struct kobject *kobj, struct attribute *attr,
@@ -254,23 +255,23 @@ static ssize_t store_orig_interval(struct kobject *kobj, struct attribute *attr,
 
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
diff --git a/batman-adv/compat.h b/batman-adv/compat.h
index 8302a58..58ae850 100644
--- a/batman-adv/compat.h
+++ b/batman-adv/compat.h
@@ -60,6 +60,19 @@ static inline int skb_clone_writable(struct sk_buff *skb, unsigned int len)
 
 #endif /* < KERNEL_VERSION(2, 6, 23) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 24)
+
+#ifndef pr_fmt
+#define pr_fmt(fmt) fmt
+#endif
+
+#define pr_err(fmt, ...) \
+       printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_warning(fmt, ...) \
+       printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
+
+#endif /* < KERNEL_VERSION(2, 6, 24) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 25)
 
 #define strict_strtoul(cp, base, res) \
diff --git a/batman-adv/gateway_common.c b/batman-adv/gateway_common.c
index 270cf3d..06bdd75 100644
--- a/batman-adv/gateway_common.c
+++ b/batman-adv/gateway_common.c
@@ -76,7 +76,8 @@ void gw_srv_class_to_kbit(uint8_t gw_srv_class, int *down, int *up)
 	*up = ((upart + 1) * (*down)) / 8;
 }
 
-static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
+static bool parse_gw_mode_tok(struct net_device *net_dev,
+			      char *tokptr, long *gw_mode_tmp,
 			      char **gw_mode_tmp_str, long *gw_class_tmp,
 			      long *up, long *down)
 {
@@ -87,16 +88,15 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 	case GW_MODE_CLIENT:
 		ret = strict_strtoul(tokptr, 10, gw_class_tmp);
 		if (ret) {
-			printk(KERN_ERR "batman-adv: "
-			       "Client class of gateway mode invalid: %s\n",
-			       tokptr);
+			bat_err(net_dev, "Client class of gateway mode invalid:"
+				" %s\n", tokptr);
 			return false;
 		}
 
 		if (*gw_class_tmp > TQ_MAX_VALUE) {
-			printk(KERN_ERR "batman-adv: Client class of gateway "
-					"mode greater than %i: %ld\n",
-					TQ_MAX_VALUE, *gw_class_tmp);
+			bat_err(net_dev,
+				"Client class of gateway mode greater than %i: "
+				"%ld\n", TQ_MAX_VALUE, *gw_class_tmp);
 			return false;
 		}
 
@@ -121,9 +121,9 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 
 		ret = strict_strtoul(tokptr, 10, down);
 		if (ret) {
-			printk(KERN_ERR "batman-adv: "
-			       "Download speed of gateway mode invalid: %s\n",
-			       tokptr);
+			bat_err(net_dev,
+				"Download speed of gateway mode invalid: %s\n",
+				tokptr);
 			return false;
 		}
 
@@ -147,9 +147,9 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 
 			ret = strict_strtoul(slash_ptr + 1, 10, up);
 			if (ret) {
-				printk(KERN_ERR "batman-adv: Upload speed of "
-				       "gateway mode invalid: %s\n",
-				       slash_ptr + 1);
+				bat_err(net_dev,
+					"Upload speed of gateway mode invalid: "
+					"%s\n", slash_ptr + 1);
 				return false;
 			}
 
@@ -177,13 +177,14 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 	return true;
 }
 
-ssize_t gw_mode_set(struct bat_priv *bat_priv, char *buff, size_t count)
+ssize_t gw_mode_set(struct net_device *net_dev, char *buff, size_t count)
 {
 	char *tokptr, *cp, finished;
 	char *gw_mode_curr_str, *gw_mode_tmp_str = NULL;
 	long gw_mode_curr, gw_mode_tmp = GW_MODE_OFF;
 	long gw_class_tmp = 0, up = 0, down = 0;
 	bool ret;
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
 
 	tokptr = buff;
 	gw_mode_curr = atomic_read(&bat_priv->gw_mode);
@@ -200,9 +201,8 @@ ssize_t gw_mode_set(struct bat_priv *bat_priv, char *buff, size_t count)
 			if (strlen(tokptr) == 0)
 				goto next;
 
-			ret = parse_gw_mode_tok(tokptr, &gw_mode_tmp,
-						&gw_mode_tmp_str,
-						&gw_class_tmp,
+			ret = parse_gw_mode_tok(net_dev, tokptr, &gw_mode_tmp,
+						&gw_mode_tmp_str, &gw_class_tmp,
 						&up, &down);
 
 			if (!ret)
@@ -217,11 +217,9 @@ next:
 	}
 
 	if (!gw_mode_tmp_str) {
-		printk(KERN_INFO "batman-adv: "
-		       "Gateway mode can only be set to: '%s', '%s' or '%s' - "
-		       "given value: %s\n",
-		       GW_MODE_OFF_NAME, GW_MODE_CLIENT_NAME,
-		       GW_MODE_SERVER_NAME, buff);
+		bat_info(net_dev, "Gateway mode can only be set to: '%s', '%s' "
+			 "or '%s' - given value: %s\n", GW_MODE_OFF_NAME,
+			 GW_MODE_CLIENT_NAME, GW_MODE_SERVER_NAME, buff);
 		goto end;
 	}
 
@@ -242,10 +240,9 @@ next:
 		if ((gw_mode_tmp == GW_MODE_CLIENT) && (!gw_class_tmp))
 			gw_class_tmp = 20;
 
-		printk(KERN_INFO "batman-adv: "
-		       "Changing gateway mode from: '%s' to: '%s' "
-		       "(gw_class: %ld)\n",
-		       gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp);
+		bat_info(net_dev, "Changing gateway mode from: '%s' to: '%s' "
+			 "(gw_class: %ld)\n",
+			 gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp);
 		break;
 	case GW_MODE_SERVER:
 		if (!down)
@@ -265,19 +262,17 @@ next:
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
+		bat_info(net_dev, "Changing gateway mode from: '%s' to: '%s' "
+			 "(gw_class: %ld -> propagating: %ld%s/%ld%s)\n",
+			 gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp,
+			 (down > 2048 ? down / 1024 : down),
+			 (down > 2048 ? "MBit" : "KBit"),
+			 (up > 2048 ? up / 1024 : up),
+			 (up > 2048 ? "MBit" : "KBit"));
 		break;
 	default:
-		printk(KERN_INFO "batman-adv: "
-			  "Changing gateway mode from: '%s' to: '%s'\n",
-			  gw_mode_curr_str, gw_mode_tmp_str);
+		bat_info(net_dev, "Changing gateway mode from: '%s' to: '%s'\n",
+			 gw_mode_curr_str, gw_mode_tmp_str);
 		break;
 	}
 
diff --git a/batman-adv/gateway_common.h b/batman-adv/gateway_common.h
index b88eb50..c85e2bf 100644
--- a/batman-adv/gateway_common.h
+++ b/batman-adv/gateway_common.h
@@ -30,4 +30,4 @@ enum gw_modes {
 #define GW_MODE_SERVER_NAME	"server"
 
 void gw_srv_class_to_kbit(uint8_t gw_class, int *down, int *up);
-ssize_t gw_mode_set(struct bat_priv *bat_priv, char *buff, size_t count);
+ssize_t gw_mode_set(struct net_device *net_dev, char *buff, size_t count);
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 0773420..a7569d9 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -152,12 +152,10 @@ static void check_known_mac_addr(uint8_t *addr)
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
@@ -191,7 +189,8 @@ void update_min_mtu(void)
 		soft_device->mtu = min_mtu;
 }
 
-static void hardif_activate_interface(struct bat_priv *bat_priv,
+static void hardif_activate_interface(struct net_device *net_dev,
+				      struct bat_priv *bat_priv,
 				      struct batman_if *batman_if)
 {
 	if (batman_if->if_status != IF_INACTIVE)
@@ -209,8 +208,7 @@ static void hardif_activate_interface(struct bat_priv *bat_priv,
 	if (!bat_priv->primary_if)
 		set_primary_if(bat_priv, batman_if);
 
-	printk(KERN_INFO "batman-adv:Interface activated: %s\n",
-	       batman_if->dev);
+	bat_info(net_dev, "Interface activated: %s\n", batman_if->dev);
 
 	if (atomic_read(&module_state) == MODULE_INACTIVE)
 		activate_module();
@@ -219,7 +217,8 @@ static void hardif_activate_interface(struct bat_priv *bat_priv,
 	return;
 }
 
-static void hardif_deactivate_interface(struct batman_if *batman_if)
+static void hardif_deactivate_interface(struct net_device *net_dev,
+					struct batman_if *batman_if)
 {
 	if ((batman_if->if_status != IF_ACTIVE) &&
 	   (batman_if->if_status != IF_TO_BE_ACTIVATED))
@@ -229,8 +228,7 @@ static void hardif_deactivate_interface(struct batman_if *batman_if)
 
 	batman_if->if_status = IF_INACTIVE;
 
-	printk(KERN_INFO "batman-adv:Interface deactivated: %s\n",
-	       batman_if->dev);
+	bat_info(net_dev, "Interface deactivated: %s\n", batman_if->dev);
 
 	update_min_mtu();
 }
@@ -248,9 +246,8 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	batman_if->packet_buff = kmalloc(batman_if->packet_len, GFP_ATOMIC);
 
 	if (!batman_if->packet_buff) {
-		printk(KERN_ERR "batman-adv:"
-		       "Can't add interface packet (%s): out of memory\n",
-		       batman_if->dev);
+		bat_err(soft_device, "Can't add interface packet (%s): "
+			"out of memory\n", batman_if->dev);
 		goto err;
 	}
 
@@ -268,15 +265,14 @@ int hardif_enable_interface(struct batman_if *batman_if)
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
@@ -294,12 +290,12 @@ void hardif_disable_interface(struct batman_if *batman_if)
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
 
@@ -326,8 +322,7 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 
 	batman_if = kmalloc(sizeof(struct batman_if), GFP_ATOMIC);
 	if (!batman_if) {
-		printk(KERN_ERR "batman-adv:"
-		       "Can't add interface (%s): out of memory\n",
+		pr_err("Can't add interface (%s): out of memory\n",
 		       net_dev->name);
 		goto out;
 	}
@@ -410,11 +405,11 @@ static int hard_if_event(struct notifier_block *this,
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
diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index 08cca22..edc0f91 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
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
@@ -60,8 +60,7 @@ static int bat_socket_open(struct inode *inode, struct file *file)
 	}
 
 	if (i == ARRAY_SIZE(socket_client_hash)) {
-		printk(KERN_ERR "batman-adv:"
-		       "Error - can't add another packet client: "
+		pr_err("Error - can't add another packet client: "
 		       "maximum number of clients reached\n");
 		kfree(socket_client);
 		return -EXFULL;
diff --git a/batman-adv/main.c b/batman-adv/main.c
index dec1607..e3d4766 100644
--- a/batman-adv/main.c
+++ b/batman-adv/main.c
@@ -94,16 +94,14 @@ int init_module(void)
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
 
@@ -120,9 +118,9 @@ int init_module(void)
 	register_netdevice_notifier(&hard_if_notifier);
 	dev_add_pack(&batman_adv_packet_type);
 
-	printk(KERN_INFO "batman-adv:"
-	       "B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded\n",
-	       SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
+	pr_info("B.A.T.M.A.N. advanced %s%s (compatibility version %i) "
+		"loaded\n", SOURCE_VERSION, REVISION_VERSION_STR,
+		COMPAT_VERSION);
 
 	return 0;
 
@@ -182,8 +180,7 @@ void activate_module(void)
 	goto end;
 
 err:
-	printk(KERN_ERR "batman-adv:"
-	       "Unable to allocate memory for mesh information structures: "
+	pr_err("Unable to allocate memory for mesh information structures: "
 	       "out of mem ?\n");
 	deactivate_module();
 end:
diff --git a/batman-adv/main.h b/batman-adv/main.h
index cb17a9c..846bef6 100644
--- a/batman-adv/main.h
+++ b/batman-adv/main.h
@@ -83,6 +83,15 @@
 /*
  * Debug Messages
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt /* Append 'batman-adv: ' before
+					     * kernel messages */
+
+#define bat_warning(net_dev, fmt, arg...) \
+	do { pr_warning("%s: " fmt, (net_dev)->name, ## arg); } while (0)
+#define bat_info(net_dev, fmt, arg...) \
+	do { pr_info("%s: " fmt, (net_dev)->name, ## arg); } while (0)
+#define bat_err(net_dev, fmt, arg...) \
+	do { pr_err("%s: " fmt, (net_dev)->name, ## arg); } while (0)
 
 #define DBG_BATMAN 1	/* all messages related to routing / flooding /
 			 * broadcasting / etc */
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index d276afd..6a29ab5 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -165,8 +165,8 @@ struct orig_node *get_orig_node(uint8_t *addr)
 		swaphash = hash_resize(orig_hash, orig_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR
-			       "batman-adv:Couldn't resize orig hash table\n");
+			bat_err(soft_device,
+				"Couldn't resize orig hash table\n");
 		else
 			orig_hash = swaphash;
 	}
@@ -358,8 +358,7 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 	data_ptr = kmalloc(max_if_num * sizeof(TYPE_OF_WORD) * NUM_WORDS,
 			   GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -370,8 +369,7 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -420,8 +418,7 @@ static int orig_node_del_if(struct orig_node *orig_node,
 	chunk_size = sizeof(TYPE_OF_WORD) * NUM_WORDS;
 	data_ptr = kmalloc(max_if_num * chunk_size, GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -442,8 +439,7 @@ free_bcast_own:
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR
-		       "batman-adv:Can't resize orig: out of memory\n");
+		pr_err("Can't resize orig: out of memory\n");
 		return -1;
 	}
 
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index a37c288..ad8b13f 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -857,10 +857,9 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 
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
 
@@ -1132,10 +1131,9 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
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
 
diff --git a/batman-adv/send.c b/batman-adv/send.c
index 3c0bb7d..8f788ca 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -70,10 +70,8 @@ int send_skb_packet(struct sk_buff *skb,
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
 
@@ -188,8 +186,8 @@ static void send_packet(struct forw_packet *forw_packet)
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
 
 	if (!forw_packet->if_incoming) {
-		printk(KERN_ERR "batman-adv: Error - can't forward packet: "
-		       "incoming iface not specified\n");
+		pr_err("Error - can't forward packet: incoming iface not "
+		       "specified\n");
 		return;
 	}
 
diff --git a/batman-adv/translation-table.c b/batman-adv/translation-table.c
index b969fe7..daa5b02 100644
--- a/batman-adv/translation-table.c
+++ b/batman-adv/translation-table.c
@@ -115,8 +115,7 @@ void hna_local_add(uint8_t *addr)
 				       hna_local_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR "batman-adv:"
-			       "Couldn't resize local hna hash table\n");
+			pr_err("Couldn't resize local hna hash table\n");
 		else
 			hna_local_hash = swaphash;
 	}
@@ -367,8 +366,7 @@ void hna_global_add_orig(struct orig_node *orig_node,
 				       hna_global_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR "batman-adv:"
-			       "Couldn't resize global hna hash table\n");
+			pr_err("Couldn't resize global hna hash table\n");
 		else
 			hna_global_hash = swaphash;
 	}
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index 3832043..5c825b5 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -679,7 +679,7 @@ static void send_vis_packet(struct vis_info *info)
 	int packet_length;
 
 	if (info->packet.ttl < 2) {
-		printk(KERN_WARNING "batman-adv: Error - can't send vis packet: ttl exceeded\n");
+		pr_warning("Error - can't send vis packet: ttl exceeded\n");
 		return;
 	}
 
@@ -741,13 +741,13 @@ int vis_init(void)
 
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
 
@@ -768,8 +768,7 @@ int vis_init(void)
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

