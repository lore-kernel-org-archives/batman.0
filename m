Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 02:09:37 +0200
Message-Id: <1336781383-15649-17-git-send-email-sven@narfation.org>
In-Reply-To: <1336781383-15649-1-git-send-email-sven@narfation.org>
References: <1336781383-15649-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 17/23] batman-adv: Prefix send non-static
	functions with batadv_
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

batman-adv can be compiled as part of the kernel instead of an module. In that
case the linker will see all non-static symbols of batman-adv and all other
non-static symbols of the kernel. This could lead to symbol collisions. A
prefix for the batman-adv symbols that defines their private namespace avoids
such a problem.

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_iv_ogm.c            |    9 +++++----
 distributed-arp-table.c |    8 ++++++--
 hard-interface.c        |    4 ++--
 icmp_socket.c           |    2 +-
 main.c                  |    2 +-
 routing.c               |   10 +++++-----
 send.c                  |   22 ++++++++++++----------
 send.h                  |   17 +++++++++--------
 soft-interface.c        |    2 +-
 translation-table.c     |    8 ++++----
 unicast.c               |    6 +++---
 vis.c                   |    5 +++--
 12 files changed, 52 insertions(+), 43 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index b045bf7..d4e94ca 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -201,7 +201,7 @@ static void bat_iv_ogm_send_to_if(struct forw_packet *forw_packet,
 		inc_counter(bat_priv, BAT_CNT_MGMT_TX);
 		add_counter(bat_priv, BAT_CNT_MGMT_TX_BYTES,
 			    skb->len + ETH_HLEN);
-		send_skb_packet(skb, hard_iface, broadcast_addr);
+		batadv_send_skb_packet(skb, hard_iface, broadcast_addr);
 	}
 }
 
@@ -250,8 +250,9 @@ static void bat_iv_ogm_emit(struct forw_packet *forw_packet)
 			forw_packet->if_incoming->net_dev->dev_addr);
 
 		/* skb is only used once and than forw_packet is free'd */
-		send_skb_packet(forw_packet->skb, forw_packet->if_incoming,
-				broadcast_addr);
+		batadv_send_skb_packet(forw_packet->skb,
+				       forw_packet->if_incoming,
+				       broadcast_addr);
 		forw_packet->skb = NULL;
 
 		goto out;
