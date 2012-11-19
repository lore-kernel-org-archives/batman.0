Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 19 Nov 2012 09:24:06 +0100
Message-Id: <1353313451-2930-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1353313451-2930-1-git-send-email-ordex@autistici.org>
References: <1353313451-2930-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 05/10] batman-adv: Add wrapper to look up
	neighbor and send skb
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Martin Hundebøll <martin@hundeboll.net>

By adding batadv_send_skb_to_orig() in send.c, we can remove duplicate
code that looks up the next hop and then calls batadv_send_skb_packet().

Furthermore, this prepares the upcoming new implementation of
fragmentation, which requires the next hop to route packets.

Please note that this doesn't entirely remove the next-hop lookup in
routing.c and unicast.c, since it is used by the current fragmentation
code.

Also note that the next-hop info is removed from debug messages in
translation-table.c, since it is looked up elsewhere.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/routing.c           | 37 +++++-----------------
 net/batman-adv/send.c              | 33 +++++++++++++++++++
 net/batman-adv/send.h              |  3 ++
 net/batman-adv/translation-table.c | 65 ++++++++++----------------------------
 net/batman-adv/unicast.c           |  8 ++---
 net/batman-adv/vis.c               | 37 ++++++----------------
 6 files changed, 75 insertions(+), 108 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 78d6572..8d64348 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -285,7 +285,6 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
-	struct batadv_neigh_node *router = NULL;
 	struct batadv_icmp_packet_rr *icmp_packet;
 	int ret = NET_RX_DROP;
 
@@ -307,10 +306,6 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	router = batadv_orig_node_get_router(orig_node);
-	if (!router)
-		goto out;
-
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, ETH_HLEN) < 0)
 		goto out;
@@ -322,14 +317,12 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 	icmp_packet->msg_type = BATADV_ECHO_REPLY;
 	icmp_packet->header.ttl = BATADV_TTL;
 
-	batadv_send_skb_packet(skb, router->if_incoming, router->addr);
-	ret = NET_RX_SUCCESS;
+	if (batadv_send_skb_to_orig(skb, orig_node, NULL))
+		ret = NET_RX_SUCCESS;
 
 out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
-	if (router)
-		batadv_neigh_node_free_ref(router);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 	return ret;
@@ -340,7 +333,6 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
-	struct batadv_neigh_node *router = NULL;
 	struct batadv_icmp_packet *icmp_packet;
 	int ret = NET_RX_DROP;
 
@@ -362,10 +354,6 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	router = batadv_orig_node_get_router(orig_node);
-	if (!router)
-		goto out;
-
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, ETH_HLEN) < 0)
 		goto out;
@@ -377,14 +365,12 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	icmp_packet->msg_type = BATADV_TTL_EXCEEDED;
 	icmp_packet->header.ttl = BATADV_TTL;
 
-	batadv_send_skb_packet(skb, router->if_incoming, router->addr);
-	ret = NET_RX_SUCCESS;
+	if (batadv_send_skb_to_orig(skb, orig_node, NULL))
+		ret = NET_RX_SUCCESS;
 
 out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
-	if (router)
-		batadv_neigh_node_free_ref(router);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 	return ret;
@@ -398,7 +384,6 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	struct batadv_icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
 	struct batadv_orig_node *orig_node = NULL;
-	struct batadv_neigh_node *router = NULL;
 	int hdr_size = sizeof(struct batadv_icmp_packet);
 	int ret = NET_RX_DROP;
 
@@ -447,10 +432,6 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	if (!orig_node)
 		goto out;
 
-	router = batadv_orig_node_get_router(orig_node);
-	if (!router)
-		goto out;
-
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, ETH_HLEN) < 0)
 		goto out;
@@ -461,12 +442,10 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	icmp_packet->header.ttl--;
 
 	/* route it */
