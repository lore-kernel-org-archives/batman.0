Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 30 Mar 2014 22:35:02 +0200
Message-Id: <1396211704-4677-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
References: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFCv2 4/6] mac80211: minstrel - implement
	get_expected_throughput() API
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
Cc: devel@lists.open80211s.org, Felix Fietkau <nbd@openwrt.org>, b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Cc: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 net/mac80211/rc80211_minstrel.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/mac80211/rc80211_minstrel.c b/net/mac80211/rc80211_minstrel.c
index 26fd94f..9434435d 100644
--- a/net/mac80211/rc80211_minstrel.c
+++ b/net/mac80211/rc80211_minstrel.c
@@ -657,6 +657,20 @@ minstrel_free(void *priv)
 	kfree(priv);
 }
 
+static u32
+minstrel_get_expected_throughput(void *priv, void *priv_sta,
+				 struct ieee80211_supported_band *sband)
+{
+	struct minstrel_sta_info *mi = priv_sta;
+	int idx = mi->max_tp_rate[0];
+	u32 bitrate, ret;
+
+	bitrate = sband->bitrates[mi->r[idx].rix].bitrate;
+	ret = bitrate * MINSTREL_TRUNC(mi->r[idx].probability * 1000) / 1000;
+
+	return ret;
+}
+
 const struct rate_control_ops mac80211_minstrel = {
 	.name = "minstrel",
 	.tx_status = minstrel_tx_status,
@@ -670,6 +684,7 @@ const struct rate_control_ops mac80211_minstrel = {
 	.add_sta_debugfs = minstrel_add_sta_debugfs,
 	.remove_sta_debugfs = minstrel_remove_sta_debugfs,
 #endif
+	.get_expected_throughput = minstrel_get_expected_throughput,
 };
 
 int __init
-- 
1.8.3.2

