Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 27 Jan 2013 20:43:59 +0100
Message-Id: <1359315839-24136-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1359315839-24136-1-git-send-email-ordex@autistici.org>
References: <1359315839-24136-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: filter ARP packets with
	invalid MAC addresses in DAT
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Matthias Schiffer <mschiffer@universe-factory.net>

We never want multicast MAC addresses in the Distributed ARP Table, so it's
best to completely ignore ARP packets containing them where we expect unicast
addresses.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Acked-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/distributed-arp-table.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index be3be28..ea0bd31 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -738,6 +738,7 @@ static uint16_t batadv_arp_get_type(struct batadv_priv *bat_priv,
 	struct arphdr *arphdr;
 	struct ethhdr *ethhdr;
 	__be32 ip_src, ip_dst;
+	uint8_t *hw_src, *hw_dst;
 	uint16_t type = 0;
 
 	/* pull the ethernet header */
@@ -782,6 +783,18 @@ static uint16_t batadv_arp_get_type(struct batadv_priv *bat_priv,
 	    ipv4_is_zeronet(ip_dst) || ipv4_is_lbcast(ip_dst))
 		goto out;
 
+	hw_src = batadv_arp_hw_src(skb, hdr_size);
+	if (is_zero_ether_addr(hw_src) || is_multicast_ether_addr(hw_src))
+		goto out;
+
+	/* we don't care about the destination MAC address in ARP requests */
+	if (arphdr->ar_op != htons(ARPOP_REQUEST)) {
+		hw_dst = batadv_arp_hw_dst(skb, hdr_size);
+		if (is_zero_ether_addr(hw_dst) ||
+		    is_multicast_ether_addr(hw_dst))
+			goto out;
+	}
+
 	type = ntohs(arphdr->ar_op);
 out:
 	return type;
-- 
1.8.1.1