-	batadv_send_skb_packet(skb, router->if_incoming, router->addr);
-	ret = NET_RX_SUCCESS;
+	if (batadv_send_skb_to_orig(skb, orig_node, recv_if))
+		ret = NET_RX_SUCCESS;
 
 out:
-	if (router)
-		batadv_neigh_node_free_ref(router);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 	return ret;
@@ -882,8 +861,8 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 			   skb->len + ETH_HLEN);
 
 	/* route it */
-	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
-	ret = NET_RX_SUCCESS;
+	if (batadv_send_skb_to_orig(skb, orig_node, recv_if))
+		ret = NET_RX_SUCCESS;
 
 out:
 	if (neigh_node)
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 660d9bf..c7f7023 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -78,6 +78,39 @@ send_skb_err:
 	return NET_XMIT_DROP;
 }
 
+/**
+ * batadv_send_skb_to_orig - Lookup next-hop and transmit skb.
+ * @skb: Packet to be transmitted.
+ * @orig_node: Final destination of the packet.
+ * @recv_if: Interface used when receiving the packet (can be NULL).
+ *
+ * Looks up the best next-hop towards the passed originator and passes the
+ * skb on for preparation of MAC header. If the packet originated from this
+ * host, NULL can be passed as recv_if and no interface alternating is
+ * attempted.
+ *
+ * Returns TRUE on success; FALSE otherwise.
+ */
+bool batadv_send_skb_to_orig(struct sk_buff *skb,
+			     struct batadv_orig_node *orig_node,
+			     struct batadv_hard_iface *recv_if)
+{
+	struct batadv_priv *bat_priv = orig_node->bat_priv;
+	struct batadv_neigh_node *neigh_node;
+
+	/* batadv_find_router() increases neigh_nodes refcount if found. */
+	neigh_node = batadv_find_router(bat_priv, orig_node, recv_if);
+	if (!neigh_node)
+		return false;
+
+	/* route it */
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+
+	batadv_neigh_node_free_ref(neigh_node);
+
+	return true;
+}
+
 void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 643329b..0078dec 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -23,6 +23,9 @@
 int batadv_send_skb_packet(struct sk_buff *skb,
 			   struct batadv_hard_iface *hard_iface,
 			   const uint8_t *dst_addr);
+bool batadv_send_skb_to_orig(struct sk_buff *skb,
+			     struct batadv_orig_node *orig_node,
+			     struct batadv_hard_iface *recv_if);
 void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface);
 int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				    const struct sk_buff *skb,
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index cdad824..22457a7 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1642,7 +1642,6 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 {
 	struct sk_buff *skb = NULL;
 	struct batadv_tt_query_packet *tt_request;
-	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_hard_iface *primary_if;
 	struct batadv_tt_req_node *tt_req_node = NULL;
 	int ret = 1;
@@ -1680,23 +1679,15 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 	if (full_table)
 		tt_request->flags |= BATADV_TT_FULL_TABLE;
 
-	neigh_node = batadv_orig_node_get_router(dst_orig_node);
-	if (!neigh_node)
-		goto out;
-
-	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Sending TT_REQUEST to %pM via %pM [%c]\n",
-		   dst_orig_node->orig, neigh_node->addr,
-		   (full_table ? 'F' : '.'));
+	batadv_dbg(BATADV_DBG_TT, bat_priv, "Sending TT_REQUEST to %pM [%c]\n",
+		   dst_orig_node->orig, (full_table ? 'F' : '.'));
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_REQUEST_TX);
 
-	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
-	ret = 0;
+	if (batadv_send_skb_to_orig(skb, dst_orig_node, NULL))
+		ret = 0;
 
 out:
-	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
 	if (ret)
