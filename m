Return-Path: <ordex@autistici.org>
From: Antonio Quartull <ordex@autistici.org>
Date: Wed, 19 Oct 2011 14:34:42 +0200
Message-Id: <1319027682-2897-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: correct ttcrc print format in the
	tcpdump output
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

The OGM ttcrc field is an unsigned short int, therefore it has to be printed
using %hu and has to be converted from network to host order using ntohs

Signed-off-by: Antonio Quartull <ordex@autistici.org>
---
 tcpdump.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 977bedc..7dd289e 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -331,10 +331,10 @@ static void dump_batman_ogm(unsigned char *packet_buff, ssize_t buff_len, int re
 	printf("BAT %s: ",
 	       get_name_by_macaddr((struct ether_addr *)batman_ogm_packet->orig, read_opt));
 
-	printf("OGM via neigh %s, seq %u, tq %3d, ttvn %d, ttcrc %d, ttl %2d, v %d, flags [%c%c%c%c], length %zu\n",
+	printf("OGM via neigh %s, seq %u, tq %3d, ttvn %d, ttcrc %hu, ttl %2d, v %d, flags [%c%c%c%c], length %zu\n",
 	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt),
 	       ntohl(batman_ogm_packet->seqno), batman_ogm_packet->tq, batman_ogm_packet->ttvn,
-	       ntohl(batman_ogm_packet->tt_crc), batman_ogm_packet->ttl, batman_ogm_packet->version,
+	       ntohs(batman_ogm_packet->tt_crc), batman_ogm_packet->ttl, batman_ogm_packet->version,
 	       (batman_ogm_packet->flags & DIRECTLINK ? 'D' : '.'),
 	       (batman_ogm_packet->flags & VIS_SERVER ? 'V' : '.'),
 	       (batman_ogm_packet->flags & PRIMARIES_FIRST_HOP ? 'F' : '.'),
-- 
1.7.3.4

