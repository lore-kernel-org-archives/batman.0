Return-Path: <marco.dallato@gmail.com>
From: Marco Dalla Torre <marco.dallato@gmail.com>
Date: Tue, 17 Sep 2013 14:08:14 +0200
Message-Id: <1379419694-12758-1-git-send-email-marco.dallato@gmail.com>
Subject: [B.A.T.M.A.N.] [RFCv2] batctl tcpdump: add IPv6 support to tcpdump
	parser
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

Extends 'tcpdump' functionality in 'batctl' to parse and report IPv6
communications. 'batctl' now recognizes TCP, UDP packets and the most
common ICMPv6 packet types:
	-ECHO request and ECHO reply
	-unreachable destination and subcases
	-time exceeded
	-neighbor discovery protocol 'solicit' and 'advert'

TCP and UDP parsing code has been moved from the IPv4 specific
codepath to separate functions in order to allow reuse regardless
the underlying protocol.

Signed-off-by: Marco Dalla Torre <marco.dallato@gmail.com>
---
CHANGES FROM v1
-Fixed code formatting style
 tcpdump.c | 308 ++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 250 insertions(+), 58 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 7e0987b..3904667 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -32,9 +32,11 @@
 #include <net/if_arp.h>
 #include <netinet/in.h>
 #include <netinet/ip.h>
+#include <netinet/ip6.h>
 #include <netinet/tcp.h>
 #include <netinet/udp.h>
 #include <netinet/ip_icmp.h>
+#include <netinet/icmp6.h>
 #include <netinet/if_ether.h>
 
 #include "main.h"
@@ -47,6 +49,8 @@
 #define ETH_P_BATMAN	0x4305
 #endif /* ETH_P_BATMAN */
 