@@ -1716,7 +1707,6 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 {
 	struct batadv_orig_node *req_dst_orig_node;
 	struct batadv_orig_node *res_dst_orig_node = NULL;
-	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
 	uint8_t orig_ttvn, req_ttvn, ttvn;
 	int ret = false;
@@ -1742,10 +1732,6 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	if (!res_dst_orig_node)
 		goto out;
 
-	neigh_node = batadv_orig_node_get_router(res_dst_orig_node);
-	if (!neigh_node)
-		goto out;
-
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
 		goto out;
@@ -1817,14 +1803,13 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 		tt_response->flags |= BATADV_TT_FULL_TABLE;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Sending TT_RESPONSE %pM via %pM for %pM (ttvn: %u)\n",
-		   res_dst_orig_node->orig, neigh_node->addr,
-		   req_dst_orig_node->orig, req_ttvn);
+		   "Sending TT_RESPONSE %pM for %pM (ttvn: %u)\n",
+		   res_dst_orig_node->orig, req_dst_orig_node->orig, req_ttvn);
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_RESPONSE_TX);
 
-	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
-	ret = true;
+	if (batadv_send_skb_to_orig(skb, res_dst_orig_node, NULL))
+		ret = true;
 	goto out;
 
 unlock:
@@ -1835,8 +1820,6 @@ out:
 		batadv_orig_node_free_ref(res_dst_orig_node);
 	if (req_dst_orig_node)
 		batadv_orig_node_free_ref(req_dst_orig_node);
-	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
 	if (!ret)
@@ -1850,7 +1833,6 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 			   struct batadv_tt_query_packet *tt_request)
 {
 	struct batadv_orig_node *orig_node;
-	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
 	uint8_t my_ttvn, req_ttvn, ttvn;
 	int ret = false;
@@ -1875,10 +1857,6 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	neigh_node = batadv_orig_node_get_router(orig_node);
-	if (!neigh_node)
-		goto out;
-
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
 		goto out;
@@ -1942,14 +1920,14 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 		tt_response->flags |= BATADV_TT_FULL_TABLE;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Sending TT_RESPONSE to %pM via %pM [%c]\n",
-		   orig_node->orig, neigh_node->addr,
+		   "Sending TT_RESPONSE to %pM [%c]\n",
+		   orig_node->orig,
 		   (tt_response->flags & BATADV_TT_FULL_TABLE ? 'F' : '.'));
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_RESPONSE_TX);
 
-	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
-	ret = true;
+	if (batadv_send_skb_to_orig(skb, orig_node, NULL))
+		ret = true;
 	goto out;
 
 unlock:
@@ -1957,8 +1935,6 @@ unlock:
 out:
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
-	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
 	if (!ret)
@@ -2223,7 +2199,6 @@ unlock:
 static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 				 struct batadv_orig_node *orig_node)
 {
-	struct batadv_neigh_node *neigh_node = NULL;
 	struct sk_buff *skb = NULL;
 	struct batadv_roam_adv_packet *roam_adv_packet;
 	int ret = 1;
@@ -2256,23 +2231,17 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 	memcpy(roam_adv_packet->dst, orig_node->orig, ETH_ALEN);
 	memcpy(roam_adv_packet->client, client, ETH_ALEN);
 
-	neigh_node = batadv_orig_node_get_router(orig_node);
-	if (!neigh_node)
-		goto out;
-
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Sending ROAMING_ADV to %pM (client %pM) via %pM\n",
-		   orig_node->orig, client, neigh_node->addr);
+		   "Sending ROAMING_ADV to %pM (client %pM)\n",
+		   orig_node->orig, client);
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_ROAM_ADV_TX);
 
-	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
-	ret = 0;
+	if (batadv_send_skb_to_orig(skb, orig_node, NULL))
+		ret = 0;
 
 out:
-	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
-	if (ret)
+	if (ret && skb)
 		kfree_skb(skb);
 	return;
 }
