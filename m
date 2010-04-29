Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 29 Apr 2010 16:22:24 +0200
Message-Id: <1272550944-8522-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201004291621.08579.sven.eckelmann@gmx.de>
References: <201004291621.08579.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH-maint 2/2] batman-adv: Reduce max characters
	on a line to 80
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
 device.c            |   22 ++++++++++++++-----
 hard-interface.c    |   19 +++++++++++-----
 main.c              |   17 +++++++++-----
 main.h              |    3 +-
 originator.c        |   37 ++++++++++++++++++++++----------
 proc.c              |   15 +++++++++---
 routing.c           |   58 +++++++++++++++++++++++++++++++++++++-------------
 send.c              |   19 +++++++++++-----
 soft-interface.c    |    8 ++++--
 translation-table.c |   34 +++++++++++++++++++----------
 types.h             |   46 ++++++++++++++++++++++++++++------------
 11 files changed, 193 insertions(+), 85 deletions(-)

diff --git a/device.c b/device.c
index 5f7655b..bbd30f2 100644
--- a/device.c
+++ b/device.c
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
@@ -210,7 +214,9 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 	unsigned long flags;
 
 	if (len < sizeof(struct icmp_packet)) {
-		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from char device: invalid packet size\n");
+		bat_dbg(DBG_BATMAN, "batman-adv:"
+			"Error - can't send packet from char device: "
+			"invalid packet size\n");
 		return -EINVAL;
 	}
 
@@ -221,12 +227,16 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
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
 
diff --git a/hard-interface.c b/hard-interface.c
index 5799d6d..0a0ae9d 100644
--- a/hard-interface.c
+++ b/hard-interface.c
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
@@ -267,7 +271,9 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	if (hardif_is_iface_up(batman_if))
 		hardif_activate_interface(bat_priv, batman_if);
 	else
-		printk(KERN_ERR "batman-adv:Not using interface %s (retrying later): interface not active\n", batman_if->dev);
+		printk(KERN_ERR "batman-adv:"
+		       "Not using interface %s (retrying later): "
+		       "interface not active\n", batman_if->dev);
 
 	/* begin scheduling originator messages on that interface */
 	schedule_own_packet(batman_if);
