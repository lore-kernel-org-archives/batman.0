Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [RFC] batman-adv: ELP - use wifi tx bitrate as fallback throughput
Date: Sun, 11 Aug 2019 21:07:05 +0800
Message-Id: <20190811130705.4544-1-mareklindner@neomailbox.ch>
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
Cc: =?UTF-8?q?Ren=C3=A9=20Treffer?= <treffer@measite.de>, Marek Lindner <mareklindner@neomailbox.ch>

From: René Treffer <treffer@measite.de>

Some wifi drivers (e.g. ath10k) provide per-station rx/tx values but no
estimated throughput. Setting a better estimate than the default 1 MBit
makes these devices work well with B.A.T.M.A.N. V.

Signed-off-by: René Treffer <treffer@measite.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/bat_v_elp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 2614a9ca..1e852d4b 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -107,10 +107,15 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 		}
 		if (ret)
 			goto default_throughput;
-		if (!(sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)))
-			goto default_throughput;
 
-		return sinfo.expected_throughput / 100;
+		if (sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT))
+			return sinfo.expected_throughput / 100;
+
+		/* try to estimate en expected throughput based on reported tx rates */
+		if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE))
+			return cfg80211_calculate_bitrate(&sinfo.txrate) / 3;
+
+		goto default_throughput;
 	}
 
 	/* if not a wifi interface, check if this device provides data via
-- 
2.20.1

