Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  2 Apr 2013 22:34:29 +0200
Message-Id: <1364934870-23095-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/2] batctl: fix 4addr parsing in tcpdump
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

In the UNICAST4ADDR parsing routing a wrong type is used to
parse the batman header, resulting in a wrong data
visualization. Fix this by using the correct data type.

Introduced by 70aefcf8abefd509e5721c6ae228d3854d5e8b16
("batctl: Add minimal unicast 4addr dissector support")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2:
- removed subtype print format

 tcpdump.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index f357c6d..f69ac6f 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -545,14 +545,14 @@ static void dump_batman_frag(unsigned char *packet_buff, ssize_t buff_len, int r
 static void dump_batman_4addr(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
 	struct ether_header *ether_header;
-	struct batadv_unicast_packet *unicast_4addr_packet;
+	struct batadv_unicast_4addr_packet *unicast_4addr_packet;
 
-	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct batadv_unicast_packet), "BAT 4ADDR");
-	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header) - sizeof(struct batadv_unicast_packet),
+	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct batadv_unicast_4addr_packet), "BAT 4ADDR");
+	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header) - sizeof(struct batadv_unicast_4addr_packet),
 		sizeof(struct ether_header), "BAT 4ADDR (unpacked)");
 
 	ether_header = (struct ether_header *)packet_buff;
-	unicast_4addr_packet = (struct batadv_unicast_packet *)(packet_buff + sizeof(struct ether_header));
+	unicast_4addr_packet = (struct batadv_unicast_4addr_packet *)(packet_buff + sizeof(struct ether_header));
 
 	if (!time_printed)
 		time_printed = print_time();
@@ -561,11 +561,11 @@ static void dump_batman_4addr(unsigned char *packet_buff, ssize_t buff_len, int
 	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt));
 
 	printf("%s: 4ADDR, ttvn %d, ttl %hhu, ",
-	       get_name_by_macaddr((struct ether_addr *)unicast_4addr_packet->dest, read_opt),
-	       unicast_4addr_packet->ttvn, unicast_4addr_packet->header.ttl);
+	       get_name_by_macaddr((struct ether_addr *)unicast_4addr_packet->u.dest, read_opt),
+	       unicast_4addr_packet->u.ttvn, unicast_4addr_packet->u.header.ttl);
 
-	parse_eth_hdr(packet_buff + ETH_HLEN + sizeof(struct batadv_unicast_packet),
-		      buff_len - ETH_HLEN - sizeof(struct batadv_unicast_packet),
+	parse_eth_hdr(packet_buff + ETH_HLEN + sizeof(struct batadv_unicast_4addr_packet),
+		      buff_len - ETH_HLEN - sizeof(struct batadv_unicast_4addr_packet),
 		      read_opt, time_printed);
 }
 
-- 
1.8.1.5

