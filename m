Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  5 Sep 2016 13:20:25 +0200
Message-Id: <20160905112029.32533-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v7 1/5] batman-adv: prevent multiple ARP
	replies sent by gateways if dat enabled
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

From: Andreas Pape <APape@phoenixcontact.com>

If dat is enabled it must be made sure that only the backbone gw which has
claimed the remote destination for the ARP request answers the ARP request
directly if the MAC address is known due to the local dat table. This
prevents multiple ARP replies in a common backbone if more than one
gateway already knows the remote mac searched for in the ARP request.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
Acked-by: Simon Wunderlich <sw@simonwunderlich.de>
[sven@narfation.org: fix conflicts with current version]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 49 ++++++++++++++++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.h | 11 ++++++++
 net/batman-adv/distributed-arp-table.c | 15 +++++++++++
 3 files changed, 75 insertions(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index e7f690b..41ab4a6 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -2450,3 +2450,52 @@ out:
 
 	return ret;
 }
+
+#ifdef CONFIG_BATMAN_ADV_DAT
+/**
+ * batadv_bla_check_claim - check if address is claimed
+ *
+ * @bat_priv: the bat priv with all the soft interface information
+ * @addr: mac address of which the claim status is checked
+ * @vid: the VLAN ID
+ *
+ * addr is checked if this address is claimed by the local device itself.
+ *
+ * Return: true if bla is disabled or the mac is claimed by the device,
+ * false if the device addr is already claimed by another gateway
+ */
+bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
+			    u8 *addr, unsigned short vid)
+{
+	struct batadv_bla_claim search_claim;
+	struct batadv_bla_claim *claim = NULL;
+	struct batadv_hard_iface *primary_if = NULL;
+	bool ret = true;
+
+	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
+		return ret;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		return ret;
+
+	/* First look if the mac address is claimed */
+	ether_addr_copy(search_claim.addr, addr);
+	search_claim.vid = vid;
+
+	claim = batadv_claim_hash_find(bat_priv, &search_claim);
+
+	/* If there is a claim and we are not owner of the claim,
+	 * return false.
+	 */
+	if (claim) {
+		if (!batadv_compare_eth(claim->backbone_gw->orig,
+					primary_if->net_dev->dev_addr))
+			ret = false;
+		batadv_claim_put(claim);
+	}
+
+	batadv_hardif_put(primary_if);
+	return ret;
+}
+#endif
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 1ae93e4..86b8740 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -51,6 +51,10 @@ void batadv_bla_status_update(struct net_device *net_dev);
 int batadv_bla_init(struct batadv_priv *bat_priv);
 void batadv_bla_free(struct batadv_priv *bat_priv);
 int batadv_bla_claim_dump(struct sk_buff *msg, struct netlink_callback *cb);
+#ifdef CONFIG_BATMAN_ADV_DAT
+bool batadv_bla_check_claim(struct batadv_priv *bat_priv, u8 *addr,
+			    unsigned short vid);
+#endif
 #define BATADV_BLA_CRC_INIT	0
 #else /* ifdef CONFIG_BATMAN_ADV_BLA */
 
@@ -127,6 +131,13 @@ static inline int batadv_bla_backbone_dump(struct sk_buff *msg,
 	return -EOPNOTSUPP;
 }
 
+static inline
+bool batadv_bla_check_claim(struct batadv_priv *bat_priv, u8 *addr,
+			    unsigned short vid)
+{
+	return true;
+}
+
 #endif /* ifdef CONFIG_BATMAN_ADV_BLA */
 
 #endif /* ifndef _NET_BATMAN_ADV_BLA_H_ */
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index e257efd..cf53404 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -43,6 +43,7 @@
 #include <linux/workqueue.h>
 #include <net/arp.h>
 
+#include "bridge_loop_avoidance.h"
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
@@ -1007,6 +1008,20 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 			goto out;
 		}
 
+		/* If BLA is enabled, only send ARP replies if we have claimed
+		 * the destination for the ARP request or if no one else of
+		 * the backbone gws belonging to our backbone has claimed the
+		 * destination.
+		 */
+		if (!batadv_bla_check_claim(bat_priv,
+					    dat_entry->mac_addr, vid)) {
+			batadv_dbg(BATADV_DBG_DAT, bat_priv,
+				   "Device %pM claimed by another backbone gw. Don't send ARP reply!",
+				   dat_entry->mac_addr);
+			ret = true;
+			goto out;
+		}
+
 		skb_new = arp_create(ARPOP_REPLY, ETH_P_ARP, ip_src,
 				     bat_priv->soft_iface, ip_dst, hw_src,
 				     dat_entry->mac_addr, hw_src);
-- 
2.9.3

