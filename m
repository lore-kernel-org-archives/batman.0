Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 17 May 2014 17:05:27 +0200
Message-Id: <1400339131-15636-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1400339131-15636-1-git-send-email-antonio@meshcoding.com>
References: <1400339060-13544-1-git-send-email-antonio@meshcoding.com>
 <1400339131-15636-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/6] mac80211: export the expected
	throughput
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
Cc: devel@lists.open80211s.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Add get_expected_throughput() API to mac80211 so that each
driver can implement its own version based on the RC
algorithm they are using (might be using an HW RC algo).
The API returns a value expressed in Kbps.

Also, add the new get_expected_throughput() member
to the rate_control_ops structure in order to be
able to query the RC algorithm.

The related member in the station_info object is now
filled when dumping a station.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 include/net/mac80211.h    |  7 +++++++
 net/mac80211/cfg.c        | 19 +++++++++++++++++++
 net/mac80211/driver-ops.h | 13 +++++++++++++
 net/mac80211/trace.h      | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 982d2cd..81efbc7 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2769,6 +2769,10 @@ enum ieee80211_roc_type {
  *	information in bss_conf is set up and the beacon can be retrieved. A
  *	channel context is bound before this is called.
  * @leave_ibss: Leave the IBSS again.
+ *
+ * @get_expected_throughput: extract the expected throughput towards the
+ *	specified station. The returned value is expressed in Kbps. It returns 0
+ *	if the RC algorithm does not have proper data to provide.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -2962,6 +2966,7 @@ struct ieee80211_ops {
 
 	int (*join_ibss)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 	void (*leave_ibss)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
+	u32 (*get_expected_throughput)(struct ieee80211_sta *sta);
 };
 
 /**
@@ -4534,6 +4539,8 @@ struct rate_control_ops {
 	void (*add_sta_debugfs)(void *priv, void *priv_sta,
 				struct dentry *dir);
 	void (*remove_sta_debugfs)(void *priv, void *priv_sta);
+
+	u32 (*get_expected_throughput)(void *priv_sta);
 };
 
 static inline int rate_supported(struct ieee80211_sta *sta,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index bfd2534..d739409 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -472,8 +472,12 @@ static void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
+	struct rate_control_ref *ref = local->rate_ctrl;
+	struct ieee80211_supported_band *sband;
+	enum ieee80211_band band;
 	struct timespec uptime;
 	u64 packets = 0;
+	u32 thr = 0;
 	int i, ac;
 
 	sinfo->generation = sdata->local->sta_generation;
@@ -587,6 +591,21 @@ static void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo)
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_ASSOCIATED);
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER))
 		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_TDLS_PEER);
+
+	/* check if the driver has a SW RC implementation */
+	if (ref && ref->ops->get_expected_throughput) {
+		band = ieee80211_get_sdata_band(sta->sdata);
+		sband = sta->local->hw.wiphy->bands[band];
+
+		thr = ref->ops->get_expected_throughput(sta->rate_ctrl_priv);
+	} else {
+		thr = drv_get_expected_throughput(local, &sta->sta);
+	}
+
+	if (thr != 0) {
+		sinfo->filled |= STATION_INFO_EXPECTED_THROUGHPUT;
+		sinfo->expected_throughput = thr;
+	}
 }
 
 static const char ieee80211_gstrings_sta_stats[][ETH_GSTRING_LEN] = {
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index df1d502..696ef78 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1156,4 +1156,17 @@ static inline void drv_leave_ibss(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline u32 drv_get_expected_throughput(struct ieee80211_local *local,
+					      struct ieee80211_sta *sta)
+{
+	u32 ret = 0;
+
+	trace_drv_get_expected_throughput(sta);
+	if (local->ops->get_expected_throughput)
+		ret = local->ops->get_expected_throughput(sta);
+	trace_drv_return_u32(local, ret);
+
+	return ret;
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index a0b0aea..942f64b 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -184,6 +184,20 @@ TRACE_EVENT(drv_return_bool,
 		  "true" : "false")
 );
 
+TRACE_EVENT(drv_return_u32,
+	TP_PROTO(struct ieee80211_local *local, u32 ret),
+	TP_ARGS(local, ret),
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		__field(u32, ret)
+	),
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		__entry->ret = ret;
+	),
+	TP_printk(LOCAL_PR_FMT " - %u", LOCAL_PR_ARG, __entry->ret)
+);
+
 TRACE_EVENT(drv_return_u64,
 	TP_PROTO(struct ieee80211_local *local, u64 ret),
 	TP_ARGS(local, ret),
@@ -1499,6 +1513,24 @@ DEFINE_EVENT(local_sdata_evt, drv_leave_ibss,
 	TP_ARGS(local, sdata)
 );
 
+TRACE_EVENT(drv_get_expected_throughput,
+	TP_PROTO(struct ieee80211_sta *sta),
+
+	TP_ARGS(sta),
+
+	TP_STRUCT__entry(
+		STA_ENTRY
+	),
+
+	TP_fast_assign(
+		STA_ASSIGN;
+	),
+
+	TP_printk(
+		STA_PR_FMT, STA_PR_ARG
+	)
+);
+
 /*
  * Tracing for API calls that drivers call.
  */
-- 
1.8.5.5

