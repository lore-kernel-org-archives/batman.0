Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Mon, 14 Mar 2016 12:01:47 +0800
Message-Id: <1457928107-22710-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: tcpdump - add OGM2 and ELP parsing
	support
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
Cc: Antonio Quartulli <antonio.quartulli@open-mesh.com>

From: Antonio Quartulli <antonio.quartulli@open-mesh.com>

These new packet types were introduced with B.A.T.M.A.N. V and
required tcpdump parsing support.
With this change it is now possible to properly read the content
these packets by means of the batctl tdpcump command.

In order to reduce code duplication, the mechanism used
to dump TVLV containers has been extracted and moved to a new
function.

Signed-off-by: Antonio Quartulli <antonio.quartulli@open-mesh.com>
---
 tcpdump.c | 164 ++++++++++++++++++++++++++++++++++++++++++++------------------
 tcpdump.h |  11 +++--
 2 files changed, 123 insertions(+), 52 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index ac03cb2..8df9915 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -49,6 +49,8 @@
 #include "bat-hosts.h"
 #include "functions.h"
 
+#define BATADV_THROUGHPUT_MAX_VALUE	0xFFFFFFFF
+
 #ifndef ETH_P_BATMAN
 #define ETH_P_BATMAN	0x4305
 #endif /* ETH_P_BATMAN */
@@ -62,8 +64,10 @@ if ((size_t)(buff_len) < (check_len)) { \
 	return; \
 }
 
-static unsigned short dump_level_all = DUMP_TYPE_BATOGM | DUMP_TYPE_BATICMP | DUMP_TYPE_BATUCAST |
-		DUMP_TYPE_BATBCAST | DUMP_TYPE_BATUTVLV | DUMP_TYPE_BATFRAG | DUMP_TYPE_NONBAT;
+static unsigned short dump_level_all = DUMP_TYPE_BATOGM | DUMP_TYPE_BATELP |
+				       DUMP_TYPE_BATICMP | DUMP_TYPE_BATUCAST |
+				       DUMP_TYPE_BATBCAST | DUMP_TYPE_BATUTVLV |
+				       DUMP_TYPE_BATFRAG | DUMP_TYPE_NONBAT;
 static unsigned short dump_level;
 
 static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed);
@@ -78,7 +82,9 @@ static void tcpdump_usage(void)
 	fprintf(stderr, " \t -p dump specific packet type\n");
 	fprintf(stderr, " \t -x dump all packet types except specified\n");
 	fprintf(stderr, "packet types:\n");
-	fprintf(stderr, " \t\t%3d - batman ogm packets\n", DUMP_TYPE_BATOGM);
+	fprintf(stderr, " \t\t%3d - batman ogm/ogmv2 packets\n",
+		DUMP_TYPE_BATOGM);
+	fprintf(stderr, " \t\t%3d - batman elp packets\n", DUMP_TYPE_BATELP);
 	fprintf(stderr, " \t\t%3d - batman icmp packets\n", DUMP_TYPE_BATICMP);
 	fprintf(stderr, " \t\t%3d - batman unicast packets\n", DUMP_TYPE_BATUCAST);
 	fprintf(stderr, " \t\t%3d - batman broadcast packets\n", DUMP_TYPE_BATBCAST);
@@ -246,20 +252,43 @@ static batctl_tvlv_parser_t tvlv_parser_get(uint8_t type, uint8_t version)
 	}
 }
 
