Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri,  7 May 2010 21:47:30 +0200
Message-Id: <1273261651-21378-26-git-send-email-andrew@lunn.ch>
In-Reply-To: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
References: <1273261651-21378-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 25/26] Staging: batman-adv: Reduce max
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
To: greg@kroah.com
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Sven Eckelmann <sven.eckelmann@gmx.de>

Documentation/CodingStyle sets a strongly prefered limit of 80
characters per line in "Chapter 2: Breaking long lines and strings".

Strings must be broken into smaller parts and long statements must be
rewritten.

Reported-by: Mikal Sande <mikal.sande@gmail.com>
Reported-by: Mark Rankilor <reodge@gmail.com>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/device.c            |   22 +++++++---
 drivers/staging/batman-adv/hard-interface.c    |   20 ++++++---
 drivers/staging/batman-adv/main.c              |   17 +++++---
 drivers/staging/batman-adv/main.h              |    3 +-
 drivers/staging/batman-adv/originator.c        |   47 ++++++++++++-------
 drivers/staging/batman-adv/routing.c           |   57 +++++++++++++++++------
 drivers/staging/batman-adv/send.c              |   21 +++++---
 drivers/staging/batman-adv/soft-interface.c    |    8 ++-
 drivers/staging/batman-adv/translation-table.c |   34 +++++++++-----
 drivers/staging/batman-adv/types.h             |   45 +++++++++++++-----
 10 files changed, 186 insertions(+), 88 deletions(-)

diff --git a/drivers/staging/batman-adv/device.c b/drivers/staging/batman-adv/device.c
index b2ecba2..ad82ec4 100644
--- a/drivers/staging/batman-adv/device.c
+++ b/drivers/staging/batman-adv/device.c
@@ -57,7 +57,8 @@ int bat_device_setup(void)
 	/* register our device - kernel assigns a free major number */
 	tmp_major = register_chrdev(0, DRIVER_DEVICE, &fops);
 	if (tmp_major < 0) {
-		printk(KERN_ERR "batman-adv:Registering the character device failed with %d\n",
+		printk(KERN_ERR "batman-adv:"
+		       "Registering the character device failed with %d\n",
 			  tmp_major);
 		return 0;
 	}
@@ -65,7 +66,8 @@ int bat_device_setup(void)
 	batman_class = class_create(THIS_MODULE, "batman-adv");
 
 	if (IS_ERR(batman_class)) {
-		printk(KERN_ERR "batman-adv:Could not register class 'batman-adv'\n");
+		printk(KERN_ERR "batman-adv:"
+		       "Could not register class 'batman-adv'\n");
 		return 0;
 	}
 
@@ -108,7 +110,9 @@ int bat_device_open(struct inode *inode, struct file *file)
 	}
 
 	if (i == ARRAY_SIZE(device_client_hash)) {
-		printk(KERN_ERR "batman-adv:Error - can't add another packet client: maximum number of clients reached\n");
+		printk(KERN_ERR "batman-adv:"
+		       "Error - can't add another packet client: "
+		       "maximum number of clients reached\n");
 		kfree(device_client);
 		return -EXFULL;
 	}
@@ -209,7 +213,9 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
 	unsigned long flags;
 
 	if (len < sizeof(struct icmp_packet)) {
-		bat_dbg(DBG_BATMAN, "batman-adv:Error - can't send packet from char device: invalid packet size\n");
+		bat_dbg(DBG_BATMAN, "batman-adv:"
+			"Error - can't send packet from char device: "
+			"invalid packet size\n");
 		return -EINVAL;
 	}
 
