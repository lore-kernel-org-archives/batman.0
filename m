Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Thu, 24 Jan 2013 18:18:26 +0100
Message-Id: <a6ad84c212e89c411dab6b40ac613a61c8b9621c.1359047612.git.mschiffer@universe-factory.net>
In-Reply-To: <1359047907-23522-1-git-send-email-mschiffer@universe-factory.net>
References: <20130124151221.GA8211@ritirata.org>
 <1359047907-23522-1-git-send-email-mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCH v2 1/2] batman-adv: check for more types of
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
To: b.a.t.m.a.n@lists.open-mesh.org

There are more types of IP addresses that may appear in ARP packets that we
don't want to process. While some of these should never appear in sane ARP
packets, a 0.0.0.0 source is used for duplicate address detection and thus seen
quite often.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 distributed-arp-table.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 9f4cff3..a35466a 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -777,7 +777,9 @@ static uint16_t batadv_arp_get_type(struct batadv_priv *bat_priv,
 	ip_src = batadv_arp_ip_src(skb, hdr_size);
 	ip_dst = batadv_arp_ip_dst(skb, hdr_size);
 	if (ipv4_is_loopback(ip_src) || ipv4_is_multicast(ip_src) ||
-	    ipv4_is_loopback(ip_dst) || ipv4_is_multicast(ip_dst))
+	    ipv4_is_zeronet(ip_src) || ipv4_is_lbcast(ip_src) ||
+	    ipv4_is_loopback(ip_dst) || ipv4_is_multicast(ip_dst) ||
+	    ipv4_is_zeronet(ip_dst) || ipv4_is_lbcast(ip_dst))
 		goto out;
 
 	type = ntohs(arphdr->ar_op);
-- 
1.8.1.1

