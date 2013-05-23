Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 24 May 2013 02:18:16 +0800
Message-Id: <1369333096-15869-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: consider network coding overhead
	when calculating required mtu
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

The module prints a warning when the MTU on the hard interface is too
small to transfer payload traffic without fragmentation. The required
MTU is calculated based on the encapsulation header size. If network
coding is compild into the module its header size is taken into
account as well.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 hard-interface.c |   19 ++++++++++---------
 main.c           |   25 +++++++++++++++++++++++++
 main.h           |    1 +
 soft-interface.c |    2 +-
 types.h          |    7 -------
 5 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index c343aa8..ca50dd4 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -269,9 +269,10 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 	const struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	const struct batadv_hard_iface *hard_iface;
 	/* allow big frames if all devices are capable to do so
-	 * (have MTU > 1500 + BAT_HEADER_LEN)
+	 * (have MTU > 1500 + batadv_max_header_len())
 	 */
 	int min_mtu = ETH_DATA_LEN;
+	int max_header_len = batadv_max_header_len();
 
 	if (atomic_read(&bat_priv->fragmentation))
 		goto out;
@@ -285,8 +286,7 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 		if (hard_iface->soft_iface != soft_iface)
 			continue;
 
-		min_mtu = min_t(int,
-				hard_iface->net_dev->mtu - BATADV_HEADER_LEN,
+		min_mtu = min_t(int, hard_iface->net_dev->mtu - max_header_len,
 				min_mtu);
 	}
 	rcu_read_unlock();
@@ -380,6 +380,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	struct batadv_priv *bat_priv;
 	struct net_device *soft_iface, *master;
 	__be16 ethertype = __constant_htons(ETH_P_BATMAN);
+	int max_header_len = batadv_max_header_len();
 	int ret;
 
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
@@ -448,18 +449,18 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 		    hard_iface->net_dev->name);
 
 	if (atomic_read(&bat_priv->fragmentation) &&
-	    hard_iface->net_dev->mtu < ETH_DATA_LEN + BATADV_HEADER_LEN)
+	    hard_iface->net_dev->mtu < ETH_DATA_LEN + max_header_len)
 		batadv_info(hard_iface->soft_iface,
-			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to %zi would solve the problem.\n",
+			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to %i would solve the problem.\n",
 			    hard_iface->net_dev->name, hard_iface->net_dev->mtu,
-			    ETH_DATA_LEN + BATADV_HEADER_LEN);
+			    ETH_DATA_LEN + max_header_len);
 
 	if (!atomic_read(&bat_priv->fragmentation) &&
-	    hard_iface->net_dev->mtu < ETH_DATA_LEN + BATADV_HEADER_LEN)
+	    hard_iface->net_dev->mtu < ETH_DATA_LEN + max_header_len)
 		batadv_info(hard_iface->soft_iface,
-			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. If you experience problems getting traffic through try increasing the MTU to %zi.\n",
+			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. If you experience problems getting traffic through try increasing the MTU to %i.\n",
 			    hard_iface->net_dev->name, hard_iface->net_dev->mtu,
-			    ETH_DATA_LEN + BATADV_HEADER_LEN);
+			    ETH_DATA_LEN + max_header_len);
 
 	if (batadv_hardif_is_iface_up(hard_iface))
 		batadv_hardif_activate_interface(hard_iface);
diff --git a/main.c b/main.c
index 7188beb..25520b1 100644
--- a/main.c
+++ b/main.c
@@ -252,6 +252,31 @@ out:
 	return primary_if;
 }
 
+/**
+ * batadv_max_header_len - calculate maximum encapsulation overhead for a
+ *  payload packet
+ *
+ * Return the maximum encapsulation overhead in bytes.
+ */
+int batadv_max_header_len(void)
+{
+	int header_len = 0;
+
+	header_len = max_t(int, header_len,
+			   sizeof(struct batadv_unicast_packet));
+	header_len = max_t(int, header_len,
+			   sizeof(struct batadv_unicast_4addr_packet));
+	header_len = max_t(int, header_len,
+			   sizeof(struct batadv_bcast_packet));
+
+#ifdef CONFIG_BATMAN_ADV_NC
+	header_len = max_t(int, header_len,
+			   sizeof(struct batadv_coded_packet));
+#endif
+
+	return header_len;
+}
+
 static int batadv_recv_unhandled_packet(struct sk_buff *skb,
 					struct batadv_hard_iface *recv_if)
 {
diff --git a/main.h b/main.h
index 3db6c2e..1f0b135 100644
--- a/main.h
+++ b/main.h
@@ -193,6 +193,7 @@ void batadv_mesh_free(struct net_device *soft_iface);
 int batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr);
 struct batadv_hard_iface *
 batadv_seq_print_text_primary_if_get(struct seq_file *seq);
+int batadv_max_header_len(void);
 int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 			   struct packet_type *ptype,
 			   struct net_device *orig_dev);
diff --git a/soft-interface.c b/soft-interface.c
index e157463..991a91f 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -615,7 +615,7 @@ static void batadv_softif_init_early(struct net_device *dev)
 	 */
 	dev->mtu = ETH_DATA_LEN;
 	/* reserve more space in the skbuff for our header */
-	dev->hard_header_len = BATADV_HEADER_LEN;
+	dev->hard_header_len = batadv_max_header_len();
 
 	/* generate random address */
 	eth_hw_addr_random(dev);
diff --git a/types.h b/types.h
index c388e47..18ea0d7 100644
--- a/types.h
+++ b/types.h
@@ -24,13 +24,6 @@
 #include "bitarray.h"
 #include <linux/kernel.h>
 
-/**
- * Maximum overhead for the encapsulation for a payload packet
- */
-#define BATADV_HEADER_LEN \
-	(ETH_HLEN + max(sizeof(struct batadv_unicast_packet), \
-			sizeof(struct batadv_bcast_packet)))
-
 #ifdef CONFIG_BATMAN_ADV_DAT
 
 /* batadv_dat_addr_t is the type used for all DHT addresses. If it is changed,
-- 
1.7.10.4

