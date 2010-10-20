Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 20 Oct 2010 23:01:07 +0200
Message-Id: <1287608467-5050-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1287589664-25447-1-git-send-email-andy.shevchenko@gmail.com>
References: <1287589664-25447-1-git-send-email-andy.shevchenko@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: remove useless addr_to_string()
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
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>

From: Andy Shevchenko <andy.shevchenko@gmail.com>

Since all *printf() methods in the kernel understand '%pM' modifier the
conversion to the string is useless beforehand.

Additionally this patch decreases batman_if structure by 20 bytes.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
[sven.eckelmann@gmx.de: Fix compilation errors]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/gateway_client.c |   13 +++++--------
 batman-adv/hard-interface.c |    2 --
 batman-adv/main.c           |    5 -----
 batman-adv/main.h           |    2 --
 batman-adv/originator.c     |   16 ++++++----------
 batman-adv/routing.c        |    4 ++--
 batman-adv/send.c           |    8 ++++----
 batman-adv/types.h          |    1 -
 batman-adv/vis.c            |   18 ++++++------------
 9 files changed, 23 insertions(+), 46 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index ae1ab1e..77f1044 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -351,17 +351,14 @@ static int _write_buffer_text(struct bat_priv *bat_priv,
 			      struct seq_file *seq, struct gw_node *gw_node)
 {
 	int down, up;
-	char gw_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
 
-	addr_to_string(gw_str, gw_node->orig_node->orig);
-	addr_to_string(router_str, gw_node->orig_node->router->addr);
 	gw_srv_class_to_kbit(gw_node->orig_node->gw_flags, &down, &up);
 
-	return seq_printf(seq, "%s %-17s (%3i) %17s [%10s]: %3i - %i%s/%i%s\n",
+	return seq_printf(seq, "%s %pM (%3i) %pM [%10s]: %3i - %i%s/%i%s\n",
 		       (bat_priv->curr_gw == gw_node ? "=>" : "  "),
-		       gw_str,
+		       gw_node->orig_node->orig,
 		       gw_node->orig_node->router->tq_avg,
-		       router_str,
+		       gw_node->orig_node->router->addr,
 		       gw_node->orig_node->router->if_incoming->net_dev->name,
 		       gw_node->orig_node->gw_flags,
 		       (down > 2048 ? down / 1024 : down),
@@ -393,11 +390,11 @@ int gw_client_seq_print_text(struct seq_file *seq, void *offset)
 	}
 
 	seq_printf(seq, "      %-12s (%s/%i) %17s [%10s]: gw_class ... "
-		   "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
+		   "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%pM (%s)]\n",
 		   "Gateway", "#", TQ_MAX_VALUE, "Nexthop",
 		   "outgoingIF", SOURCE_VERSION, REVISION_VERSION_STR,
 		   bat_priv->primary_if->net_dev->name,
-		   bat_priv->primary_if->addr_str, net_dev->name);
+		   bat_priv->primary_if->net_dev->dev_addr, net_dev->name);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node, node, &bat_priv->gw_list, list) {
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 3c59209..ef95680 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -171,8 +171,6 @@ static bool hardif_is_iface_up(struct batman_if *batman_if)
 
 static void update_mac_addresses(struct batman_if *batman_if)
 {
-	addr_to_string(batman_if->addr_str, batman_if->net_dev->dev_addr);
-
 	memcpy(((struct batman_packet *)(batman_if->packet_buff))->orig,
 	       batman_if->net_dev->dev_addr, ETH_ALEN);
 	memcpy(((struct batman_packet *)(batman_if->packet_buff))->prev_sender,
diff --git a/batman-adv/main.c b/batman-adv/main.c
index 6ecee49..b932c4d 100644
--- a/batman-adv/main.c
+++ b/batman-adv/main.c
@@ -154,11 +154,6 @@ void dec_module_count(void)
 	module_put(THIS_MODULE);
 }
 
-int addr_to_string(char *buff, uint8_t *addr)
-{
-	return sprintf(buff, "%pM", addr);
-}
-
 /* returns 1 if they are the same originator */
 
 int compare_orig(void *data1, void *data2)
diff --git a/batman-adv/main.h b/batman-adv/main.h
index cc42eb4..a4337ea 100644
--- a/batman-adv/main.h
+++ b/batman-adv/main.h
@@ -58,7 +58,6 @@
 
 #define PACKBUFF_SIZE 2000
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
-#define ETH_STR_LEN 20
 
 #define VIS_INTERVAL 5000	/* 5 seconds */
 
@@ -138,7 +137,6 @@ int mesh_init(struct net_device *soft_iface);
 void mesh_free(struct net_device *soft_iface);
 void inc_module_count(void);
 void dec_module_count(void);
-int addr_to_string(char *buff, uint8_t *addr);
 int compare_orig(void *data1, void *data2);
 int choose_orig(void *data, int32_t size);
 int is_my_mac(uint8_t *addr);
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 6868a2a..db2efc2 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -324,7 +324,6 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 	int last_seen_secs;
 	int last_seen_msecs;
 	unsigned long flags;
-	char orig_str[ETH_STR_LEN], router_str[ETH_STR_LEN];
 
 	if ((!bat_priv->primary_if) ||
 	    (bat_priv->primary_if->if_status != IF_ACTIVE)) {
@@ -338,10 +337,10 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 				  net_dev->name);
 	}
 
-	seq_printf(seq, "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%s (%s)]\n",
+	seq_printf(seq, "[B.A.T.M.A.N. adv %s%s, MainIF/MAC: %s/%pM (%s)]\n",
 		   SOURCE_VERSION, REVISION_VERSION_STR,
 		   bat_priv->primary_if->net_dev->name,
-		   bat_priv->primary_if->addr_str, net_dev->name);
+		   bat_priv->primary_if->net_dev->dev_addr, net_dev->name);
 	seq_printf(seq, "  %-15s %s (%s/%i) %17s [%10s]: %20s ...\n",
 		   "Originator", "last-seen", "#", TQ_MAX_VALUE, "Nexthop",
 		   "outgoingIF", "Potential nexthops");
@@ -358,21 +357,18 @@ int orig_seq_print_text(struct seq_file *seq, void *offset)
 		if (orig_node->router->tq_avg == 0)
 			continue;
 
-		addr_to_string(orig_str, orig_node->orig);
-		addr_to_string(router_str, orig_node->router->addr);
 		last_seen_secs = jiffies_to_msecs(jiffies -
 						orig_node->last_valid) / 1000;
 		last_seen_msecs = jiffies_to_msecs(jiffies -
 						orig_node->last_valid) % 1000;
 
-		seq_printf(seq, "%-17s %4i.%03is   (%3i) %17s [%10s]:",
-			   orig_str, last_seen_secs, last_seen_msecs,
-			   orig_node->router->tq_avg, router_str,
+		seq_printf(seq, "%pM %4i.%03is   (%3i) %pM [%10s]:",
+			   orig_node->orig, last_seen_secs, last_seen_msecs,
+			   orig_node->router->tq_avg, orig_node->router->addr,
 			   orig_node->router->if_incoming->net_dev->name);
 
 		list_for_each_entry(neigh_node, &orig_node->neigh_list, list) {
-			addr_to_string(orig_str, neigh_node->addr);
-			seq_printf(seq, " %17s (%3i)", orig_str,
+			seq_printf(seq, " %pM (%3i)", neigh_node->addr,
 					   neigh_node->tq_avg);
 		}
 
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index cc8b77f..e28fffe 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -566,11 +566,11 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 					    batman_packet->orig) ? 1 : 0);
 
 	bat_dbg(DBG_BATMAN, bat_priv,
-		"Received BATMAN packet via NB: %pM, IF: %s [%s] "
+		"Received BATMAN packet via NB: %pM, IF: %s [%pM] "
 		"(from OG: %pM, via prev OG: %pM, seqno %d, tq %d, "
 		"TTL %d, V %d, IDF %d)\n",
 		ethhdr->h_source, if_incoming->net_dev->name,
-		if_incoming->addr_str, batman_packet->orig,
+		if_incoming->net_dev->dev_addr, batman_packet->orig,
 		batman_packet->prev_sender, batman_packet->seqno,
 		batman_packet->tq, batman_packet->ttl, batman_packet->version,
 		has_directlink_flag);
diff --git a/batman-adv/send.c b/batman-adv/send.c
index 180e18b..cfacb4d 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -137,13 +137,13 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 							    "Forwarding"));
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"%s %spacket (originator %pM, seqno %d, TQ %d, TTL %d,"
-			" IDF %s) on interface %s [%s]\n",
+			" IDF %s) on interface %s [%pM]\n",
 			fwd_str, (packet_num > 0 ? "aggregated " : ""),
 			batman_packet->orig, ntohl(batman_packet->seqno),
 			batman_packet->tq, batman_packet->ttl,
 			(batman_packet->flags & DIRECTLINK ?
 			 "on" : "off"),
