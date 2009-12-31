Return-Path: <andrew@lunn.ch>
Date: Thu, 31 Dec 2009 11:52:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091231105246.GI8143@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [Patch 1/1] Staging: batman-adv: Use printk(%pM) for
	MAC addresses
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

printk() since kernel version 2.6.29 has supported printing MAC
addresses directly, as an extension to the %p processing. This patch
makes use of this for printk() and bat_dbg(). This will remove the
overhead of using addr_to_string() which is normally never actually
output.

For kernels older than 2.6.29 the printk support from 2.6.31 has been
imported into batman-adv and will be used for formatting the output
before passing it onto the native printk() function.

Fix the typo found by Gus Wirth.
grep pMs suggests the typo only occurred once.

Stripped out all unneeded %pX functionality in bat_printk.c so that
the code is more likely to build with older kernels. 

Only build bat_printk.c with kernels that require it, thanks to Simon
Wunderlich Makefile.kbuild patch.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Index: Makefile.kbuild
===================================================================
--- Makefile.kbuild	(revision 1524)
+++ Makefile.kbuild	(working copy)
@@ -32,4 +32,4 @@
 endif
 
 obj-m += batman-adv.o
-batman-adv-objs := main.o proc.o send.o routing.o soft-interface.o device.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o
+batman-adv-objs := main.o proc.o send.o routing.o soft-interface.o device.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o $(shell [ "2" -eq "$(VERSION)" ] && [ "6" -eq "$(PATCHLEVEL)" ] && [ "$(SUBLEVEL)" -le "28" ] && echo bat_printk.o)
Index: translation-table.c
===================================================================
--- translation-table.c	(revision 1524)
+++ translation-table.c	(working copy)
@@ -61,7 +61,6 @@
 	struct hna_local_entry *hna_local_entry;
 	struct hna_global_entry *hna_global_entry;
 	struct hashtable_t *swaphash;
-	char hna_str[ETH_STR_LEN];
 	unsigned long flags;
 
 	spin_lock_irqsave(&hna_local_hash_lock, flags);
@@ -74,19 +73,17 @@
 		return;
 	}
 
-	addr_to_string(hna_str, addr);
-
 	/* only announce as many hosts as possible in the batman-packet and
 	   space in batman_packet->num_hna That also should give a limit to
 	   MAC-flooding. */
 	if ((num_hna + 1 > (ETH_DATA_LEN - BAT_PACKET_LEN) / ETH_ALEN) ||
 	    (num_hna + 1 > 255)) {
-		bat_dbg(DBG_ROUTES, "Can't add new local hna entry (%s): number of local hna entries exceeds packet size \n", hna_str);
+		bat_dbg(DBG_ROUTES, "Can't add new local hna entry (%pM): number of local hna entries exceeds packet size \n", addr);
 		return;
 	}
 
-	bat_dbg(DBG_ROUTES, "Creating new local hna entry: %s \n",
-		hna_str);
+	bat_dbg(DBG_ROUTES, "Creating new local hna entry: %pM \n",
+		addr);
 
 	hna_local_entry = kmalloc(sizeof(struct hna_local_entry), GFP_ATOMIC);
 	if (!hna_local_entry)
@@ -201,12 +198,9 @@
 static void hna_local_del(struct hna_local_entry *hna_local_entry,
 			  char *message)
 {
-	char hna_str[ETH_STR_LEN];
+	bat_dbg(DBG_ROUTES, "Deleting local hna entry (%pM): %s \n",
+		hna_local_entry->addr, message);
 
-	addr_to_string(hna_str, hna_local_entry->addr);
-	bat_dbg(DBG_ROUTES, "Deleting local hna entry (%s): %s \n",
-		hna_str, message);
-
 	hash_remove(hna_local_hash, hna_local_entry->addr);
 	_hna_local_del(hna_local_entry);
 }
@@ -278,13 +272,10 @@
 	struct hna_global_entry *hna_global_entry;
 	struct hna_local_entry *hna_local_entry;
 	struct hashtable_t *swaphash;
-	char hna_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
 	int hna_buff_count = 0;
 	unsigned long flags;
 	unsigned char *hna_ptr;
 
