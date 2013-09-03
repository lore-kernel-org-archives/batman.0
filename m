Return-Path: <marco.dallato@gmail.com>
From: Marco Dalla Torre <marco.dallato@gmail.com>
Date: Tue,  3 Sep 2013 14:58:38 +0200
Message-Id: <1378213118-4084-1-git-send-email-marco.dallato@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH][RFC] batctl: add IPv6 support to tcpdump
	parsing capabilities
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
 tcpdump.c | 270 ++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 230 insertions(+), 40 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 7e0987b..6dc49ac 100644
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
@@ -188,11 +192,219 @@ static void dump_arp(unsigned char *packet_buff, ssize_t buff_len,
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
+
+		icmphdr = (struct icmp6_hdr *)(packet_buff + sizeof(struct ip6_hdr));
+		char tmp_ipv6_addr[40];
+		inet_ntop(AF_INET6, &(iphdr->ip6_src), tmp_ipv6_addr, 40);
+		printf("IPv6 %s > ", tmp_ipv6_addr);
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
+					+ sizeof(struct icmp6_hdr));
+
+				tmp_udphdr = (struct udphdr *)((char *)tmp_iphdr)
+					+ sizeof(struct ip6_hdr);
+
+				inet_ntop(AF_INET6, &(iphdr->ip6_dst), tmp_ipv6_addr, 40);
+				printf("%s: ICMP ", tmp_ipv6_addr);
+				inet_ntop(AF_INET6, &(tmp_iphdr->ip6_dst), tmp_ipv6_addr, 40);
+				printf("%s udp port %hu unreachable, length %zu\n",
+					tmp_ipv6_addr,
+					ntohs(tmp_udphdr->dest),
+					(size_t)buff_len - sizeof(struct ip6_hdr));
+				break;
+			default:
+				inet_ntop(AF_INET6, &(iphdr->ip6_dst), tmp_ipv6_addr, 40);
+				printf("%s: ICMP unreachable %hhu, length %zu\n",
+					tmp_ipv6_addr,
+					icmphdr->icmp6_code,
+					(size_t)buff_len - sizeof(struct icmp6_hdr));
+			}
+			break;
+		case ICMP6_ECHO_REQUEST:
+			inet_ntop(AF_INET6, &(iphdr->ip6_dst), tmp_ipv6_addr, 40);
+			printf("%s: ICMPv6 echo request, id: %d, seq: %d, length: %hu\n",
+				tmp_ipv6_addr,
+				icmphdr->icmp6_id,
+				icmphdr->icmp6_seq,
+				iphdr->ip6_plen);
+			break;
+		case ICMP6_ECHO_REPLY:
+			inet_ntop(AF_INET6, &(iphdr->ip6_dst), tmp_ipv6_addr, 40);
+			printf("%s: ICMPv6 echo reply, id: %d, seq: %d, length: %hu\n",
+				tmp_ipv6_addr,
+				icmphdr->icmp6_id,
+				icmphdr->icmp6_seq,
+				iphdr->ip6_plen);
+			break;
+		case ICMP6_TIME_EXCEEDED:
+			inet_ntop(AF_INET6, &(iphdr->ip6_dst), tmp_ipv6_addr, 40);
+			printf("%s: ICMPv6 time exceeded in-transit, length %zu\n",
+				tmp_ipv6_addr,
+				(size_t)buff_len - sizeof(struct icmp6_hdr));
+			break;
+		case ND_NEIGHBOR_SOLICIT:
+			;
+			struct nd_neighbor_solicit *tmp_ns =
+				(struct nd_neighbor_solicit *)icmphdr;
+
+			inet_ntop(AF_INET6, &(tmp_ns->nd_ns_target), tmp_ipv6_addr, 40);
+			printf("NEIGHBOR SOLICITATION, Request who-has %s", tmp_ipv6_addr);
+
+			inet_ntop(AF_INET6, &(iphdr->ip6_src), tmp_ipv6_addr, 40);
+			printf(" tell %s, length %zd\n",
+				tmp_ipv6_addr,
+				buff_len);
+			break;
+		case ND_NEIGHBOR_ADVERT:
+			;
+			struct nd_neighbor_advert *tmp_ns2 =
+				(struct nd_neighbor_advert *)icmphdr;
+			char tmp_na_target[40];
+
+			inet_ntop(AF_INET6, &(tmp_ns2->nd_na_target), tmp_na_target, 40);
+			inet_ntop(AF_INET6, &(iphdr->ip6_dst), tmp_ipv6_addr, 40);
+			printf("NEIGHBOR ADVERTISEMENT, Reply to %s for target %s, length %zd\n",
+				tmp_na_target,
+				tmp_ipv6_addr,
+				buff_len);
+			break;
+		default:
+			inet_ntop(AF_INET6, &(iphdr->ip6_dst), tmp_ipv6_addr, 40);
+			printf("%s: ICMPv6 type %hhu, length %zu\n",
+				tmp_ipv6_addr,
+				icmphdr->icmp6_type,
+				(size_t)buff_len - sizeof(struct icmp6_hdr));
+		}
+		break;
+	case IPPROTO_TCP:
+		;
+		char tmp_saddr_t[40];
+		char tmp_daddr_t[40];
+		inet_ntop(AF_INET6, &(iphdr->ip6_src), tmp_saddr_t, 40);
+		inet_ntop(AF_INET6, &(iphdr->ip6_dst), tmp_daddr_t, 40);
+		parse_tcp(
+			packet_buff,
+			buff_len,
+			sizeof(struct ip6_hdr),
+			tmp_saddr_t,
+			tmp_daddr_t);
+		break;
+	case IPPROTO_UDP:
+		;
+		char tmp_saddr_u[40];
+		char tmp_daddr_u[40];
+		inet_ntop(AF_INET6, &(iphdr->ip6_src), tmp_saddr_u, 40);
+		inet_ntop(AF_INET6, &(iphdr->ip6_dst), tmp_daddr_u, 40);
+		parse_udp(
+			packet_buff,
+			buff_len,
+			sizeof(struct ip6_hdr),
+			tmp_saddr_u,
+			tmp_daddr_u);
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
@@ -257,46 +469,20 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_print
 
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
+			packet_buff,
+			buff_len,
+			iphdr->ihl * 4,
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
+			packet_buff,
+			buff_len,
+			iphdr->ihl * 4,
+			inet_ntoa(*(struct in_addr *)&iphdr->saddr),
+			inet_ntoa(*(struct in_addr *)&iphdr->daddr));
 		break;
 	default:
 		printf("IP unknown protocol: %i\n", iphdr->protocol);
@@ -497,6 +683,10 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
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

