Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 18 Jun 2012 22:39:09 +0200
Message-Id: <1340051963-14836-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1340051963-14836-1-git-send-email-ordex@autistici.org>
References: <1340051963-14836-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 05/19] batman-adv: Add get_ethtool_stats()
	support
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>, b.a.t.m.a.n@lists.open-mesh.org

From: Martin Hundebøll <martin@hundeboll.net>

Added additional counters in a bat_stats structure, which are exported
through the ethtool api. The counters are specific to batman-adv and
includes:
 forwarded packets and bytes
 management packets and bytes (aggregated OGMs at this point)
 translation table packets

New counters are added by extending "enum bat_counters" in types.h and
adding corresponding  descriptive string(s) to bat_counters_strings in
soft-iface.c.

Counters are increased by calling batadv_add_counter() and incremented
by one by calling batadv_inc_counter().

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 Documentation/networking/batman-adv.txt |    5 +++
 net/batman-adv/bat_iv_ogm.c             |   10 ++++-
 net/batman-adv/main.c                   |    2 +
 net/batman-adv/main.h                   |   27 +++++++++++++
 net/batman-adv/routing.c                |   11 ++++++
 net/batman-adv/soft-interface.c         |   66 ++++++++++++++++++++++++++++++-
 net/batman-adv/translation-table.c      |    8 ++++
 net/batman-adv/types.h                  |   17 ++++++++
 8 files changed, 143 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/batman-adv.txt b/Documentation/networking/batman-adv.txt
index 75a5923..8f3ae4a 100644
--- a/Documentation/networking/batman-adv.txt
+++ b/Documentation/networking/batman-adv.txt
@@ -211,6 +211,11 @@ The debug output can be changed at runtime  using  the  file
 
 will enable debug messages for when routes change.
 
+Counters for different types of packets entering and leaving the
+batman-adv module are available through ethtool:
+
+# ethtool --statistics bat0
+
 
 BATCTL
 ------
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index ec35119..99ec218 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -196,8 +196,12 @@ static void bat_iv_ogm_send_to_if(struct forw_packet *forw_packet,
 
 	/* create clone because function is called more than once */
 	skb = skb_clone(forw_packet->skb, GFP_ATOMIC);
-	if (skb)
+	if (skb) {
+		batadv_inc_counter(bat_priv, BAT_CNT_MGMT_TX);
+		batadv_add_counter(bat_priv, BAT_CNT_MGMT_TX_BYTES,
+				   skb->len + ETH_HLEN);
 		send_skb_packet(skb, hard_iface, broadcast_addr);
+	}
 }
 
 /* send a batman ogm packet */
@@ -1203,6 +1207,10 @@ static int bat_iv_ogm_receive(struct sk_buff *skb,
 	if (bat_priv->bat_algo_ops->bat_ogm_emit != bat_iv_ogm_emit)
 		return NET_RX_DROP;
 
+	batadv_inc_counter(bat_priv, BAT_CNT_MGMT_RX);
+	batadv_add_counter(bat_priv, BAT_CNT_MGMT_RX_BYTES,
+			   skb->len + ETH_HLEN);
+
 	packet_len = skb_headlen(skb);
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 	packet_buff = skb->data;
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 083a299..bd83aa4 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -153,6 +153,8 @@ void mesh_free(struct net_device *soft_iface)
 
 	bla_free(bat_priv);
 
+	free_percpu(bat_priv->bat_counters);
+
 	atomic_set(&bat_priv->mesh_state, MESH_INACTIVE);
 }
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 630bbe8..6e0cbdc 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -138,6 +138,7 @@ enum dbg_level {
 #include <linux/kthread.h>	/* kernel threads */
 #include <linux/pkt_sched.h>	/* schedule types */
 #include <linux/workqueue.h>	/* workqueue */
+#include <linux/percpu.h>
 #include <linux/slab.h>
 #include <net/sock.h>		/* struct sock */
 #include <linux/jiffies.h>
@@ -242,4 +243,30 @@ static inline bool has_timed_out(unsigned long timestamp, unsigned int timeout)
 			  _dummy > smallest_signed_int(_dummy); })
 #define seq_after(x, y) seq_before(y, x)
 
