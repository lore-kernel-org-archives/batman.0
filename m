Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  6 Jun 2012 13:17:25 +0200
Message-Id: <1338981447-25754-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batctl: Prefix packet defines with
	BATADV_
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

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 packet.h     |   12 ++++++------
 ping.c       |   16 ++++++++--------
 tcpdump.c    |    8 ++++----
 traceroute.c |    4 ++--
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/packet.h b/packet.h
index c90219c..e562414 100644
--- a/packet.h
+++ b/packet.h
@@ -20,7 +20,7 @@
 #ifndef _NET_BATMAN_ADV_PACKET_H_
 #define _NET_BATMAN_ADV_PACKET_H_
 
-#define ETH_P_BATMAN  0x4305	/* unofficial/not registered Ethertype */
+#define BATADV_ETH_P_BATMAN  0x4305 /* unofficial/not registered Ethertype */
 
 enum bat_packettype {
 	BAT_IV_OGM	 = 0x01,
@@ -34,7 +34,7 @@ enum bat_packettype {
 };
 
 /* this file is included by batctl which needs these defines */
-#define COMPAT_VERSION 14
+#define BATADV_COMPAT_VERSION 14
 
 enum batman_iv_flags {
 	NOT_BEST_NEXT_HOP   = 1 << 3,
@@ -65,7 +65,7 @@ enum unicast_frag_flags {
 };
 
 /* TT_QUERY subtypes */
-#define TT_QUERY_TYPE_MASK 0x3
+#define BATADV_TT_QUERY_TYPE_MASK 0x3
 
 enum tt_query_packettype {
 	TT_REQUEST    = 0,
@@ -126,7 +126,7 @@ struct batman_ogm_packet {
 	__be16   tt_crc;
 } __packed;
 
-#define BATMAN_OGM_HLEN sizeof(struct batman_ogm_packet)
+#define BATADV_OGM_HLEN sizeof(struct batman_ogm_packet)
 
 struct icmp_packet {
 	struct batman_header header;
@@ -138,7 +138,7 @@ struct icmp_packet {
 	uint8_t  reserved;
 } __packed;
 
-#define BAT_RR_LEN 16
+#define BATADV_RR_LEN 16
 
 /* icmp_packet_rr must start with all fields from imcp_packet
  * as this is assumed by code that handles ICMP packets
@@ -151,7 +151,7 @@ struct icmp_packet_rr {
 	__be16   seqno;
 	uint8_t  uid;
 	uint8_t  rr_cur;
-	uint8_t  rr[BAT_RR_LEN][ETH_ALEN];
+	uint8_t  rr[BATADV_RR_LEN][ETH_ALEN];
 } __packed;
 
 struct unicast_packet {
diff --git a/ping.c b/ping.c
index 791cfb7..213f1e3 100644
--- a/ping.c
+++ b/ping.c
@@ -79,7 +79,7 @@ int ping(char *mesh_iface, int argc, char **argv)
 	char *dst_string, *mac_string, *rr_string;
 	double time_delta;
 	float min = 0.0, max = 0.0, avg = 0.0, mdev = 0.0;
-	uint8_t last_rr_cur = 0, last_rr[BAT_RR_LEN][ETH_ALEN];
+	uint8_t last_rr_cur = 0, last_rr[BATADV_RR_LEN][ETH_ALEN];
 	size_t packet_len;
 	char *debugfs_mnt;
 	char icmp_socket[MAX_PATH+1];
@@ -164,7 +164,7 @@ int ping(char *mesh_iface, int argc, char **argv)
 
 	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
 	icmp_packet_out.header.packet_type = BAT_ICMP;
-	icmp_packet_out.header.version = COMPAT_VERSION;
+	icmp_packet_out.header.version = BATADV_COMPAT_VERSION;
 	icmp_packet_out.msg_type = ECHO_REQUEST;
 	icmp_packet_out.header.ttl = 50;
 	icmp_packet_out.seqno = 0;
@@ -172,8 +172,8 @@ int ping(char *mesh_iface, int argc, char **argv)
 	if (rr) {
 		packet_len = sizeof(struct icmp_packet_rr);
 		icmp_packet_out.rr_cur = 1;
-		memset(&icmp_packet_out.rr, 0, BAT_RR_LEN * ETH_ALEN);
-		memset(last_rr, 0, BAT_RR_LEN * ETH_ALEN);
+		memset(&icmp_packet_out.rr, 0, BATADV_RR_LEN * ETH_ALEN);
+		memset(last_rr, 0, BATADV_RR_LEN * ETH_ALEN);
 	}
 
 	printf("PING %s (%s) %zu(%zu) bytes of data\n", dst_string, mac_string,
@@ -243,14 +243,14 @@ read_packet:
 
 			if (read_len == sizeof(struct icmp_packet_rr)) {
 				if (last_rr_cur == icmp_packet_in.rr_cur
-					&& !memcmp(last_rr, icmp_packet_in.rr, BAT_RR_LEN * ETH_ALEN)) {
+					&& !memcmp(last_rr, icmp_packet_in.rr, BATADV_RR_LEN * ETH_ALEN)) {
 
 					printf("\t(same route)");
 
 				} else {
 					printf("\nRR: ");
 
-					for (i = 0; i < BAT_RR_LEN
+					for (i = 0; i < BATADV_RR_LEN
 						&& i < icmp_packet_in.rr_cur; i++) {
 
 						rr_mac = (struct ether_addr *)&icmp_packet_in.rr[i];
@@ -266,7 +266,7 @@ read_packet:
 					}
 
 					last_rr_cur = icmp_packet_in.rr_cur;
-					memcpy(last_rr, icmp_packet_in.rr, BAT_RR_LEN * ETH_ALEN);
+					memcpy(last_rr, icmp_packet_in.rr, BATADV_RR_LEN * ETH_ALEN);
 				}
 			}
 
@@ -288,7 +288,7 @@ read_packet:
 			break;
 		case PARAMETER_PROBLEM:
 			printf("Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
-					icmp_packet_in.header.version, COMPAT_VERSION);
+					icmp_packet_in.header.version, BATADV_COMPAT_VERSION);
 			printf("Please make sure to use compatible versions!\n");
 			goto out;
 		default:
diff --git a/tcpdump.c b/tcpdump.c
index 6672cf1..1ead780 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -61,7 +61,7 @@ static void tcpdump_usage(void)
 {
 	printf("Usage: batctl tcpdump [options] interface [interface]\n");
 	printf("options:\n");
-	printf(" \t -c compat filter - only display packets matching own compat version (%i)\n", COMPAT_VERSION);
+	printf(" \t -c compat filter - only display packets matching own compat version (%i)\n", BATADV_COMPAT_VERSION);
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't convert addresses to bat-host names\n");
 	printf(" \t -p dump specific packet type\n");
@@ -264,7 +264,7 @@ static void dump_batman_tt(unsigned char *packet_buff, ssize_t buff_len, int rea
 	if (!time_printed)
 		print_time();
 
-	switch (tt_query_packet->flags & TT_QUERY_TYPE_MASK) {
+	switch (tt_query_packet->flags & BATADV_TT_QUERY_TYPE_MASK) {
 	case TT_REQUEST:
 		tt_desc = "request";
 		tt_data = "crc";
@@ -489,11 +489,11 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 		if ((dump_level & DUMP_TYPE_NONBAT) || (time_printed))
 			dump_vlan(packet_buff, buff_len, read_opt, time_printed);
 		break;
-	case ETH_P_BATMAN:
+	case BATADV_ETH_P_BATMAN:
 		batman_ogm_packet = (struct batman_ogm_packet *)(packet_buff + ETH_HLEN);
 
 		if ((read_opt & COMPAT_FILTER) &&
-		    (batman_ogm_packet->header.version != COMPAT_VERSION))
+		    (batman_ogm_packet->header.version != BATADV_COMPAT_VERSION))
 			return;
 
 		switch (batman_ogm_packet->header.packet_type) {
diff --git a/traceroute.c b/traceroute.c
index fdc9e4a..da0ba60 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -121,7 +121,7 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 	}
 
 	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
-	icmp_packet_out.header.version = COMPAT_VERSION;
+	icmp_packet_out.header.version = BATADV_COMPAT_VERSION;
 	icmp_packet_out.header.packet_type = BAT_ICMP;
 	icmp_packet_out.msg_type = ECHO_REQUEST;
 	icmp_packet_out.seqno = 0;
@@ -193,7 +193,7 @@ read_packet:
 				goto out;
 			case PARAMETER_PROBLEM:
 				printf("Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
-						icmp_packet_in.header.version, COMPAT_VERSION);
+						icmp_packet_in.header.version, BATADV_COMPAT_VERSION);
 				printf("Please make sure to use compatible versions!\n");
 				goto out;
 			default:
-- 
1.7.10

