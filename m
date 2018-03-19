Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 19 Mar 2018 17:37:23 +0100
Message-Id: <20180319163726.10921-3-sw@simonwunderlich.de>
In-Reply-To: <20180319163726.10921-1-sw@simonwunderlich.de>
References: <20180319163726.10921-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: update data pointers after
 skb_cow()
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Matthias Schiffer <mschiffer@universe-factory.net>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Matthias Schiffer <mschiffer@universe-factory.net>

batadv_check_unicast_ttvn() calls skb_cow(), so pointers into the SKB data
must be (re)set after calling it. The ethhdr variable is dropped
altogether.

Fixes: 7cdcf6dddc42 ("batman-adv: add UNICAST_4ADDR packet type")
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index b6891e8b741c..6a9242658c8d 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -968,14 +968,10 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	struct batadv_orig_node *orig_node = NULL, *orig_node_gw = NULL;
 	int check, hdr_size = sizeof(*unicast_packet);
 	enum batadv_subtype subtype;
-	struct ethhdr *ethhdr;
 	int ret = NET_RX_DROP;
 	bool is4addr, is_gw;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
-	unicast_4addr_packet = (struct batadv_unicast_4addr_packet *)skb->data;
-	ethhdr = eth_hdr(skb);
-
 	is4addr = unicast_packet->packet_type == BATADV_UNICAST_4ADDR;
 	/* the caller function should have already pulled 2 bytes */
 	if (is4addr)
@@ -995,12 +991,14 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	if (!batadv_check_unicast_ttvn(bat_priv, skb, hdr_size))
 		goto free_skb;
 
+	unicast_packet = (struct batadv_unicast_packet *)skb->data;
+
 	/* packet for me */
 	if (batadv_is_my_mac(bat_priv, unicast_packet->dest)) {
 		/* If this is a unicast packet from another backgone gw,
 		 * drop it.
 		 */
-		orig_addr_gw = ethhdr->h_source;
+		orig_addr_gw = eth_hdr(skb)->h_source;
 		orig_node_gw = batadv_orig_hash_find(bat_priv, orig_addr_gw);
 		if (orig_node_gw) {
 			is_gw = batadv_bla_is_backbone_gw(skb, orig_node_gw,
@@ -1015,6 +1013,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 		}
 
 		if (is4addr) {
+			unicast_4addr_packet =
+				(struct batadv_unicast_4addr_packet *)skb->data;
 			subtype = unicast_4addr_packet->subtype;
 			batadv_dat_inc_counter(bat_priv, subtype);
 
-- 
2.11.0

