Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 27 Dec 2016 08:51:17 +0100
Message-Id: <20161227075117.5802-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [[PATCH maint]] batman-adv: Decrease hardif refcnt
	on fragmentation send error
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

An error before the hardif is found has to free the skb. But every error
after that has to free the skb + put the hard interface.

Fixes: 8b4132b1447a ("batman-adv: Consume skb in batadv_frag_send_packet")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/fragmentation.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 9c561e68..0854ebd8 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -474,7 +474,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if) {
 		ret = -EINVAL;
-		goto put_primary_if;
+		goto free_skb;
 	}
 
 	/* Create one header to be copied to all fragments */
@@ -502,7 +502,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 		skb_fragment = batadv_frag_create(skb, &frag_header, mtu);
 		if (!skb_fragment) {
 			ret = -ENOMEM;
-			goto free_skb;
+			goto put_primary_if;
 		}
 
 		batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_TX);
@@ -511,7 +511,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 		ret = batadv_send_unicast_skb(skb_fragment, neigh_node);
 		if (ret != NET_XMIT_SUCCESS) {
 			ret = NET_XMIT_DROP;
-			goto free_skb;
+			goto put_primary_if;
 		}
 
 		frag_header.no++;
@@ -519,7 +519,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 		/* The initial check in this function should cover this case */
 		if (frag_header.no == BATADV_FRAG_MAX_FRAGMENTS - 1) {
 			ret = -EINVAL;
-			goto free_skb;
+			goto put_primary_if;
 		}
 	}
 
@@ -527,7 +527,7 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 	if (batadv_skb_head_push(skb, header_size) < 0 ||
 	    pskb_expand_head(skb, header_size + ETH_HLEN, 0, GFP_ATOMIC) < 0) {
 		ret = -ENOMEM;
-		goto free_skb;
+		goto put_primary_if;
 	}
 
 	memcpy(skb->data, &frag_header, header_size);
-- 
2.11.0