-	addr_to_string(orig_str, orig_node->orig);
-
 	while ((hna_buff_count + 1) * ETH_ALEN <= hna_buff_len) {
 		spin_lock_irqsave(&hna_global_hash_lock, flags);
 
@@ -304,10 +295,9 @@
 
 			memcpy(hna_global_entry->addr, hna_ptr, ETH_ALEN);
 
-			addr_to_string(hna_str, hna_global_entry->addr);
 			bat_dbg(DBG_ROUTES,
-				"Creating new global hna entry: %s (via %s)\n",
-				hna_str, orig_str);
+				"Creating new global hna entry: %pM (via %pM)\n",
+				hna_global_entry->addr, orig_node->orig);
 
 			spin_lock_irqsave(&hna_global_hash_lock, flags);
 			hash_add(hna_global_hash, hna_global_entry);
@@ -399,14 +389,10 @@
 void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
 			  char *message)
 {
-	char hna_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
+	bat_dbg(DBG_ROUTES, "Deleting global hna entry %pM (via %pM): %s \n",
+		hna_global_entry->addr, hna_global_entry->orig_node->orig,
+		message);
 
-	addr_to_string(orig_str, hna_global_entry->orig_node->orig);
-	addr_to_string(hna_str, hna_global_entry->addr);
-
-	bat_dbg(DBG_ROUTES, "Deleting global hna entry %s (via %s): %s \n",
-		hna_str, orig_str, message);
-
 	hash_remove(hna_global_hash, hna_global_entry->addr);
 	kfree(hna_global_entry);
 }
Index: send.c
===================================================================
--- send.c	(revision 1524)
+++ send.c	(working copy)
@@ -132,7 +132,6 @@
 	uint8_t packet_num;
 	int16_t buff_pos;
 	struct batman_packet *batman_packet;
-	char orig_str[ETH_STR_LEN];
 
 	if (batman_if->if_active != IF_ACTIVE)
 		return;
@@ -154,15 +153,14 @@
 		else
 			batman_packet->flags &= ~DIRECTLINK;
 
