Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2011 13:28:41 +0100
Message-Id: <1299328122-21468-28-git-send-email-sven@narfation.org>
In-Reply-To: <1299328122-21468-1-git-send-email-sven@narfation.org>
References: <1299328122-21468-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 27/28] batman-adv: Remove unused hdr_size
	variable in route_unicast_packet()
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

From: Linus Lüssing <linus.luessing@ascom.ch>

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/routing.c        |    7 +++----
 net/batman-adv/routing.h        |    3 +--
 net/batman-adv/soft-interface.c |    2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 42cb6e2..c172f5d 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1263,8 +1263,7 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	return 0;
 }
 
-int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if,
-			 int hdr_size)
+int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
 	struct orig_node *orig_node = NULL;
@@ -1365,7 +1364,7 @@ int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		return NET_RX_SUCCESS;
 	}
 
-	return route_unicast_packet(skb, recv_if, hdr_size);
+	return route_unicast_packet(skb, recv_if);
 }
 
 int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if)
@@ -1398,7 +1397,7 @@ int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		return NET_RX_SUCCESS;
 	}
 
-	return route_unicast_packet(skb, recv_if, hdr_size);
+	return route_unicast_packet(skb, recv_if);
 }
 
 
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 5efceaf..b5a064c 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -30,8 +30,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 void update_routes(struct bat_priv *bat_priv, struct orig_node *orig_node,
 		   struct neigh_node *neigh_node, unsigned char *hna_buff,
 		   int hna_buff_len);
-int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if,
-			 int hdr_size);
+int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if);
 int recv_ucast_frag_packet(struct sk_buff *skb, struct hard_iface *recv_if);
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 95d1c3f..6b514ec 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -462,7 +462,7 @@ void interface_rx(struct net_device *soft_iface,
 
 		memcpy(unicast_packet->dest,
 		       bat_priv->softif_neigh->addr, ETH_ALEN);
-		ret = route_unicast_packet(skb, recv_if, hdr_size);
+		ret = route_unicast_packet(skb, recv_if);
 		if (ret == NET_RX_DROP)
 			goto dropped;
 
-- 
1.7.2.3

