Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 17 May 2014 17:05:28 +0200
Message-Id: <1400339131-15636-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1400339131-15636-1-git-send-email-antonio@meshcoding.com>
References: <1400339060-13544-1-git-send-email-antonio@meshcoding.com>
 <1400339131-15636-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 3/6] mac80211: minstrel - implement
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
Cc: devel@lists.open80211s.org, Felix Fietkau <nbd@openwrt.org>, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Cc: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 net/mac80211/rc80211_minstrel.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mac80211/rc80211_minstrel.c b/net/mac80211/rc80211_minstrel.c
index 26fd94f..ce61ec9 100644
--- a/net/mac80211/rc80211_minstrel.c
+++ b/net/mac80211/rc80211_minstrel.c
@@ -657,6 +657,17 @@ minstrel_free(void *priv)
 	kfree(priv);
 }
 
+static u32 minstrel_get_expected_throughput(void *priv_sta)
+{
+	struct minstrel_sta_info *mi = priv_sta;
+	int idx = mi->max_tp_rate[0];
+
+	/* convert pkt per sec in kbps (1200 is the average pkt size used for
+	 * computing cur_tp
+	 */
+	return MINSTREL_TRUNC(mi->r[idx].cur_tp) * 1200 / (8 * 1024);
+}
+
 const struct rate_control_ops mac80211_minstrel = {
 	.name = "minstrel",
 	.tx_status = minstrel_tx_status,
@@ -670,6 +681,7 @@ const struct rate_control_ops mac80211_minstrel = {
 	.add_sta_debugfs = minstrel_add_sta_debugfs,
 	.remove_sta_debugfs = minstrel_remove_sta_debugfs,
 #endif
+	.get_expected_throughput = minstrel_get_expected_throughput,
 };
 
 int __init
-- 
1.8.5.5

