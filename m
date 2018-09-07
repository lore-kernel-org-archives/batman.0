Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri,  7 Sep 2018 17:59:52 +0800
Message-Id: <20180907095958.30946-2-mareklindner@neomailbox.ch>
In-Reply-To: <20180907095958.30946-1-mareklindner@neomailbox.ch>
References: <20180907095958.30946-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH v5 1/7] batman-adv: tp_meter - prevent
 concurrent tp_meter sessions by using workqueue
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
Cc: Antonio Quartulli <a@unstable.cc>

From: Antonio Quartulli <a@unstable.cc>

To ensure that no more than one tp_meter session runs at the
same time, use an ordered workqueue instead of spawning
one kthread per session.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/main.c     | 10 +++-
 net/batman-adv/tp_meter.c | 96 +++++++++++++++++++--------------------
 net/batman-adv/tp_meter.h |  3 +-
 net/batman-adv/types.h    |  3 ++
 4 files changed, 60 insertions(+), 52 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 69c0d85b..cd3f1924 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -91,6 +91,10 @@ static int __init batadv_init(void)
 	if (ret < 0)
 		return ret;
 
+	ret = batadv_tp_meter_init();
+	if (ret < 0)
+		goto err_tp_meter;
+
 	INIT_LIST_HEAD(&batadv_hardif_list);
 	batadv_algo_init();
 
@@ -99,7 +103,6 @@ static int __init batadv_init(void)
 	batadv_v_init();
 	batadv_iv_init();
 	batadv_nc_init();
-	batadv_tp_meter_init();
 
 	batadv_event_workqueue = create_singlethread_workqueue("bat_events");
 	if (!batadv_event_workqueue)
@@ -118,9 +121,11 @@ static int __init batadv_init(void)
 	return 0;
 
 err_create_wq:
+	batadv_tp_meter_destroy();
+err_tp_meter:
 	batadv_tt_cache_destroy();
 
-	return -ENOMEM;
+	return ret;
 }
 
 static void __exit batadv_exit(void)
@@ -138,6 +143,7 @@ static void __exit batadv_exit(void)
 	rcu_barrier();
 
 	batadv_tt_cache_destroy();
+	batadv_tp_meter_destroy();
 }
 
 /**
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 11520de9..9a29ab62 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -32,7 +32,6 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
-#include <linux/kthread.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/param.h>
@@ -97,6 +96,9 @@
 
 static u8 batadv_tp_prerandom[4096] __read_mostly;
 
+/* ordered work queue */
+static struct workqueue_struct *batadv_tp_meter_queue;
+
 /**
  * batadv_tp_session_cookie() - generate session cookie based on session ids
  * @session: TP session identifier
@@ -808,19 +810,22 @@ static int batadv_tp_wait_available(struct batadv_tp_vars *tp_vars, size_t plen)
 
 /**
  * batadv_tp_send() - main sending thread of a tp meter session
- * @arg: address of the related tp_vars
+ * @work: delayed work reference of the related tp_vars
  *
  * Return: nothing, this function never returns
  */