@@ -220,12 +226,16 @@ ssize_t bat_device_write(struct file *file, const char __user *buff,
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
 
diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index b82cae7..0d1d101 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -149,9 +149,12 @@ static void check_known_mac_addr(uint8_t *addr)
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
@@ -242,7 +245,8 @@ int hardif_enable_interface(struct batman_if *batman_if)
 	batman_if->packet_buff = kmalloc(batman_if->packet_len, GFP_ATOMIC);
 
 	if (!batman_if->packet_buff) {
-		printk(KERN_ERR "batman-adv:Can't add interface packet (%s): out of memory\n",
+		printk(KERN_ERR "batman-adv:"
+		       "Can't add interface packet (%s): out of memory\n",
 		       batman_if->dev);
 		goto err;
 	}
@@ -266,7 +270,10 @@ int hardif_enable_interface(struct batman_if *batman_if)
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
@@ -316,7 +323,8 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 
 	batman_if = kmalloc(sizeof(struct batman_if), GFP_ATOMIC);
 	if (!batman_if) {
-		printk(KERN_ERR "batman-adv:Can't add interface (%s): out of memory\n",
+		printk(KERN_ERR "batman-adv:"
+		       "Can't add interface (%s): out of memory\n",
 		       net_dev->name);
 		goto out;
 	}
diff --git a/drivers/staging/batman-adv/main.c b/drivers/staging/batman-adv/main.c
index aa072d1..9d13979 100644
--- a/drivers/staging/batman-adv/main.c
+++ b/drivers/staging/batman-adv/main.c
@@ -99,14 +99,16 @@ int init_module(void)
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
 
@@ -118,8 +120,9 @@ int init_module(void)
 	register_netdevice_notifier(&hard_if_notifier);
 	dev_add_pack(&batman_adv_packet_type);
 
-	printk(KERN_INFO "batman-adv:B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded\n",
-		  SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
+	printk(KERN_INFO "batman-adv:"
+	       "B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded\n",
+	       SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
 
 	return 0;
 
@@ -176,7 +179,9 @@ void activate_module(void)
 	goto end;
 
 err:
-	printk(KERN_ERR "batman-adv:Unable to allocate memory for mesh information structures: out of mem ?\n");
+	printk(KERN_ERR "batman-adv:"
+	       "Unable to allocate memory for mesh information structures: "
+	       "out of mem ?\n");
 	deactivate_module();
 end:
 	return;
@@ -218,7 +223,7 @@ void dec_module_count(void)
 
 int addr_to_string(char *buff, uint8_t *addr)
 {
-	return sprintf(buff, "%02x:%02x:%02x:%02x:%02x:%02x",
+	return sprintf(buff, MAC_FMT,
 		       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
 }
 
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index 8818e2b..5f8343d 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -22,7 +22,8 @@
 /* Kernel Programming */
 #define LINUX
 
-#define DRIVER_AUTHOR "Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>"
+#define DRIVER_AUTHOR "Marek Lindner <lindner_marek@yahoo.de>, " \
+		      "Simon Wunderlich <siwu@hrz.tu-chemnitz.de>"
 #define DRIVER_DESC   "B.A.T.M.A.N. advanced"
 #define DRIVER_DEVICE "batman-adv"
 
diff --git a/drivers/staging/batman-adv/originator.c b/drivers/staging/batman-adv/originator.c
index 25a9e21..568aef8 100644
--- a/drivers/staging/batman-adv/originator.c
+++ b/drivers/staging/batman-adv/originator.c
@@ -140,8 +140,10 @@ struct orig_node *get_orig_node(uint8_t *addr)
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
 
@@ -198,11 +200,15 @@ static bool purge_orig_neighbors(struct orig_node *orig_node,
 
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
 
@@ -280,24 +286,25 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
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
+	else if (bat_priv->primary_if->if_status != IF_ACTIVE)
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
@@ -366,7 +373,8 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 	data_ptr = kmalloc(max_if_num * sizeof(TYPE_OF_WORD) * NUM_WORDS,
 			   GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		printk(KERN_ERR
+		       "batman-adv:Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -377,7 +385,8 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		printk(KERN_ERR
+		       "batman-adv:Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -426,7 +435,8 @@ static int orig_node_del_if(struct orig_node *orig_node,
 	chunk_size = sizeof(TYPE_OF_WORD) * NUM_WORDS;
 	data_ptr = kmalloc(max_if_num * chunk_size, GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		printk(KERN_ERR
+		       "batman-adv:Can't resize orig: out of memory\n");
 		return -1;
 	}
 
@@ -447,7 +457,8 @@ free_bcast_own:
 
 	data_ptr = kmalloc(max_if_num * sizeof(uint8_t), GFP_ATOMIC);
 	if (!data_ptr) {
-		printk(KERN_ERR "batman-adv:Can't resize orig: out of memory\n");
+		printk(KERN_ERR
+		       "batman-adv:Can't resize orig: out of memory\n");
 		return -1;
 	}
 
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 919a4f8..066dc8b 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -94,7 +94,11 @@ static void update_route(struct orig_node *orig_node,
 
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
@@ -207,7 +211,11 @@ static int isBidirectionalNeigh(struct orig_node *orig_node,
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
@@ -229,7 +237,8 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	int tmp_hna_buff_len;
 
-	bat_dbg(DBG_BATMAN, "update_originator(): Searching and updating originator entry of received packet\n");
+	bat_dbg(DBG_BATMAN, "update_originator(): "
+		"Searching and updating originator entry of received packet\n");
 
 	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
 		if (compare_orig(tmp_neigh_node->addr, ethhdr->h_source) &&
@@ -422,7 +431,9 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	is_single_hop_neigh = (compare_orig(ethhdr->h_source,
 					    batman_packet->orig) ? 1 : 0);
 
-	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] (from OG: %pM, via prev OG: %pM, seqno %d, tq %d, TTL %d, V %d, IDF %d)\n",
+	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] "
+		"(from OG: %pM, via prev OG: %pM, seqno %d, tq %d, "
+		"TTL %d, V %d, IDF %d)\n",
 		ethhdr->h_source, if_incoming->dev, if_incoming->addr_str,
 		batman_packet->orig, batman_packet->prev_sender,
 		batman_packet->seqno, batman_packet->tq, batman_packet->ttl,
@@ -457,13 +468,16 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 
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
 
@@ -491,12 +505,15 @@ void receive_bat_packet(struct ethhdr *ethhdr,
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
+			"Drop packet: ignoring all rebroadcast echos (sender: "
+			"%pM)\n", ethhdr->h_source);
 		return;
 	}
 
@@ -507,12 +524,15 @@ void receive_bat_packet(struct ethhdr *ethhdr,
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
 
@@ -524,7 +544,9 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	    !(compare_orig(batman_packet->orig, batman_packet->prev_sender)) &&
 	    (compare_orig(orig_node->router->addr,
 			  orig_node->router->orig_node->router->addr))) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %pM)\n", ethhdr->h_source);
+		bat_dbg(DBG_BATMAN,
+			"Drop packet: ignoring all rebroadcast packets that "
+			"may make me loop (sender: %pM)\n", ethhdr->h_source);
 		return;
 	}
 
@@ -562,7 +584,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		schedule_forward_packet(orig_node, ethhdr, batman_packet,
 					1, hna_buff_len, if_incoming);
 
-		bat_dbg(DBG_BATMAN, "Forwarding packet: rebroadcast neighbor packet with direct link flag\n");
+		bat_dbg(DBG_BATMAN, "Forwarding packet: "
+			"rebroadcast neighbor packet with direct link flag\n");
 		return;
 	}
 
@@ -708,8 +731,10 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
 
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
 
@@ -874,7 +899,9 @@ int recv_unicast_packet(struct sk_buff *skb)
 
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
-		printk(KERN_WARNING "batman-adv:Warning - can't forward unicast packet from %pM to %pM: ttl exceeded\n",
+		printk(KERN_WARNING "batman-adv:Warning - "
+		       "can't forward unicast packet from %pM to %pM: "
+		       "ttl exceeded\n",
 		       ethhdr->h_source, unicast_packet->dest);
 		return NET_RX_DROP;
 	}
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index f58a9ed..d8536e2 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -65,7 +65,8 @@ int send_skb_packet(struct sk_buff *skb,
 
 	if (!(batman_if->net_dev->flags & IFF_UP)) {
 		printk(KERN_WARNING
-		       "batman-adv:Interface %s is not up - can't send packet via that interface!\n",
+		       "batman-adv:Interface %s "
+		       "is not up - can't send packet via that interface!\n",
 		       batman_if->dev);
 		goto send_skb_err;
 	}
@@ -148,9 +149,9 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 							    "Sending own" :
 							    "Forwarding"));
 		bat_dbg(DBG_BATMAN,
-			"%s %spacket (originator %pM, seqno %d, TQ %d, TTL %d, IDF %s) on interface %s [%s]\n",
-			fwd_str,
-			(packet_num > 0 ? "aggregated " : ""),
+			"%s %spacket (originator %pM, seqno %d, TQ %d, TTL %d,"
+			" IDF %s) on interface %s [%s]\n",
+			fwd_str, (packet_num > 0 ? "aggregated " : ""),
 			batman_packet->orig, ntohs(batman_packet->seqno),
 			batman_packet->tq, batman_packet->ttl,
 			(batman_packet->flags & DIRECTLINK ?
@@ -178,7 +179,8 @@ static void send_packet(struct forw_packet *forw_packet)
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
 
 	if (!forw_packet->if_incoming) {
-		printk(KERN_ERR "batman-adv: Error - can't forward packet: incoming iface not specified\n");
+		printk(KERN_ERR "batman-adv: Error - can't forward packet: "
+		       "incoming iface not specified\n");
 		return;
 	}
 
@@ -192,7 +194,8 @@ static void send_packet(struct forw_packet *forw_packet)
 
 		/* FIXME: what about aggregated packets ? */
 		bat_dbg(DBG_BATMAN,
-			"%s packet (originator %pM, seqno %d, TTL %d) on interface %s [%s]\n",
+			"%s packet (originator %pM, seqno %d, TTL %d) "
+			"on interface %s [%s]\n",
 			(forw_packet->own ? "Sending own" : "Forwarding"),
 			batman_packet->orig, ntohs(batman_packet->seqno),
 			batman_packet->ttl, forw_packet->if_incoming->dev,
@@ -322,7 +325,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 			batman_packet->tq = orig_node->router->tq_avg;
 
 			if (orig_node->router->last_ttl)
-				batman_packet->ttl = orig_node->router->last_ttl - 1;
+				batman_packet->ttl = orig_node->router->last_ttl
+							- 1;
 		}
 
 		tq_avg = orig_node->router->tq_avg;
@@ -331,7 +335,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	/* apply hop penalty */
 	batman_packet->tq = hop_penalty(batman_packet->tq);
 
-	bat_dbg(DBG_BATMAN, "Forwarding packet: tq_orig: %i, tq_avg: %i, tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
+	bat_dbg(DBG_BATMAN, "Forwarding packet: tq_orig: %i, tq_avg: %i, "
+		"tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
 		in_tq, tq_avg, batman_packet->tq, in_ttl - 1,
 		batman_packet->ttl);
 
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index c3b5288..51c40b7 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
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
diff --git a/drivers/staging/batman-adv/translation-table.c b/drivers/staging/batman-adv/translation-table.c
index c7a6635..e01ff21 100644
--- a/drivers/staging/batman-adv/translation-table.c
+++ b/drivers/staging/batman-adv/translation-table.c
@@ -77,7 +77,10 @@ void hna_local_add(uint8_t *addr)
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
 
@@ -108,7 +111,8 @@ void hna_local_add(uint8_t *addr)
 				       hna_local_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR "batman-adv:Couldn't resize local hna hash table\n");
+			printk(KERN_ERR "batman-adv:"
+			       "Couldn't resize local hna hash table\n");
 		else
 			hna_local_hash = swaphash;
 	}
@@ -169,14 +173,16 @@ int hna_local_fill_buffer_text(struct net_device *net_dev, char *buff,
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
@@ -196,7 +202,7 @@ int hna_local_fill_buffer_text(struct net_device *net_dev, char *buff,
 		hna_local_entry = hashit.bucket->data;
 
 		bytes_written += snprintf(buff + bytes_written, 22,
-					  " * %02x:%02x:%02x:%02x:%02x:%02x\n",
+					  " * " MAC_FMT "\n",
 					  hna_local_entry->addr[0],
 					  hna_local_entry->addr[1],
 					  hna_local_entry->addr[2],
@@ -317,7 +323,8 @@ void hna_global_add_orig(struct orig_node *orig_node,
 			memcpy(hna_global_entry->addr, hna_ptr, ETH_ALEN);
 
 			bat_dbg(DBG_ROUTES,
-				"Creating new global hna entry: %pM (via %pM)\n",
+				"Creating new global hna entry: "
+				"%pM (via %pM)\n",
 				hna_global_entry->addr, orig_node->orig);
 
 			spin_lock_irqsave(&hna_global_hash_lock, flags);
@@ -362,7 +369,8 @@ void hna_global_add_orig(struct orig_node *orig_node,
 				       hna_global_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR "batman-adv:Couldn't resize global hna hash table\n");
+			printk(KERN_ERR "batman-adv:"
+			       "Couldn't resize global hna hash table\n");
 		else
 			hna_global_hash = swaphash;
 	}
@@ -383,14 +391,16 @@ int hna_global_fill_buffer_text(struct net_device *net_dev, char *buff,
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
@@ -410,7 +420,7 @@ int hna_global_fill_buffer_text(struct net_device *net_dev, char *buff,
 		hna_global_entry = hashit.bucket->data;
 
 		bytes_written += snprintf(buff + bytes_written, 44,
-					  " * %02x:%02x:%02x:%02x:%02x:%02x via %02x:%02x:%02x:%02x:%02x:%02x\n",
+					  " * " MAC_FMT " via " MAC_FMT "\n",
 					  hna_global_entry->addr[0],
 					  hna_global_entry->addr[1],
 					  hna_global_entry->addr[2],
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 0b1fe9e..86007c7 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -29,7 +29,10 @@
 #include "packet.h"
 #include "bitarray.h"
 
-#define BAT_HEADER_LEN (sizeof(struct ethhdr) + ((sizeof(struct unicast_packet) > sizeof(struct bcast_packet) ? sizeof(struct unicast_packet) : sizeof(struct bcast_packet))))
+#define BAT_HEADER_LEN (sizeof(struct ethhdr) + \
+	((sizeof(struct unicast_packet) > sizeof(struct bcast_packet) ? \
+	 sizeof(struct unicast_packet) : \
+	 sizeof(struct bcast_packet))))
 
 
 struct batman_if {
@@ -47,28 +50,40 @@ struct batman_if {
 
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
@@ -77,7 +92,7 @@ struct neigh_node {
 	uint8_t tq_index;
 	uint8_t tq_avg;
 	uint8_t last_ttl;
-	unsigned long last_valid;            /* when last packet via this neighbor was received */
+	unsigned long last_valid;
 	TYPE_OF_WORD real_bits[NUM_WORDS];
 	struct orig_node *orig_node;
 	struct batman_if *if_incoming;
@@ -117,7 +132,11 @@ struct hna_global_entry {
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

