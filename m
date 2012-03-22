Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 22 Mar 2012 22:51:12 +0100
Message-Id: <1332453075-27999-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [RFC 2/5] batman-adv: ELP - creating neighbor
	structures, updating LQs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

From: Linus Luessing <linus.luessing@web.de>

Developed by Linus during a 6 months trainee study period in Ascom (Switzerland)
AG.

Signed-off-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_v_elp.c |  255 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 packet.h    |    6 ++
 types.h     |    8 ++
 3 files changed, 267 insertions(+), 2 deletions(-)

diff --git a/bat_v_elp.c b/bat_v_elp.c
index c2dee5c..e252c04 100644
--- a/bat_v_elp.c
+++ b/bat_v_elp.c
@@ -23,6 +23,8 @@
 #include "hard-interface.h"
 #include "send.h"
 #include "bat_algo.h"
+#include "originator.h"
+#include "routing.h"
 
 static void bat_v_elp_start_timer(struct hard_iface *hard_iface)
 {
@@ -35,12 +37,78 @@ static void bat_v_elp_start_timer(struct hard_iface *hard_iface)
 			   &hard_iface->elp_wq, elp_interval);
 }
 
+static struct neigh_node *bat_v_elp_neigh_new(struct hard_iface *hard_iface,
+					      uint8_t *neigh_addr,
+					      uint32_t seqno)
+{
+	struct neigh_node *neigh_node;
+
+	neigh_node = neigh_node_new(hard_iface, neigh_addr, seqno);
+	if (!neigh_node)
+		goto out;
+
+	neigh_node->last_recv_seqno = seqno - 1;
+
+	spin_lock_bh(&hard_iface->neigh_list_lock);
+	hlist_add_head_rcu(&neigh_node->list, &hard_iface->neigh_list);
+	spin_unlock_bh(&hard_iface->neigh_list_lock);
+
+out:
+	return neigh_node;
+}
+
+static struct neigh_node *bat_v_elp_neigh_get(struct hard_iface *hard_iface,
+					      uint8_t *neigh_addr)
+{
+	struct neigh_node *neigh_node = NULL, *neigh_node_tmp;
+	struct hlist_node *node;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(neigh_node_tmp, node,
+				 &hard_iface->neigh_list, list) {
+		if (!compare_eth(neigh_node_tmp->addr, neigh_addr))
+			continue;
+
+		if (!atomic_inc_not_zero(&neigh_node_tmp->refcount))
+			continue;
+
+		neigh_node = neigh_node_tmp;
+		break;
+	}
+	rcu_read_unlock();
+
+	return neigh_node;
+}
+
+static void bat_v_elp_neigh_purge(struct hard_iface *hard_iface)
+{
+	struct neigh_node *neigh_node;
+	struct hlist_node *node, *node_tmp;
+
+	spin_lock_bh(&hard_iface->neigh_list_lock);
+	hlist_for_each_entry_safe(neigh_node, node, node_tmp,
+				  &hard_iface->neigh_list, list) {
+
+		if ((!has_timed_out(neigh_node->last_seen, PURGE_TIMEOUT)) &&
+		    (hard_iface->if_status == IF_ACTIVE))
+			continue;
+
+		hlist_del_rcu(&neigh_node->list);
+		neigh_node_free_ref(neigh_node);
+	}
+	spin_unlock_bh(&hard_iface->neigh_list_lock);
+}
+
 static void bat_v_elp_send_outstanding(struct work_struct *work)
 {
 	struct hard_iface *hard_iface;
 	struct bat_priv *bat_priv;
 	struct batman_elp_packet *elp_packet;
+	struct elp_neigh_entry *elp_neigh_entry;
+	struct neigh_node *neigh_node;
+	struct hlist_node *node;
 	struct sk_buff *skb;
+	unsigned int max_len;
 
 	hard_iface = container_of(work, struct hard_iface, elp_wq.work);
 	bat_priv = netdev_priv(hard_iface->soft_iface);
@@ -48,6 +116,7 @@ static void bat_v_elp_send_outstanding(struct work_struct *work)
 	if (atomic_read(&bat_priv->mesh_state) == MESH_DEACTIVATING)
 		goto out;
 
+	/* we are in the process of shutting this interface down */
 	if ((hard_iface->if_status == IF_NOT_IN_USE) ||
 	    (hard_iface->if_status == IF_TO_BE_REMOVED))
 		goto out;
@@ -56,14 +125,40 @@ static void bat_v_elp_send_outstanding(struct work_struct *work)
 	if (hard_iface->if_status != IF_ACTIVE)
 		goto restart_timer;
 
+	max_len = min_t(unsigned int, ETH_DATA_LEN, hard_iface->net_dev->mtu);
+
 	skb = skb_copy(hard_iface->elp_skb, GFP_ATOMIC);
 	if (!skb)
 		goto out;
 
+	/* purge outdated entries first */
+	bat_v_elp_neigh_purge(hard_iface);
+
 	elp_packet = (struct batman_elp_packet *)skb->data;
 	elp_packet->seqno = htonl(atomic_read(&hard_iface->elp_seqno));
 	elp_packet->num_neighbors = 0;
 
+	elp_neigh_entry = (struct elp_neigh_entry *)(elp_packet + 1);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(neigh_node, node,
+				 &hard_iface->neigh_list, list) {
+		if (skb->len + sizeof(struct elp_neigh_entry) > max_len) {
+			if (printk_ratelimit())
+				bat_err(hard_iface->net_dev,
+					"Skipping ELP neigh entries: "
+					"packet length exhausted\n");
+			break;
+		}
+
+		memcpy(elp_neigh_entry->addr, neigh_node->addr, ETH_ALEN);
+		elp_neigh_entry->rq = neigh_node->rq;
+		elp_packet->num_neighbors++;
+		elp_neigh_entry++;
+		skb_put(skb, sizeof(struct elp_neigh_entry));
+	}
+	rcu_read_unlock();
+
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Sending elp packet on interface %s, seqno %d\n",
 		hard_iface->net_dev->name, atomic_read(&hard_iface->elp_seqno));
