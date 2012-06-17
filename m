Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 17 Jun 2012 17:19:58 +0800
Message-Id: <1339924798-14845-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: tcpdump support for bla2 claim
	packets
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 tcpdump.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 302085b..cbae9bb 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -90,9 +90,75 @@ static int print_time(void)
 	return 1;
 }
 
-static void dump_arp(unsigned char *packet_buff, ssize_t buff_len, int time_printed)
+static int dump_bla2_claim(struct ether_header *eth_hdr,
+			   struct ether_arp *arphdr, int read_opt)
+{
+	uint8_t bla_claim_magic[3] = {0xff, 0x43, 0x05};
+	struct batadv_bla_claim_dst *bla_dst;
+	int arp_is_bla2_claim = 0;
+	uint8_t *hw_src, *hw_dst;
+
+	if (arphdr->ea_hdr.ar_hrd != htons(ARPHRD_ETHER))
+		goto out;
+
+	if (arphdr->ea_hdr.ar_pro != htons(ETH_P_IP))
+		goto out;
+
+	if (arphdr->ea_hdr.ar_hln != ETH_ALEN)
+		goto out;
+
+	if (arphdr->ea_hdr.ar_pln != 4)
+		goto out;
+
+	hw_src = arphdr->arp_sha;
+	hw_dst = arphdr->arp_tha;
+	bla_dst = (struct batadv_bla_claim_dst *)hw_dst;
+
+	if (memcmp(bla_dst->magic, bla_claim_magic, sizeof(bla_claim_magic)) != 0)
+		goto out;
+
+	switch (bla_dst->type) {
+	case BATADV_CLAIM_TYPE_ADD:
+		printf("BLA CLAIM, backbone %s, ",
+		       get_name_by_macaddr((struct ether_addr *)hw_src, read_opt));
+		printf("client %s, bla group %04x\n",
+		       get_name_by_macaddr((struct ether_addr *)eth_hdr->ether_shost, read_opt),
+		       ntohs(bla_dst->group));
+		break;
+	case BATADV_CLAIM_TYPE_DEL:
+		printf("BLA UNCLAIM, backbone %s, ",
+		       get_name_by_macaddr((struct ether_addr *)eth_hdr->ether_shost, read_opt));
+		printf("client %s, bla group %04x\n",
+		       get_name_by_macaddr((struct ether_addr *)hw_src, read_opt),
+		       ntohs(bla_dst->group));
+		break;
+	case BATADV_CLAIM_TYPE_ANNOUNCE:
+		printf("BLA ANNOUNCE, backbone %s, bla group %04x, crc %04x\n",
+		       get_name_by_macaddr((struct ether_addr *)eth_hdr->ether_shost, read_opt),
+		       ntohs(bla_dst->group), ntohs(*((uint16_t *)(&hw_src[4]))));
+		break;
+	case BATADV_CLAIM_TYPE_REQUEST:
+		printf("BLA REQUEST, src backbone %s, ",
+		       get_name_by_macaddr((struct ether_addr *)hw_src, read_opt));
+		printf("dst backbone %s\n",
+		       get_name_by_macaddr((struct ether_addr *)eth_hdr->ether_dhost, read_opt));
+		break;
+	default:
+		printf("BLA UNKNOWN, type %hhu\n", bla_dst->type);
+		break;
+	}
+
+	arp_is_bla2_claim = 1;
+
+out:
+	return arp_is_bla2_claim;
+}
+
+static void dump_arp(unsigned char *packet_buff, ssize_t buff_len,
+		     struct ether_header *eth_hdr, int read_opt, int time_printed)
 {
 	struct ether_arp *arphdr;
+	int arp_is_bla2_claim;
 
 	LEN_CHECK((size_t)buff_len, sizeof(struct ether_arp), "ARP");
 
@@ -108,6 +174,10 @@ static void dump_arp(unsigned char *packet_buff, ssize_t buff_len, int time_prin
 			ether_ntoa_long((struct ether_addr *)&arphdr->arp_sha), buff_len);
 		break;
 	case ARPOP_REPLY:
+		arp_is_bla2_claim = dump_bla2_claim(eth_hdr, arphdr, read_opt);
+		if (arp_is_bla2_claim)
+			break;
+
 		printf("ARP, Reply %s is-at %s, length %zd\n", inet_ntoa(*(struct in_addr *)&arphdr->arp_spa),
 			ether_ntoa_long((struct ether_addr *)&arphdr->arp_sha), buff_len);
 		break;
@@ -479,7 +549,8 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 	switch (ntohs(eth_hdr->ether_type)) {
 	case ETH_P_ARP:
 		if ((dump_level & DUMP_TYPE_NONBAT) || (time_printed))
-			dump_arp(packet_buff + ETH_HLEN, buff_len - ETH_HLEN, time_printed);
+			dump_arp(packet_buff + ETH_HLEN, buff_len - ETH_HLEN,
+				 eth_hdr, read_opt, time_printed);
 		break;
 	case ETH_P_IP:
 		if ((dump_level & DUMP_TYPE_NONBAT) || (time_printed))
-- 
1.7.9.1

