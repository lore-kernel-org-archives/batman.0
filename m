Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 15 Feb 2011 18:12:19 +0100
Message-Id: <1297789948-16948-5-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
References: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 04/13] batman-adv: Make
	route_unicast_packet() packet_type independent
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
 routing.c        |   20 +++++++++-----------
 routing.h        |    3 ++-
 soft-interface.c |    3 ++-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 293bb32..e53f6f5 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1204,22 +1204,20 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	return 0;
 }
 
-int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
+int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
+			 uint8_t *dest, uint8_t packet_type)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct orig_node *orig_node = NULL;
 	struct neigh_node *neigh_node = NULL;
-	struct unicast_packet *unicast_packet;
 	int ret = NET_RX_DROP;
 	struct sk_buff *new_skb;
 
-	unicast_packet = (struct unicast_packet *)skb->data;
-
 	/* get routing information */
 	rcu_read_lock();
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
-			       unicast_packet->dest));
+			       dest));
 
 	if (!orig_node)
 		goto unlock;
@@ -1237,9 +1235,7 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
 		goto out;
 
-	unicast_packet = (struct unicast_packet *)skb->data;
-
-	if (unicast_packet->header.packet_type == BAT_UNICAST &&
+	if (packet_type == BAT_UNICAST &&
 	    atomic_read(&bat_priv->fragmentation) &&
 	    skb->len > neigh_node->if_incoming->net_dev->mtu) {
 		ret = frag_send_skb(skb, bat_priv,
@@ -1247,7 +1243,7 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		goto out;
 	}
 
-	if (unicast_packet->header.packet_type == BAT_UNICAST_FRAG &&
+	if (packet_type == BAT_UNICAST_FRAG &&
 	    frag_can_reassemble(skb, neigh_node->if_incoming->net_dev->mtu)) {
 
 		ret = frag_reassemble_skb(skb, bat_priv, &new_skb);
@@ -1295,7 +1291,8 @@ int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		return NET_RX_SUCCESS;
 	}
 
-	return route_unicast_packet(skb, recv_if);
+	return route_unicast_packet(skb, recv_if, unicast_packet->dest,
+				    unicast_packet->header.packet_type);
 }
 
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
@@ -1328,7 +1325,8 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		return NET_RX_SUCCESS;
 	}
 
-	return route_unicast_packet(skb, recv_if);
+	return route_unicast_packet(skb, recv_if, unicast_packet->dest,
+				    unicast_packet->header.packet_type);
 }
 
 
diff --git a/batman-adv/routing.h b/batman-adv/routing.h
index d302bd7..c6b2ad3 100644
--- a/batman-adv/routing.h
+++ b/batman-adv/routing.h
@@ -30,7 +30,8 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		   struct neigh_node *neigh_node, unsigned char *hna_buff,
 		   int hna_buff_len);
-int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
+int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
+			 uint8_t *dest, uint8_t packet_type);
 int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if);
 int recv_ucast_frag_packet(struct sk_buff *skb, struct batman_if *recv_if);
diff --git a/batman-adv/soft-interface.c b/batman-adv/soft-interface.c
index 55edebb..0b48bf1 100644
--- a/batman-adv/soft-interface.c
+++ b/batman-adv/soft-interface.c
@@ -482,7 +482,8 @@ void interface_rx(struct net_device *soft_iface,
 
 		memcpy(unicast_packet->dest,
 		       bat_priv->softif_neigh->addr, ETH_ALEN);
-		ret = route_unicast_packet(skb, recv_if);
+		ret = route_unicast_packet(skb, recv_if, unicast_packet->dest,
+					   unicast_packet->header.packet_type);
 		if (ret == NET_RX_DROP)
 			goto dropped;
 
-- 
1.7.2.3

