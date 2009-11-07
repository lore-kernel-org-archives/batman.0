Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat,  7 Nov 2009 17:20:53 +0100
Message-Id: <1257610853-29008-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] [batctl] Correct printf format string
	conversation
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net


Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/ping.c       |   12 ++++++------
 batctl/tcpdump.c    |   44 ++++++++++++++++++++++----------------------
 batctl/traceroute.c |   10 +++++-----
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/batctl/ping.c b/batctl/ping.c
index f6b11af..8020643 100644
--- a/batctl/ping.c
+++ b/batctl/ping.c
@@ -148,7 +148,7 @@ int ping(int argc, char **argv)
 	icmp_packet_out.ttl = 50;
 	icmp_packet_out.seqno = 0;
 
-	printf("PING %s (%s) %zi(%zi) bytes of data\n", dst_string, mac_string,
+	printf("PING %s (%s) %zu(%zu) bytes of data\n", dst_string, mac_string,
 		sizeof(icmp_packet_out), sizeof(icmp_packet_out) + 28);
 
 	while (!is_aborted) {
@@ -196,7 +196,7 @@ int ping(int argc, char **argv)
 		}
 
 		if ((size_t)read_len < sizeof(icmp_packet_in)) {
-			printf("Warning - dropping received packet as it is smaller than expected (%zd): %zd\n",
+			printf("Warning - dropping received packet as it is smaller than expected (%zu): %zd\n",
 				sizeof(icmp_packet_in), read_len);
 			goto sleep;
 		}
@@ -204,7 +204,7 @@ int ping(int argc, char **argv)
 		switch (icmp_packet_in.msg_type) {
 		case ECHO_REPLY:
 			time_delta = end_timer();
-			printf("%zd bytes from %s icmp_seq=%u ttl=%d time=%.2f ms\n",
+			printf("%zd bytes from %s icmp_seq=%hu ttl=%d time=%.2f ms\n",
 					read_len, dst_string, ntohs(icmp_packet_in.seqno),
 					icmp_packet_in.ttl, time_delta);
 
@@ -216,10 +216,10 @@ int ping(int argc, char **argv)
 			packets_in++;
 			break;
 		case DESTINATION_UNREACHABLE:
-			printf("From %s: Destination Host Unreachable (icmp_seq %u)\n", dst_string, ntohs(icmp_packet_in.seqno));
+			printf("From %s: Destination Host Unreachable (icmp_seq %hu)\n", dst_string, ntohs(icmp_packet_in.seqno));
 			break;
 		case TTL_EXCEEDED:
-			printf("From %s: Time to live exceeded (icmp_seq %u)\n", dst_string, ntohs(icmp_packet_in.seqno));
+			printf("From %s: Time to live exceeded (icmp_seq %hu)\n", dst_string, ntohs(icmp_packet_in.seqno));
 			break;
 		case PARAMETER_PROBLEM:
 			printf("Error - the batman adv kernel module version (%d) differs from ours (%d)\n",
@@ -243,7 +243,7 @@ sleep:
 		packets_loss = ((packets_out - packets_in) * 100) / packets_out;
 
 	printf("--- %s ping statistics ---\n", dst_string);
-	printf("%d packets transmitted, %d received, %d%% packet loss\n",
+	printf("%u packets transmitted, %u received, %u%% packet loss\n",
 		packets_out, packets_in, packets_loss);
 	printf("rtt min/avg/max/mdev = %.3f/%.3f/%.3f/%.3f ms\n",
 		min, (packets_in ? (avg / packets_in) : 0.000), max, (max - min));
diff --git a/batctl/tcpdump.c b/batctl/tcpdump.c
index e121472..b96984b 100644
--- a/batctl/tcpdump.c
+++ b/batctl/tcpdump.c
@@ -45,7 +45,7 @@
 
 #define LEN_CHECK(buff_len, check_len, desc) \
 if ((size_t)(buff_len) < (check_len)) { \
-	printf("Warning - dropping received %s packet as it is smaller than expected (%zd): %zd\n", \
+	printf("Warning - dropping received %s packet as it is smaller than expected (%zu): %zu\n", \
 		desc, (check_len), (size_t)(buff_len)); \
 	return; \
 }
@@ -127,7 +127,7 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_print
 
 		switch (icmphdr->type) {
 		case ICMP_ECHOREPLY:
-			printf("%s: ICMP echo reply, id %u, seq %u, length %zd\n",
+			printf("%s: ICMP echo reply, id %hu, seq %hu, length %zu\n",
 				inet_ntoa(*(struct in_addr *)&iphdr->daddr),
 				ntohs(icmphdr->un.echo.id), ntohs(icmphdr->un.echo.sequence),
 				(size_t)buff_len - (iphdr->ihl * 4));
@@ -142,12 +142,12 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_print
 				tmp_udphdr = (struct udphdr *)(((char *)tmp_iphdr) + (tmp_iphdr->ihl * 4));
 
 				printf("%s: ICMP ", inet_ntoa(*(struct in_addr *)&iphdr->daddr));
-				printf("%s udp port %u unreachable, length %zd\n",
+				printf("%s udp port %hu unreachable, length %zu\n",
 					inet_ntoa(*(struct in_addr *)&tmp_iphdr->daddr),
 					ntohs(tmp_udphdr->dest), (size_t)buff_len - (iphdr->ihl * 4));
 				break;
 			default:
-				printf("%s: ICMP unreachable %u, length %zd\n",
+				printf("%s: ICMP unreachable %hhu, length %zu\n",
 					inet_ntoa(*(struct in_addr *)&iphdr->daddr),
 					icmphdr->code, (size_t)buff_len - (iphdr->ihl * 4));
 				break;
@@ -155,18 +155,18 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_print
 
 			break;
 		case ICMP_ECHO:
-			printf("%s: ICMP echo request, id %u, seq %u, length %zd\n",
+			printf("%s: ICMP echo request, id %hu, seq %hu, length %zu\n",
 				inet_ntoa(*(struct in_addr *)&iphdr->daddr),
 				ntohs(icmphdr->un.echo.id), ntohs(icmphdr->un.echo.sequence),
 				(size_t)buff_len - (iphdr->ihl * 4));
 			break;
 		case ICMP_TIME_EXCEEDED:
-			printf("%s: ICMP time exceeded in-transit, length %zd\n",
+			printf("%s: ICMP time exceeded in-transit, length %zu\n",
 				inet_ntoa(*(struct in_addr *)&iphdr->daddr),
 				(size_t)buff_len - (iphdr->ihl * 4));
 			break;
 		default:
-			printf("%s: ICMP type %u, length %zd\n",
+			printf("%s: ICMP type %hhu, length %zu\n",
 				inet_ntoa(*(struct in_addr *)&iphdr->daddr), icmphdr->type,
 				(size_t)buff_len - (iphdr->ihl * 4));
 			break;
@@ -178,7 +178,7 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_print
 
 		tcphdr = (struct tcphdr *)(packet_buff + (iphdr->ihl * 4));
 		printf("IP %s.%i > ", inet_ntoa(*(struct in_addr *)&iphdr->saddr), ntohs(tcphdr->source));
-		printf("%s.%i: TCP, flags [%c%c%c%c%c%c], length %zd\n",
+		printf("%s.%i: TCP, flags [%c%c%c%c%c%c], length %zu\n",
 			inet_ntoa(*(struct in_addr *)&iphdr->daddr), ntohs(tcphdr->dest),
 			(tcphdr->fin ? 'F' : '.'), (tcphdr->syn ? 'S' : '.'),
 			(tcphdr->rst ? 'R' : '.'), (tcphdr->psh ? 'P' : '.'),
@@ -194,18 +194,18 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_print
 		switch (ntohs(udphdr->dest)) {
 		case 67:
                         LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4) - sizeof(struct udphdr), (size_t) 44, "DHCP");
-			printf("%s.67: BOOTP/DHCP, Request from %s, length %zd\n",
+			printf("%s.67: BOOTP/DHCP, Request from %s, length %zu\n",
 				inet_ntoa(*(struct in_addr *)&iphdr->daddr),
 				ether_ntoa_long((struct ether_addr *)(((char *)udphdr) + sizeof(struct udphdr) + 28)),
 				(size_t)buff_len - (iphdr->ihl * 4) - sizeof(struct udphdr));
 			break;
 		case 68:
-			printf("%s.68: BOOTP/DHCP, Reply, length %zd\n",
+			printf("%s.68: BOOTP/DHCP, Reply, length %zu\n",
 				inet_ntoa(*(struct in_addr *)&iphdr->daddr),
 				(size_t)buff_len - (iphdr->ihl * 4) - sizeof(struct udphdr));
 			break;
 		default:
-			printf("%s.%i: UDP, length %zd\n",
+			printf("%s.%i: UDP, length %zu\n",
 				inet_ntoa(*(struct in_addr *)&iphdr->daddr), ntohs(udphdr->dest),
 				(size_t)buff_len - (iphdr->ihl * 4) - sizeof(struct udphdr));
 			break;
@@ -236,7 +236,7 @@ static void dump_batman_ogm(unsigned char *packet_buff, ssize_t buff_len, int re
 	printf("BAT %s: ",
 	       get_name_by_macaddr((struct ether_addr *)batman_packet->orig, read_opt));
 
-	printf("OGM via neigh %s, seqno %d, tq %3d, ttl %2d, v %d, flags [%c%c], length %zd\n",
+	printf("OGM via neigh %s, seqno %d, tq %3d, ttl %2d, v %d, flags [%c%c], length %zu\n",
 	        get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt),
 	        ntohs(batman_packet->seqno), batman_packet->tq,
 	        batman_packet->ttl, batman_packet->version,
@@ -264,25 +264,25 @@ static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int r
 
 	switch (icmp_packet->msg_type) {
 	case ECHO_REPLY:
-		printf("%s: ICMP echo reply, id %u, seq %u, ttl %2d, v %d, length %zd\n",
+		printf("%s: ICMP echo reply, id %hhu, seq %hu, ttl %2d, v %d, length %zu\n",
 			name, icmp_packet->uid, ntohs(icmp_packet->seqno),
 			icmp_packet->ttl, icmp_packet->version,
 			(size_t)buff_len - sizeof(struct ether_header));
 		break;
 	case ECHO_REQUEST:
-		printf("%s: ICMP echo request, id %u, seq %u, ttl %2d, v %d, length %zd\n",
+		printf("%s: ICMP echo request, id %hhu, seq %hu, ttl %2d, v %d, length %zu\n",
 			name, icmp_packet->uid, ntohs(icmp_packet->seqno),
 			icmp_packet->ttl, icmp_packet->version,
 			(size_t)buff_len - sizeof(struct ether_header));
 		break;
 	case TTL_EXCEEDED:
-		printf("%s: ICMP time exceeded in-transit, id %u, seq %u, ttl %2d, v %d, length %zd\n",
+		printf("%s: ICMP time exceeded in-transit, id %hhu, seq %hu, ttl %2d, v %d, length %zu\n",
 			name, icmp_packet->uid, ntohs(icmp_packet->seqno),
 			icmp_packet->ttl, icmp_packet->version,
 			(size_t)buff_len - sizeof(struct ether_header));
 		break;
 	default:
-		printf("%s: ICMP type %u, length %zd\n",
+		printf("%s: ICMP type %hhu, length %zu\n",
 			name, icmp_packet->msg_type, (size_t)buff_len - sizeof(struct ether_header));
 		break;
 	}
@@ -305,7 +305,7 @@ static void dump_batman_ucast(unsigned char *packet_buff, ssize_t buff_len, int
 	printf("BAT %s > ",
 	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt));
 
-	printf("%s: UCAST, ttl %u, ",
+	printf("%s: UCAST, ttl %hu, ",
 	       get_name_by_macaddr((struct ether_addr *)unicast_packet->dest, read_opt),
 	       unicast_packet->ttl);
 
@@ -321,7 +321,7 @@ static void dump_batman_ucast(unsigned char *packet_buff, ssize_t buff_len, int
 			buff_len - (2 * sizeof(struct ether_header)) - sizeof(struct unicast_packet), 1);
 		break;
 	default:
-		printf(" unknown payload ether type: %u\n", ntohs(ether_header->ether_type));
+		printf(" unknown payload ether type: %hu\n", ntohs(ether_header->ether_type));
 		break;
 	}
 }
@@ -343,7 +343,7 @@ static void dump_batman_bcast(unsigned char *packet_buff, ssize_t buff_len, int
 	printf("BAT %s: ",
 	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt));
 
-	printf("BCAST, orig %s, seqno %u, ",
+	printf("BCAST, orig %s, seqno %hu, ",
 	       get_name_by_macaddr((struct ether_addr *)bcast_packet->orig, read_opt),
 	       ntohs(bcast_packet->seqno));
 
@@ -359,7 +359,7 @@ static void dump_batman_bcast(unsigned char *packet_buff, ssize_t buff_len, int
 			buff_len - (2 * sizeof(struct ether_header)) - sizeof(struct bcast_packet), 1);
 		break;
 	default:
-		printf(" unknown payload ether type: %u\n", ntohs(ether_header->ether_type));
+		printf(" unknown payload ether type: %hu\n", ntohs(ether_header->ether_type));
 		break;
 	}
 }
@@ -492,7 +492,7 @@ int tcpdump(int argc, char **argv)
 			}
 
 			if ((size_t)read_len < sizeof(struct ether_header)) {
-				printf("Warning - dropping received packet as it is smaller than expected (%zd): %zd\n",
+				printf("Warning - dropping received packet as it is smaller than expected (%zu): %zd\n",
 					sizeof(struct ether_header), read_len);
 				continue;
 			}
@@ -538,7 +538,7 @@ int tcpdump(int argc, char **argv)
 
 				break;
 			default:
-				printf("Warning - packet contains unknown ether type: %u\n", ether_type);
+				printf("Warning - packet contains unknown ether type: %hu\n", ether_type);
 				break;
 			}
 
diff --git a/batctl/traceroute.c b/batctl/traceroute.c
index f69586e..f05c306 100644
--- a/batctl/traceroute.c
+++ b/batctl/traceroute.c
@@ -114,7 +114,7 @@ int traceroute(int argc, char **argv)
 	icmp_packet_out.msg_type = ECHO_REQUEST;
 	icmp_packet_out.seqno = 0;
 
-	printf("traceroute to %s (%s), %d hops max, %zd byte packets\n",
+	printf("traceroute to %s (%s), %d hops max, %zu byte packets\n",
 		dst_string, mac_string, TTL_MAX, sizeof(icmp_packet_out));
 
 	for (icmp_packet_out.ttl = 1; !dst_reached && icmp_packet_out.ttl < TTL_MAX; icmp_packet_out.ttl++) {
@@ -139,7 +139,7 @@ int traceroute(int argc, char **argv)
 
 			if (res <= 0) {
 				if (i == 0)
-					printf("%2u: ", icmp_packet_out.ttl);
+					printf("%2hu: ", icmp_packet_out.ttl);
 
 				printf(" * ");
 				fflush(stdout);
@@ -154,7 +154,7 @@ int traceroute(int argc, char **argv)
 			}
 
 			if ((size_t)read_len < sizeof(icmp_packet_in)) {
-				printf("Warning - dropping received packet as it is smaller than expected (%zd): %zd\n",
+				printf("Warning - dropping received packet as it is smaller than expected (%zu): %zd\n",
 					sizeof(icmp_packet_in), read_len);
 				continue;
 			}
@@ -176,10 +176,10 @@ int traceroute(int argc, char **argv)
 					bat_host = bat_hosts_find_by_mac((char *)&icmp_packet_in.orig);
 
 				if (!bat_host)
-					printf("%2u: %s %.3f ms",
+					printf("%2hu: %s %.3f ms",
 						icmp_packet_out.ttl, return_mac, time_delta);
 				else
-					printf("%2u: %s (%s) %.3f ms",
+					printf("%2hu: %s (%s) %.3f ms",
 						icmp_packet_out.ttl, bat_host->name, return_mac, time_delta);
 
 				if (icmp_packet_in.msg_type == ECHO_REPLY)
-- 
1.6.5.2