@@ -71,8 +166,9 @@ static void bat_v_elp_send_outstanding(struct work_struct *work)
 	send_skb_packet(skb, hard_iface, broadcast_addr);
 
 	atomic_inc(&hard_iface->elp_seqno);
-	bat_v_elp_start_timer(hard_iface);
 
+restart_timer:
+	bat_v_elp_start_timer(hard_iface);
 out:
 	return;
 }
@@ -117,6 +213,8 @@ static void bat_v_elp_iface_disable(struct hard_iface *hard_iface)
 
 	dev_kfree_skb(hard_iface->elp_skb);
 	hard_iface->elp_skb = NULL;
+
+	bat_v_elp_neigh_purge(hard_iface);
 }
 
 static void bat_v_elp_iface_update_mac(struct hard_iface *hard_iface)
@@ -158,6 +256,143 @@ static void bat_v_ogm_emit(struct forw_packet *forw_packet)
 	return;
 }
 
+/* extract my own tq to neighbor from the elp packet */
+static uint8_t bat_v_elp_fetch_tq(uint8_t *my_iface_addr,
+				  struct batman_elp_packet *elp_packet,
+				  int elp_packet_len)
+{
+	struct elp_neigh_entry *elp_neigh_entry;
+	uint8_t tq = 0;
+	int i;
+
+	elp_neigh_entry = (struct elp_neigh_entry *)(elp_packet + 1);
+	elp_packet_len -= BATMAN_ELP_HLEN;
+
+	for (i = 0; i < elp_packet->num_neighbors; i++) {
+		if (!compare_eth(my_iface_addr, elp_neigh_entry->addr))
+			goto next;
+
+		tq = elp_neigh_entry->rq;
+		break;
+
+	next:
+		elp_packet_len -= sizeof(struct elp_neigh_entry);
+		if (elp_packet_len < 0)
+			break;
+
+		elp_neigh_entry++;
+	}
+
+	return tq;
+}
+
+static void bat_v_elp_neigh_update_lq(struct hard_iface *hard_iface,
+				      struct neigh_node *neigh_node,
+				      uint8_t my_tq, uint32_t seqno)
+{
+	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	int32_t seq_diff;
+	int neigh_packet_count;
+	bool is_new_seqno;
+
+	seq_diff = seqno - neigh_node->last_recv_seqno;
+
+	is_new_seqno = bit_get_packet(bat_priv, neigh_node->elp_rq_bits,
+				      seq_diff, 1);
+	if (!is_new_seqno)
+		return;
+
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"Updating last_seqno of neighbor %pM: old %d, new %d\n",
+		neigh_node->addr, neigh_node->last_recv_seqno, seqno);
+
+	/***
+	 * we only update the tq/last seen/last seqno fields upon
+	 * receival of a newer ELP sequence number
+	 */
+	neigh_node->tq = my_tq;
+	neigh_node->last_seen = jiffies;
+	neigh_node->last_recv_seqno = seqno;
+
+	neigh_packet_count = bitmap_weight(neigh_node->elp_rq_bits,
+					   TQ_LOCAL_WINDOW_SIZE);
+	neigh_node->rq = (neigh_packet_count * TQ_MAX_VALUE) /
+							TQ_LOCAL_WINDOW_SIZE;
+
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"New rq/tq of neighbor %pM: rq %d, tq %d\n",
+		neigh_node->addr, neigh_node->rq, neigh_node->tq);
+}
+
+void bat_v_elp_neigh_update(uint8_t *neigh_addr,
+			    struct hard_iface *if_incoming,
+			    struct batman_elp_packet *elp_packet,
+			    int elp_packet_len)
+{
+	struct neigh_node *neigh_node;
+	uint8_t my_tq;
+
+	neigh_node = bat_v_elp_neigh_get(if_incoming, neigh_addr);
+	if (!neigh_node) {
+		neigh_node = bat_v_elp_neigh_new(if_incoming, neigh_addr,
+						 elp_packet->seqno);
+		if (!neigh_node)
+			goto out;
+	}
+
+	my_tq = bat_v_elp_fetch_tq(if_incoming->net_dev->dev_addr,
+				   elp_packet, elp_packet_len);
+
+	spin_lock_bh(&neigh_node->lq_update_lock);
+	bat_v_elp_neigh_update_lq(if_incoming, neigh_node,
+				  my_tq, elp_packet->seqno);
+	spin_unlock_bh(&neigh_node->lq_update_lock);
+
+out:
+	if (neigh_node)
+		neigh_node_free_ref(neigh_node);
+}
+
+static int bat_v_elp_packet_recv(struct sk_buff *skb,
+				 struct hard_iface *if_incoming)
+{
+	struct bat_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batman_elp_packet *elp_packet;
+	struct hard_iface *primary_if;
+	struct ethhdr *ethhdr;
+	bool ret;
+
+	ret = check_management_packet(skb, if_incoming, BATMAN_ELP_HLEN);
+	if (!ret)
+		return NET_RX_DROP;
+
+	/* did we receive a B.A.T.M.A.N. V ELP packet on an interface
+	 * that does not have B.A.T.M.A.N. V ELP enabled ? */
+	if (bat_priv->bat_algo_ops->bat_ogm_emit != bat_v_ogm_emit)
+		return NET_RX_DROP;
+
+	primary_if = primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
+
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	elp_packet = (struct batman_elp_packet *)skb->data;
+
+	/* our own ELP packet */
+	if (compare_eth(primary_if->net_dev->dev_addr, elp_packet->orig))
+		goto out;
+
+	elp_packet->seqno = ntohl(elp_packet->seqno);
+
+	bat_v_elp_neigh_update(ethhdr->h_source, if_incoming,
+			       elp_packet, skb_headlen(skb));
+
+out:
+	if (primary_if)
+		hardif_free_ref(primary_if);
+	dev_kfree_skb(skb);
+	return NET_RX_SUCCESS;
+}
 
 static struct bat_algo_ops batman_v __read_mostly = {
 	.name = "BATMAN V",
@@ -171,5 +406,21 @@ static struct bat_algo_ops batman_v __read_mostly = {
 
 int __init bat_v_init(void)
 {
-	return bat_algo_register(&batman_v);
+	int ret;
+
+	/* batman v echo location protocol packet  */
+	ret = recv_handler_register(BAT_V_ELP, bat_v_elp_packet_recv);
+	if (ret < 0)
+		goto out;
+
+	ret = bat_algo_register(&batman_v);
+	if (ret < 0)
+		goto handler_unregister;
+
+	goto out;
+
+handler_unregister:
+	recv_handler_unregister(BAT_V_ELP);
+out:
+	return ret;
 }
diff --git a/packet.h b/packet.h
index cf516dc..ea1683f 100644
--- a/packet.h
+++ b/packet.h
@@ -148,6 +148,12 @@ struct batman_elp_packet {
 
 #define BATMAN_ELP_HLEN sizeof(struct batman_elp_packet)
 
+struct elp_neigh_entry {
+	uint8_t addr[ETH_ALEN];
+	uint8_t rq;
+	uint8_t align;
+} __attribute__((packed));
+
 struct icmp_packet {
 	struct batman_header header;
 	uint8_t  msg_type; /* see ICMP message types above */
diff --git a/types.h b/types.h
index 86f2250..abe27dd 100644
--- a/types.h
+++ b/types.h
@@ -61,6 +61,8 @@ struct hard_iface {
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	atomic_t elp_interval;
 	atomic_t elp_seqno;
+	struct hlist_head neigh_list;
+	spinlock_t neigh_list_lock;
 	struct sk_buff *elp_skb;
 	struct delayed_work elp_wq;
 #endif /* CONFIG_BATMAN_ADV_BATMAN_V */
@@ -158,6 +160,12 @@ struct neigh_node {
 	struct orig_node *orig_node;
 	struct hard_iface *if_incoming;
 	spinlock_t lq_update_lock;	/* protects: tq_recv, tq_index */
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	uint8_t rq;
+	uint8_t tq;
+	uint32_t last_recv_seqno;
+	DECLARE_BITMAP(elp_rq_bits, TQ_LOCAL_WINDOW_SIZE);
+#endif
 };
 
 #ifdef CONFIG_BATMAN_ADV_BLA
-- 
1.7.9.1

