Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Sun,  8 Jul 2012 23:24:18 +0200
Message-Id: <1341782658-10978-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add wrapper to look up neighbor
	and send skb
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

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
---
 routing.c           | 33 ++++-----------------------
 send.c              | 20 +++++++++++++++++
 send.h              |  3 +++
 translation-table.c | 65 +++++++++++++----------------------------------------
 unicast.c           |  9 ++++----
 vis.c               | 38 +++++++++----------------------
 6 files changed, 58 insertions(+), 110 deletions(-)

diff --git a/routing.c b/routing.c
index bc2b88b..5e5d335 100644
--- a/routing.c
+++ b/routing.c
@@ -284,7 +284,6 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
-	struct batadv_neigh_node *router = NULL;
 	struct batadv_icmp_packet_rr *icmp_packet;
 	int ret = NET_RX_DROP;
 
@@ -306,10 +305,6 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	router = batadv_orig_node_get_router(orig_node);
-	if (!router)
-		goto out;
-
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, ETH_HLEN) < 0)
 		goto out;
@@ -321,14 +316,11 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 	icmp_packet->msg_type = BATADV_ECHO_REPLY;
 	icmp_packet->header.ttl = BATADV_TTL;
 
-	batadv_send_skb_packet(skb, router->if_incoming, router->addr);
-	ret = NET_RX_SUCCESS;
+	ret = batadv_send_skb_to_orig(orig_node, skb, NULL);
 
 out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
-	if (router)
-		batadv_neigh_node_free_ref(router);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 	return ret;
@@ -339,7 +331,6 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 {
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
-	struct batadv_neigh_node *router = NULL;
 	struct batadv_icmp_packet *icmp_packet;
 	int ret = NET_RX_DROP;
 
@@ -361,10 +352,6 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	router = batadv_orig_node_get_router(orig_node);
-	if (!router)
-		goto out;
-
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, ETH_HLEN) < 0)
 		goto out;
@@ -376,14 +363,11 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	icmp_packet->msg_type = BATADV_TTL_EXCEEDED;
 	icmp_packet->header.ttl = BATADV_TTL;
 
-	batadv_send_skb_packet(skb, router->if_incoming, router->addr);
-	ret = NET_RX_SUCCESS;
+	ret = batadv_send_skb_to_orig(orig_node, skb, NULL);
 
 out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
-	if (router)
-		batadv_neigh_node_free_ref(router);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 	return ret;
@@ -397,7 +381,6 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	struct batadv_icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
 	struct batadv_orig_node *orig_node = NULL;
-	struct batadv_neigh_node *router = NULL;
 	int hdr_size = sizeof(struct batadv_icmp_packet);
 	int ret = NET_RX_DROP;
 
@@ -446,10 +429,6 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	if (!orig_node)
 		goto out;
 
-	router = batadv_orig_node_get_router(orig_node);
-	if (!router)
-		goto out;
-
 	/* create a copy of the skb, if needed, to modify it. */
 	if (skb_cow(skb, ETH_HLEN) < 0)
 		goto out;
@@ -460,12 +439,9 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	icmp_packet->header.ttl--;
 
 	/* route it */
-	batadv_send_skb_packet(skb, router->if_incoming, router->addr);
-	ret = NET_RX_SUCCESS;
+	ret = batadv_send_skb_to_orig(orig_node, skb, recv_if);
 
 out:
-	if (router)
-		batadv_neigh_node_free_ref(router);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 	return ret;
@@ -919,8 +895,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 			   skb->len + ETH_HLEN);
 
 	/* route it */
-	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
-	ret = NET_RX_SUCCESS;
+	ret = batadv_send_skb_to_orig(orig_node, skb, recv_if);
 
 out:
 	if (neigh_node)
diff --git a/send.c b/send.c
index 3b4b2da..c553cfa 100644
--- a/send.c
+++ b/send.c
@@ -77,6 +77,26 @@ send_skb_err:
 	return NET_XMIT_DROP;
 }
 
