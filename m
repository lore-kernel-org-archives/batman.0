Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 15 Feb 2011 18:12:21 +0100
Message-Id: <1297789948-16948-7-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
References: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 06/13] batman-adv: Use route_unicast_packet()
	for sending own unicast packets
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

This removes some redundancy present in unicast_send_skb(). It now
invokes route_unicast_packet() for the next hop decision and sending.

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 routing.c        |   15 ++++++++-------
 routing.h        |    5 +++--
 soft-interface.c |    3 ++-
 unicast.c        |   41 +++++++----------------------------------
 4 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 081c461..f8fb709 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1188,10 +1188,10 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	return 0;
 }
 
-int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
-			 uint8_t *dest, uint8_t packet_type)
+int route_unicast_packet(struct bat_priv *bat_priv, struct sk_buff *skb,
+			 struct batman_if *recv_if, uint8_t *dest,
+			 uint8_t packet_type)
 {
-	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct orig_node *orig_node = NULL;
 	struct neigh_node *neigh_node = NULL;
 	int ret = NET_RX_DROP;
@@ -1252,6 +1252,7 @@ out:
 
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
+	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct unicast_packet *unicast_packet;
 	int hdr_size = sizeof(struct unicast_packet);
 
@@ -1266,8 +1267,8 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		return NET_RX_SUCCESS;
 	}
 
-	return route_unicast_packet(skb, recv_if, unicast_packet->dest,
-				    unicast_packet->header.packet_type);
+	return route_unicast_packet(bat_priv, skb, recv_if,
+		unicast_packet->dest, unicast_packet->header.packet_type);
 }
 
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
@@ -1300,8 +1301,8 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		return NET_RX_SUCCESS;
 	}
 
-	return route_unicast_packet(skb, recv_if, unicast_packet->dest,
-				    unicast_packet->header.packet_type);
+	return route_unicast_packet(bat_priv, skb, recv_if,
+		unicast_packet->dest, unicast_packet->header.packet_type);
 }
 
 
diff --git a/batman-adv/routing.h b/batman-adv/routing.h
index c6b2ad3..406f396 100644
--- a/batman-adv/routing.h
+++ b/batman-adv/routing.h
@@ -30,8 +30,9 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		   struct neigh_node *neigh_node, unsigned char *hna_buff,
 		   int hna_buff_len);
-int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
-			 uint8_t *dest, uint8_t packet_type);
+int route_unicast_packet(struct bat_priv *bat_priv, struct sk_buff *skb,
+			 struct batman_if *recv_if, uint8_t *dest,
+			 uint8_t packet_type);
 int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if);
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 0b48bf1..23f374a 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -482,7 +482,8 @@ void interface_rx(struct net_device *soft_iface,
 
 		memcpy(unicast_packet->dest,
 		       bat_priv->softif_neigh->addr, ETH_ALEN);
-		ret = route_unicast_packet(skb, recv_if, unicast_packet->dest,
+		ret = route_unicast_packet(bat_priv, skb, recv_if,
+					   unicast_packet->dest,
 					   unicast_packet->header.packet_type);
 		if (ret == NET_RX_DROP)
 			goto dropped;
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 4d794cb..df69514 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -282,34 +282,19 @@ int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv)
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct unicast_packet *unicast_packet;
 	struct orig_node *orig_node;
-	struct neigh_node *neigh_node;
-	int data_len = skb->len;
-	int ret = 1;
+	int ret = NET_RX_DROP;
 
 	/* get routing information */
 	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		orig_node = (struct orig_node *)gw_get_selected(bat_priv);
 		if (orig_node)
-			goto find_router;
+			goto route;
 	}
 
 	/* check for hna host - increases orig_node refcount */
 	orig_node = transtable_search(bat_priv, ethhdr->h_dest);
 
-find_router:
-	/**
-	 * find_router():
-	 *  - if orig_node is NULL it returns NULL
-	 *  - increases neigh_nodes refcount if found.
-	 */
-	neigh_node = find_router(bat_priv, orig_node, NULL);
-
-	if (!neigh_node)
-		goto out;
-
-	if (neigh_node->if_incoming->if_status != IF_ACTIVE)
-		goto out;
-
+route:
 	if (my_skb_head_push(skb, sizeof(struct unicast_packet)) < 0)
 		goto out;
 
@@ -323,24 +308,12 @@ find_router:
 	/* copy the destination for faster routing */
 	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
 
-	if (atomic_read(&bat_priv->fragmentation) &&
-	    data_len + sizeof(struct unicast_packet) >
-				neigh_node->if_incoming->net_dev->mtu) {
-		ret = frag_send_skb(skb, bat_priv,
-				    neigh_node->if_incoming, neigh_node->addr);
-		goto out;
-	}
-
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
-	ret = 0;
-	goto out;
+	ret = route_unicast_packet(orig_node->bat_priv, skb, NULL,
+		unicast_packet->dest, unicast_packet->header.packet_type);
 
 out:
-	if (neigh_node)
-		neigh_node_free_ref(neigh_node);
-	if (orig_node)
-		kref_put(&orig_node->refcount, orig_node_free_ref);
-	if (ret == 1)
+	if (ret == NET_RX_DROP)
 		kfree_skb(skb);
+
 	return ret;
 }
-- 
1.7.2.3

