Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 14 Aug 2010 23:08:01 +0200
Message-Id: <1281820085-13507-5-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
References: <1281820085-13507-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/9] batman-adv: Remove duplicate of attached
	device name
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

batman_if has the name of the net_dev as extra string in its own
structure, but also holds a reference to the actual net_device structure
which always has the current name of the device. This makes it
unneccessary and also more complex because we must update the name in
situations when we receive a NETDEV_CHANGENAME event.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/gateway_client.c |    6 +++---
 batman-adv/hard-interface.c |   29 ++++++++++-------------------
 batman-adv/originator.c     |    8 ++++----
 batman-adv/routing.c        |    9 +++++----
 batman-adv/send.c           |    9 +++++----
 batman-adv/types.h          |    1 -
 6 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index ec3aeb0..6721398 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -321,7 +321,7 @@ static int _write_buffer_text(struct bat_priv *bat_priv,
 		       gw_str,
 		       gw_node->orig_node->router->tq_avg,
 		       router_str,
-		       gw_node->orig_node->router->if_incoming->dev,
+		       gw_node->orig_node->router->if_incoming->net_dev->name,
 		       gw_node->orig_node->gw_flags,
 		       (down > 2048 ? down / 1024 : down),
 		       (down > 2048 ? "MBit" : "KBit"),
@@ -358,8 +358,8 @@ int gw_client_seq_print_text(struct seq_file *seq, void *offset)
 		   "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
 		   "Gateway", "#", TQ_MAX_VALUE, "Nexthop",
 		   "outgoingIF", SOURCE_VERSION, REVISION_VERSION_STR,
-		   bat_priv->primary_if->dev, bat_priv->primary_if->addr_str,
-		   net_dev->name);
+		   bat_priv->primary_if->net_dev->name,
+		   bat_priv->primary_if->addr_str, net_dev->name);
 	rcu_read_unlock();
 
 	rcu_read_lock();
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index d53138c..a141ffb 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -160,7 +160,7 @@ static void check_known_mac_addr(uint8_t *addr)
 			continue;
 
 		pr_warning("The newly added mac address (%pM) already exists "
-			   "on: %s\n", addr, batman_if->dev);
+			   "on: %s\n", addr, batman_if->net_dev->name);
 		pr_warning("It is strongly recommended to keep mac addresses "
 			   "unique to avoid problems!\n");
 	}
@@ -226,7 +226,7 @@ static void hardif_activate_interface(struct batman_if *batman_if)
 		set_primary_if(bat_priv, batman_if);
 
 	bat_info(batman_if->soft_iface, "Interface activated: %s\n",
-		 batman_if->dev);
+		 batman_if->net_dev->name);
 
 	update_min_mtu(batman_if->soft_iface);
 	return;
@@ -243,7 +243,7 @@ static void hardif_deactivate_interface(struct batman_if *batman_if)
 	batman_if->if_status = IF_INACTIVE;
 
 	bat_info(batman_if->soft_iface, "Interface deactivated: %s\n",
-		 batman_if->dev);
+		 batman_if->net_dev->name);
 
 	update_min_mtu(batman_if->soft_iface);
 }
@@ -274,7 +274,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 
 	if (!batman_if->packet_buff) {
 		bat_err(batman_if->soft_iface, "Can't add interface packet "
-			"(%s): out of memory\n", batman_if->dev);
+			"(%s): out of memory\n", batman_if->net_dev->name);
 		goto err;
 	}
 
@@ -299,7 +299,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 	atomic_set(&batman_if->seqno, 1);
 	atomic_set(&batman_if->frag_seqno, 1);
 	bat_info(batman_if->soft_iface, "Adding interface: %s\n",
-		 batman_if->dev);
+		 batman_if->net_dev->name);
 
 	if (atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu <
 		ETH_DATA_LEN + BAT_HEADER_LEN)
@@ -309,7 +309,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 			"over this interface will be fragmented on layer2 "
 			"which could impact the performance. Setting the MTU "
 			"to %zi would solve the problem.\n",
-			batman_if->dev, batman_if->net_dev->mtu,
+			batman_if->net_dev->name, batman_if->net_dev->mtu,
 			ETH_DATA_LEN + BAT_HEADER_LEN);
 
 	if (!atomic_read(&bat_priv->frag_enabled) && batman_if->net_dev->mtu <
@@ -319,7 +319,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 			"the transport of batman-adv packets. If you experience"
 			" problems getting traffic through try increasing the "
 			"MTU to %zi.\n",
-			batman_if->dev, batman_if->net_dev->mtu,
+			batman_if->net_dev->name, batman_if->net_dev->mtu,
 			ETH_DATA_LEN + BAT_HEADER_LEN);
 
 	if (hardif_is_iface_up(batman_if))
@@ -327,7 +327,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 	else
 		bat_err(batman_if->soft_iface, "Not using interface %s "
 			"(retrying later): interface not active\n",
-			batman_if->dev);
+			batman_if->net_dev->name);
 
 	/* begin scheduling originator messages on that interface */
 	schedule_own_packet(batman_if);
@@ -350,7 +350,7 @@ void hardif_disable_interface(struct batman_if *batman_if)
 		return;
 
 	bat_info(batman_if->soft_iface, "Removing interface: %s\n",
-		 batman_if->dev);
+		 batman_if->net_dev->name);
 	dev_remove_pack(&batman_if->batman_adv_ptype);
 
 	bat_priv->num_ifaces--;
@@ -392,13 +392,9 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 		goto out;
 	}
 
-	batman_if->dev = kstrdup(net_dev->name, GFP_ATOMIC);
-	if (!batman_if->dev)
-		goto free_if;
-
 	ret = sysfs_add_hardif(&batman_if->hardif_obj, net_dev);
 	if (ret)