+int batadv_send_skb_to_orig(struct batadv_orig_node *orig_node,
+			    struct sk_buff *skb,
+			    struct batadv_hard_iface *recv_if)
+{
+	struct batadv_priv *bat_priv = orig_node->bat_priv;
+	struct batadv_neigh_node *neigh_node;
+
+	/* batadv_find_router() increases neigh_nodes refcount if found. */
+	neigh_node = batadv_find_router(bat_priv, orig_node, recv_if);
+	if (!neigh_node)
+		return NET_XMIT_DROP;
+
+	/* route it */
+	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+
+	batadv_neigh_node_free_ref(neigh_node);
+
+	return NET_XMIT_SUCCESS;
+}
+
 void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
diff --git a/send.h b/send.h
index 643329b..4f6f5c5 100644
--- a/send.h
+++ b/send.h
@@ -23,6 +23,9 @@
 int batadv_send_skb_packet(struct sk_buff *skb,
 			   struct batadv_hard_iface *hard_iface,
 			   const uint8_t *dst_addr);
+int batadv_send_skb_to_orig(struct batadv_orig_node *orig_node,
+			    struct sk_buff *skb,
+			    struct batadv_hard_iface *recv_if);
 void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface);
 int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				    const struct sk_buff *skb,
diff --git a/translation-table.c b/translation-table.c
index a438f4b..571f8c8 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1446,10 +1446,9 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 {
 	struct sk_buff *skb = NULL;
 	struct batadv_tt_query_packet *tt_request;
-	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_hard_iface *primary_if;
 	struct batadv_tt_req_node *tt_req_node = NULL;
-	int ret = 1;
+	int ret = NET_RX_DROP;
 	size_t tt_req_len;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -1484,26 +1483,17 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
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
+	ret = batadv_send_skb_to_orig(dst_orig_node, skb, NULL);
 
 out:
-	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
-	if (ret)
+	if (ret == NET_RX_DROP)
 		kfree_skb(skb);
 	if (ret && tt_req_node) {
 		spin_lock_bh(&bat_priv->tt_req_list_lock);
@@ -1520,7 +1510,6 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 {
 	struct batadv_orig_node *req_dst_orig_node = NULL;
 	struct batadv_orig_node *res_dst_orig_node = NULL;
-	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
 	uint8_t orig_ttvn, req_ttvn, ttvn;
 	int ret = false;
@@ -1545,10 +1534,6 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	if (!res_dst_orig_node)
 		goto out;
 
-	neigh_node = batadv_orig_node_get_router(res_dst_orig_node);
-	if (!neigh_node)
-		goto out;
-
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
 		goto out;
@@ -1620,13 +1605,12 @@ batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 		tt_response->flags |= BATADV_TT_FULL_TABLE;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Sending TT_RESPONSE %pM via %pM for %pM (ttvn: %u)\n",
-		   res_dst_orig_node->orig, neigh_node->addr,
-		   req_dst_orig_node->orig, req_ttvn);
+		   "Sending TT_RESPONSE %pM for %pM (ttvn: %u)\n",
+		   res_dst_orig_node->orig, req_dst_orig_node->orig, req_ttvn);
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_RESPONSE_TX);
 
-	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_to_orig(res_dst_orig_node, skb, NULL);
 	ret = true;
 	goto out;
 
@@ -1638,8 +1622,6 @@ out:
 		batadv_orig_node_free_ref(res_dst_orig_node);
 	if (req_dst_orig_node)
 		batadv_orig_node_free_ref(req_dst_orig_node);
-	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
 	if (!ret)
@@ -1653,7 +1635,6 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 			   struct batadv_tt_query_packet *tt_request)
 {
 	struct batadv_orig_node *orig_node = NULL;
-	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
 	uint8_t my_ttvn, req_ttvn, ttvn;
 	int ret = false;
@@ -1677,10 +1658,6 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	neigh_node = batadv_orig_node_get_router(orig_node);
-	if (!neigh_node)
-		goto out;
-
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
 		goto out;
@@ -1744,13 +1721,13 @@ batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 		tt_response->flags |= BATADV_TT_FULL_TABLE;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Sending TT_RESPONSE to %pM via %pM [%c]\n",
-		   orig_node->orig, neigh_node->addr,
+		   "Sending TT_RESPONSE to %pM [%c]\n",
+		   orig_node->orig,
 		   (tt_response->flags & BATADV_TT_FULL_TABLE ? 'F' : '.'));
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_RESPONSE_TX);
 