-static int batadv_tp_send(void *arg)
+static void batadv_tp_send(struct work_struct *work)
 {
-	struct batadv_tp_vars *tp_vars = arg;
-	struct batadv_priv *bat_priv = tp_vars->bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
+	struct batadv_tp_vars *tp_vars;
 	size_t payload_len, packet_len;
+	struct batadv_priv *bat_priv;
 	int err = 0;
 
+	tp_vars = container_of(work, struct batadv_tp_vars, test_work);
+	bat_priv = tp_vars->bat_priv;
+
 	if (unlikely(tp_vars->role != BATADV_TP_SENDER)) {
 		err = BATADV_TP_REASON_DST_UNREACHABLE;
 		tp_vars->reason = err;
@@ -901,40 +906,6 @@ static int batadv_tp_send(void *arg)
 	batadv_tp_sender_cleanup(bat_priv, tp_vars);
 
 	batadv_tp_vars_put(tp_vars);
-
-	do_exit(0);
-}
-
-/**
- * batadv_tp_start_kthread() - start new thread which manages the tp meter
- *  sender
- * @tp_vars: the private data of the current TP meter session
- */
-static void batadv_tp_start_kthread(struct batadv_tp_vars *tp_vars)
-{
-	struct task_struct *kthread;
-	struct batadv_priv *bat_priv = tp_vars->bat_priv;
-	u32 session_cookie;
-
-	kref_get(&tp_vars->refcount);
-	kthread = kthread_create(batadv_tp_send, tp_vars, "kbatadv_tp_meter");
-	if (IS_ERR(kthread)) {
-		session_cookie = batadv_tp_session_cookie(tp_vars->session,
-							  tp_vars->icmp_uid);
-		pr_err("batadv: cannot create tp meter kthread\n");
-		batadv_tp_batctl_error_notify(BATADV_TP_REASON_MEMORY_ERROR,
-					      tp_vars->other_end,
-					      bat_priv, session_cookie);
-
-		/* drop reserved reference for kthread */
-		batadv_tp_vars_put(tp_vars);
-
-		/* cleanup of failed tp meter variables */
-		batadv_tp_sender_cleanup(bat_priv, tp_vars);
-		return;
-	}
-
-	wake_up_process(kthread);
 }
 
 /**
@@ -951,6 +922,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	u8 session_id[2];
 	u8 icmp_uid;
 	u32 session_cookie;
+	bool ret;
 
 	get_random_bytes(session_id, sizeof(session_id));
 	get_random_bytes(&icmp_uid, 1);
@@ -1046,20 +1018,28 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	if (!tp_vars->test_length)
 		tp_vars->test_length = BATADV_TP_DEF_TEST_LENGTH;
 
-	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
-		   "Meter: starting throughput meter towards %pM (length=%ums)\n",
-		   dst, test_length);
-
 	/* init work item for finished tp tests */
 	INIT_DELAYED_WORK(&tp_vars->finish_work, batadv_tp_sender_finish);
 
-	/* start tp kthread. This way the write() call issued from userspace can
-	 * happily return and avoid to block
+	/* schedule the tp worker. This way the write() call issued from
+	 * userspace can happily return and avoid to block
 	 */
-	batadv_tp_start_kthread(tp_vars);
+	INIT_WORK(&tp_vars->test_work, batadv_tp_send);
+	ret = queue_work(batadv_tp_meter_queue, &tp_vars->test_work);
 
-	/* don't return reference to new tp_vars */
-	batadv_tp_vars_put(tp_vars);
+	if (!ret) {
+		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
+			   "Meter: too many queued workers, aborting (SEND)\n");
+		batadv_tp_caller_init_error(bat_priv, caller,
+					    BATADV_TP_REASON_ALREADY_ONGOING,
+					    dst, session_cookie, neigh);
+		batadv_tp_vars_put(tp_vars);
+		return;
+	}
+
+	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
+		   "Meter: starting throughput meter towards %pM (length=%ums)\n",
+		   dst, test_length);
 }
 
 /**
@@ -1498,8 +1478,26 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 
 /**
  * batadv_tp_meter_init() - initialize global tp_meter structures
+ *
+ * Return: 0 on success, -ENOMEM if the tp_meter queue allocation fails
  */
-void __init batadv_tp_meter_init(void)
+int __init batadv_tp_meter_init(void)
 {
 	get_random_bytes(batadv_tp_prerandom, sizeof(batadv_tp_prerandom));
+
+	batadv_tp_meter_queue = alloc_ordered_workqueue("bat_tp_meter", 0);
+	if (!batadv_tp_meter_queue)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * batadv_tp_meter_destroy() - destroy tp meter memory allocations
+ */
+void batadv_tp_meter_destroy(void)
+{
+	flush_workqueue(batadv_tp_meter_queue);
+	destroy_workqueue(batadv_tp_meter_queue);
+	batadv_tp_meter_queue = NULL;
 }
diff --git a/net/batman-adv/tp_meter.h b/net/batman-adv/tp_meter.h
index 68e60097..ab0bde26 100644
--- a/net/batman-adv/tp_meter.h
+++ b/net/batman-adv/tp_meter.h
@@ -25,7 +25,8 @@
 
 struct sk_buff;
 
-void batadv_tp_meter_init(void);
+int batadv_tp_meter_init(void);
+void batadv_tp_meter_destroy(void);
 void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 		     u32 test_length, u32 *cookie);
 void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 343d3048..2696b093 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1355,6 +1355,9 @@ struct batadv_tp_vars {
 	/** @finish_work: work item for the finishing procedure */
 	struct delayed_work finish_work;
 
+	/** @test_work: work item for the test process */
+	struct work_struct test_work;
+
 	/** @test_length: test length in milliseconds */
 	u32 test_length;
 
-- 
2.18.0

