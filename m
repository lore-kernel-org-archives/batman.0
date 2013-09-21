Return-Path: <marco.dallato@gmail.com>
From: Marco Dalla Torre <marco.dallato@gmail.com>
Date: Sat, 21 Sep 2013 13:39:12 +0200
Message-Id: <1379763552-17590-1-git-send-email-marco.dallato@gmail.com>
Subject: [B.A.T.M.A.N.] [RFCv3] [batctl] add IPv6 support to tcpdump parser
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
This patch additionaly fixes the erratic report of TCP header
length, which was considered fixed size. This is actually not the case
given the variable length (or no presence at all) of the options field.

Signed-off-by: Marco Dalla Torre <marco.dallato@gmail.com>
---
CHANGES FROM v2
-code style corrections
-changed function names from parse_tcp, parse_udp to dump_tcp, dump_udp
-sticking to "tcpdump" output style whenever possible (that is without
 having to completely alter the code already in place before this patch)
 tcpdump.c | 229 ++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 187 insertions(+), 42 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 7e0987b..9432ecb 100644
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
@@ -188,12 +192,181 @@ static void dump_arp(unsigned char *packet_buff, ssize_t buff_len,
 	}
 }
 
-static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_printed)
+static void dump_tcp(const char ip_string[], unsigned char *packet_buff,
+		     ssize_t buff_len, size_t ip6_header_len, char *src_addr,
+		     char *dst_addr)
 {
-	struct iphdr *iphdr, *tmp_iphdr;
+	uint16_t tcp_header_len;
 	struct tcphdr *tcphdr;
-	struct udphdr *udphdr, *tmp_udphdr;
+
+	LEN_CHECK((size_t)buff_len - ip6_header_len,
+		  sizeof(struct tcphdr), "TCP");
+	tcphdr = (struct tcphdr *)(packet_buff + ip6_header_len);
+	tcp_header_len = tcphdr->doff * 4;
+	printf("%s %s.%i > ", ip_string, src_addr, ntohs(tcphdr->source));
+	printf("%s.%i: TCP, Flags [%c%c%c%c%c%c], length %zu\n",
+		dst_addr, ntohs(tcphdr->dest),
+		(tcphdr->fin ? 'F' : '.'), (tcphdr->syn ? 'S' : '.'),
+		(tcphdr->rst ? 'R' : '.'), (tcphdr->psh ? 'P' : '.'),
+		(tcphdr->ack ? 'A' : '.'), (tcphdr->urg ? 'U' : '.'),
+		(size_t)buff_len - ip6_header_len - tcp_header_len);
+}
+
+static void dump_udp(const char ip_string[], unsigned char *packet_buff,
+		     ssize_t buff_len, size_t ip6_header_len, char *src_addr,
+		     char *dst_addr)
+{
+	struct udphdr *udphdr;
+
+	LEN_CHECK((size_t)buff_len - ip6_header_len, sizeof(struct udphdr),
+		  "UDP");
+	udphdr = (struct udphdr *)(packet_buff + ip6_header_len);
+	printf("%s %s.%i > ", ip_string, src_addr, ntohs(udphdr->source));
+
+	switch (ntohs(udphdr->dest)) {
+	case 67:
+		LEN_CHECK((size_t)buff_len - ip6_header_len -
+			  sizeof(struct udphdr), (size_t) 44, "DHCP");
+		printf("%s.67: BOOTP/DHCP, Request from %s, length %zu\n",
+		       dst_addr,
+		       ether_ntoa_long((struct ether_addr *)(((char *)udphdr) +
+				       sizeof(struct udphdr) + 28)),
+		       (size_t)buff_len - ip6_header_len -
+		       sizeof(struct udphdr));
+		break;
+	case 68:
+		printf("%s.68: BOOTP/DHCP, Reply, length %zu\n", dst_addr,
+		       (size_t)buff_len - ip6_header_len -
+		       sizeof(struct udphdr));
+		break;
+	default:
+		printf("%s.%i: UDP, length %zu\n", dst_addr,
+		       ntohs(udphdr->dest),
+		       (size_t)buff_len - ip6_header_len -
+		       sizeof(struct udphdr));
+		break;
+	}
+}
+
+static void dump_ipv6(unsigned char *packet_buff, ssize_t buff_len,
+		      int time_printed)
+{
+	struct ip6_hdr *iphdr;
+	struct icmp6_hdr *icmphdr;
+
+	char ipv6_addr_src[40], ipv6_addr_dst[40];
+	char ip_saddr[40], ip_daddr[40], nd_nas_target[40];
+	struct nd_neighbor_solicit *nd_neigh_sol;
+	struct nd_neighbor_advert *nd_advert;
+	const char ip_string[] = "IP6";
+
+	iphdr = (struct ip6_hdr *)packet_buff;
+	LEN_CHECK((size_t)buff_len, (size_t)(sizeof(struct ip6_hdr)), "IP6");
+
+	if (!time_printed)
+		print_time();
+
+	inet_ntop(AF_INET6, &(iphdr->ip6_src), ipv6_addr_src, 40);
+	inet_ntop(AF_INET6, &(iphdr->ip6_dst), ipv6_addr_dst, 40);
+
+	switch (iphdr->ip6_nxt) {
+	case IPPROTO_ICMPV6:
+		LEN_CHECK((size_t)buff_len - (size_t)(sizeof(struct ip6_hdr)),
+			  sizeof(struct icmp6_hdr), "ICMPv6");
+		icmphdr = (struct icmp6_hdr *)(packet_buff +
+					       sizeof(struct ip6_hdr));
+
+		printf("IP6 %s > %s ", ipv6_addr_src, ipv6_addr_dst);
+		if (icmphdr->icmp6_type < ICMP6_INFOMSG_MASK &&
+		    (size_t)(buff_len) > IPV6_MIN_MTU) {
+			fprintf(stderr,
+				"Warning - dropping received 'ICMPv6 destination unreached' packet as it is bigger than maximum allowed size (%u): %zu\n",
+				IPV6_MIN_MTU, (size_t)(buff_len));
+			return;
+		}
+
+		printf("ICMP6");
+		switch (icmphdr->icmp6_type) {
+		case ICMP6_DST_UNREACH:
+			switch (icmphdr->icmp6_code) {
+			case ICMP6_DST_UNREACH_NOROUTE:
+				printf(", unreachable route\n");
+				break;
+			case ICMP6_DST_UNREACH_ADMIN:
+				printf(", unreachable prohibited\n");
+				break;
+			case ICMP6_DST_UNREACH_ADDR:
+				printf(", unreachable address\n");
+				break;
+			case ICMP6_DST_UNREACH_BEYONDSCOPE:
+				printf(", beyond scope\n");
+				break;
+			case ICMP6_DST_UNREACH_NOPORT:
+				printf(", unreachable port\n");
+				break;
+			default:
+				printf("unknown unreach code (%u)\n",
+				       icmphdr->icmp6_code);
+			}
+			break;
+		case ICMP6_ECHO_REQUEST:
+			printf(" echo request, id: %d, seq: %d, length: %hu\n",
+			       icmphdr->icmp6_id, icmphdr->icmp6_seq,
+			       iphdr->ip6_plen);
+			break;
+		case ICMP6_ECHO_REPLY:
+			printf(" echo reply, id: %d, seq: %d, length: %hu\n",
+			       icmphdr->icmp6_id, icmphdr->icmp6_seq,
+			       iphdr->ip6_plen);
+			break;
+		case ICMP6_TIME_EXCEEDED:
+			printf(" time exceeded in-transit, length %zu\n",
+			       (size_t)buff_len - sizeof(struct icmp6_hdr));
+			break;
+		case ND_NEIGHBOR_SOLICIT:
+			nd_neigh_sol = (struct nd_neighbor_solicit *)icmphdr;
+			inet_ntop(AF_INET6, &(nd_neigh_sol->nd_ns_target),
+				  nd_nas_target, 40);
+			printf(" neighbor solicitation, who has %s, length %zd\n",
+			       nd_nas_target, buff_len);
+			break;
+		case ND_NEIGHBOR_ADVERT:
+			nd_advert = (struct nd_neighbor_advert *)icmphdr;
+			inet_ntop(AF_INET6, &(nd_advert->nd_na_target),
+				  nd_nas_target, 40);
+			printf(" neighbor advertisement, tgt is %s, length %zd\n",
+			       nd_nas_target, buff_len);
+			break;
+		default:
+			printf(", destination unreachable, unknown icmp6 type (%u)\n",
+			       icmphdr->icmp6_type);
+			break;
+		}
+		break;
+	case IPPROTO_TCP:
+		inet_ntop(AF_INET6, &(iphdr->ip6_src), ip_saddr, 40);
+		inet_ntop(AF_INET6, &(iphdr->ip6_dst), ip_daddr, 40);
+		dump_tcp(ip_string, packet_buff, buff_len,
+			 sizeof(struct ip6_hdr), ip_saddr, ip_daddr);
+		break;
+	case IPPROTO_UDP:
+		inet_ntop(AF_INET6, &(iphdr->ip6_src), ip_saddr, 40);
+		inet_ntop(AF_INET6, &(iphdr->ip6_dst), ip_daddr, 40);
+		dump_udp(ip_string, packet_buff, buff_len,
+			 sizeof(struct ip6_hdr), ip_saddr, ip_daddr);
+		break;
+	default:
+		printf(" IPv6 unknown protocol: %i\n", iphdr->ip6_nxt);
+	}
+}
+
+static void dump_ip(unsigned char *packet_buff, ssize_t buff_len,
+		    int time_printed)
+{
+	struct iphdr *iphdr, *tmp_iphdr;
+	struct udphdr *tmp_udphdr;
 	struct icmphdr *icmphdr;
+	const char ip_string[] = "IP";
 
 	iphdr = (struct iphdr *)packet_buff;
 	LEN_CHECK((size_t)buff_len, (size_t)(iphdr->ihl * 4), "IP");
@@ -254,49 +427,16 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_print
 				(size_t)buff_len - (iphdr->ihl * 4));
 			break;
 		}
