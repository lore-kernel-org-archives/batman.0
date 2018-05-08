Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed,  9 May 2018 00:41:30 +0800
Message-Id: <20180508164130.8633-7-mareklindner@neomailbox.ch>
In-Reply-To: <20180508164130.8633-1-mareklindner@neomailbox.ch>
References: <20180508164130.8633-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [RFC 6/6] batman-adv: ELP - use tp meter to estimate
 the throughput if otherwise not available
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/bat_v_elp.c | 62 ++++++++++++++++++++++++++++++++++++--
 net/batman-adv/bat_v_elp.h | 19 ++++++++++++
 net/batman-adv/main.h      |  1 +
 net/batman-adv/tp_meter.c  | 25 +++++++++++++--
 net/batman-adv/types.h     |  9 ++++++
 5 files changed, 111 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 28687493..028dc3ab 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -51,6 +51,7 @@
 #include "originator.h"
 #include "routing.h"
 #include "send.h"
+#include "tp_meter.h"
 
 /**
  * batadv_v_elp_start_timer() - restart timer for ELP periodic work
@@ -67,6 +68,41 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 			   msecs_to_jiffies(msecs));
 }
 
+/**
+ * batadv_v_elp_tp_start() - start a tp meter session for a neighbor
+ * @neigh: neighbor to run tp meter on
+ */
+static void batadv_v_elp_tp_start(struct batadv_hardif_neigh_node *neigh)
+{
+	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+
+	neigh->bat_v.tp_meter_running = true;
+	batadv_tp_start(bat_priv, neigh->addr, neigh, 10, NULL, BATADV_TP_ELP);
+}
+
+/**
+ * batadv_v_elp_tp_fail() - handle tp meter session failure
+ * @neigh: neighbor to run tp meter on
+ */
+void batadv_v_elp_tp_fail(struct batadv_hardif_neigh_node *neigh)
+{
+	neigh->bat_v.tp_meter_running = false;
+}
+
+/**
+ * batadv_v_elp_tp_finish() - post-process tp meter results
+ * @neigh: neighbor tp meter on
+ * @throughput: tp meter throughput result
+ */
+void batadv_v_elp_tp_finish(struct batadv_hardif_neigh_node *neigh,
+			    u32 throughput)
+{
+	ewma_throughput_add(&neigh->bat_v.throughput, throughput);
+	neigh->bat_v.last_tp_meter_run = jiffies;
+	neigh->bat_v.tp_meter_running = false;
+}
+
 /**
  * batadv_v_elp_get_throughput() - get the throughput towards a neighbour
  * @neigh: the neighbour for which the throughput has to be obtained
@@ -80,6 +116,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	struct ethtool_link_ksettings link_settings;
 	struct net_device *real_netdev;
 	struct station_info sinfo;
+	u32 last_tp_run_msecs;
 	u32 throughput;
 	int ret;
 
@@ -112,10 +149,13 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			 */
 			return 0;
 		}
+
+		/* unsupported WiFi driver */
 		if (ret)
-			goto default_throughput;
+			goto fallback_throughput;
+
 		if (!(sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)))
-			goto default_throughput;
+			goto fallback_throughput;
 
 		return sinfo.expected_throughput / 100;
 	}
@@ -139,6 +179,24 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			return throughput * 10;
 	}
 
