Return-Path: <marco.dallato@gmail.com>
From: Marco Dalla Torre <marco.dallato@gmail.com>
Date: Sat, 21 Sep 2013 17:05:07 +0200
Message-Id: <1379775907-19199-1-git-send-email-marco.dallato@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH maint] batctl tcpdump: Fix reported length of
	TCP payload
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

Fixes the erratic report of TCP payload length in 'batctl tcpdump'.
Previously TCP header length size was considered fixed, while
this is actually not the case given the variable length (or no
presence at all) of the options field.

Signed-off-by: Marco Dalla Torre <marco.dallato@gmail.com>
---
 tcpdump.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 7e0987b..e6f8f7d 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -194,6 +194,7 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_print
 	struct tcphdr *tcphdr;
 	struct udphdr *udphdr, *tmp_udphdr;
 	struct icmphdr *icmphdr;
+	uint16_t tcp_header_len;
 
 	iphdr = (struct iphdr *)packet_buff;
 	LEN_CHECK((size_t)buff_len, (size_t)(iphdr->ihl * 4), "IP");
@@ -257,16 +258,18 @@ static void dump_ip(unsigned char *packet_buff, ssize_t buff_len, int time_print
 
 		break;
 	case IPPROTO_TCP:
-		LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4), sizeof(struct tcphdr), "TCP");
-
 		tcphdr = (struct tcphdr *)(packet_buff + (iphdr->ihl * 4));
+		tcp_header_len = tcphdr->doff * 4;
+		LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4),
+			  (size_t)tcp_header_len, "TCP");
+
 		printf("IP %s.%i > ", inet_ntoa(*(struct in_addr *)&iphdr->saddr), ntohs(tcphdr->source));
 		printf("%s.%i: TCP, flags [%c%c%c%c%c%c], length %zu\n",
 			inet_ntoa(*(struct in_addr *)&iphdr->daddr), ntohs(tcphdr->dest),
 			(tcphdr->fin ? 'F' : '.'), (tcphdr->syn ? 'S' : '.'),
 			(tcphdr->rst ? 'R' : '.'), (tcphdr->psh ? 'P' : '.'),
 			(tcphdr->ack ? 'A' : '.'), (tcphdr->urg ? 'U' : '.'),
-			(size_t)buff_len - (iphdr->ihl * 4) - sizeof(struct tcphdr));
+			(size_t)buff_len - (iphdr->ihl * 4) - tcp_header_len);
 		break;
 	case IPPROTO_UDP:
 		LEN_CHECK((size_t)buff_len - (iphdr->ihl * 4), sizeof(struct udphdr), "UDP");
-- 
1.8.3.2

