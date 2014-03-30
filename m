Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 30 Mar 2014 22:35:01 +0200
Message-Id: <1396211704-4677-4-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
References: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFCv2 3/6] mac80211: export expected throughput in
	set_sta_info()
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: devel@lists.open80211s.org, b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

If the RC algorithm implements the get_expected_throughput()
API fill the related member in the station_info object when
dumping a station.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 net/mac80211/cfg.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index aa39381..0e80e2c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -472,9 +472,13 @@ static void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
+	struct rate_control_ref *ref = local->rate_ctrl;
+	struct ieee80211_supported_band *sband;
+	enum ieee80211_band band;
 	struct timespec uptime;
 	u64 packets = 0;
 	int i, ac;
+	u32 thr;
 
 	sinfo->generation = sdata->local->sta_generation;
 
@@ -587,6 +591,19 @@ static void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo)
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_ASSOCIATED);
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER))
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_TDLS_PEER);
+
+	if (ref->ops->get_expected_throughput) {
+		band = ieee80211_get_sdata_band(sta->sdata);
+		sband = sta->local->hw.wiphy->bands[band];
+
+		thr = ref->ops->get_expected_throughput(ref->priv,
+							sta->rate_ctrl_priv,
+							sband);
+		if (thr != 0) {
+			sinfo->filled |= STATION_INFO_EXPECTED_THROUGHPUT;
+			sinfo->expected_throughput = thr;
+		}
+	}
 }
 
 static const char ieee80211_gstrings_sta_stats[][ETH_GSTRING_LEN] = {
-- 
1.8.3.2

