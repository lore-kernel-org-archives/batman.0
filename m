Return-Path: <andrew.lunn@ascom.ch>
Date: Sun, 23 Aug 2009 15:09:34 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090823130934.GA28556@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv] Use prinkt instead of debug_log
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

If batman is to get into mainline, the use of debug_log will need to
be removed. This is a first step in this direction. It replaces
debug_log calls for CRITICAL, WARNING and NOTICE with printk calls.
It tries to consistently prefix all such output with "batman:" making
it easier to find such output mixed in with other kernel messages.
LOG_TYPE_BATMAN and LOG_TYPE_ROUTES has not been changed.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Index: batman-adv-kernelland/vis.c
===================================================================
--- batman-adv-kernelland/vis.c	(revision 1411)
+++ batman-adv-kernelland/vis.c	(working copy)
@@ -440,8 +440,8 @@
 	int packet_length;
 
 	if (info->packet.ttl < 2) {
-		debug_log(LOG_TYPE_NOTICE,
-			  "Error - can't send vis packet: ttl exceeded\n");
+		printk(KERN_DEBUG
+			  "batman: Can't send vis packet: ttl exceeded\n");
 		return;
 	}
 
@@ -490,13 +490,13 @@
 
 	vis_hash = hash_new(256, vis_info_cmp, vis_info_choose);
 	if (!vis_hash) {
-		debug_log(LOG_TYPE_CRIT, "Can't initialize vis_hash\n");
+		printk(KERN_ERR  "batman: Can't initialize vis_hash\n");
 		goto err;
 	}
 
 	my_vis_info = kmalloc(1000, GFP_KERNEL);
 	if (!my_vis_info) {
-		debug_log(LOG_TYPE_CRIT, "Can't initialize vis packet\n");
+		printk(KERN_ERR  "batman: Can't initialize vis packet\n");
 		goto err;
 	}
 
@@ -517,8 +517,8 @@
 	memcpy(my_vis_info->packet.sender_orig, mainIfAddr, ETH_ALEN);
 
 	if (hash_add(vis_hash, my_vis_info) < 0) {
-		debug_log(LOG_TYPE_CRIT,
-			  "Can't add own vis packet into hash\n");
+		printk(KERN_ERR
+			  "batman: Can't add own vis packet into hash\n");
 		free_info(my_vis_info);	/* not in hash, need to remove it
 					 * manually. */
 		goto err;
Index: batman-adv-kernelland/translation-table.c
===================================================================
--- batman-adv-kernelland/translation-table.c	(revision 1411)
+++ batman-adv-kernelland/translation-table.c	(working copy)
@@ -111,7 +111,7 @@
 				       hna_local_hash->size * 2);
 
 		if (swaphash == NULL)
-			debug_log(LOG_TYPE_CRIT, "Couldn't resize local hna hash table \n");
+			printk(KERN_ERR "batman: Couldn't resize local hna hash table \n");
 		else
 			hna_local_hash = swaphash;
 	}
@@ -331,7 +331,7 @@
 				       hna_global_hash->size * 2);
 
 		if (swaphash == NULL)
-			debug_log(LOG_TYPE_CRIT, "Couldn't resize global hna hash table \n");
+			printk(KERN_ERR "batman: Couldn't resize global hna hash table \n");
 		else
 			hna_global_hash = swaphash;
 	}
Index: batman-adv-kernelland/send.c
===================================================================
--- batman-adv-kernelland/send.c	(revision 1411)
+++ batman-adv-kernelland/send.c	(working copy)
@@ -70,8 +70,8 @@
 		return;
 
 	if (!(batman_if->net_dev->flags & IFF_UP)) {
-		debug_log(LOG_TYPE_WARN,
-			  "Interface %s is not up - can't send packet via that interface !\n", batman_if->dev);
+		printk(KERN_WARNING
+		       "batman: Interface %s is not up - can't send packet via that interface !\n", batman_if->dev);
 		batman_if->if_active = IF_TO_BE_DEACTIVATED;
 		return;
 	}
