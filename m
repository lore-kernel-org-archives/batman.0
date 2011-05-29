Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 29 May 2011 19:17:39 +0200
Message-Id: <1306689460-30162-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: tcpdump - add support for tt
	request / roaming advertisement packets
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
 tcpdump.c |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++----------
 tcpdump.h |    3 +-
 2 files changed, 78 insertions(+), 16 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index a715e27..6f1adc1 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -52,7 +52,7 @@ if ((size_t)(buff_len) < (check_len)) { \
 }
 
 static unsigned short dump_level = DUMP_TYPE_BATOGM | DUMP_TYPE_BATICMP | DUMP_TYPE_BATUCAST |
-		DUMP_TYPE_BATBCAST | DUMP_TYPE_BATVIS | DUMP_TYPE_BATFRAG | DUMP_TYPE_NONBAT;
+		DUMP_TYPE_BATBCAST | DUMP_TYPE_BATVIS | DUMP_TYPE_BATFRAG | DUMP_TYPE_BATTT | DUMP_TYPE_NONBAT;
 
 static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed);
 
@@ -63,14 +63,15 @@ static void tcpdump_usage(void)
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't convert addresses to bat-host names\n");
 	printf(" \t -p dump specific packet type\n");
-	printf(" \t\t%d - batman ogm packets\n", DUMP_TYPE_BATOGM);
-	printf(" \t\t%d - batman icmp packets\n", DUMP_TYPE_BATICMP);
-	printf(" \t\t%d - batman unicast packets\n", DUMP_TYPE_BATUCAST);
-	printf(" \t\t%d - batman broadcast packets\n", DUMP_TYPE_BATBCAST);
-	printf(" \t\t%d - batman vis packets\n", DUMP_TYPE_BATVIS);
-	printf(" \t\t%d - batman fragmented packets\n", DUMP_TYPE_BATFRAG);
-	printf(" \t\t%d - non batman packets\n", DUMP_TYPE_NONBAT);
-	printf(" \t\t%d - batman ogm & non batman packets\n", DUMP_TYPE_BATOGM | DUMP_TYPE_NONBAT);
+	printf(" \t\t%3d - batman ogm packets\n", DUMP_TYPE_BATOGM);
+	printf(" \t\t%3d - batman icmp packets\n", DUMP_TYPE_BATICMP);
+	printf(" \t\t%3d - batman unicast packets\n", DUMP_TYPE_BATUCAST);
+	printf(" \t\t%3d - batman broadcast packets\n", DUMP_TYPE_BATBCAST);
+	printf(" \t\t%3d - batman vis packets\n", DUMP_TYPE_BATVIS);
+	printf(" \t\t%3d - batman fragmented packets\n", DUMP_TYPE_BATFRAG);
+	printf(" \t\t%3d - batman tt / roaming packets\n", DUMP_TYPE_BATTT);
+	printf(" \t\t%3d - non batman packets\n", DUMP_TYPE_NONBAT);
+	printf(" \t\t%3d - batman ogm & non batman packets\n", DUMP_TYPE_BATOGM | DUMP_TYPE_NONBAT);
 }
 
 static int print_time(void)
@@ -247,6 +248,58 @@ static void dump_vlan(unsigned char *packet_buff, ssize_t buff_len, int read_opt
 	parse_eth_hdr(packet_buff + 4, buff_len - 4, read_opt, time_printed);
 }
 
