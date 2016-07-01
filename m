Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  1 Jul 2016 15:09:06 +0200
Message-Id: <1467378549-9646-15-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
References: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 14/17] batman-adv: Always flood IGMP/MLD
	reports
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Linus Lüssing <linus.luessing@c0d3.blue>

With this patch IGMP or MLD reports are always flooded. This is
necessary for the upcoming bridge integration to function without
multicast packet loss.

With the report handling so far bridges might miss interested multicast
listeners, leading to wrongly excluding ports from multicast packet
forwarding.

Currently we are treating IGMP/MLD reports, the messages bridges use to
learn about interested multicast listeners, just as any other multicast
packet: We try to send them to nodes matching its multicast destination.

Unfortunately, the destination address of reports of the older
IGMPv2/MLDv1 protocol families do not strictly adhere to their own
protocol: More precisely, the interested receiver, an IGMPv2 or MLDv1
querier, itself usually does not listen to the multicast destination
address of any reports.

Therefore with this patch we are simply excluding IGMP/MLD reports from
the multicast forwarding code path and keep flooding them. By that
any bridge receives them and can properly learn about listeners.

To avoid compatibility issues with older nodes not yet implementing this
report handling, we need to force them to flood reports: We do this by
bumping the multicast TVLV version to 2, effectively disabling their
multicast optimization.

Tested-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig     |  2 +-
 net/batman-adv/multicast.c | 87 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index f66930e..b7ba97d 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -66,7 +66,7 @@ config BATMAN_ADV_NC
 
 config BATMAN_ADV_MCAST
 	bool "Multicast optimisation"
-	depends on BATMAN_ADV
+	depends on BATMAN_ADV && INET
 	default n
 	help
 	  This option enables the multicast optimisation which aims to
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index c32f24f..4673328 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -25,9 +25,11 @@
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/fs.h>
+#include <linux/icmpv6.h>
 #include <linux/if_ether.h>
-#include <linux/in6.h>
+#include <linux/igmp.h>
 #include <linux/in.h>
+#include <linux/in6.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/kref.h>
@@ -236,7 +238,7 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 	if (batadv_mcast_has_bridge(bat_priv)) {
 		if (bat_priv->mcast.enabled) {
 			batadv_tvlv_container_unregister(bat_priv,
-							 BATADV_TVLV_MCAST, 1);
+							 BATADV_TVLV_MCAST, 2);
 			bat_priv->mcast.enabled = false;
 		}
 
@@ -245,7 +247,7 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 
 	if (!bat_priv->mcast.enabled ||
 	    mcast_data.flags != bat_priv->mcast.flags) {
-		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 1,
+		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 2,
 					       &mcast_data, sizeof(mcast_data));
 		bat_priv->mcast.flags = mcast_data.flags;
 		bat_priv->mcast.enabled = true;
