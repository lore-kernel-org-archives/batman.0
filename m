Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu,  6 Apr 2017 16:07:39 +0200
Message-Id: <20170406140741.30745-18-sw@simonwunderlich.de>
In-Reply-To: <20170406140741.30745-1-sw@simonwunderlich.de>
References: <20170406140741.30745-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 17/19] batman-adv: Remove ethtool
	.get_settings stub
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

The .get_settings function pointer and the related API was deprecated.
Fortunately, batman-adv is a virtual interface and never provided any
useful information via .get_settings. The stub can therefore be
removed.

This also avoids that incorrect information is shown in ethtool about the
batadv interface.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/soft-interface.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 3e0ee2afb814..6f22b1283c92 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -64,7 +64,6 @@
 #include "sysfs.h"
 #include "translation-table.h"
 
-static int batadv_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
 static void batadv_get_drvinfo(struct net_device *dev,
 			       struct ethtool_drvinfo *info);
 static void batadv_get_strings(struct net_device *dev, u32 stringset, u8 *data);
@@ -73,7 +72,6 @@ static void batadv_get_ethtool_stats(struct net_device *dev,
 static int batadv_get_sset_count(struct net_device *dev, int stringset);
 
 static const struct ethtool_ops batadv_ethtool_ops = {
-	.get_settings = batadv_get_settings,
 	.get_drvinfo = batadv_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_strings = batadv_get_strings,
@@ -1079,23 +1077,6 @@ struct rtnl_link_ops batadv_link_ops __read_mostly = {
 	.dellink	= batadv_softif_destroy_netlink,
 };
 
-/* ethtool */
-static int batadv_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
-{
-	cmd->supported = 0;
-	cmd->advertising = 0;
-	ethtool_cmd_speed_set(cmd, SPEED_10);
-	cmd->duplex = DUPLEX_FULL;
-	cmd->port = PORT_TP;
-	cmd->phy_address = 0;
-	cmd->transceiver = XCVR_INTERNAL;
-	cmd->autoneg = AUTONEG_DISABLE;
-	cmd->maxtxpkt = 0;
-	cmd->maxrxpkt = 0;
-
-	return 0;
-}
-
 static void batadv_get_drvinfo(struct net_device *dev,
 			       struct ethtool_drvinfo *info)
 {
-- 
2.11.0

