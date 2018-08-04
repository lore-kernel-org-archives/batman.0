Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat,  4 Aug 2018 21:48:53 +0800
Message-Id: <20180804134854.4075-7-mareklindner@neomailbox.ch>
In-Reply-To: <20180804134854.4075-1-mareklindner@neomailbox.ch>
References: <20180804134854.4075-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH v3 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
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
 net/batman-adv/bat_v_elp.c | 67 ++++++++++++++++++++++++++++++++++++--
 net/batman-adv/bat_v_elp.h | 21 ++++++++++++
 net/batman-adv/main.h      |  1 +
 net/batman-adv/tp_meter.c  | 43 +++++++++++++++++++-----
 net/batman-adv/types.h     | 14 ++++++++
 5 files changed, 135 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 71c20c1d..2d206a08 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -51,6 +51,7 @@
 #include "originator.h"
 #include "routing.h"
 #include "send.h"
+#include "tp_meter.h"
 
 /**
  * batadv_v_elp_start_timer() - restart timer for ELP periodic work
@@ -67,6 +68,42 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
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
+	batadv_tp_start(bat_priv, neigh->addr, neigh,
+			1000, NULL, BATADV_TP_ELP);
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
+	neigh->bat_v.tp_meter_throughput = throughput;
+	neigh->bat_v.last_tp_meter_run = jiffies;
+	neigh->bat_v.tp_meter_running = false;
+}
+
 /**
  * batadv_v_elp_get_throughput() - get the throughput towards a neighbour
  * @neigh: the neighbour for which the throughput has to be obtained
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
@@ -152,6 +192,29 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			return throughput * 10;
 	}
 
+fallback_throughput:
+	/* check the tp_meter_running flag before checking the timestamp to
+	 * avoid a race condition where a new tp meter session is scheduled
+	 * right after the previous tp meter session has completed.
+	 *
+	 * No lock is required because this is the only point where
+	 * batadv_v_elp_tp_start() is invoked and we get here only through a
+	 * periodic timer. This means we will never run this function
+	 * concurrently with itself.
+	 */
+	if (!neigh->bat_v.tp_meter_running &&
+	    batadv_has_timed_out(neigh->bat_v.last_tp_meter_run,
+				 BATADV_ELP_TP_RUN_INTERVAL))
+		batadv_v_elp_tp_start(neigh);
+
+	/* discard too old tp test results */
+	if (batadv_has_timed_out(neigh->bat_v.last_tp_meter_run,
+				 2 * BATADV_ELP_TP_RUN_INTERVAL))
+		neigh->bat_v.tp_meter_throughput = 0;
+
+	if (neigh->bat_v.tp_meter_throughput)
+		return neigh->bat_v.tp_meter_throughput;
+
 default_throughput:
 	if (!(hard_iface->bat_v.flags & BATADV_WARNING_DEFAULT)) {
 		batadv_info(hard_iface->soft_iface,
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index e8c7b7fd..4ffb1fde 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -21,6 +21,8 @@
 
 #include "main.h"
 
+#include <linux/types.h>
+
 struct sk_buff;
 struct work_struct;
 
@@ -33,4 +35,23 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
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
index 87aaeb1d..243a03b9 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -24,7 +24,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
 #include <linux/compiler.h>
-#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
 #include <linux/if_ether.h>
@@ -33,9 +33,9 @@
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
+#include <linux/log2.h>
 #include <linux/netdevice.h>
 #include <linux/param.h>
-#include <linux/printk.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -51,6 +51,7 @@
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
+#include "bat_v_elp.h"
 #include "hard-interface.h"
 #include "log.h"
 #include "netlink.h"
@@ -224,7 +225,7 @@ static void batadv_tp_caller_notify(struct batadv_priv *bat_priv,
 				    struct batadv_tp_vars *tp_vars,
 				    enum batadv_tp_meter_reason reason)
 {
-	u32 total_bytes;
+	u64 total_bytes;
 	u32 test_time;
 	u32 cookie;
 	bool reason_is_error;
@@ -251,6 +252,26 @@ static void batadv_tp_caller_notify(struct batadv_priv *bat_priv,
 
 		break;
 	case BATADV_TP_ELP:
+		if (reason_is_error) {
+			batadv_v_elp_tp_fail(tp_vars->hardif_neigh);
+			return;
+		}
+
+		test_time = jiffies_to_msecs(jiffies - tp_vars->start_time);
+		if (!test_time) {
+			batadv_v_elp_tp_fail(tp_vars->hardif_neigh);
+			return;
+		}
+
+		total_bytes = atomic64_read(&tp_vars->tot_sent);
+
+		/* The following calculation includes these steps:
+		 * - divide bytes by the test length (msecs)
+		 * - convert result from bits/ms to 0.1Mb/s (1Mb/s==1000000b/s)
+		 */
+		total_bytes = atomic64_read(&tp_vars->tot_sent);
+		do_div(total_bytes, test_time * 125);
+		batadv_v_elp_tp_finish(tp_vars->hardif_neigh, total_bytes);
 		break;
 	default:
 		break;
@@ -264,11 +285,14 @@ static void batadv_tp_caller_notify(struct batadv_priv *bat_priv,
  * @reason: reason for tp meter session stop
  * @dst: destination of tp_meter session
  * @cookie: cookie of tp_meter session
+ * @hardif_neigh: neighbor towards which the test was ran (for one-hop test)
  */
-static void batadv_tp_caller_init_error(struct batadv_priv *bat_priv,
-					enum batadv_tp_meter_caller caller,
-					enum batadv_tp_meter_reason reason,
-					const u8 *dst, u32 cookie)
+static void
+batadv_tp_caller_init_error(struct batadv_priv *bat_priv,
+			    enum batadv_tp_meter_caller caller,
+			    enum batadv_tp_meter_reason reason, const u8 *dst,
+			    u32 cookie,
+			    struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	switch (caller) {
 	case BATADV_TP_USERSPACE:
@@ -276,6 +300,7 @@ static void batadv_tp_caller_init_error(struct batadv_priv *bat_priv,
 					      cookie);
 		break;
 	case BATADV_TP_ELP:
+		batadv_v_elp_tp_fail(hardif_neigh);
 		break;
 	default:
 		break;
@@ -981,7 +1006,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 			   "Meter: too many ongoing sessions, aborting (SEND)\n");
 		batadv_tp_caller_init_error(bat_priv, caller,
 					    BATADV_TP_REASON_TOO_MANY, dst,
-					    session_cookie);
+					    session_cookie, neigh);
 		return;
 	}
 
@@ -989,7 +1014,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	if (!tp_vars) {
 		batadv_tp_caller_init_error(bat_priv, caller,
 					    BATADV_TP_REASON_MEMORY_ERROR, dst,
-					    session_cookie);
+					    session_cookie, neigh);
 		return;
 	}
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index f72db6cf..fe763410 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -584,6 +584,20 @@ struct batadv_hardif_neigh_node_bat_v {
 
 	/** @metric_work: work queue callback item for metric update */
 	struct work_struct metric_work;
+
+	/**
+	 * @tp_meter_running: tp meter measurements towards this neighbor in
+	 * progress
+	 */
+	unsigned char tp_meter_running:1;
+
+	/**
+	 * @last_tp_meter_run: timestamp of last tp meter measurement completion
+	 */
+	unsigned long last_tp_meter_run;
+
+	/** @tp_meter_throughput: throughput information measured by tp meter */
+	unsigned long tp_meter_throughput;
 };
 
 /**
-- 
2.18.0