diff --git a/net/batman-adv/unicast.c b/net/batman-adv/unicast.c
index c9a1f65..10aff49 100644
--- a/net/batman-adv/unicast.c
+++ b/net/batman-adv/unicast.c
@@ -402,7 +402,7 @@ int batadv_unicast_generic_send_skb(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *orig_node;
 	struct batadv_neigh_node *neigh_node;
 	int data_len = skb->len;
-	int ret = 1;
+	int ret = NET_RX_DROP;
 	unsigned int dev_mtu;
 
 	/* get routing information */
@@ -466,15 +466,15 @@ find_router:
 		goto out;
 	}
 
-	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
-	ret = 0;
+	if (batadv_send_skb_to_orig(skb, orig_node, NULL))
+		ret = 0;
 
 out:
 	if (neigh_node)
 		batadv_neigh_node_free_ref(neigh_node);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
-	if (ret == 1)
+	if (ret == NET_RX_DROP)
 		kfree_skb(skb);
 	return ret;
 }
diff --git a/net/batman-adv/vis.c b/net/batman-adv/vis.c
index ad14a6c..0f65a9d 100644
--- a/net/batman-adv/vis.c
+++ b/net/batman-adv/vis.c
@@ -698,15 +698,12 @@ static void batadv_purge_vis_packets(struct batadv_priv *bat_priv)
 static void batadv_broadcast_vis_packet(struct batadv_priv *bat_priv,
 					struct batadv_vis_info *info)
 {
-	struct batadv_neigh_node *router;
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	struct hlist_node *node;
 	struct hlist_head *head;
 	struct batadv_orig_node *orig_node;
 	struct batadv_vis_packet *packet;
 	struct sk_buff *skb;
-	struct batadv_hard_iface *hard_iface;
-	uint8_t dstaddr[ETH_ALEN];
 	uint32_t i;
 
 
@@ -722,30 +719,20 @@ static void batadv_broadcast_vis_packet(struct batadv_priv *bat_priv,
 			if (!(orig_node->flags & BATADV_VIS_SERVER))
 				continue;
 
-			router = batadv_orig_node_get_router(orig_node);
-			if (!router)
-				continue;
-
 			/* don't send it if we already received the packet from
 			 * this node.
 			 */
 			if (batadv_recv_list_is_in(bat_priv, &info->recv_list,
-						   orig_node->orig)) {
-				batadv_neigh_node_free_ref(router);
+						   orig_node->orig))
 				continue;
-			}
 
 			memcpy(packet->target_orig, orig_node->orig, ETH_ALEN);
-			hard_iface = router->if_incoming;
-			memcpy(dstaddr, router->addr, ETH_ALEN);
-
-			batadv_neigh_node_free_ref(router);
-
 			skb = skb_clone(info->skb_packet, GFP_ATOMIC);
-			if (skb)
-				batadv_send_skb_packet(skb, hard_iface,
-						       dstaddr);
+			if (!skb)
+				continue;
 
+			if (!batadv_send_skb_to_orig(skb, orig_node, NULL))
+				kfree_skb(skb);
 		}
 		rcu_read_unlock();
 	}
@@ -755,7 +742,6 @@ static void batadv_unicast_vis_packet(struct batadv_priv *bat_priv,
 				      struct batadv_vis_info *info)
 {
 	struct batadv_orig_node *orig_node;
-	struct batadv_neigh_node *router = NULL;
 	struct sk_buff *skb;
 	struct batadv_vis_packet *packet;
 
@@ -765,17 +751,14 @@ static void batadv_unicast_vis_packet(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	router = batadv_orig_node_get_router(orig_node);
-	if (!router)
-		goto out;
-
 	skb = skb_clone(info->skb_packet, GFP_ATOMIC);
-	if (skb)
-		batadv_send_skb_packet(skb, router->if_incoming, router->addr);
+	if (!skb)
+		goto out;
+
+	if (!batadv_send_skb_to_orig(skb, orig_node, NULL))
+		kfree_skb(skb);
 
 out:
-	if (router)
-		batadv_neigh_node_free_ref(router);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 }
-- 
1.8.0

