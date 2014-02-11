Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:13 +0100
Message-Id: <1392122903-805-14-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 13/23] batman-adv: add last_unicast_tx to
	struct neigh_node_elp
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

This timestamp registers the last time a unicast packet was
sent to a given neighbour

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_iv_ogm.c            |  2 +-
 bat_v_elp.c             |  2 +-
 bat_v_ogm.c             |  2 +-
 distributed-arp-table.c |  4 +---
 fragmentation.c         |  8 +++-----
 icmp_socket.c           |  2 +-
 network-coding.c        | 20 +++++++++-----------
 send.c                  | 46 +++++++++++++++++++++++++++++++++++++++-------
 send.h                  | 10 +++++++---
 types.h                 |  2 ++
 10 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index f92253a..e2069c9 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -469,7 +469,7 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 		batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_TX);
 		batadv_add_counter(bat_priv, BATADV_CNT_MGMT_TX_BYTES,
 				   skb->len + ETH_HLEN);
-		batadv_send_skb_packet(skb, hard_iface, batadv_broadcast_addr);
+		batadv_send_broadcast_skb(skb, hard_iface);
 	}
 }
 
diff --git a/bat_v_elp.c b/bat_v_elp.c
index f9a6bfe..4185d8c 100644
--- a/bat_v_elp.c
+++ b/bat_v_elp.c
@@ -200,7 +200,7 @@ static void batadv_v_elp_send_outstanding(struct work_struct *work)
 		   hard_iface->net_dev->name,
 		   atomic_read(&hard_iface->bat_v.elp_seqno));
 
-	batadv_send_skb_packet(skb, hard_iface, batadv_broadcast_addr);
+	batadv_send_broadcast_skb(skb, hard_iface);
 
 	atomic_inc(&hard_iface->bat_v.elp_seqno);
 
diff --git a/bat_v_ogm.c b/bat_v_ogm.c
index 5876164..fa3d1a1 100644
--- a/bat_v_ogm.c
+++ b/bat_v_ogm.c
@@ -129,7 +129,7 @@ static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
 	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_TX_BYTES,
 			   skb->len + ETH_HLEN);
 
-	batadv_send_skb_packet(skb, hard_iface, batadv_broadcast_addr);
+	batadv_send_broadcast_skb(skb, hard_iface);
 }
 
 static void batadv_v_ogm_send(struct work_struct *work)
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 78803b8..bc37033 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -602,9 +602,7 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 			goto free_neigh;
 		}
 
-		send_status = batadv_send_skb_packet(tmp_skb,
-						     neigh_node->if_incoming,
-						     neigh_node->addr);
+		send_status = batadv_send_unicast_skb(tmp_skb, neigh_node);
 		if (send_status == NET_XMIT_SUCCESS) {
 			/* count the sent packet */
 			switch (packet_subtype) {
diff --git a/fragmentation.c b/fragmentation.c
index bcc4bea..12811e0 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -354,8 +354,7 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 				   skb->len + ETH_HLEN);
 
 		packet->ttl--;
-		batadv_send_skb_packet(skb, neigh_node->if_incoming,
-				       neigh_node->addr);
+		batadv_send_unicast_skb(skb, neigh_node);
 		ret = true;
 	}
 
@@ -461,8 +460,7 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 		batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_TX);
 		batadv_add_counter(bat_priv, BATADV_CNT_FRAG_TX_BYTES,
 				   skb_fragment->len + ETH_HLEN);
-		batadv_send_skb_packet(skb_fragment, neigh_node->if_incoming,
-				       neigh_node->addr);
+		batadv_send_unicast_skb(skb_fragment, neigh_node);
 		frag_header.no++;
 
 		/* The initial check in this function should cover this case */
@@ -481,7 +479,7 @@ bool batadv_frag_send_packet(struct sk_buff *skb,
 	batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_TX);
 	batadv_add_counter(bat_priv, BATADV_CNT_FRAG_TX_BYTES,
 			   skb->len + ETH_HLEN);
-	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_unicast_skb(skb, neigh_node);
 
 	return true;
 out_err:
