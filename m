Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Tue, 17 Apr 2012 01:24:55 +0200
Message-Id: <1334618695-28338-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add get_ethtool_stats() support
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
 forwarded packets
 management packets (OGMs at this point)
 translation table packets
 distributed arp table packets

I would like you all to check if the increments are added at the right
locations and also if more counters would be relevant. (E.g. in bridge
loop avoidance code?)

This is the reworked approach from the previous stat counters patch I
send, where ethtool stats was suggested.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 bat_iv_ogm.c            |    6 ++++-
 distributed-arp-table.c |    8 ++++++-
 routing.c               |    9 +++++++
 soft-interface.c        |   61 +++++++++++++++++++++++++++++++++++++++++++++++
 translation-table.c     |    8 +++++++
 types.h                 |   17 +++++++++++++
 6 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 994369d..288326a 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -196,8 +196,10 @@ static void bat_iv_ogm_send_to_if(struct forw_packet *forw_packet,
 
 	/* create clone because function is called more than once */
 	skb = skb_clone(forw_packet->skb, GFP_ATOMIC);
-	if (skb)
+	if (skb) {
+		bat_priv->bat_stats.mgmt_tx++;
 		send_skb_packet(skb, hard_iface, broadcast_addr);
+	}
 }
 
 /* send a batman ogm packet */
@@ -956,6 +958,8 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 	if (batman_ogm_packet->header.packet_type != BAT_IV_OGM)
 		return;
 
+	bat_priv->bat_stats.mgmt_rx++;
+
 	/* could be changed by schedule_own_packet() */
 	if_incoming_seqno = atomic_read(&if_incoming->seqno);
 
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index b43bece..cc3182e 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -395,9 +395,11 @@ bool dat_snoop_outgoing_arp_request(struct bat_priv *bat_priv,
 
 		netif_rx(skb_new);
 		bat_dbg(DBG_DAT, bat_priv, "ARP request replied locally\n");
-	} else
+	} else {
 		/* Send the request on the DHT */
+		bat_priv->bat_stats.dat_request_tx++;
 		ret = dht_send_data(bat_priv, skb, ip_dst, BAT_P_DAT_DHT_GET);
+	}
 out:
 	if (n)
 		neigh_release(n);
@@ -450,6 +452,8 @@ bool dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
 	if (!skb_new)
 		goto out;
 
+	bat_priv->bat_stats.dat_reply_tx++;
+
 	unicast_4addr_send_skb(skb_new, bat_priv, BAT_P_DAT_CACHE_REPLY);
 
 	ret = true;