@@ -99,7 +99,7 @@
 	 * (which is > 0). This will not be treated as an error. */
 	retval = dev_queue_xmit(skb);
 	if (retval < 0) {
-		debug_log(LOG_TYPE_CRIT, "Can't write to raw socket: %i\n",
+		printk(KERN_WARNING "batman: Can't write to raw socket: %i\n",
 			  retval);
 		batman_if->if_active = IF_TO_BE_DEACTIVATED;
 	}
@@ -171,8 +171,8 @@
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
 
 	if (!forw_packet->if_incoming) {
-		debug_log(LOG_TYPE_CRIT,
-			  "Error - can't forward packet: incoming iface not specified\n");
+		printk(KERN_ERR
+			  "batman: Can't forward packet: incoming iface not specified\n");
 		return;
 	}
 
Index: batman-adv-kernelland/device.c
===================================================================
--- batman-adv-kernelland/device.c	(revision 1411)
+++ batman-adv-kernelland/device.c	(working copy)
@@ -60,7 +60,7 @@
 	/* register our device - kernel assigns a free major number */
 	tmp_major = register_chrdev(0, DRIVER_DEVICE, &fops);
 	if (tmp_major < 0) {
-		debug_log(LOG_TYPE_WARN, "Registering the character device failed with %d\n",
+		printk(KERN_ERR "batman: Registering the character device failed with %d\n",
 			  tmp_major);
 		return 0;
 	}
@@ -68,14 +68,14 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0)
 	if (devfs_mk_cdev(MKDEV(tmp_major, 0), S_IFCHR | S_IRUGO | S_IWUGO,
 			  "batman-adv", 0)) {
-		debug_log(LOG_TYPE_WARN, "Could not create /dev/batman-adv\n");
+		printk(KERN_ERR "batman: Could not create /dev/batman-adv\n");
 		return 0;
 	}
 #else
 	batman_class = class_create(THIS_MODULE, "batman-adv");
 
 	if (IS_ERR(batman_class)) {
-		debug_log(LOG_TYPE_WARN, "Could not register class 'batman-adv' \n");
+		printk(KERN_ERR "batman: Could not register class 'batman-adv' \n");
 		return 0;
 	}
 
@@ -109,7 +109,7 @@
 #endif
 
 	if (result < 0)
-		debug_log(LOG_TYPE_WARN, "Unregistering the character device failed with %d\n", result);
+		printk(KERN_ERR "batman: Unregistering the character device failed with %d\n", result);
 
 	Major = 0;
 }
@@ -132,7 +132,7 @@
 	}
 
 	if (device_client_hash[i] != device_client) {
-		debug_log(LOG_TYPE_WARN, "Error - can't add another packet client: maximum number of clients reached \n");
+		printk(KERN_INFO "batman: Can't add another packet client: maximum number of clients reached \n");
 		kfree(device_client);
 		return -EXFULL;
 	}
@@ -229,7 +229,7 @@
 	struct batman_if *batman_if;
 
 	if (len < sizeof(struct icmp_packet)) {
-		debug_log(LOG_TYPE_NOTICE, "Error - can't send packet from char device: invalid packet size\n");
+		printk(KERN_DEBUG "batman: Can't send packet from char device: invalid packet size\n");
 		return -EINVAL;
 	}
 
@@ -240,12 +240,12 @@
 		return -EFAULT;
 
 	if (icmp_packet.packet_type != BAT_ICMP) {
-		debug_log(LOG_TYPE_NOTICE, "Error - can't send packet from char device: got bogus packet type (expected: BAT_ICMP)\n");
+		printk(KERN_DEBUG "batman: Can't send packet from char device: got bogus packet type (expected: BAT_ICMP)\n");
 		return -EINVAL;
 	}
 
 	if (icmp_packet.msg_type != ECHO_REQUEST) {
-		debug_log(LOG_TYPE_NOTICE, "Error - can't send packet from char device: got bogus message type (expected: ECHO_REQUEST)\n");
+		printk(KERN_DEBUG "batman: Can't send packet from char device: got bogus message type (expected: ECHO_REQUEST)\n");
 		return -EINVAL;
 	}
 
Index: batman-adv-kernelland/proc.c
===================================================================
--- batman-adv-kernelland/proc.c	(revision 1411)
+++ batman-adv-kernelland/proc.c	(working copy)
@@ -74,8 +74,8 @@
 		return -ENOMEM;
 
 	if (count > IFNAMSIZ - 1) {
-		debug_log(LOG_TYPE_WARN,
-			  "Can't add interface: device name is too long\n");
+		printk(KERN_WARNING
+			  "batman: Can't add interface: device name is too long\n");
 		goto end;
 	}
 
