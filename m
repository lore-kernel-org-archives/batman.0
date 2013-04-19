Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 19 Apr 2013 21:01:40 +0200
Message-Id: <1366398101-31363-3-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1366398101-31363-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1366398101-31363-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: reorder packet types
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Reordering the packet type numbers allows us to handle unicast
packets in a general way - even if we don't know the specific packet
type, we can still forward it. There was already code handling
this for a couple of unicast packets, and this is the more
generalized version to do that.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 main.c    |   28 +++++++++++++++++++++++-----
 packet.h  |   34 +++++++++++++++++++++++++---------
 routing.c |   19 +++++++++++++++++++
 routing.h |    2 ++
 4 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/main.c b/main.c
index a003067..5c0a8db 100644
--- a/main.c
+++ b/main.c
@@ -328,18 +328,31 @@ static void batadv_recv_handler_init(void)
 	for (i = 0; i < ARRAY_SIZE(batadv_rx_handler); i++)
 		batadv_rx_handler[i] = batadv_recv_unhandled_packet;
 
-	/* batman icmp packet */
-	batadv_rx_handler[BATADV_ICMP] = batadv_recv_icmp_packet;
+	for (i = BATADV_UNICAST_MIN; i <= BATADV_UNICAST_MAX; i++)
+		batadv_rx_handler[i] = batadv_recv_unhandled_unicast_packet;
+
+	/* compile time checks for struct member offsets */
+	BUILD_BUG_ON(offsetof(struct batadv_unicast_4addr_packet, src) != 10);
+	BUILD_BUG_ON(offsetof(struct batadv_unicast_packet, dest) != 4);
+	BUILD_BUG_ON(offsetof(struct batadv_unicast_frag_packet, dest) != 4);
+	BUILD_BUG_ON(offsetof(struct batadv_unicast_tvlv_packet, dst) != 4);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet, dst) != 4);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet_rr, dst) != 4);
+
+	/* broadcast packet */
+	batadv_rx_handler[BATADV_BCAST] = batadv_recv_bcast_packet;
+
+	/* unicast packets ... */
 	/* unicast with 4 addresses packet */
 	batadv_rx_handler[BATADV_UNICAST_4ADDR] = batadv_recv_unicast_packet;
 	/* unicast packet */
 	batadv_rx_handler[BATADV_UNICAST] = batadv_recv_unicast_packet;
 	/* fragmented unicast packet */
 	batadv_rx_handler[BATADV_UNICAST_FRAG] = batadv_recv_ucast_frag_packet;
-	/* broadcast packet */
-	batadv_rx_handler[BATADV_BCAST] = batadv_recv_bcast_packet;
 	/* unicast tvlv packet */
 	batadv_rx_handler[BATADV_UNICAST_TVLV] = batadv_recv_unicast_tvlv;
+	/* batman icmp packet */
+	batadv_rx_handler[BATADV_ICMP] = batadv_recv_icmp_packet;
 }
 
 int
@@ -347,7 +360,12 @@ batadv_recv_handler_register(uint8_t packet_type,
 			     int (*recv_handler)(struct sk_buff *,
 						 struct batadv_hard_iface *))
 {
-	if (batadv_rx_handler[packet_type] != &batadv_recv_unhandled_packet)
+	int (*curr)(struct sk_buff *,
+		    struct batadv_hard_iface *);
+	curr = batadv_rx_handler[packet_type];
+
+	if ((curr != batadv_recv_unhandled_packet) &&
+	    (curr != batadv_recv_unhandled_unicast_packet))
 		return -EBUSY;
 
 	batadv_rx_handler[packet_type] = recv_handler;
diff --git a/packet.h b/packet.h
index 8ec9cf7..c90856d 100644
--- a/packet.h
+++ b/packet.h
@@ -22,18 +22,34 @@
 
 /**
  * enum batadv_packettype - types for batman-adv encapsulated packets
+ * @BATADV_IV_OGM: originator messages for B.A.T.M.A.N. IV
+ * @BATADV_BCAST: broadcast packets carrying broadcast payload
+ * @BATADV_CODED: network coded packets
+ *
+ * @BATADV_UNICAST: unicast packets carrying unicast payload traffic
+ * @BATADV_UNICAST_FRAG: unicast packets carrying a fragment of the original
+ *	payload packet
+ * @BATADV_UNICAST_4ADDR: unicast packet including the originator address of
+ *	the sender
+ * @BATADV_ICMP: unicast packet like IP ICMP used for ping or traceroute
  * @BATADV_UNICAST_TVLV: unicast packet carrying TVLV containers
+ *
  */
+
 enum batadv_packettype {
-	BATADV_IV_OGM		= 0x01,
-	BATADV_ICMP		= 0x02,
-	BATADV_UNICAST		= 0x03,
-	BATADV_BCAST		= 0x04,
-	BATADV_VIS		= 0x05,
-	BATADV_UNICAST_FRAG	= 0x06,
-	BATADV_UNICAST_4ADDR	= 0x09,
-	BATADV_CODED		= 0x0a,
-	BATADV_UNICAST_TVLV	= 0x0b,
+	/* 0x00 - 0x3f: local packets or special rules for handling */
+	BATADV_IV_OGM		= 0x00,
+	BATADV_BCAST		= 0x01,
+	BATADV_CODED		= 0x02,
+	/* 0x40 - 0x7f: unicast */
+#define BATADV_UNICAST_MIN	0x40
+	BATADV_UNICAST		= 0x40,
+	BATADV_UNICAST_FRAG	= 0x41,
+	BATADV_UNICAST_4ADDR	= 0x42,
+	BATADV_ICMP		= 0x43,
+	BATADV_UNICAST_TVLV	= 0x44,
+#define BATADV_UNICAST_MAX	0x7f
+	/* 0x80 - 0xff: reserved */
 };
 
 /**
diff --git a/routing.c b/routing.c
index d48f9f9..b63a002 100644
--- a/routing.c
+++ b/routing.c
@@ -892,6 +892,25 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	return 1;
 }
 
+int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
+					 struct batadv_hard_iface *recv_if)
+{
+	struct batadv_unicast_packet *unicast_packet;
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	int check, hdr_size = sizeof(*unicast_packet);
+
+	check = batadv_check_unicast_packet(bat_priv, skb, hdr_size);
+	if (check < 0)
+		return NET_RX_DROP;
+
+	/* we don't know about this type, drop it. */
+	unicast_packet = (struct batadv_unicast_packet *)skb->data;
+	if (batadv_is_my_mac(bat_priv, unicast_packet->dest))
+		return NET_RX_DROP;
+
+	return batadv_route_unicast_packet(skb, recv_if);
+}
+
 int batadv_recv_unicast_packet(struct sk_buff *skb,
 			       struct batadv_hard_iface *recv_if)
 {
diff --git a/routing.h b/routing.h
index 0a7983b..33cdf6c 100644
--- a/routing.h
+++ b/routing.h
@@ -42,6 +42,8 @@ int batadv_recv_roam_adv(struct sk_buff *skb,
 			 struct batadv_hard_iface *recv_if);
 int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
+int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
+					 struct batadv_hard_iface *recv_if);
 struct batadv_neigh_node *
 batadv_find_router(struct batadv_priv *bat_priv,
 		   struct batadv_orig_node *orig_node,
-- 
1.7.10.4

