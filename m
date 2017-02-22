Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 22 Feb 2017 17:16:39 +0100
Message-Id: <20170222161642.22899-1-sven@narfation.org>
In-Reply-To: <82659786.7iirk8N2EY@bentobox>
References: <82659786.7iirk8N2EY@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v2 1/4] batman-adv: Remove preprocessor
	checks in multicast.c
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

It is not necessary to disable these code sections in case other kernel
features are disabled. Instead the IS_ENABLED tests can be added directly
in the code and the compiler can remove the unnecessary code parts during
its optimization run.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - rebased patch on master

 net/batman-adv/multicast.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 952ba81..0e9112c 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -182,10 +182,8 @@ static void batadv_mcast_mla_br_addr_cpy(char *dst, const struct br_ip *src)
 {
 	if (src->proto == htons(ETH_P_IP))
 		ip_eth_mc_map(src->u.ip4, dst);
-#if IS_ENABLED(CONFIG_IPV6)
-	else if (src->proto == htons(ETH_P_IPV6))
+	else if (IS_ENABLED(CONFIG_IPV6) && src->proto == htons(ETH_P_IPV6))
 		ipv6_eth_mc_map(&src->u.ip6, dst);
-#endif
 	else
 		eth_zero_addr(dst);
 }
@@ -494,9 +492,8 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 	if (!bridged)
 		goto update;
 
-#if !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)
-	pr_warn_once("No bridge IGMP snooping compiled - multicast optimizations disabled\n");
-#endif
+	if (!IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING))
+		pr_warn_once("No bridge IGMP snooping compiled - multicast optimizations disabled\n");
 
 	querier4.exists = br_multicast_has_querier_anywhere(dev, ETH_P_IP);
 	querier4.shadowing = br_multicast_has_querier_adjacent(dev, ETH_P_IP);
@@ -671,7 +668,6 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_IPV6)
 /**
  * batadv_mcast_is_report_ipv6 - check for MLD reports
  * @skb: the ethernet frame destined for the mesh
@@ -736,7 +732,6 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 
 	return 0;
 }
-#endif
 
 /**
  * batadv_mcast_forw_mode_check - check for optimized forwarding potential
@@ -765,11 +760,12 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 	case ETH_P_IP:
 		return batadv_mcast_forw_mode_check_ipv4(bat_priv, skb,
 							 is_unsnoopable);
-#if IS_ENABLED(CONFIG_IPV6)
 	case ETH_P_IPV6:
+		if (!IS_ENABLED(CONFIG_IPV6))
+			return -EINVAL;
+
 		return batadv_mcast_forw_mode_check_ipv6(bat_priv, skb,
 							 is_unsnoopable);
-#endif
 	default:
 		return -EINVAL;
 	}
-- 
2.11.0