+fallback_throughput:
+	last_tp_run_msecs = jiffies_to_msecs(jiffies - neigh->bat_v.last_tp_meter_run);
+
+	/* check the tp_meter_running flag before checking the timestamp to
+	 * avoid a race condition where a new tp meter session is scheduled
+	 * right after the previous tp meter session has completed
+	 */
+	if (!neigh->bat_v.tp_meter_running &&
+	    last_tp_run_msecs > BATADV_ELP_TP_RUN_INTERVAL)
+		batadv_v_elp_tp_start(neigh);
+
+	/* discard too old tp test results */
+	if (last_tp_run_msecs > 2 * BATADV_ELP_TP_RUN_INTERVAL)
+		neigh->bat_v.tp_meter_throughput = 0;
+
+	if (!neigh->bat_v.tp_meter_throughput)
+		return neigh->bat_v.tp_meter_throughput;
+
 default_throughput:
 	if (!(hard_iface->bat_v.flags & BATADV_WARNING_DEFAULT)) {
 		batadv_info(hard_iface->soft_iface,
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index e8c7b7fd..d0605054 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -33,4 +33,23 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming);
 void batadv_v_elp_throughput_metric_update(struct work_struct *work);
 
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+
+void batadv_v_elp_tp_fail(struct batadv_hardif_neigh_node *neigh);
+void batadv_v_elp_tp_finish(struct batadv_hardif_neigh_node *neigh,
+			    u32 throughput);
+
+#else
+
+static inline void batadv_v_elp_tp_fail(struct batadv_hardif_neigh_node *neigh)
+{
+}
+
+static inline void
+batadv_v_elp_tp_finish(struct batadv_hardif_neigh_node *neigh, u32 throughput)
+{
+}
+
+#endif /* CONFIG_BATMAN_ADV_BATMAN_V */
+
 #endif /* _NET_BATMAN_ADV_BAT_V_ELP_H_ */
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 89dfaf87..ed4ae913 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -69,6 +69,7 @@
 #define BATADV_ELP_MIN_PROBE_SIZE 200 /* bytes */
 #define BATADV_ELP_PROBE_MAX_TX_DIFF 100 /* milliseconds */
 #define BATADV_ELP_MAX_AGE 64
+#define BATADV_ELP_TP_RUN_INTERVAL 60000 /* milliseconds */
 #define BATADV_OGM_MAX_ORIGDIFF 5
 #define BATADV_OGM_MAX_AGE 64
 
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 1526286b..e7a3c24e 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -56,6 +56,7 @@
 #include "netlink.h"
 #include "originator.h"
 #include "send.h"
+#include "bat_v_elp.h"
 
 /**
  * BATADV_TP_DEF_TEST_LENGTH - Default test length if not specified by the user
@@ -225,6 +226,7 @@ static void batadv_tp_caller_notify(struct batadv_priv *bat_priv,
 				    enum batadv_tp_meter_reason reason)
 {
 	u32 total_bytes;
+	u64 throughput;
 	u32 test_time;
 	u32 cookie;
 	bool reason_is_error;
@@ -249,6 +251,21 @@ static void batadv_tp_caller_notify(struct batadv_priv *bat_priv,
 
 		break;
 	case BATADV_TP_ELP:
+		if (reason_is_error) {
+			batadv_v_elp_tp_fail(tp_vars->hardif_neigh);
+			return;
+		}
+
+		test_time = jiffies_to_msecs(jiffies - tp_vars->start_time);
+		total_bytes = atomic64_read(&tp_vars->tot_sent);
+
+		/* The following calculation includes these steps:
+		 * - convert bytes to bits
+		 * - divide bits by the test length (msecs)
+		 * - convert result from bits/ms to 0.1Mb/s (* 1024 * 10 / 1000)
+		 */
+		throughput = total_bytes * 8 >> ilog2(test_time) / 10;
+		batadv_v_elp_tp_finish(tp_vars->hardif_neigh, throughput);
 		break;
 	default:
 		break;
@@ -266,13 +283,15 @@ static void batadv_tp_caller_notify(struct batadv_priv *bat_priv,
 static void batadv_tp_caller_init_error(struct batadv_priv *bat_priv,
 					enum batadv_tp_meter_caller caller,
 					enum batadv_tp_meter_reason reason,
-					const u8 *dst, u32 cookie)
+					const u8 *dst, u32 cookie,
+					struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	switch (caller) {
 	case BATADV_TP_USERSPACE:
 		batadv_netlink_tpmeter_notify(bat_priv, dst, reason, 0, 0, cookie);
 		break;
 	case BATADV_TP_ELP:
+		batadv_v_elp_tp_fail(hardif_neigh);
 		break;
 	default:
 		break;
@@ -978,7 +997,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: too many ongoing sessions, aborting (SEND)\n");
 		batadv_tp_caller_init_error(bat_priv, caller, BATADV_TP_REASON_TOO_MANY,
-					    dst, session_cookie);
+					    dst, session_cookie, neigh);
 		return;
 	}
 
@@ -988,7 +1007,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 			   "Meter: %s cannot allocate list elements\n",
 			   __func__);
 		batadv_tp_caller_init_error(bat_priv, caller, BATADV_TP_REASON_MEMORY_ERROR,
-					    dst, session_cookie);
+					    dst, session_cookie, neigh);
 		return;
 	}
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 98dccc6c..54fabcb1 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -583,6 +583,15 @@ struct batadv_hardif_neigh_node_bat_v {
 
 	/** @metric_work: work queue callback item for metric update */
 	struct work_struct metric_work;
+
+	/** @tp_meter_running: tp meter measurements towards this neighbor in progress */
+	bool tp_meter_running;
+
+	/** @last_tp_meter_run: timestamp of last tp meter measurement completion */
+	unsigned long last_tp_meter_run;
+
+	/** @tp_meter_throughput: throughput information measured by tp meter */
+	unsigned long tp_meter_throughput;
 };
 
 /**
-- 
2.17.0

