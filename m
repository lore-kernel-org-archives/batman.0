Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 29 May 2016 21:25:52 +0200
Message-Id: <1464549952-27830-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: Fix ICMP RR ethernet
	access after skb_linearize
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

The skb_linearize may reallocate the skb. This makes the calculated pointer
for ethhdr invalid. But it the pointer is used later to fill in the RR
field of the batadv_icmp_packet_rr packet.

Instead re-evaluate eth_hdr after the skb_linearize+skb_cow to fix the
pointer and avoid the invalid read.

Fixes: bb69cb678d37 ("batman-adv: generalize batman-adv icmp packet handling")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 0c0c30e..27e07dd 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -374,6 +374,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 		if (skb_cow(skb, ETH_HLEN) < 0)
 			goto out;
 
+		ethhdr = eth_hdr(skb);
 		icmph = (struct batadv_icmp_header *)skb->data;
 		icmp_packet_rr = (struct batadv_icmp_packet_rr *)icmph;
 		if (icmp_packet_rr->rr_cur >= BATADV_RR_LEN)
-- 
2.8.1