@@ -283,6 +285,31 @@ out:
 }
 
 /**
+ * batadv_mcast_is_report_ipv4 - check for IGMP reports
+ * @skb: the ethernet frame destined for the mesh
+ *
+ * This call might reallocate skb data.
+ *
+ * Checks whether the given frame is a valid IGMP report.
+ *
+ * Return: If so then true, otherwise false.
+ */
+static bool batadv_mcast_is_report_ipv4(struct sk_buff *skb)
+{
+	if (ip_mc_check_igmp(skb, NULL) < 0)
+		return false;
+
+	switch (igmp_hdr(skb)->type) {
+	case IGMP_HOST_MEMBERSHIP_REPORT:
+	case IGMPV2_HOST_MEMBERSHIP_REPORT:
+	case IGMPV3_HOST_MEMBERSHIP_REPORT:
+		return true;
+	}
+
+	return false;
+}
+
+/**
  * batadv_mcast_forw_mode_check_ipv4 - check for optimized forwarding potential
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the IPv4 packet to check
@@ -304,6 +331,9 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
 	if (!pskb_may_pull(skb, sizeof(struct ethhdr) + sizeof(*iphdr)))
 		return -ENOMEM;
 
+	if (batadv_mcast_is_report_ipv4(skb))
+		return -EINVAL;
+
 	iphdr = ip_hdr(skb);
 
 	/* TODO: Implement Multicast Router Discovery (RFC4286),
@@ -320,6 +350,31 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+/**
+ * batadv_mcast_is_report_ipv6 - check for MLD reports
+ * @skb: the ethernet frame destined for the mesh
+ *
+ * This call might reallocate skb data.
+ *
+ * Checks whether the given frame is a valid MLD report.
+ *
+ * Return: If so then true, otherwise false.
+ */
+static bool batadv_mcast_is_report_ipv6(struct sk_buff *skb)
+{
+	if (ipv6_mc_check_mld(skb, NULL) < 0)
+		return false;
+
+	switch (icmp6_hdr(skb)->icmp6_type) {
+	case ICMPV6_MGM_REPORT:
+	case ICMPV6_MLD2_REPORT:
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * batadv_mcast_forw_mode_check_ipv6 - check for optimized forwarding potential
  * @bat_priv: the bat priv with all the soft interface information
@@ -341,6 +396,9 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 	if (!pskb_may_pull(skb, sizeof(struct ethhdr) + sizeof(*ip6hdr)))
 		return -ENOMEM;
 
+	if (batadv_mcast_is_report_ipv6(skb))
+		return -EINVAL;
+
 	ip6hdr = ipv6_hdr(skb);
 
 	/* TODO: Implement Multicast Router Discovery (RFC4286),
@@ -357,6 +415,7 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 
 	return 0;
 }
+#endif
 
 /**
  * batadv_mcast_forw_mode_check - check for optimized forwarding potential
@@ -385,9 +444,11 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 	case ETH_P_IP:
 		return batadv_mcast_forw_mode_check_ipv4(bat_priv, skb,
 							 is_unsnoopable);
+#if IS_ENABLED(CONFIG_IPV6)
 	case ETH_P_IPV6:
 		return batadv_mcast_forw_mode_check_ipv6(bat_priv, skb,
 							 is_unsnoopable);
+#endif
 	default:
 		return -EINVAL;
 	}
@@ -728,18 +789,18 @@ static void batadv_mcast_want_ipv6_update(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_mcast_tvlv_ogm_handler_v1 - process incoming multicast tvlv container
+ * batadv_mcast_tvlv_ogm_handler - process incoming multicast tvlv container
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
  * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flags)
  * @tvlv_value: tvlv buffer containing the multicast data
  * @tvlv_value_len: tvlv buffer length
  */
-static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
-					     struct batadv_orig_node *orig,
-					     u8 flags,
-					     void *tvlv_value,
-					     u16 tvlv_value_len)
+static void batadv_mcast_tvlv_ogm_handler(struct batadv_priv *bat_priv,
+					  struct batadv_orig_node *orig,
+					  u8 flags,
+					  void *tvlv_value,
+					  u16 tvlv_value_len)
 {
 	bool orig_mcast_enabled = !(flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 	u8 mcast_flags = BATADV_NO_FLAGS;
@@ -789,8 +850,8 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
  */
 void batadv_mcast_init(struct batadv_priv *bat_priv)
 {
-	batadv_tvlv_handler_register(bat_priv, batadv_mcast_tvlv_ogm_handler_v1,
-				     NULL, BATADV_TVLV_MCAST, 1,
+	batadv_tvlv_handler_register(bat_priv, batadv_mcast_tvlv_ogm_handler,
+				     NULL, BATADV_TVLV_MCAST, 2,
 				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
 }
 
@@ -800,8 +861,8 @@ void batadv_mcast_init(struct batadv_priv *bat_priv)
  */
 void batadv_mcast_free(struct batadv_priv *bat_priv)
 {
-	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
-	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
+	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
+	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
 
 	spin_lock_bh(&bat_priv->tt.commit_lock);
 	batadv_mcast_mla_tt_retract(bat_priv, NULL);
-- 
2.8.1

