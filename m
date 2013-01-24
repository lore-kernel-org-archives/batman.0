Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Thu, 24 Jan 2013 18:18:27 +0100
Message-Id: <463977c0dcf7b3fcc6a2aebbb87add0d2377d3de.1359047612.git.mschiffer@universe-factory.net>
In-Reply-To: <1359047907-23522-1-git-send-email-mschiffer@universe-factory.net>
References: <20130124151221.GA8211@ritirata.org>
 <1359047907-23522-1-git-send-email-mschiffer@universe-factory.net>
In-Reply-To: <a6ad84c212e89c411dab6b40ac613a61c8b9621c.1359047612.git.mschiffer@universe-factory.net>
References: <a6ad84c212e89c411dab6b40ac613a61c8b9621c.1359047612.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: filter ARP packets with
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
To: b.a.t.m.a.n@lists.open-mesh.org

We never want multicast MAC addresses in the Distributed ARP Table, so it's
best to completely ignore ARP packets containing them where we expect unicast
addresses.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 distributed-arp-table.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index a35466a..c89a01e 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
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
+	/* we don't care for the destination MAC address in ARP requests */
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

