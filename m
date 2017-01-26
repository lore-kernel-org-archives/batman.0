Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 26 Jan 2017 08:52:50 +0100
Message-Id: <20170126075250.12345-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Simplify handling of NET_XMIT_CN
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
Cc: Gao Feng <gfree.wind@gmail.com>

The handling of NET_XMIT_CN can be avoided in functions which (indirectly)
are using batadv_send_skb_packet. Instead batadv_send_skb_packet can take
care that the return code of dev_queue_xmit is never NET_XMIT_CN.
NET_XMIT_CN will therefore always be mapped to a NET_XMIT_SUCCESS.

Cc: Gao Feng <gfree.wind@gmail.com>
Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
The result of this change is:

 - all code changes of
   1120b81c7418 ("batman-adv: Treat NET_XMIT_CN as transmit successfully")
   are reverted
 - The change to send.c is added

 net/batman-adv/distributed-arp-table.c | 3 +--
 net/batman-adv/fragmentation.c         | 2 +-
 net/batman-adv/routing.c               | 9 +++++----
 net/batman-adv/send.c                  | 2 +-
 net/batman-adv/soft-interface.c        | 2 +-
 net/batman-adv/tp_meter.c              | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index b13c018..1bfd1db 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -659,8 +659,7 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 		}
 
 		send_status = batadv_send_unicast_skb(tmp_skb, neigh_node);
-		if (send_status == NET_XMIT_SUCCESS ||
-		    send_status == NET_XMIT_CN) {
+		if (send_status == NET_XMIT_SUCCESS) {
 			/* count the sent packet */
 			switch (packet_subtype) {
 			case BATADV_P_DAT_DHT_GET:
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index eb85153..ead18ca 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -509,7 +509,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 		batadv_add_counter(bat_priv, BATADV_CNT_FRAG_TX_BYTES,
 				   skb_fragment->len + ETH_HLEN);
 		ret = batadv_send_unicast_skb(skb_fragment, neigh_node);
-		if (ret != NET_XMIT_SUCCESS && ret != NET_XMIT_CN) {
+		if (ret != NET_XMIT_SUCCESS) {
 			ret = NET_XMIT_DROP;
 			goto put_primary_if;
 		}
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index bf5a0b9..7fd740b 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -262,7 +262,7 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 		icmph->ttl = BATADV_TTL;
 
 		res = batadv_send_skb_to_orig(skb, orig_node, NULL);
-		if (res == NET_XMIT_SUCCESS || res == NET_XMIT_CN)
+		if (res == NET_XMIT_SUCCESS)
 			ret = NET_RX_SUCCESS;
 
 		/* skb was consumed */
@@ -330,7 +330,7 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	icmp_packet->ttl = BATADV_TTL;
 
 	res = batadv_send_skb_to_orig(skb, orig_node, NULL);
-	if (res == NET_RX_SUCCESS || res == NET_XMIT_CN)
+	if (res == NET_RX_SUCCESS)
 		ret = NET_XMIT_SUCCESS;
 
 	/* skb was consumed */
@@ -424,7 +424,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 
 	/* route it */
 	res = batadv_send_skb_to_orig(skb, orig_node, recv_if);
-	if (res == NET_XMIT_SUCCESS || res == NET_XMIT_CN)
+	if (res == NET_XMIT_SUCCESS)
 		ret = NET_RX_SUCCESS;
 
 	/* skb was consumed */
@@ -719,8 +719,9 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 
 	len = skb->len;
 	res = batadv_send_skb_to_orig(skb, orig_node, recv_if);
+
 	/* translate transmit result into receive result */
-	if (res == NET_XMIT_SUCCESS || res == NET_XMIT_CN) {
+	if (res == NET_XMIT_SUCCESS) {
 		ret = NET_RX_SUCCESS;
 		/* skb was transmitted and consumed */
 		batadv_inc_counter(bat_priv, BATADV_CNT_FORWARD);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index d730826..d9b2889 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -115,7 +115,7 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP
 	 * (which is > 0). This will not be treated as an error.
 	 */
-	return dev_queue_xmit(skb);
+	return net_xmit_eval(dev_queue_xmit(skb));
 send_skb_err:
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index b506781..5d099b2 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -387,7 +387,7 @@ send:
 			ret = batadv_send_skb_via_tt(bat_priv, skb, dst_hint,
 						     vid);
 		}
-		if (ret != NET_XMIT_SUCCESS && ret != NET_XMIT_CN)
+		if (ret != NET_XMIT_SUCCESS)
 			goto dropped_freed;
 	}
 
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 392a60d..07f64b6 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -615,7 +615,7 @@ static int batadv_tp_send_msg(struct batadv_tp_vars *tp_vars, const u8 *src,
 	batadv_tp_fill_prerandom(tp_vars, data, data_len);
 
 	r = batadv_send_skb_to_orig(skb, orig_node, NULL);
-	if (r == NET_XMIT_SUCCESS || r == NET_XMIT_CN)
+	if (r == NET_XMIT_SUCCESS)
 		return 0;
 
 	return BATADV_TP_REASON_CANT_SEND;
-- 
2.11.0