-		addr_to_string(orig_str, batman_packet->orig);
 		fwd_str = (packet_num > 0 ? "Forwarding" : (forw_packet->own ?
 							    "Sending own" :
 							    "Forwarding"));
 		bat_dbg(DBG_BATMAN,
-			"%s %spacket (originator %s, seqno %d, TQ %d, TTL %d, IDF %s) on interface %s [%s]\n",
+			"%s %spacket (originator %pM, seqno %d, TQ %d, TTL %d, IDF %s) on interface %s [%s]\n",
 			fwd_str,
 			(packet_num > 0 ? "aggregated " : ""),
-			orig_str, ntohs(batman_packet->seqno),
+			batman_packet->orig, ntohs(batman_packet->seqno),
 			batman_packet->tq, batman_packet->ttl,
 			(batman_packet->flags & DIRECTLINK ?
 			 "on" : "off"),
@@ -186,7 +184,6 @@
 	struct batman_if *batman_if;
 	struct batman_packet *batman_packet =
 		(struct batman_packet *)(forw_packet->packet_buff);
-	char orig_str[ETH_STR_LEN];
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
 
 	if (!forw_packet->if_incoming) {
@@ -197,8 +194,6 @@
 	if (forw_packet->if_incoming->if_active != IF_ACTIVE)
 		return;
 
-	addr_to_string(orig_str, batman_packet->orig);
-
 	/* multihomed peer assumed */
 	/* non-primary OGMs are only broadcasted on their interface */
 	if ((directlink && (batman_packet->ttl == 1)) ||
@@ -206,9 +201,9 @@
 
 		/* FIXME: what about aggregated packets ? */
 		bat_dbg(DBG_BATMAN,
-			"%s packet (originator %s, seqno %d, TTL %d) on interface %s [%s]\n",
+			"%s packet (originator %pM, seqno %d, TTL %d) on interface %s [%s]\n",
 			(forw_packet->own ? "Sending own" : "Forwarding"),
-			orig_str, ntohs(batman_packet->seqno),
+			batman_packet->orig, ntohs(batman_packet->seqno),
 			batman_packet->ttl, forw_packet->if_incoming->dev,
 			forw_packet->if_incoming->addr_str);
 
Index: hard-interface.c
===================================================================
--- hard-interface.c	(revision 1524)
+++ hard-interface.c	(working copy)
@@ -74,7 +74,6 @@
 static void check_known_mac_addr(uint8_t *addr)
 {
 	struct batman_if *batman_if;
-	char mac_string[ETH_STR_LEN];
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
@@ -85,9 +84,8 @@
 		if (!compare_orig(batman_if->net_dev->dev_addr, addr))
 			continue;
 
-		addr_to_string(mac_string, addr);
-		printk(KERN_WARNING "batman-adv:The newly added mac address (%s) already exists on: %s\n",
-		       mac_string, batman_if->dev);
+		printk(KERN_WARNING "batman-adv:The newly added mac address (%pM) already exists on: %s\n",
+		       addr, batman_if->dev);
 		printk(KERN_WARNING "batman-adv:It is strongly recommended to keep mac addresses unique to avoid problems!\n");
 	}
 	rcu_read_unlock();
Index: originator.c
===================================================================
--- originator.c	(revision 1524)
+++ originator.c	(working copy)
@@ -121,7 +121,6 @@
 {
 	struct orig_node *orig_node;
 	struct hashtable_t *swaphash;
-	char orig_str[ETH_STR_LEN];
 	int size;
 
 	orig_node = ((struct orig_node *)hash_find(orig_hash, addr));
@@ -129,8 +128,7 @@
 	if (orig_node != NULL)
 		return orig_node;
 
-	addr_to_string(orig_str, addr);
-	bat_dbg(DBG_BATMAN, "Creating new originator: %s \n", orig_str);
+	bat_dbg(DBG_BATMAN, "Creating new originator: %pM \n", addr);
 
 	orig_node = kmalloc(sizeof(struct orig_node), GFP_ATOMIC);
 	if (!orig_node)
@@ -186,7 +184,6 @@
 				 struct neigh_node **best_neigh_node)
 {
 	struct list_head *list_pos, *list_pos_tmp;
-	char neigh_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
 	struct neigh_node *neigh_node;
 	bool neigh_purged = false;
 
@@ -201,9 +198,7 @@
 			       (neigh_node->last_valid +
 				((PURGE_TIMEOUT * HZ) / 1000)))) {
 
-			addr_to_string(neigh_str, neigh_node->addr);
-			addr_to_string(orig_str, orig_node->orig);
-			bat_dbg(DBG_BATMAN, "neighbor timeout: originator %s, neighbor: %s, last_valid %lu\n", orig_str, neigh_str, (neigh_node->last_valid / HZ));
+			bat_dbg(DBG_BATMAN, "neighbor timeout: originator %pM, neighbor: %pM, last_valid %lu\n", orig_node->orig, neigh_node->addr, (neigh_node->last_valid / HZ));
 
 			neigh_purged = true;
 			list_del(list_pos);
@@ -221,17 +216,14 @@
 static bool purge_orig_node(struct orig_node *orig_node)
 {
 	struct neigh_node *best_neigh_node;
-	char orig_str[ETH_STR_LEN];
 
-	addr_to_string(orig_str, orig_node->orig);
-
 	if (time_after(jiffies,
 		       (orig_node->last_valid +
 			((2 * PURGE_TIMEOUT * HZ) / 1000)))) {
 
 		bat_dbg(DBG_BATMAN,
-			"Originator timeout: originator %s, last_valid %lu\n",
-			orig_str, (orig_node->last_valid / HZ));
+			"Originator timeout: originator %pM, last_valid %lu\n",
+			orig_node->orig, (orig_node->last_valid / HZ));
 		return true;
 	} else {
 		if (purge_orig_neighbors(orig_node, &best_neigh_node))
Index: routing.c
===================================================================
--- routing.c	(revision 1524)
+++ routing.c	(working copy)
@@ -80,32 +80,24 @@
 			 struct neigh_node *neigh_node,
 			 unsigned char *hna_buff, int hna_buff_len)
 {
-	char orig_str[ETH_STR_LEN], neigh_str[ETH_STR_LEN];
-	char router_str[ETH_STR_LEN];
-
-	addr_to_string(orig_str, orig_node->orig);
-
 	/* route deleted */
 	if ((orig_node->router != NULL) && (neigh_node == NULL)) {
 
-		bat_dbg(DBG_ROUTES, "Deleting route towards: %s\n",
-			orig_str);
+		bat_dbg(DBG_ROUTES, "Deleting route towards: %pM\n",
+			orig_node->orig);
 		hna_global_del_orig(orig_node, "originator timed out");
 
 		/* route added */
 	} else if ((orig_node->router == NULL) && (neigh_node != NULL)) {
 
-		addr_to_string(neigh_str, neigh_node->addr);
 		bat_dbg(DBG_ROUTES,
-			"Adding route towards: %s (via %s)\n",
-			orig_str, neigh_str);
+			"Adding route towards: %pM (via %pM)\n",
+			orig_node->orig, neigh_node->addr);
 		hna_global_add_orig(orig_node, hna_buff, hna_buff_len);
 
 		/* route changed */
 	} else {
-		addr_to_string(neigh_str, neigh_node->addr);
-		addr_to_string(router_str, orig_node->router->addr);
-		bat_dbg(DBG_ROUTES, "Changing route towards: %s (now via %s - was via %s)\n", orig_str, neigh_str, router_str);
+		bat_dbg(DBG_ROUTES, "Changing route towards: %pM (now via %pM - was via %pM)\n", orig_node->orig, neigh_node->addr, orig_node->router->addr);
 	}
 
 	if (neigh_node != NULL)
@@ -138,12 +130,8 @@
 				struct batman_if *if_incoming)
 {
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
-	char orig_str[ETH_STR_LEN], neigh_str[ETH_STR_LEN];
 	unsigned char total_count;
 
-	addr_to_string(orig_str, orig_node->orig);
-	addr_to_string(neigh_str, orig_neigh_node->orig);
-
 	if (orig_node == orig_neigh_node) {
 		list_for_each_entry(tmp_neigh_node,
 				    &orig_node->neigh_list,
@@ -227,8 +215,8 @@
 			      orig_neigh_node->tq_asym_penalty) /
 			     (TQ_MAX_VALUE *	 TQ_MAX_VALUE));
 
-	bat_dbg(DBG_BATMAN, "bidirectional: orig = %-15s neigh = %-15s => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i \n",
-		orig_str, neigh_str, total_count,
+	bat_dbg(DBG_BATMAN, "bidirectional: orig = %-15pM neigh = %-15pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i \n",
+		orig_node->orig, orig_neigh_node->orig, total_count,
 		neigh_node->real_packet_count, orig_neigh_node->tq_own,
 		orig_neigh_node->tq_asym_penalty, batman_packet->tq);
 
@@ -372,8 +360,6 @@
 {
 	struct batman_if *batman_if;
 	struct orig_node *orig_neigh_node, *orig_node;
-	char orig_str[ETH_STR_LEN], prev_sender_str[ETH_STR_LEN];
-	char neigh_str[ETH_STR_LEN];
 	char has_directlink_flag;
 	char is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
 	char is_broadcast = 0, is_bidirectional, is_single_hop_neigh;
@@ -398,20 +384,16 @@
 	/* could be changed by schedule_own_packet() */
 	if_incoming_seqno = atomic_read(&if_incoming->seqno);
 
-	addr_to_string(orig_str, batman_packet->orig);
-	addr_to_string(prev_sender_str, batman_packet->prev_sender);
-	addr_to_string(neigh_str, ethhdr->h_source);
-
 	has_directlink_flag = (batman_packet->flags & DIRECTLINK ? 1 : 0);
 
 	is_single_hop_neigh = (compare_orig(ethhdr->h_source,
 					    batman_packet->orig) ? 1 : 0);
 
-	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %s, IF: %s [%s] (from OG: %s, via prev OG: %s, seqno %d, tq %d, TTL %d, V %d, IDF %d) \n",
-		neigh_str, if_incoming->dev, if_incoming->addr_str,
-		orig_str, prev_sender_str, batman_packet->seqno,
-		batman_packet->tq, batman_packet->ttl, batman_packet->version,
-		has_directlink_flag);
+	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] (from OG: %pM, via prev OG: %pM, seqno %d, tq %d, TTL %d, V %d, IDF %d) \n",
+		ethhdr->h_source, if_incoming->dev, if_incoming->addr_str,
+		batman_packet->orig, batman_packet->prev_sender,
+		batman_packet->seqno, batman_packet->tq, batman_packet->ttl,
+		batman_packet->version, has_directlink_flag);
 
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
 		if (batman_if->if_active != IF_ACTIVE)
@@ -442,13 +424,13 @@
 
 	if (is_my_addr) {
 		bat_dbg(DBG_BATMAN,
-			"Drop packet: received my own broadcast (sender: %s)\n",
-			neigh_str);
+			"Drop packet: received my own broadcast (sender: %pM)\n",
+			ethhdr->h_source);
 		return;
 	}
 
 	if (is_broadcast) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all packets with broadcast source addr (sender: %s) \n", neigh_str);
+		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all packets with broadcast source addr (sender: %pM) \n", ethhdr->h_source);
 		return;
 	}
 
