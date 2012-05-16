Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 May 2012 20:23:15 +0200
Message-Id: <1337192605-8652-3-git-send-email-sven@narfation.org>
In-Reply-To: <1337192605-8652-1-git-send-email-sven@narfation.org>
References: <1779270.uUsuEFyTM4@sven-desktop.home.narfation.org>
	<1337192605-8652-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 03/13] batman-adv: Prefix soft-interface
	local static functions with batadv_
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

All non-static symbols of batman-adv were prefixed with batadv_ to avoid
collisions with other symbols of the kernel. Other symbols of batman-adv
should use the same prefix to keep the naming scheme consistent.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 soft-interface.c |  105 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 54 insertions(+), 51 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index dfe32b9..9b4c0d0 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -38,26 +38,26 @@
 #include "bridge_loop_avoidance.h"
 
 
-static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
-static void bat_get_drvinfo(struct net_device *dev,
-			    struct ethtool_drvinfo *info);
-static u32 bat_get_msglevel(struct net_device *dev);
-static void bat_set_msglevel(struct net_device *dev, u32 value);
-static u32 bat_get_link(struct net_device *dev);
-static void bat_get_strings(struct net_device *dev, u32 stringset, u8 *data);
-static void bat_get_ethtool_stats(struct net_device *dev,
-				  struct ethtool_stats *stats, u64 *data);
-static int bat_get_sset_count(struct net_device *dev, int stringset);
+static int batadv_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
+static void batadv_get_drvinfo(struct net_device *dev,
+			       struct ethtool_drvinfo *info);
+static u32 batadv_get_msglevel(struct net_device *dev);
+static void batadv_set_msglevel(struct net_device *dev, u32 value);
+static u32 batadv_get_link(struct net_device *dev);
+static void batadv_get_strings(struct net_device *dev, u32 stringset, u8 *data);
+static void batadv_get_ethtool_stats(struct net_device *dev,
+				     struct ethtool_stats *stats, u64 *data);
+static int batadv_get_sset_count(struct net_device *dev, int stringset);
 
-static const struct ethtool_ops bat_ethtool_ops = {
-	.get_settings = bat_get_settings,
-	.get_drvinfo = bat_get_drvinfo,
-	.get_msglevel = bat_get_msglevel,
-	.set_msglevel = bat_set_msglevel,
-	.get_link = bat_get_link,
-	.get_strings = bat_get_strings,
-	.get_ethtool_stats = bat_get_ethtool_stats,
-	.get_sset_count = bat_get_sset_count,
+static const struct ethtool_ops batadv_ethtool_ops = {
+	.get_settings = batadv_get_settings,
+	.get_drvinfo = batadv_get_drvinfo,
+	.get_msglevel = batadv_get_msglevel,
+	.set_msglevel = batadv_set_msglevel,
+	.get_link = batadv_get_link,
+	.get_strings = batadv_get_strings,
+	.get_ethtool_stats = batadv_get_ethtool_stats,
+	.get_sset_count = batadv_get_sset_count,
 };
 
 int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
@@ -79,25 +79,25 @@ int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
 	return 0;
 }
 
-static int interface_open(struct net_device *dev)
+static int batadv_interface_open(struct net_device *dev)
 {
 	netif_start_queue(dev);
 	return 0;
 }
 
-static int interface_release(struct net_device *dev)
+static int batadv_interface_release(struct net_device *dev)
 {
 	netif_stop_queue(dev);
 	return 0;
 }
 
-static struct net_device_stats *interface_stats(struct net_device *dev)
+static struct net_device_stats *batadv_interface_stats(struct net_device *dev)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
 	return &bat_priv->stats;
 }
 
-static int interface_set_mac_addr(struct net_device *dev, void *p)
+static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
 	struct sockaddr *addr = p;
@@ -117,7 +117,7 @@ static int interface_set_mac_addr(struct net_device *dev, void *p)
 	return 0;
 }
 
-static int interface_change_mtu(struct net_device *dev, int new_mtu)
+static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 {
 	/* check ranges */
 	if ((new_mtu < 68) || (new_mtu > batadv_hardif_min_mtu(dev)))
@@ -128,7 +128,8 @@ static int interface_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
+static int batadv_interface_tx(struct sk_buff *skb,
+			       struct net_device *soft_iface)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
@@ -336,23 +337,23 @@ out:
 	return;
 }
 