+static void dump_tvlv(unsigned char *ptr, ssize_t tvlv_len)
+{
+	struct batadv_tvlv_hdr *tvlv_hdr;
+	batctl_tvlv_parser_t parser;
+	ssize_t len;
+
+	while (tvlv_len >= (ssize_t)sizeof(*tvlv_hdr)) {
+		tvlv_hdr = (struct batadv_tvlv_hdr *)ptr;
+
+		/* data after TVLV header */
+		ptr = (uint8_t *)(tvlv_hdr + 1);
+		tvlv_len -= sizeof(*tvlv_hdr);
+
+		len = ntohs(tvlv_hdr->len);
+		LEN_CHECK(tvlv_len, (size_t)len, "BAT TVLV");
+
+		parser = tvlv_parser_get(tvlv_hdr->type, tvlv_hdr->version);
+		if (parser)
+			parser(ptr, len);
+
+		/* go to the next container */
+		ptr += len;
+		tvlv_len -= len;
+	}
+}
+
 static void dump_batman_ucast_tvlv(unsigned char *packet_buff, ssize_t buff_len,
 				   int read_opt, int time_printed)
 {
 	struct batadv_unicast_tvlv_packet *tvlv_packet;
-	struct batadv_tvlv_hdr *tvlv_hdr;
 	struct ether_header *ether_header;
 	struct ether_addr *src, *dst;
-	batctl_tvlv_parser_t parser;
-	ssize_t check_len, tvlv_len, len;
-	uint8_t *ptr;
+	ssize_t check_len, tvlv_len;
 
 	check_len = (size_t)buff_len - sizeof(struct ether_header);
 
-	LEN_CHECK(check_len, sizeof(*tvlv_packet), "BAT TVLV");
+	LEN_CHECK(check_len, sizeof(*tvlv_packet), "BAT UCAST TVLV");
 	check_len -= sizeof(*tvlv_packet);
 
 	ether_header = (struct ether_header *)packet_buff;
@@ -281,26 +310,7 @@ static void dump_batman_ucast_tvlv(unsigned char *packet_buff, ssize_t buff_len,
 	       buff_len - sizeof(struct ether_header), tvlv_len,
 	       tvlv_packet->ttl);
 
-	ptr = (uint8_t *)(tvlv_packet + 1);
-
-	while (tvlv_len >= (ssize_t)sizeof(*tvlv_hdr)) {
-		tvlv_hdr = (struct batadv_tvlv_hdr *)ptr;
-
-		/* data after TVLV header */
-		ptr = (uint8_t *)(tvlv_hdr + 1);
-		tvlv_len -= sizeof(*tvlv_hdr);
-
-		len = ntohs(tvlv_hdr->len);
-		LEN_CHECK(tvlv_len, (size_t)len, "BAT UCAST TVLV");
-
-		parser = tvlv_parser_get(tvlv_hdr->type, tvlv_hdr->version);
-		if (parser)
-			parser(ptr, len);
-
-		/* go to the next container */
-		ptr += len;
-		tvlv_len -= len;
-	}
+	dump_tvlv((uint8_t *)(tvlv_packet + 1), tvlv_len);
 }
 
 static int dump_bla2_claim(struct ether_header *eth_hdr,
@@ -686,10 +696,7 @@ static void dump_batman_iv_ogm(unsigned char *packet_buff, ssize_t buff_len, int
 {
 	struct ether_header *ether_header;
 	struct batadv_ogm_packet *batman_ogm_packet;
-	struct batadv_tvlv_hdr *tvlv_hdr;
-	ssize_t tvlv_len, len, check_len;
-	batctl_tvlv_parser_t parser;
-	uint8_t *ptr;
+	ssize_t tvlv_len, check_len;
 
 	check_len = (size_t)buff_len - sizeof(struct ether_header);
 	LEN_CHECK(check_len, sizeof(struct batadv_ogm_packet), "BAT IV OGM");
@@ -716,26 +723,79 @@ static void dump_batman_iv_ogm(unsigned char *packet_buff, ssize_t buff_len, int
 	check_len -= sizeof(struct batadv_ogm_packet);
 	LEN_CHECK(check_len, (size_t)tvlv_len, "BAT OGM TVLV (containers)");
 
-	ptr = (uint8_t *)(batman_ogm_packet + 1);
+	dump_tvlv((uint8_t *)(batman_ogm_packet + 1), tvlv_len);
+}
 
-	while (tvlv_len >= (ssize_t)sizeof(*tvlv_hdr)) {
-		tvlv_hdr = (struct batadv_tvlv_hdr *)ptr;
+static void dump_batman_ogm2(unsigned char *packet_buff, ssize_t buff_len,
+			     int read_opt, int time_printed)
+{
+	struct batadv_ogm2_packet *batman_ogm2;
+	struct ether_header *ether_header;
+	struct ether_addr *ether_addr;
+	ssize_t tvlv_len, check_len;
+	uint32_t throughput;
+	char thr_str[20];
 
-		/* data after TVLV header */
-		ptr = (uint8_t *)(tvlv_hdr + 1);
-		tvlv_len -= sizeof(*tvlv_hdr);
+	check_len = (size_t)buff_len - sizeof(struct ether_header);
+	LEN_CHECK(check_len, BATADV_OGM2_HLEN, "BAT OGM2");
 
-		len = ntohs(tvlv_hdr->len);
-		LEN_CHECK(tvlv_len, (size_t)len, "BAT IV OGM TVLV");
+	ether_header = (struct ether_header *)packet_buff;
+	batman_ogm2 = (struct batadv_ogm2_packet *)(packet_buff +
+						    sizeof(struct ether_header));
 
-		parser = tvlv_parser_get(tvlv_hdr->type, tvlv_hdr->version);
-		if (parser)
-			parser(ptr, len);
+	if (!time_printed)
+		print_time();
 
-		/* go to the next container */
-		ptr += len;
-		tvlv_len -= len;
-	}
+	ether_addr = (struct ether_addr *)batman_ogm2->orig;
+	printf("BAT %s: ", get_name_by_macaddr(ether_addr, read_opt));
+
+	tvlv_len = ntohs(batman_ogm2->tvlv_len);
+
+	throughput = ntohl(batman_ogm2->throughput);
+	if (throughput == BATADV_THROUGHPUT_MAX_VALUE)
+		snprintf(thr_str, sizeof(thr_str), "MAX");
+	else
+		snprintf(thr_str, sizeof(thr_str), "%.2fMbps",
+			 (float)ntohl(batman_ogm2->throughput) / 10);
+
+	ether_addr = (struct ether_addr *)ether_header->ether_shost;
+	printf("OGM2 via neigh %s, seq %u, throughput %s, ttl %2d, v %d, length %zu, tvlv_len %zu\n",
+	       get_name_by_macaddr(ether_addr, read_opt),
+	       ntohl(batman_ogm2->seqno), thr_str, batman_ogm2->ttl,
+	       batman_ogm2->version, check_len, tvlv_len);
+
+	check_len -= BATADV_OGM2_HLEN;
+	LEN_CHECK(check_len, (size_t)tvlv_len, "BAT OGM2 TVLV (containers)");
+
+	dump_tvlv((uint8_t *)(batman_ogm2 + 1), tvlv_len);
+}
+
+static void dump_batman_elp(unsigned char *packet_buff, ssize_t buff_len,
+			    int read_opt, int time_printed)
+{
+	struct batadv_elp_packet *batman_elp;
+	struct ether_header *ether_header;
+	struct ether_addr *ether_addr;
+	ssize_t check_len;
+
+	check_len = (size_t)buff_len - sizeof(struct ether_header);
+	LEN_CHECK(check_len, BATADV_ELP_HLEN, "BAT ELP");
+
+	ether_header = (struct ether_header *)packet_buff;
+	batman_elp = (struct batadv_elp_packet *)(packet_buff +
+						  sizeof(struct ether_header));
+
+	if (!time_printed)
+		print_time();
+
+	ether_addr = (struct ether_addr *)batman_elp->orig;
+	printf("BAT %s: ", get_name_by_macaddr(ether_addr, read_opt));
+
+	ether_addr = (struct ether_addr *)ether_header->ether_shost;
+	printf("ELP via iface %s, seq %u, v %d, interval %ums, length %zu\n",
+	       get_name_by_macaddr(ether_addr, read_opt),
+	       ntohl(batman_elp->seqno), batman_elp->version,
+	       ntohl(batman_elp->elp_interval), check_len);
 }
 
 static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
@@ -914,6 +974,16 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 			if (dump_level & DUMP_TYPE_BATOGM)
 				dump_batman_iv_ogm(packet_buff, buff_len, read_opt, time_printed);
 			break;
+		case BATADV_OGM2:
+			if (dump_level & DUMP_TYPE_BATOGM)
+				dump_batman_ogm2(packet_buff, buff_len,
+						 read_opt, time_printed);
+			break;
+		case BATADV_ELP:
+			if (dump_level & DUMP_TYPE_BATELP)
+				dump_batman_elp(packet_buff, buff_len,
+						 read_opt, time_printed);
+			break;
 		case BATADV_ICMP:
 			if (dump_level & DUMP_TYPE_BATICMP)
 				dump_batman_icmp(packet_buff, buff_len, read_opt, time_printed);
diff --git a/tcpdump.h b/tcpdump.h
index dc9e5a6..5ec474f 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -38,11 +38,12 @@
 #endif
 
 #define DUMP_TYPE_BATOGM 1
-#define DUMP_TYPE_BATICMP 2
-#define DUMP_TYPE_BATUCAST 4
-#define DUMP_TYPE_BATBCAST 8
-#define DUMP_TYPE_BATUTVLV 16
-#define DUMP_TYPE_BATFRAG 32
+#define DUMP_TYPE_BATELP 2
+#define DUMP_TYPE_BATICMP 4
+#define DUMP_TYPE_BATUCAST 8
+#define DUMP_TYPE_BATBCAST 16
+#define DUMP_TYPE_BATUTVLV 32
+#define DUMP_TYPE_BATFRAG 64
 #define DUMP_TYPE_NONBAT 128
 
 #define IEEE80211_FCTL_FTYPE 0x0c00
-- 
2.7.3

