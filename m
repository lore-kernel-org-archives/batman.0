Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 13:48:57 +0200
Message-Id: <1336823339-4095-6-git-send-email-sven@narfation.org>
In-Reply-To: <1336823339-4095-1-git-send-email-sven@narfation.org>
References: <1336823339-4095-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/8] batman-adv: Prefix unicast static inline
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

All non-static symbols of batman-adv were prefixed with batadv_ to avoid
collisions with other symbols of the kernel. Other symbols of batman-adv
should use the same prefix to keep the naming scheme consistent.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 distributed-arp-table.c |    2 +-
 routing.c               |    3 ++-
 soft-interface.c        |    2 +-
 unicast.h               |   12 ++++++------
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index a0b38b1..68dbde1 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -498,7 +498,7 @@ bool batadv_dat_snoop_incoming_arp_request(struct bat_priv *bat_priv,
 
 	inc_counter(bat_priv, BAT_CNT_DAT_REPLY_TX);
 
-	unicast_4addr_send_skb(skb_new, bat_priv, BAT_P_DAT_CACHE_REPLY);
+	batadv_unicast_4addr_send_skb(skb_new, bat_priv, BAT_P_DAT_CACHE_REPLY);
 
 	ret = true;
 out:
diff --git a/routing.c b/routing.c
index 4741cdc..b1a1732 100644
--- a/routing.c
+++ b/routing.c
@@ -867,7 +867,8 @@ static int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	}
 
 	if (unicast_packet->header.packet_type == BAT_UNICAST_FRAG &&
-	    frag_can_reassemble(skb, neigh_node->if_incoming->net_dev->mtu)) {
+	    batadv_frag_can_reassemble(skb,
+				       neigh_node->if_incoming->net_dev->mtu)) {
 
 		ret = batadv_frag_reassemble_skb(skb, bat_priv, &new_skb);
 
diff --git a/soft-interface.c b/soft-interface.c
index faba6f3..fc3ea29 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -245,7 +245,7 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 
 		batadv_dat_snoop_outgoing_arp_reply(bat_priv, skb);
 
-		ret = unicast_send_skb(skb, bat_priv);
+		ret = batadv_unicast_send_skb(skb, bat_priv);
 		if (ret != 0)
 			goto dropped_freed;
 	}
diff --git a/unicast.h b/unicast.h
index c09ebbc..a9a71af 100644
--- a/unicast.h
+++ b/unicast.h
@@ -39,21 +39,21 @@ int batadv_unicast_generic_send_skb(struct sk_buff *skb,
 				    struct bat_priv *bat_priv,
 				    int packet_type, int packet_subtype);
 
-static inline int unicast_send_skb(struct sk_buff *skb,
-				   struct bat_priv *bat_priv)
+static inline int batadv_unicast_send_skb(struct sk_buff *skb,
+					  struct bat_priv *bat_priv)
 {
 	return batadv_unicast_generic_send_skb(skb, bat_priv, BAT_UNICAST, 0);
 }
 
-static inline int unicast_4addr_send_skb(struct sk_buff *skb,
-					 struct bat_priv *bat_priv,
-					 int packet_subtype)
+static inline int batadv_unicast_4addr_send_skb(struct sk_buff *skb,
+						struct bat_priv *bat_priv,
+						int packet_subtype)
 {
 	return batadv_unicast_generic_send_skb(skb, bat_priv, BAT_UNICAST_4ADDR,
 					       packet_subtype);
 }
 
-static inline int frag_can_reassemble(const struct sk_buff *skb, int mtu)
+static inline int batadv_frag_can_reassemble(const struct sk_buff *skb, int mtu)
 {
 	const struct unicast_frag_packet *unicast_packet;
 	int uneven_correction = 0;
-- 
1.7.10

