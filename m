Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 26 Jan 2017 17:44:03 +0100
Message-Id: <20170126164404.16074-7-sw@simonwunderlich.de>
In-Reply-To: <20170126164404.16074-1-sw@simonwunderlich.de>
References: <20170126164404.16074-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 6/7] batman-adv: Remove one condition check
	in batadv_route_unicast_packet
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
Cc: Gao Feng <gfree.wind@gmail.com>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Gao Feng <gfree.wind@gmail.com>

It could decrease one condition check to collect some statements in the
first condition block.

Signed-off-by: Gao Feng <gfree.wind@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 5f050fbdfff7..7fd740b6e36d 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -719,20 +719,19 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 
 	len = skb->len;
 	res = batadv_send_skb_to_orig(skb, orig_node, recv_if);
-	if (res == NET_XMIT_SUCCESS)
-		ret = NET_RX_SUCCESS;
-
-	/* skb was consumed */
-	skb = NULL;
 
 	/* translate transmit result into receive result */
 	if (res == NET_XMIT_SUCCESS) {
+		ret = NET_RX_SUCCESS;
 		/* skb was transmitted and consumed */
 		batadv_inc_counter(bat_priv, BATADV_CNT_FORWARD);
 		batadv_add_counter(bat_priv, BATADV_CNT_FORWARD_BYTES,
 				   len + ETH_HLEN);
 	}
 
+	/* skb was consumed */
+	skb = NULL;
+
 put_orig_node:
 	batadv_orig_node_put(orig_node);
 free_skb:
-- 
2.11.0

