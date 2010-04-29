Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 30 Apr 2010 00:48:52 +0200
Message-Id: <1272581332-27145-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1272551013-8606-2-git-send-email-sven.eckelmann@gmx.de>
References: <1272551013-8606-2-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH-trunk 2/2v2] batman-adv: Reduce max
	characters on a line to 80
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

Documentation/CodingStyle sets a strongly prefered limit of 80
characters per line in "Chapter 2: Breaking long lines and strings".

Strings must be broken into smaller parts and long statements must be
rewritten.

Reported-by: Mikal Sande <mikal.sande@gmail.com>
Reported-by: Mark Rankilor <reodge@gmail.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/bat_sysfs.c         |    3 +-
 batman-adv-kernelland/device.c            |   22 ++++++++---
 batman-adv-kernelland/gateway_client.c    |   28 +++++++++-----
 batman-adv-kernelland/gateway_common.c    |   45 ++++++++++++++--------
 batman-adv-kernelland/hard-interface.c    |   20 +++++++---
 batman-adv-kernelland/main.c              |   17 +++++---
 batman-adv-kernelland/main.h              |    3 +-
 batman-adv-kernelland/originator.c        |   47 ++++++++++++++---------
 batman-adv-kernelland/routing.c           |   58 +++++++++++++++++++++-------
 batman-adv-kernelland/send.c              |   19 ++++++---
 batman-adv-kernelland/translation-table.c |   34 +++++++++++------
 batman-adv-kernelland/types.h             |   58 ++++++++++++++++++++--------
 12 files changed, 239 insertions(+), 115 deletions(-)

diff --git a/batman-adv-kernelland/bat_sysfs.c b/batman-adv-kernelland/bat_sysfs.c
index 43feef5..25193b0 100644
--- a/batman-adv-kernelland/bat_sysfs.c
+++ b/batman-adv-kernelland/bat_sysfs.c
@@ -237,7 +237,8 @@ static ssize_t show_gw_mode(struct kobject *kobj, struct attribute *attr,
 	case GW_MODE_SERVER:
 		gw_srv_class_to_kbit(gw_class, &down, &up);
 		bytes_written = sprintf(buff,
-					"status: %s (gw_class: %i -> propagating: %i%s/%i%s)\n",
+					"status: %s (gw_class: %i "
+					"-> propagating: %i%s/%i%s)\n",
 					GW_MODE_SERVER_NAME, gw_class,
 					(down > 2048 ? down / 1024 : down),
 					(down > 2048 ? "MBit" : "KBit"),
diff --git a/batman-adv-kernelland/device.c b/batman-adv-kernelland/device.c
index c8ec4f9..8a99ea9 100644
--- a/batman-adv-kernelland/device.c
+++ b/batman-adv-kernelland/device.c
@@ -58,7 +58,8 @@ int bat_device_setup(void)
 	/* register our device - kernel assigns a free major number */
 	tmp_major = register_chrdev(0, DRIVER_DEVICE, &fops);
 	if (tmp_major < 0) {
-		printk(KERN_ERR "batman-adv:Registering the character device failed with %d\n",
+		printk(KERN_ERR "batman-adv:"
+		       "Registering the character device failed with %d\n",
 			  tmp_major);
 		return 0;
 	}
@@ -66,7 +67,8 @@ int bat_device_setup(void)
 	batman_class = class_create(THIS_MODULE, "batman-adv");
 
 	if (IS_ERR(batman_class)) {
-		printk(KERN_ERR "batman-adv:Could not register class 'batman-adv'\n");
+		printk(KERN_ERR "batman-adv:"
+		       "Could not register class 'batman-adv'\n");
 		return 0;
 	}
 
@@ -109,7 +111,9 @@ int bat_device_open(struct inode *inode, struct file *file)
 	}
 
 	if (i == ARRAY_SIZE(device_client_hash)) {
-		printk(KERN_ERR "batman-adv:Error - can't add another packet client: maximum number of clients reached\n");
+		printk(KERN_ERR "batman-adv:"
+		       "Error - can't add another packet client: "
+		       "maximum number of clients reached\n");
 		kfree(device_client);
 		return -EXFULL;
 	}
@@ -213,7 +217,9 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 	unsigned long flags;
 
 	if (len < sizeof(struct icmp_packet)) {
-		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from char device: invalid packet size\n");
+		bat_dbg(DBG_BATMAN, "batman-adv:"
+			"Error - can't send packet from char device: "
+			"invalid packet size\n");
 		return -EINVAL;
 	}
 
@@ -227,12 +233,16 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 		return -EFAULT;
 
 	if (icmp_packet.packet_type != BAT_ICMP) {
-		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from char device: got bogus packet type (expected: BAT_ICMP)\n");
+		bat_dbg(DBG_BATMAN, "batman-adv:"
+			"Error - can't send packet from char device: "
+			"got bogus packet type (expected: BAT_ICMP)\n");
 		return -EINVAL;
 	}
 
 	if (icmp_packet.msg_type != ECHO_REQUEST) {
-		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from char device: got bogus message type (expected: ECHO_REQUEST)\n");
+		bat_dbg(DBG_BATMAN, "batman-adv:"
+			"Error - can't send packet from char device: "
+			"got bogus message type (expected: ECHO_REQUEST)\n");
 		return -EINVAL;
 	}
 
diff --git a/batman-adv-kernelland/gateway_client.c b/batman-adv-kernelland/gateway_client.c
index 1f662d8..a5e4f5f 100644
--- a/batman-adv-kernelland/gateway_client.c
+++ b/batman-adv-kernelland/gateway_client.c
@@ -81,7 +81,8 @@ void gw_election(void)
 
 		if (curr_gateway) {
 			bat_dbg(DBG_BATMAN,
-				"Removing selected gateway - no gateway in range\n");
+				"Removing selected gateway - "
+				"no gateway in range\n");
 			gw_deselect();
 		}
 
@@ -137,16 +138,19 @@ void gw_election(void)
 	if (curr_gateway != curr_gw_tmp) {
 		if ((curr_gateway) && (!curr_gw_tmp))
 			bat_dbg(DBG_BATMAN,
-				"Removing selected gateway - no gateway in range\n");
+				"Removing selected gateway - "
+				"no gateway in range\n");
 		else if ((!curr_gateway) && (curr_gw_tmp))
 			bat_dbg(DBG_BATMAN,
-				"Adding route to gateway %pM (gw_flags: %i, tq: %i)\n",
+				"Adding route to gateway %pM "
+				"(gw_flags: %i, tq: %i)\n",
 				curr_gw_tmp->orig_node->orig,
 				curr_gw_tmp->orig_node->gw_flags,
 				curr_gw_tmp->orig_node->router->tq_avg);
 		else
 			bat_dbg(DBG_BATMAN,
-				"Changing route to gateway %pM (gw_flags: %i, tq: %i)\n",
+				"Changing route to gateway %pM "
+				"(gw_flags: %i, tq: %i)\n",
 				curr_gw_tmp->orig_node->orig,
 				curr_gw_tmp->orig_node->gw_flags,
 				curr_gw_tmp->orig_node->router->tq_avg);
@@ -197,7 +201,8 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 		return;
 
 	bat_dbg(DBG_BATMAN,
-		"Restarting gateway selection: better gateway found (tq curr: %i, tq new: %i)\n",
+		"Restarting gateway selection: better gateway found (tq curr: "
+		"%i, tq new: %i)\n",
 		gw_tq_avg, orig_tq_avg);
 
 deselect:
@@ -239,7 +244,8 @@ void gw_node_update(struct orig_node *orig_node, uint8_t new_gwflags)
 			continue;
 
 		bat_dbg(DBG_BATMAN,
-			"Gateway class of originator %pM changed from %i to %i\n",
+			"Gateway class of originator %pM changed from "
+			"%i to %i\n",
 			orig_node->orig, gw_node->orig_node->gw_flags,
 			new_gwflags);
 
@@ -349,7 +355,8 @@ int gw_client_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 		if (off == 0)
 			return sprintf(buff,
-				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
+				       "BATMAN mesh %s disabled - please "
+				       "specify interfaces to enable it\n",
 				       net_dev->name);
 
 		return 0;
@@ -360,14 +367,15 @@ int gw_client_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 		if (off == 0)
 			return sprintf(buff,
-				       "BATMAN mesh %s disabled - primary interface not active\n",
+				       "BATMAN mesh %s disabled - "
+				       "primary interface not active\n",
 				       net_dev->name);
 
 		return 0;
 	}
 
