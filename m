Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu, 26 Jun 2014 02:24:00 +0200
Message-Id: <1403742240-7430-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: tcpdump - parse TVLV containers
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

OGMs and unicast TVLV packets carry TVLV containers as
payload.
With this patch such containers are now parsed and the
relevant information is printed to screen.

Moreover, the parts of code that have been touched by this
patch have also been re-arranged a bit from the style point
of view.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 main.h    |   7 +++
 tcpdump.c | 199 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 tcpdump.h |  13 ++--
 3 files changed, 199 insertions(+), 20 deletions(-)

diff --git a/main.h b/main.h
index c68801a..1c444dd 100644
--- a/main.h
+++ b/main.h
@@ -49,4 +49,11 @@
 
 extern char module_ver_path[];
 
+#ifndef VLAN_VID_MASK
+#define VLAN_VID_MASK   0xfff
+#endif
+
+#define BATADV_PRINT_VID(vid) (vid & BATADV_VLAN_HAS_TAG ? \
+			       (int)(vid & VLAN_VID_MASK) : -1)
+
 #endif
diff --git a/tcpdump.c b/tcpdump.c
index 47081b6..c63765d 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -62,29 +62,40 @@ if ((size_t)(buff_len) < (check_len)) { \
 	return; \
 }
 
-static unsigned short dump_level_all = DUMP_TYPE_BATOGM | DUMP_TYPE_BATICMP | DUMP_TYPE_BATUCAST |
-		DUMP_TYPE_BATBCAST | DUMP_TYPE_BATFRAG | DUMP_TYPE_NONBAT;
+static unsigned short dump_level_all = DUMP_TYPE_BATOGM | DUMP_TYPE_BATICMP |
+				       DUMP_TYPE_BATUCAST | DUMP_TYPE_BATBCAST |
+				       DUMP_TYPE_BATFRAG | DUMP_TYPE_BATUTVLV |
+				       DUMP_TYPE_NONBAT;
 static unsigned short dump_level;
 
 static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed);
 
 static void tcpdump_usage(void)
 {
-	fprintf(stderr, "Usage: batctl tcpdump [parameters] interface [interface]\n");
+	fprintf(stderr,
+		"Usage: batctl tcpdump [parameters] interface [interface]\n");
 	fprintf(stderr, "parameters:\n");
-	fprintf(stderr, " \t -c compat filter - only display packets matching own compat version (%i)\n", BATADV_COMPAT_VERSION);
+	fprintf(stderr,
+		" \t -c compat filter - only display packets matching own compat version (%i)\n",
+		BATADV_COMPAT_VERSION);
 	fprintf(stderr, " \t -h print this help\n");
 	fprintf(stderr, " \t -n don't convert addresses to bat-host names\n");
 	fprintf(stderr, " \t -p dump specific packet type\n");
 	fprintf(stderr, " \t -x dump all packet types except specified\n");
 	fprintf(stderr, "packet types:\n");
-	fprintf(stderr, " \t\t%3d - batman ogm packets\n", DUMP_TYPE_BATOGM);
-	fprintf(stderr, " \t\t%3d - batman icmp packets\n", DUMP_TYPE_BATICMP);
-	fprintf(stderr, " \t\t%3d - batman unicast packets\n", DUMP_TYPE_BATUCAST);
-	fprintf(stderr, " \t\t%3d - batman broadcast packets\n", DUMP_TYPE_BATBCAST);
-	fprintf(stderr, " \t\t%3d - batman fragmented packets\n", DUMP_TYPE_BATFRAG);
-	fprintf(stderr, " \t\t%3d - non batman packets\n", DUMP_TYPE_NONBAT);
-	fprintf(stderr, " \t\t%3d - batman ogm & non batman packets\n", DUMP_TYPE_BATOGM | DUMP_TYPE_NONBAT);
+	fprintf(stderr, " \t\t%3ld - batman ogm packets\n", DUMP_TYPE_BATOGM);
+	fprintf(stderr, " \t\t%3ld - batman icmp packets\n", DUMP_TYPE_BATICMP);
+	fprintf(stderr, " \t\t%3ld - batman unicast packets\n",
+		DUMP_TYPE_BATUCAST);
+	fprintf(stderr, " \t\t%3ld - batman broadcast packets\n",
+		DUMP_TYPE_BATBCAST);
+	fprintf(stderr, " \t\t%3ld - batman fragmented packets\n",
+		DUMP_TYPE_BATFRAG);
+	fprintf(stderr, " \t\t%3ld - batman unicast tvlv packets\n",
+		DUMP_TYPE_BATUTVLV);
+	fprintf(stderr, " \t\t%3ld - non batman packets\n", DUMP_TYPE_NONBAT);
+	fprintf(stderr, " \t\t%3ld - batman ogm & non batman packets\n",
+		DUMP_TYPE_BATOGM | DUMP_TYPE_NONBAT);
 }
 
 static int print_time(void)
