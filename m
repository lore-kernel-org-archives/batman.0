Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  4 Apr 2010 03:44:20 +0200
Message-Id: <1270345460-20555-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201004040312.28481.sven.eckelmann@gmx.de>
References: <201004040312.28481.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv2-trunk] Staging: batman-adv: fix whitespace
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
Changes are done with "reorganized kernel interface patches (version 3)"
applied.

 batman-adv-kernelland/bat_sysfs.c         |   10 +++++-----
 batman-adv-kernelland/device.c            |    2 +-
 batman-adv-kernelland/gateway_client.c    |    6 +++---
 batman-adv-kernelland/main.c              |    2 +-
 batman-adv-kernelland/originator.c        |    8 ++++----
 batman-adv-kernelland/routing.c           |   18 +++++++++---------
 batman-adv-kernelland/send.c              |    4 ++--
 batman-adv-kernelland/translation-table.c |   12 ++++++------
 8 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/batman-adv-kernelland/bat_sysfs.c b/batman-adv-kernelland/bat_sysfs.c
index 4dffa00..ad7e4c9 100644
--- a/batman-adv-kernelland/bat_sysfs.c
+++ b/batman-adv-kernelland/bat_sysfs.c
@@ -77,7 +77,7 @@ static ssize_t show_aggr_ogm(struct kobject *kobj, struct attribute *attr,
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
 	int aggr_status = atomic_read(&bat_priv->aggregation_enabled);
 
-	return sprintf(buff, "status: %s\ncommands: enable, disable, 0, 1 \n",
+	return sprintf(buff, "status: %s\ncommands: enable, disable, 0, 1\n",
 		       aggr_status == 0 ? "disabled" : "enabled");
 }
 
@@ -125,7 +125,7 @@ static ssize_t show_bond(struct kobject *kobj, struct attribute *attr,
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
 	int bond_status = atomic_read(&bat_priv->bonding_enabled);
 
-	return sprintf(buff, "status: %s\ncommands: enable, disable, 0, 1 \n",
+	return sprintf(buff, "status: %s\ncommands: enable, disable, 0, 1\n",
 		       bond_status == 0 ? "disabled" : "enabled");
 }
 
@@ -174,7 +174,7 @@ static ssize_t show_vis_mode(struct kobject *kobj, struct attribute *attr,
 	struct bat_priv *bat_priv = netdev_priv(to_net_dev(dev));
 	int vis_mode = atomic_read(&bat_priv->vis_mode);
 
-	return sprintf(buff, "status: %s\ncommands: client, server, %d, %d \n",
+	return sprintf(buff, "status: %s\ncommands: client, server, %d, %d\n",
 		       vis_mode == VIS_TYPE_CLIENT_UPDATE ?
 							"client" : "server",
 		       VIS_TYPE_SERVER_SYNC, VIS_TYPE_CLIENT_UPDATE);
@@ -251,7 +251,7 @@ static ssize_t show_gw_mode(struct kobject *kobj, struct attribute *attr,
 	}
 
 	bytes_written += sprintf(buff + bytes_written,
-				 "commands: %s, %s <opt arg>, %s <opt arg> \n",
+				 "commands: %s, %s <opt arg>, %s <opt arg>\n",
 				 GW_MODE_OFF_NAME, GW_MODE_CLIENT_NAME,
 				 GW_MODE_SERVER_NAME);
 	return bytes_written;
@@ -480,7 +480,7 @@ static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute *attr,
 	if (!batman_if)
 		return 0;
 
-	return sprintf(buff, "status: %s\ncommands: none, bat0 \n",
+	return sprintf(buff, "status: %s\ncommands: none, bat0\n",
 		       batman_if->if_status == IF_NOT_IN_USE ?
 							"none" : "bat0");
 }
diff --git a/batman-adv-kernelland/device.c b/batman-adv-kernelland/device.c
index 44d15c4..c8ec4f9 100644
--- a/batman-adv-kernelland/device.c
+++ b/batman-adv-kernelland/device.c
@@ -66,7 +66,7 @@ int bat_device_setup(void)
 	batman_class = class_create(THIS_MODULE, "batman-adv");
 
 	if (IS_ERR(batman_class)) {
-		printk(KERN_ERR "batman-adv:Could not register class 'batman-adv' \n");
+		printk(KERN_ERR "batman-adv:Could not register class 'batman-adv'\n");
 		return 0;
 	}
 
diff --git a/batman-adv-kernelland/gateway_client.c b/batman-adv-kernelland/gateway_client.c
index c4ae443..1f662d8 100644
--- a/batman-adv-kernelland/gateway_client.c
+++ b/batman-adv-kernelland/gateway_client.c
@@ -197,7 +197,7 @@ void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 		return;
 
 	bat_dbg(DBG_BATMAN,
-		"Restarting gateway selection: better gateway found (tq curr: %i, tq new: %i) \n",
+		"Restarting gateway selection: better gateway found (tq curr: %i, tq new: %i)\n",
 		gw_tq_avg, orig_tq_avg);
 
 deselect:
@@ -367,7 +367,7 @@ int gw_client_fill_buffer_text(struct net_device *net_dev, char *buff,
 	}
 
 	hdr_len = sprintf(buff,
-			  "      %-12s (%s/%i) %17s [%10s]: gw_class ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)] \n",
+			  "      %-12s (%s/%i) %17s [%10s]: gw_class ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
 			  "Gateway", "#", TQ_MAX_VALUE, "Nexthop",
 			  "outgoingIF", SOURCE_VERSION, REVISION_VERSION_STR,
 			  bat_priv->primary_if->dev,
@@ -403,7 +403,7 @@ int gw_client_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 	if ((gw_count == 0) && (off == 0))
 		bytes_written += sprintf(buff + bytes_written,
-					 "No gateways in range ... \n");
+					 "No gateways in range ...\n");
 
 	return bytes_written;
 }
diff --git a/batman-adv-kernelland/main.c b/batman-adv-kernelland/main.c
index b98fd83..635f6f6 100644
--- a/batman-adv-kernelland/main.c
+++ b/batman-adv-kernelland/main.c
@@ -115,7 +115,7 @@ int init_module(void)
 	register_netdevice_notifier(&hard_if_notifier);
 	dev_add_pack(&batman_adv_packet_type);
 
-	printk(KERN_INFO "batman-adv:B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded \n",
+	printk(KERN_INFO "batman-adv:B.A.T.M.A.N. advanced %s%s (compatibility version %i) loaded\n",
 		  SOURCE_VERSION, REVISION_VERSION_STR, COMPAT_VERSION);
 
 	return 0;
diff --git a/batman-adv-kernelland/originator.c b/batman-adv-kernelland/originator.c
index d04bac4..1a59dd3 100644
--- a/batman-adv-kernelland/originator.c
+++ b/batman-adv-kernelland/originator.c
@@ -131,7 +131,7 @@ struct orig_node *get_orig_node(uint8_t *addr)
 	if (orig_node != NULL)
 		return orig_node;
 
-	bat_dbg(DBG_BATMAN, "Creating new originator: %pM \n", addr);
+	bat_dbg(DBG_BATMAN, "Creating new originator: %pM\n", addr);
 
 	orig_node = kzalloc(sizeof(struct orig_node), GFP_ATOMIC);
 	if (!orig_node)
@@ -162,7 +162,7 @@ struct orig_node *get_orig_node(uint8_t *addr)
 
 		if (swaphash == NULL)
 			printk(KERN_ERR
-			       "batman-adv:Couldn't resize orig hash table \n");
+			       "batman-adv:Couldn't resize orig hash table\n");
 		else
 			orig_hash = swaphash;
 	}
@@ -307,7 +307,7 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 	rcu_read_lock();
 	hdr_len = sprintf(buff,
-		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)] \n",
+		   "  %-14s (%s/%i) %17s [%10s]: %20s ... [B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
 		   "Originator", "#", TQ_MAX_VALUE, "Nexthop", "outgoingIF",
 		   "Potential nexthops", SOURCE_VERSION, REVISION_VERSION_STR,
 		   bat_priv->primary_if->dev, bat_priv->primary_if->addr_str,
@@ -364,7 +364,7 @@ ssize_t orig_fill_buffer_text(struct net_device *net_dev, char *buff,
 
 	if ((batman_count == 0) && (off == 0))
 		bytes_written += sprintf(buff + bytes_written,
-					"No batman nodes in range ... \n");
+					"No batman nodes in range ...\n");
 
 	return bytes_written;
 }
