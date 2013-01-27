Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 27 Jan 2013 20:43:58 +0100
Message-Id: <1359315839-24136-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1359315839-24136-1-git-send-email-ordex@autistici.org>
References: <1359315839-24136-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: check for more types of
	invalid IP addresses in DAT
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

There are more types of IP addresses that may appear in ARP packets that we
don't want to process. While some of these should never appear in sane ARP
packets, a 0.0.0.0 source is used for duplicate address detection and thus seen
quite often.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Acked-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/distributed-arp-table.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 9f4cff3..be3be28 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -777,7 +777,9 @@ static uint16_t batadv_arp_get_type(struct batadv_priv *bat_priv,
 	ip_src = batadv_arp_ip_src(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 	if (ipv4_is_loopback(ip_src) || ipv4_is_multicast(ip_src) ||
-	    ipv4_is_loopback(ip_dst) || ipv4_is_multicast(ip_dst))
+	    ipv4_is_loopback(ip_dst) || ipv4_is_multicast(ip_dst) ||
+	    ipv4_is_zeronet(ip_src) || ipv4_is_lbcast(ip_src) ||
+	    ipv4_is_zeronet(ip_dst) || ipv4_is_lbcast(ip_dst))
 		goto out;
 
 	type = ntohs(arphdr->ar_op);
-- 
1.8.1.1

