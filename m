Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 15 Feb 2011 18:12:22 +0100
Message-Id: <1297789948-16948-8-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
References: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 07/13] batman-adv: Avoid redundant
	hash_find() call for own unicast packets
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

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 routing.c        |   37 ++++++++++++++++++-------------------
 routing.h        |    8 +++-----
 soft-interface.c |    6 ++++--
 unicast.c        |    4 ++--
 4 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index f8fb709..4899649 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1020,10 +1020,10 @@ out:
 /* find a suitable router for this originator, and use
  * bonding if possible. increases the found neighbors
  * refcount.*/
-struct neigh_node *find_router(struct bat_priv *bat_priv,
-			       struct orig_node *orig_node,
+struct neigh_node *find_router(struct orig_node *orig_node,
 			       struct batman_if *recv_if)
 {
+	struct bat_priv *bat_priv;
 	struct orig_node *primary_orig_node;
 	struct orig_node *router_orig;
 	struct neigh_node *router, *first_candidate, *tmp_neigh_node;
@@ -1036,6 +1036,8 @@ struct neigh_node *find_router(struct bat_priv *bat_priv,
 	if (!orig_node->router)
 		return NULL;
 
+	bat_priv = orig_node->bat_priv;
+
 	/* without bonding, the first node should
 	 * always choose the default router. */
 	bonding_enabled = atomic_read(&bat_priv->bonding);
@@ -1188,22 +1190,15 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	return 0;
 }
 
-int route_unicast_packet(struct bat_priv *bat_priv, struct sk_buff *skb,
-			 struct batman_if *recv_if, uint8_t *dest,
-			 uint8_t packet_type)
+int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
+			 struct orig_node *orig_node, uint8_t packet_type)
 {
-	struct orig_node *orig_node = NULL;
 	struct neigh_node *neigh_node = NULL;
 	int ret = NET_RX_DROP;
 	struct sk_buff *new_skb;
 
-	/* get routing information */
-	orig_node = hash_find_orig(bat_priv, dest);
-	if (!orig_node)
-		goto out;
-
 	/* find_router() increases neigh_nodes refcount if found. */
-	neigh_node = find_router(bat_priv, orig_node, recv_if);
+	neigh_node = find_router(orig_node, recv_if);
 
 	if (!neigh_node)
 		goto out;
@@ -1213,9 +1208,9 @@ int route_unicast_packet(struct bat_priv *bat_priv, struct sk_buff *skb,
 		goto out;
 
 	if (packet_type == BAT_UNICAST &&
-	    atomic_read(&bat_priv->fragmentation) &&
+	    atomic_read(&orig_node->bat_priv->fragmentation) &&
 	    skb->len > neigh_node->if_incoming->net_dev->mtu) {
-		ret = frag_send_skb(skb, bat_priv,
+		ret = frag_send_skb(skb, orig_node->bat_priv,
 				    neigh_node->if_incoming, neigh_node->addr);
 		goto out;
 	}
@@ -1223,7 +1218,7 @@ int route_unicast_packet(struct bat_priv *bat_priv, struct sk_buff *skb,
 	if (packet_type == BAT_UNICAST_FRAG &&
 	    frag_can_reassemble(skb, neigh_node->if_incoming->net_dev->mtu)) {
 
-		ret = frag_reassemble_skb(skb, bat_priv, &new_skb);
+		ret = frag_reassemble_skb(skb, orig_node->bat_priv, &new_skb);
 
 		if (ret == NET_RX_DROP)
 			goto out;
@@ -1254,6 +1249,7 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct unicast_packet *unicast_packet;
+	struct orig_node *orig_node;
 	int hdr_size = sizeof(struct unicast_packet);
 
 	if (check_unicast_packet(skb, hdr_size) < 0)
@@ -1267,14 +1263,16 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		return NET_RX_SUCCESS;
 	}
 
-	return route_unicast_packet(bat_priv, skb, recv_if,
-		unicast_packet->dest, unicast_packet->header.packet_type);
+	orig_node = hash_find_orig(bat_priv, unicast_packet->dest);
+	return route_unicast_packet(skb, recv_if, orig_node,
+				    unicast_packet->header.packet_type);
 }
 
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct unicast_frag_packet *unicast_packet;
+	struct orig_node *orig_node;
 	int hdr_size = sizeof(struct unicast_frag_packet);
 	struct sk_buff *new_skb = NULL;
 	int ret;
@@ -1301,8 +1299,9 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		return NET_RX_SUCCESS;
 	}
 
-	return route_unicast_packet(bat_priv, skb, recv_if,
-		unicast_packet->dest, unicast_packet->header.packet_type);
+	orig_node = hash_find_orig(bat_priv, unicast_packet->dest);
+	return route_unicast_packet(skb, recv_if, orig_node,
+				    unicast_packet->header.packet_type);
 }
 
 
diff --git a/batman-adv/routing.h b/batman-adv/routing.h
index 406f396..3c04bb0 100644
--- a/batman-adv/routing.h
+++ b/batman-adv/routing.h
@@ -30,17 +30,15 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		   struct neigh_node *neigh_node, unsigned char *hna_buff,
 		   int hna_buff_len);
-int route_unicast_packet(struct bat_priv *bat_priv, struct sk_buff *skb,
-			 struct batman_if *recv_if, uint8_t *dest,
-			 uint8_t packet_type);
+int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
+			 struct orig_node *orig_node, uint8_t packet_type);
 int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_vis_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_bat_packet(struct sk_buff *skb, struct batman_if *recv_if);
-struct neigh_node *find_router(struct bat_priv *bat_priv,
-			       struct orig_node *orig_node,
+struct neigh_node *find_router(struct orig_node *orig_node,
 			       struct batman_if *recv_if);
 void bonding_candidate_del(struct orig_node *orig_node,
 			   struct neigh_node *neigh_node);
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 23f374a..7225764 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -439,6 +439,7 @@ void interface_rx(struct net_device *soft_iface,
 {
 	struct bat_priv *bat_priv = netdev_priv(soft_iface);
 	struct unicast_packet *unicast_packet;
+	struct orig_node *orig_node;
 	struct ethhdr *ethhdr;
 	struct vlan_ethhdr *vhdr;
 	short vid = -1;
@@ -482,8 +483,9 @@ void interface_rx(struct net_device *soft_iface,
 
 		memcpy(unicast_packet->dest,
 		       bat_priv->softif_neigh->addr, ETH_ALEN);
-		ret = route_unicast_packet(bat_priv, skb, recv_if,
-					   unicast_packet->dest,
+
+		orig_node = hash_find_orig(bat_priv, unicast_packet->dest);
+		ret = route_unicast_packet(skb, recv_if, orig_node,
 					   unicast_packet->header.packet_type);
 		if (ret == NET_RX_DROP)
 			goto dropped;
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index df69514..7262a22 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -308,8 +308,8 @@ route:
 	/* copy the destination for faster routing */
 	memcpy(unicast_packet->dest, orig_node->orig, ETH_ALEN);
 
-	ret = route_unicast_packet(orig_node->bat_priv, skb, NULL,
-		unicast_packet->dest, unicast_packet->header.packet_type);
+	ret = route_unicast_packet(skb, NULL, orig_node,
+				   unicast_packet->header.packet_type);
 
 out:
 	if (ret == NET_RX_DROP)
-- 
1.7.2.3

