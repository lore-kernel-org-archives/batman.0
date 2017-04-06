Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu,  6 Apr 2017 16:07:41 +0200
Message-Id: <20170406140741.30745-20-sw@simonwunderlich.de>
In-Reply-To: <20170406140741.30745-1-sw@simonwunderlich.de>
References: <20170406140741.30745-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 19/19] batman-adv: Use net_device_stats from
	struct net_device
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>, b.a.t.m.a.n@lists.open-mesh.org

From: Tobias Klauser <tklauser@distanz.ch>

Instead of using a private copy of struct net_device_stats in struct
batadv_priv, use stats from struct net_device.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 9 +++++----
 net/batman-adv/soft-interface.c        | 2 +-
 net/batman-adv/types.h                 | 2 --
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 0608fcf99e7b..013e970eff39 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1003,6 +1003,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	bool ret = false;
 	struct batadv_dat_entry *dat_entry = NULL;
 	struct sk_buff *skb_new;
+	struct net_device *soft_iface = bat_priv->soft_iface;
 	int hdr_size = 0;
 	unsigned short vid;
 
@@ -1061,10 +1062,10 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		if (!skb_new)
 			goto out;
 
-		skb_new->protocol = eth_type_trans(skb_new,
-						   bat_priv->soft_iface);
-		bat_priv->stats.rx_packets++;
-		bat_priv->stats.rx_bytes += skb->len + ETH_HLEN + hdr_size;
+		skb_new->protocol = eth_type_trans(skb_new, soft_iface);
+
+		soft_iface->stats.rx_packets++;
+		soft_iface->stats.rx_bytes += skb->len + ETH_HLEN + hdr_size;
 
 		netif_rx(skb_new);
 		batadv_dbg(BATADV_DBG_DAT, bat_priv, "ARP request replied locally\n");
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index f33bee08bd99..b223d3cacbae 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -118,7 +118,7 @@ static u64 batadv_sum_counter(struct batadv_priv *bat_priv,  size_t idx)
 static struct net_device_stats *batadv_interface_stats(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
-	struct net_device_stats *stats = &bat_priv->stats;
+	struct net_device_stats *stats = &dev->stats;
 
 	stats->tx_packets = batadv_sum_counter(bat_priv, BATADV_CNT_TX);
 	stats->tx_bytes = batadv_sum_counter(bat_priv, BATADV_CNT_TX_BYTES);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 74b5af7dcd86..76873bf39d75 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1000,7 +1000,6 @@ struct batadv_priv_bat_v {
  * struct batadv_priv - per mesh interface data
  * @mesh_state: current status of the mesh (inactive/active/deactivating)
  * @soft_iface: net device which holds this struct as private data
- * @stats: structure holding the data for the ndo_get_stats() call
  * @bat_counters: mesh internal traffic statistic counters (see batadv_counters)
  * @aggregated_ogms: bool indicating whether OGM aggregation is enabled
  * @bonding: bool indicating whether traffic bonding is enabled
@@ -1055,7 +1054,6 @@ struct batadv_priv_bat_v {
 struct batadv_priv {
 	atomic_t mesh_state;
 	struct net_device *soft_iface;
-	struct net_device_stats stats;
 	u64 __percpu *bat_counters; /* Per cpu counters */
 	atomic_t aggregated_ogms;
 	atomic_t bonding;
-- 
2.11.0

