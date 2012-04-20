Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri, 20 Apr 2012 17:02:45 +0200
Message-Id: <1334934165-17430-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1334618695-28338-1-git-send-email-martin@hundeboll.net>
References: <1334618695-28338-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4] batman-adv: Add get_ethtool_stats() support
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Added additional counters in a bat_stats structure, which are exported
through the ethtool api. The counters are specific to batman-adv and
includes:
 forwarded packets and bytes
 management packets and bytes (aggregated OGMs at this point)
 translation table packets
 distributed arp table packets

New counters are added by extending "enum bat_counters" in types.h and
adding corresponding  descriptive string(s) to bat_counters_strings in
soft-iface.c.

Counters are increased by calling add_counter() and incremented by one
by calling inc_counter().

v2: Changed to per_cpu variables. Added ifdefs for optional submodules.
v3: Change from "struct bat_stats" to uint64_t array.
v4: Added byte counters. Moved free function. Added spaces.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 README                  |    5 ++++
 bat_iv_ogm.c            |    9 +++++-
 distributed-arp-table.c |    8 +++++-
 main.c                  |    2 ++
 main.h                  |   27 ++++++++++++++++++
 routing.c               |   10 +++++++
 soft-interface.c        |   71 +++++++++++++++++++++++++++++++++++++++++++++--
 translation-table.c     |    8 ++++++
 types.h                 |   23 +++++++++++++++
 9 files changed, 159 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 82c075f..49c03d5 100644
--- a/README
+++ b/README
@@ -212,6 +212,11 @@ The debug output can be changed at runtime  using  the  file
 
 will enable debug messages for when routes change.
 
+Counters for different types of packets entering and leaving the
+batman-adv module are available through ethtool:
+
+# ethtool --statistics bat0
+
 
 BATCTL
 ------
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 994369d..b222ed9 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -196,8 +196,12 @@ static void bat_iv_ogm_send_to_if(struct forw_packet *forw_packet,
 
 	/* create clone because function is called more than once */
 	skb = skb_clone(forw_packet->skb, GFP_ATOMIC);
-	if (skb)
+	if (skb) {
+		inc_counter(bat_priv, BAT_CNT_MGMT_TX);
+		add_counter(bat_priv, BAT_CNT_MGMT_TX_BYTES,
+			    skb->len + ETH_HLEN);
 		send_skb_packet(skb, hard_iface, broadcast_addr);
+	}
 }
 
 /* send a batman ogm packet */
@@ -1204,6 +1208,9 @@ static int bat_iv_ogm_receive(struct sk_buff *skb,
 	if (bat_priv->bat_algo_ops->bat_ogm_emit != bat_iv_ogm_emit)
 		return NET_RX_DROP;
 
+	inc_counter(bat_priv, BAT_CNT_MGMT_RX);
+	add_counter(bat_priv, BAT_CNT_MGMT_RX_BYTES, skb->len + ETH_HLEN);
+
 	packet_len = skb_headlen(skb);
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 	packet_buff = skb->data;
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index b43bece..a2d3821 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -395,9 +395,11 @@ bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
 
 		netif_rx(skb_new);
 		bat_dbg(DBG_DAT, bat_priv, "ARP request replied locally\n");
-	} else
+	} else {
 		/* Send the request on the DHT */
+		inc_counter(bat_priv, BAT_CNT_DAT_REQUEST_TX);
 		ret = dht_send_data(bat_priv, skb, ip_dst, BAT_P_DAT_DHT_GET);
+	}
 out:
 	if (n)
 		neigh_release(n);
@@ -450,6 +452,8 @@ bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
 	if (!skb_new)
 		goto out;
 
+	inc_counter(bat_priv, BAT_CNT_DAT_REPLY_TX);
+
 	unicast_4addr_send_skb(skb_new, bat_priv, BAT_P_DAT_CACHE_REPLY);
 
 	ret = true;
@@ -488,6 +492,8 @@ bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
 	arp_neigh_update(bat_priv, ip_src, hw_src);
 	arp_neigh_update(bat_priv, ip_dst, hw_dst);
 
+	inc_counter(bat_priv, BAT_CNT_DAT_REPLY_TX);
+
 	/* Send the ARP reply to the candidates for both the IP addresses we
 	 * fetched from the ARP reply */
 	dht_send_data(bat_priv, skb, ip_src, BAT_P_DAT_DHT_PUT);
diff --git a/main.c b/main.c
index 0757c2d..5a193f5 100644
--- a/main.c
+++ b/main.c
@@ -153,6 +153,8 @@ void mesh_free(struct net_device *soft_iface)
 
 	bla_free(bat_priv);
 
+	free_percpu(bat_priv->bat_counters);
+
 	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
 }
 
diff --git a/main.h b/main.h
index c8bfe28..9dc7971 100644
--- a/main.h
+++ b/main.h
@@ -150,6 +150,7 @@ enum dbg_level {
 #include <linux/kthread.h>	/* kernel threads */
 #include <linux/pkt_sched.h>	/* schedule types */
 #include <linux/workqueue.h>	/* workqueue */
+#include <linux/percpu.h>
 #include <linux/slab.h>
 #include <net/sock.h>		/* struct sock */
 #include <linux/jiffies.h>
@@ -259,4 +260,30 @@ static inline bool has_timed_out(unsigned long timestamp, unsigned int timeout)
 			  _dummy > smallest_signed_int(_dummy); })
 #define seq_after(x, y) seq_before(y, x)
 
