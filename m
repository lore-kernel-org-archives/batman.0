Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu,  6 Apr 2017 16:07:24 +0200
Message-Id: <20170406140741.30745-3-sw@simonwunderlich.de>
In-Reply-To: <20170406140741.30745-1-sw@simonwunderlich.de>
References: <20170406140741.30745-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 02/19] batman-adv: Reduce preprocessor checks
	in multicast.c
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

It is not necessary to disable these code sections in case other kernel
features are disabled. Instead the IS_ENABLED tests can be added directly
in the code and the compiler can remove the unnecessary code parts during
its optimization run.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 952ba81a565b..d327670641ac 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -494,9 +494,8 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 	if (!bridged)
 		goto update;
 
-#if !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)
-	pr_warn_once("No bridge IGMP snooping compiled - multicast optimizations disabled\n");
-#endif
+	if (!IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING))
+		pr_warn_once("No bridge IGMP snooping compiled - multicast optimizations disabled\n");
 
 	querier4.exists = br_multicast_has_querier_anywhere(dev, ETH_P_IP);
 	querier4.shadowing = br_multicast_has_querier_adjacent(dev, ETH_P_IP);
@@ -671,7 +670,6 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_IPV6)
 /**
  * batadv_mcast_is_report_ipv6 - check for MLD reports
  * @skb: the ethernet frame destined for the mesh
@@ -736,7 +734,6 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 
 	return 0;
 }
-#endif
 
 /**
  * batadv_mcast_forw_mode_check - check for optimized forwarding potential
@@ -765,11 +762,12 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
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

