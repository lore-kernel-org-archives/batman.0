Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:14 +0100
Message-Id: <1392122903-805-15-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 14/23] batman-adv: ELP - compute the metric
	based on the estimated throughput
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

Implement a stub get_throughput() function which returns the
estimated throughput towards a given neighbour.
Its result is then used to compute the metric value.

The metric is updated each time a new ELP packet is sent,
this way it is possible to timely react to a metric
variation which can imply (for example) a neighbour
disconnection.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_v_elp.c | 49 +++++++++++++++++++++++++++++++++++++++++++------
 types.h     |  2 ++
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/bat_v_elp.c b/bat_v_elp.c
index 4185d8c..ef4e476 100644
--- a/bat_v_elp.c
+++ b/bat_v_elp.c
@@ -53,6 +53,29 @@ void batadv_elp_neigh_node_free_ref(struct batadv_elp_neigh_node *neigh)
 }
 
 /**
+ * batadv_v_elp_get_throughput - get the throughput towards a neighbour
+ * @neigh: the neighbour for which the throughput has to be obtained
+ *
+ * Returns the throughput towards the given neighbour.
+ */
+static uint32_t
+batadv_v_elp_get_throughput(struct batadv_elp_neigh_node *neigh)
+{
+	struct batadv_hard_iface *hard_iface = neigh->hard_iface;
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	uint32_t throughput;
+
+	/* get the customised user value for the throughput */
+	throughput = atomic_read(&hard_iface->bat_v.user_throughput);
+	/* if the user specified a value, let's return it */
+	if (throughput != 0)
+		return throughput;
+
+	/* throughput cannot be computed right now. Return base value */
+	return atomic_read(&bat_priv->bat_v.base_throughput);
+}
+
+/**
  * batadv_v_elp_neigh_new - create a new ELP neighbour node
  * @hard_iface: the interface the neighbour is connected to
  * @neigh_addr: the neighbour interface address
@@ -75,6 +98,7 @@ batadv_v_elp_neigh_new(struct batadv_hard_iface *hard_iface,
 	memcpy(neigh->addr, neigh_addr, ETH_ALEN);
 	neigh->last_seen = jiffies;
 	ewma_init(&neigh->metric, 1024, 8);
+	neigh->hard_iface = hard_iface;
 	/* recount initialised to 2 to simplify the caller function */
 	atomic_set(&neigh->refcount, 2);
 
@@ -147,19 +171,20 @@ static void batadv_v_elp_neigh_purge(struct batadv_hard_iface *hard_iface)
 }
 
 /**
- * batadv_v_elp_send_outstanding - ELP periodic broadcast sending
+ * batadv_v_elp_periodic_work - ELP periodic task per interface
  * @work: work queue item
  *
- * Sends a broadcast ELP message over the interface that this work item belongs
- * to.
+ * Sends a broadcast ELP message and reads the metric for all the neighbours
+ * connected to the interface that this work item belongs to.
  */
-static void batadv_v_elp_send_outstanding(struct work_struct *work)
+static void batadv_v_elp_periodic_work(struct work_struct *work)
 {
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_hard_iface_bat_v *bat_v;
 	struct batadv_priv *bat_priv;
 	struct batadv_elp_packet *elp_packet;
 	uint32_t elp_interval;
+	struct batadv_elp_neigh_node *neigh;
 	struct sk_buff *skb;
 	uint8_t num_neighs;
 
@@ -181,7 +206,7 @@ static void batadv_v_elp_send_outstanding(struct work_struct *work)
 
 	skb = skb_copy(hard_iface->bat_v.elp_skb, GFP_ATOMIC);
 	if (!skb)
-		goto out;
+		goto update_metric;
 
 	/* purge outdated entries first */
 	batadv_v_elp_neigh_purge(hard_iface);
@@ -204,6 +229,17 @@ static void batadv_v_elp_send_outstanding(struct work_struct *work)
 
 	atomic_inc(&hard_iface->bat_v.elp_seqno);
 
+update_metric:
+	/* Instead of updating the metric each "received" ELP packet, it is
+	 * better to do it on each ELP sending. This way, if a node is dead and
+	 * does not send packets anymore, batman-adv is still able to timely
+	 * react to its death.
+	 */
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(neigh, &hard_iface->bat_v.neigh_list, list)
+		ewma_add(&neigh->metric, batadv_v_elp_get_throughput(neigh));
+	rcu_read_unlock();
+
 restart_timer:
 	batadv_v_elp_start_timer(hard_iface);
 out:
@@ -247,7 +283,7 @@ int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 	atomic_set(&hard_iface->bat_v.elp_interval, 500);
 
 	INIT_DELAYED_WORK(&hard_iface->bat_v.elp_wq,
-			  batadv_v_elp_send_outstanding);
+			  batadv_v_elp_periodic_work);
 	batadv_v_elp_start_timer(hard_iface);
 	res = 0;
 
@@ -332,6 +368,7 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 
 	neigh->last_seen = jiffies;
 	neigh->last_recv_seqno = ntohl(elp_packet->seqno);
+	ewma_add(&neigh->metric, batadv_v_elp_get_throughput(neigh));
 
 out:
 	if (neigh)
diff --git a/types.h b/types.h
index 54fae29..948d5dc 100644
--- a/types.h
+++ b/types.h
@@ -345,6 +345,7 @@ struct batadv_gw_node {
  * @last_unicast_tx: when the last unicast packet has been sent to this neighbor
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
+ * @hard_iface: the interface where this neighbor is connected to
  */
 struct batadv_elp_neigh_node {
 	struct hlist_node list;
@@ -357,6 +358,7 @@ struct batadv_elp_neigh_node {
 	unsigned long last_unicast_tx;
 	atomic_t refcount;
 	struct rcu_head rcu;
+	struct batadv_hard_iface *hard_iface;
 };
 
 /**
-- 
1.8.5.3