+static void dump_batman_tt(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
+{
+	struct ether_header *ether_header;
+	struct tt_query_packet *tt_query_packet;
+
+	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct tt_query_packet), "BAT TT");
+
+	ether_header = (struct ether_header *)packet_buff;
+	tt_query_packet = (struct tt_query_packet *)(packet_buff + sizeof(struct ether_header));
+
+	if (!time_printed)
+		print_time();
+
+	printf("BAT %s > ",
+	       get_name_by_macaddr((struct ether_addr *)tt_query_packet->src, read_opt));
+
+	printf("%s: TT %s, ttvn %d, %s %d, ttl %2d, v %d, flags [%c%c%c], length %zu\n",
+	       get_name_by_macaddr((struct ether_addr *)tt_query_packet->dst, read_opt),
+	       tt_query_packet->flags & TT_RESPONSE ? "response" : "request",
+	       tt_query_packet->ttvn, tt_query_packet->flags & TT_RESPONSE ? "entries" : "crc",
+	       ntohs(tt_query_packet->tt_data), tt_query_packet->ttl, tt_query_packet->version,
+	       (tt_query_packet->flags & TT_REQUEST ? 'Q' : '.'),
+	       (tt_query_packet->flags & TT_RESPONSE ? 'P' : '.'),
+	       (tt_query_packet->flags & TT_FULL_TABLE ? 'F' : '.'),
+	       (size_t)buff_len - sizeof(struct ether_header));
+}
+
+static void dump_batman_roam(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
+{
+	struct ether_header *ether_header;
+	struct roam_adv_packet *roam_adv_packet;
+
+	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct roam_adv_packet), "BAT ROAM");
+
+	ether_header = (struct ether_header *)packet_buff;
+	roam_adv_packet = (struct roam_adv_packet *)(packet_buff + sizeof(struct ether_header));
+
+	if (!time_printed)
+		print_time();
+
+	printf("BAT %s > ",
+	       get_name_by_macaddr((struct ether_addr *)roam_adv_packet->src, read_opt));
+
+	printf("%s: ROAM, ",
+	       get_name_by_macaddr((struct ether_addr *)roam_adv_packet->dst, read_opt));
+
+	printf("client %s, ttl %2d, v %d, length %zu\n",
+	       get_name_by_macaddr((struct ether_addr *)roam_adv_packet->client, read_opt),
+	       roam_adv_packet->ttl, roam_adv_packet->version,
+	       (size_t)buff_len - sizeof(struct ether_header));
+}
+
 static void dump_batman_ogm(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
 	struct ether_header *ether_header;
@@ -263,9 +316,9 @@ static void dump_batman_ogm(unsigned char *packet_buff, ssize_t buff_len, int re
 	printf("BAT %s: ",
 	       get_name_by_macaddr((struct ether_addr *)batman_packet->orig, read_opt));
 
-	printf("OGM via neigh %s, seq %u, tq %3d, ttl %2d, v %d, flags [%c%c%c%c], length %zu\n",
+	printf("OGM via neigh %s, seq %u, tq %3d, ttvn %d, ttl %2d, v %d, flags [%c%c%c%c], length %zu\n",
 	        get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt),
-	        ntohl(batman_packet->seqno), batman_packet->tq,
+	        ntohl(batman_packet->seqno), batman_packet->tq, batman_packet->ttvn,
 	        batman_packet->ttl, batman_packet->version,
 	        (batman_packet->flags & DIRECTLINK ? 'D' : '.'),
 	        (batman_packet->flags & VIS_SERVER ? 'V' : '.'),
@@ -334,9 +387,9 @@ static void dump_batman_ucast(unsigned char *packet_buff, ssize_t buff_len, int
 	printf("BAT %s > ",
 	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt));
 
-	printf("%s: UCAST, ttl %hhu, ",
+	printf("%s: UCAST, ttvn %d, ttl %hhu, ",
 	       get_name_by_macaddr((struct ether_addr *)unicast_packet->dest, read_opt),
-	       unicast_packet->ttl);
+	       unicast_packet->ttvn, unicast_packet->ttl);
 
 	parse_eth_hdr(packet_buff + ETH_HLEN + sizeof(struct unicast_packet),
 		      buff_len - ETH_HLEN - sizeof(struct unicast_packet),
@@ -385,9 +438,9 @@ static void dump_batman_frag(unsigned char *packet_buff, ssize_t buff_len, int r
 	printf("BAT %s > ",
 	       get_name_by_macaddr((struct ether_addr *)unicast_frag_packet->orig, read_opt));
 
-	printf("%s: FRAG, seq %hu, ttl %hhu, flags [%c%c], ",
+	printf("%s: FRAG, seq %hu, ttvn %d, ttl %hhu, flags [%c%c], ",
 	       get_name_by_macaddr((struct ether_addr *)unicast_frag_packet->dest, read_opt),
-	       ntohs(unicast_frag_packet->seqno), unicast_frag_packet->ttl,
+	       ntohs(unicast_frag_packet->seqno), unicast_frag_packet->ttvn, unicast_frag_packet->ttl,
 	       (unicast_frag_packet->flags & UNI_FRAG_HEAD ? 'H' : '.'),
 	       (unicast_frag_packet->flags & UNI_FRAG_LARGETAIL ? 'L' : '.'));
 
@@ -447,6 +500,14 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 			if (dump_level & DUMP_TYPE_BATFRAG)
 				dump_batman_frag(packet_buff, buff_len, read_opt, time_printed);
 			break;
+		case BAT_TT_QUERY:
+			if (dump_level & DUMP_TYPE_BATTT)
+				dump_batman_tt(packet_buff, buff_len, read_opt, time_printed);
+			break;
+		case BAT_ROAM_ADV:
+			if (dump_level & DUMP_TYPE_BATTT)
+				dump_batman_roam(packet_buff, buff_len, read_opt, time_printed);
+			break;
 		default:
 			printf("Warning - packet contains unknown batman packet type: 0x%02x\n", batman_packet->packet_type);
 			break;
diff --git a/tcpdump.h b/tcpdump.h
index 4364be1..925b116 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -37,7 +37,8 @@
 #define DUMP_TYPE_BATBCAST 8
 #define DUMP_TYPE_BATVIS 16
 #define DUMP_TYPE_BATFRAG 32
-#define DUMP_TYPE_NONBAT 64
+#define DUMP_TYPE_BATTT 64
+#define DUMP_TYPE_NONBAT 128
 
 #define IEEE80211_FCTL_FTYPE 0x0c00
 #define IEEE80211_FCTL_TODS 0x0001
-- 
1.7.2.3

