Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 31 Mar 2014 09:40:41 +0200
Message-Id: <1396251641-20510-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: tcpdump - fix IP header
	parsing
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

Fix the IP header parsing by properly converting the source
and the destination addresses to strings.
The problem is given by the fact that inet_ntoa() uses a
static buffer to store its result, therefore it cannot be
invoked twice in a row without saving the first outcome.
Moreover inet_ntoa() is deprecated in favor of inet_pton().

Introduced by 35b37756f4a3a230bf7941034d9da178ee5b4948
("add IPv6 support to tcpdump parser")

This patch also slightly beautifies the code.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 tcpdump.c | 73 ++++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index e9fac70..c37943e 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -258,20 +258,27 @@ static void dump_ipv6(unsigned char *packet_buff, ssize_t buff_len,
 	struct ip6_hdr *iphdr;
 	struct icmp6_hdr *icmphdr;
 
-	char ipv6_addr_src[40], ipv6_addr_dst[40];
-	char ip_saddr[40], ip_daddr[40], nd_nas_target[40];
+	char ipsrc[INET6_ADDRSTRLEN], ipdst[INET6_ADDRSTRLEN];
 	struct nd_neighbor_solicit *nd_neigh_sol;
 	struct nd_neighbor_advert *nd_advert;
+	char nd_nas_target[INET6_ADDRSTRLEN];
 	const char ip_string[] = "IP6";
 
 	iphdr = (struct ip6_hdr *)packet_buff;
-	LEN_CHECK((size_t)buff_len, (size_t)(sizeof(struct ip6_hdr)), "IP6");
+	LEN_CHECK((size_t)buff_len, (size_t)(sizeof(struct ip6_hdr)), ip_string);
 
 	if (!time_printed)
 		print_time();
 
-	inet_ntop(AF_INET6, &(iphdr->ip6_src), ipv6_addr_src, 40);
-	inet_ntop(AF_INET6, &(iphdr->ip6_dst), ipv6_addr_dst, 40);
+	if (!inet_ntop(AF_INET6, &iphdr->ip6_src, ipsrc, sizeof(ipsrc))) {
+		printf("Cannot decode source IPv6\n");
+		return;
+	}
+
+	if (!inet_ntop(AF_INET6, &iphdr->ip6_dst, ipdst, sizeof(ipdst))) {
+		printf("Cannot decode destination IPv6\n");
+		return;
+	}
 
 	switch (iphdr->ip6_nxt) {
 	case IPPROTO_ICMPV6:
@@ -280,7 +287,7 @@ static void dump_ipv6(unsigned char *packet_buff, ssize_t buff_len,
 		icmphdr = (struct icmp6_hdr *)(packet_buff +
 					       sizeof(struct ip6_hdr));
 
-		printf("IP6 %s > %s ", ipv6_addr_src, ipv6_addr_dst);
+		printf("%s %s > %s ", ip_string, ipsrc, ipdst);
 		if (icmphdr->icmp6_type < ICMP6_INFOMSG_MASK &&
 		    (size_t)(buff_len) > IPV6_MIN_MTU) {
 			fprintf(stderr,
@@ -348,16 +355,12 @@ static void dump_ipv6(unsigned char *packet_buff, ssize_t buff_len,
 		}
 		break;
 	case IPPROTO_TCP:
-		inet_ntop(AF_INET6, &(iphdr->ip6_src), ip_saddr, 40);
-		inet_ntop(AF_INET6, &(iphdr->ip6_dst), ip_daddr, 40);
 		dump_tcp(ip_string, packet_buff, buff_len,
-			 sizeof(struct ip6_hdr), ip_saddr, ip_daddr);
+			 sizeof(struct ip6_hdr), ipsrc, ipdst);
 		break;
 	case IPPROTO_UDP:
-		inet_ntop(AF_INET6, &(iphdr->ip6_src), ip_saddr, 40);
-		inet_ntop(AF_INET6, &(iphdr->ip6_dst), ip_daddr, 40);
 		dump_udp(ip_string, packet_buff, buff_len,
-			 sizeof(struct ip6_hdr), ip_saddr, ip_daddr);
+			 sizeof(struct ip6_hdr), ipsrc, ipdst);
 		break;
 	default:
 		printf(" IPv6 unknown protocol: %i\n", iphdr->ip6_nxt);
@@ -367,29 +370,40 @@ static void dump_ipv6(unsigned char *packet_buff, ssize_t buff_len,
 static void dump_ip(unsigned char *packet_buff, ssize_t buff_len,
 		    int time_printed)
 {
+	char ipsrc[INET_ADDRSTRLEN], ipdst[INET_ADDRSTRLEN];
 	struct iphdr *iphdr, *tmp_iphdr;
+	const char ip_string[] = "IP";
 	struct udphdr *tmp_udphdr;
 	struct icmphdr *icmphdr;
-	const char ip_string[] = "IP";
 
 	iphdr = (struct iphdr *)packet_buff;
-	LEN_CHECK((size_t)buff_len, (size_t)(iphdr->ihl * 4), "IP");
+	LEN_CHECK((size_t)buff_len, (size_t)(iphdr->ihl * 4), ip_string);
 
 	if (!time_printed)
 		print_time();
 
+	if (!inet_ntop(AF_INET, &iphdr->saddr, ipsrc, sizeof(ipsrc))) {
+		fprintf(stderr, "Cannot decode source IP\n");
+		return;
+	}
+
+	if (!inet_ntop(AF_INET, &iphdr->daddr, ipdst, sizeof(ipdst))) {
+		fprintf(stderr, "Cannot decode destination IP\n");
+		return;
+	}
+
 	switch (iphdr->protocol) {
 	case IPPROTO_ICMP:
 		LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4), sizeof(struct icmphdr), "ICMP");
 
 		icmphdr = (struct icmphdr *)(packet_buff + (iphdr->ihl * 4));
-		printf("IP %s > ", inet_ntoa(*(struct in_addr *)&iphdr->saddr));
+		printf("%s %s > ", ip_string, ipsrc);
 
 		switch (icmphdr->type) {
 		case ICMP_ECHOREPLY:
 			printf("%s: ICMP echo reply, id %hu, seq %hu, length %zu\n",
-				inet_ntoa(*(struct in_addr *)&iphdr->daddr),
-				ntohs(icmphdr->un.echo.id), ntohs(icmphdr->un.echo.sequence),
+				ipdst, ntohs(icmphdr->un.echo.id),
+				ntohs(icmphdr->un.echo.sequence),
 				(size_t)buff_len - (iphdr->ihl * 4));
 			break;
 		case ICMP_DEST_UNREACH:
@@ -401,46 +415,43 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len,
 				tmp_iphdr = (struct iphdr *)(((char *)icmphdr) + sizeof(struct icmphdr));
 				tmp_udphdr = (struct udphdr *)(((char *)tmp_iphdr) + (tmp_iphdr->ihl * 4));
 
-				printf("%s: ICMP ", inet_ntoa(*(struct in_addr *)&iphdr->daddr));
+				printf("%s: ICMP ", ipdst);
 				printf("%s udp port %hu unreachable, length %zu\n",
-					inet_ntoa(*(struct in_addr *)&tmp_iphdr->daddr),
-					ntohs(tmp_udphdr->dest), (size_t)buff_len - (iphdr->ihl * 4));
+					ipdst, ntohs(tmp_udphdr->dest),
+					(size_t)buff_len - (iphdr->ihl * 4));
 				break;
 			default:
 				printf("%s: ICMP unreachable %hhu, length %zu\n",
-					inet_ntoa(*(struct in_addr *)&iphdr->daddr),
-					icmphdr->code, (size_t)buff_len - (iphdr->ihl * 4));
+					ipdst, icmphdr->code,
+					(size_t)buff_len - (iphdr->ihl * 4));
 				break;
 			}
 
 			break;
 		case ICMP_ECHO:
 			printf("%s: ICMP echo request, id %hu, seq %hu, length %zu\n",
-				inet_ntoa(*(struct in_addr *)&iphdr->daddr),
-				ntohs(icmphdr->un.echo.id), ntohs(icmphdr->un.echo.sequence),
+				ipdst, ntohs(icmphdr->un.echo.id),
+				ntohs(icmphdr->un.echo.sequence),
 				(size_t)buff_len - (iphdr->ihl * 4));
 			break;
 		case ICMP_TIME_EXCEEDED:
 			printf("%s: ICMP time exceeded in-transit, length %zu\n",
-				inet_ntoa(*(struct in_addr *)&iphdr->daddr),
-				(size_t)buff_len - (iphdr->ihl * 4));
+				ipdst, (size_t)buff_len - (iphdr->ihl * 4));
 			break;
 		default:
 			printf("%s: ICMP type %hhu, length %zu\n",
-				inet_ntoa(*(struct in_addr *)&iphdr->daddr), icmphdr->type,
+				ipdst, icmphdr->type,
 				(size_t)buff_len - (iphdr->ihl * 4));
 			break;
 		}
 		break;
 	case IPPROTO_TCP:
 		dump_tcp(ip_string, packet_buff, buff_len, iphdr->ihl * 4,
-			 inet_ntoa(*(struct in_addr *)&iphdr->saddr),
-			 inet_ntoa(*(struct in_addr *)&iphdr->daddr));
+			 ipsrc, ipdst);
 		break;
 	case IPPROTO_UDP:
 		dump_udp(ip_string, packet_buff, buff_len, iphdr->ihl * 4,
-			 inet_ntoa(*(struct in_addr *)&iphdr->saddr),
-			 inet_ntoa(*(struct in_addr *)&iphdr->daddr));
+			 ipsrc, ipdst);
 		break;
 	default:
 		printf("IP unknown protocol: %i\n", iphdr->protocol);
-- 
1.8.3.2