@@ -420,7 +421,7 @@ static void bat_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 
 	/* start timer for this packet */
 	INIT_DELAYED_WORK(&forw_packet_aggr->delayed_work,
-			  send_outstanding_bat_ogm_packet);
+			  batadv_send_outstanding_bat_ogm_packet);
 	queue_delayed_work(bat_event_workqueue,
 			   &forw_packet_aggr->delayed_work,
 			   send_time - jiffies);
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 3069a01..64b02f1 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -240,6 +240,7 @@ static bool dht_send_data(struct bat_priv *bat_priv, struct sk_buff *skb,
 {
 	int i;
 	bool ret = false;
+	int send_status;
 	struct neigh_node *neigh_node = NULL;
 	struct sk_buff *tmp_skb;
 	struct dht_candidate *cand = dht_select_candidates(bat_priv, ip);
@@ -264,8 +265,11 @@ static bool dht_send_data(struct bat_priv *bat_priv, struct sk_buff *skb,
 			kfree_skb(tmp_skb);
 			goto free_neigh;
 		}
-		if (send_skb_packet(tmp_skb, neigh_node->if_incoming,
-				    neigh_node->addr) == NET_XMIT_SUCCESS)
+
+		send_status = batadv_send_skb_packet(tmp_skb,
+						     neigh_node->if_incoming,
+						     neigh_node->addr);
+		if (send_status == NET_XMIT_SUCCESS)
 			/* packet sent to a candidate: we can return true */
 			ret = true;
 free_neigh:
diff --git a/hard-interface.c b/hard-interface.c
index 7e70cc3..ce75b12 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -348,7 +348,7 @@ int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
 			hard_iface->net_dev->name);
 
 	/* begin scheduling originator messages on that interface */
-	schedule_bat_ogm(hard_iface);
+	batadv_schedule_bat_ogm(hard_iface);
 
 out:
 	return 0;
@@ -394,7 +394,7 @@ void batadv_hardif_disable_interface(struct hard_iface *hard_iface)
 
 	/* delete all references to this hard_iface */
 	batadv_purge_orig_ref(bat_priv);
-	purge_outstanding_packets(bat_priv, hard_iface);
+	batadv_purge_outstanding_packets(bat_priv, hard_iface);
 	dev_put(hard_iface->soft_iface);
 
 	/* nobody uses this interface anymore */
diff --git a/icmp_socket.c b/icmp_socket.c
index 60e7f87..c7ef760 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -236,7 +236,7 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 		memcpy(icmp_packet->rr,
 		       neigh_node->if_incoming->net_dev->dev_addr, ETH_ALEN);
 
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	goto out;
 
 dst_unreach:
diff --git a/main.c b/main.c
index c3eb3d5..4921c13 100644
--- a/main.c
+++ b/main.c
@@ -145,7 +145,7 @@ void mesh_free(struct net_device *soft_iface)
 
 	atomic_set(&bat_priv->mesh_state, MESH_DEACTIVATING);
 
-	purge_outstanding_packets(bat_priv, NULL);
+	batadv_purge_outstanding_packets(bat_priv, NULL);
 
 	vis_quit(bat_priv);
 
diff --git a/routing.c b/routing.c
index 4241d7d..c004440 100644
--- a/routing.c
+++ b/routing.c
@@ -319,7 +319,7 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 	icmp_packet->msg_type = ECHO_REPLY;
 	icmp_packet->header.ttl = TTL;
 
-	send_skb_packet(skb, router->if_incoming, router->addr);
+	batadv_send_skb_packet(skb, router->if_incoming, router->addr);
 	ret = NET_RX_SUCCESS;
 
 out:
@@ -374,7 +374,7 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 	icmp_packet->msg_type = TTL_EXCEEDED;
 	icmp_packet->header.ttl = TTL;
 
-	send_skb_packet(skb, router->if_incoming, router->addr);
+	batadv_send_skb_packet(skb, router->if_incoming, router->addr);
 	ret = NET_RX_SUCCESS;
 
 out:
@@ -459,7 +459,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	icmp_packet->header.ttl--;
 
 	/* route it */
-	send_skb_packet(skb, router->if_incoming, router->addr);
+	batadv_send_skb_packet(skb, router->if_incoming, router->addr);
 	ret = NET_RX_SUCCESS;
 
 out:
@@ -878,7 +878,7 @@ static int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	add_counter(bat_priv, BAT_CNT_FORWARD_BYTES, skb->len + ETH_HLEN);
 
 	/* route it */
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = NET_RX_SUCCESS;
 
 out:
@@ -1095,7 +1095,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		goto out;
 
 	/* rebroadcast packet */
-	add_bcast_packet_to_list(bat_priv, skb, 1);
+	batadv_add_bcast_packet_to_list(bat_priv, skb, 1);
 
 	/* don't hand the broadcast up if it is from an originator
 	 * from the same backbone.
diff --git a/send.c b/send.c
index 43f6f39..57c8adb 100644
--- a/send.c
+++ b/send.c
@@ -34,8 +34,8 @@ static void send_outstanding_bcast_packet(struct work_struct *work);
 
 /* send out an already prepared packet to the given address via the
  * specified batman interface */
-int send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
-		    const uint8_t *dst_addr)
+int batadv_send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
+			   const uint8_t *dst_addr)
 {
 	struct ethhdr *ethhdr;
 
@@ -78,7 +78,7 @@ send_skb_err:
 	return NET_XMIT_DROP;
 }
 
-void schedule_bat_ogm(struct hard_iface *hard_iface)
+void batadv_schedule_bat_ogm(struct hard_iface *hard_iface)
 {
 	struct bat_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 
@@ -134,8 +134,9 @@ static void _add_bcast_packet_to_list(struct bat_priv *bat_priv,
  *
  * The skb is not consumed, so the caller should make sure that the
  * skb is freed. */
-int add_bcast_packet_to_list(struct bat_priv *bat_priv,
-			     const struct sk_buff *skb, unsigned long delay)
+int batadv_add_bcast_packet_to_list(struct bat_priv *bat_priv,
+				    const struct sk_buff *skb,
+				    unsigned long delay)
 {
 	struct hard_iface *primary_if = NULL;
 	struct forw_packet *forw_packet;
@@ -215,7 +216,8 @@ static void send_outstanding_bcast_packet(struct work_struct *work)
 		/* send a copy of the saved skb */
 		skb1 = skb_clone(forw_packet->skb, GFP_ATOMIC);
 		if (skb1)
-			send_skb_packet(skb1, hard_iface, broadcast_addr);
+			batadv_send_skb_packet(skb1, hard_iface,
+					       broadcast_addr);
 	}
 	rcu_read_unlock();
 
@@ -233,7 +235,7 @@ out:
 	atomic_inc(&bat_priv->bcast_queue_left);
 }
 
-void send_outstanding_bat_ogm_packet(struct work_struct *work)
+void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 {
 	struct delayed_work *delayed_work =
 		container_of(work, struct delayed_work, work);
@@ -257,7 +259,7 @@ void send_outstanding_bat_ogm_packet(struct work_struct *work)
 	 * shutting down
 	 */
 	if (forw_packet->own)
-		schedule_bat_ogm(forw_packet->if_incoming);
+		batadv_schedule_bat_ogm(forw_packet->if_incoming);
 
 out:
 	/* don't count own packet */
@@ -267,8 +269,8 @@ out:
 	forw_packet_free(forw_packet);
 }
 
-void purge_outstanding_packets(struct bat_priv *bat_priv,
-			       const struct hard_iface *hard_iface)
+void batadv_purge_outstanding_packets(struct bat_priv *bat_priv,
+				      const struct hard_iface *hard_iface)
 {
 	struct forw_packet *forw_packet;
 	struct hlist_node *tmp_node, *safe_tmp_node;
diff --git a/send.h b/send.h
index 824ef06..452e8df 100644
--- a/send.h
+++ b/send.h
@@ -22,13 +22,14 @@
 #ifndef _NET_BATMAN_ADV_SEND_H_
 #define _NET_BATMAN_ADV_SEND_H_
 
-int send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
-		    const uint8_t *dst_addr);
-void schedule_bat_ogm(struct hard_iface *hard_iface);
-int add_bcast_packet_to_list(struct bat_priv *bat_priv,
-			     const struct sk_buff *skb, unsigned long delay);
-void send_outstanding_bat_ogm_packet(struct work_struct *work);
-void purge_outstanding_packets(struct bat_priv *bat_priv,
-			       const struct hard_iface *hard_iface);
+int batadv_send_skb_packet(struct sk_buff *skb, struct hard_iface *hard_iface,
+			   const uint8_t *dst_addr);
+void batadv_schedule_bat_ogm(struct hard_iface *hard_iface);
+int batadv_add_bcast_packet_to_list(struct bat_priv *bat_priv,
+				    const struct sk_buff *skb,
+				    unsigned long delay);
+void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work);
+void batadv_purge_outstanding_packets(struct bat_priv *bat_priv,
+				      const struct hard_iface *hard_iface);
 
 #endif /* _NET_BATMAN_ADV_SEND_H_ */
