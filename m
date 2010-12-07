Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue,  7 Dec 2010 15:39:33 +0100
Message-Id: <1291732778-27441-6-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
References: <1291732778-27441-1-git-send-email-linus.luessing@ascom.ch>
Subject: [B.A.T.M.A.N.] [PATCH 05/10] batman-adv: Creating neighbor
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

It will now be checked if a neighbor discovery packet from a new
neighbor on a certain interface has been received. If so,
structures in memory will be allocated for further seqno-tracking
and RQ calculations, and TQ reception, which will be updated
frequently from this commit on.
---
 hard-interface.c |    5 ++
 ndp.c            |  148 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 ndp.h            |    5 ++
 routing.c        |   38 +++++++++++++-
 routing.h        |    1 +
 types.h          |    5 ++
 6 files changed, 200 insertions(+), 2 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 887f794..820121a 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -608,6 +608,11 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	 * the supplied skb. if not, we have to free the skb. */
 
 	switch (batman_packet_ogm->packet_type) {
+		/* batman neighbor discovery protocol packet */
+	case BAT_PACKET_NDP:
+		ret = recv_ndp_packet(skb, batman_if);
+		break;
+
 		/* batman originator packet */
 	case BAT_PACKET_OGM:
 		ret = recv_bat_packet(skb, batman_if);
diff --git a/ndp.c b/ndp.c
index afdf249..3442e17 100644
--- a/ndp.c
+++ b/ndp.c
@@ -1,6 +1,8 @@
 #include "main.h"
 #include "send.h"
 #include "ndp.h"
+#include "soft-interface.h"
+#include "originator.h"
 
 void start_ndp_timer(struct batman_if *batman_if)
 {
@@ -23,9 +25,29 @@ static void ndp_send(struct work_struct *work)
 	struct batman_packet_ndp *ndp_packet = (struct batman_packet_ndp*)
 						batman_if->ndp_packet_buff;
 	int packet_len = sizeof(struct batman_packet_ndp);
+	struct neigh_entry *neigh_entry = (struct neigh_entry*)
+						(ndp_packet + 1);
+	struct neigh_node *neigh_node = NULL;
 	struct sk_buff *skb;
 
-	ndp_packet->seqno = atomic_read(&batman_if->ndp_seqno);
+	ndp_packet->num_neighbors = 0;
+
+	spin_lock_bh(&batman_if->neigh_list_lock);
+	list_for_each_entry(neigh_node, &batman_if->neigh_list, list) {
+		if (packet_len + sizeof(struct neigh_entry) > ETH_DATA_LEN)
+			break;
+
+		memcpy(neigh_entry->addr, neigh_node->addr, ETH_ALEN);
+		neigh_entry->rq = neigh_node->rq;
+		ndp_packet->num_neighbors++;
+		neigh_entry++;
+		packet_len += sizeof(struct neigh_entry);
+	}
+	spin_unlock_bh(&batman_if->neigh_list_lock);
+
+	ndp_packet->seqno = htonl(atomic_read(&batman_if->ndp_seqno));
+	memcpy(ndp_packet->orig, bat_priv->primary_if->net_dev->dev_addr,
+	       ETH_ALEN);
 
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"batman-adv:Sending ndp packet on interface %s, seqno %d\n",
@@ -65,6 +87,9 @@ int ndp_init(struct batman_if *batman_if)
 	ndp_packet->packet_type = BAT_PACKET_NDP;
 	ndp_packet->version = COMPAT_VERSION;
 
+	INIT_LIST_HEAD(&batman_if->neigh_list);
+	spin_lock_init(&batman_if->neigh_list_lock);
+
 	INIT_DELAYED_WORK(&batman_if->ndp_wq, ndp_send);
 
 	return 0;
@@ -77,3 +102,124 @@ void ndp_free(struct batman_if *batman_if)
 	stop_ndp_timer(batman_if);
 	kfree(batman_if->ndp_packet_buff);
 }
+
+/* extract my own tq to neighbor from the ndp packet */
+uint8_t ndp_fetch_tq(struct batman_packet_ndp *packet,
+			 uint8_t *my_if_addr)
+{
+	struct neigh_entry *neigh_entry = (struct neigh_entry*)(packet + 1);
+	uint8_t tq = 0;
+	int i;
+
+	for (i = 0; i < packet->num_neighbors; i++) {
+		if (compare_orig(my_if_addr, neigh_entry->addr)) {
+			tq = neigh_entry->rq;
+			break;
+		}
+		neigh_entry++;
+	}
+	return tq;
+}
+
+static void ndp_update_neighbor_lq(uint8_t tq, uint32_t seqno,
+				   struct neigh_node *neigh_node,
+				   struct bat_priv *bat_priv)
+{
+	char is_duplicate = 0;
+	int32_t seq_diff;
+	int need_update = 0;
+
+	seq_diff = seqno - neigh_node->last_rq_seqno;
+
+	is_duplicate |= get_bit_status(neigh_node->rq_real_bits,
+				       neigh_node->last_rq_seqno,
+				       seqno);
+
+	/* if the window moved, set the update flag. */
+	need_update |= bit_get_packet(bat_priv, neigh_node->rq_real_bits,
+				      seq_diff, 1);
+	// TODO: rename TQ_LOCAL_WINDOW_SIZE to RQ_LOCAL...
+	neigh_node->rq =
+		(bit_packet_count(neigh_node->rq_real_bits) * TQ_MAX_VALUE)
+			/ TQ_LOCAL_WINDOW_SIZE;
+
+	if (need_update) {
+		bat_dbg(DBG_BATMAN, bat_priv, "batman-adv: ndp: "
+			"updating last_seqno of neighbor %pM: old %d, new %d\n",
+			neigh_node->addr, neigh_node->last_rq_seqno, seqno);
+		neigh_node->last_rq_seqno = seqno;
+		// TODO: this is not really an average here,
+		// need to change the variable name later
+		neigh_node->tq_avg = tq;
+		neigh_node->last_valid = jiffies;
+	}
+
+	if (is_duplicate)
+		bat_dbg(DBG_BATMAN, bat_priv,
+			"seqno %d of neighbor %pM was a duplicate!\n",
+			seqno, neigh_node->addr);
+
+	bat_dbg(DBG_BATMAN, bat_priv, "batman-adv: ndp: "
+		"new rq/tq of neighbor %pM: rq %d, tq %d\n",
+		neigh_node->addr, neigh_node->rq, neigh_node->tq_avg);
+}
+
+static struct neigh_node *ndp_create_neighbor(uint8_t my_tq, uint32_t seqno,
+					      uint8_t *neigh_addr,
+					      struct bat_priv *bat_priv)
+{
+	struct neigh_node *neigh_node;
+
+	bat_dbg(DBG_BATMAN, bat_priv,
+		"batman-adv: ndp: Creating new neighbor %pM, "
+		"initial tq %d, initial seqno %d\n",
+		neigh_addr, my_tq, seqno);
+
+	neigh_node = kzalloc(sizeof(struct neigh_node), GFP_ATOMIC);
+	if (!neigh_node)
+		return NULL;
+
+	INIT_LIST_HEAD(&neigh_node->list);
+	memcpy(neigh_node->addr, neigh_addr, ETH_ALEN);
+	neigh_node->tq_avg = my_tq;
+	neigh_node->last_valid = jiffies;
+
+	// TODO: need to initialise rq-window with seqno here
+
+	return neigh_node;
+}
+
+int ndp_update_neighbor(uint8_t my_tq, uint32_t seqno,
+			struct batman_if *batman_if, uint8_t *neigh_addr)
+{
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
+	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
+	int ret = 1;
+
+	spin_lock_bh(&batman_if->neigh_list_lock);
+	// old neighbor?
+	list_for_each_entry(tmp_neigh_node, &batman_if->neigh_list, list) {
+		if (compare_orig(tmp_neigh_node->addr, neigh_addr)) {
+			neigh_node = tmp_neigh_node;
+			ndp_update_neighbor_lq(my_tq, seqno, neigh_node,
+					       bat_priv);
+			break;
+		}
+	}
+
+	// new neighbor?
+	if (!neigh_node) {
+		neigh_node = ndp_create_neighbor(my_tq, seqno, neigh_addr,
+						 bat_priv);
+		if (!neigh_node)
+			goto ret;
+
+		list_add_tail(&neigh_node->list, &batman_if->neigh_list);
+	}
+
+	ret = 0;
+
+ret:
+	spin_unlock_bh(&batman_if->neigh_list_lock);
+	return ret;
+}
diff --git a/ndp.h b/ndp.h
index de85910..35146ce 100644
--- a/ndp.h
+++ b/ndp.h
@@ -4,3 +4,8 @@ void stop_ndp_timer(struct batman_if *batman_if);
 
 int ndp_init(struct batman_if *batman_if);
 void ndp_free(struct batman_if *batman_if);
+
+uint8_t ndp_fetch_tq(struct batman_packet_ndp *packet,
+		 uint8_t *my_if_addr);
+int ndp_update_neighbor(uint8_t my_tq, uint32_t seqno,
+			struct batman_if *batman_if, uint8_t *neigh_addr);
diff --git a/routing.c b/routing.c
index 7ebb631..1972bb8 100644
--- a/routing.c
+++ b/routing.c
@@ -27,6 +27,7 @@
 #include "hard-interface.h"
 #include "icmp_socket.h"
 #include "translation-table.h"
+#include "ndp.h"
 #include "originator.h"
 #include "types.h"
 #include "ring_buffer.h"
@@ -759,7 +760,42 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 				0, hna_buff_len, if_incoming);
 }
 