@@ -488,7 +470,7 @@
 	}
 
 	if (is_my_oldorig) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast echos (sender: %s) \n", neigh_str);
+		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast echos (sender: %pM) \n", ethhdr->h_source);
 		return;
 	}
 
@@ -506,7 +488,7 @@
 	    !(compare_orig(batman_packet->orig, batman_packet->prev_sender)) &&
 	    (compare_orig(orig_node->router->addr,
 			  orig_node->router->orig_node->router->addr))) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %s) \n", neigh_str);
+		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %pM) \n", ethhdr->h_source);
 		return;
 	}
 
@@ -659,7 +641,6 @@
 
 static int recv_icmp_ttl_exceeded(struct sk_buff *skb)
 {
-	unsigned char src_str[ETH_STR_LEN], dst_str[ETH_STR_LEN];
 	struct orig_node *orig_node;
 	struct icmp_packet *icmp_packet;
 	struct ethhdr *ethhdr;
@@ -670,11 +651,8 @@
 	icmp_packet = (struct icmp_packet *) skb->data;
 	ethhdr = (struct ethhdr *) skb_mac_header(skb);
 
-	addr_to_string(src_str, icmp_packet->orig);
-	addr_to_string(dst_str, icmp_packet->dst);
+	printk(KERN_WARNING "batman-adv:Warning - can't send packet from %pM to %pM: ttl exceeded\n", icmp_packet->orig, icmp_packet->dst);
 
-	printk(KERN_WARNING "batman-adv:Warning - can't send packet from %s to %s: ttl exceeded\n", src_str, dst_str);
-
 	/* send TTL exceeded if packet is an echo request (traceroute) */
 	if (icmp_packet->msg_type != ECHO_REQUEST)
 		return NET_RX_DROP;
@@ -793,7 +771,6 @@
 int recv_unicast_packet(struct sk_buff *skb)
 {
 	struct unicast_packet *unicast_packet;
-	unsigned char src_str[ETH_STR_LEN], dst_str[ETH_STR_LEN];
 	struct orig_node *orig_node;
 	struct ethhdr *ethhdr;
 	struct batman_if *batman_if;
@@ -831,10 +808,7 @@
 
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
-		addr_to_string(src_str, ethhdr->h_source);
-		addr_to_string(dst_str, ethhdr->h_dest);
-
-		printk(KERN_WARNING "batman-adv:Warning - can't send packet from %s to %s: ttl exceeded\n", src_str, dst_str);
+		printk(KERN_WARNING "batman-adv:Warning - can't send packet from %pM to %pM: ttl exceeded\n", ethhdr->h_source, unicast_packet->dest);
 		return NET_RX_DROP;
 	}
 
@@ -984,5 +958,3 @@
 	}
 	return ret;
 }
-
-
Index: compat.h
===================================================================
--- compat.h	(revision 1524)
+++ compat.h	(working copy)
@@ -73,3 +73,8 @@
 	ret; \
 })
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 25) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29)
+asmlinkage int bat_printk(const char *fmt, ...);
+#define printk bat_printk
+#endif