+/* Stop preemption on local cpu while incrementing the counter */
+static inline void add_counter(struct bat_priv *bat_priv, size_t idx,
+			       size_t count)
+{
+	int cpu = get_cpu();
+	per_cpu_ptr(bat_priv->bat_counters, cpu)[idx] += count;
+	put_cpu();
+}
+
+#define inc_counter(b, i) add_counter(b, i, 1)
+
+/* Sum and return the cpu-local counters for index 'idx' */
+static inline uint64_t sum_counter(struct bat_priv *bat_priv, size_t idx)
+{
+	uint64_t *counters;
+	int cpu;
+	int sum = 0;
+
+	for_each_possible_cpu(cpu) {
+		counters = per_cpu_ptr(bat_priv->bat_counters, cpu);
+		sum += counters[idx];
+	}
+
+	return sum;
+}
+
 #endif /* _NET_BATMAN_ADV_MAIN_H_ */
diff --git a/routing.c b/routing.c
index 795d3af..de420c6 100644
--- a/routing.c
+++ b/routing.c
@@ -600,6 +600,8 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	switch (tt_query->flags & TT_QUERY_TYPE_MASK) {
 	case TT_REQUEST:
+		inc_counter(bat_priv, BAT_CNT_TT_REQUEST_RX);
+
 		/* If we cannot provide an answer the tt_request is
 		 * forwarded */
 		if (!send_tt_response(bat_priv, tt_query)) {
@@ -612,6 +614,8 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 		}
 		break;
 	case TT_RESPONSE:
+		inc_counter(bat_priv, BAT_CNT_TT_RESPONSE_RX);
+
 		if (is_my_mac(tt_query->dst)) {
 			/* packet needs to be linearized to access the TT
 			 * changes */
@@ -663,6 +667,8 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 	if (is_broadcast_ether_addr(ethhdr->h_source))
 		goto out;
 
+	inc_counter(bat_priv, BAT_CNT_TT_ROAM_ADV_RX);
+
 	roam_adv_packet = (struct roam_adv_packet *)skb->data;
 
 	if (!is_my_mac(roam_adv_packet->dst))
@@ -869,6 +875,10 @@ static int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	/* decrement ttl */
 	unicast_packet->header.ttl--;
 
+	/* Update stats counter */
+	inc_counter(bat_priv, BAT_CNT_FORWARD);
+	add_counter(bat_priv, BAT_CNT_FORWARD_BYTES, skb->len + ETH_HLEN);
+
 	/* route it */
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = NET_RX_SUCCESS;
diff --git a/soft-interface.c b/soft-interface.c
index 92137af..ab13af9 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -46,6 +46,10 @@ static void bat_get_drvinfo(struct net_device *dev,
 static u32 bat_get_msglevel(struct net_device *dev);
 static void bat_set_msglevel(struct net_device *dev, u32 value);
 static u32 bat_get_link(struct net_device *dev);
+static void bat_get_strings(struct net_device *dev, u32 stringset, u8 *data);
+static void bat_get_ethtool_stats(struct net_device *dev,
+				  struct ethtool_stats *stats, u64 *data);
+static int bat_get_sset_count(struct net_device *dev, int stringset);
 
 static const struct ethtool_ops bat_ethtool_ops = {
 	.get_settings = bat_get_settings,
@@ -53,6 +57,9 @@ static const struct ethtool_ops bat_ethtool_ops = {
 	.get_msglevel = bat_get_msglevel,
 	.set_msglevel = bat_set_msglevel,
 	.get_link = bat_get_link,
+	.get_strings = bat_get_strings,
+	.get_ethtool_stats = bat_get_ethtool_stats,
+	.get_sset_count = bat_get_sset_count,
 };
 
 int my_skb_head_push(struct sk_buff *skb, unsigned int len)
@@ -411,13 +418,18 @@ struct net_device *softif_create(const char *name)
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
 
+	bat_priv->bat_counters = __alloc_percpu(sizeof(uint64_t) * BAT_CNT_NUM,
+						__alignof__(uint64_t));
+	if (!bat_priv->bat_counters)
+		goto unreg_soft_iface;
+
 	ret = bat_algo_select(bat_priv, bat_routing_algo);
 	if (ret < 0)
-		goto unreg_soft_iface;
+		goto free_bat_counters;
 
 	ret = sysfs_add_meshif(soft_iface);
 	if (ret < 0)
-		goto unreg_soft_iface;
+		goto free_bat_counters;
 
 	ret = debugfs_add_meshif(soft_iface);
 	if (ret < 0)
@@ -433,6 +445,8 @@ unreg_debugfs:
 	debugfs_del_meshif(soft_iface);
 unreg_sysfs:
 	sysfs_del_meshif(soft_iface);
+free_bat_counters:
+	free_percpu(bat_priv->bat_counters);
 unreg_soft_iface:
 	unregister_netdevice(soft_iface);
 	return NULL;
@@ -498,3 +512,56 @@ static u32 bat_get_link(struct net_device *dev)
 {
 	return 1;
 }
+
+/* Inspired by drivers/net/ethernet/dlink/sundance.c:1702
+ * Declare each description string in struct.name[] to get fixed sized buffer
+ * and compile time checking for strings longer than ETH_GSTRING_LEN.
+ */
+static const struct {
+	const char name[ETH_GSTRING_LEN];
+} bat_counters_strings[] = {
+	{ "forward" },
+	{ "forward_bytes" },
+	{ "mgmt_tx" },
+	{ "mgmt_tx_bytes" },
+	{ "mgmt_rx" },
+	{ "mgmt_rx_bytes" },
+	{ "tt_request_tx" },
+	{ "tt_request_rx" },
+	{ "tt_response_tx" },
+	{ "tt_response_rx" },
+	{ "tt_roam_adv_tx" },
+	{ "tt_roam_adv_rx" },
+#ifdef CONFIG_BATMAN_ADV_DAT
+	{ "dat_request_tx" },
+	{ "dat_request_rx" },
+	{ "dat_reply_tx" },
+	{ "dat_reply_rx" },
+#endif
+};
+
+static void bat_get_strings(struct net_device *dev, uint32_t stringset,
+			    uint8_t *data)
+{
+	if (stringset == ETH_SS_STATS)
+		memcpy(data, bat_counters_strings,
+		       sizeof(bat_counters_strings));
+}
+
+static void bat_get_ethtool_stats(struct net_device *dev,
+				  struct ethtool_stats *stats, uint64_t *data)
+{
+	struct bat_priv *bat_priv = netdev_priv(dev);
+	int i;
+
+	for (i = 0; i < BAT_CNT_NUM; i++)
+		data[i] = sum_counter(bat_priv, i);
+}
+
+static int bat_get_sset_count(struct net_device *dev, int stringset)
+{
+	if (stringset == ETH_SS_STATS)
+		return BAT_CNT_NUM;
+
+	return -EOPNOTSUPP;
+}
diff --git a/translation-table.c b/translation-table.c
index b3e608a..7f5dffe 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1352,6 +1352,8 @@ static int send_tt_request(struct bat_priv *bat_priv,
 		dst_orig_node->orig, neigh_node->addr,
 		(full_table ? 'F' : '.'));
 
+	inc_counter(bat_priv, BAT_CNT_TT_REQUEST_TX);
+
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
 
@@ -1476,6 +1478,8 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 		res_dst_orig_node->orig, neigh_node->addr,
 		req_dst_orig_node->orig, req_ttvn);
 
+	inc_counter(bat_priv, BAT_CNT_TT_RESPONSE_TX);
+
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = true;
 	goto out;
@@ -1592,6 +1596,8 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 		orig_node->orig, neigh_node->addr,
 		(tt_response->flags & TT_FULL_TABLE ? 'F' : '.'));
 
+	inc_counter(bat_priv, BAT_CNT_TT_RESPONSE_TX);
+
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = true;
 	goto out;
@@ -1891,6 +1897,8 @@ static void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 		"Sending ROAMING_ADV to %pM (client %pM) via %pM\n",
 		orig_node->orig, client, neigh_node->addr);
 
+	inc_counter(bat_priv, BAT_CNT_TT_ROAM_ADV_TX);
+
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
 
diff --git a/types.h b/types.h
index 15f538a..57ba44f 100644
--- a/types.h
+++ b/types.h
@@ -162,9 +162,32 @@ struct bcast_duplist_entry {
 };
 #endif
 
+enum bat_counters {
+	BAT_CNT_FORWARD,
+	BAT_CNT_FORWARD_BYTES,
+	BAT_CNT_MGMT_TX,
+	BAT_CNT_MGMT_TX_BYTES,
+	BAT_CNT_MGMT_RX,
+	BAT_CNT_MGMT_RX_BYTES,
+	BAT_CNT_TT_REQUEST_TX,
+	BAT_CNT_TT_REQUEST_RX,
+	BAT_CNT_TT_RESPONSE_TX,
+	BAT_CNT_TT_RESPONSE_RX,
+	BAT_CNT_TT_ROAM_ADV_TX,
+	BAT_CNT_TT_ROAM_ADV_RX,
+#ifdef CONFIG_BATMAN_ADV_DAT
+	BAT_CNT_DAT_REQUEST_TX,
+	BAT_CNT_DAT_REQUEST_RX,
+	BAT_CNT_DAT_REPLY_TX,
+	BAT_CNT_DAT_REPLY_RX,
+#endif
+	BAT_CNT_NUM,
+};
+
 struct bat_priv {
 	atomic_t mesh_state;
 	struct net_device_stats stats;
+	uint64_t *bat_counters; /* Per cpu counters */
 	atomic_t aggregated_ogms;	/* boolean */
 	atomic_t bonding;		/* boolean */
 	atomic_t fragmentation;		/* boolean */
-- 
1.7.10