-static const struct net_device_ops bat_netdev_ops = {
-	.ndo_open = interface_open,
-	.ndo_stop = interface_release,
-	.ndo_get_stats = interface_stats,
-	.ndo_set_mac_address = interface_set_mac_addr,
-	.ndo_change_mtu = interface_change_mtu,
-	.ndo_start_xmit = interface_tx,
+static const struct net_device_ops batadv_netdev_ops = {
+	.ndo_open = batadv_interface_open,
+	.ndo_stop = batadv_interface_release,
+	.ndo_get_stats = batadv_interface_stats,
+	.ndo_set_mac_address = batadv_interface_set_mac_addr,
+	.ndo_change_mtu = batadv_interface_change_mtu,
+	.ndo_start_xmit = batadv_interface_tx,
 	.ndo_validate_addr = eth_validate_addr
 };
 
-static void interface_setup(struct net_device *dev)
+static void batadv_interface_setup(struct net_device *dev)
 {
 	struct bat_priv *priv = netdev_priv(dev);
 
 	ether_setup(dev);
 
-	dev->netdev_ops = &bat_netdev_ops;
+	dev->netdev_ops = &batadv_netdev_ops;
 	dev->destructor = free_netdev;
 	dev->tx_queue_len = 0;
 
@@ -366,7 +367,7 @@ static void interface_setup(struct net_device *dev)
 	/* generate random address */
 	eth_hw_addr_random(dev);
 
-	SET_ETHTOOL_OPS(dev, &bat_ethtool_ops);
+	SET_ETHTOOL_OPS(dev, &batadv_ethtool_ops);
 
 	memset(priv, 0, sizeof(*priv));
 }
@@ -377,7 +378,8 @@ struct net_device *batadv_softif_create(const char *name)
 	struct bat_priv *bat_priv;
 	int ret;
 
-	soft_iface = alloc_netdev(sizeof(*bat_priv), name, interface_setup);
+	soft_iface = alloc_netdev(sizeof(*bat_priv), name,
+				  batadv_interface_setup);
 
 	if (!soft_iface)
 		goto out;
@@ -471,14 +473,14 @@ void batadv_softif_destroy(struct net_device *soft_iface)
 
 int batadv_softif_is_valid(const struct net_device *net_dev)
 {
-	if (net_dev->netdev_ops->ndo_start_xmit == interface_tx)
+	if (net_dev->netdev_ops->ndo_start_xmit == batadv_interface_tx)
 		return 1;
 
 	return 0;
 }
 
 /* ethtool */
-static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+static int batadv_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	cmd->supported = 0;
 	cmd->advertising = 0;
@@ -494,8 +496,8 @@ static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 	return 0;
 }
 
-static void bat_get_drvinfo(struct net_device *dev,
-			    struct ethtool_drvinfo *info)
+static void batadv_get_drvinfo(struct net_device *dev,
+			       struct ethtool_drvinfo *info)
 {
 	strcpy(info->driver, "B.A.T.M.A.N. advanced");
 	strcpy(info->version, SOURCE_VERSION);
@@ -503,16 +505,16 @@ static void bat_get_drvinfo(struct net_device *dev,
 	strcpy(info->bus_info, "batman");
 }
 
-static u32 bat_get_msglevel(struct net_device *dev)
+static u32 batadv_get_msglevel(struct net_device *dev)
 {
 	return -EOPNOTSUPP;
 }
 
-static void bat_set_msglevel(struct net_device *dev, u32 value)
+static void batadv_set_msglevel(struct net_device *dev, u32 value)
 {
 }
 
-static u32 bat_get_link(struct net_device *dev)
+static u32 batadv_get_link(struct net_device *dev)
 {
 	return 1;
 }
@@ -523,7 +525,7 @@ static u32 bat_get_link(struct net_device *dev)
  */
 static const struct {
 	const char name[ETH_GSTRING_LEN];
-} bat_counters_strings[] = {
+} batadv_counters_strings[] = {
 	{ "forward" },
 	{ "forward_bytes" },
 	{ "mgmt_tx" },
@@ -544,16 +546,17 @@ static const struct {
 #endif
 };
 
-static void bat_get_strings(struct net_device *dev, uint32_t stringset,
-			    uint8_t *data)
+static void batadv_get_strings(struct net_device *dev, uint32_t stringset,
+			       uint8_t *data)
 {
 	if (stringset == ETH_SS_STATS)
-		memcpy(data, bat_counters_strings,
-		       sizeof(bat_counters_strings));
+		memcpy(data, batadv_counters_strings,
+		       sizeof(batadv_counters_strings));
 }
 
-static void bat_get_ethtool_stats(struct net_device *dev,
-				  struct ethtool_stats *stats, uint64_t *data)
+static void batadv_get_ethtool_stats(struct net_device *dev,
+				     struct ethtool_stats *stats,
+				     uint64_t *data)
 {
 	struct bat_priv *bat_priv = netdev_priv(dev);
 	int i;
@@ -562,7 +565,7 @@ static void bat_get_ethtool_stats(struct net_device *dev,
 		data[i] = batadv_sum_counter(bat_priv, i);
 }
 
-static int bat_get_sset_count(struct net_device *dev, int stringset)
+static int batadv_get_sset_count(struct net_device *dev, int stringset)
 {
 	if (stringset == ETH_SS_STATS)
 		return BAT_CNT_NUM;
-- 
1.7.10