diff --git a/batman-adv-kernelland/routing.c b/batman-adv-kernelland/routing.c
index 7020b01..9a60b7c 100644
--- a/batman-adv-kernelland/routing.c
+++ b/batman-adv-kernelland/routing.c
@@ -209,7 +209,7 @@ static int isBidirectionalNeigh(struct orig_node *orig_node,
 			      orig_neigh_node->tq_asym_penalty) /
 			     (TQ_MAX_VALUE * TQ_MAX_VALUE));
 
-	bat_dbg(DBG_BATMAN, "bidirectional: orig = %-15pM neigh = %-15pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i \n",
+	bat_dbg(DBG_BATMAN, "bidirectional: orig = %-15pM neigh = %-15pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i\n",
 		orig_node->orig, orig_neigh_node->orig, total_count,
 		neigh_node->real_packet_count, orig_neigh_node->tq_own,
 		orig_neigh_node->tq_asym_penalty, batman_packet->tq);
@@ -233,7 +233,7 @@ static void update_orig(struct orig_node *orig_node, struct ethhdr *ethhdr,
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
 	int tmp_hna_buff_len;
 
-	bat_dbg(DBG_BATMAN, "update_originator(): Searching and updating originator entry of received packet \n");
+	bat_dbg(DBG_BATMAN, "update_originator(): Searching and updating originator entry of received packet\n");
 
 	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
 		if (compare_orig(tmp_neigh_node->addr, ethhdr->h_source) &&
@@ -350,7 +350,7 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	}
 
 	if (!is_duplicate) {
-		bat_dbg(DBG_BATMAN, "updating last_seqno: old %d, new %d \n",
+		bat_dbg(DBG_BATMAN, "updating last_seqno: old %d, new %d\n",
 			orig_node->last_real_seqno, batman_packet->seqno);
 		orig_node->last_real_seqno = batman_packet->seqno;
 	}
@@ -509,7 +509,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	is_single_hop_neigh = (compare_orig(ethhdr->h_source,
 					    batman_packet->orig) ? 1 : 0);
 
-	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] (from OG: %pM, via prev OG: %pM, seqno %d, tq %d, TTL %d, V %d, IDF %d) \n",
+	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] (from OG: %pM, via prev OG: %pM, seqno %d, tq %d, TTL %d, V %d, IDF %d)\n",
 		ethhdr->h_source, if_incoming->dev, if_incoming->addr_str,
 		batman_packet->orig, batman_packet->prev_sender,
 		batman_packet->seqno, batman_packet->tq, batman_packet->ttl,
@@ -550,7 +550,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	}
 
 	if (is_broadcast) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all packets with broadcast source addr (sender: %pM) \n", ethhdr->h_source);
