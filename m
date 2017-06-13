Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 13 Jun 2017 13:36:59 +0200
Message-Id: <20170613113700.31220-10-sw@simonwunderlich.de>
In-Reply-To: <20170613113700.31220-1-sw@simonwunderlich.de>
References: <20170613113700.31220-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 09/10] batman-adv: Use default throughput
 value on cfg80211 error
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

A wifi interface should never be handled like an ethernet devices. The
parser of the cfg80211 output must therefore skip the ethtool code when
cfg80211_get_station returned an error.

Fixes: f44a3ae9a281 ("batman-adv: refactor wifi interface detection")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Reviewed-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index b90c9903e246..96e7333764f0 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -109,8 +109,10 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			 */
 			return 0;
 		}
-		if (!ret)
-			return sinfo.expected_throughput / 100;
+		if (ret)
+			goto default_throughput;
+
+		return sinfo.expected_throughput / 100;
 	}
 
 	/* if not a wifi interface, check if this device provides data via
-- 
2.11.0

