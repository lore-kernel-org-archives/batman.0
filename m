Return-Path: <treffer@measite.de>
From: =?UTF-8?q?Ren=C3=A9=20Treffer?= <treffer@measite.de>
Subject: [PATCH] batman-adv: Use wifi rx/tx as fallback throughput
Date: Sun,  9 Jun 2019 12:19:22 +0200
Message-Id: <20190609101922.2366-1-treffer@measite.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: rtreffer <treffer@measite.de>

Some wifi drivers (e.g. ath10k) provide per-station rx/tx values but no
estimated throughput. Setting a better estimate than the default 1MBit
makes these devices work well with BATMAN V.

Signed-off-by: René Treffer <treffer@measite.de>
---
 net/batman-adv/bat_v_elp.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 2614a9ca..ce3b52f1 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -68,7 +68,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	struct ethtool_link_ksettings link_settings;
 	struct net_device *real_netdev;
 	struct station_info sinfo;
-	u32 throughput;
+	u32 throughput, rx, tx;
 	int ret;
 
 	/* if the user specified a customised value for this interface, then
@@ -107,10 +107,25 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 		}
 		if (ret)
 			goto default_throughput;
-		if (!(sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)))
-			goto default_throughput;
 
-		return sinfo.expected_throughput / 100;
+		if (sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)) {
+			return sinfo.expected_throughput / 100;
+		}
+
+		// try to estimate en expected throughput based on reported rx/tx rates
+		// 1/3 of tx or 1/3 of the average of rx and tx, whichever is smaller
+		if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE)) {
+			tx = cfg80211_calculate_bitrate(&sinfo.txrate);
+			if (sinfo.filled & BIT(NL80211_STA_INFO_RX_BITRATE)) {
+				rx = cfg80211_calculate_bitrate(&sinfo.rxrate);
+				if (rx < tx) {
+					return (rx + tx) / 6;
+				}
+			}
+			return tx / 3;
+		}
+
+		goto default_throughput;
 	}
 
 	/* if not a wifi interface, check if this device provides data via
-- 
2.20.1

