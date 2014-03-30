Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 30 Mar 2014 22:35:03 +0200
Message-Id: <1396211704-4677-6-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
References: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFCv2 5/6] mac80211: minstrel_ht - implement
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
 net/mac80211/rc80211_minstrel_ht.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index bccaf85..480f657 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1031,6 +1031,24 @@ minstrel_ht_free(void *priv)
 	mac80211_minstrel.free(priv);
 }
 
+static u32
+minstrel_ht_get_expected_throughput(void *priv, void *priv_sta,
+				    struct ieee80211_supported_band *sband)
+{
+	struct minstrel_ht_sta_priv *msp = priv_sta;
+	struct minstrel_ht_sta *mi = &msp->ht;
+	int i, j;
+
+	if (!msp->is_ht)
+		return mac80211_minstrel.get_expected_throughput(priv, priv_sta,
+								 sband);
+
+	i = mi->max_tp_rate / MCS_GROUP_RATES;
+	j = mi->max_tp_rate % MCS_GROUP_RATES;
+
+	return mi->groups[i].rates[j].cur_tp;
+}
+
 static const struct rate_control_ops mac80211_minstrel_ht = {
 	.name = "minstrel_ht",
 	.tx_status = minstrel_ht_tx_status,
@@ -1045,6 +1063,7 @@ static const struct rate_control_ops mac80211_minstrel_ht = {
 	.add_sta_debugfs = minstrel_ht_add_sta_debugfs,
 	.remove_sta_debugfs = minstrel_ht_remove_sta_debugfs,
 #endif
+	.get_expected_throughput = minstrel_ht_get_expected_throughput,
 };
 
 
-- 
1.8.3.2