+		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all packets with broadcast source addr (sender: %pM)\n", ethhdr->h_source);
 		return;
 	}
 
@@ -578,19 +578,19 @@ void receive_bat_packet(struct ethhdr *ethhdr,
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
 
@@ -608,7 +608,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	    !(compare_orig(batman_packet->orig, batman_packet->prev_sender)) &&
 	    (compare_orig(orig_node->router->addr,
 			  orig_node->router->orig_node->router->addr))) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %pM) \n", ethhdr->h_source);
+		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %pM)\n", ethhdr->h_source);
 		return;
 	}
 
diff --git a/batman-adv-kernelland/send.c b/batman-adv-kernelland/send.c
index 684bf1d..0fb713c 100644
--- a/batman-adv-kernelland/send.c
+++ b/batman-adv-kernelland/send.c
@@ -311,7 +311,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	unsigned long send_time;
 
 	if (batman_packet->ttl <= 1) {
-		bat_dbg(DBG_BATMAN, "ttl exceeded \n");
+		bat_dbg(DBG_BATMAN, "ttl exceeded\n");
 		return;
 	}
 
@@ -339,7 +339,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	/* apply hop penalty */
 	batman_packet->tq = hop_penalty(batman_packet->tq);
 
-	bat_dbg(DBG_BATMAN, "Forwarding packet: tq_orig: %i, tq_avg: %i, tq_forw: %i, ttl_orig: %i, ttl_forw: %i \n",
+	bat_dbg(DBG_BATMAN, "Forwarding packet: tq_orig: %i, tq_avg: %i, tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
 		in_tq, tq_avg, batman_packet->tq, in_ttl - 1,
 		batman_packet->ttl);
 
diff --git a/batman-adv-kernelland/translation-table.c b/batman-adv-kernelland/translation-table.c
index d63f0b8..3ce39a6 100644
--- a/batman-adv-kernelland/translation-table.c
+++ b/batman-adv-kernelland/translation-table.c
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
@@ -220,7 +220,7 @@ static void _hna_local_del(void *data)
 static void hna_local_del(struct hna_local_entry *hna_local_entry,
 			  char *message)
 {
-	bat_dbg(DBG_ROUTES, "Deleting local hna entry (%pM): %s \n",
+	bat_dbg(DBG_ROUTES, "Deleting local hna entry (%pM): %s\n",
 		hna_local_entry->addr, message);
 
 	hash_remove(hna_local_hash, hna_local_entry->addr);
@@ -363,7 +363,7 @@ void hna_global_add_orig(struct orig_node *orig_node,
 				       hna_global_hash->size * 2);
 
 		if (swaphash == NULL)
-			printk(KERN_ERR "batman-adv:Couldn't resize global hna hash table \n");
+			printk(KERN_ERR "batman-adv:Couldn't resize global hna hash table\n");
 		else
 			hna_global_hash = swaphash;
 	}
@@ -433,7 +433,7 @@ int hna_global_fill_buffer_text(struct net_device *net_dev, char *buff,
 void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
 			  char *message)
 {
-	bat_dbg(DBG_ROUTES, "Deleting global hna entry %pM (via %pM): %s \n",
+	bat_dbg(DBG_ROUTES, "Deleting global hna entry %pM (via %pM): %s\n",
 		hna_global_entry->addr, hna_global_entry->orig_node->orig,
 		message);
 
-- 
1.7.0.3

