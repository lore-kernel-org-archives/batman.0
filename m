Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Fri, 16 Mar 2018 11:29:09 +0100
Message-Id: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCH maint 1/3] batman-adv: update data pointers
 after skb_cow()
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

batadv_check_unicast_ttvn() calls skb_cow(), so pointers into the SKB data
must be (re)set after calling it. The ethhdr variable is dropped
altogether.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 net/batman-adv/routing.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 289df027ecdd..0f10c565ac85 100644
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
2.16.2