@@ -488,6 +492,8 @@ bool dat_snoop_outgoing_arp_reply(struct bat_priv *bat_priv,
 	arp_neigh_update(bat_priv, ip_src, hw_src);
 	arp_neigh_update(bat_priv, ip_dst, hw_dst);
 
+	bat_priv->bat_stats.dat_reply_tx++;
+
 	/* Send the ARP reply to the candidates for both the IP addresses we
 	 * fetched from the ARP reply */
 	dht_send_data(bat_priv, skb, ip_src, BAT_P_DAT_DHT_PUT);
diff --git a/routing.c b/routing.c
index 795d3af..28ce7b9 100644
--- a/routing.c
+++ b/routing.c
@@ -600,6 +600,8 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 
 	switch (tt_query->flags & TT_QUERY_TYPE_MASK) {
 	case TT_REQUEST:
+		bat_priv->bat_stats.tt_request_rx++;
+
 		/* If we cannot provide an answer the tt_request is
 		 * forwarded */
 		if (!send_tt_response(bat_priv, tt_query)) {
@@ -612,6 +614,8 @@ int recv_tt_query(struct sk_buff *skb, struct hard_iface *recv_if)
 		}
 		break;
 	case TT_RESPONSE:
+		bat_priv->bat_stats.tt_response_rx++;
+
 		if (is_my_mac(tt_query->dst)) {
 			/* packet needs to be linearized to access the TT
 			 * changes */
@@ -663,6 +667,8 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
 	if (is_broadcast_ether_addr(ethhdr->h_source))
 		goto out;
 
+	bat_priv->bat_stats.tt_roam_adv_rx++;
+
 	roam_adv_packet = (struct roam_adv_packet *)skb->data;
 
 	if (!is_my_mac(roam_adv_packet->dst))
@@ -869,6 +875,9 @@ static int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	/* decrement ttl */
 	unicast_packet->header.ttl--;
 
+	/* Update stats counter */
+	bat_priv->bat_stats.forward++;
+
 	/* route it */
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = NET_RX_SUCCESS;
diff --git a/soft-interface.c b/soft-interface.c
index 92137af..095ee83 100644
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
@@ -498,3 +505,57 @@ static u32 bat_get_link(struct net_device *dev)
 {
 	return 1;
 }
+
+/* Inspired by drivers/net/ethernet/dlink/sundance.c:1702 */
+static const struct {
+	const char name[ETH_GSTRING_LEN];
+} bat_stats_strings[] = {
+	{ "forward" },
+	{ "mgmt_tx" },
+	{ "mgmt_rx" },
+	{ "tt_request_tx" },
+	{ "tt_request_rx" },
+	{ "tt_response_tx" },
+	{ "tt_response_rx" },
+	{ "tt_roam_adv_tx" },
+	{ "tt_roam_adv_rx" },
+	{ "dat_request_tx" },
+	{ "dat_request_rx" },
+	{ "dat_reply_tx" },
+	{ "dat_reply_rx" },
+};
+#define BAT_STATS_NUM 13
+
+static void bat_get_strings(struct net_device *dev, u32 stringset, u8 *data)
+{
+	if (stringset == ETH_SS_STATS)
+		memcpy(data, bat_stats_strings, sizeof(bat_stats_strings));
+}
+
+static void bat_get_ethtool_stats(struct net_device *dev,
+				  struct ethtool_stats *stats, u64 *data)
+{
+	struct bat_priv *bat_priv = netdev_priv(dev);
+
+	data[0] = bat_priv->bat_stats.forward;
+	data[1] = bat_priv->bat_stats.mgmt_tx;
+	data[2] = bat_priv->bat_stats.mgmt_rx;
+	data[3] = bat_priv->bat_stats.tt_request_tx;
+	data[4] = bat_priv->bat_stats.tt_request_rx;
+	data[5] = bat_priv->bat_stats.tt_response_tx;
+	data[6] = bat_priv->bat_stats.tt_response_rx;
+	data[7] = bat_priv->bat_stats.tt_roam_adv_tx;
+	data[8] = bat_priv->bat_stats.tt_roam_adv_rx;
+	data[9] = bat_priv->bat_stats.dat_request_tx;
+	data[10] = bat_priv->bat_stats.dat_request_rx;
+	data[11] = bat_priv->bat_stats.dat_reply_tx;
+	data[12] = bat_priv->bat_stats.dat_reply_rx;
+}
+
+static int bat_get_sset_count(struct net_device *dev, int stringset)
+{
+	if (stringset == ETH_SS_STATS)
+		return BAT_STATS_NUM;
+
+	return -EOPNOTSUPP;
+}
diff --git a/translation-table.c b/translation-table.c
index b3e608a..aa0afb1 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1352,6 +1352,8 @@ static int send_tt_request(struct bat_priv *bat_priv,
 		dst_orig_node->orig, neigh_node->addr,
 		(full_table ? 'F' : '.'));
 
+	bat_priv->bat_stats.tt_request_tx++;
+
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
 
@@ -1476,6 +1478,8 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 		res_dst_orig_node->orig, neigh_node->addr,
 		req_dst_orig_node->orig, req_ttvn);
 
+	bat_priv->bat_stats.tt_response_tx++;
+
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = true;
 	goto out;
@@ -1592,6 +1596,8 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 		orig_node->orig, neigh_node->addr,
 		(tt_response->flags & TT_FULL_TABLE ? 'F' : '.'));
 
+	bat_priv->bat_stats.tt_response_tx++;
+
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = true;
 	goto out;
@@ -1891,6 +1897,8 @@ static void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 		"Sending ROAMING_ADV to %pM (client %pM) via %pM\n",
 		orig_node->orig, client, neigh_node->addr);
 
+	bat_priv->bat_stats.tt_roam_adv_tx++;
+
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
 
diff --git a/types.h b/types.h
index 15f538a..c4c1e13 100644
--- a/types.h
+++ b/types.h
@@ -162,9 +162,26 @@ struct bcast_duplist_entry {
 };
 #endif
 
+struct bat_stats {
+	uint64_t forward;
+	uint64_t mgmt_tx;
+	uint64_t mgmt_rx;
+	uint64_t tt_request_tx;
+	uint64_t tt_request_rx;
+	uint64_t tt_response_tx;
+	uint64_t tt_response_rx;
+	uint64_t tt_roam_adv_tx;
+	uint64_t tt_roam_adv_rx;
+	uint64_t dat_request_tx;
+	uint64_t dat_request_rx;
+	uint64_t dat_reply_tx;
+	uint64_t dat_reply_rx;
+};
+
 struct bat_priv {
 	atomic_t mesh_state;
 	struct net_device_stats stats;
+	struct bat_stats bat_stats;
 	atomic_t aggregated_ogms;	/* boolean */
 	atomic_t bonding;		/* boolean */
 	atomic_t fragmentation;		/* boolean */
-- 
1.7.10

