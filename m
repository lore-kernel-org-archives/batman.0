Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  4 Apr 2010 03:24:01 +0200
Message-Id: <1270344241-9700-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201004040312.28481.sven.eckelmann@gmx.de>
References: <201004040312.28481.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv2-maint] Staging: batman-adv: fix whitespace
	style issues
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
Cc: Luis de Bethencourt <luisbg@ubuntu.com>

From: Luis de Bethencourt <luisbg@ubuntu.com>

This patch fixes the 31 unnecessary whitespaces before a quoted
newline that the batman-adv files had.

Signed-off-by: Luis de Bethencourt <luisbg@ubuntu.com>
[sven.eckelmann@gmx.de: Redone to apply against current version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 device.c            |    2 +-
 main.c              |    2 +-
 originator.c        |    4 ++--
 proc.c              |   18 +++++++++---------
 routing.c           |   18 +++++++++---------
 send.c              |    4 ++--
 translation-table.c |   14 +++++++-------
 7 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/device.c b/device.c
index 67245ff..73d2e17 100644
--- a/device.c
+++ b/device.c
@@ -66,7 +66,7 @@ int bat_device_setup(void)
 	batman_class = class_create(THIS_MODULE, "batman-adv");
 
 	if (IS_ERR(batman_class)) {
-		printk(KERN_ERR "batman-adv:Could not register class 'batman-adv' \n");
+		printk(KERN_ERR "batman-adv:Could not register class 'batman-adv'\n");
 		return 0;
 	}
 
diff --git a/main.c b/main.c
index 2c2f243..41f7dd2 100644
--- a/main.c
+++ b/main.c
@@ -120,7 +120,7 @@ int init_module(void)
 	register_netdevice_notifier(&hard_if_notifier);
 	dev_add_pack(&batman_adv_packet_type);
 
-	printk(KERN_INFO "batman-adv:B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded \n",
+	printk(KERN_INFO "batman-adv:B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded\n",
 		  SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
 
 	return 0;
diff --git a/originator.c b/originator.c
index 1f368ac..a5f9679 100644
--- a/originator.c
+++ b/originator.c
@@ -128,7 +128,7 @@ struct orig_node *get_orig_node(uint8_t *addr)
 	if (orig_node != NULL)
 		return orig_node;
 
-	bat_dbg(DBG_BATMAN, "Creating new originator: %pM \n", addr);
+	bat_dbg(DBG_BATMAN, "Creating new originator: %pM\n", addr);
 
 	orig_node = kzalloc(sizeof(struct orig_node), GFP_ATOMIC);
 	if (!orig_node)
@@ -160,7 +160,7 @@ struct orig_node *get_orig_node(uint8_t *addr)
 
 		if (swaphash == NULL)
 			printk(KERN_ERR
-			       "batman-adv:Couldn't resize orig hash table \n");
+			       "batman-adv:Couldn't resize orig hash table\n");
 		else
 			orig_hash = swaphash;
 	}
diff --git a/proc.c b/proc.c
index 4ec3050..f0a2900 100644
--- a/proc.c
+++ b/proc.c
@@ -42,7 +42,7 @@ static int proc_interfaces_read(struct seq_file *seq, void *offset)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
-		seq_printf(seq, "[%8s] %s %s \n",
+		seq_printf(seq, "[%8s] %s %s\n",
 			   (batman_if->if_active == IF_ACTIVE ?
 			    "active" : "inactive"),
 			   batman_if->dev,
@@ -189,18 +189,18 @@ static int proc_originators_read(struct seq_file *seq, void *offset)
 	rcu_read_lock();
 	if (list_empty(&if_list)) {
 		rcu_read_unlock();
-		seq_printf(seq, "BATMAN disabled - please specify interfaces to enable it \n");
+		seq_printf(seq, "BATMAN disabled - please specify interfaces to enable it\n");
 		goto end;
 	}
 
 	if (((struct batman_if *)if_list.next)->if_active != IF_ACTIVE) {
 		rcu_read_unlock();
-		seq_printf(seq, "BATMAN disabled - primary interface not active \n");
+		seq_printf(seq, "BATMAN disabled - primary interface not active\n");
 		goto end;
 	}
 
 	seq_printf(seq,
-		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s] \n",
+		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s]\n",
 		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
 		   "Potential nexthops", SOURCE_VERSION, REVISION_VERSION_STR,
 		   ((struct batman_if *)if_list.next)->dev,
@@ -241,7 +241,7 @@ static int proc_originators_read(struct seq_file *seq, void *offset)
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 
 	if (batman_count == 0)
-		seq_printf(seq, "No batman nodes in range ... \n");
+		seq_printf(seq, "No batman nodes in range ...\n");
 
 end:
 	return 0;
@@ -263,7 +263,7 @@ static int proc_transt_local_read(struct seq_file *seq, void *offset)
 	rcu_read_lock();
 	if (list_empty(&if_list)) {
 		rcu_read_unlock();
-		seq_printf(seq, "BATMAN disabled - please specify interfaces to enable it \n");
+		seq_printf(seq, "BATMAN disabled - please specify interfaces to enable it\n");
 		goto end;
 	}
 
@@ -295,7 +295,7 @@ static int proc_transt_global_read(struct seq_file *seq, void *offset)
 	rcu_read_lock();
 	if (list_empty(&if_list)) {
 		rcu_read_unlock();
-		seq_printf(seq, "BATMAN disabled - please specify interfaces to enable it \n");
+		seq_printf(seq, "BATMAN disabled - please specify interfaces to enable it\n");
 		goto end;
 	}
 	rcu_read_unlock();
@@ -351,9 +351,9 @@ static int proc_vis_srv_read(struct seq_file *seq, void *offset)
 {
 	int vis_server = atomic_read(&vis_mode);
 
-	seq_printf(seq, "[%c] client mode (server disabled) \n",
+	seq_printf(seq, "[%c] client mode (server disabled)\n",
 			(vis_server == VIS_TYPE_CLIENT_UPDATE) ? 'x' : ' ');
-	seq_printf(seq, "[%c] server mode (server enabled) \n",
+	seq_printf(seq, "[%c] server mode (server enabled)\n",
 			(vis_server == VIS_TYPE_SERVER_SYNC) ? 'x' : ' ');
 
 	return 0;
diff --git a/routing.c b/routing.c
index b64bad4..cccb10a 100644
--- a/routing.c
+++ b/routing.c
@@ -213,7 +213,7 @@ static int isBidirectionalNeigh(struct orig_node *orig_node,
 			      orig_neigh_node->tq_asym_penalty) /
 			     (TQ_MAX_VALUE *	 TQ_MAX_VALUE));
 
-	bat_dbg(DBG_BATMAN, "bidirectional: orig = %-15pM neigh = %-15pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i \n",
+	bat_dbg(DBG_BATMAN, "bidirectional: orig = %-15pM neigh = %-15pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i\n",
 		orig_node->orig, orig_neigh_node->orig, total_count,
 		neigh_node->real_packet_count, orig_neigh_node->tq_own,
 		orig_neigh_node->tq_asym_penalty, batman_packet->tq);
@@ -235,7 +235,7 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	int tmp_hna_buff_len;
 
-	bat_dbg(DBG_BATMAN, "update_originator(): Searching and updating originator entry of received packet \n");
+	bat_dbg(DBG_BATMAN, "update_originator(): Searching and updating originator entry of received packet\n");
 
 	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
 		if (compare_orig(tmp_neigh_node->addr, ethhdr->h_source) &&
@@ -342,7 +342,7 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	}
 
 	if (!is_duplicate) {
-		bat_dbg(DBG_BATMAN, "updating last_seqno: old %d, new %d \n",
+		bat_dbg(DBG_BATMAN, "updating last_seqno: old %d, new %d\n",
 			orig_node->last_real_seqno, batman_packet->seqno);
 		orig_node->last_real_seqno = batman_packet->seqno;
 	}
@@ -386,7 +386,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	is_single_hop_neigh = (compare_orig(ethhdr->h_source,
 					    batman_packet->orig) ? 1 : 0);
 
-	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] (from OG: %pM, via prev OG: %pM, seqno %d, tq %d, TTL %d, V %d, IDF %d) \n",
+	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] (from OG: %pM, via prev OG: %pM, seqno %d, tq %d, TTL %d, V %d, IDF %d)\n",
 		ethhdr->h_source, if_incoming->dev, if_incoming->addr_str,
 		batman_packet->orig, batman_packet->prev_sender,
 		batman_packet->seqno, batman_packet->tq, batman_packet->ttl,
@@ -427,7 +427,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	}
 
 	if (is_broadcast) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all packets with broadcast source addr (sender: %pM) \n", ethhdr->h_source);
+		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all packets with broadcast source addr (sender: %pM)\n", ethhdr->h_source);
 		return;
 	}
 
@@ -455,19 +455,19 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				bit_packet_count(word);
 		}
 
-		bat_dbg(DBG_BATMAN, "Drop packet: originator packet from myself (via neighbor) \n");
+		bat_dbg(DBG_BATMAN, "Drop packet: originator packet from myself (via neighbor)\n");
 		return;
 	}
 
 	if (batman_packet->tq == 0) {
 		count_real_packets(ethhdr, batman_packet, if_incoming);
 
-		bat_dbg(DBG_BATMAN, "Drop packet: originator packet with tq equal 0 \n");
+		bat_dbg(DBG_BATMAN, "Drop packet: originator packet with tq equal 0\n");
 		return;
 	}
 
 	if (is_my_oldorig) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast echos (sender: %pM) \n", ethhdr->h_source);
