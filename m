Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:16 +0100
Message-Id: <1392122903-805-17-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 16/23] batman-adv: ELP - read estimated
	throughput from cfg80211
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

In case of wireless interface retrieve the throughput by
querying cfg80211. To perform this call a separate work
must be scheduled because the function may sleep and this
is not allowed within an RCU protected context (RCU in this
case is used to iterate over all the neighbours).

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_v_elp.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 compat.h    | 20 ++++++++++++++++++++
 types.h     |  2 ++
 3 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/bat_v_elp.c b/bat_v_elp.c
index 14a1e15..31190af 100644
--- a/bat_v_elp.c
+++ b/bat_v_elp.c
@@ -18,6 +18,8 @@
  *
  */
 
+#include <net/cfg80211.h>
+
 #include "main.h"
 #include "hard-interface.h"
 #include "send.h"
@@ -64,19 +66,56 @@ batadv_v_elp_get_throughput(struct batadv_elp_neigh_node *neigh)
 {
 	struct batadv_hard_iface *hard_iface = neigh->hard_iface;
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct station_info sinfo;
 	uint32_t throughput;
+	int r;
 
-	/* get the customised user value for the throughput */
-	throughput = atomic_read(&hard_iface->bat_v.user_throughput);
-	/* if the user specified a value, let's return it */
+	/* if the user specified a customised value for this interface, then
+	 * return it directly
+	 */
+	throughput =  atomic_read(&hard_iface->bat_v.user_throughput);
 	if (throughput != 0)
 		return throughput;
 
-	/* throughput cannot be computed right now. Return base value */
+	/* if this is a wireless device, then ask its throughput through
+	 * cfg80211 API
+	 */
+	if (hard_iface->net_dev->ieee80211_ptr) {
+		r = cfg80211_get_station(hard_iface->net_dev, neigh->addr,
+					 &sinfo);
+		if (r == -ENOENT) {
+			/* node is not associated anymore! it would be possible
+			 * to delete this neighbor. for now set metric to 0
+			 */
+			return 0;
+		}
+		if (!r)
+			return sinfo.expected_throughput;
+	}
+
+	/* if none of the above cases apply, return the base_throughput */
 	return atomic_read(&bat_priv->bat_v.base_throughput);
 }
 
 /**
+ * batadv_v_elp_metric_update - worker updating the metric of one neighbour
+ * @work: the work queue item
+ */
+static void batadv_v_elp_metric_update(struct work_struct *work)
+{
+	struct batadv_elp_neigh_node *neigh;
+
+	neigh = container_of(work, struct batadv_elp_neigh_node, metric_work);
+
+	ewma_add(&neigh->metric, batadv_v_elp_get_throughput(neigh));
+
+	/* decrement refcounter to balance increment performed before scheduling
+	 * this task
+	 */
+	batadv_elp_neigh_node_free_ref(neigh);
+}
+
+/**
  * batadv_v_elp_neigh_new - create a new ELP neighbour node
  * @hard_iface: the interface the neighbour is connected to
  * @neigh_addr: the neighbour interface address
@@ -108,6 +147,8 @@ batadv_v_elp_neigh_new(struct batadv_hard_iface *hard_iface,
 	spin_unlock_bh(&hard_iface->bat_v.neigh_list_lock);
 	atomic_inc(&hard_iface->bat_v.num_neighbors);
 
+	INIT_WORK(&neigh->metric_work, batadv_v_elp_metric_update);
+
 	return neigh;
 }
 
@@ -192,7 +233,7 @@ static int batadv_v_elp_wifi_neigh_probe(struct batadv_hard_iface *hard_iface,
 	int probe_len, i;
 
 	/* this probing routine is for Wifi neighbours only */
-	if (batadv_is_wifi_netdev(hard_iface->net_dev))
+	if (!batadv_is_wifi_netdev(hard_iface->net_dev))
 		return 0;
 
 	/* probe the neighbor only if no unicast packets have been sent
@@ -310,7 +351,14 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 			 */
 			break;
 
-		ewma_add(&neigh->metric, batadv_v_elp_get_throughput(neigh));
+		if (!atomic_inc_not_zero(&neigh->refcount))
+			continue;
+
+		/* reading the estimated throughput from cfg80211 is a task that
+		 * may sleep and that is not allowed in an rcu protected
+		 * context. Therefore schedule a task for that.
+		 */
+		queue_work(batadv_event_workqueue, &neigh->metric_work);
 	}
 	rcu_read_unlock();
 
@@ -442,7 +490,6 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 
 	neigh->last_seen = jiffies;
 	neigh->last_recv_seqno = ntohl(elp_packet->seqno);
-	ewma_add(&neigh->metric, batadv_v_elp_get_throughput(neigh));
 
 out:
 	if (neigh)
diff --git a/compat.h b/compat.h
index 12bc8d8..9f71f51 100644
--- a/compat.h
+++ b/compat.h
@@ -407,4 +407,24 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 14, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 15, 0)
+
+/* NOTE: shall I put this ifndef outside of every #if block ? */
+#ifndef cfg80211_get_station
+
+/* the expected behaviour of this function is to return 0 on success, therefore
+ * it is possible to define it as 1 so that batman-adv thinks like something
+ * went wrong. It will then decide what to do.
+ */
+#define cfg80211_get_station(_a, _b, _c) (1)
+/* the following define substitute the expected_throughput field with a random
+ * one existing in the station_info struct. It can be random because due to the
+ * define above it will never be used. We need it only to make the code compile
+ */
+#define expected_throughput filled
+
+#endif /* cfg80211_get_station */
+
+#endif /* < KERNEL_VERSION(3, 15, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/types.h b/types.h
index 948d5dc..6f05d99 100644
--- a/types.h
+++ b/types.h
@@ -346,6 +346,7 @@ struct batadv_gw_node {
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  * @hard_iface: the interface where this neighbor is connected to
+ * @metric_work: work queue callback item for metric update
  */
 struct batadv_elp_neigh_node {
 	struct hlist_node list;
@@ -359,6 +360,7 @@ struct batadv_elp_neigh_node {
 	atomic_t refcount;
 	struct rcu_head rcu;
 	struct batadv_hard_iface *hard_iface;
+	struct work_struct metric_work;
 };
 
 /**
-- 
1.8.5.3

