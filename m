Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:04 +0100
Message-Id: <1392122903-805-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 04/23] batman-adv: ELP - creating neighbor
	structures
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <antonio@open-mesh.com>

From: Linus Luessing <linus.luessing@web.de>

Initially developed by Linus during a 6 months trainee study
period in Ascom (Switzerland) AG.

Signed-off-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_v.c     |  18 +++++-
 bat_v_elp.c | 204 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 bat_v_elp.h |   6 ++
 main.h      |   2 +
 types.h     |  53 ++++++++++++++++
 5 files changed, 281 insertions(+), 2 deletions(-)

diff --git a/bat_v.c b/bat_v.c
index 7247d7f..bed5e00 100644
--- a/bat_v.c
+++ b/bat_v.c
@@ -61,5 +61,21 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 
 int __init batadv_v_init(void)
 {
-	return batadv_algo_register(&batadv_batman_v);
+	int ret;
+
+	/* batman v echo location protocol packet  */
+	ret = batadv_recv_handler_register(BATADV_ELP,
+					   batadv_v_elp_packet_recv);
+	if (ret < 0)
+		goto elp_unregister;
+
+	ret = batadv_algo_register(&batadv_batman_v);
+
+	return ret;
+
+elp_unregister:
+	if (ret < 0)
+		batadv_recv_handler_unregister(BATADV_ELP);
+
+	return ret;
 }
diff --git a/bat_v_elp.c b/bat_v_elp.c
index 45b082b..ee4207d 100644
--- a/bat_v_elp.c
+++ b/bat_v_elp.c
@@ -23,6 +23,8 @@
 #include "send.h"
 #include "bat_algo.h"
 #include "bat_v_elp.h"