-	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	batadv_send_skb_to_orig(orig_node, skb, NULL);
 	ret = true;
 	goto out;
 
@@ -1759,8 +1736,6 @@ unlock:
 out:
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
-	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
 	if (!ret)
@@ -2028,10 +2003,9 @@ unlock:
 static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 				 struct batadv_orig_node *orig_node)
 {
-	struct batadv_neigh_node *neigh_node = NULL;
 	struct sk_buff *skb = NULL;
 	struct batadv_roam_adv_packet *roam_adv_packet;
-	int ret = 1;
+	int ret = NET_RX_DROP;
 	struct batadv_hard_iface *primary_if;
 	size_t len = sizeof(*roam_adv_packet);
 
@@ -2061,23 +2035,16 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
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
+	ret = batadv_send_skb_to_orig(orig_node, skb, NULL);
 
 out:
-	if (neigh_node)
-		batadv_neigh_node_free_ref(neigh_node);
-	if (ret)
+	if (ret == NET_RX_DROP)
 		kfree_skb(skb);
 	return;
 }
diff --git a/unicast.c b/unicast.c
index 0016464..5568b69 100644
--- a/unicast.c
+++ b/unicast.c
@@ -295,7 +295,7 @@ int batadv_unicast_send_skb(struct sk_buff *skb, struct batadv_priv *bat_priv)
 	struct batadv_orig_node *orig_node;
 	struct batadv_neigh_node *neigh_node;
 	int data_len = skb->len;
-	int ret = 1;
+	int ret = NET_RX_DROP;
 	unsigned int dev_mtu;
 
 	/* get routing information */
@@ -356,16 +356,15 @@ find_router:
 		goto out;
 	}
 
-	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
-	ret = 0;
-	goto out;
+
+	ret = batadv_send_skb_to_orig(orig_node, skb, NULL);
 
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
diff --git a/vis.c b/vis.c
index 2a2ea06..a3120e4 100644
--- a/vis.c
+++ b/vis.c
@@ -698,16 +698,13 @@ static void batadv_purge_vis_packets(struct batadv_priv *bat_priv)
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
-	uint32_t i;
+	uint32_t i, ret;
 
 
 	packet = (struct batadv_vis_packet *)info->skb_packet->data;
@@ -722,30 +719,21 @@ static void batadv_broadcast_vis_packet(struct batadv_priv *bat_priv,
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
 
+			ret = batadv_send_skb_to_orig(orig_node, skb, NULL);
+			if (ret == NET_RX_DROP)
+				kfree_skb(skb);
 		}
 		rcu_read_unlock();
 	}
@@ -755,7 +743,6 @@ static void batadv_unicast_vis_packet(struct batadv_priv *bat_priv,
 				      struct batadv_vis_info *info)
 {
 	struct batadv_orig_node *orig_node;
-	struct batadv_neigh_node *router = NULL;
 	struct sk_buff *skb;
 	struct batadv_vis_packet *packet;
 
@@ -765,17 +752,14 @@ static void batadv_unicast_vis_packet(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
-	router = batadv_orig_node_get_router(orig_node);
-	if (!router)
+	skb = skb_clone(info->skb_packet, GFP_ATOMIC);
+	if (!skb)
 		goto out;
 
-	skb = skb_clone(info->skb_packet, GFP_ATOMIC);
-	if (skb)
-		batadv_send_skb_packet(skb, router->if_incoming, router->addr);
+	if (batadv_send_skb_to_orig(orig_node, skb, NULL) == NET_RX_DROP)
+		kfree_skb(skb);
 
 out:
-	if (router)
-		batadv_neigh_node_free_ref(router);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
 }
-- 
1.7.11.1