diff --git a/icmp_socket.c b/icmp_socket.c
index bf07dfd..4734e02 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -253,7 +253,7 @@ static ssize_t batadv_socket_write(struct file *file, const char __user *buff,
 
 	ether_addr_copy(icmp_header->orig, primary_if->net_dev->dev_addr);
 
-	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_unicast_skb(skb, neigh_node);
 	goto out;
 
 dst_unreach:
diff --git a/network-coding.c b/network-coding.c
index a9546fe..bbb4ac0 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -535,9 +535,7 @@ batadv_nc_hash_find(struct batadv_hashtable *hash,
  */
 static void batadv_nc_send_packet(struct batadv_nc_packet *nc_packet)
 {
-	batadv_send_skb_packet(nc_packet->skb,
-			       nc_packet->neigh_node->if_incoming,
-			       nc_packet->nc_path->next_hop);
+	batadv_send_unicast_skb(nc_packet->skb, nc_packet->neigh_node);
 	nc_packet->skb = NULL;
 	batadv_nc_packet_free(nc_packet);
 }
@@ -1018,11 +1016,11 @@ static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
 	struct batadv_unicast_packet *packet1;
 	struct batadv_unicast_packet *packet2;
 	struct batadv_coded_packet *coded_packet;
-	struct batadv_neigh_node *neigh_tmp, *router_neigh;
-	struct batadv_neigh_node *router_coding = NULL;
+	struct batadv_neigh_node *neigh_tmp, *router_neigh, *first_dest;
+	struct batadv_neigh_node *router_coding = NULL, *second_dest;
 	struct batadv_neigh_ifinfo *router_neigh_ifinfo = NULL;
 	struct batadv_neigh_ifinfo *router_coding_ifinfo = NULL;
-	uint8_t *first_source, *first_dest, *second_source, *second_dest;
+	uint8_t *first_source, *second_source;
 	__be32 packet_id1, packet_id2;
 	size_t count;
 	bool res = false;
@@ -1065,9 +1063,9 @@ static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
 	 */
 	if (tq_weighted_neigh >= tq_weighted_coding) {
 		/* Destination from nc_packet is selected for MAC-header */
-		first_dest = nc_packet->nc_path->next_hop;
+		first_dest = nc_packet->neigh_node;
 		first_source = nc_packet->nc_path->prev_hop;
-		second_dest = neigh_node->addr;
+		second_dest = neigh_node;
 		second_source = ethhdr->h_source;
 		packet1 = (struct batadv_unicast_packet *)nc_packet->skb->data;
 		packet2 = (struct batadv_unicast_packet *)skb->data;
@@ -1076,9 +1074,9 @@ static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
 					      skb->data + sizeof(*packet2));
 	} else {
 		/* Destination for skb is selected for MAC-header */
-		first_dest = neigh_node->addr;
+		first_dest = neigh_node;
 		first_source = ethhdr->h_source;
-		second_dest = nc_packet->nc_path->next_hop;
+		second_dest = nc_packet->neigh_node;
 		second_source = nc_packet->nc_path->prev_hop;
 		packet1 = (struct batadv_unicast_packet *)skb->data;
 		packet2 = (struct batadv_unicast_packet *)nc_packet->skb->data;
@@ -1175,7 +1173,7 @@ static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
 	batadv_nc_packet_free(nc_packet);
 
 	/* Send the coded packet and return true */
-	batadv_send_skb_packet(skb_dest, neigh_node->if_incoming, first_dest);
+	batadv_send_unicast_skb(skb_dest, first_dest);
 	res = true;
 out:
 	if (router_neigh)
diff --git a/send.c b/send.c
index 63a46c3..734b24e 100644
--- a/send.c
+++ b/send.c
@@ -30,16 +30,30 @@
 
 static void batadv_send_outstanding_bcast_packet(struct work_struct *work);
 
-/* send out an already prepared packet to the given address via the
- * specified batman interface
+/**
+ * batadv_send_skb_packet - send an already prepared packet
+ * @skb: the packet to send
+ * @hard_iface: the interface to use to send the broadcast packet
+ * @neigh_node: the destination node. If not NULL packet is sent as unicast
+ *
+ * Send out an already prepared packet to the given neighbor or broadcast it
+ * using the specified interface. Either hard_iface or neigh_node must be not
+ * NULL.
+ * If neigh_node is NULL, then the packet is broadcasted using hard_iface,
+ * otherwise it is sent as unicast to the given neighbor.
+ *
+ * Return NET_TX_DROP in case of error or the result of dev_queue_xmit(skb)
+ * otherwise
  */
 int batadv_send_skb_packet(struct sk_buff *skb,
 			   struct batadv_hard_iface *hard_iface,
 			   const uint8_t *dst_addr)
 {
-	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+	struct batadv_priv *bat_priv;
 	struct ethhdr *ethhdr;
 
+	bat_priv = netdev_priv(hard_iface->soft_iface);
+
 	if (hard_iface->if_status != BATADV_IF_ACTIVE)
 		goto send_skb_err;
 
@@ -81,6 +95,26 @@ send_skb_err:
 	return NET_XMIT_DROP;
 }
 
+int batadv_send_broadcast_skb(struct sk_buff *skb,
+			      struct batadv_hard_iface *hard_iface)
+{
+	return batadv_send_skb_packet(skb, hard_iface, batadv_broadcast_addr);
+}
+
+int batadv_send_unicast_skb(struct sk_buff *skb,
+			    struct batadv_neigh_node *neigh)
+{
+	int ret;
+
+	ret = batadv_send_skb_packet(skb, neigh->if_incoming, neigh->addr);
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	if (ret != NET_XMIT_DROP && neigh->elp_neigh)
+		neigh->elp_neigh->last_unicast_tx = jiffies;
+#endif
+
+	return ret;
+}
+
 /**
  * batadv_send_skb_to_orig - Lookup next-hop and transmit skb.
  * @skb: Packet to be transmitted.
@@ -127,8 +161,7 @@ int batadv_send_skb_to_orig(struct sk_buff *skb,
 	if (recv_if && batadv_nc_skb_forward(skb, neigh_node)) {
 		ret = NET_XMIT_POLICED;
 	} else {
-		batadv_send_skb_packet(skb, neigh_node->if_incoming,
-				       neigh_node->addr);
+		batadv_send_unicast_skb(skb, neigh_node);
 		ret = NET_XMIT_SUCCESS;
 	}
 
@@ -516,8 +549,7 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 		/* send a copy of the saved skb */
 		skb1 = skb_clone(forw_packet->skb, GFP_ATOMIC);
 		if (skb1)
-			batadv_send_skb_packet(skb1, hard_iface,
-					       batadv_broadcast_addr);
+			batadv_send_broadcast_skb(skb1, hard_iface);
 	}
 	rcu_read_unlock();
 
diff --git a/send.h b/send.h
index 20e1668..f510dee 100644
--- a/send.h
+++ b/send.h
@@ -18,12 +18,16 @@
 #ifndef _NET_BATMAN_ADV_SEND_H_
 #define _NET_BATMAN_ADV_SEND_H_
 
-int batadv_send_skb_packet(struct sk_buff *skb,
-			   struct batadv_hard_iface *hard_iface,
-			   const uint8_t *dst_addr);
 int batadv_send_skb_to_orig(struct sk_buff *skb,
 			    struct batadv_orig_node *orig_node,
 			    struct batadv_hard_iface *recv_if);
+int batadv_send_skb_packet(struct sk_buff *skb,
+			   struct batadv_hard_iface *hard_iface,
+			   const uint8_t *dst_addr);
+int batadv_send_broadcast_skb(struct sk_buff *skb,
+			      struct batadv_hard_iface *hard_iface);
+int batadv_send_unicast_skb(struct sk_buff *skb,
+			    struct batadv_neigh_node *neigh_node);
 void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface);
 int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				    const struct sk_buff *skb,
diff --git a/types.h b/types.h
index 22d621e..54fae29 100644
--- a/types.h
+++ b/types.h
@@ -342,6 +342,7 @@ struct batadv_gw_node {
  * @metric: ewma link metric towards this neighbor
  * @last_recv_seqno: last ELP received sequence number
  * @lest_seen: last time this neigh has been seen
+ * @last_unicast_tx: when the last unicast packet has been sent to this neighbor
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in an RCU-safe manner
  */
@@ -353,6 +354,7 @@ struct batadv_elp_neigh_node {
 	uint32_t last_recv_seqno;
 	unsigned long last_seen;
 	uint32_t elp_interval;
+	unsigned long last_unicast_tx;
 	atomic_t refcount;
 	struct rcu_head rcu;
 };
-- 
1.8.5.3

