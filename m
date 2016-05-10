Return-Path: <fw@breakpoint.cc>
From: Florian Westphal <fw@strlen.de>
Date: Tue, 10 May 2016 23:17:59 +0200
Message-Id: <1462915079-22681-1-git-send-email-fw@strlen.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix skb deref after free
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
Cc: Florian Westphal <fw@strlen.de>

batadv_send_skb_to_orig() calls dev_queue_xmit() so we can't use skb->len.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Noticed during review, compile tested only.

 net/batman-adv/routing.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index b781bf7..0c0c30e 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -601,6 +601,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 	struct batadv_unicast_packet *unicast_packet;
 	struct ethhdr *ethhdr = eth_hdr(skb);
 	int res, hdr_len, ret = NET_RX_DROP;
+	unsigned int len;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 
@@ -641,6 +642,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 	if (hdr_len > 0)
 		batadv_skb_set_priority(skb, hdr_len);
 
+	len = skb->len;
 	res = batadv_send_skb_to_orig(skb, orig_node, recv_if);
 
 	/* translate transmit result into receive result */
@@ -648,7 +650,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 		/* skb was transmitted and consumed */
 		batadv_inc_counter(bat_priv, BATADV_CNT_FORWARD);
 		batadv_add_counter(bat_priv, BATADV_CNT_FORWARD_BYTES,
-				   skb->len + ETH_HLEN);
+				   len + ETH_HLEN);
 
 		ret = NET_RX_SUCCESS;
 	} else if (res == NET_XMIT_POLICED) {
-- 
2.7.3