@@ -102,7 +102,7 @@
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
 		if (strncmp(batman_if->dev, if_string, count) == 0) {
-			debug_log(LOG_TYPE_WARN, "Given interface is already active: %s\n", if_string);
+			printk(KERN_WARNING "batman: Given interface is already active: %s\n", if_string);
 			rcu_read_unlock();
 			goto end;
 
@@ -158,19 +158,19 @@
 
 	retval = strict_strtol(interval_string, 10, &originator_interval_tmp);
 	if (retval) {
-		debug_log(LOG_TYPE_WARN, "New originator interval invalid\n");
+		printk(KERN_WARNING "batman: New originator interval invalid\n");
 		goto end;
 	}
 
 	if (originator_interval_tmp <= JITTER * 2) {
-		debug_log(LOG_TYPE_WARN,
-			  "New originator interval too small: %i (min: %i)\n",
+		printk(KERN_WARNING
+			  "batman: New originator interval too small: %li (min: %i)\n",
 			  originator_interval_tmp, JITTER * 2);
 		goto end;
 	}
 
-	debug_log(LOG_TYPE_NOTICE,
-		  "Changing originator interval from: %i to: %i\n",
+	printk(KERN_INFO
+		  "batman: Changing originator interval from: %i to: %li\n",
 		  atomic_read(&originator_interval), originator_interval_tmp);
 
 	atomic_set(&originator_interval, originator_interval_tmp);
@@ -262,14 +262,7 @@
 static int proc_log_level_read(struct seq_file *seq, void *offset)
 {
 
-	seq_printf(seq, "[x] %s (%d)\n", LOG_TYPE_CRIT_NAME, LOG_TYPE_CRIT);
 	seq_printf(seq, "[%c] %s (%d)\n",
-		   (LOG_TYPE_WARN & log_level) ? 'x' : ' ',
-		   LOG_TYPE_WARN_NAME, LOG_TYPE_WARN);
-	seq_printf(seq, "[%c] %s (%d)\n",
-		   (LOG_TYPE_NOTICE & log_level) ? 'x' : ' ',
-		   LOG_TYPE_NOTICE_NAME, LOG_TYPE_NOTICE);
-	seq_printf(seq, "[%c] %s (%d)\n",
 		   (LOG_TYPE_BATMAN & log_level) ? 'x' : ' ',
 		   LOG_TYPE_BATMAN_NAME, LOG_TYPE_BATMAN);
 	seq_printf(seq, "[%c] %s (%d)\n",
@@ -315,10 +308,6 @@
 			case '\t':
 				*cp = 0;
 				/* compare */
-				if (strcmp(tokptr, LOG_TYPE_WARN_NAME) == 0)
-					log_level_tmp |= LOG_TYPE_WARN;
-				if (strcmp(tokptr, LOG_TYPE_NOTICE_NAME) == 0)
-					log_level_tmp |= LOG_TYPE_NOTICE;
 				if (strcmp(tokptr, LOG_TYPE_BATMAN_NAME) == 0)
 					log_level_tmp |= LOG_TYPE_BATMAN;
 				if (strcmp(tokptr, LOG_TYPE_ROUTES_NAME) == 0)
@@ -331,7 +320,7 @@
 		}
 	}
 
-	debug_log(LOG_TYPE_CRIT, "Changing log_level from: %i to: %i\n",
+	printk(KERN_INFO "batman: Changing log_level from: %i to: %i\n",
 		  log_level, log_level_tmp);
 	log_level = log_level_tmp;
 
@@ -503,14 +492,14 @@
 	vis_mode_string[count - not_copied - 1] = 0;
 
 	if (strcmp(vis_mode_string, "client") == 0) {
-		debug_log(LOG_TYPE_NOTICE, "Setting VIS mode to client\n");
+		printk(KERN_INFO "batman: Setting VIS mode to client\n");
 		vis_set_mode(VIS_TYPE_CLIENT_UPDATE);
 	} else if (strcmp(vis_mode_string, "server") == 0) {
-		debug_log(LOG_TYPE_NOTICE, "Setting VIS mode to server\n");
+		printk(KERN_INFO "batman: Setting VIS mode to server\n");
 		vis_set_mode(VIS_TYPE_SERVER_SYNC);
 	} else
-		debug_log(LOG_TYPE_WARN, "Unknown VIS mode: %s\n",
-			  vis_mode_string);
+		printk(KERN_WARNING "batman: Unknown VIS mode: %s\n",
+		       vis_mode_string);
 
 	kfree(vis_mode_string);
 	return count;
@@ -555,15 +544,15 @@
 	vis_format_string[count - not_copied - 1] = 0;
 
 	if (strcmp(vis_format_string, VIS_FORMAT_DD_NAME) == 0) {
-		debug_log(LOG_TYPE_NOTICE, "Setting VIS output format to: %s\n",
+		printk(KERN_INFO "batman: Setting VIS output format to: %s\n",
 			  VIS_FORMAT_DD_NAME);
 		vis_format = DOT_DRAW;
 	} else if (strcmp(vis_format_string, VIS_FORMAT_JSON_NAME) == 0) {
-		debug_log(LOG_TYPE_NOTICE, "Setting VIS output format to: %s\n",
+		printk(KERN_INFO  "batman: Setting VIS output format to: %s\n",
 			  VIS_FORMAT_JSON_NAME);
 		vis_format = JSON;
 	} else
-		debug_log(LOG_TYPE_WARN, "Unknown VIS output format: %s\n",
+		printk(KERN_WARNING "batman: Unknown VIS output format: %s\n",
 			  vis_format_string);
 
 	kfree(vis_format_string);
@@ -595,11 +584,11 @@
 	strict_strtol(aggr_string, 10, &aggregation_enabled_tmp);
 
 	if ((aggregation_enabled_tmp != 0) && (aggregation_enabled_tmp != 1)) {
-		debug_log(LOG_TYPE_WARN, "Aggregation can only be enabled (1) or disabled (0), given value: %li\n", aggregation_enabled_tmp);
+		printk(KERN_WARNING "batman: Aggregation can only be enabled (1) or disabled (0), given value: %li\n", aggregation_enabled_tmp);
 		goto end;
 	}
 
-	debug_log(LOG_TYPE_NOTICE, "Changing aggregation from: %s (%i) to: %s (%li)\n",
+	printk(KERN_INFO "batman: Changing aggregation from: %s (%i) to: %s (%li)\n",
 		  (atomic_read(&aggregation_enabled) == 1 ?
 		   "enabled" : "disabled"),
 		  atomic_read(&aggregation_enabled),
@@ -754,7 +743,7 @@
 #endif
 
 	if (!proc_batman_dir) {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s' folder failed\n", PROC_ROOT_DIR);
+		printk(KERN_ERR "batman: Registering the '/proc/net/%s' folder failed\n", PROC_ROOT_DIR);
 		return -EFAULT;
 	}
 
@@ -764,7 +753,7 @@
 	if (proc_interface_file) {
 		proc_interface_file->proc_fops = &proc_interfaces_fops;
 	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_INTERFACES);
+		printk(KERN_ERR "batman: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_INTERFACES);
 		cleanup_procfs();
 		return -EFAULT;
 	}
@@ -775,7 +764,7 @@
 	if (proc_orig_interval_file) {
 		proc_orig_interval_file->proc_fops = &proc_orig_interval_fops;
 	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_ORIG_INTERVAL);
+		printk(KERN_ERR "batman: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_ORIG_INTERVAL);
 		cleanup_procfs();
 		return -EFAULT;
 	}
@@ -786,7 +775,7 @@
 	if (proc_log_level_file) {
 		proc_log_level_file->proc_fops = &proc_log_level_fops;
 	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_LOG_LEVEL);
+		printk(KERN_ERR "batman: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_LOG_LEVEL);
 		cleanup_procfs();
 		return -EFAULT;
 	}
@@ -796,7 +785,7 @@
 	if (proc_originators_file) {
 		proc_originators_file->proc_fops = &proc_originators_fops;
 	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_ORIGINATORS);
+		printk(KERN_ERR "batman: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_ORIGINATORS);
 		cleanup_procfs();
 		return -EFAULT;
 	}
@@ -806,7 +795,7 @@
 	if (proc_log_file) {
 		proc_log_file->proc_fops = &proc_log_operations;
 	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_FILE_LOG, PROC_FILE_GATEWAYS);
+		printk(KERN_ERR "batman: Registering the '/proc/net/%s/%s' file failed\n", PROC_FILE_LOG, PROC_FILE_GATEWAYS);
 		cleanup_procfs();
 		return -EFAULT;
 	}
@@ -816,7 +805,7 @@
 	if (proc_transt_local_file) {
 		proc_transt_local_file->proc_fops = &proc_transt_local_fops;
 	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_TRANST_LOCAL);
+		printk(KERN_ERR "batman: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_TRANST_LOCAL);
 		cleanup_procfs();
 		return -EFAULT;
 	}
@@ -826,7 +815,7 @@
 	if (proc_transt_global_file) {
 		proc_transt_global_file->proc_fops = &proc_transt_global_fops;
 	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_TRANST_GLOBAL);
+		printk(KERN_ERR "batman: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_TRANST_GLOBAL);
 		cleanup_procfs();
 		return -EFAULT;
 	}
@@ -836,7 +825,7 @@
 	if (proc_vis_file) {
 		proc_vis_file->proc_fops = &proc_vis_fops;
 	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_VIS);
+		printk(KERN_ERR "batman: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_VIS);
 		cleanup_procfs();
 		return -EFAULT;
 	}
@@ -847,7 +836,7 @@
 	if (proc_vis_format_file) {
 		proc_vis_format_file->proc_fops = &proc_vis_format_fops;
 	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_VIS_FORMAT);
+		printk(KERN_ERR "batman: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_VIS_FORMAT);
 		cleanup_procfs();
 		return -EFAULT;
 	}
@@ -857,7 +846,7 @@
 	if (proc_aggr_file) {
 		proc_aggr_file->proc_fops = &proc_aggr_fops;
 	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_AGGR);
+		printk(KERN_ERR "batman: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_AGGR);
 		cleanup_procfs();
 		return -EFAULT;
 	}
Index: batman-adv-kernelland/soft-interface.c
===================================================================
--- batman-adv-kernelland/soft-interface.c	(revision 1411)
+++ batman-adv-kernelland/soft-interface.c	(working copy)
@@ -212,7 +212,7 @@
 		 * dropping */
 		if (!spin_trylock(&orig_hash_lock)) {
 			lock_dropped++;
-			debug_log(LOG_TYPE_NOTICE, "%d packets dropped because lock was hold\n", lock_dropped);
+			printk(KERN_DEBUG "batman: %d packets dropped because lock was hold\n", lock_dropped);
 			goto dropped;
 		}
 
Index: batman-adv-kernelland/hard-interface.c
===================================================================
--- batman-adv-kernelland/hard-interface.c	(revision 1411)
+++ batman-adv-kernelland/hard-interface.c	(working copy)
@@ -119,7 +119,7 @@
 	batman_if->if_active = IF_INACTIVE;
 	active_ifs--;
 
-	debug_log(LOG_TYPE_NOTICE, "Interface deactivated: %s\n",
+	printk(KERN_INFO "batman: Interface deactivated: %s\n",
 		  batman_if->dev);
 }
 
@@ -142,8 +142,8 @@
 				  &batman_if->raw_sock);
 
 	if (retval < 0) {
-		debug_log(LOG_TYPE_WARN, "Can't create raw socket: %i\n",
-			  retval);
+		printk(KERN_ERR "batman: Can't create raw socket: %i\n",
+		       retval);
 		goto error;
 	}
 
@@ -155,8 +155,8 @@
 			     (struct sockaddr *)&bind_addr, sizeof(bind_addr));
 
 	if (retval < 0) {
-		debug_log(LOG_TYPE_WARN, "Can't create bind raw socket: %i\n",
-			  retval);
+		printk(KERN_ERR "batman: Can't create bind raw socket: %i\n",
+		       retval);
 		goto error;
 	}
 
@@ -225,7 +225,7 @@
 	data_ptr = kmalloc((if_num + 1) * sizeof(TYPE_OF_WORD) * NUM_WORDS,
 			   GFP_ATOMIC);
 	if (!data_ptr) {
-		debug_log(LOG_TYPE_WARN, "Can't resize orig: out of memory\n");
+		printk(KERN_WARNING "batman: Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -236,7 +236,7 @@
 
 	data_ptr = kmalloc((if_num + 1) * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		debug_log(LOG_TYPE_WARN, "Can't resize orig: out of memory\n");
+		printk(KERN_WARNING "batman: Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -259,7 +259,7 @@
 	batman_if = kmalloc(sizeof(struct batman_if), GFP_KERNEL);
 
 	if (!batman_if) {
-		debug_log(LOG_TYPE_WARN, "Can't add interface (%s): out of memory\n", dev);
+		printk(KERN_WARNING "batman: Can't add interface (%s): out of memory\n", dev);
 		return -1;
 	}
 
@@ -274,7 +274,7 @@
 	batman_if->packet_buff = kmalloc(batman_if->packet_len, GFP_KERNEL);
 
 	if (!batman_if->packet_buff) {
-		debug_log(LOG_TYPE_WARN, "Can't add interface packet (%s): out of memory\n", dev);
+		printk(KERN_WARNING "batman: Can't add interface packet (%s): out of memory\n", dev);
 		goto out;
 	}
 
@@ -283,7 +283,7 @@
 	batman_if->if_active = IF_INACTIVE;
 	INIT_RCU_HEAD(&batman_if->rcu);
 
-	debug_log(LOG_TYPE_NOTICE, "Adding interface: %s\n", dev);
+	printk(KERN_INFO "batman: Adding interface: %s\n", dev);
 	avail_ifs++;
 
 	INIT_LIST_HEAD(&batman_if->list);
@@ -324,7 +324,7 @@
 	spin_unlock(&orig_hash_lock);
 
 	if (!hardif_is_interface_up(batman_if->dev))
-		debug_log(LOG_TYPE_WARN, "Not using interface %s (retrying later): interface not active\n", batman_if->dev);
+		printk(KERN_WARNING "batman: Not using interface %s (retrying later): interface not active\n", batman_if->dev);
 
 	list_add_tail_rcu(&batman_if->list, &if_list);
 
Index: batman-adv-kernelland/log.c
===================================================================
--- batman-adv-kernelland/log.c	(revision 1411)
+++ batman-adv-kernelland/log.c	(working copy)
@@ -80,17 +80,9 @@
 	int retval = 0;
 	char tmp_log_buf[256];
 
-	/* only critical information get into the official kernel log */
-	if (type == LOG_TYPE_CRIT) {
+	if (log_level & type) {
 		va_start(args, fmt);
 		vscnprintf(tmp_log_buf, sizeof(tmp_log_buf), fmt, args);
-		printk(KERN_ERR "batman-adv: %s", tmp_log_buf);
-		va_end(args);
-	}
-
-	if ((type == LOG_TYPE_CRIT) || (log_level & type)) {
-		va_start(args, fmt);
-		vscnprintf(tmp_log_buf, sizeof(tmp_log_buf), fmt, args);
 		fdebug_log("[%10u] %s", (jiffies / HZ), tmp_log_buf);
 		va_end(args);
 	}
Index: batman-adv-kernelland/main.c
===================================================================
--- batman-adv-kernelland/main.c	(revision 1411)
+++ batman-adv-kernelland/main.c	(working copy)
@@ -88,20 +88,20 @@
 				   interface_setup);
 
 	if (!soft_device) {
-		debug_log(LOG_TYPE_CRIT, "Unable to allocate the batman interface\n");
+		printk(KERN_ERR "batman: Unable to allocate the batman interface\n");
 		goto end;
 	}
 
 	retval = register_netdev(soft_device);
 
 	if (retval < 0) {
-		debug_log(LOG_TYPE_CRIT, "Unable to register the batman interface: %i\n", retval);
+		printk(KERN_ERR  "batman: Unable to register the batman interface: %i\n", retval);
 		goto free_soft_device;
 	}
 
 	start_hardif_check_timer();
 
-	debug_log(LOG_TYPE_CRIT, "B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded \n",
+	printk(KERN_INFO  "B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded \n",
 	          SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
 
 	return 0;
@@ -154,7 +154,7 @@
 		kthread_task = kthread_run(packet_recv_thread, NULL, "batman-adv");
 
 		if (IS_ERR(kthread_task)) {
-			debug_log(LOG_TYPE_CRIT, "Unable to start packet receive thread\n");
+			printk(KERN_ERR  "batman: Unable to start packet receive thread\n");
 			kthread_task = NULL;
 		}
 	}
@@ -163,7 +163,7 @@
 	goto end;
 
 err:
-	debug_log(LOG_TYPE_CRIT, "Unable to allocate memory for mesh information structures: out of mem ?\n");
+	printk(KERN_ERR  "batman: Unable to allocate memory for mesh information structures: out of mem ?\n");
 	shutdown_module();
 end:
 	return;
Index: batman-adv-kernelland/routing.c
===================================================================
--- batman-adv-kernelland/routing.c	(revision 1411)
+++ batman-adv-kernelland/routing.c	(working copy)
@@ -156,7 +156,7 @@
 		swaphash = hash_resize(orig_hash, orig_hash->size * 2);
 
 		if (swaphash == NULL)
-			debug_log(LOG_TYPE_CRIT, "Couldn't resize orig hash table \n");
+			printk(KERN_WARNING "batman: Couldn't resize orig hash table \n");
 		else
 			orig_hash = swaphash;
 	}
@@ -617,7 +617,7 @@
 	atomic_set(&exit_cond, 0);
 	packet_buff = kmalloc(PACKBUFF_SIZE, GFP_KERNEL);
 	if (!packet_buff) {
-		debug_log(LOG_TYPE_CRIT, "Could allocate memory for the packet buffer. :(\n");
+		printk(KERN_ERR "batman: Couldn't allocate memory for the packet buffer. :(\n");
 		return -1;
 	}
 
@@ -640,8 +640,8 @@
 			while (1) {
 				if (batman_if->if_active != IF_ACTIVE) {
 					if (batman_if->if_active != IF_TO_BE_ACTIVATED)
-						debug_log(LOG_TYPE_NOTICE,
-						          "Could not read from deactivated interface %s!\n",
+						printk(KERN_DEBUG
+						       "batman: Could not read from deactivated interface %s!\n",
 						          batman_if->dev);
 
 					if (batman_if->raw_sock)
@@ -748,7 +748,7 @@
 						addr_to_string(src_str, icmp_packet->orig);
 						addr_to_string(dst_str, icmp_packet->dst);
 
-						debug_log(LOG_TYPE_NOTICE, "Error - can't send packet from %s to %s: ttl exceeded\n", src_str, dst_str);
+						printk(KERN_DEBUG "batman: Can't send packet from %s to %s: ttl exceeded\n", src_str, dst_str);
 
 						/* send TTL exceeded if packet is an echo request (traceroute) */
 						if (icmp_packet->msg_type != ECHO_REQUEST)
@@ -829,7 +829,7 @@
 						addr_to_string(src_str, ((struct ethhdr *)(unicast_packet + 1))->h_source);
 						addr_to_string(dst_str, unicast_packet->dest);
 
-						debug_log(LOG_TYPE_NOTICE, "Error - can't send packet from %s to %s: ttl exceeded\n", src_str, dst_str);
+						printk(KERN_DEBUG "batman: Can't send packet from %s to %s: ttl exceeded\n", src_str, dst_str);
 						continue;
 					}
 
@@ -942,8 +942,9 @@
 
 			}
 
-			if ((result < 0) && (result != -EAGAIN))
-				debug_log(LOG_TYPE_CRIT, "Could not receive packet from interface %s: %i\n", batman_if->dev, result);
+			if ((result < 0) && (result != -EAGAIN) &&
+			    printk_ratelimit())
+				printk(KERN_WARNING "batman: Could not receive packet from interface %s: %i\n", batman_if->dev, result);
 
 			/* lock for the next iteration */
 			rcu_read_lock();
Index: batman-adv-kernelland/main.h
===================================================================
--- batman-adv-kernelland/main.h	(revision 1411)
+++ batman-adv-kernelland/main.h	(working copy)
@@ -66,19 +66,9 @@
  * Logging
  */
 
-#define LOG_TYPE_CRIT 0		/* highest priority for fatal errors such as
-				 * blocked sockets / failed packet delivery /
-				 * programming errors */
-#define LOG_TYPE_WARN 1		/* warnings for small errors like wrong user
-				 * input / damaged packets / etc */
-#define LOG_TYPE_NOTICE 2	/* notice information for new interfaces /
-				 * changed settings / new originators / etc */
 #define LOG_TYPE_BATMAN 4	/* all messages related to routing / flooding /
 				 * broadcasting / etc */
 #define LOG_TYPE_ROUTES 8	/* route or hna added / changed / deleted */
-#define LOG_TYPE_CRIT_NAME	"critical"
-#define LOG_TYPE_WARN_NAME	"warnings"
-#define LOG_TYPE_NOTICE_NAME	"notices"
 #define LOG_TYPE_BATMAN_NAME	"batman"
 #define LOG_TYPE_ROUTES_NAME	"routes"
 