+#define IPV6_MIN_MTU	1280
+
 #define LEN_CHECK(buff_len, check_len, desc) \
 if ((size_t)(buff_len) < (check_len)) { \
 	fprintf(stderr, "Warning - dropping received %s packet as it is smaller than expected (%zu): %zu\n", \
@@ -188,11 +192,210 @@ static void dump_arp(unsigned char *packet_buff, ssize_t buff_len,
 	}
 }
 
+static void parse_tcp(
+	unsigned char *packet_buff,
+	ssize_t buff_len,
+	size_t header_len,
+	char *src_addr,
+	char *dst_addr)
+{
+	LEN_CHECK((size_t)buff_len - header_len,
+		sizeof(struct tcphdr), "TCP");
+	struct tcphdr *tcphdr;
+
+	tcphdr = (struct tcphdr *)(packet_buff + header_len);
+	printf("IP %s.%i > ", src_addr, ntohs(tcphdr->source));
+	printf("%s.%i: TCP, flags [%c%c%c%c%c%c], length %zu\n",
+		dst_addr, ntohs(tcphdr->dest),
+		(tcphdr->fin ? 'F' : '.'), (tcphdr->syn ? 'S' : '.'),
+		(tcphdr->rst ? 'R' : '.'), (tcphdr->psh ? 'P' : '.'),
+		(tcphdr->ack ? 'A' : '.'), (tcphdr->urg ? 'U' : '.'),
+		(size_t)buff_len - header_len - sizeof(struct tcphdr));
+}
+
+static void parse_udp(
+	unsigned char *packet_buff,
+	ssize_t buff_len,
+	size_t header_len,
+	char *src_addr,
+	char *dst_addr)
+{
+	LEN_CHECK((size_t)buff_len - header_len, sizeof(struct udphdr), "UDP");
+	struct udphdr *udphdr;
+
+	udphdr = (struct udphdr *)(packet_buff + header_len);
+	printf("IP %s.%i > ",
+		src_addr,
+		ntohs(udphdr->source));
+
+	switch (ntohs(udphdr->dest)) {
+	case 67:
+		LEN_CHECK(
+			(size_t)buff_len - header_len - sizeof(struct udphdr),
+			(size_t) 44,
+			"DHCP");
+		printf("%s.67: BOOTP/DHCP, Request from %s, length %zu\n",
+			dst_addr,
+			ether_ntoa_long(
+				(struct ether_addr *)(((char *)udphdr)
+					+ sizeof(struct udphdr) + 28)),
+			(size_t)buff_len - header_len - sizeof(struct udphdr));
+		break;
+	case 68:
+		printf("%s.68: BOOTP/DHCP, Reply, length %zu\n",
+			dst_addr,
+			(size_t)buff_len - header_len - sizeof(struct udphdr));
+		break;
+	default:
+		printf("%s.%i: UDP, length %zu\n",
+			dst_addr,
+			ntohs(udphdr->dest),
+			(size_t)buff_len - header_len - sizeof(struct udphdr));
+		break;
+	}
+}
+
+static void dump_ipv6(
+	unsigned char *packet_buff,
+	ssize_t buff_len,
+	int time_printed)
+{
+	struct ip6_hdr *iphdr, *tmp_iphdr;
+	struct udphdr *tmp_udphdr;
+	struct icmp6_hdr *icmphdr;
+
+	char ip_saddr[40];
+	char ip_daddr[40];
+	char nd_na_target[40];
+	char nd_ipv6_addr[40];
+	struct nd_neighbor_solicit *nd_neigh_sol;
+	struct nd_neighbor_advert *nd_advert;
+
+	iphdr = (struct ip6_hdr *)packet_buff;
+	LEN_CHECK((size_t)buff_len, (size_t)(sizeof(struct ip6_hdr)), "IPv6");
+	
+	if (!time_printed)
+		print_time();
+
+	switch (iphdr->ip6_nxt) {
+	case IPPROTO_ICMPV6:
+		LEN_CHECK(
+			(size_t)buff_len - (size_t)(sizeof(struct ip6_hdr)),
+			sizeof(struct icmp6_hdr),
+			"ICMPv6");
+		icmphdr = (struct icmp6_hdr *)(packet_buff +
+					       sizeof(struct ip6_hdr));
+		inet_ntop(AF_INET6, &(iphdr->ip6_src), nd_ipv6_addr, 40);
+		printf("IPv6 %s > ", nd_ipv6_addr);
+		switch (icmphdr->icmp6_type) {
+		case ICMP6_DST_UNREACH:
+			if ((size_t)(buff_len) < IPV6_MIN_MTU) {
+				fprintf(stderr,
+					"Warning - dropping received 'ICMPv6 destination unreached' packet as it is bigger than maximum allowed size (%u): %zu\n",
+					IPV6_MIN_MTU, (size_t)(buff_len));
+				return;
+			}
+
+			switch (icmphdr->icmp6_code) {
+			case ICMP6_DST_UNREACH_NOPORT:
+				tmp_iphdr = (struct ip6_hdr *)(((char *)icmphdr)
+					    + sizeof(struct icmp6_hdr));
+
+				tmp_udphdr = (struct udphdr *)
+					     ((char *)tmp_iphdr)
+					     + sizeof(struct ip6_hdr);
+
+				inet_ntop(AF_INET6, &(iphdr->ip6_dst),
+					  nd_ipv6_addr, 40);
+				printf("%s: ICMP ", nd_ipv6_addr);
+				inet_ntop(AF_INET6, &(tmp_iphdr->ip6_dst),
+					  nd_ipv6_addr, 40);
+				printf("%s udp port %hu unreachable, length %zu\n",
+				       nd_ipv6_addr, ntohs(tmp_udphdr->dest),
+				       (size_t)buff_len -
+				       sizeof(struct ip6_hdr));
+				break;
+			default:
+				inet_ntop(AF_INET6, &(iphdr->ip6_dst),
+					  nd_ipv6_addr, 40);
+				printf("%s: ICMP unreachable %hhu, length %zu\n",
+					nd_ipv6_addr, icmphdr->icmp6_code,
+					(size_t)buff_len -
+					sizeof(struct icmp6_hdr));
+			}
+			break;
+		case ICMP6_ECHO_REQUEST:
+			inet_ntop(AF_INET6, &(iphdr->ip6_dst), nd_ipv6_addr,
+				  40);
+			printf("%s: ICMPv6 echo request, id: %d, seq: %d, length: %hu\n",
+			       nd_ipv6_addr, icmphdr->icmp6_id,
+			       icmphdr->icmp6_seq, iphdr->ip6_plen);
+			break;
+		case ICMP6_ECHO_REPLY:
+			inet_ntop(AF_INET6, &(iphdr->ip6_dst),
+				  nd_ipv6_addr, 40);
+			printf("%s: ICMPv6 echo reply, id: %d, seq: %d, length: %hu\n",
+			       nd_ipv6_addr, icmphdr->icmp6_id,
+			       icmphdr->icmp6_seq, iphdr->ip6_plen);
+			break;
+		case ICMP6_TIME_EXCEEDED:
+			inet_ntop(AF_INET6, &(iphdr->ip6_dst), nd_ipv6_addr,
+				  40);
+			printf("%s: ICMPv6 time exceeded in-transit, length %zu\n",
+			       nd_ipv6_addr,
+			       (size_t)buff_len - sizeof(struct icmp6_hdr));
+			break;
+		case ND_NEIGHBOR_SOLICIT:
+			nd_neigh_sol = (struct nd_neighbor_solicit *)icmphdr;
+
+			inet_ntop(AF_INET6, &(nd_neigh_sol->nd_ns_target),
+				  nd_ipv6_addr, 40);
+			printf("NEIGHBOR SOLICITATION, Request who-has %s",
+			       nd_ipv6_addr);
+
+			inet_ntop(AF_INET6, &(iphdr->ip6_src), nd_ipv6_addr,
+				  40);
+			printf(" tell %s, length %zd\n", nd_ipv6_addr,
+			       buff_len);
+			break;
+		case ND_NEIGHBOR_ADVERT:
+			nd_advert = (struct nd_neighbor_advert *)icmphdr;
+			inet_ntop(AF_INET6, &(nd_advert->nd_na_target),
+				  nd_na_target, 40);
+			inet_ntop(AF_INET6, &(iphdr->ip6_dst), nd_ipv6_addr,
+				  40);
+			printf("NEIGHBOR ADVERTISEMENT, Reply to %s for target %s, length %zd\n",
+			       nd_na_target, nd_ipv6_addr, buff_len);
+			break;
+		default:
+			inet_ntop(AF_INET6, &(iphdr->ip6_dst), nd_ipv6_addr,
+				  40);
+			printf("%s: ICMPv6 type %hhu, length %zu\n",
+			       nd_ipv6_addr, icmphdr->icmp6_type,
+			       (size_t)buff_len - sizeof(struct icmp6_hdr));
+		}
+		break;
+	case IPPROTO_TCP:
+		inet_ntop(AF_INET6, &(iphdr->ip6_src), ip_saddr, 40);
+		inet_ntop(AF_INET6, &(iphdr->ip6_dst), ip_daddr, 40);
+		parse_tcp(packet_buff, buff_len, sizeof(struct ip6_hdr),
+			  ip_saddr, ip_daddr);
+		break;
+	case IPPROTO_UDP:
+		inet_ntop(AF_INET6, &(iphdr->ip6_src), ip_saddr, 40);
+		inet_ntop(AF_INET6, &(iphdr->ip6_dst), ip_daddr, 40);
+		parse_udp(packet_buff, buff_len, sizeof(struct ip6_hdr),
+			  ip_saddr, ip_daddr);
+		break;
+	default:
+		printf("IPv6 unknown protocol: %i\n", iphdr->ip6_nxt);
+	}
+}
+
 static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_printed)
 {
 	struct iphdr *iphdr, *tmp_iphdr;
-	struct tcphdr *tcphdr;
-	struct udphdr *udphdr, *tmp_udphdr;
+	struct udphdr *tmp_udphdr;
 	struct icmphdr *icmphdr;
 
 	iphdr = (struct iphdr *)packet_buff;
@@ -203,7 +406,8 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_print
 
 	switch (iphdr->protocol) {
 	case IPPROTO_ICMP:
-		LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4), sizeof(struct icmphdr), "ICMP");
+		LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4),
+			  sizeof(struct icmphdr), "ICMP");
 
 		icmphdr = (struct icmphdr *)(packet_buff + (iphdr->ihl * 4));
 		printf("IP %s > ", inet_ntoa(*(struct in_addr *)&iphdr->saddr));