+#include "originator.h"
+#include "routing.h"
 
 /**
  * batadv_v_elp_start_timer - restart timer for ELP periodic work
@@ -40,6 +42,111 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 }
 
 /**
+ * batadv_elp_neigh_node_free_ref - release a ELP neighbour node
+ * @neigh: the neighbour object to release
+ */
+void batadv_elp_neigh_node_free_ref(struct batadv_elp_neigh_node *neigh)
+{
+	if (atomic_dec_and_test(&neigh->refcount))
+		kfree_rcu(neigh, rcu);
+}
+
+/**
+ * batadv_v_elp_neigh_new - create a new ELP neighbour node
+ * @hard_iface: the interface the neighbour is connected to
+ * @neigh_addr: the neighbour interface address
+ * @orig_addr: the neighbour originator address
+ * @seqno: the received sequence number to be used to initialize the object
+ *
+ * Returns a new ELP neighbour node or NULL in case of failure.
+ */
+static struct batadv_elp_neigh_node *
+batadv_v_elp_neigh_new(struct batadv_hard_iface *hard_iface,
+		       uint8_t *neigh_addr, uint8_t *orig_addr, uint32_t seqno)
+{
+	struct batadv_elp_neigh_node *neigh;
+
+	neigh = kzalloc(sizeof(*neigh), GFP_ATOMIC);
+	if (!neigh)
+		return NULL;
+
+	memcpy(neigh->orig, orig_addr, ETH_ALEN);
+	memcpy(neigh->addr, neigh_addr, ETH_ALEN);
+	neigh->last_recv_seqno = seqno - 1;
+	neigh->last_seen = jiffies;
+	ewma_init(&neigh->metric, 1024, 8);
+	/* recount initialised to 2 to simplify the caller function */
+	atomic_set(&neigh->refcount, 2);
+
+	spin_lock_bh(&hard_iface->bat_v.neigh_list_lock);
+	hlist_add_head_rcu(&neigh->list, &hard_iface->bat_v.neigh_list);
+	spin_unlock_bh(&hard_iface->bat_v.neigh_list_lock);
+	atomic_inc(&hard_iface->bat_v.num_neighbors);
+
+	return neigh;
+}
+
+/**
+ * batadv_v_elp_neigh_get - retrieve an ELP neighbour node
+ * @hard_iface: the interface this neighbour is connected to
+ * @neigh_addr: the interface address of the neighbour to retrieve
+ *
+ * Returns the ELP neighbour node if found or NULL otherwise.
+ */
+struct batadv_elp_neigh_node *
+batadv_v_elp_neigh_get(struct batadv_hard_iface *hard_iface,
+		       uint8_t *neigh_addr)
+{
+	struct batadv_elp_neigh_node *neigh = NULL, *neigh_tmp;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(neigh_tmp,
+				 &hard_iface->bat_v.neigh_list, list) {
+		if (!batadv_compare_eth(neigh_tmp->addr, neigh_addr))
+			continue;
+
+		if (!atomic_inc_not_zero(&neigh_tmp->refcount))
+			continue;
+
+		neigh = neigh_tmp;
+		break;
+	}
+	rcu_read_unlock();
+
+	return neigh;
+}
+
+/**
+ * batadv_v_elp_neigh_purge - purge obsolete neighbour nodes
+ *
+ * Deletes the ELP neighbour nodes that did not send any ELP message for a
+ * pre-defined amount of time.
+ */
+static void batadv_v_elp_neigh_purge(struct batadv_hard_iface *hard_iface)
+{
+	unsigned long timeout;
+	struct batadv_elp_neigh_node *neigh;
+	struct hlist_node *node;
+	bool has_timed_out;
+
+	spin_lock_bh(&hard_iface->bat_v.neigh_list_lock);
+	hlist_for_each_entry_safe(neigh, node, &hard_iface->bat_v.neigh_list,
+				  list) {
+		timeout = neigh->elp_interval * BATADV_ELP_OUTDATED_MAX;
+		has_timed_out = batadv_has_timed_out(neigh->last_seen, timeout);
+
+		if ((!has_timed_out) &&
+		    (hard_iface->if_status == BATADV_IF_ACTIVE))
+			continue;
+
+		hlist_del_rcu(&neigh->list);
+		atomic_dec(&hard_iface->bat_v.num_neighbors);
+		batadv_elp_neigh_node_free_ref(neigh);
+	}
+	spin_unlock_bh(&hard_iface->bat_v.neigh_list_lock);
+}
+
+/**
  * batadv_v_elp_send_outstanding - ELP periodic broadcast sending
  * @work: work queue item
  *
@@ -54,6 +161,7 @@ static void batadv_v_elp_send_outstanding(struct work_struct *work)
 	struct batadv_elp_packet *elp_packet;
 	uint32_t elp_interval;
 	struct sk_buff *skb;
+	uint8_t num_neighs;
 
 	bat_v = container_of(work, struct batadv_hard_iface_bat_v, elp_wq.work);
 	hard_iface = container_of(bat_v, struct batadv_hard_iface, bat_v);
@@ -75,9 +183,15 @@ static void batadv_v_elp_send_outstanding(struct work_struct *work)
 	if (!skb)
 		goto out;
 
+	/* purge outdated entries first */
+	batadv_v_elp_neigh_purge(hard_iface);
+
 	elp_packet = (struct batadv_elp_packet *)skb->data;
 	elp_packet->seqno = htonl(atomic_read(&hard_iface->bat_v.elp_seqno));
-	elp_packet->num_neighbors = 0;
+
+	num_neighs = atomic_read(&hard_iface->bat_v.num_neighbors);
+	elp_packet->num_neighbors = num_neighs;
+
 	elp_interval = atomic_read(&hard_iface->bat_v.elp_interval);
 	elp_packet->elp_interval = htonl(elp_interval);
 
@@ -110,6 +224,9 @@ int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface)
 	size_t size;
 	int res = -ENOMEM;
 
+	INIT_HLIST_HEAD(&hard_iface->bat_v.neigh_list);
+	spin_lock_init(&hard_iface->bat_v.neigh_list_lock);
+
 	size = ETH_HLEN + NET_IP_ALIGN + BATADV_ELP_HLEN;
 	hard_iface->bat_v.elp_skb = dev_alloc_skb(size);
 	if (!hard_iface->bat_v.elp_skb)
@@ -148,6 +265,8 @@ void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface)
 
 	dev_kfree_skb(hard_iface->bat_v.elp_skb);
 	hard_iface->bat_v.elp_skb = NULL;