-	hdr_len = sprintf(buff,
-			  "      %-12s (%s/%i) %17s [%10s]: gw_class ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
+	hdr_len = sprintf(buff, "      %-12s (%s/%i) %17s [%10s]: gw_class ... "
+			  "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
 			  "Gateway", "#", TQ_MAX_VALUE, "Nexthop",
 			  "outgoingIF", SOURCE_VERSION, REVISION_VERSION_STR,
 			  bat_priv->primary_if->dev,
diff --git a/batman-adv-kernelland/gateway_common.c b/batman-adv-kernelland/gateway_common.c
index 2cc43f5..d542306 100644
--- a/batman-adv-kernelland/gateway_common.c
+++ b/batman-adv-kernelland/gateway_common.c
@@ -87,13 +87,15 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 	case GW_MODE_CLIENT:
 		ret = strict_strtoul(tokptr, 10, gw_class_tmp);
 		if (ret) {
-			printk(KERN_ERR "batman-adv: Client class of gateway mode invalid: %s\n",
+			printk(KERN_ERR "batman-adv: "
+			       "Client class of gateway mode invalid: %s\n",
 			       tokptr);
 			return false;
 		}
 
 		if (*gw_class_tmp > TQ_MAX_VALUE) {
-			printk(KERN_ERR "batman-adv: Client class of gateway mode greater than %i: %ld\n",
+			printk(KERN_ERR "batman-adv: Client class of gateway "
+					"mode greater than %i: %ld\n",
 					TQ_MAX_VALUE, *gw_class_tmp);
 			return false;
 		}
@@ -119,7 +121,8 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 
 		ret = strict_strtoul(tokptr, 10, down);
 		if (ret) {
-			printk(KERN_ERR "batman-adv: Download speed of gateway mode invalid: %s\n",
+			printk(KERN_ERR "batman-adv: "
+			       "Download speed of gateway mode invalid: %s\n",
 			       tokptr);
 			return false;
 		}
@@ -131,7 +134,8 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 			multi = 1;
 
 			if (strlen(slash_ptr + 1) > 4) {
-				tmp_ptr = slash_ptr + 1 + strlen(slash_ptr + 1) - 4;
+				tmp_ptr = slash_ptr + 1 - 4
+					   + strlen(slash_ptr + 1);
 
 				if (strnicmp(tmp_ptr, "mbit", 4) == 0)
 					multi = 1024;
@@ -143,7 +147,8 @@ static bool parse_gw_mode_tok(char *tokptr, long *gw_mode_tmp,
 
 			ret = strict_strtoul(slash_ptr + 1, 10, up);
 			if (ret) {
-				printk(KERN_ERR "batman-adv: Upload speed of gateway mode invalid: %s\n",
+				printk(KERN_ERR "batman-adv: Upload speed of "
+				       "gateway mode invalid: %s\n",
 				       slash_ptr + 1);
 				return false;
 			}
@@ -212,9 +217,11 @@ next:
 	}
 
 	if (!gw_mode_tmp_str) {
-		printk(KERN_INFO "batman-adv: Gateway mode can only be set to: '%s', '%s' or '%s' - given value: %s\n",
-			GW_MODE_OFF_NAME, GW_MODE_CLIENT_NAME,
-			GW_MODE_SERVER_NAME, buff);
+		printk(KERN_INFO "batman-adv: "
+		       "Gateway mode can only be set to: '%s', '%s' or '%s' - "
+		       "given value: %s\n",
+		       GW_MODE_OFF_NAME, GW_MODE_CLIENT_NAME,
+		       GW_MODE_SERVER_NAME, buff);
 		goto end;
 	}
 
@@ -235,8 +242,10 @@ next:
 		if ((gw_mode_tmp == GW_MODE_CLIENT) && (!gw_class_tmp))
 			gw_class_tmp = 20;
 
-		printk(KERN_INFO "batman-adv: Changing gateway mode from: '%s' to: '%s' (gw_class: %ld)\n",
-			  gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp);
+		printk(KERN_INFO "batman-adv: "
+		       "Changing gateway mode from: '%s' to: '%s' "
+		       "(gw_class: %ld)\n",
+		       gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp);
 		break;
 	case GW_MODE_SERVER:
 		if (!down)
@@ -257,15 +266,17 @@ next:
 
 		gw_deselect();
 		printk(KERN_INFO
-			  "batman-adv: Changing gateway mode from: '%s' to: '%s' (gw_class: %ld -> propagating: %ld%s/%ld%s)\n",
-			  gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp,
-			  (down > 2048 ? down / 1024 : down),
-			  (down > 2048 ? "MBit" : "KBit"),
-			  (up > 2048 ? up / 1024 : up),
-			  (up > 2048 ? "MBit" : "KBit"));
+		       "batman-adv: Changing gateway mode from: '%s' to: '%s' "
+		       "(gw_class: %ld -> propagating: %ld%s/%ld%s)\n",
+		       gw_mode_curr_str, gw_mode_tmp_str, gw_class_tmp,
+		       (down > 2048 ? down / 1024 : down),
+		       (down > 2048 ? "MBit" : "KBit"),
+		       (up > 2048 ? up / 1024 : up),
+		       (up > 2048 ? "MBit" : "KBit"));
 		break;
 	default:
-		printk(KERN_INFO "batman-adv: Changing gateway mode from: '%s' to: '%s'\n",
+		printk(KERN_INFO "batman-adv: "
+			  "Changing gateway mode from: '%s' to: '%s'\n",
 			  gw_mode_curr_str, gw_mode_tmp_str);
 		break;
 	}
diff --git a/batman-adv-kernelland/hard-interface.c b/batman-adv-kernelland/hard-interface.c
index 64307fc..5123176 100644
--- a/batman-adv-kernelland/hard-interface.c
+++ b/batman-adv-kernelland/hard-interface.c
@@ -150,9 +150,12 @@ static void check_known_mac_addr(uint8_t *addr)
 		if (!compare_orig(batman_if->net_dev->dev_addr, addr))
 			continue;
 
-		printk(KERN_WARNING "batman-adv:The newly added mac address (%pM) already exists on: %s\n",
-		       addr, batman_if->dev);
-		printk(KERN_WARNING "batman-adv:It is strongly recommended to keep mac addresses unique to avoid problems!\n");
+		printk(KERN_WARNING "batman-adv:"
+		    "The newly added mac address (%pM) already exists on: %s\n",
+		    addr, batman_if->dev);
+		printk(KERN_WARNING "batman-adv:"
+		    "It is strongly recommended to keep mac addresses unique"
+		    "to avoid problems!\n");
 	}
 	rcu_read_unlock();
 }
@@ -243,7 +246,8 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	batman_if->packet_buff = kmalloc(batman_if->packet_len, GFP_ATOMIC);
 
 	if (!batman_if->packet_buff) {
-		printk(KERN_ERR "batman-adv:Can't add interface packet (%s): out of memory\n",
+		printk(KERN_ERR "batman-adv:"
+		       "Can't add interface packet (%s): out of memory\n",
 		       batman_if->dev);
 		goto err;
 	}
@@ -267,7 +271,10 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	if (hardif_is_iface_up(batman_if))
 		hardif_activate_interface(bat_priv, batman_if);
 	else
-		printk(KERN_ERR "batman-adv:Not using interface %s (retrying later): interface not active\n", batman_if->dev);
+		printk(KERN_ERR "batman-adv:"
+		       "Not using interface %s "
+		       "(retrying later): interface not active\n",
+		       batman_if->dev);
 
 	/* begin scheduling originator messages on that interface */
 	schedule_own_packet(batman_if);
@@ -317,7 +324,8 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 
 	batman_if = kmalloc(sizeof(struct batman_if), GFP_ATOMIC);
 	if (!batman_if) {
-		printk(KERN_ERR "batman-adv:Can't add interface (%s): out of memory\n",
+		printk(KERN_ERR "batman-adv:"
+		       "Can't add interface (%s): out of memory\n",
 		       net_dev->name);
 		goto out;
 	}
diff --git a/batman-adv-kernelland/main.c b/batman-adv-kernelland/main.c
index 1203d3f..d03a7fa 100644
--- a/batman-adv-kernelland/main.c
+++ b/batman-adv-kernelland/main.c
@@ -92,14 +92,16 @@ int init_module(void)
 				   interface_setup);
 
 	if (!soft_device) {
-		printk(KERN_ERR "batman-adv:Unable to allocate the batman interface\n");
+		printk(KERN_ERR "batman-adv:"
+		       "Unable to allocate the batman interface\n");
 		goto end;
 	}
 
 	retval = register_netdev(soft_device);
 
 	if (retval < 0) {
-		printk(KERN_ERR "batman-adv:Unable to register the batman interface: %i\n", retval);
+		printk(KERN_ERR "batman-adv:"
+		       "Unable to register the batman interface: %i\n", retval);
 		goto free_soft_device;
 	}
 
@@ -111,8 +113,9 @@ int init_module(void)
 	register_netdevice_notifier(&hard_if_notifier);
 	dev_add_pack(&batman_adv_packet_type);
 
-	printk(KERN_INFO "batman-adv:B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded\n",
-		  SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
+	printk(KERN_INFO "batman-adv:"
+	       "B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded\n",
+	       SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
 
 	return 0;
 
@@ -169,7 +172,9 @@ void activate_module(void)
 	goto end;
 
 err:
-	printk(KERN_ERR "batman-adv:Unable to allocate memory for mesh information structures: out of mem ?\n");
+	printk(KERN_ERR "batman-adv:"
+	       "Unable to allocate memory for mesh information structures: "
+	       "out of mem ?\n");
 	deactivate_module();
 end:
 	return;
@@ -212,7 +217,7 @@ void dec_module_count(void)
 
 int addr_to_string(char *buff, uint8_t *addr)
 {
-	return sprintf(buff, "%02x:%02x:%02x:%02x:%02x:%02x",
+	return sprintf(buff, MAC_FMT,
 		       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
 }
 
diff --git a/batman-adv-kernelland/main.h b/batman-adv-kernelland/main.h
index 2b47259..730343e 100644
--- a/batman-adv-kernelland/main.h
+++ b/batman-adv-kernelland/main.h
@@ -22,7 +22,8 @@
 /* Kernel Programming */
 #define LINUX
 
-#define DRIVER_AUTHOR "Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>"
+#define DRIVER_AUTHOR "Marek Lindner <lindner_marek@yahoo.de>, " \
+		      "Simon Wunderlich <siwu@hrz.tu-chemnitz.de>"
 #define DRIVER_DESC   "B.A.T.M.A.N. advanced"
 #define DRIVER_DEVICE "batman-adv"
 
diff --git a/batman-adv-kernelland/originator.c b/batman-adv-kernelland/originator.c
index e01459a..13f69bf 100644
--- a/batman-adv-kernelland/originator.c
+++ b/batman-adv-kernelland/originator.c
@@ -142,8 +142,10 @@ struct orig_node *get_orig_node(uint8_t *addr)
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	orig_node->router = NULL;
 	orig_node->hna_buff = NULL;
-	orig_node->bcast_seqno_reset = jiffies - msecs_to_jiffies(RESET_PROTECTION_MS) - 1;
-	orig_node->batman_seqno_reset = jiffies - msecs_to_jiffies(RESET_PROTECTION_MS) - 1;
+	orig_node->bcast_seqno_reset = jiffies - 1
+					- msecs_to_jiffies(RESET_PROTECTION_MS);
+	orig_node->batman_seqno_reset = jiffies - 1
+					- msecs_to_jiffies(RESET_PROTECTION_MS);
 
 	size = bat_priv->num_ifaces * sizeof(TYPE_OF_WORD) * NUM_WORDS;
 
@@ -200,11 +202,15 @@ static bool purge_orig_neighbors(struct orig_node *orig_node,
 
 			if (neigh_node->if_incoming->if_status ==
 							IF_TO_BE_REMOVED)
-				bat_dbg(DBG_BATMAN, "neighbor purge: originator %pM, neighbor: %pM, iface: %s\n",
+				bat_dbg(DBG_BATMAN,
+					"neighbor purge: originator %pM, "
+					"neighbor: %pM, iface: %s\n",
 					orig_node->orig, neigh_node->addr,
 					neigh_node->if_incoming->dev);
 			else
-				bat_dbg(DBG_BATMAN, "neighbor timeout: originator %pM, neighbor: %pM, last_valid: %lu\n",
+				bat_dbg(DBG_BATMAN,
+					"neighbor timeout: originator %pM, "
+					"neighbor: %pM, last_valid: %lu\n",
 					orig_node->orig, neigh_node->addr,
 					(neigh_node->last_valid / HZ));
 
@@ -292,24 +298,25 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 	if (!bat_priv->primary_if) {
 		if (off == 0)
 			return sprintf(buff,
-				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				       net_dev->name);
+				     "BATMAN mesh %s disabled - "
+				     "please specify interfaces to enable it\n",
+				     net_dev->name);
 
 		return 0;
 	}
 
-	if (bat_priv->primary_if->if_status != IF_ACTIVE) {
-		if (off == 0)
-			return sprintf(buff,
-				       "BATMAN mesh %s disabled - primary interface not active\n",
-				       net_dev->name);
-
+	if (bat_priv->primary_if->if_status != IF_ACTIVE && off == 0)
+		return sprintf(buff,
+			       "BATMAN mesh %s "
+			       "disabled - primary interface not active\n",
+			       net_dev->name);
+	else if (bat_priv->primary_if->if_status)
 		return 0;
-	}
 
 	rcu_read_lock();
 	hdr_len = sprintf(buff,
-		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
+		   "  %-14s (%s/%i) %17s [%10s]: %20s "
+		   "... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
 		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
 		   "Potential nexthops", SOURCE_VERSION, REVISION_VERSION_STR,
 		   bat_priv->primary_if->dev, bat_priv->primary_if->addr_str,
@@ -378,7 +385,8 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 	data_ptr = kmalloc(max_if_num * sizeof(TYPE_OF_WORD) * NUM_WORDS,
 			   GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		printk(KERN_ERR
+		       "batman-adv:Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -389,7 +397,8 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		printk(KERN_ERR
+		       "batman-adv:Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -438,7 +447,8 @@ static int orig_node_del_if(struct orig_node *orig_node,
 	chunk_size = sizeof(TYPE_OF_WORD) * NUM_WORDS;
 	data_ptr = kmalloc(max_if_num * chunk_size, GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		printk(KERN_ERR
+		       "batman-adv:Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -459,7 +469,8 @@ free_bcast_own:
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		printk(KERN_ERR
+		       "batman-adv:Can't resize orig: out of memory\n");
 		return -1;
 	}
 
diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index 9f09a40..5456b0a 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -96,7 +96,11 @@ static void update_route(struct orig_node *orig_node,
 
 		/* route changed */
 	} else {
-		bat_dbg(DBG_ROUTES, "Changing route towards: %pM (now via %pM - was via %pM)\n", orig_node->orig, neigh_node->addr, orig_node->router->addr);
+		bat_dbg(DBG_ROUTES,
+			"Changing route towards: %pM "
+			"(now via %pM - was via %pM)\n",
+			orig_node->orig, neigh_node->addr,
+			orig_node->router->addr);
 	}
 
 	orig_node->router = neigh_node;
@@ -209,7 +213,11 @@ static int isBidirectionalNeigh(struct orig_node *orig_node,
 			      orig_neigh_node->tq_asym_penalty) /
 			     (TQ_MAX_VALUE * TQ_MAX_VALUE));
 
-	bat_dbg(DBG_BATMAN, "bidirectional: orig = %-15pM neigh = %-15pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i\n",
+	bat_dbg(DBG_BATMAN,
+		"bidirectional: "
+		"orig = %-15pM neigh = %-15pM => own_bcast = %2i, "
+		"real recv = %2i, local tq: %3i, asym_penalty: %3i, "
+		"total tq: %3i\n",
 		orig_node->orig, orig_neigh_node->orig, total_count,
 		neigh_node->real_packet_count, orig_neigh_node->tq_own,
 		orig_neigh_node->tq_asym_penalty, batman_packet->tq);
@@ -233,7 +241,8 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	int tmp_hna_buff_len;
 
-	bat_dbg(DBG_BATMAN, "update_originator(): Searching and updating originator entry of received packet\n");
+	bat_dbg(DBG_BATMAN, "update_originator(): "
+		"Searching and updating originator entry of received packet\n");
 
 	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
 		if (compare_orig(tmp_neigh_node->addr, ethhdr->h_source) &&
@@ -551,7 +560,9 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	is_single_hop_neigh = (compare_orig(ethhdr->h_source,
 					    batman_packet->orig) ? 1 : 0);
 
-	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] (from OG: %pM, via prev OG: %pM, seqno %d, tq %d, TTL %d, V %d, IDF %d)\n",
+	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] "
+		"(from OG: %pM, via prev OG: %pM, seqno %d, tq %d, "
+		"TTL %d, V %d, IDF %d)\n",
 		ethhdr->h_source, if_incoming->dev, if_incoming->addr_str,
 		batman_packet->orig, batman_packet->prev_sender,
 		batman_packet->seqno, batman_packet->tq, batman_packet->ttl,
@@ -586,13 +597,16 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 
 	if (is_my_addr) {
 		bat_dbg(DBG_BATMAN,
-			"Drop packet: received my own broadcast (sender: %pM)\n",
+			"Drop packet: received my own broadcast (sender: %pM"
+			")\n",
 			ethhdr->h_source);
 		return;
 	}
 
 	if (is_broadcast) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all packets with broadcast source addr (sender: %pM)\n", ethhdr->h_source);
+		bat_dbg(DBG_BATMAN, "Drop packet: "
+		"ignoring all packets with broadcast source addr (sender: %pM"
+		")\n", ethhdr->h_source);
 		return;
 	}
 
@@ -620,12 +634,15 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				bit_packet_count(word);
 		}
 
-		bat_dbg(DBG_BATMAN, "Drop packet: originator packet from myself (via neighbor)\n");
+		bat_dbg(DBG_BATMAN, "Drop packet: "
+			"originator packet from myself (via neighbor)\n");
 		return;
 	}
 
 	if (is_my_oldorig) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast echos (sender: %pM)\n", ethhdr->h_source);
+		bat_dbg(DBG_BATMAN,
+			"Drop packet: ignoring all rebroadcast echos "
+			"(sender: %pM)\n", ethhdr->h_source);
 		return;
 	}
 
@@ -636,12 +653,15 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	is_duplicate = count_real_packets(ethhdr, batman_packet, if_incoming);
 
 	if (is_duplicate == -1) {
-		bat_dbg(DBG_BATMAN, "Drop packet: packet within seqno protection time (sender: %pM)\n", ethhdr->h_source);
+		bat_dbg(DBG_BATMAN,
+			"Drop packet: packet within seqno protection time "
+			"(sender: %pM)\n", ethhdr->h_source);
 		return;
 	}
 
 	if (batman_packet->tq == 0) {
-		bat_dbg(DBG_BATMAN,	"Drop packet: originator packet with tq equal 0\n");
+		bat_dbg(DBG_BATMAN,
+			"Drop packet: originator packet with tq equal 0\n");
 		return;
 	}
 
@@ -653,7 +673,9 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	    !(compare_orig(batman_packet->orig, batman_packet->prev_sender)) &&
 	    (compare_orig(orig_node->router->addr,
 			  orig_node->router->orig_node->router->addr))) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %pM)\n", ethhdr->h_source);
+		bat_dbg(DBG_BATMAN,
+			"Drop packet: ignoring all rebroadcast packets that "
+			"may make me loop (sender: %pM)\n", ethhdr->h_source);
 		return;
 	}
 
@@ -695,7 +717,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		schedule_forward_packet(orig_node, ethhdr, batman_packet,
 					1, hna_buff_len, if_incoming);
 
-		bat_dbg(DBG_BATMAN, "Forwarding packet: rebroadcast neighbor packet with direct link flag\n");
+		bat_dbg(DBG_BATMAN, "Forwarding packet: "
+			"rebroadcast neighbor packet with direct link flag\n");
 		return;
 	}
 
@@ -840,8 +863,10 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 
 	/* send TTL exceeded if packet is an echo request (traceroute) */
 	if (icmp_packet->msg_type != ECHO_REQUEST) {
-		printk(KERN_WARNING "batman-adv:Warning - can't forward icmp packet from %pM to %pM: ttl exceeded\n",
-			icmp_packet->orig, icmp_packet->dst);
+		printk(KERN_WARNING "batman-adv:"
+		       "Warning - can't forward icmp packet from %pM to %pM: "
+		       "ttl exceeded\n",
+		       icmp_packet->orig, icmp_packet->dst);
 		return NET_RX_DROP;
 	}
 
@@ -1079,7 +1104,10 @@ int recv_unicast_packet(struct sk_buff *skb)
 
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
-		printk(KERN_WARNING "batman-adv:Warning - can't forward unicast packet from %pM to %pM: ttl exceeded\n", ethhdr->h_source, unicast_packet->dest);
+		printk(KERN_WARNING "batman-adv:Warning - "
+		       "can't forward unicast packet from %pM to %pM: "
+		       "ttl exceeded\n",
+		       ethhdr->h_source, unicast_packet->dest);
 		return NET_RX_DROP;
 	}
 
diff --git a/batman-adv-kernelland/send.c b/batman-adv-kernelland/send.c
index 7667d1f..bed6cea 100644
--- a/batman-adv-kernelland/send.c
+++ b/batman-adv-kernelland/send.c
@@ -68,7 +68,8 @@ int send_skb_packet(struct sk_buff *skb,
 
 	if (!(batman_if->net_dev->flags & IFF_UP)) {
 		printk(KERN_WARNING
-		       "batman-adv:Interface %s is not up - can't send packet via that interface!\n",
+		       "batman-adv:Interface %s "
+		       "is not up - can't send packet via that interface!\n",
 		       batman_if->dev);
 		goto send_skb_err;
 	}
@@ -150,7 +151,9 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 							    "Sending own" :
 							    "Forwarding"));
 		bat_dbg(DBG_BATMAN,
-			"%s %spacket (originator %pM, seqno %d, TQ %d, TTL %d, IDF %s) on interface %s [%s]\n",
+			"%s %spacket "
+			"(originator %pM, seqno %d, TQ %d, TTL %d, IDF %s) "
+			"on interface %s [%s]\n",
 			fwd_str,
 			(packet_num > 0 ? "aggregated " : ""),
 			batman_packet->orig, ntohl(batman_packet->seqno),
@@ -180,7 +183,8 @@ static void send_packet(struct forw_packet *forw_packet)
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
 
 	if (!forw_packet->if_incoming) {
-		printk(KERN_ERR "batman-adv: Error - can't forward packet: incoming iface not specified\n");
+		printk(KERN_ERR "batman-adv: Error - can't forward packet: "
+		       "incoming iface not specified\n");
 		return;
 	}
 
@@ -194,7 +198,8 @@ static void send_packet(struct forw_packet *forw_packet)
 
 		/* FIXME: what about aggregated packets ? */
 		bat_dbg(DBG_BATMAN,
-			"%s packet (originator %pM, seqno %d, TTL %d) on interface %s [%s]\n",
+			"%s packet (originator %pM, seqno %d, TTL %d) "
+			"on interface %s [%s]\n",
 			(forw_packet->own ? "Sending own" : "Forwarding"),
 			batman_packet->orig, ntohl(batman_packet->seqno),
 			batman_packet->ttl, forw_packet->if_incoming->dev,
@@ -330,7 +335,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 			batman_packet->tq = orig_node->router->tq_avg;
 
 			if (orig_node->router->last_ttl)
-				batman_packet->ttl = orig_node->router->last_ttl - 1;
+				batman_packet->ttl = orig_node->router->last_ttl
+							- 1;
 		}
 
 		tq_avg = orig_node->router->tq_avg;
@@ -339,7 +345,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	/* apply hop penalty */
 	batman_packet->tq = hop_penalty(batman_packet->tq);
 
-	bat_dbg(DBG_BATMAN, "Forwarding packet: tq_orig: %i, tq_avg: %i, tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
+	bat_dbg(DBG_BATMAN, "Forwarding packet: tq_orig: %i, tq_avg: %i, "
+		"tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
 		in_tq, tq_avg, batman_packet->tq, in_ttl - 1,
 		batman_packet->ttl);
 
diff --git a/batman-adv-kernelland/translation-table.c b/batman-adv-kernelland/translation-table.c
index 3ce39a6..a60bc7e 100644
--- a/batman-adv-kernelland/translation-table.c
+++ b/batman-adv-kernelland/translation-table.c
@@ -78,7 +78,10 @@ void hna_local_add(uint8_t *addr)
 	   MAC-flooding. */
 	if ((num_hna + 1 > (ETH_DATA_LEN - BAT_PACKET_LEN) / ETH_ALEN) ||
 	    (num_hna + 1 > 255)) {
-		bat_dbg(DBG_ROUTES, "Can't add new local hna entry (%pM): number of local hna entries exceeds packet size\n", addr);
+		bat_dbg(DBG_ROUTES,
+			"Can't add new local hna entry (%pM): "
+			"number of local hna entries exceeds packet size\n",
+			addr);
 		return;
 	}
 
@@ -109,7 +112,8 @@ void hna_local_add(uint8_t *addr)
 				       hna_local_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR "batman-adv:Couldn't resize local hna hash table\n");
+			printk(KERN_ERR "batman-adv:"
+			       "Couldn't resize local hna hash table\n");
 		else
 			hna_local_hash = swaphash;
 	}
@@ -170,14 +174,16 @@ int hna_local_fill_buffer_text(struct net_device *net_dev, char *buff,
 	if (!bat_priv->primary_if) {
 		if (off == 0)
 			return sprintf(buff,
-				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				       net_dev->name);
+				     "BATMAN mesh %s disabled - "
+				     "please specify interfaces to enable it\n",
+				     net_dev->name);
 
 		return 0;
 	}
 
 	hdr_len = sprintf(buff,
-			  "Locally retrieved addresses (from %s) announced via HNA:\n",
+			  "Locally retrieved addresses (from %s) "
+			  "announced via HNA:\n",
 			  net_dev->name);
 
 	if (off < hdr_len)
@@ -197,7 +203,7 @@ int hna_local_fill_buffer_text(struct net_device *net_dev, char *buff,
 		hna_local_entry = hashit.bucket->data;
 
 		bytes_written += snprintf(buff + bytes_written, 22,
-					  " * %02x:%02x:%02x:%02x:%02x:%02x\n",
+					  " * " MAC_FMT "\n",
 					  hna_local_entry->addr[0],
 					  hna_local_entry->addr[1],
 					  hna_local_entry->addr[2],
@@ -318,7 +324,8 @@ void hna_global_add_orig(struct orig_node *orig_node,
 			memcpy(hna_global_entry->addr, hna_ptr, ETH_ALEN);
 
 			bat_dbg(DBG_ROUTES,
-				"Creating new global hna entry: %pM (via %pM)\n",
+				"Creating new global hna entry: "
+				"%pM (via %pM)\n",
 				hna_global_entry->addr, orig_node->orig);
 
 			spin_lock_irqsave(&hna_global_hash_lock, flags);
@@ -363,7 +370,8 @@ void hna_global_add_orig(struct orig_node *orig_node,
 				       hna_global_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR "batman-adv:Couldn't resize global hna hash table\n");
+			printk(KERN_ERR "batman-adv:"
+			       "Couldn't resize global hna hash table\n");
 		else
 			hna_global_hash = swaphash;
 	}
@@ -384,14 +392,16 @@ int hna_global_fill_buffer_text(struct net_device *net_dev, char *buff,
 	if (!bat_priv->primary_if) {
 		if (off == 0)
 			return sprintf(buff,
-				       "BATMAN mesh %s disabled - please specify interfaces to enable it\n",
-				       net_dev->name);
+				     "BATMAN mesh %s disabled - "
+				     "please specify interfaces to enable it\n",
+				     net_dev->name);
 
 		return 0;
 	}
 
 	hdr_len = sprintf(buff,
-			  "Globally announced HNAs received via the mesh %s (translation table):\n",
+			  "Globally announced HNAs received via the mesh %s "
+			  "(translation table):\n",
 			  net_dev->name);
 
 	if (off < hdr_len)
@@ -411,7 +421,7 @@ int hna_global_fill_buffer_text(struct net_device *net_dev, char *buff,
 		hna_global_entry = hashit.bucket->data;
 
 		bytes_written += snprintf(buff + bytes_written, 44,
-					  " * %02x:%02x:%02x:%02x:%02x:%02x via %02x:%02x:%02x:%02x:%02x:%02x\n",
+					  " * " MAC_FMT " via " MAC_FMT "\n",
 					  hna_global_entry->addr[0],
 					  hna_global_entry->addr[1],
 					  hna_global_entry->addr[2],
diff --git a/batman-adv-kernelland/types.h b/batman-adv-kernelland/types.h
index 3f1788d..f9dda8e 100644
--- a/batman-adv-kernelland/types.h
+++ b/batman-adv-kernelland/types.h
@@ -29,7 +29,10 @@
 #include "packet.h"
 #include "bitarray.h"
 
-#define BAT_HEADER_LEN (sizeof(struct ethhdr) + ((sizeof(struct unicast_packet) > sizeof(struct bcast_packet) ? sizeof(struct unicast_packet) : sizeof(struct bcast_packet))))
+#define BAT_HEADER_LEN (sizeof(struct ethhdr) + \
+	((sizeof(struct unicast_packet) > sizeof(struct bcast_packet) ? \
+	 sizeof(struct unicast_packet) : \
+	 sizeof(struct bcast_packet))))
 
 
 struct batman_if {
@@ -46,31 +49,44 @@ struct batman_if {
 	struct rcu_head rcu;
 };
 
-struct orig_node {               /* structure for orig_list maintaining nodes of mesh */
+/**
+  *	orig_node - structure for orig_list maintaining nodes of mesh
+  *	@primary_addr: hosts primary interface address
+  *	@last_valid: when last packet from this node was received
+  *	@bcast_seqno_reset: time when the broadcast seqno window was reset
+  *	@batman_seqno_reset: time when the batman seqno window was reset
+  *	@gw_flags: flags related to gateway class
+  *	@flags: for now only VIS_SERVER flag
+  *	@last_real_seqno: last and best known squence number
+  *	@last_ttl: ttl of last received packet
+  *	@last_bcast_seqno: last broadcast sequence number received by this host
+  *
+  *	@candidates: how many candidates are available
+  *	@selected: next bonding candidate
+ */
+struct orig_node {
 	uint8_t orig[ETH_ALEN];
-	uint8_t primary_addr[ETH_ALEN];	/* hosts primary interface address */
+	uint8_t primary_addr[ETH_ALEN];
 	struct neigh_node *router;
 	TYPE_OF_WORD *bcast_own;
 	uint8_t *bcast_own_sum;
 	uint8_t tq_own;
 	int tq_asym_penalty;
-	unsigned long last_valid;        /* when last packet from this node was received */
-	unsigned long bcast_seqno_reset; /* time when the broadcast
-					    seqno window was reset. */
-	unsigned long batman_seqno_reset;/* time when the batman seqno
-					    window was reset. */
-	uint8_t gw_flags;      /* flags related to gateway class */
-	uint8_t flags;    /* for now only VIS_SERVER flag. */
+	unsigned long last_valid;
+	unsigned long bcast_seqno_reset;
+	unsigned long batman_seqno_reset;
+	uint8_t gw_flags;
+	uint8_t flags;
 	unsigned char *hna_buff;
 	int16_t hna_buff_len;
-	uint32_t last_real_seqno;   /* last and best known sequence number */
-	uint8_t last_ttl;         /* ttl of last received packet */
+	uint32_t last_real_seqno;
+	uint8_t last_ttl;
 	TYPE_OF_WORD bcast_bits[NUM_WORDS];
-	uint32_t last_bcast_seqno;  /* last received broadcast seqno */
+	uint32_t last_bcast_seqno;
 	struct list_head neigh_list;
 	struct {
-		uint8_t candidates;	/* how many candidates are available */
-		struct neigh_node *selected;	/* next bonding candidate */
+		uint8_t candidates;
+		struct neigh_node *selected;
 	} bond;
 };
 
@@ -81,6 +97,10 @@ struct gw_node {
 	struct rcu_head rcu;
 };
 
+/**
+  *	neigh_node
+  *	@last_valid: when last packet via this neighbor was received
+ */
 struct neigh_node {
 	struct list_head list;
 	uint8_t addr[ETH_ALEN];
@@ -90,7 +110,7 @@ struct neigh_node {
 	uint8_t tq_avg;
 	uint8_t last_ttl;
 	struct neigh_node *next_bond_candidate;
-	unsigned long last_valid;            /* when last packet via this neighbor was received */
+	unsigned long last_valid;
 	TYPE_OF_WORD real_bits[NUM_WORDS];
 	struct orig_node *orig_node;
 	struct batman_if *if_incoming;
@@ -136,7 +156,11 @@ struct hna_global_entry {
 	struct orig_node *orig_node;
 };
 
-struct forw_packet {               /* structure for forw_list maintaining packets to be send/forwarded */
+/**
+  *	forw_packet - structure for forw_list maintaining packets to be
+  *	              send/forwarded
+ */
+struct forw_packet {
 	struct hlist_node list;
 	unsigned long send_time;
 	uint8_t own;
-- 
1.7.1

