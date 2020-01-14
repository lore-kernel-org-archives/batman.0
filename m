Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4/7] batman-adv: ELP - use wifi tx bitrate as fallback
 throughput
Date: Tue, 14 Jan 2020 15:23:48 +0100
Message-Id: <20200114142351.26622-5-sw@simonwunderlich.de>
In-Reply-To: <20200114142351.26622-1-sw@simonwunderlich.de>
References: <20200114142351.26622-1-sw@simonwunderlich.de>
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Ren=C3=A9=20Treffer?= <treffer@measite.de>, Marek Lindner <mareklindner@neomailbox.ch>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: René Treffer <treffer@measite.de>

Some wifi drivers (e.g. ath10k) provide per-station rx/tx values but no
estimated throughput. Setting a better estimate than the default 1 MBit
makes these devices work well with B.A.T.M.A.N. V.

Signed-off-by: René Treffer <treffer@measite.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 2614a9caee00..6536e8cc53a0 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -107,10 +107,17 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 		}
 		if (ret)
 			goto default_throughput;
-		if (!(sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)))
-			goto default_throughput;
 
-		return sinfo.expected_throughput / 100;
+		if (sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT))
+			return sinfo.expected_throughput / 100;
+
+		/* try to estimate the expected throughput based on reported tx
+		 * rates
+		 */
+		if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE))
+			return cfg80211_calculate_bitrate(&sinfo.txrate) / 3;
+
+		goto default_throughput;
 	}
 
 	/* if not a wifi interface, check if this device provides data via
-- 
2.20.1