+
+	batadv_v_elp_neigh_purge(hard_iface);
 }
 
 /**
@@ -177,3 +296,86 @@ void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *hard_iface)
 	}
 	rcu_read_unlock();
 }
+
+/**
+ * batadv_v_elp_neigh_update - update an ELP neighbour node
+ * @bat_priv: the bat priv with all the soft interface information
+ * @neigh_addr: the neighbour interface address
+ * @if_incoming: the interface the packet was received through
+ * @elp_packet: the received ELP packet
+ *
+ * Updates the ELP neighbour node state with the data received within the new
+ * ELP packet.
+ */
+static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
+				      uint8_t *neigh_addr,
+				      struct batadv_hard_iface *if_incoming,
+				      struct batadv_elp_packet *elp_packet)
+{
+	struct batadv_elp_neigh_node *neigh;
+
+	neigh = batadv_v_elp_neigh_get(if_incoming, neigh_addr);
+	if (!neigh) {
+		neigh = batadv_v_elp_neigh_new(if_incoming, neigh_addr,
+					       elp_packet->orig,
+					       ntohl(elp_packet->seqno));
+		if (!neigh)
+			goto out;
+	}
+
+	neigh->last_seen = jiffies;
+
+out:
+	if (neigh)
+		batadv_elp_neigh_node_free_ref(neigh);
+}
+
+/**
+ * batadv_v_elp_packet_recv - main ELP packet handler
+ * @skb: the received packet
+ * @if_incoming: the interface this packet was received through
+ *
+ * Returns NET_RX_SUCCESS and consumes the skb if the packet was peoperly
+ * processed or NET_RX_DROP in case of failure.
+ */
+int batadv_v_elp_packet_recv(struct sk_buff *skb,
+			     struct batadv_hard_iface *if_incoming)
+{
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_elp_packet *elp_packet;
+	struct batadv_hard_iface *primary_if;
+	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	bool ret;
+
+	ret = batadv_check_management_packet(skb, if_incoming, BATADV_ELP_HLEN);
+	if (!ret)
+		return NET_RX_DROP;
+
+	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
+		return NET_RX_DROP;
+
+	/* did we receive a B.A.T.M.A.N. V ELP packet on an interface
+	 * that does not have B.A.T.M.A.N. V ELP enabled ? */
+	if (strcmp(bat_priv->bat_algo_ops->name, "BATMAN_V") != 0)
+		return NET_RX_DROP;
+
+	elp_packet = (struct batadv_elp_packet *)skb->data;
+
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "Received ELP packet from %pM seqno %u ORIG: %pM\n",
+		   ethhdr->h_source, ntohl(elp_packet->seqno),
+		   elp_packet->orig);
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
+
+	batadv_v_elp_neigh_update(bat_priv, ethhdr->h_source, if_incoming,
+				  elp_packet);
+
+out:
+	if (primary_if)
+		batadv_hardif_free_ref(primary_if);
+	consume_skb(skb);
+	return NET_RX_SUCCESS;
+}
diff --git a/bat_v_elp.h b/bat_v_elp.h
index 06d2cb1..186ff4b 100644
--- a/bat_v_elp.h
+++ b/bat_v_elp.h
@@ -23,8 +23,14 @@
 #ifndef _NET_BATMAN_ADV_BAT_V_ELP_H_
 #define _NET_BATMAN_ADV_BAT_V_ELP_H_
 
+struct batadv_elp_neigh_node *
+batadv_v_elp_neigh_get(struct batadv_hard_iface *hard_iface,
+		       uint8_t *neigh_addr);
+void batadv_elp_neigh_node_free_ref(struct batadv_elp_neigh_node *neigh);
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface);
 void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface);
 void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *hard_iface);
+int batadv_v_elp_packet_recv(struct sk_buff *skb,
+			     struct batadv_hard_iface *if_incoming);
 
 #endif /* _NET_BATMAN_ADV_BAT_V_ELP_H_ */
diff --git a/main.h b/main.h
index 34e85a2..4ab3216 100644
--- a/main.h
+++ b/main.h
@@ -45,6 +45,7 @@
 #define BATADV_TT_WORK_PERIOD 5000 /* 5 seconds */
 #define BATADV_ORIG_WORK_PERIOD 1000 /* 1 second */
 #define BATADV_DAT_ENTRY_TIMEOUT (5*60000) /* 5 mins in milliseconds */
+#define BATADV_ELP_OUTDATED_MAX 4
 /* sliding packet range of received originator messages in sequence numbers
  * (should be a multiple of our word size)
  */
