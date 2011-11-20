Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Nov 2011 15:47:39 +0100
Message-Id: <1321800459-15975-2-git-send-email-sven@narfation.org>
In-Reply-To: <1321800459-15975-1-git-send-email-sven@narfation.org>
References: <1321800459-15975-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: Explicitly mark the common
	header structure
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

All batman-adv packets have a common 3 byte header. It can be used to share
some code between different code paths, but it was never explicit stated that
this header has to be always the same for all packets. Therefore, new code
changes always have the problem that they may accidently introduce regressions
by moving some elements around.

A new structure is introduced that contains the common header and makes it
easier visible that these 3 bytes have to be the same for all on-wire packets.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 packet.h     |   38 +++++++++++++-------------------------
 ping.c       |   10 +++++-----
 tcpdump.c    |   20 ++++++++++----------
 traceroute.c |   12 ++++++------
 4 files changed, 34 insertions(+), 46 deletions(-)

diff --git a/packet.h b/packet.h
index 4d9e54c..88c717b 100644
--- a/packet.h
+++ b/packet.h
@@ -90,10 +90,14 @@ enum tt_client_flags {
 	TT_CLIENT_PENDING = 1 << 10
 };
 
-struct batman_ogm_packet {
+struct batman_header {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
 	uint8_t  ttl;
+} __packed;
+
+struct batman_ogm_packet {
+	struct batman_header header;
 	uint8_t  flags;    /* 0x40: DIRECTLINK flag, 0x20 VIS_SERVER flag... */
 	uint32_t seqno;
 	uint8_t  orig[6];
@@ -108,9 +112,7 @@ struct batman_ogm_packet {
 #define BATMAN_OGM_LEN sizeof(struct batman_ogm_packet)
 
 struct icmp_packet {
-	uint8_t  packet_type;
-	uint8_t  version;  /* batman version field */
-	uint8_t  ttl;
+	struct batman_header header;
 	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  dst[6];
 	uint8_t  orig[6];
@@ -124,9 +126,7 @@ struct icmp_packet {
 /* icmp_packet_rr must start with all fields from imcp_packet
  * as this is assumed by code that handles ICMP packets */
 struct icmp_packet_rr {
-	uint8_t  packet_type;
-	uint8_t  version;  /* batman version field */
-	uint8_t  ttl;
+	struct batman_header header;
 	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  dst[6];
 	uint8_t  orig[6];
@@ -137,17 +137,13 @@ struct icmp_packet_rr {
 } __packed;
 
 struct unicast_packet {
-	uint8_t  packet_type;
-	uint8_t  version;  /* batman version field */
-	uint8_t  ttl;
+	struct batman_header header;
 	uint8_t  ttvn; /* destination translation table version number */
 	uint8_t  dest[6];
 } __packed;
 
 struct unicast_frag_packet {
-	uint8_t  packet_type;
-	uint8_t  version;  /* batman version field */
-	uint8_t  ttl;
+	struct batman_header header;
 	uint8_t  ttvn; /* destination translation table version number */
 	uint8_t  dest[6];
 	uint8_t  flags;
@@ -157,18 +153,14 @@ struct unicast_frag_packet {
 } __packed;
 
 struct bcast_packet {
-	uint8_t  packet_type;
-	uint8_t  version;  /* batman version field */
-	uint8_t  ttl;
+	struct batman_header header;
 	uint8_t  reserved;
 	uint32_t seqno;
 	uint8_t  orig[6];
 } __packed;
 
 struct vis_packet {
-	uint8_t  packet_type;
-	uint8_t  version;        /* batman version field */
-	uint8_t  ttl;		 /* TTL */
+	struct batman_header header;
 	uint8_t  vis_type;	 /* which type of vis-participant sent this? */
 	uint32_t seqno;		 /* sequence number */
 	uint8_t  entries;	 /* number of entries behind this struct */
@@ -179,9 +171,7 @@ struct vis_packet {
 } __packed;
 
 struct tt_query_packet {
-	uint8_t  packet_type;
-	uint8_t  version;  /* batman version field */
-	uint8_t  ttl;
+	struct batman_header header;
 	/* the flag field is a combination of:
 	 * - TT_REQUEST or TT_RESPONSE
 	 * - TT_FULL_TABLE */
@@ -202,9 +192,7 @@ struct tt_query_packet {
 } __packed;
 
 struct roam_adv_packet {
-	uint8_t  packet_type;
-	uint8_t  version;
-	uint8_t  ttl;
+	struct batman_header header;
 	uint8_t  reserved;
 	uint8_t  dst[ETH_ALEN];
 	uint8_t  src[ETH_ALEN];
diff --git a/ping.c b/ping.c
index 91b733a..d880290 100644
--- a/ping.c
+++ b/ping.c
@@ -163,10 +163,10 @@ int ping(char *mesh_iface, int argc, char **argv)
 	packet_len = sizeof(struct icmp_packet);
 
 	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
-	icmp_packet_out.packet_type = BAT_ICMP;
-	icmp_packet_out.version = COMPAT_VERSION;
+	icmp_packet_out.header.packet_type = BAT_ICMP;
+	icmp_packet_out.header.version = COMPAT_VERSION;
 	icmp_packet_out.msg_type = ECHO_REQUEST;
-	icmp_packet_out.ttl = 50;
+	icmp_packet_out.header.ttl = 50;
 	icmp_packet_out.seqno = 0;
 
 	if (rr) {
@@ -234,7 +234,7 @@ int ping(char *mesh_iface, int argc, char **argv)
 			time_delta = end_timer();
 			printf("%zd bytes from %s icmp_seq=%hu ttl=%d time=%.2f ms",
 					read_len, dst_string, ntohs(icmp_packet_in.seqno),
-					icmp_packet_in.ttl, time_delta);
+					icmp_packet_in.header.ttl, time_delta);
 
 			if (read_len == sizeof(struct icmp_packet_rr)) {
 				if (last_rr_cur == icmp_packet_in.rr_cur
@@ -283,7 +283,7 @@ int ping(char *mesh_iface, int argc, char **argv)
 			break;
 		case PARAMETER_PROBLEM:
 			printf("Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
-					icmp_packet_in.version, COMPAT_VERSION);
+					icmp_packet_in.header.version, COMPAT_VERSION);
 			printf("Please make sure to use compatible versions!\n");
 			goto out;
 		default:
diff --git a/tcpdump.c b/tcpdump.c
index 7dd289e..8bfcecb 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -287,7 +287,7 @@ static void dump_batman_tt(unsigned char *packet_buff, ssize_t buff_len, int rea
 	printf("%s: TT %s, ttvn %d, %s %u, ttl %2d, v %d, flags [%c%c], length %zu\n",
 	       get_name_by_macaddr((struct ether_addr *)tt_query_packet->dst, read_opt),
 	       tt_desc, tt_query_packet->ttvn, tt_data, ntohs(tt_query_packet->tt_data),
-	       tt_query_packet->ttl, tt_query_packet->version,
+	       tt_query_packet->header.ttl, tt_query_packet->header.version,
 	       tt_type, (tt_query_packet->flags & TT_FULL_TABLE ? 'F' : '.'),
 	       (size_t)buff_len - sizeof(struct ether_header));
 }
@@ -311,7 +311,7 @@ static void dump_batman_roam(unsigned char *packet_buff, ssize_t buff_len, int r
 
 	printf("client %s, ttl %2d, v %d, length %zu\n",
 	       get_name_by_macaddr((struct ether_addr *)roam_adv_packet->client, read_opt),
-	       roam_adv_packet->ttl, roam_adv_packet->version,
+	       roam_adv_packet->header.ttl, roam_adv_packet->header.version,
 	       (size_t)buff_len - sizeof(struct ether_header));
 }
 
@@ -334,7 +334,7 @@ static void dump_batman_ogm(unsigned char *packet_buff, ssize_t buff_len, int re
 	printf("OGM via neigh %s, seq %u, tq %3d, ttvn %d, ttcrc %hu, ttl %2d, v %d, flags [%c%c%c%c], length %zu\n",
 	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt),
 	       ntohl(batman_ogm_packet->seqno), batman_ogm_packet->tq, batman_ogm_packet->ttvn,
-	       ntohs(batman_ogm_packet->tt_crc), batman_ogm_packet->ttl, batman_ogm_packet->version,
+	       ntohs(batman_ogm_packet->tt_crc), batman_ogm_packet->header.ttl, batman_ogm_packet->header.version,
 	       (batman_ogm_packet->flags & DIRECTLINK ? 'D' : '.'),
 	       (batman_ogm_packet->flags & VIS_SERVER ? 'V' : '.'),
 	       (batman_ogm_packet->flags & PRIMARIES_FIRST_HOP ? 'F' : '.'),
@@ -362,19 +362,19 @@ static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int r
 	case ECHO_REPLY:
 		printf("%s: ICMP echo reply, id %hhu, seq %hu, ttl %2d, v %d, length %zu\n",
 			name, icmp_packet->uid, ntohs(icmp_packet->seqno),
-			icmp_packet->ttl, icmp_packet->version,
+			icmp_packet->header.ttl, icmp_packet->header.version,
 			(size_t)buff_len - sizeof(struct ether_header));
 		break;
 	case ECHO_REQUEST:
 		printf("%s: ICMP echo request, id %hhu, seq %hu, ttl %2d, v %d, length %zu\n",
 			name, icmp_packet->uid, ntohs(icmp_packet->seqno),
-			icmp_packet->ttl, icmp_packet->version,
+			icmp_packet->header.ttl, icmp_packet->header.version,
 			(size_t)buff_len - sizeof(struct ether_header));
 		break;
 	case TTL_EXCEEDED:
 		printf("%s: ICMP time exceeded in-transit, id %hhu, seq %hu, ttl %2d, v %d, length %zu\n",
 			name, icmp_packet->uid, ntohs(icmp_packet->seqno),
-			icmp_packet->ttl, icmp_packet->version,
+			icmp_packet->header.ttl, icmp_packet->header.version,
 			(size_t)buff_len - sizeof(struct ether_header));
 		break;
 	default:
@@ -404,7 +404,7 @@ static void dump_batman_ucast(unsigned char *packet_buff, ssize_t buff_len, int
 
 	printf("%s: UCAST, ttvn %d, ttl %hhu, ",
 	       get_name_by_macaddr((struct ether_addr *)unicast_packet->dest, read_opt),
-	       unicast_packet->ttvn, unicast_packet->ttl);
+	       unicast_packet->ttvn, unicast_packet->header.ttl);
 
 	parse_eth_hdr(packet_buff + ETH_HLEN + sizeof(struct unicast_packet),
 		      buff_len - ETH_HLEN - sizeof(struct unicast_packet),
@@ -455,7 +455,7 @@ static void dump_batman_frag(unsigned char *packet_buff, ssize_t buff_len, int r
 
 	printf("%s: FRAG, seq %hu, ttvn %d, ttl %hhu, flags [%c%c], ",
 	       get_name_by_macaddr((struct ether_addr *)unicast_frag_packet->dest, read_opt),
-	       ntohs(unicast_frag_packet->seqno), unicast_frag_packet->ttvn, unicast_frag_packet->ttl,
+	       ntohs(unicast_frag_packet->seqno), unicast_frag_packet->ttvn, unicast_frag_packet->header.ttl,
 	       (unicast_frag_packet->flags & UNI_FRAG_HEAD ? 'H' : '.'),
 	       (unicast_frag_packet->flags & UNI_FRAG_LARGETAIL ? 'L' : '.'));
 
@@ -490,7 +490,7 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 	case ETH_P_BATMAN:
 		batman_ogm_packet = (struct batman_ogm_packet *)(packet_buff + ETH_HLEN);
 
-		switch (batman_ogm_packet->packet_type) {
+		switch (batman_ogm_packet->header.packet_type) {
 		case BAT_OGM:
 			if (dump_level & DUMP_TYPE_BATOGM)
 				dump_batman_ogm(packet_buff, buff_len, read_opt, time_printed);
@@ -524,7 +524,7 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 				dump_batman_roam(packet_buff, buff_len, read_opt, time_printed);
 			break;
 		default:
-			printf("Warning - packet contains unknown batman packet type: 0x%02x\n", batman_ogm_packet->packet_type);
+			printf("Warning - packet contains unknown batman packet type: 0x%02x\n", batman_ogm_packet->header.packet_type);
 			break;
 		}
 
diff --git a/traceroute.c b/traceroute.c
index d120311..4dc41fc 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -121,15 +121,15 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 	}
 
 	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
-	icmp_packet_out.version = COMPAT_VERSION;
-	icmp_packet_out.packet_type = BAT_ICMP;
+	icmp_packet_out.header.version = COMPAT_VERSION;
+	icmp_packet_out.header.packet_type = BAT_ICMP;
 	icmp_packet_out.msg_type = ECHO_REQUEST;
 	icmp_packet_out.seqno = 0;
 
 	printf("traceroute to %s (%s), %d hops max, %zu byte packets\n",
 		dst_string, mac_string, TTL_MAX, sizeof(icmp_packet_out));
 
-	for (icmp_packet_out.ttl = 1; !dst_reached && icmp_packet_out.ttl < TTL_MAX; icmp_packet_out.ttl++) {
+	for (icmp_packet_out.header.ttl = 1; !dst_reached && icmp_packet_out.header.ttl < TTL_MAX; icmp_packet_out.header.ttl++) {
 		return_mac = NULL;
 		bat_host = NULL;
 
@@ -188,7 +188,7 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 				goto out;
 			case PARAMETER_PROBLEM:
 				printf("Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
-						icmp_packet_in.version, COMPAT_VERSION);
+						icmp_packet_in.header.version, COMPAT_VERSION);
 				printf("Please make sure to use compatible versions!\n");
 				goto out;
 			default:
@@ -198,9 +198,9 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 		}
 
 		if (!bat_host)
-			printf("%2hhu: %s", icmp_packet_out.ttl, (return_mac ? return_mac : "*"));
+			printf("%2hhu: %s", icmp_packet_out.header.ttl, (return_mac ? return_mac : "*"));
 		else
-			printf("%2hhu: %s (%s)", icmp_packet_out.ttl, bat_host->name, return_mac);
+			printf("%2hhu: %s (%s)", icmp_packet_out.header.ttl, bat_host->name, return_mac);
 
 		for (i = 0; i < NUM_PACKETS; i++) {
 			if (time_delta[i])
-- 
1.7.7.3

