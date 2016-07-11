Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 11 Jul 2016 14:39:08 +0200
Message-Id: <1468240748-16456-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: Use own timer for multicast
	TT and TVLV updates
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

Instead of latching onto the OGM period, this patch introduces a worker
dedicated to multicast TT and TVLV updates.

The reasoning is, that upon roaming especially the translation table
should be updated timely to minimize connectivity issues.

With BATMAN V, the idea is to greatly increase the OGM interval to
reduce overhead. Unfortunately, right now this could lead to
a bad user experience if multicast traffic is involved.

Therefore this patch introduces a fixed 500ms update interval for
multicast TT entries and the multicast TVLV.

RFC Notes:
* Patch compile tested only
* Someone should check whether adding/removing multicast TT entries
  from this new entry point is save like this
---
 net/batman-adv/main.h              |  1 +
 net/batman-adv/multicast.c         | 44 ++++++++++++++++++++++++++++++++++++--
 net/batman-adv/multicast.h         |  6 ------
 net/batman-adv/translation-table.c |  4 ----
 net/batman-adv/types.h             |  2 ++
 5 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 06a8608..edb8427 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -48,6 +48,7 @@
 #define BATADV_TT_CLIENT_TEMP_TIMEOUT 600000 /* in milliseconds */
 #define BATADV_TT_WORK_PERIOD 5000 /* 5 seconds */
 #define BATADV_ORIG_WORK_PERIOD 1000 /* 1 second */
+#define BATADV_MCAST_WORK_PERIOD 500 /* 0.5 seconds */
 #define BATADV_DAT_ENTRY_TIMEOUT (5 * 60000) /* 5 mins in milliseconds */
 /* sliding packet range of received originator messages in sequence numbers
  * (should be a multiple of our word size)
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 894df60..f5b7c26 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -60,6 +60,19 @@
 #include "translation-table.h"
 #include "tvlv.h"
 
+static void batadv_mcast_mla_update(struct work_struct *work);
+
+/**
+ * batadv_mcast_start_timer - initialise the multicast periodic worker
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+static void batadv_mcast_start_timer(struct batadv_priv *bat_priv)
+{
+	INIT_DELAYED_WORK(&bat_priv->mcast.work, batadv_mcast_mla_update);
+	queue_delayed_work(batadv_event_workqueue, &bat_priv->mcast.work,
+			   msecs_to_jiffies(BATADV_MCAST_WORK_PERIOD));
+}
+
 /**
  * batadv_mcast_get_bridge - get the bridge on top of the softif if it exists
  * @soft_iface: netdev struct of the mesh interface
@@ -532,13 +545,13 @@ update:
 }
 
 /**
- * batadv_mcast_mla_update - update the own MLAs
+ * __batadv_mcast_mla_update - update the own MLAs
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Updates the own multicast listener announcements in the translation
  * table as well as the own, announced multicast tvlv container.
  */
-void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
+static void __batadv_mcast_mla_update(struct batadv_priv *bat_priv)
 {
 	struct net_device *soft_iface = bat_priv->soft_iface;
 	struct hlist_head mcast_list = HLIST_HEAD_INIT;
@@ -564,6 +577,29 @@ out:
 }
 
 /**
+ * batadv_mcast_mla_update - update the own MLAs
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Updates the own multicast listener announcements in the translation
+ * table as well as the own, announced multicast tvlv container.
+ *
+ * In the end, reschedules the work timer.
+ */
+static void batadv_mcast_mla_update(struct work_struct *work)
+{
+	struct delayed_work *delayed_work;
+	struct batadv_priv_mcast *priv_mcast;
+	struct batadv_priv *bat_priv;
+
+	delayed_work = to_delayed_work(work);
+	priv_mcast = container_of(delayed_work, struct batadv_priv_mcast, work);
+	bat_priv = container_of(priv_mcast, struct batadv_priv, mcast);
+
+	__batadv_mcast_mla_update(bat_priv);
+	batadv_mcast_start_timer(bat_priv);
+}
+
+/**
  * batadv_mcast_is_report_ipv4 - check for IGMP reports
  * @skb: the ethernet frame destined for the mesh
  *
@@ -1132,6 +1168,8 @@ void batadv_mcast_init(struct batadv_priv *bat_priv)
 	batadv_tvlv_handler_register(bat_priv, batadv_mcast_tvlv_ogm_handler,
 				     NULL, BATADV_TVLV_MCAST, 2,
 				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
+
+	batadv_mcast_start_timer(bat_priv);
 }
 
 /**
@@ -1241,6 +1279,8 @@ int batadv_mcast_flags_seq_print_text(struct seq_file *seq, void *offset)
  */
 void batadv_mcast_free(struct batadv_priv *bat_priv)
 {
+	cancel_delayed_work_sync(&bat_priv->mcast.work);
+
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
 
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 1fb00ba..2cddaf5 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -39,8 +39,6 @@ enum batadv_forw_mode {
 
 #ifdef CONFIG_BATMAN_ADV_MCAST
 
-void batadv_mcast_mla_update(struct batadv_priv *bat_priv);
-
 enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		       struct batadv_orig_node **mcast_single_orig);
@@ -55,10 +53,6 @@ void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node);
 
 #else
 
-static inline void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
-{
-}
-
 static inline enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		       struct batadv_orig_node **mcast_single_orig)
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index af2bfef..2ea9b66 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -50,7 +50,6 @@
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
-#include "multicast.h"
 #include "originator.h"
 #include "packet.h"
 #include "soft-interface.h"
@@ -3414,9 +3413,6 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 {
 	lockdep_assert_held(&bat_priv->tt.commit_lock);
 
-	/* Update multicast addresses in local translation table */
-	batadv_mcast_mla_update(bat_priv);
-
 	if (atomic_read(&bat_priv->tt.local_changes) < 1) {
 		if (!batadv_atomic_dec_not_zero(&bat_priv->tt.ogm_append_cnt))
 			batadv_tt_tvlv_container_update(bat_priv);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 72806a3..81778a5 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -784,6 +784,7 @@ struct batadv_mcast_querier_state {
  * @num_want_all_ipv6: counter for items in want_all_ipv6_list
  * @want_lists_lock: lock for protecting modifications to mcast want lists
  *  (traversals are rcu-locked)
+ * @work: work queue callback item for multicast TT and TVLV updates
  */
 struct batadv_priv_mcast {
 	struct hlist_head mla_list;
@@ -801,6 +802,7 @@ struct batadv_priv_mcast {
 	atomic_t num_want_all_ipv6;
 	/* protects want_all_{unsnoopables,ipv4,ipv6}_list */
 	spinlock_t want_lists_lock;
+	struct delayed_work work;
 };
 #endif
 
-- 
2.1.4

