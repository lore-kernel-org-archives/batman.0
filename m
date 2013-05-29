Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 29 May 2013 09:58:24 +0200
Message-Id: <1369814304-2852-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batctl: create common header for ICMP
	packets
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

the icmp and the icmp_rr packets share the same initial
fields since they use the same code to be processed and
forwarded.

Extract the common fields and put them into a separate
struct so that future ICMP packets can be easily added
without bloating the packet definition.

However, keep the seqno field outside of the newly created
common header because future ICMP types may require a
bigger sequence number space.

This change breaks compatibility due to fields reordering
in the ICMP headers.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---

v2:
- added changes to packet.h

 packet.h     | 38 ++++++++++++++++++++++++++++----------
 ping.c       | 24 ++++++++++++++----------
 tcpdump.c    | 27 +++++++++++++++++----------
 traceroute.c | 31 +++++++++++++++++++------------
 4 files changed, 78 insertions(+), 42 deletions(-)

diff --git a/packet.h b/packet.h
index 57d2002..8b8b03f 100644
--- a/packet.h
+++ b/packet.h
@@ -186,29 +186,47 @@ struct batadv_ogm_packet {
 
 #define BATADV_OGM_HLEN sizeof(struct batadv_ogm_packet)
 
-struct batadv_icmp_packet {
+/**
+ * batadc_icmp_header - common ICMP header
+ * @header: common batman header
+ * @msg_type: ICMP packet type
+ * @dst: address of the destination node
+ * @orig: address of the source node
+ * @uid: local ICMP socket identifier
+ */
+struct batadv_icmp_header {
 	struct batadv_header header;
 	uint8_t  msg_type; /* see ICMP message types above */
 	uint8_t  dst[ETH_ALEN];
 	uint8_t  orig[ETH_ALEN];
-	__be16   seqno;
 	uint8_t  uid;
+};
+
+/**
+ * batadv_icmp_packet - ICMP packet
+ * @icmph: common ICMP header
+ * @reserved: not used - useful for alignment
+ * @seqno: ICMP sequence number
+ */
+struct batadv_icmp_packet {
+	struct batadv_icmp_header icmph;
 	uint8_t  reserved;
+	__be16   seqno;
 };
 
 #define BATADV_RR_LEN 16
 
-/* icmp_packet_rr must start with all fields from imcp_packet
- * as this is assumed by code that handles ICMP packets
+/**
+ * batadv_icmp_packet_rr - ICMP RouteRecord packet
+ * @icmph: common ICMP header
+ * @rr_cur: number of entries the rr array
+ * @seqno: ICMP sequence number
+ * @rr: route record array
  */
 struct batadv_icmp_packet_rr {
-	struct batadv_header header;
-	uint8_t  msg_type; /* see ICMP message types above */
-	uint8_t  dst[ETH_ALEN];
-	uint8_t  orig[ETH_ALEN];
-	__be16   seqno;
-	uint8_t  uid;
+	struct batadv_icmp_header icmph;
 	uint8_t  rr_cur;
+	__be16   seqno;
 	uint8_t  rr[BATADV_RR_LEN][ETH_ALEN];
 };
 
diff --git a/ping.c b/ping.c
index 5d6b7e9..6679604 100644
--- a/ping.c
+++ b/ping.c
@@ -171,11 +171,11 @@ int ping(char *mesh_iface, int argc, char **argv)
 
 	packet_len = sizeof(struct batadv_icmp_packet);
 
-	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
-	icmp_packet_out.header.packet_type = BATADV_ICMP;
-	icmp_packet_out.header.version = BATADV_COMPAT_VERSION;
-	icmp_packet_out.msg_type = BATADV_ECHO_REQUEST;
-	icmp_packet_out.header.ttl = 50;
+	memcpy(&icmp_packet_out.icmph.dst, dst_mac, ETH_ALEN);
+	icmp_packet_out.icmph.header.packet_type = BATADV_ICMP;
+	icmp_packet_out.icmph.header.version = BATADV_COMPAT_VERSION;
+	icmp_packet_out.icmph.msg_type = BATADV_ECHO_REQUEST;
+	icmp_packet_out.icmph.header.ttl = 50;
 	icmp_packet_out.seqno = 0;
 
 	if (rr) {
@@ -245,12 +245,14 @@ read_packet:
 		if (htons(seq_counter) != icmp_packet_in.seqno)
 			goto read_packet;
 
-		switch (icmp_packet_in.msg_type) {
+		switch (icmp_packet_in.icmph.msg_type) {
 		case BATADV_ECHO_REPLY:
 			time_delta = end_timer();
 			printf("%zd bytes from %s icmp_seq=%hu ttl=%d time=%.2f ms",
-					read_len, dst_string, ntohs(icmp_packet_in.seqno),
-					icmp_packet_in.header.ttl, time_delta);
+					read_len, dst_string,
+					ntohs(icmp_packet_in.seqno),
+					icmp_packet_in.icmph.header.ttl,
+					time_delta);
 
 			if (read_len == sizeof(struct batadv_icmp_packet_rr)) {
 				if (last_rr_cur == icmp_packet_in.rr_cur
@@ -299,11 +301,13 @@ read_packet:
 			break;
 		case BATADV_PARAMETER_PROBLEM:
 			fprintf(stderr, "Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
-					icmp_packet_in.header.version, BATADV_COMPAT_VERSION);
+					icmp_packet_in.icmph.header.version,
+					BATADV_COMPAT_VERSION);
 			printf("Please make sure to use compatible versions!\n");
 			goto out;
 		default:
-			printf("Unknown message type %d len %zd received\n", icmp_packet_in.msg_type, read_len);
+			printf("Unknown message type %d len %zd received\n",
+			       icmp_packet_in.icmph.msg_type, read_len);
 			break;
 		}
 
diff --git a/tcpdump.c b/tcpdump.c
index 3e932cd..7e0987b 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -361,32 +361,39 @@ static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int r
 	if (!time_printed)
 		print_time();
 
-	printf("BAT %s > ", get_name_by_macaddr((struct ether_addr *)icmp_packet->orig, read_opt));
+	printf("BAT %s > ",
+	       get_name_by_macaddr((struct ether_addr *)icmp_packet->icmph.orig,
+				   read_opt));
 
-	name = get_name_by_macaddr((struct ether_addr *)icmp_packet->dst, read_opt);
+	name = get_name_by_macaddr((struct ether_addr *)icmp_packet->icmph.dst,
+				   read_opt);
 
-	switch (icmp_packet->msg_type) {
+	switch (icmp_packet->icmph.msg_type) {
 	case BATADV_ECHO_REPLY:
 		printf("%s: ICMP echo reply, id %hhu, seq %hu, ttl %2d, v %d, length %zu\n",
-			name, icmp_packet->uid, ntohs(icmp_packet->seqno),
-			icmp_packet->header.ttl, icmp_packet->header.version,
+			name, icmp_packet->icmph.uid, ntohs(icmp_packet->seqno),
+			icmp_packet->icmph.header.ttl,
+			icmp_packet->icmph.header.version,
 			(size_t)buff_len - sizeof(struct ether_header));
 		break;
 	case BATADV_ECHO_REQUEST:
 		printf("%s: ICMP echo request, id %hhu, seq %hu, ttl %2d, v %d, length %zu\n",
-			name, icmp_packet->uid, ntohs(icmp_packet->seqno),
-			icmp_packet->header.ttl, icmp_packet->header.version,
+			name, icmp_packet->icmph.uid, ntohs(icmp_packet->seqno),
+			icmp_packet->icmph.header.ttl,
+			icmp_packet->icmph.header.version,
 			(size_t)buff_len - sizeof(struct ether_header));
 		break;
 	case BATADV_TTL_EXCEEDED:
 		printf("%s: ICMP time exceeded in-transit, id %hhu, seq %hu, ttl %2d, v %d, length %zu\n",
-			name, icmp_packet->uid, ntohs(icmp_packet->seqno),
-			icmp_packet->header.ttl, icmp_packet->header.version,
+			name, icmp_packet->icmph.uid, ntohs(icmp_packet->seqno),
+			icmp_packet->icmph.header.ttl,
+			icmp_packet->icmph.header.version,
 			(size_t)buff_len - sizeof(struct ether_header));
 		break;
 	default:
 		printf("%s: ICMP type %hhu, length %zu\n",
-			name, icmp_packet->msg_type, (size_t)buff_len - sizeof(struct ether_header));
+			name, icmp_packet->icmph.msg_type,
+			(size_t)buff_len - sizeof(struct ether_header));
 		break;
 	}
 }
diff --git a/traceroute.c b/traceroute.c
index 38d3796..362d293 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -129,17 +129,19 @@ int traceroute(char *mesh_iface, int argc, char **argv)
 		goto out;
 	}
 
-	memcpy(&icmp_packet_out.dst, dst_mac, ETH_ALEN);
-	icmp_packet_out.header.version = BATADV_COMPAT_VERSION;
-	icmp_packet_out.header.packet_type = BATADV_ICMP;
-	icmp_packet_out.msg_type = BATADV_ECHO_REQUEST;
+	memcpy(&icmp_packet_out.icmph.dst, dst_mac, ETH_ALEN);
+	icmp_packet_out.icmph.header.version = BATADV_COMPAT_VERSION;
+	icmp_packet_out.icmph.header.packet_type = BATADV_ICMP;
+	icmp_packet_out.icmph.msg_type = BATADV_ECHO_REQUEST;
 	icmp_packet_out.seqno = 0;
 	icmp_packet_out.reserved = 0;
 
 	printf("traceroute to %s (%s), %d hops max, %zu byte packets\n",
 		dst_string, mac_string, TTL_MAX, sizeof(icmp_packet_out));
 
-	for (icmp_packet_out.header.ttl = 1; !dst_reached && icmp_packet_out.header.ttl < TTL_MAX; icmp_packet_out.header.ttl++) {
+	for (icmp_packet_out.icmph.header.ttl = 1;
+	     !dst_reached && icmp_packet_out.icmph.header.ttl < TTL_MAX;
+	     icmp_packet_out.icmph.header.ttl++) {
 		return_mac = NULL;
 		bat_host = NULL;
 
@@ -183,7 +185,7 @@ read_packet:
 			if (htons(seq_counter) != icmp_packet_in.seqno)
 				goto read_packet;
 
-			switch (icmp_packet_in.msg_type) {
+			switch (icmp_packet_in.icmph.msg_type) {
 			case BATADV_ECHO_REPLY:
 				dst_reached = 1;
 				/* fall through */
@@ -191,10 +193,10 @@ read_packet:
 				time_delta[i] = end_timer();
 
 				if (!return_mac) {
-					return_mac = ether_ntoa_long((struct ether_addr *)&icmp_packet_in.orig);
+					return_mac = ether_ntoa_long((struct ether_addr *)&icmp_packet_in.icmph.orig);
 
 					if (read_opt & USE_BAT_HOSTS)
-						bat_host = bat_hosts_find_by_mac((char *)&icmp_packet_in.orig);
+						bat_host = bat_hosts_find_by_mac((char *)&icmp_packet_in.icmph.orig);
 				}
 
 				break;
@@ -203,19 +205,24 @@ read_packet:
 				goto out;
 			case BATADV_PARAMETER_PROBLEM:
 				fprintf(stderr, "Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
-						icmp_packet_in.header.version, BATADV_COMPAT_VERSION);
+						icmp_packet_in.icmph.header.version,
+						BATADV_COMPAT_VERSION);
 				fprintf(stderr, "Please make sure to use compatible versions!\n");
 				goto out;
 			default:
-				printf("Unknown message type %d len %zd received\n", icmp_packet_in.msg_type, read_len);
+				printf("Unknown message type %d len %zd received\n",
+				       icmp_packet_in.icmph.msg_type, read_len);
 				break;
 			}
 		}
 
 		if (!bat_host)
-			printf("%2hhu: %s", icmp_packet_out.header.ttl, (return_mac ? return_mac : "*"));
+			printf("%2hhu: %s", icmp_packet_out.icmph.header.ttl,
+			       (return_mac ? return_mac : "*"));
 		else
-			printf("%2hhu: %s (%s)", icmp_packet_out.header.ttl, bat_host->name, return_mac);
+			printf("%2hhu: %s (%s)",
+			       icmp_packet_out.icmph.header.ttl,
+			       bat_host->name, return_mac);
 
 		for (i = 0; i < NUM_PACKETS; i++) {
 			if (time_delta[i])
-- 
1.8.1.5