@@ -99,6 +110,138 @@ static int print_time(void)
 	return 1;
 }
 
+static void batctl_tvlv_parse_gw_v1(void *buff,
+				    ssize_t (buff_len)__attribute__((unused)))
+{
+	struct batadv_tvlv_gateway_data *tvlv = buff;
+	uint32_t down, up;
+
+	down = ntohl(tvlv->bandwidth_down);
+	up = ntohl(tvlv->bandwidth_up);
+
+	printf("\tTVLV GWv1: down %d.%.1dMbps, up %d.%1dMbps\n",
+	       down / 10, down % 10, up / 10, up % 10);
+}
+
+static void batctl_tvlv_parse_dat_v1(void (*buff)__attribute__((unused)),
+				     ssize_t (buff_len)__attribute__((unused)))
+{
+	printf("\tTVLV DATv1: enabled\n");
+}
+
+static void batctl_tvlv_parse_nc_v1(void (*buff)__attribute__((unused)),
+				    ssize_t (buff_len)__attribute__((unused)))
+{
+	printf("\tTVLV NCv1: enabled\n");
+}
+
+static void batctl_tvlv_parse_tt_v1(void *buff,
+				    ssize_t (buff_len)__attribute__((unused)))
+{
+	struct batadv_tvlv_tt_data *tvlv = buff;
+	struct batadv_tvlv_tt_vlan_data *vlan;
+	int i, num_vlan, num_entry;
+	const char *type;
+
+	if (tvlv->flags & BATADV_TT_OGM_DIFF)
+		type = "OGM DIFF";
+	else if (tvlv->flags & BATADV_TT_REQUEST)
+		type = "TT REQUEST";
+	else if (tvlv->flags & BATADV_TT_RESPONSE)
+		type = "TT RESPONSE";
+	else
+		type = "UNKNOWN";
+
+	num_vlan = ntohs(tvlv->num_vlan);
+	buff_len -= sizeof(*tvlv) + sizeof(*vlan) * num_vlan;
+	num_entry = buff_len / sizeof(struct batadv_tvlv_tt_change);
+
+	printf("\tTVLV TTv1: %s [%c] ttvn=%hhu vlan_num=%hu entry_num=%hu\n",
+	       type, tvlv->flags & BATADV_TT_FULL_TABLE ? 'F' : '.',
+	       tvlv->ttvn, num_vlan, num_entry);
+
+	vlan = (struct batadv_tvlv_tt_vlan_data *)(tvlv + 1);
+	for (i = 0; i < num_vlan; i++) {
+		printf("\t\tVLAN ID %hd, crc %#.8x\n",
+		       BATADV_PRINT_VID(ntohs(vlan->vid)),
+		       ntohl(vlan->crc));
+		vlan++;
+	}
+}
+
+static void batctl_tvlv_parse_roam_v1(void *buff,
+				      ssize_t (buff_len)__attribute__((unused)))
+{
+	struct batadv_tvlv_roam_adv *tvlv = buff;
+
+	printf("\tTVLV ROAMv1: client %s, VLAN ID %d\n",
+	       get_name_by_macaddr((struct ether_addr *)tvlv->client, NO_FLAGS),
+	       BATADV_PRINT_VID(ntohs(tvlv->vid)));
+}
+
+typedef void (*batctl_tvlv_parser_t)(void *buff, ssize_t buff_len);
+
+/* location [i][j] contains the parsing function for TVLV of type 'i' and
+ * version 'j + 1'
+ */
+batctl_tvlv_parser_t tvlv_parsers[][1] = {
+	[BATADV_TVLV_GW][0] = batctl_tvlv_parse_gw_v1,
+	[BATADV_TVLV_DAT][0] = batctl_tvlv_parse_dat_v1,
+	[BATADV_TVLV_NC][0] = batctl_tvlv_parse_nc_v1,
+	[BATADV_TVLV_TT][0] = batctl_tvlv_parse_tt_v1,
+	[BATADV_TVLV_ROAM][0] = batctl_tvlv_parse_roam_v1,
+};
+
+static void dump_batman_ucast_tvlv(unsigned char *packet_buff, ssize_t buff_len,
+				   int read_opt, int time_printed)
+{
+	struct batadv_unicast_tvlv_packet *tvlv_packet;
+	struct batadv_tvlv_hdr *tvlv_hdr;
+	struct ether_header *ether_header;
+	struct ether_addr *src, *dst;
+	batctl_tvlv_parser_t parser;
+	ssize_t check_len, tvlv_len, len;
+	uint8_t *ptr;
+
+	check_len = (size_t)buff_len - sizeof(struct ether_header);
+
+	LEN_CHECK(check_len, sizeof(*tvlv_packet), "BAT TVLV");
+	check_len -= sizeof(*tvlv_packet);
+
+	ether_header = (struct ether_header *)packet_buff;
+	tvlv_packet = (struct batadv_unicast_tvlv_packet *)(ether_header + 1);
+
+	LEN_CHECK(check_len, (size_t)ntohs(tvlv_packet->tvlv_len),
+		  "BAT TVLV (containers)");
+
+	if (!time_printed)
+		time_printed = print_time();
+
+	src = (struct ether_addr *)tvlv_packet->src;
+	printf("BAT %s > ", get_name_by_macaddr(src, read_opt));
+
+	dst = (struct ether_addr *)tvlv_packet->dst;
+	tvlv_len = ntohs(tvlv_packet->tvlv_len);
+	printf("%s: TVLV, len %zu, tvlv_len %zu, ttl %hhu\n",
+	       get_name_by_macaddr(dst, read_opt),
+	       buff_len - sizeof(struct ether_header), tvlv_len,
+	       tvlv_packet->ttl);
+
+	ptr = (uint8_t *)(tvlv_packet + 1);
+
+	while (tvlv_len > 0) {
+		tvlv_hdr = (struct batadv_tvlv_hdr *)ptr;
+		len = ntohs(tvlv_hdr->len);
+
+		parser = tvlv_parsers[tvlv_hdr->type][tvlv_hdr->version - 1];
+		parser(tvlv_hdr + 1, len);
+
+		/* go to the next container */
+		ptr = (uint8_t *)(tvlv_hdr + 1) + len;
+		tvlv_len -= sizeof(*tvlv_hdr) + len;
+	}
+}
+
 static int dump_bla2_claim(struct ether_header *eth_hdr,
 			   struct ether_arp *arphdr, int read_opt)
 {
@@ -482,8 +625,13 @@ static void dump_batman_iv_ogm(unsigned char *packet_buff, ssize_t buff_len, int
 {
 	struct ether_header *ether_header;
 	struct batadv_ogm_packet *batman_ogm_packet;
+	struct batadv_tvlv_hdr *tvlv_hdr;
+	size_t tvlv_len, len, check_len;
+	batctl_tvlv_parser_t parser;
+	uint8_t *ptr;
 
-	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct batadv_ogm_packet), "BAT IV OGM");
+	check_len = (size_t)buff_len - sizeof(struct ether_header);
+	LEN_CHECK(check_len, sizeof(struct batadv_ogm_packet), "BAT IV OGM");
 
 	ether_header = (struct ether_header *)packet_buff;
 	batman_ogm_packet = (struct batadv_ogm_packet *)(packet_buff + sizeof(struct ether_header));
@@ -494,14 +642,32 @@ static void dump_batman_iv_ogm(unsigned char *packet_buff, ssize_t buff_len, int
 	printf("BAT %s: ",
 	       get_name_by_macaddr((struct ether_addr *)batman_ogm_packet->orig, read_opt));
 
-	printf("OGM IV via neigh %s, seq %u, tq %3d, ttl %2d, v %d, flags [%c%c%c], length %zu\n",
+	tvlv_len = ntohs(batman_ogm_packet->tvlv_len);
+	printf("OGM IV via neigh %s, seq %u, tq %3d, ttl %2d, v %d, flags [%c%c%c], length %zu, tvlv_len %zu\n",
 	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt),
 	       ntohl(batman_ogm_packet->seqno), batman_ogm_packet->tq,
 	       batman_ogm_packet->ttl, batman_ogm_packet->version,
 	       (batman_ogm_packet->flags & BATADV_NOT_BEST_NEXT_HOP ? 'N' : '.'),
 	       (batman_ogm_packet->flags & BATADV_DIRECTLINK ? 'D' : '.'),
 	       (batman_ogm_packet->flags & BATADV_PRIMARIES_FIRST_HOP ? 'F' : '.'),
-	       (size_t)buff_len - sizeof(struct ether_header));
+	       check_len, tvlv_len);
+
+	check_len -= sizeof(struct batadv_ogm_packet);
+	LEN_CHECK(check_len, tvlv_len, "BAT OGM TVLV (containers)");
+
+	ptr = (uint8_t *)(batman_ogm_packet + 1);
+
+	while (tvlv_len > 0) {
+		tvlv_hdr = (struct batadv_tvlv_hdr *)ptr;
+		len = ntohs(tvlv_hdr->len);
+
+		parser = tvlv_parsers[tvlv_hdr->type][tvlv_hdr->version - 1];
+		parser(tvlv_hdr + 1, len);
+
+		/* go to the next container */
+		ptr = (uint8_t *)(tvlv_hdr + 1) + len;
+		tvlv_len -= sizeof(*tvlv_hdr) + len;
+	}
 }
 
 static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
