Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  6 Jun 2012 13:17:26 +0200
Message-Id: <1338981447-25754-2-git-send-email-sven@narfation.org>
In-Reply-To: <1338981447-25754-1-git-send-email-sven@narfation.org>
References: <1338981447-25754-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batctl: Prefix packet enum with BATADV_
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
 packet.h     |   86 +++++++++++++++++++++++++++++-----------------------------
 ping.c       |   12 ++++----
 tcpdump.c    |   42 ++++++++++++++--------------
 traceroute.c |   12 ++++----
 4 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/packet.h b/packet.h
index e562414..2ca6819 100644
--- a/packet.h
+++ b/packet.h
@@ -22,80 +22,80 @@
 
 #define BATADV_ETH_P_BATMAN  0x4305 /* unofficial/not registered Ethertype */
 
-enum bat_packettype {
-	BAT_IV_OGM	 = 0x01,
-	BAT_ICMP	 = 0x02,
-	BAT_UNICAST	 = 0x03,
-	BAT_BCAST	 = 0x04,
-	BAT_VIS		 = 0x05,
-	BAT_UNICAST_FRAG = 0x06,
-	BAT_TT_QUERY	 = 0x07,
-	BAT_ROAM_ADV	 = 0x08
+enum batadv_packettype {
+	BATADV_IV_OGM	    = 0x01,
+	BATADV_ICMP	    = 0x02,
+	BATADV_UNICAST	    = 0x03,
+	BATADV_BCAST	    = 0x04,
+	BATADV_VIS	    = 0x05,
+	BATADV_UNICAST_FRAG = 0x06,
+	BATADV_TT_QUERY	    = 0x07,
+	BATADV_ROAM_ADV	    = 0x08,
 };
 
 /* this file is included by batctl which needs these defines */
 #define BATADV_COMPAT_VERSION 14
 
-enum batman_iv_flags {
-	NOT_BEST_NEXT_HOP   = 1 << 3,
-	PRIMARIES_FIRST_HOP = 1 << 4,
-	VIS_SERVER	    = 1 << 5,
-	DIRECTLINK	    = 1 << 6
+enum batadv_iv_flags {
+	BATADV_NOT_BEST_NEXT_HOP   = 1 << 3,
+	BATADV_PRIMARIES_FIRST_HOP = 1 << 4,
+	BATADV_VIS_SERVER	   = 1 << 5,
+	BATADV_DIRECTLINK	   = 1 << 6,
 };
 
 /* ICMP message types */
-enum icmp_packettype {
-	ECHO_REPLY		= 0,
-	DESTINATION_UNREACHABLE = 3,
-	ECHO_REQUEST		= 8,
-	TTL_EXCEEDED		= 11,
-	PARAMETER_PROBLEM	= 12
+enum batadv_icmp_packettype {
+	BATADV_ECHO_REPLY	       = 0,
+	BATADV_DESTINATION_UNREACHABLE = 3,
+	BATADV_ECHO_REQUEST	       = 8,
+	BATADV_TTL_EXCEEDED	       = 11,
+	BATADV_PARAMETER_PROBLEM       = 12,
 };
 
 /* vis defines */
-enum vis_packettype {
-	VIS_TYPE_SERVER_SYNC   = 0,
-	VIS_TYPE_CLIENT_UPDATE = 1
+enum batadv_vis_packettype {
+	BATADV_VIS_TYPE_SERVER_SYNC   = 0,
+	BATADV_VIS_TYPE_CLIENT_UPDATE = 1,
 };
 
 /* fragmentation defines */
-enum unicast_frag_flags {
-	UNI_FRAG_HEAD	   = 1 << 0,
-	UNI_FRAG_LARGETAIL = 1 << 1
+enum batadv_unicast_frag_flags {
+	BATADV_UNI_FRAG_HEAD	  = 1 << 0,
+	BATADV_UNI_FRAG_LARGETAIL = 1 << 1,
 };
 
 /* TT_QUERY subtypes */
 #define BATADV_TT_QUERY_TYPE_MASK 0x3
 
-enum tt_query_packettype {
-	TT_REQUEST    = 0,
-	TT_RESPONSE   = 1
+enum batadv_tt_query_packettype {
+	BATADV_TT_REQUEST  = 0,
+	BATADV_TT_RESPONSE = 1,
 };
 
 /* TT_QUERY flags */
-enum tt_query_flags {
-	TT_FULL_TABLE = 1 << 2
+enum batadv_tt_query_flags {
+	BATADV_TT_FULL_TABLE = 1 << 2,
 };
 
 /* TT_CLIENT flags.
  * Flags from 1 to 1 << 7 are sent on the wire, while flags from 1 << 8 to
  * 1 << 15 are used for local computation only
  */
-enum tt_client_flags {
-	TT_CLIENT_DEL     = 1 << 0,
-	TT_CLIENT_ROAM    = 1 << 1,
-	TT_CLIENT_WIFI    = 1 << 2,
-	TT_CLIENT_NOPURGE = 1 << 8,
-	TT_CLIENT_NEW     = 1 << 9,
-	TT_CLIENT_PENDING = 1 << 10
+enum batadv_tt_client_flags {
+	BATADV_TT_CLIENT_DEL     = 1 << 0,
+	BATADV_TT_CLIENT_ROAM    = 1 << 1,
+	BATADV_TT_CLIENT_WIFI    = 1 << 2,
+	BATADV_TT_CLIENT_NOPURGE = 1 << 8,
+	BATADV_TT_CLIENT_NEW     = 1 << 9,
+	BATADV_TT_CLIENT_PENDING = 1 << 10,
 };
 
 /* claim frame types for the bridge loop avoidance */
-enum bla_claimframe {
-	CLAIM_TYPE_ADD		= 0x00,
-	CLAIM_TYPE_DEL		= 0x01,
-	CLAIM_TYPE_ANNOUNCE	= 0x02,
-	CLAIM_TYPE_REQUEST	= 0x03
+enum batadv_bla_claimframe {
+	BATADV_CLAIM_TYPE_ADD		= 0x00,
+	BATADV_CLAIM_TYPE_DEL		= 0x01,
+	BATADV_CLAIM_TYPE_ANNOUNCE	= 0x02,
+	BATADV_CLAIM_TYPE_REQUEST	= 0x03,
 };
 
 /* the destination hardware field in the ARP frame is used to
diff --git a/ping.c b/ping.c
index 213f1e3..a4d579f 100644
--- a/ping.c
+++ b/ping.c
@@ -163,9 +163,9 @@ int ping(char *mesh_iface, int argc, char **argv)
 	packet_len = sizeof(struct icmp_packet);
 
 	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
-	icmp_packet_out.header.packet_type = BAT_ICMP;
+	icmp_packet_out.header.packet_type = BATADV_ICMP;
 	icmp_packet_out.header.version = BATADV_COMPAT_VERSION;
-	icmp_packet_out.msg_type = ECHO_REQUEST;
+	icmp_packet_out.msg_type = BATADV_ECHO_REQUEST;
 	icmp_packet_out.header.ttl = 50;
 	icmp_packet_out.seqno = 0;
 
@@ -235,7 +235,7 @@ read_packet:
 			goto read_packet;
 
 		switch (icmp_packet_in.msg_type) {
-		case ECHO_REPLY:
+		case BATADV_ECHO_REPLY:
 			time_delta = end_timer();
 			printf("%zd bytes from %s icmp_seq=%hu ttl=%d time=%.2f ms",
 					read_len, dst_string, ntohs(icmp_packet_in.seqno),
@@ -280,13 +280,13 @@ read_packet:
 			mdev += time_delta * time_delta;
 			packets_in++;
 			break;
-		case DESTINATION_UNREACHABLE:
+		case BATADV_DESTINATION_UNREACHABLE:
 			printf("From %s: Destination Host Unreachable (icmp_seq %hu)\n", dst_string, ntohs(icmp_packet_in.seqno));
 			break;
-		case TTL_EXCEEDED:
+		case BATADV_TTL_EXCEEDED:
 			printf("From %s: Time to live exceeded (icmp_seq %hu)\n", dst_string, ntohs(icmp_packet_in.seqno));
 			break;
-		case PARAMETER_PROBLEM:
+		case BATADV_PARAMETER_PROBLEM:
 			printf("Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
 					icmp_packet_in.header.version, BATADV_COMPAT_VERSION);
 			printf("Please make sure to use compatible versions!\n");
diff --git a/tcpdump.c b/tcpdump.c
index 1ead780..ba012a7 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -265,12 +265,12 @@ static void dump_batman_tt(unsigned char *packet_buff, ssize_t buff_len, int rea
 		print_time();
 
 	switch (tt_query_packet->flags & BATADV_TT_QUERY_TYPE_MASK) {
-	case TT_REQUEST:
+	case BATADV_TT_REQUEST:
 		tt_desc = "request";
 		tt_data = "crc";
 		tt_type = 'Q';
 		break;
-	case TT_RESPONSE:
+	case BATADV_TT_RESPONSE:
 		tt_desc = "response";
 		tt_data = "entries";
 		tt_type = 'P';
@@ -289,7 +289,7 @@ static void dump_batman_tt(unsigned char *packet_buff, ssize_t buff_len, int rea
 	       get_name_by_macaddr((struct ether_addr *)tt_query_packet->dst, read_opt),
 	       tt_desc, tt_query_packet->ttvn, tt_data, ntohs(tt_query_packet->tt_data),
 	       tt_query_packet->header.ttl, tt_query_packet->header.version,
-	       tt_type, (tt_query_packet->flags & TT_FULL_TABLE ? 'F' : '.'),
+	       tt_type, (tt_query_packet->flags & BATADV_TT_FULL_TABLE ? 'F' : '.'),
 	       (size_t)buff_len - sizeof(struct ether_header));
 }
 
@@ -336,10 +336,10 @@ static void dump_batman_iv_ogm(unsigned char *packet_buff, ssize_t buff_len, int
 	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt),
 	       ntohl(batman_ogm_packet->seqno), batman_ogm_packet->tq, batman_ogm_packet->ttvn,
 	       ntohs(batman_ogm_packet->tt_crc), batman_ogm_packet->header.ttl, batman_ogm_packet->header.version,
-	       (batman_ogm_packet->flags & NOT_BEST_NEXT_HOP ? 'N' : '.'),
-	       (batman_ogm_packet->flags & DIRECTLINK ? 'D' : '.'),
-	       (batman_ogm_packet->flags & VIS_SERVER ? 'V' : '.'),
-	       (batman_ogm_packet->flags & PRIMARIES_FIRST_HOP ? 'F' : '.'),
+	       (batman_ogm_packet->flags & BATADV_NOT_BEST_NEXT_HOP ? 'N' : '.'),
+	       (batman_ogm_packet->flags & BATADV_DIRECTLINK ? 'D' : '.'),
+	       (batman_ogm_packet->flags & BATADV_VIS_SERVER ? 'V' : '.'),
+	       (batman_ogm_packet->flags & BATADV_PRIMARIES_FIRST_HOP ? 'F' : '.'),
 	       (batman_ogm_packet->gw_flags ? 'G' : '.'),
 	       (size_t)buff_len - sizeof(struct ether_header));
 }
@@ -361,19 +361,19 @@ static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int r
 	name = get_name_by_macaddr((struct ether_addr *)icmp_packet->dst, read_opt);
 
 	switch (icmp_packet->msg_type) {
-	case ECHO_REPLY:
+	case BATADV_ECHO_REPLY:
 		printf("%s: ICMP echo reply, id %hhu, seq %hu, ttl %2d, v %d, length %zu\n",
 			name, icmp_packet->uid, ntohs(icmp_packet->seqno),
 			icmp_packet->header.ttl, icmp_packet->header.version,
 			(size_t)buff_len - sizeof(struct ether_header));
 		break;
-	case ECHO_REQUEST:
+	case BATADV_ECHO_REQUEST:
 		printf("%s: ICMP echo request, id %hhu, seq %hu, ttl %2d, v %d, length %zu\n",
 			name, icmp_packet->uid, ntohs(icmp_packet->seqno),
 			icmp_packet->header.ttl, icmp_packet->header.version,
 			(size_t)buff_len - sizeof(struct ether_header));
 		break;
-	case TTL_EXCEEDED:
+	case BATADV_TTL_EXCEEDED:
 		printf("%s: ICMP time exceeded in-transit, id %hhu, seq %hu, ttl %2d, v %d, length %zu\n",
 			name, icmp_packet->uid, ntohs(icmp_packet->seqno),
 			icmp_packet->header.ttl, icmp_packet->header.version,
@@ -458,10 +458,10 @@ static void dump_batman_frag(unsigned char *packet_buff, ssize_t buff_len, int r
 	printf("%s: FRAG, seq %hu, ttvn %d, ttl %hhu, flags [%c%c], ",
 	       get_name_by_macaddr((struct ether_addr *)unicast_frag_packet->dest, read_opt),
 	       ntohs(unicast_frag_packet->seqno), unicast_frag_packet->ttvn, unicast_frag_packet->header.ttl,
-	       (unicast_frag_packet->flags & UNI_FRAG_HEAD ? 'H' : '.'),
-	       (unicast_frag_packet->flags & UNI_FRAG_LARGETAIL ? 'L' : '.'));
+	       (unicast_frag_packet->flags & BATADV_UNI_FRAG_HEAD ? 'H' : '.'),
+	       (unicast_frag_packet->flags & BATADV_UNI_FRAG_LARGETAIL ? 'L' : '.'));
 
-	if (unicast_frag_packet->flags & UNI_FRAG_HEAD)
+	if (unicast_frag_packet->flags & BATADV_UNI_FRAG_HEAD)
 		parse_eth_hdr(packet_buff + ETH_HLEN + sizeof(struct unicast_frag_packet),
 			      buff_len - ETH_HLEN - sizeof(struct unicast_frag_packet),
 			      read_opt, time_printed);
@@ -497,35 +497,35 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 			return;
 
 		switch (batman_ogm_packet->header.packet_type) {
-		case BAT_IV_OGM:
+		case BATADV_IV_OGM:
 			if (dump_level & DUMP_TYPE_BATOGM)
 				dump_batman_iv_ogm(packet_buff, buff_len, read_opt, time_printed);
 			break;
-		case BAT_ICMP:
+		case BATADV_ICMP:
 			if (dump_level & DUMP_TYPE_BATICMP)
 				dump_batman_icmp(packet_buff, buff_len, read_opt, time_printed);
 			break;
-		case BAT_UNICAST:
+		case BATADV_UNICAST:
 			if (dump_level & DUMP_TYPE_BATUCAST)
 				dump_batman_ucast(packet_buff, buff_len, read_opt, time_printed);
 			break;
-		case BAT_BCAST:
+		case BATADV_BCAST:
 			if (dump_level & DUMP_TYPE_BATBCAST)
 				dump_batman_bcast(packet_buff, buff_len, read_opt, time_printed);
 			break;
-		case BAT_VIS:
+		case BATADV_VIS:
 			if (dump_level & DUMP_TYPE_BATVIS)
 				printf("Warning - batman vis packet received: function not implemented yet\n");
 			break;
-		case BAT_UNICAST_FRAG:
+		case BATADV_UNICAST_FRAG:
 			if (dump_level & DUMP_TYPE_BATFRAG)
 				dump_batman_frag(packet_buff, buff_len, read_opt, time_printed);
 			break;
-		case BAT_TT_QUERY:
+		case BATADV_TT_QUERY:
 			if (dump_level & DUMP_TYPE_BATTT)
 				dump_batman_tt(packet_buff, buff_len, read_opt, time_printed);
 			break;
-		case BAT_ROAM_ADV:
+		case BATADV_ROAM_ADV:
 			if (dump_level & DUMP_TYPE_BATTT)
 				dump_batman_roam(packet_buff, buff_len, read_opt, time_printed);
 			break;
diff --git a/traceroute.c b/traceroute.c
index da0ba60..9ef70e8 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -122,8 +122,8 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 
 	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
 	icmp_packet_out.header.version = BATADV_COMPAT_VERSION;
-	icmp_packet_out.header.packet_type = BAT_ICMP;
-	icmp_packet_out.msg_type = ECHO_REQUEST;
+	icmp_packet_out.header.packet_type = BATADV_ICMP;
+	icmp_packet_out.msg_type = BATADV_ECHO_REQUEST;
 	icmp_packet_out.seqno = 0;
 
 	printf("traceroute to %s (%s), %d hops max, %zu byte packets\n",
@@ -174,10 +174,10 @@ read_packet:
 				goto read_packet;
 
 			switch (icmp_packet_in.msg_type) {
-			case ECHO_REPLY:
+			case BATADV_ECHO_REPLY:
 				dst_reached = 1;
 				/* fall through */
-			case TTL_EXCEEDED:
+			case BATADV_TTL_EXCEEDED:
 				time_delta[i] = end_timer();
 
 				if (!return_mac) {
@@ -188,10 +188,10 @@ read_packet:
 				}
 
 				break;
-			case DESTINATION_UNREACHABLE:
+			case BATADV_DESTINATION_UNREACHABLE:
 				printf("%s: Destination Host Unreachable\n", dst_string);
 				goto out;
-			case PARAMETER_PROBLEM:
+			case BATADV_PARAMETER_PROBLEM:
 				printf("Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
 						icmp_packet_in.header.version, BATADV_COMPAT_VERSION);
 				printf("Please make sure to use compatible versions!\n");
-- 
1.7.10

