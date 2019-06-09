Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/3] batctl: tcpdump: Add support for unicast fragmentation
Date: Sun,  9 Jun 2019 18:56:51 +0200
Message-Id: <20190609165652.12841-3-sven@narfation.org>
In-Reply-To: <20190609165652.12841-1-sven@narfation.org>
References: <20190609165652.12841-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

The support for unicast fragmentation was implemented in commit
9b3eab61754d ("batman-adv: Receive fragmented packets and merge"). The
support to identify such packets by batctl's tcpdump was never implemented.

This minimal implementation allows to identify these packets but is not
able to reassemble the packets. Wireshark should be used when this advanced
feature is required.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Martin Hundebøll <martin@hundeboll.net>

 tcpdump.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tcpdump.c b/tcpdump.c
index 9153fc4..7d04dd5 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -930,6 +930,30 @@ static void dump_batman_ucast(unsigned char *packet_buff, ssize_t buff_len, int
 		      read_opt, time_printed);
 }
 
+static void dump_batman_ucast_frag(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
+{
+	struct batadv_frag_packet *frag_packet;
+	struct ether_header *ether_header;
+
+	LEN_CHECK((size_t)buff_len - sizeof(*ether_header),
+		  sizeof(*frag_packet), "BAT UCAST FRAG");
+
+	ether_header = (struct ether_header *)packet_buff;
+	frag_packet = (struct batadv_frag_packet *)(packet_buff + sizeof(*ether_header));
+
+	if (!time_printed)
+		time_printed = print_time();
+
+	printf("BAT %s > ",
+	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost,
+				   read_opt));
+
+	printf("%s: UCAST FRAG, seqno %d, no %d, ttl %hhu\n",
+	       get_name_by_macaddr((struct ether_addr *)frag_packet->dest,
+				   read_opt),
+	       frag_packet->seqno, frag_packet->no, frag_packet->ttl);
+}
+
 static void dump_batman_bcast(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
 	struct ether_header *ether_header;
@@ -1041,6 +1065,10 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 			if (dump_level & DUMP_TYPE_BATUCAST)
 				dump_batman_ucast(packet_buff, buff_len, read_opt, time_printed);
 			break;
+		case BATADV_UNICAST_FRAG:
+			if (dump_level & DUMP_TYPE_BATFRAG)
+				dump_batman_ucast_frag(packet_buff, buff_len, read_opt, time_printed);
+			break;
 		case BATADV_BCAST:
 			if (dump_level & DUMP_TYPE_BATBCAST)
 				dump_batman_bcast(packet_buff, buff_len, read_opt, time_printed);
-- 
2.20.1

