Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 23 Jun 2012 11:47:53 +0200
Message-Id: <1340444873-5063-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: convert remaining packet
	counters to per_cpu_ptr() infrastructure
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bridge_loop_avoidance.c |    5 ++-
 soft-interface.c        |   50 +++++++++++++++++++++++++++++++----------------
 types.h                 |    5 ++++
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 1e2cfe5..b92b0ea 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -338,8 +338,9 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, uint8_t *mac,
 
 	skb_reset_mac_header(skb);
 	skb->protocol = eth_type_trans(skb, soft_iface);
-	bat_priv->stats.rx_packets++;
-	bat_priv->stats.rx_bytes += skb->len + ETH_HLEN;
+	batadv_inc_counter(bat_priv, BATADV_CNT_RX);
+	batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES,
+			   skb->len + ETH_HLEN);
 	soft_iface->last_rx = jiffies;
 
 	netif_rx(skb);
diff --git a/soft-interface.c b/soft-interface.c
index b7c655c..e06480a 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -93,7 +93,14 @@ static int batadv_interface_release(struct net_device *dev)
 static struct net_device_stats *batadv_interface_stats(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
-	return &bat_priv->stats;
+	struct net_device_stats *stats = &bat_priv->stats;
+
+	stats->tx_packets = batadv_sum_counter(bat_priv, BATADV_CNT_TX);
+	stats->tx_bytes = batadv_sum_counter(bat_priv, BATADV_CNT_TX_BYTES);
+	stats->tx_dropped = batadv_sum_counter(bat_priv, BATADV_CNT_TX_DROPPED);
+	stats->rx_packets = batadv_sum_counter(bat_priv, BATADV_CNT_RX);
+	stats->rx_bytes = batadv_sum_counter(bat_priv, BATADV_CNT_RX_BYTES);
+	return stats;
 }
 
 static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
@@ -245,14 +252,14 @@ static int batadv_interface_tx(struct sk_buff *skb,
 			goto dropped_freed;
 	}
 
-	bat_priv->stats.tx_packets++;
-	bat_priv->stats.tx_bytes += data_len;
+	batadv_inc_counter(bat_priv, BATADV_CNT_TX);
+	batadv_add_counter(bat_priv, BATADV_CNT_TX_BYTES, data_len);
 	goto end;
 
 dropped:
 	kfree_skb(skb);
 dropped_freed:
-	bat_priv->stats.tx_dropped++;
+	batadv_inc_counter(bat_priv, BATADV_CNT_TX_DROPPED);
 end:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
@@ -303,8 +310,9 @@ void batadv_interface_rx(struct net_device *soft_iface,
 
 	/* skb->ip_summed = CHECKSUM_UNNECESSARY; */
 
-	bat_priv->stats.rx_packets++;
-	bat_priv->stats.rx_bytes += skb->len + ETH_HLEN;
+	batadv_inc_counter(bat_priv, BATADV_CNT_RX);
+	batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES,
+			   skb->len + ETH_HLEN);
 
 	soft_iface->last_rx = jiffies;
 
@@ -374,15 +382,21 @@ struct net_device *batadv_softif_create(const char *name)
 	if (!soft_iface)
 		goto out;
 
+	bat_priv = netdev_priv(soft_iface);
+
+	/* batadv_interface_stats() needs to be available as soon as
+	 * register_netdevice() has been called */
+	bat_priv->bat_counters = __alloc_percpu(cnt_len, __alignof__(uint64_t));
+	if (!bat_priv->bat_counters)
+		goto free_soft_iface;
+
 	ret = register_netdevice(soft_iface);
 	if (ret < 0) {
 		pr_err("Unable to register the batman interface '%s': %i\n",
 		       name, ret);
-		goto free_soft_iface;
+		goto free_bat_counters;
 	}
 
-	bat_priv = netdev_priv(soft_iface);
-
 	atomic_set(&bat_priv->aggregated_ogms, 1);
 	atomic_set(&bat_priv->bonding, 0);
 	atomic_set(&bat_priv->bridge_loop_avoidance, 0);
@@ -412,17 +426,13 @@ struct net_device *batadv_softif_create(const char *name)
 	bat_priv->primary_if = NULL;
 	bat_priv->num_ifaces = 0;
 
-	bat_priv->bat_counters = __alloc_percpu(cnt_len, __alignof__(uint64_t));
-	if (!bat_priv->bat_counters)
-		goto unreg_soft_iface;
-
 	ret = batadv_algo_select(bat_priv, batadv_routing_algo);
 	if (ret < 0)
-		goto free_bat_counters;
+		goto unreg_soft_iface;
 
 	ret = batadv_sysfs_add_meshif(soft_iface);
 	if (ret < 0)
-		goto free_bat_counters;
+		goto unreg_soft_iface;
 
 	ret = batadv_debugfs_add_meshif(soft_iface);
 	if (ret < 0)
@@ -438,12 +448,13 @@ unreg_debugfs:
 	batadv_debugfs_del_meshif(soft_iface);
 unreg_sysfs:
 	batadv_sysfs_del_meshif(soft_iface);
-free_bat_counters:
-	free_percpu(bat_priv->bat_counters);
 unreg_soft_iface:
+	free_percpu(bat_priv->bat_counters);
 	unregister_netdevice(soft_iface);
 	return NULL;
 
+free_bat_counters:
+	free_percpu(bat_priv->bat_counters);
 free_soft_iface:
 	free_netdev(soft_iface);
 out:
@@ -513,6 +524,11 @@ static u32 batadv_get_link(struct net_device *dev)
 static const struct {
 	const char name[ETH_GSTRING_LEN];
 } batadv_counters_strings[] = {
+	{ "tx" },
+	{ "tx_bytes" },
+	{ "tx_dropped" },
+	{ "rx" },
+	{ "rx_bytes" },
 	{ "forward" },
 	{ "forward_bytes" },
 	{ "mgmt_tx" },
diff --git a/types.h b/types.h
index 2141c13..64b4317 100644
--- a/types.h
+++ b/types.h
@@ -144,6 +144,11 @@ struct batadv_bcast_duplist_entry {
 #endif
 
 enum batadv_counters {
+	BATADV_CNT_TX,
+	BATADV_CNT_TX_BYTES,
+	BATADV_CNT_TX_DROPPED,
+	BATADV_CNT_RX,
+	BATADV_CNT_RX_BYTES,
 	BATADV_CNT_FORWARD,
 	BATADV_CNT_FORWARD_BYTES,
 	BATADV_CNT_MGMT_TX,
-- 
1.7.9.1