@@ -695,6 +861,11 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 		case BATADV_UNICAST_4ADDR:
 			if (dump_level & DUMP_TYPE_BATUCAST)
 				dump_batman_4addr(packet_buff, buff_len, read_opt, time_printed);
+		case BATADV_UNICAST_TVLV:
+			if ((dump_level & DUMP_TYPE_BATUCAST) ||
+			    (dump_level & DUMP_TYPE_BATUTVLV))
+				dump_batman_ucast_tvlv(packet_buff, buff_len,
+						       read_opt, time_printed);
 			break;
 		default:
 			fprintf(stderr, "Warning - packet contains unknown batman packet type: 0x%02x\n", batman_ogm_packet->packet_type);
diff --git a/tcpdump.h b/tcpdump.h
index cfb1c69..328f19f 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -37,12 +37,13 @@
 #define ARPHRD_IEEE80211_RADIOTAP 803
 #endif
 
-#define DUMP_TYPE_BATOGM 1
-#define DUMP_TYPE_BATICMP 2
-#define DUMP_TYPE_BATUCAST 4
-#define DUMP_TYPE_BATBCAST 8
-#define DUMP_TYPE_BATFRAG 32
-#define DUMP_TYPE_NONBAT 128
+#define DUMP_TYPE_BATOGM	BIT(0)
+#define DUMP_TYPE_BATICMP	BIT(1)
+#define DUMP_TYPE_BATUCAST	BIT(2)
+#define DUMP_TYPE_BATBCAST	BIT(3)
+#define DUMP_TYPE_BATFRAG	BIT(4)
+#define DUMP_TYPE_BATUTVLV	BIT(5)
+#define DUMP_TYPE_NONBAT	BIT(6)
 
 #define IEEE80211_FCTL_FTYPE 0x0c00
 #define IEEE80211_FCTL_TODS 0x0001
-- 
1.8.5.5

