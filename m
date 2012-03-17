Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 17 Mar 2012 12:19:23 +0800
Message-Id: <1331957963-23856-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: tcpdump - display new
	not_best_hop_flag when parsing OGMs
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 tcpdump.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 771e4f0..72c9cf1 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -331,10 +331,11 @@ static void dump_batman_iv_ogm(unsigned char *packet_buff, ssize_t buff_len, int
 	printf("BAT %s: ",
 	       get_name_by_macaddr((struct ether_addr *)batman_ogm_packet->orig, read_opt));
 
-	printf("OGM IV via neigh %s, seq %u, tq %3d, ttvn %d, ttcrc %hu, ttl %2d, v %d, flags [%c%c%c%c], length %zu\n",
+	printf("OGM IV via neigh %s, seq %u, tq %3d, ttvn %d, ttcrc %hu, ttl %2d, v %d, flags [%c%c%c%c%c], length %zu\n",
 	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt),
 	       ntohl(batman_ogm_packet->seqno), batman_ogm_packet->tq, batman_ogm_packet->ttvn,
 	       ntohs(batman_ogm_packet->tt_crc), batman_ogm_packet->header.ttl, batman_ogm_packet->header.version,
+	       (batman_ogm_packet->flags & NOT_BEST_NEXT_HOP ? 'N' : '.'),
 	       (batman_ogm_packet->flags & DIRECTLINK ? 'D' : '.'),
 	       (batman_ogm_packet->flags & VIS_SERVER ? 'V' : '.'),
 	       (batman_ogm_packet->flags & PRIMARIES_FIRST_HOP ? 'F' : '.'),
-- 
1.7.9.1