+		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast echos (sender: %pM)\n", ethhdr->h_source);
 		return;
 	}
 
@@ -485,7 +485,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	    !(compare_orig(batman_packet->orig, batman_packet->prev_sender)) &&
 	    (compare_orig(orig_node->router->addr,
 			  orig_node->router->orig_node->router->addr))) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %pM) \n", ethhdr->h_source);
+		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %pM)\n", ethhdr->h_source);
 		return;
 	}
 
diff --git a/send.c b/send.c
index c485324..1cca87c 100644
--- a/send.c
+++ b/send.c
@@ -291,7 +291,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	unsigned long send_time;
 
 	if (batman_packet->ttl <= 1) {
-		bat_dbg(DBG_BATMAN, "ttl exceeded \n");
+		bat_dbg(DBG_BATMAN, "ttl exceeded\n");
 		return;
 	}
 
@@ -319,7 +319,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	/* apply hop penalty */
 	batman_packet->tq = hop_penalty(batman_packet->tq);
 
-	bat_dbg(DBG_BATMAN, "Forwarding packet: tq_orig: %i, tq_avg: %i, tq_forw: %i, ttl_orig: %i, ttl_forw: %i \n",
+	bat_dbg(DBG_BATMAN, "Forwarding packet: tq_orig: %i, tq_avg: %i, tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
 		in_tq, tq_avg, batman_packet->tq, in_ttl - 1,
 		batman_packet->ttl);
 
diff --git a/translation-table.c b/translation-table.c
index 9d1a10e..8a1a305 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -78,11 +78,11 @@ void hna_local_add(uint8_t *addr)
 	   MAC-flooding. */
 	if ((num_hna + 1 > (ETH_DATA_LEN - BAT_PACKET_LEN) / ETH_ALEN) ||
 	    (num_hna + 1 > 255)) {
-		bat_dbg(DBG_ROUTES, "Can't add new local hna entry (%pM): number of local hna entries exceeds packet size \n", addr);
+		bat_dbg(DBG_ROUTES, "Can't add new local hna entry (%pM): number of local hna entries exceeds packet size\n", addr);
 		return;
 	}
 
-	bat_dbg(DBG_ROUTES, "Creating new local hna entry: %pM \n",
+	bat_dbg(DBG_ROUTES, "Creating new local hna entry: %pM\n",
 		addr);
 
 	hna_local_entry = kmalloc(sizeof(struct hna_local_entry), GFP_ATOMIC);
@@ -109,7 +109,7 @@ void hna_local_add(uint8_t *addr)
 				       hna_local_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR "batman-adv:Couldn't resize local hna hash table \n");
+			printk(KERN_ERR "batman-adv:Couldn't resize local hna hash table\n");
 		else
 			hna_local_hash = swaphash;
 	}
