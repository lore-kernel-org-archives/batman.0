Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu,  6 Apr 2017 16:07:37 +0200
Message-Id: <20170406140741.30745-16-sw@simonwunderlich.de>
In-Reply-To: <20170406140741.30745-1-sw@simonwunderlich.de>
References: <20170406140741.30745-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 15/19] batman-adv: Use ethtool helper to get
	link status
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

The ethtool_ops of batman-adv never contained more than a stub for the
get_link function pointer. It was always returning that a link exists even
when the devices was not yet up and therefore nothing resampling a link
could have been available.

Instead use the ethtool helper which returns the current carrier state.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/soft-interface.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index a9dbcc1590bd..eff23d519c6f 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -69,7 +69,6 @@ static void batadv_get_drvinfo(struct net_device *dev,
 			       struct ethtool_drvinfo *info);
 static u32 batadv_get_msglevel(struct net_device *dev);
 static void batadv_set_msglevel(struct net_device *dev, u32 value);
-static u32 batadv_get_link(struct net_device *dev);
 static void batadv_get_strings(struct net_device *dev, u32 stringset, u8 *data);
 static void batadv_get_ethtool_stats(struct net_device *dev,
 				     struct ethtool_stats *stats, u64 *data);
@@ -80,7 +79,7 @@ static const struct ethtool_ops batadv_ethtool_ops = {
 	.get_drvinfo = batadv_get_drvinfo,
 	.get_msglevel = batadv_get_msglevel,
 	.set_msglevel = batadv_set_msglevel,
-	.get_link = batadv_get_link,
+	.get_link = ethtool_op_get_link,
 	.get_strings = batadv_get_strings,
 	.get_ethtool_stats = batadv_get_ethtool_stats,
 	.get_sset_count = batadv_get_sset_count,
@@ -1119,11 +1118,6 @@ static void batadv_set_msglevel(struct net_device *dev, u32 value)
 {
 }
 
-static u32 batadv_get_link(struct net_device *dev)
-{
-	return 1;
-}
-
 /* Inspired by drivers/net/ethernet/dlink/sundance.c:1702
  * Declare each description string in struct.name[] to get fixed sized buffer
  * and compile time checking for strings longer than ETH_GSTRING_LEN.
-- 
2.11.0

