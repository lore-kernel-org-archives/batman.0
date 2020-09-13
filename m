Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH] batctl: tcpdump: Fix endianness in ICMPv6 Echo Request/Reply parsing
Date: Sun, 13 Sep 2020 23:30:19 +0200
Message-Id: <20200913213019.4250-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

The ICMPv6 Echo Request/Reply sequence number and id as well as the
IPv6 header length are two byte long fields and therefore might need a
conversion on a little endian system. Otherwise the output will be
broken on such a machine.

Fixes: 35b37756f4a3 ("add IPv6 support to tcpdump parser")
Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
 tcpdump.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index db93681..b9edc20 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -589,13 +589,15 @@ static void dump_ipv6(unsigned char *packet_buff, s=
size_t buff_len,
 			break;
 		case ICMP6_ECHO_REQUEST:
 			printf(" echo request, id: %d, seq: %d, length: %hu\n",
-			       icmphdr->icmp6_id, icmphdr->icmp6_seq,
-			       iphdr->ip6_plen);
+			       ntohs(icmphdr->icmp6_id),
+			       ntohs(icmphdr->icmp6_seq),
+			       ntohs(iphdr->ip6_plen));
 			break;
 		case ICMP6_ECHO_REPLY:
 			printf(" echo reply, id: %d, seq: %d, length: %hu\n",
-			       icmphdr->icmp6_id, icmphdr->icmp6_seq,
-			       iphdr->ip6_plen);
+			       ntohs(icmphdr->icmp6_id),
+			       ntohs(icmphdr->icmp6_seq),
+			       ntohs(iphdr->ip6_plen));
 			break;
 		case ICMP6_TIME_EXCEEDED:
 			printf(" time exceeded in-transit, length %zu\n",
--=20
2.28.0
