Return-Path: <an.langer@gmx.de>
From: Andreas Langer <an.langer@gmx.de>
Date: Fri, 17 Sep 2010 00:00:08 +0200
Message-Id: <1284674410-15477-4-git-send-email-an.langer@gmx.de>
In-Reply-To: <20100916235908.51ab3bfc@rechenknecht>
References: <20100916235908.51ab3bfc@rechenknecht>
Subject: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv:remove redundant is_my_mac()
	check in route_unicast_packet - callers deal with it
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

Signed-off-by: Andreas Langer <an.langer at gmx.de>
---
 batman-adv/routing.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index c1e32e6..5d17597 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -1145,12 +1145,6 @@ static int route_unicast_packet(struct sk_buff *skb,
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
-	/* packet for me */
-	if (is_my_mac(unicast_packet->dest)) {
-		interface_rx(recv_if->soft_iface, skb, hdr_size);
-		return NET_RX_SUCCESS;
-	}
-
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
 		pr_debug("Warning - can't forward unicast packet from %pM to "
@@ -1184,7 +1178,6 @@ static int route_unicast_packet(struct sk_buff *skb,
 		return NET_RX_DROP;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* decrement ttl */
 	unicast_packet->ttl--;
-- 
1.7.0.4