-			batman_if->net_dev->name, batman_if->addr_str);
+			batman_if->net_dev->name, batman_if->net_dev->dev_addr);
 
 		buff_pos += sizeof(struct batman_packet) +
 			(batman_packet->num_hna * ETH_ALEN);
@@ -188,12 +188,12 @@ static void send_packet(struct forw_packet *forw_packet)
 		/* FIXME: what about aggregated packets ? */
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"%s packet (originator %pM, seqno %d, TTL %d) "
-			"on interface %s [%s]\n",
+			"on interface %s [%pM]\n",
 			(forw_packet->own ? "Sending own" : "Forwarding"),
 			batman_packet->orig, ntohl(batman_packet->seqno),
 			batman_packet->ttl,
 			forw_packet->if_incoming->net_dev->name,
-			forw_packet->if_incoming->addr_str);
+			forw_packet->if_incoming->net_dev->dev_addr);
 
 		/* skb is only used once and than forw_packet is free'd */
 		send_skb_packet(forw_packet->skb, forw_packet->if_incoming,
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 44b3c07..b6e5a88 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -37,7 +37,6 @@ struct batman_if {
 	struct list_head list;
 	int16_t if_num;
 	char if_status;
-	char addr_str[ETH_STR_LEN];
 	struct net_device *net_dev;
 	atomic_t seqno;
 	atomic_t frag_seqno;
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index ddfdcd8..ebd85b3 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -131,15 +131,13 @@ static ssize_t vis_data_read_prim_sec(char *buff, struct hlist_head *if_list)
 {
 	struct if_list_entry *entry;
 	struct hlist_node *pos;
-	char tmp_addr_str[ETH_STR_LEN];
 	size_t len = 0;
 
 	hlist_for_each_entry(entry, pos, if_list, list) {
 		if (entry->primary)
 			len += sprintf(buff + len, "PRIMARY, ");
 		else {
-			addr_to_string(tmp_addr_str, entry->addr);
-			len += sprintf(buff + len,  "SEC %s, ", tmp_addr_str);
+			len += sprintf(buff + len,  "SEC %pM, ", entry->addr);
 		}
 	}
 
@@ -166,14 +164,12 @@ static size_t vis_data_count_prim_sec(struct hlist_head *if_list)
 static ssize_t vis_data_read_entry(char *buff, struct vis_info_entry *entry,
 				   uint8_t *src, bool primary)
 {
-	char to[18];
-
 	/* maximal length: max(4+17+2, 3+17+1+3+2) == 26 */
-	addr_to_string(to, entry->dest);
 	if (primary && entry->quality == 0)
-		return sprintf(buff, "HNA %s, ", to);
+		return sprintf(buff, "HNA %pM, ", entry->dest);
 	else if (compare_orig(entry->src, src))
-		return sprintf(buff, "TQ %s %d, ", to, entry->quality);
+		return sprintf(buff, "TQ %pM %d, ", entry->dest,
+			       entry->quality);
 
 	return 0;
 }
@@ -191,7 +187,6 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 	struct if_list_entry *entry;
 	struct hlist_node *pos, *n;
 	int i;
-	char tmp_addr_str[ETH_STR_LEN];
 	unsigned long flags;
 	int vis_server = atomic_read(&bat_priv->vis_mode);
 	size_t buff_pos, buf_size;
@@ -256,9 +251,8 @@ int vis_seq_print_text(struct seq_file *seq, void *offset)
 		}
 
 		hlist_for_each_entry(entry, pos, &vis_if_list, list) {
-			addr_to_string(tmp_addr_str, entry->addr);
-			buff_pos += sprintf(buff + buff_pos, "%s,",
-					    tmp_addr_str);
+			buff_pos += sprintf(buff + buff_pos, "%pM,",
+					    entry->addr);
 
 			for (i = 0; i < packet->entries; i++)
 				buff_pos += vis_data_read_entry(buff + buff_pos,
-- 
1.7.1

