Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  1 Apr 2017 14:47:04 +0200
Message-Id: <20170401124706.18257-3-sven@narfation.org>
In-Reply-To: <20170401124706.18257-1-sven@narfation.org>
References: <20170401124706.18257-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Remove ethtool msglevel
	functions
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

batadv devices don't support msglevel. The ethtool stubs therefore returned
that it isn't supported. But instead, the complete function can be dropped
to avoid that bogus values are shown in ethtool.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 583fcfca..4e888c5e 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -67,8 +67,6 @@
 static int batadv_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);
 static void batadv_get_drvinfo(struct net_device *dev,
 			       struct ethtool_drvinfo *info);
-static u32 batadv_get_msglevel(struct net_device *dev);
-static void batadv_set_msglevel(struct net_device *dev, u32 value);
 static void batadv_get_strings(struct net_device *dev, u32 stringset, u8 *data);
 static void batadv_get_ethtool_stats(struct net_device *dev,
 				     struct ethtool_stats *stats, u64 *data);
@@ -77,8 +75,6 @@ static int batadv_get_sset_count(struct net_device *dev, int stringset);
 static const struct ethtool_ops batadv_ethtool_ops = {
 	.get_settings = batadv_get_settings,
 	.get_drvinfo = batadv_get_drvinfo,
-	.get_msglevel = batadv_get_msglevel,
-	.set_msglevel = batadv_set_msglevel,
 	.get_link = ethtool_op_get_link,
 	.get_strings = batadv_get_strings,
 	.get_ethtool_stats = batadv_get_ethtool_stats,
@@ -1108,15 +1104,6 @@ static void batadv_get_drvinfo(struct net_device *dev,
 	strlcpy(info->bus_info, "batman", sizeof(info->bus_info));
 }
 
-static u32 batadv_get_msglevel(struct net_device *dev)
-{
-	return -EOPNOTSUPP;
-}
-
-static void batadv_set_msglevel(struct net_device *dev, u32 value)
-{
-}
-
 /* Inspired by drivers/net/ethernet/dlink/sundance.c:1702
  * Declare each description string in struct.name[] to get fixed sized buffer
  * and compile time checking for strings longer than ETH_GSTRING_LEN.
-- 
2.11.0

