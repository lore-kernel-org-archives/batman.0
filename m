Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:17 +0100
Message-Id: <1392122903-805-18-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 17/23] batman-adv: ELP - implement dead neigh
	node detection
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Improve the neighbour purging routine to timely detect when
a neighbour is not sending data anymore without waiting for
a real timeout. This detection system can be used by the
B.A.T.M.A.N. V routing algorithm to trigger an on-demand
route reconstruction.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_v.c     |  7 +++++
 bat_v_elp.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 bat_v_elp.h |  2 ++
 types.h     |  2 ++
 4 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/bat_v.c b/bat_v.c
index 3aa42ec..5681d19 100644
--- a/bat_v.c
+++ b/bat_v.c
@@ -75,14 +75,21 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 
 int batadv_v_mesh_init(struct batadv_priv *bat_priv)
 {
+	int r;
+
 	atomic_set(&bat_priv->bat_v.base_throughput,
 		   BATADV_DEFAULT_BASE_THROUGHPUT);
 
+	r = batadv_v_elp_init(bat_priv);
+	if (r)
+		return r;
+
 	return batadv_v_ogm_init(bat_priv);
 }
 
 void batadv_v_mesh_free(struct batadv_priv *bat_priv)
 {
+	batadv_v_elp_free(bat_priv);
 	batadv_v_ogm_free(bat_priv);
 }
 
diff --git a/bat_v_elp.c b/bat_v_elp.c
index 31190af..763113e 100644
--- a/bat_v_elp.c
+++ b/bat_v_elp.c
@@ -25,6 +25,7 @@
 #include "send.h"
 #include "bat_algo.h"
 #include "bat_v_elp.h"
+#include "bat_v_ogm.h"
 #include "originator.h"
 #include "routing.h"
 #include "soft-interface.h"
@@ -186,30 +187,55 @@ batadv_v_elp_neigh_get(struct batadv_hard_iface *hard_iface,
  * batadv_v_elp_neigh_purge - purge obsolete neighbour nodes
  *
  * Deletes the ELP neighbour nodes that did not send any ELP message for a
- * pre-defined amount of time.
+ * pre-defined amount of time and returns the minimum ELP interval among all the
+ * remaining neighbours.
  */
-static void batadv_v_elp_neigh_purge(struct batadv_hard_iface *hard_iface)
+static uint32_t batadv_v_elp_neigh_purge(struct batadv_hard_iface *hard_iface)
 {
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	unsigned long timeout;
 	struct batadv_elp_neigh_node *neigh;
 	struct hlist_node *node;
 	bool has_timed_out;
+	uint32_t tmp_interval, min_interval = UINT_MAX;
 
 	spin_lock_bh(&hard_iface->bat_v.neigh_list_lock);
 	hlist_for_each_entry_safe(neigh, node, &hard_iface->bat_v.neigh_list,
 				  list) {
-		timeout = neigh->elp_interval * BATADV_ELP_OUTDATED_MAX;
+		tmp_interval = neigh->elp_interval;
+
+		timeout = tmp_interval * BATADV_ELP_OUTDATED_MAX;
 		has_timed_out = batadv_has_timed_out(neigh->last_seen, timeout);
+		if (has_timed_out) {
+			/* this neigh is dead! the node could react somehow.
+			 * TODO: implement dead node reaction mechanism
+			 */
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Node %pM is dead.\n", neigh->addr);
 
+			/* this node is not sending ELP packets anymore. Don't
+			 * consider it in the minimum ELP interval research
+			 */
+			tmp_interval = UINT_MAX;
+		}
+
+		has_timed_out = batadv_has_timed_out(neigh->last_seen,
+						     BATADV_PURGE_TIMEOUT);
 		if ((!has_timed_out) &&
-		    (hard_iface->if_status == BATADV_IF_ACTIVE))
+		    (hard_iface->if_status == BATADV_IF_ACTIVE)) {
+			if (tmp_interval < min_interval)
+				min_interval = tmp_interval;
 			continue;
+		}
 
 		hlist_del_rcu(&neigh->list);
 		atomic_dec(&hard_iface->bat_v.num_neighbors);
 		batadv_elp_neigh_node_free_ref(neigh);
+
 	}
 	spin_unlock_bh(&hard_iface->bat_v.neigh_list_lock);
+
+	return min_interval;
 }
 
 /**
@@ -479,6 +505,7 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 
 {
 	struct batadv_elp_neigh_node *neigh;
+	uint32_t interval;
 
 	neigh = batadv_v_elp_neigh_get(if_incoming, neigh_addr);
 	if (!neigh) {
@@ -490,6 +517,16 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 
 	neigh->last_seen = jiffies;
 	neigh->last_recv_seqno = ntohl(elp_packet->seqno);
+	neigh->elp_interval = ntohl(elp_packet->elp_interval);
+
+	interval = atomic_read(&bat_priv->bat_v.neigh_interval);
+	if (neigh->elp_interval >= interval)
+		goto out;
+
+	/* got a shorter elp interval: reschedule the neigh check */
+	atomic_set(&bat_priv->bat_v.neigh_interval, neigh->elp_interval);
+	queue_delayed_work(batadv_event_workqueue, &bat_priv->bat_v.neigh_wq,
+			   msecs_to_jiffies(neigh->elp_interval));
 
 out:
 	if (neigh)
