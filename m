Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  9 Jun 2017 15:02:55 +0200
Message-Id: <20170609130255.8577-2-sven@narfation.org>
In-Reply-To: <20170609130255.8577-1-sven@narfation.org>
References: <20170609130255.8577-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Accept only filled wifi
 station info
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

The wifi driver can decide to not provide parts of the station info. For
example, the expected throughput of the station can be omitted when the
used rate control doesn't provide this kind of information.

The B.A.T.M.A.N. V implementation must therefore check the filled bitfield
before it tries to access the expected_throughput of the returned
station_info.

Reported-by: Alvaro Antelo <alvaro.antelo@gmail.com>
Fixes: 5c3245172c01 ("batman-adv: ELP - compute the metric based on the estimated throughput")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/net/cfg80211.h | 2 ++
 net/batman-adv/bat_v_elp.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/compat-include/net/cfg80211.h b/compat-include/net/cfg80211.h
index 6e0eca3c..f65fa756 100644
--- a/compat-include/net/cfg80211.h
+++ b/compat-include/net/cfg80211.h
@@ -20,6 +20,8 @@ static inline int cfg80211_get_station(struct net_device *dev,
  */
 #define expected_throughput filled
 
+#define STATION_INFO_EXPECTED_THROUGHPUT    BIT(28)
+
 #endif /* < KERNEL_VERSION(3, 16, 0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 8, 0)
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 96e73337..16552568 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -111,6 +111,8 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 		}
 		if (ret)
 			goto default_throughput;
+		if (!(sinfo.filled & STATION_INFO_EXPECTED_THROUGHPUT))
+			goto default_throughput;
 
 		return sinfo.expected_throughput / 100;
 	}
-- 
2.11.0