@@ -317,7 +323,8 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 
 	batman_if = kmalloc(sizeof(struct batman_if), GFP_ATOMIC);
 	if (!batman_if) {
-		printk(KERN_ERR "batman-adv:Can't add interface (%s): out of memory\n",
+		printk(KERN_ERR "batman-adv:"
+		       "Can't add interface (%s): out of memory\n",
 		       net_dev->name);
 		goto out;
 	}
diff --git a/main.c b/main.c
index 17810d0..6c39990 100644
--- a/main.c
+++ b/main.c
@@ -100,14 +100,16 @@ int init_module(void)
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
 
@@ -119,8 +121,9 @@ int init_module(void)
 	register_netdevice_notifier(&hard_if_notifier);
 	dev_add_pack(&batman_adv_packet_type);
 
-	printk(KERN_INFO "batman-adv:B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded\n",
-		  SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
+	printk(KERN_INFO "batman-adv:"
+	       "B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded\n",
+	       SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
 
 	return 0;
 
@@ -177,7 +180,9 @@ void activate_module(void)
 	goto end;
 
 err:
-	printk(KERN_ERR "batman-adv:Unable to allocate memory for mesh information structures: out of mem ?\n");
+	printk(KERN_ERR "batman-adv:"
+	       "Unable to allocate memory for mesh information structures: "
+	       "out of mem ?\n");
 	deactivate_module();
 end:
 	return;
@@ -219,7 +224,7 @@ void dec_module_count(void)
 
 int addr_to_string(char *buff, uint8_t *addr)
 {
-	return sprintf(buff, "%02x:%02x:%02x:%02x:%02x:%02x",
+	return sprintf(buff, MAC_FMT,
 		       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
 }
 
diff --git a/main.h b/main.h
index a2e819b..8d6c1a0 100644
--- a/main.h
+++ b/main.h
@@ -22,7 +22,8 @@
 /* Kernel Programming */
 #define LINUX
 
-#define DRIVER_AUTHOR "Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>"
+#define DRIVER_AUTHOR "Marek Lindner <lindner_marek@yahoo.de>, " \
+		      "Simon Wunderlich <siwu@hrz.tu-chemnitz.de>"
 #define DRIVER_DESC   "B.A.T.M.A.N. advanced"
 #define DRIVER_DEVICE "batman-adv"
 
diff --git a/originator.c b/originator.c
index 3a9430c..a2c60d0 100644
--- a/originator.c
+++ b/originator.c
@@ -141,8 +141,10 @@ struct orig_node *get_orig_node(uint8_t *addr)
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
 
@@ -199,11 +201,15 @@ static bool purge_orig_neighbors(struct orig_node *orig_node,
 
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
 
@@ -281,8 +287,9 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
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
@@ -290,7 +297,8 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 	if (bat_priv->primary_if->if_status != IF_ACTIVE) {
 		if (off == 0)
 			return sprintf(buff,
-				       "BATMAN mesh %s disabled - primary interface not active\n",
+				       "BATMAN mesh %s disabled - "
+				       "primary interface not active\n",
 				       net_dev->name);
 
 		return 0;
@@ -298,7 +306,8 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 	rcu_read_lock();
 	hdr_len = sprintf(buff,
-		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
+		   "  %-14s (%s/%i) %17s [%10s]: %20s ... "
+		   "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
 		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
 		   "Potential nexthops", SOURCE_VERSION, REVISION_VERSION_STR,
 		   bat_priv->primary_if->dev, bat_priv->primary_if->addr_str,
@@ -367,7 +376,8 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 	data_ptr = kmalloc(max_if_num * sizeof(TYPE_OF_WORD) * NUM_WORDS,
 			   GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		printk(KERN_ERR
+		       "batman-adv:Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -378,7 +388,8 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		printk(KERN_ERR
+		       "batman-adv:Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -427,7 +438,8 @@ static int orig_node_del_if(struct orig_node *orig_node,
 	chunk_size = sizeof(TYPE_OF_WORD) * NUM_WORDS;
 	data_ptr = kmalloc(max_if_num * chunk_size, GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		printk(KERN_ERR
+		       "batman-adv:Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -448,7 +460,8 @@ free_bcast_own:
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		printk(KERN_ERR
+		       "batman-adv:Can't resize orig: out of memory\n");
 		return -1;
 	}
 
diff --git a/proc.c b/proc.c
index 2bc474e..8526e7e 100644
--- a/proc.c
+++ b/proc.c
@@ -68,7 +68,8 @@ static ssize_t proc_interfaces_write(struct file *instance,
 		return -ENOMEM;
 
 	if (count > IFNAMSIZ - 1) {
-		printk(KERN_WARNING "batman-adv:Can't add interface: device name is too long\n");
+		printk(KERN_WARNING "batman-adv:"
+		       "Can't add interface: device name is too long\n");
 		goto end;
 	}
 
@@ -95,7 +96,9 @@ static ssize_t proc_interfaces_write(struct file *instance,
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
 		if (strncmp(batman_if->dev, if_string, count) == 0) {
-			printk(KERN_ERR "batman-adv:Given interface is already active: %s\n", if_string);
+			printk(KERN_ERR "batman-adv:"
+			       "Given interface is already active: %s\n",
+			       if_string);
 			rcu_read_unlock();
 			goto end;
 
@@ -152,7 +155,9 @@ int setup_procfs(void)
 #endif
 
 	if (!proc_batman_dir) {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s' folder failed\n", PROC_ROOT_DIR);
+		printk(KERN_ERR "batman-adv:"
+		       "Registering the '/proc/net/%s' folder failed\n",
+		       PROC_ROOT_DIR);
 		return -EFAULT;
 	}
 
@@ -162,7 +167,9 @@ int setup_procfs(void)
 	if (proc_interface_file) {
 		proc_interface_file->proc_fops = &proc_interfaces_fops;
 	} else {
-		printk(KERN_ERR "batman-adv: Registering the '/proc/net/%s/%s' file failed\n", PROC_ROOT_DIR, PROC_FILE_INTERFACES);
+		printk(KERN_ERR "batman-adv:"
+		       "Registering the '/proc/net/%s/%s' file failed\n",
+		       PROC_ROOT_DIR, PROC_FILE_INTERFACES);
 		cleanup_procfs();
 		return -EFAULT;
 	}
diff --git a/routing.c b/routing.c
index 0ab8f89..d12c914 100644
--- a/routing.c
+++ b/routing.c
@@ -95,7 +95,11 @@ static void update_route(struct orig_node *orig_node,
 
 		/* route changed */
 	} else {
-		bat_dbg(DBG_ROUTES, "Changing route towards: %pM (now via %pM - was via %pM)\n", orig_node->orig, neigh_node->addr, orig_node->router->addr);
+		bat_dbg(DBG_ROUTES,
+			"Changing route towards: "
+			"%pM (now via %pM - was via %pM)\n",
+			orig_node->orig, neigh_node->addr,
+			orig_node->router->addr);
 	}
 
 	orig_node->router = neigh_node;
@@ -208,7 +212,11 @@ static int isBidirectionalNeigh(struct orig_node *orig_node,
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
@@ -230,7 +238,8 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	int tmp_hna_buff_len;
 
-	bat_dbg(DBG_BATMAN, "update_originator(): Searching and updating originator entry of received packet\n");
+	bat_dbg(DBG_BATMAN, "update_originator(): "
+		"Searching and updating originator entry of received packet\n");
 
 	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
 		if (compare_orig(tmp_neigh_node->addr, ethhdr->h_source) &&
@@ -423,7 +432,9 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	is_single_hop_neigh = (compare_orig(ethhdr->h_source,
 					    batman_packet->orig) ? 1 : 0);
 
-	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] (from OG: %pM, via prev OG: %pM, seqno %d, tq %d, TTL %d, V %d, IDF %d)\n",
+	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] "
+		"(from OG: %pM, via prev OG: %pM, seqno %d, tq %d, "
+		"TTL %d, V %d, IDF %d)\n",
 		ethhdr->h_source, if_incoming->dev, if_incoming->addr_str,
 		batman_packet->orig, batman_packet->prev_sender,
 		batman_packet->seqno, batman_packet->tq, batman_packet->ttl,
@@ -458,13 +469,16 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 
 	if (is_my_addr) {
 		bat_dbg(DBG_BATMAN,
-			"Drop packet: received my own broadcast (sender: %pM)\n",
+			"Drop packet: received my own broadcast "
+			"(sender: %pM)\n",
 			ethhdr->h_source);
 		return;
 	}
 
 	if (is_broadcast) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all packets with broadcast source addr (sender: %pM)\n", ethhdr->h_source);
+		bat_dbg(DBG_BATMAN, "Drop packet: "
+		"ignoring all packets with broadcast source addr "
+		"(sender: %pM)\n", ethhdr->h_source);
 		return;
 	}
 
@@ -492,12 +506,15 @@ void receive_bat_packet(struct ethhdr *ethhdr,
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
 
@@ -508,12 +525,15 @@ void receive_bat_packet(struct ethhdr *ethhdr,
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
 
@@ -525,7 +545,9 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	    !(compare_orig(batman_packet->orig, batman_packet->prev_sender)) &&
 	    (compare_orig(orig_node->router->addr,
 			  orig_node->router->orig_node->router->addr))) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %pM)\n", ethhdr->h_source);
+		bat_dbg(DBG_BATMAN,
+			"Drop packet: ignoring all rebroadcast packets that "
+			"may make me loop (sender: %pM)\n", ethhdr->h_source);
 		return;
 	}
 
@@ -563,7 +585,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		schedule_forward_packet(orig_node, ethhdr, batman_packet,
 					1, hna_buff_len, if_incoming);
 
-		bat_dbg(DBG_BATMAN, "Forwarding packet: rebroadcast neighbor packet with direct link flag\n");
+		bat_dbg(DBG_BATMAN, "Forwarding packet: "
+			"rebroadcast neighbor packet with direct link flag\n");
 		return;
 	}
 
@@ -709,8 +732,10 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
 
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
 
@@ -875,7 +900,10 @@ int recv_unicast_packet(struct sk_buff *skb)
 
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
-		printk(KERN_WARNING "batman-adv:Warning - can't forward unicast packet from %pM to %pM: ttl exceeded\n", ethhdr->h_source, unicast_packet->dest);
+		printk(KERN_WARNING "batman-adv:Warning - "
+		       "can't forward unicast packet from %pM to %pM: "
+		       "ttl exceeded\n",
+		       ethhdr->h_source, unicast_packet->dest);
 		return NET_RX_DROP;
 	}
 
diff --git a/send.c b/send.c
index caec6ef..7f3031d 100644
--- a/send.c
+++ b/send.c
@@ -67,7 +67,8 @@ int send_skb_packet(struct sk_buff *skb,
 
 	if (!(batman_if->net_dev->flags & IFF_UP)) {
 		printk(KERN_WARNING
-		       "batman-adv:Interface %s is not up - can't send packet via that interface!\n",
+		       "batman-adv:Interface %s is not up - "
+		       "can't send packet via that interface!\n",
 		       batman_if->dev);
 		goto send_skb_err;
 	}
@@ -149,7 +150,9 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 							    "Sending own" :
 							    "Forwarding"));
 		bat_dbg(DBG_BATMAN,
-			"%s %spacket (originator %pM, seqno %d, TQ %d, TTL %d, IDF %s) on interface %s [%s]\n",
+			"%s %spacket "
+			"(originator %pM, seqno %d, TQ %d, TTL %d, IDF %s) "
+			"on interface %s [%s]\n",
 			fwd_str,
 			(packet_num > 0 ? "aggregated " : ""),
 			batman_packet->orig, ntohs(batman_packet->seqno),
@@ -179,7 +182,8 @@ static void send_packet(struct forw_packet *forw_packet)
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
 
 	if (!forw_packet->if_incoming) {
-		printk(KERN_ERR "batman-adv: Error - can't forward packet: incoming iface not specified\n");
+		printk(KERN_ERR "batman-adv: Error - can't forward packet: "
+		       "incoming iface not specified\n");
 		return;
 	}
 
@@ -193,7 +197,8 @@ static void send_packet(struct forw_packet *forw_packet)
 
 		/* FIXME: what about aggregated packets ? */
 		bat_dbg(DBG_BATMAN,
-			"%s packet (originator %pM, seqno %d, TTL %d) on interface %s [%s]\n",
+			"%s packet (originator %pM, seqno %d, TTL %d) "
+			"on interface %s [%s]\n",
 			(forw_packet->own ? "Sending own" : "Forwarding"),
 			batman_packet->orig, ntohs(batman_packet->seqno),
 			batman_packet->ttl, forw_packet->if_incoming->dev,
@@ -323,7 +328,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 			batman_packet->tq = orig_node->router->tq_avg;
 
 			if (orig_node->router->last_ttl)
-				batman_packet->ttl = orig_node->router->last_ttl - 1;
+				batman_packet->ttl = orig_node->router->last_ttl
+							- 1;
 		}
 
 		tq_avg = orig_node->router->tq_avg;
@@ -332,7 +338,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	/* apply hop penalty */
 	batman_packet->tq = hop_penalty(batman_packet->tq);
 
-	bat_dbg(DBG_BATMAN, "Forwarding packet: tq_orig: %i, tq_avg: %i, tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
+	bat_dbg(DBG_BATMAN, "Forwarding packet: tq_orig: %i, tq_avg: %i, "
+		"tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
 		in_tq, tq_avg, batman_packet->tq, in_ttl - 1,
 		batman_packet->ttl);
 
diff --git a/soft-interface.c b/soft-interface.c
index 37a1f44..2a2f079 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -237,6 +237,8 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 
 		if ((orig_node) &&
 		    (orig_node->router)) {
+			struct neigh_node *router = orig_node->router;
+
 			if (my_skb_push(skb, sizeof(struct unicast_packet)) < 0)
 				goto unlock;
 
@@ -251,14 +253,14 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 			memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
 
 			/* net_dev won't be available when not active */
-			if (orig_node->router->if_incoming->if_status != IF_ACTIVE)
+			if (router->if_incoming->if_status != IF_ACTIVE)
 				goto unlock;
 
 			/* don't lock while sending the packets ... we therefore
 			 * copy the required data before sending */
 
-			batman_if = orig_node->router->if_incoming;
-			memcpy(dstaddr, orig_node->router->addr, ETH_ALEN);
+			batman_if = router->if_incoming;
+			memcpy(dstaddr, router->addr, ETH_ALEN);
 			spin_unlock_irqrestore(&orig_hash_lock, flags);
 
 			send_skb_packet(skb, batman_if, dstaddr);
diff --git a/translation-table.c b/translation-table.c
index 3ce39a6..a60bc7e 100644
--- a/translation-table.c
+++ b/translation-table.c
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
diff --git a/types.h b/types.h
index c0ede3c..86007c7 100644
--- a/types.h
+++ b/types.h
@@ -29,7 +29,10 @@
 #include "packet.h"
 #include "bitarray.h"
 
-#define BAT_HEADER_LEN (sizeof(struct ethhdr) + ((sizeof(struct unicast_packet) > sizeof(struct bcast_packet) ? sizeof(struct unicast_packet) : sizeof(struct bcast_packet))))
+#define BAT_HEADER_LEN (sizeof(struct ethhdr) + \
+	((sizeof(struct unicast_packet) > sizeof(struct bcast_packet) ? \
+	 sizeof(struct unicast_packet) : \
+	 sizeof(struct bcast_packet))))
 
 
 struct batman_if {
@@ -47,29 +50,40 @@ struct batman_if {
 
 };
 
-struct orig_node {               /* structure for orig_list maintaining nodes of mesh */
+/**
+  *	orig_node - structure for orig_list maintaining nodes of mesh
+  *	@last_valid: when last packet from this node was received
+  *	@bcast_seqno_reset: time when the broadcast seqno window was reset
+  *	@batman_seqno_reset: time when the batman seqno window was reset
+  *	@flags: for now only VIS_SERVER flag
+  *	@last_real_seqno: last and best known squence number
+  *	@last_ttl: ttl of last received packet
+  *	@last_bcast_seqno: last broadcast sequence number received by this host
+ */
+struct orig_node {
 	uint8_t orig[ETH_ALEN];
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
-/*	uint8_t  gwflags;		  * flags related to gateway functions: gateway class */
-	uint8_t  flags;			 /* for now only VIS_SERVER flag. */
+	unsigned long last_valid;
+	unsigned long bcast_seqno_reset;
+	unsigned long batman_seqno_reset;
+	uint8_t  flags;
 	unsigned char *hna_buff;
 	int16_t  hna_buff_len;
-	uint16_t last_real_seqno;   /* last and best known squence number */
-	uint8_t last_ttl;         /* ttl of last received packet */
+	uint16_t last_real_seqno;
+	uint8_t last_ttl;
 	TYPE_OF_WORD bcast_bits[NUM_WORDS];
-	uint16_t last_bcast_seqno;  /* last broadcast sequence number received by this host */
+	uint16_t last_bcast_seqno;
 	struct list_head neigh_list;
 };
 
+/**
+  *	neigh_node
+  *	@last_valid: when last packet via this neighbor was received
+ */
 struct neigh_node {
 	struct list_head list;
 	uint8_t addr[ETH_ALEN];
@@ -78,7 +92,7 @@ struct neigh_node {
 	uint8_t tq_index;
 	uint8_t tq_avg;
 	uint8_t last_ttl;
-	unsigned long last_valid;            /* when last packet via this neighbor was received */
+	unsigned long last_valid;
 	TYPE_OF_WORD real_bits[NUM_WORDS];
 	struct orig_node *orig_node;
 	struct batman_if *if_incoming;
@@ -118,7 +132,11 @@ struct hna_global_entry {
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

