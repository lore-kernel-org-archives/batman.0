Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  2 Apr 2013 22:34:30 +0200
Message-Id: <1364934870-23095-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1364934870-23095-1-git-send-email-ordex@autistici.org>
References: <1364934870-23095-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/2] batctl: tcpdump - print subtype for
	UNICAST4ADDR packets
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

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2:
- added subtype print format

 tcpdump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index f69ac6f..b4cfec9 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -560,9 +560,10 @@ static void dump_batman_4addr(unsigned char *packet_buff, ssize_t buff_len, int
 	printf("BAT %s > ",
 	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt));
 
-	printf("%s: 4ADDR, ttvn %d, ttl %hhu, ",
+	printf("%s: 4ADDR, subtybe %hhu, ttvn %d, ttl %hhu, ",
 	       get_name_by_macaddr((struct ether_addr *)unicast_4addr_packet->u.dest, read_opt),
-	       unicast_4addr_packet->u.ttvn, unicast_4addr_packet->u.header.ttl);
+	       unicast_4addr_packet->subtype, unicast_4addr_packet->u.ttvn,
+	       unicast_4addr_packet->u.header.ttl);
 
 	parse_eth_hdr(packet_buff + ETH_HLEN + sizeof(struct batadv_unicast_4addr_packet),
 		      buff_len - ETH_HLEN - sizeof(struct batadv_unicast_4addr_packet),
-- 
1.8.1.5