@@ -180,6 +181,7 @@ enum batadv_uev_type {
 #include <linux/jiffies.h>
 #include <linux/seq_file.h>
 #include <linux/if_vlan.h>
+#include <linux/average.h>	/* ewma */
 #include "compat.h"
 
 #include "types.h"
diff --git a/types.h b/types.h
index 518fa81..be230b6 100644
--- a/types.h
+++ b/types.h
@@ -73,12 +73,18 @@ struct batadv_hard_iface_bat_iv {
  * struct batadv_hard_iface_bat_v - per hard interface B.A.T.M.A.N. V data
  * @elp_interval: time interval between two ELP transmissions
  * @elp_seqno: current ELP sequence number
+ * @neigh_list: list of ELP neighbour objects
+ * @neigh_list_lock: protects neigh_list
+ * @num_neighbours: number of neighbours in the neigh_list
  * @elp_skb: base skb containing the ELP message to send
  * @elp_wq: workqueue used to schedule ELP transmissions
  */
 struct batadv_hard_iface_bat_v {
 	atomic_t elp_interval;
 	atomic_t elp_seqno;
+	struct hlist_head neigh_list;
+	spinlock_t neigh_list_lock;
+	atomic_t num_neighbors;
 	struct sk_buff *elp_skb;
 	struct delayed_work elp_wq;
 };
@@ -327,6 +333,37 @@ struct batadv_gw_node {
 };
 
 /**
+ * struct batadv_elp_neigh - hard_iface ralated neighbor information
+ * @list: list node for batadv_hard_iface::neigh_list
+ * @orig: the MAC address of the corresponding orig_node
+ * @addr: the MAC address of the neighboring interface
+ * @metric: ewma link metric towards this neighbor
+ * @last_recv_seqno: last ELP received sequence number
+ * @lest_seen: last time this neigh has been seen
+ * @refcount: number of contexts the object is used
+ * @rcu: struct used for freeing in an RCU-safe manner
+ */
+struct batadv_elp_neigh_node {
+	struct hlist_node list;
+	uint8_t orig[ETH_ALEN];
+	uint8_t addr[ETH_ALEN];
+	struct ewma metric;
+	uint32_t last_recv_seqno;
+	unsigned long last_seen;
+	uint32_t elp_interval;
+	atomic_t refcount;
+	struct rcu_head rcu;
+};
+
+/**
+ * batadv_neigh_node_bat_v - B.A.T.M.A.N. V private neighbor information
+ * @elp_neigh: ELP private neighbour data
+ */
+struct batadv_neigh_node_bat_v {
+	struct batadv_elp_neigh_node *elp_neigh;
+};
+
+/**
  * struct batadv_neigh_node - structure for single hops neighbors
  * @list: list node for batadv_orig_node::neigh_list
  * @orig_node: pointer to corresponding orig_node
@@ -336,6 +373,7 @@ struct batadv_gw_node {
  * @if_incoming: pointer to incoming hard interface
  * @last_seen: when last packet via this neighbor was received
  * @last_ttl: last received ttl from this neigh node
+ * @elp_neigh: ELP private neighbour data
  * @rcu: struct used for freeing in an RCU-safe manner
  * @bat_iv: B.A.T.M.A.N. IV private structure
  */
@@ -347,6 +385,9 @@ struct batadv_neigh_node {
 	spinlock_t ifinfo_lock;	/* protects ifinfo_list and its members */
 	struct batadv_hard_iface *if_incoming;
 	unsigned long last_seen;
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	struct batadv_neigh_node_bat_v bat_v;
+#endif
 	atomic_t refcount;
 	struct rcu_head rcu;
 };
@@ -370,6 +411,15 @@ struct batadv_neigh_ifinfo_bat_iv {
 };
 
 /**
+ * struct batadv_neigh_ifinfo_bat_v - neighbor information per outgoing
+ *  interface for BATMAN V
+ * @metric: last metric received from an originator via this neigh
+ */
+struct batadv_neigh_ifinfo_bat_v {
+	uint32_t metric;
+};
+
+/**
  * struct batadv_neigh_ifinfo - neighbor information per outgoing interface
  * @list: list node for batadv_neigh_node::ifinfo_list
  * @if_outgoing: pointer to outgoing hard interface
@@ -382,6 +432,9 @@ struct batadv_neigh_ifinfo {
 	struct hlist_node list;
 	struct batadv_hard_iface *if_outgoing;
 	struct batadv_neigh_ifinfo_bat_iv bat_iv;
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	struct batadv_neigh_ifinfo_bat_v bat_v;
+#endif
 	uint8_t last_ttl;
 	atomic_t refcount;
 	struct rcu_head rcu;
-- 
1.8.5.3