+/* Stop preemption on local cpu while incrementing the counter */
+static inline void batadv_add_counter(struct bat_priv *bat_priv, size_t idx,
+				      size_t count)
+{
+	int cpu = get_cpu();
+	per_cpu_ptr(bat_priv->bat_counters, cpu)[idx] += count;
+	put_cpu();
+}
+
+#define batadv_inc_counter(b, i) batadv_add_counter(b, i, 1)
+
+/* Sum and return the cpu-local counters for index 'idx' */
+static inline uint64_t batadv_sum_counter(struct bat_priv *bat_priv, size_t idx)
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
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 015471d..369604c 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -600,6 +600,8 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	switch (tt_query->flags & TT_QUERY_TYPE_MASK) {
 	case TT_REQUEST:
+		batadv_inc_counter(bat_priv, BAT_CNT_TT_REQUEST_RX);
+
 		/* If we cannot provide an answer the tt_request is
 		 * forwarded */
 		if (!send_tt_response(bat_priv, tt_query)) {
@@ -612,6 +614,8 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 		}
 		break;
 	case TT_RESPONSE:
+		batadv_inc_counter(bat_priv, BAT_CNT_TT_RESPONSE_RX);
+
 		if (is_my_mac(tt_query->dst)) {
 			/* packet needs to be linearized to access the TT
 			 * changes */
@@ -665,6 +669,8 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 	if (is_broadcast_ether_addr(ethhdr->h_source))
 		goto out;
 
+	batadv_inc_counter(bat_priv, BAT_CNT_TT_ROAM_ADV_RX);
+
 	roam_adv_packet = (struct roam_adv_packet *)skb->data;
 
 	if (!is_my_mac(roam_adv_packet->dst))
@@ -872,6 +878,11 @@ static int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	/* decrement ttl */
 	unicast_packet->header.ttl--;
 
+	/* Update stats counter */
+	batadv_inc_counter(bat_priv, BAT_CNT_FORWARD);
+	batadv_add_counter(bat_priv, BAT_CNT_FORWARD_BYTES,
+			   skb->len + ETH_HLEN);
+
 	/* route it */
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = NET_RX_SUCCESS;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 6e2530b..304a7ba 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -45,6 +45,10 @@ static void bat_get_drvinfo(struct net_device *dev,
 static u32 bat_get_msglevel(struct net_device *dev);
 static void bat_set_msglevel(struct net_device *dev, u32 value);
 static u32 bat_get_link(struct net_device *dev);
+static void batadv_get_strings(struct net_device *dev, u32 stringset, u8 *data);
+static void batadv_get_ethtool_stats(struct net_device *dev,
+				     struct ethtool_stats *stats, u64 *data);
+static int batadv_get_sset_count(struct net_device *dev, int stringset);
 
 static const struct ethtool_ops bat_ethtool_ops = {
 	.get_settings = bat_get_settings,
@@ -52,6 +56,9 @@ static const struct ethtool_ops bat_ethtool_ops = {
 	.get_msglevel = bat_get_msglevel,
 	.set_msglevel = bat_set_msglevel,
 	.get_link = bat_get_link,
+	.get_strings = batadv_get_strings,
+	.get_ethtool_stats = batadv_get_ethtool_stats,
+	.get_sset_count = batadv_get_sset_count,
 };
 
 int my_skb_head_push(struct sk_buff *skb, unsigned int len)
@@ -399,13 +406,18 @@ struct net_device *softif_create(const char *name)
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
@@ -421,6 +433,8 @@ unreg_debugfs:
 	debugfs_del_meshif(soft_iface);
 unreg_sysfs:
 	sysfs_del_meshif(soft_iface);
+free_bat_counters:
+	free_percpu(bat_priv->bat_counters);
 unreg_soft_iface:
 	unregister_netdevice(soft_iface);
 	return NULL;
@@ -486,3 +500,51 @@ static u32 bat_get_link(struct net_device *dev)
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
+};
+
+static void batadv_get_strings(struct net_device *dev, uint32_t stringset,
+			       uint8_t *data)
+{
+	if (stringset == ETH_SS_STATS)
+		memcpy(data, bat_counters_strings,
+		       sizeof(bat_counters_strings));
+}
+
+static void batadv_get_ethtool_stats(struct net_device *dev,
+				     struct ethtool_stats *stats,
+				     uint64_t *data)
+{
+	struct bat_priv *bat_priv = netdev_priv(dev);
+	int i;
+
+	for (i = 0; i < BAT_CNT_NUM; i++)
+		data[i] = batadv_sum_counter(bat_priv, i);
+}
+
+static int batadv_get_sset_count(struct net_device *dev, int stringset)
+{
+	if (stringset == ETH_SS_STATS)
+		return BAT_CNT_NUM;
+
+	return -EOPNOTSUPP;
+}
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index a66c2dc..ca53542 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1356,6 +1356,8 @@ static int send_tt_request(struct bat_priv *bat_priv,
 		dst_orig_node->orig, neigh_node->addr,
 		(full_table ? 'F' : '.'));
 
+	batadv_inc_counter(bat_priv, BAT_CNT_TT_REQUEST_TX);
+
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
 
@@ -1480,6 +1482,8 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 		res_dst_orig_node->orig, neigh_node->addr,
 		req_dst_orig_node->orig, req_ttvn);
 
+	batadv_inc_counter(bat_priv, BAT_CNT_TT_RESPONSE_TX);
+
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = true;
 	goto out;
@@ -1596,6 +1600,8 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 		orig_node->orig, neigh_node->addr,
 		(tt_response->flags & TT_FULL_TABLE ? 'F' : '.'));
 
+	batadv_inc_counter(bat_priv, BAT_CNT_TT_RESPONSE_TX);
+
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = true;
 	goto out;
@@ -1895,6 +1901,8 @@ static void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 		"Sending ROAMING_ADV to %pM (client %pM) via %pM\n",
 		orig_node->orig, client, neigh_node->addr);
 
+	batadv_inc_counter(bat_priv, BAT_CNT_TT_ROAM_ADV_TX);
+
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 547dc33..6b569de 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -148,9 +148,26 @@ struct bcast_duplist_entry {
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
+	BAT_CNT_NUM,
+};
+
 struct bat_priv {
 	atomic_t mesh_state;
 	struct net_device_stats stats;
+	uint64_t __percpu *bat_counters; /* Per cpu counters */
 	atomic_t aggregated_ogms;	/* boolean */
 	atomic_t bonding;		/* boolean */
 	atomic_t fragmentation;		/* boolean */
-- 
1.7.9.4

