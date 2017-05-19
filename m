Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 19 May 2017 10:01:42 +0200
Message-Id: <20170519080142.21070-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix memory leak when dropping
	packet from other gateway
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

From: Andreas Pape <apape@phoenixcontact.com>

This patch fixes a memory leak introduced with commit "batman-adv:
drop unicast packets from other backbone gw".

Fixes: bfe2a1971f43 ("batman-adv: drop unicast packets from other backbone gw")
Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 net/batman-adv/routing.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index e1ebe14..ae9f4d3 100644
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
1.7.0.4

