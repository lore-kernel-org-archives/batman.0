Return-Path: <omer.efrat@tandemg.com>
From: Omer Efrat <omer.efrat@tandemg.com>
Date: Thu, 14 Jun 2018 13:12:17 +0300
Message-Id: <1528971137-432-1-git-send-email-omer.efrat@tandemg.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [B.A.T.M.A.N.] [PATCH v2 3/5] batman: use BIT_ULL for
 NL80211_STA_INFO_* attribute types
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Omer Efrat <omer.efrat@tandemg.com>

Since 'filled' member in station_info changed to u64, BIT_ULL macro
should be used with NL80211_STA_INFO_* attribute types instead of BIT.

The BIT macro uses unsigned long type which some architectures handle as 32bit
and this results in compilation warnings such as:

net/mac80211/sta_info.c:2223:2: warning: left shift count >= width of type
  sinfo->filled |= BIT(NL80211_STA_INFO_TID_STATS);
  ^

Signed-off-by: Omer Efrat <omer.efrat@tandemg.com>
---
 net/batman-adv/bat_v_elp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 71c20c1..71e6474 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -114,7 +114,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 		}
 		if (ret)
 			goto default_throughput;
-		if (!(sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)))
+		if (!(sinfo.filled & BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT)))
 			goto default_throughput;
 
 		return sinfo.expected_throughput / 100;
-- 
2.7.4