@@ -212,91 +416,75 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_print
 		case ICMP_ECHOREPLY:
 			printf("%s: ICMP echo reply, id %hu, seq %hu, length %zu\n",
 				inet_ntoa(*(struct in_addr *)&iphdr->daddr),
-				ntohs(icmphdr->un.echo.id), ntohs(icmphdr->un.echo.sequence),
+				ntohs(icmphdr->un.echo.id),
+				ntohs(icmphdr->un.echo.sequence),
 				(size_t)buff_len - (iphdr->ihl * 4));
 			break;
 		case ICMP_DEST_UNREACH:
-			LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4) - sizeof(struct icmphdr),
-				sizeof(struct iphdr) + 8, "ICMP DEST_UNREACH");
+			LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4) -
+				  sizeof(struct icmphdr),
+				  sizeof(struct iphdr) + 8,
+				  "ICMP DEST_UNREACH");
 
 			switch (icmphdr->code) {
 			case ICMP_PORT_UNREACH:
-				tmp_iphdr = (struct iphdr *)(((char *)icmphdr) + sizeof(struct icmphdr));
-				tmp_udphdr = (struct udphdr *)(((char *)tmp_iphdr) + (tmp_iphdr->ihl * 4));
+				tmp_iphdr = (struct iphdr *)(((char *)icmphdr) +
+					     sizeof(struct icmphdr));
+				tmp_udphdr = (struct udphdr *)
+				             (((char *)tmp_iphdr) +
+				             (tmp_iphdr->ihl * 4));
 
-				printf("%s: ICMP ", inet_ntoa(*(struct in_addr *)&iphdr->daddr));
+				printf("%s: ICMP ",
+				       inet_ntoa(*(struct in_addr *)
+				       	         &iphdr->daddr));
 				printf("%s udp port %hu unreachable, length %zu\n",
-					inet_ntoa(*(struct in_addr *)&tmp_iphdr->daddr),
-					ntohs(tmp_udphdr->dest), (size_t)buff_len - (iphdr->ihl * 4));
+				       inet_ntoa(*(struct in_addr *)
+				       	         &tmp_iphdr->daddr),
+				       ntohs(tmp_udphdr->dest),
+				       (size_t)buff_len - (iphdr->ihl * 4));
 				break;
 			default:
 				printf("%s: ICMP unreachable %hhu, length %zu\n",
-					inet_ntoa(*(struct in_addr *)&iphdr->daddr),
-					icmphdr->code, (size_t)buff_len - (iphdr->ihl * 4));
+				       inet_ntoa(*(struct in_addr *)
+				       	         &iphdr->daddr),
+				       icmphdr->code,
+				       (size_t)buff_len - (iphdr->ihl * 4));
 				break;
 			}
 
 			break;
 		case ICMP_ECHO:
 			printf("%s: ICMP echo request, id %hu, seq %hu, length %zu\n",
-				inet_ntoa(*(struct in_addr *)&iphdr->daddr),
-				ntohs(icmphdr->un.echo.id), ntohs(icmphdr->un.echo.sequence),
-				(size_t)buff_len - (iphdr->ihl * 4));
+			       inet_ntoa(*(struct in_addr *)&iphdr->daddr),
+			       ntohs(icmphdr->un.echo.id),
+			       ntohs(icmphdr->un.echo.sequence),
+			       (size_t)buff_len - (iphdr->ihl * 4));
 			break;
 		case ICMP_TIME_EXCEEDED:
 			printf("%s: ICMP time exceeded in-transit, length %zu\n",
-				inet_ntoa(*(struct in_addr *)&iphdr->daddr),
-				(size_t)buff_len - (iphdr->ihl * 4));
+			       inet_ntoa(*(struct in_addr *)&iphdr->daddr),
+			       (size_t)buff_len - (iphdr->ihl * 4));
 			break;
 		default:
 			printf("%s: ICMP type %hhu, length %zu\n",
-				inet_ntoa(*(struct in_addr *)&iphdr->daddr), icmphdr->type,
-				(size_t)buff_len - (iphdr->ihl * 4));
+			       inet_ntoa(*(struct in_addr *)&iphdr->daddr),
+			       icmphdr->type,
+			       (size_t)buff_len - (iphdr->ihl * 4));
 			break;
 		}
 
 		break;
 	case IPPROTO_TCP:
-		LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4), sizeof(struct tcphdr), "TCP");
-
-		tcphdr = (struct tcphdr *)(packet_buff + (iphdr->ihl * 4));
-		printf("IP %s.%i > ", inet_ntoa(*(struct in_addr *)&iphdr->saddr), ntohs(tcphdr->source));
-		printf("%s.%i: TCP, flags [%c%c%c%c%c%c], length %zu\n",
-			inet_ntoa(*(struct in_addr *)&iphdr->daddr), ntohs(tcphdr->dest),
-			(tcphdr->fin ? 'F' : '.'), (tcphdr->syn ? 'S' : '.'),
-			(tcphdr->rst ? 'R' : '.'), (tcphdr->psh ? 'P' : '.'),
-			(tcphdr->ack ? 'A' : '.'), (tcphdr->urg ? 'U' : '.'),
-			(size_t)buff_len - (iphdr->ihl * 4) - sizeof(struct tcphdr));
+		parse_tcp(
+			packet_buff, buff_len, iphdr->ihl * 4,
+			inet_ntoa(*(struct in_addr *)&iphdr->saddr),
+			inet_ntoa(*(struct in_addr *)&iphdr->daddr));
 		break;
 	case IPPROTO_UDP:
-		LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4), sizeof(struct udphdr), "UDP");
-
-		udphdr = (struct udphdr *)(packet_buff + (iphdr->ihl * 4));
-		printf("IP %s.%i > ", inet_ntoa(*(struct in_addr *)&iphdr->saddr), ntohs(udphdr->source));
-
-		switch (ntohs(udphdr->dest)) {
-		case 67:
-                        LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4) - sizeof(struct udphdr), (size_t) 44, "DHCP");
-			printf("%s.67: BOOTP/DHCP, Request from %s, length %zu\n",
-				inet_ntoa(*(struct in_addr *)&iphdr->daddr),
-				ether_ntoa_long((struct ether_addr *)(((char *)udphdr) + sizeof(struct udphdr) + 28)),
-				(size_t)buff_len - (iphdr->ihl * 4) - sizeof(struct udphdr));
-			break;
-		case 68:
-			printf("%s.68: BOOTP/DHCP, Reply, length %zu\n",
-				inet_ntoa(*(struct in_addr *)&iphdr->daddr),
-				(size_t)buff_len - (iphdr->ihl * 4) - sizeof(struct udphdr));
-			break;
-		default:
-			printf("%s.%i: UDP, length %zu\n",
-				inet_ntoa(*(struct in_addr *)&iphdr->daddr), ntohs(udphdr->dest),
-				(size_t)buff_len - (iphdr->ihl * 4) - sizeof(struct udphdr));
-			break;
-		}
-
-		break;
-	case IPPROTO_IPV6:
-		printf("IP6: not implemented yet\n");
+		parse_udp(
+			packet_buff, buff_len, iphdr->ihl * 4,
+			inet_ntoa(*(struct in_addr *)&iphdr->saddr),
+			inet_ntoa(*(struct in_addr *)&iphdr->daddr));
 		break;
 	default:
 		printf("IP unknown protocol: %i\n", iphdr->protocol);
@@ -497,6 +685,10 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 		if ((dump_level & DUMP_TYPE_NONBAT) || (time_printed))
 			dump_ip(packet_buff + ETH_HLEN, buff_len - ETH_HLEN, time_printed);
 		break;
+	case ETH_P_IPV6:
+		if ((dump_level & DUMP_TYPE_NONBAT) || (time_printed))
+			dump_ipv6(packet_buff + ETH_HLEN, buff_len - ETH_HLEN, time_printed);
+		break;
 	case ETH_P_8021Q:
 		if ((dump_level & DUMP_TYPE_NONBAT) || (time_printed))
 			dump_vlan(packet_buff, buff_len, read_opt, time_printed);
-- 
1.8.3.2