-		goto free_dev;
+		goto free_if;
 
 	batman_if->if_num = -1;
 	batman_if->net_dev = net_dev;
@@ -410,8 +406,6 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	list_add_tail_rcu(&batman_if->list, &if_list);
 	return batman_if;
 
-free_dev:
-	kfree(batman_if->dev);
 free_if:
 	kfree(batman_if);
 out:
@@ -422,7 +416,6 @@ static void hardif_free_interface(struct rcu_head *rcu)
 {
 	struct batman_if *batman_if = container_of(rcu, struct batman_if, rcu);
 
-	kfree(batman_if->dev);
 	kfree(batman_if);
 }
 
@@ -473,8 +466,6 @@ static int hard_if_event(struct notifier_block *this,
 	case NETDEV_UNREGISTER:
 		hardif_remove_interface(batman_if);
 		break;
-	case NETDEV_CHANGENAME:
-		break;
 	case NETDEV_CHANGEADDR:
 		if (batman_if->if_status == IF_NOT_IN_USE)
 			goto out;
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index eb8081d..2250266 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -216,7 +216,7 @@ static bool purge_orig_neighbors(struct bat_priv *bat_priv,
 					"neighbor purge: originator %pM, "
 					"neighbor: %pM, iface: %s\n",
 					orig_node->orig, neigh_node->addr,
-					neigh_node->if_incoming->dev);
+					neigh_node->if_incoming->net_dev->name);
 			else
 				bat_dbg(DBG_BATMAN, bat_priv,
 					"neighbor timeout: originator %pM, "
@@ -338,8 +338,8 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 	rcu_read_lock();
 	seq_printf(seq, "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
 		   SOURCE_VERSION, REVISION_VERSION_STR,
-		   bat_priv->primary_if->dev, bat_priv->primary_if->addr_str,
-		   net_dev->name);
+		   bat_priv->primary_if->net_dev->name,
+		   bat_priv->primary_if->addr_str, net_dev->name);
 	seq_printf(seq, "  %-15s %s (%s/%i) %17s [%10s]: %20s ...\n",
 		   "Originator", "last-seen", "#", TQ_MAX_VALUE, "Nexthop",
 		   "outgoingIF", "Potential nexthops");
@@ -367,7 +367,7 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 		seq_printf(seq, "%-17s %4i.%03is   (%3i) %17s [%10s]:",
 			   orig_str, last_seen_secs, last_seen_msecs,
 			   orig_node->router->tq_avg, router_str,
-			   orig_node->router->if_incoming->dev);
+			   orig_node->router->if_incoming->net_dev->name);
 
 		list_for_each_entry(neigh_node, &orig_node->neigh_list, list) {
 			addr_to_string(orig_str, neigh_node->addr);
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 522e702..454a84c 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -569,10 +569,11 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		"Received BATMAN packet via NB: %pM, IF: %s [%s] "
 		"(from OG: %pM, via prev OG: %pM, seqno %d, tq %d, "
 		"TTL %d, V %d, IDF %d)\n",
-		ethhdr->h_source, if_incoming->dev, if_incoming->addr_str,
-		batman_packet->orig, batman_packet->prev_sender,
-		batman_packet->seqno, batman_packet->tq, batman_packet->ttl,
-		batman_packet->version, has_directlink_flag);
+		ethhdr->h_source, if_incoming->net_dev->name,
+		if_incoming->addr_str, batman_packet->orig,
+		batman_packet->prev_sender, batman_packet->seqno,
+		batman_packet->tq, batman_packet->ttl, batman_packet->version,
+		has_directlink_flag);
 
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
 		if (batman_if->if_status != IF_ACTIVE)
diff --git a/batman-adv/send.c b/batman-adv/send.c
index 97c3142..92eb421 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -70,7 +70,7 @@ int send_skb_packet(struct sk_buff *skb,
 
 	if (!(batman_if->net_dev->flags & IFF_UP)) {
 		pr_warning("Interface %s is not up - can't send packet via "
-			   "that interface!\n", batman_if->dev);
+			   "that interface!\n", batman_if->net_dev->name);
 		goto send_skb_err;
 	}
 
@@ -143,7 +143,7 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 			batman_packet->tq, batman_packet->ttl,
 			(batman_packet->flags & DIRECTLINK ?
 			 "on" : "off"),
-			batman_if->dev, batman_if->addr_str);
+			batman_if->net_dev->name, batman_if->addr_str);
 
 		buff_pos += sizeof(struct batman_packet) +
 			(batman_packet->num_hna * ETH_ALEN);
@@ -188,7 +188,8 @@ static void send_packet(struct forw_packet *forw_packet)
 			"on interface %s [%s]\n",
 			(forw_packet->own ? "Sending own" : "Forwarding"),
 			batman_packet->orig, ntohl(batman_packet->seqno),
-			batman_packet->ttl, forw_packet->if_incoming->dev,
+			batman_packet->ttl,
+			forw_packet->if_incoming->net_dev->name,
 			forw_packet->if_incoming->addr_str);
 
 		/* skb is only used once and than forw_packet is free'd */
@@ -530,7 +531,7 @@ void purge_outstanding_packets(struct bat_priv *bat_priv,
 	if (batman_if)
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"purge_outstanding_packets(): %s\n",
-			batman_if->dev);
+			batman_if->net_dev->name);
 	else
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"purge_outstanding_packets()\n");
diff --git a/batman-adv/types.h b/batman-adv/types.h
index d260fd2..1e736fb 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -36,7 +36,6 @@
 struct batman_if {
 	struct list_head list;
 	int16_t if_num;
-	char *dev;
 	char if_status;
 	char addr_str[ETH_STR_LEN];
 	struct net_device *net_dev;
-- 
1.7.1