@@ -198,7 +198,7 @@ static void _hna_local_del(void *data)
 static void hna_local_del(struct hna_local_entry *hna_local_entry,
 			  char *message)
 {
-	bat_dbg(DBG_ROUTES, "Deleting local hna entry (%pM): %s \n",
+	bat_dbg(DBG_ROUTES, "Deleting local hna entry (%pM): %s\n",
 		hna_local_entry->addr, message);
 
 	hash_remove(hna_local_hash, hna_local_entry->addr);
@@ -341,7 +341,7 @@ void hna_global_add_orig(struct orig_node *orig_node,
 				       hna_global_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR "batman-adv:Couldn't resize global hna hash table \n");
+			printk(KERN_ERR "batman-adv:Couldn't resize global hna hash table\n");
 		else
 			hna_global_hash = swaphash;
 	}
@@ -366,7 +366,7 @@ int hna_global_fill_buffer_text(unsigned char *buff, int buff_len)
 
 		bytes_written += snprintf(buff + bytes_written,
 					  (2 * ETH_STR_LEN) + 10,
-					  " * %02x:%02x:%02x:%02x:%02x:%02x via %02x:%02x:%02x:%02x:%02x:%02x \n",
+					  " * %02x:%02x:%02x:%02x:%02x:%02x via %02x:%02x:%02x:%02x:%02x:%02x\n",
 					  hna_global_entry->addr[0],
 					  hna_global_entry->addr[1],
 					  hna_global_entry->addr[2],
@@ -389,7 +389,7 @@ int hna_global_fill_buffer_text(unsigned char *buff, int buff_len)
 void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
 			  char *message)
 {
-	bat_dbg(DBG_ROUTES, "Deleting global hna entry %pM (via %pM): %s \n",
+	bat_dbg(DBG_ROUTES, "Deleting global hna entry %pM (via %pM): %s\n",
 		hna_global_entry->addr, hna_global_entry->orig_node->orig,
 		message);
 
-- 
1.7.0.3

