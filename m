Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 3/3] batctl: tcpdump: Add support for coded packets
Date: Sun,  9 Jun 2019 18:56:52 +0200
Message-Id: <20190609165652.12841-4-sven@narfation.org>
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

The network coding support in batman-adv was introduced with commit
c3289f3650d3 ("batman-adv: network coding - code and transmit packets if
possible"). The support to identify such packets by batctl's tcpdump was
never implemented.

This minimal implementation allows to identify these packets but is not
able to decode the packets.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Martin Hundebøll <martin@hundeboll.net>

 tcpdump.c | 33 ++++++++++++++++++++++++++++++++-
 tcpdump.h |  1 +
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/tcpdump.c b/tcpdump.c
index 7d04dd5..158b82e 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -56,7 +56,7 @@ static unsigned short dump_level_all = DUMP_TYPE_BATOGM | DUMP_TYPE_BATOGM2 |
 				       DUMP_TYPE_BATELP | DUMP_TYPE_BATICMP |
 				       DUMP_TYPE_BATUCAST | DUMP_TYPE_BATBCAST |
 				       DUMP_TYPE_BATUTVLV | DUMP_TYPE_BATFRAG |
-				       DUMP_TYPE_NONBAT;
+				       DUMP_TYPE_NONBAT | DUMP_TYPE_BATCODED;
 static unsigned short dump_level;
 
 static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed);
@@ -80,6 +80,7 @@ static void tcpdump_usage(void)
 	fprintf(stderr, " \t\t%3d - batman fragmented packets\n", DUMP_TYPE_BATFRAG);
 	fprintf(stderr, " \t\t%3d - batman unicast tvlv packets\n", DUMP_TYPE_BATUTVLV);
 	fprintf(stderr, " \t\t%3d - non batman packets\n", DUMP_TYPE_NONBAT);
+	fprintf(stderr, " \t\t%3d - batman coded packets\n", DUMP_TYPE_BATCODED);
 	fprintf(stderr, " \t\t%3d - batman ogm & non batman packets\n", DUMP_TYPE_BATOGM | DUMP_TYPE_NONBAT);
 }
 
@@ -981,6 +982,32 @@ static void dump_batman_bcast(unsigned char *packet_buff, ssize_t buff_len, int
 		      read_opt, time_printed);
 }
 
+static void dump_batman_coded(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
+{
+	struct batadv_coded_packet *coded_packet;
+	struct ether_header *ether_header;
+
+	LEN_CHECK((size_t)buff_len - sizeof(*ether_header), sizeof(*coded_packet), "BAT CODED");
+
+	ether_header = (struct ether_header *)packet_buff;
+	coded_packet = (struct batadv_coded_packet *)(packet_buff + sizeof(*ether_header));
+
+	if (!time_printed)
+		time_printed = print_time();
+
+	printf("BAT %s > ",
+	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost,
+				   read_opt));
+
+	printf("%s|%s: CODED, ttvn %d|%d, ttl %hhu\n",
+	       get_name_by_macaddr((struct ether_addr *)coded_packet->first_orig_dest,
+				   read_opt),
+	       get_name_by_macaddr((struct ether_addr *)coded_packet->second_dest,
+				   read_opt),
+	       coded_packet->first_ttvn, coded_packet->second_ttvn,
+	       coded_packet->ttl);
+}
+
 static void dump_batman_4addr(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
 	struct ether_header *ether_header;
@@ -1073,6 +1100,10 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 			if (dump_level & DUMP_TYPE_BATBCAST)
 				dump_batman_bcast(packet_buff, buff_len, read_opt, time_printed);
 			break;
+		case BATADV_CODED:
+			if (dump_level & DUMP_TYPE_BATCODED)
+				dump_batman_coded(packet_buff, buff_len, read_opt, time_printed);
+			break;
 		case BATADV_UNICAST_4ADDR:
 			if (dump_level & DUMP_TYPE_BATUCAST)
 				dump_batman_4addr(packet_buff, buff_len, read_opt, time_printed);
diff --git a/tcpdump.h b/tcpdump.h
index 6e9ae01..470b96a 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -33,6 +33,7 @@
 #define DUMP_TYPE_BATUTVLV 64
 #define DUMP_TYPE_BATFRAG 128
 #define DUMP_TYPE_NONBAT 256
+#define DUMP_TYPE_BATCODED 512
 
 #define IEEE80211_FCTL_FTYPE 0x0c00
 #define IEEE80211_FCTL_TODS 0x0001
-- 
2.20.1