-
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
+		dump_tcp(ip_string, packet_buff, buff_len, iphdr->ihl * 4,
+			 inet_ntoa(*(struct in_addr *)&iphdr->saddr),
+			 inet_ntoa(*(struct in_addr *)&iphdr->daddr));
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
+		dump_udp(ip_string, packet_buff, buff_len, iphdr->ihl * 4,
+			 inet_ntoa(*(struct in_addr *)&iphdr->saddr),
+			 inet_ntoa(*(struct in_addr *)&iphdr->daddr));
 		break;
 	default:
 		printf("IP unknown protocol: %i\n", iphdr->protocol);
@@ -497,6 +637,11 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 		if ((dump_level & DUMP_TYPE_NONBAT) || (time_printed))
 			dump_ip(packet_buff + ETH_HLEN, buff_len - ETH_HLEN, time_printed);
 		break;
+	case ETH_P_IPV6:
+		if ((dump_level & DUMP_TYPE_NONBAT) || (time_printed))
+			dump_ipv6(packet_buff + ETH_HLEN, buff_len - ETH_HLEN,
+				  time_printed);
+		break;
 	case ETH_P_8021Q:
 		if ((dump_level & DUMP_TYPE_NONBAT) || (time_printed))
 			dump_vlan(packet_buff, buff_len, read_opt, time_printed);
-- 
1.8.3.2

