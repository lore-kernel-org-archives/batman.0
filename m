Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue,  7 Aug 2018 21:05:15 +0800
Message-Id: <20180807130518.27018-5-mareklindner@neomailbox.ch>
In-Reply-To: <20180807130518.27018-1-mareklindner@neomailbox.ch>
References: <20180807130518.27018-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH v4 4/7] batman-adv: tp_meter - add caller
 distinction
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

The throughput meter can be called from user space as well as from
the batman-adv kernel module itself. Add infrastructure to handle
the different callers.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/netlink.c  |   3 +-
 net/batman-adv/tp_meter.c | 108 ++++++++++++++++++++++----------------
 net/batman-adv/tp_meter.h |   3 +-
 net/batman-adv/types.h    |  13 +++++
 4 files changed, 79 insertions(+), 48 deletions(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 0d9459b6..b0e1b73c 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -378,7 +378,8 @@ batadv_netlink_tp_meter_start(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	bat_priv = netdev_priv(soft_iface);
-	batadv_tp_start(bat_priv, dst, test_length, &cookie);
+	batadv_tp_start(bat_priv, dst, test_length, &cookie,
+			BATADV_TP_USERSPACE);
 
 	ret = batadv_netlink_tp_meter_put(msg, cookie);
 
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index e89d3942..50a0e4fa 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -215,50 +215,71 @@ static void batadv_tp_update_rto(struct batadv_tp_vars *tp_vars,
 }
 
 /**
- * batadv_tp_batctl_notify() - send client status result to client
- * @reason: reason for tp meter session stop
- * @dst: destination of tp_meter session
+ * batadv_tp_caller_notify() - send tp meter status result to caller
  * @bat_priv: the bat priv with all the soft interface information
- * @start_time: start of transmission in jiffies
- * @total_sent: bytes acked to the receiver
- * @cookie: cookie of tp_meter session
+ * @tp_vars: the private data of the current TP meter session
+ * @reason: reason for tp meter session stop
  */
-static void batadv_tp_batctl_notify(enum batadv_tp_meter_reason reason,
-				    const u8 *dst, struct batadv_priv *bat_priv,
-				    unsigned long start_time, u64 total_sent,
-				    u32 cookie)
+static void batadv_tp_caller_notify(struct batadv_priv *bat_priv,
+				    struct batadv_tp_vars *tp_vars,
+				    enum batadv_tp_meter_reason reason)
 {
-	u32 test_time;
-	u8 result;
 	u32 total_bytes;
+	u32 test_time;
+	u32 cookie;
+	bool reason_is_error;
 
-	if (!batadv_tp_is_error(reason)) {
-		result = BATADV_TP_REASON_COMPLETE;
-		test_time = jiffies_to_msecs(jiffies - start_time);
-		total_bytes = total_sent;
-	} else {
-		result = reason;
-		test_time = 0;
-		total_bytes = 0;
-	}
+	reason_is_error = batadv_tp_is_error(reason);
+
+	switch (tp_vars->caller) {
+	case BATADV_TP_USERSPACE:
+		cookie = batadv_tp_session_cookie(tp_vars->session,
+						  tp_vars->icmp_uid);
 
-	batadv_netlink_tpmeter_notify(bat_priv, dst, result, test_time,
-				      total_bytes, cookie);
+		if (reason_is_error) {
+			batadv_netlink_tpmeter_notify(bat_priv,
+						      tp_vars->other_end,
+						      reason, 0, 0, cookie);
+			return;
+		}
+
+		test_time = jiffies_to_msecs(jiffies - tp_vars->start_time);
+		total_bytes = atomic64_read(&tp_vars->tot_sent);
+		batadv_netlink_tpmeter_notify(bat_priv, tp_vars->other_end,
+					      BATADV_TP_REASON_COMPLETE,
+					      test_time, total_bytes, cookie);
+
+		break;
+	case BATADV_TP_ELP:
+		break;
+	default:
+		break;
+	}
 }
 
 /**
- * batadv_tp_batctl_error_notify() - send client error result to client
+ * batadv_tp_caller_init_error() - report early tp meter errors to caller
+ * @bat_priv: the bat priv with all the soft interface information
+ * @caller: caller of tp meter session (user space or ELP)
  * @reason: reason for tp meter session stop
  * @dst: destination of tp_meter session
- * @bat_priv: the bat priv with all the soft interface information
  * @cookie: cookie of tp_meter session
  */
-static void batadv_tp_batctl_error_notify(enum batadv_tp_meter_reason reason,
-					  const u8 *dst,
-					  struct batadv_priv *bat_priv,
-					  u32 cookie)
+static void batadv_tp_caller_init_error(struct batadv_priv *bat_priv,
+					enum batadv_tp_meter_caller caller,
+					enum batadv_tp_meter_reason reason,
+					const u8 *dst, u32 cookie)
 {
-	batadv_tp_batctl_notify(reason, dst, bat_priv, 0, 0, cookie);
+	switch (caller) {
+	case BATADV_TP_USERSPACE:
+		batadv_netlink_tpmeter_notify(bat_priv, dst, reason, 0, 0,
+					      cookie);
+		break;
+	case BATADV_TP_ELP:
+		break;
+	default:
+		break;
+	}
 }
 
 /**
@@ -411,8 +432,6 @@ static void batadv_tp_sender_cleanup(struct batadv_priv *bat_priv,
 static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 				 struct batadv_tp_vars *tp_vars)
 {
-	u32 session_cookie;
-
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Test towards %pM finished..shutting down (reason=%d)\n",
 		   tp_vars->other_end, tp_vars->reason);
@@ -425,15 +444,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 		   "Final values: cwnd=%u ss_threshold=%u\n",
 		   tp_vars->cwnd, tp_vars->ss_threshold);
 
-	session_cookie = batadv_tp_session_cookie(tp_vars->session,
-						  tp_vars->icmp_uid);
-
-	batadv_tp_batctl_notify(tp_vars->reason,
-				tp_vars->other_end,
-				bat_priv,
-				tp_vars->start_time,
-				atomic64_read(&tp_vars->tot_sent),
-				session_cookie);
+	batadv_tp_caller_notify(bat_priv, tp_vars, tp_vars->reason);
 }
 
 /**
@@ -925,9 +936,11 @@ static void batadv_tp_start_work(struct batadv_tp_vars *tp_vars)
  * @dst: the receiver MAC address
  * @test_length: test length in milliseconds
  * @cookie: session cookie
+ * @caller: caller of tp meter session (user space or ELP)
  */
 void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
-		     u32 test_length, u32 *cookie)
+		     u32 test_length, u32 *cookie,
+		     enum batadv_tp_meter_caller caller)
 {
 	struct batadv_tp_vars *tp_vars;
 	u8 session_id[2];
@@ -942,15 +955,17 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	if (!atomic_add_unless(&bat_priv->tp_num, 1, BATADV_TP_MAX_NUM_QUEUE)) {
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: too many ongoing sessions, aborting (SEND)\n");
-		batadv_tp_batctl_error_notify(BATADV_TP_REASON_TOO_MANY, dst,
-					      bat_priv, session_cookie);
+		batadv_tp_caller_init_error(bat_priv, caller,
+					    BATADV_TP_REASON_TOO_MANY, dst,
+					    session_cookie);
 		return;
 	}
 
 	tp_vars = kmalloc(sizeof(*tp_vars), GFP_ATOMIC);
 	if (!tp_vars) {
-		batadv_tp_batctl_error_notify(BATADV_TP_REASON_MEMORY_ERROR,
-					      dst, bat_priv, session_cookie);
+		batadv_tp_caller_init_error(bat_priv, caller,
+					    BATADV_TP_REASON_MEMORY_ERROR, dst,
+					    session_cookie);
 		return;
 	}
 
@@ -958,6 +973,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	ether_addr_copy(tp_vars->other_end, dst);
 	kref_init(&tp_vars->refcount);
 	tp_vars->role = BATADV_TP_SENDER;
+	tp_vars->caller = caller;
 	atomic_set(&tp_vars->sending, 1);
 	memcpy(tp_vars->session, session_id, sizeof(session_id));
 	tp_vars->icmp_uid = icmp_uid;
diff --git a/net/batman-adv/tp_meter.h b/net/batman-adv/tp_meter.h
index ab0bde26..3b11a3e9 100644
--- a/net/batman-adv/tp_meter.h
+++ b/net/batman-adv/tp_meter.h
@@ -28,7 +28,8 @@ struct sk_buff;
 int batadv_tp_meter_init(void);
 void batadv_tp_meter_destroy(void);
 void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
-		     u32 test_length, u32 *cookie);
+		     u32 test_length, u32 *cookie,
+		     enum batadv_tp_meter_caller caller);
 void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 		    u8 return_value);
 void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 2696b093..56034b54 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1324,6 +1324,16 @@ enum batadv_tp_meter_role {
 	BATADV_TP_SENDER
 };
 
+/**
+ * enum batadv_tp_meter_caller - initiator of the tp meter session
+ * @BATADV_TP_USERSPACE: initiated by user space
+ * @BATADV_TP_ELP: initiated by ELP
+ */
+enum batadv_tp_meter_caller {
+	BATADV_TP_USERSPACE,
+	BATADV_TP_ELP
+};
+
 /**
  * struct batadv_tp_vars - tp meter private variables per session
  */
@@ -1346,6 +1356,9 @@ struct batadv_tp_vars {
 	/** @role: receiver/sender modi */
 	enum batadv_tp_meter_role role;
 
+	/** @caller: caller of tp meter session (user space or ELP) */
+	enum batadv_tp_meter_caller caller;
+
 	/** @sending: sending binary semaphore: 1 if sending, 0 is not */
 	atomic_t sending;
 
-- 
2.18.0

