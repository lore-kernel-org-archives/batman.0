Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 19 Mar 2018 17:37:24 +0100
Message-Id: <20180319163726.10921-4-sw@simonwunderlich.de>
In-Reply-To: <20180319163726.10921-1-sw@simonwunderlich.de>
References: <20180319163726.10921-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: fix header size check in
 batadv_dbg_arp()
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

Checking for 0 is insufficient: when an SKB without a batadv header, but
with a VLAN header is received, hdr_size will be 4, making the following
code interpret the Ethernet header as a batadv header.

Fixes: be1db4f6615b ("batman-adv: make the Distributed ARP Table vlan aware")
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 9703c791ffc5..87cd962d28d5 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -393,7 +393,7 @@ static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		   batadv_arp_hw_src(skb, hdr_size), &ip_src,
 		   batadv_arp_hw_dst(skb, hdr_size), &ip_dst);
 
-	if (hdr_size == 0)
+	if (hdr_size < sizeof(struct batadv_unicast_packet))
 		return;
 
 	unicast_4addr_packet = (struct batadv_unicast_4addr_packet *)skb->data;
-- 
2.11.0