diff --git a/soft-interface.c b/soft-interface.c
index eb9e759..ed9bdab 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -228,7 +228,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		bcast_packet->seqno =
 			htonl(atomic_inc_return(&bat_priv->bcast_seqno));
 
-		add_bcast_packet_to_list(bat_priv, skb, brd_delay);
+		batadv_add_bcast_packet_to_list(bat_priv, skb, brd_delay);
 
 		/* a copy is stored in the bcast list, therefore removing
 		 * the original skb. */
diff --git a/translation-table.c b/translation-table.c
index ea27d6f..46a907e 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1406,7 +1406,7 @@ static int send_tt_request(struct bat_priv *bat_priv,
 
 	inc_counter(bat_priv, BAT_CNT_TT_REQUEST_TX);
 
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
 
 out:
@@ -1532,7 +1532,7 @@ static bool send_other_tt_response(struct bat_priv *bat_priv,
 
 	inc_counter(bat_priv, BAT_CNT_TT_RESPONSE_TX);
 
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = true;
 	goto out;
 
@@ -1650,7 +1650,7 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 
 	inc_counter(bat_priv, BAT_CNT_TT_RESPONSE_TX);
 
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = true;
 	goto out;
 
@@ -1957,7 +1957,7 @@ static void send_roam_adv(struct bat_priv *bat_priv, uint8_t *client,
 
 	inc_counter(bat_priv, BAT_CNT_TT_ROAM_ADV_TX);
 
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
 
 out:
diff --git a/unicast.c b/unicast.c
index c176f5a..62d2f47 100644
--- a/unicast.c
+++ b/unicast.c
@@ -268,8 +268,8 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 	frag1->seqno = htons(seqno - 1);
 	frag2->seqno = htons(seqno);
 
-	send_skb_packet(skb, hard_iface, dstaddr);
-	send_skb_packet(frag_skb, hard_iface, dstaddr);
+	batadv_send_skb_packet(skb, hard_iface, dstaddr);
+	batadv_send_skb_packet(frag_skb, hard_iface, dstaddr);
 	ret = NET_RX_SUCCESS;
 	goto out;
 
@@ -414,7 +414,7 @@ find_router:
 		goto out;
 	}
 
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = 0;
 
 out:
diff --git a/vis.c b/vis.c
index 1972a11..c56737c 100644
--- a/vis.c
+++ b/vis.c
@@ -777,7 +777,8 @@ static void broadcast_vis_packet(struct bat_priv *bat_priv,
 
 			skb = skb_clone(info->skb_packet, GFP_ATOMIC);
 			if (skb)
-				send_skb_packet(skb, hard_iface, dstaddr);
+				batadv_send_skb_packet(skb, hard_iface,
+						       dstaddr);
 
 		}
 		rcu_read_unlock();
@@ -804,7 +805,7 @@ static void unicast_vis_packet(struct bat_priv *bat_priv,
 
 	skb = skb_clone(info->skb_packet, GFP_ATOMIC);
 	if (skb)
-		send_skb_packet(skb, router->if_incoming, router->addr);
+		batadv_send_skb_packet(skb, router->if_incoming, router->addr);
 
 out:
 	if (router)
-- 
1.7.10