-int recv_bat_packet(struct sk_buff *skb, struct batman_if *batman_if)
+int recv_ndp_packet(struct sk_buff *skb, struct batman_if *batman_if)
+{
+	struct ethhdr *ethhdr;
+	struct batman_packet_ndp *packet;
+	int ret;
+	uint8_t my_tq;
+
+	/* drop packet if it has not necessary minimum size */
+	if (unlikely(!pskb_may_pull(skb, sizeof(struct batman_packet_ndp))))
+		return NET_RX_DROP;
+
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+
+	/* packet with broadcast indication but unicast recipient */
+	if (!is_broadcast_ether_addr(ethhdr->h_dest))
+		return NET_RX_DROP;
+
+	/* packet with broadcast sender address */
+	if (is_broadcast_ether_addr(ethhdr->h_source))
+		return NET_RX_DROP;
+
+	packet = (struct batman_packet_ndp*)(ethhdr + 1);
+
+	my_tq = ndp_fetch_tq(packet, batman_if->net_dev->dev_addr);
+
+	ret = ndp_update_neighbor(my_tq, ntohl(packet->seqno),
+					batman_if, ethhdr->h_source);
+	if (ret)
+		return NET_RX_DROP;
+
+	kfree_skb(skb);
+	return NET_RX_SUCCESS;
+}
+
+int recv_bat_packet(struct sk_buff *skb,
+				struct batman_if *batman_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 	struct ethhdr *ethhdr;
diff --git a/routing.h b/routing.h
index 81e27d5..a319714 100644
--- a/routing.h
+++ b/routing.h
@@ -39,6 +39,7 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if);
+int recv_ndp_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bat_packet(struct sk_buff *skb, struct batman_if *recv_if);
 struct neigh_node *find_router(struct bat_priv *bat_priv,
 		struct orig_node *orig_node, struct batman_if *recv_if);
diff --git a/types.h b/types.h
index 3ea8f2a..d8494b3 100644
--- a/types.h
+++ b/types.h
@@ -51,6 +51,8 @@ struct batman_if {
 	atomic_t ndp_interval;
 	atomic_t ndp_seqno;
 	struct delayed_work ndp_wq;
+	struct list_head neigh_list;
+	spinlock_t neigh_list_lock;
 };
 
 /**
@@ -112,6 +114,9 @@ struct neigh_node {
 	struct list_head list;
 	uint8_t addr[ETH_ALEN];
 	uint8_t real_packet_count;
+	uint8_t rq;
+	uint32_t last_rq_seqno;
+	TYPE_OF_WORD rq_real_bits[NUM_WORDS];
 	uint8_t tq_recv[TQ_GLOBAL_WINDOW_SIZE];
 	uint8_t tq_index;
 	uint8_t tq_avg;
-- 
1.7.1

