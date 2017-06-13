Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 13 Jun 2017 13:15:31 +0200
Message-Id: <20170613111531.29082-3-sw@simonwunderlich.de>
In-Reply-To: <20170613111531.29082-1-sw@simonwunderlich.de>
References: <20170613111531.29082-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: fix memory leak when
 dropping packet from other gateway
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Andreas Pape <apape@phoenixcontact.com>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Andreas Pape <apape@phoenixcontact.com>

The skb must be released in the receive handler since b91a2543b4c1
("batman-adv: Consume skb in receive handlers"). Just returning NET_RX_DROP
will no longer automatically free the memory. This results in memory leaks
when unicast packets from other backbones must be dropped because they
share a common backbone.

Fixes: 9e794b6bf4a2 ("batman-adv: drop unicast packets from other backbone gw")
Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
[sven@narfation.org: adjust commit message]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index e1ebe14ee2a6..ae9f4d37d34f 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -987,7 +987,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 				batadv_dbg(BATADV_DBG_BLA, bat_priv,
 					   "recv_unicast_packet(): Dropped unicast pkt received from another backbone gw %pM.\n",
 					   orig_addr_gw);
-				return NET_RX_DROP;
+				goto free_skb;
 			}
 		}
 
-- 
2.11.0