@@ -625,3 +662,49 @@ out:
 		batadv_hardif_free_ref(primary_if);
 	return 0;
 }
+
+static void batadv_v_elp_check_neigh(struct work_struct *work)
+{
+	struct batadv_priv_bat_v *bat_v;
+	struct batadv_priv *bat_priv;
+	struct batadv_hard_iface *hard_iface;
+	uint32_t tmp_interval, min_interval = UINT_MAX;
+
+	bat_v = container_of(work, struct batadv_priv_bat_v, neigh_wq.work);
+	bat_priv = container_of(bat_v, struct batadv_priv, bat_v);
+
+	list_for_each_entry(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->soft_iface != bat_priv->soft_iface)
+			continue;
+
+		tmp_interval = batadv_v_elp_neigh_purge(hard_iface);
+		/* while iterating over all the ELP neighbors, find the smallest
+		 * ELP interval to use to schedule the next check
+		 */
+		if (tmp_interval < min_interval)
+			min_interval = tmp_interval;
+	}
+
+	/* if there are no more ELP neighbors the work does not need to be
+	 * rescheduled
+	 */
+	if (min_interval == UINT_MAX)
+		return;
+
+	atomic_set(&bat_priv->bat_v.neigh_interval, min_interval);
+	queue_delayed_work(batadv_event_workqueue, &bat_priv->bat_v.neigh_wq,
+			   msecs_to_jiffies(min_interval));
+}
+
+int batadv_v_elp_init(struct batadv_priv *bat_priv)
+{
+	INIT_DELAYED_WORK(&bat_priv->bat_v.neigh_wq, batadv_v_elp_check_neigh);
+	atomic_set(&bat_priv->bat_v.neigh_interval, UINT_MAX);
+
+	return 0;
+}
+
+void batadv_v_elp_free(struct batadv_priv *bat_priv)
+{
+	cancel_delayed_work_sync(&bat_priv->bat_v.neigh_wq);
+}
diff --git a/bat_v_elp.h b/bat_v_elp.h
index 4f34ecb..5dd0568 100644
--- a/bat_v_elp.h
+++ b/bat_v_elp.h
@@ -33,5 +33,7 @@ void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *hard_iface);
 int batadv_v_elp_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming);
 int batadv_v_elp_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_v_elp_init(struct batadv_priv *bat_priv);
+void batadv_v_elp_free(struct batadv_priv *bat_priv);
 
 #endif /* _NET_BATMAN_ADV_BAT_V_ELP_H_ */
diff --git a/types.h b/types.h
index 6f05d99..2ba27ab 100644
--- a/types.h
+++ b/types.h
@@ -748,6 +748,8 @@ struct batadv_priv_bat_v {
 	struct delayed_work ogm_wq;
 	atomic_t ogm_seqno;
 	atomic_t base_throughput;
+	atomic_t neigh_interval;
+	struct delayed_work neigh_wq;
 };
 
 /**
-- 
1.8.5.3

