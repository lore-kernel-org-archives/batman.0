Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon,  6 Jun 2011 11:40:46 +0200
Message-Id: <1307353246-17441-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: tcpdump - display tt_crc field which
	is part of the OGM packet
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
 tcpdump.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 85d461e..4e09274 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -315,15 +315,15 @@ static void dump_batman_ogm(unsigned char *packet_buff, ssize_t buff_len, int re
 	printf("BAT %s: ",
 	       get_name_by_macaddr((struct ether_addr *)batman_packet->orig, read_opt));
 
-	printf("OGM via neigh %s, seq %u, tq %3d, ttvn %d, ttl %2d, v %d, flags [%c%c%c%c], length %zu\n",
-	        get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt),
-	        ntohl(batman_packet->seqno), batman_packet->tq, batman_packet->ttvn,
-	        batman_packet->ttl, batman_packet->version,
-	        (batman_packet->flags & DIRECTLINK ? 'D' : '.'),
-	        (batman_packet->flags & VIS_SERVER ? 'V' : '.'),
-	        (batman_packet->flags & PRIMARIES_FIRST_HOP ? 'F' : '.'),
-	        (batman_packet->gw_flags ? 'G' : '.'),
-	        (size_t)buff_len - sizeof(struct ether_header));
+	printf("OGM via neigh %s, seq %u, tq %3d, ttvn %d, ttcrc %d, ttl %2d, v %d, flags [%c%c%c%c], length %zu\n",
+	       get_name_by_macaddr((struct ether_addr *)ether_header->ether_shost, read_opt),
+	       ntohl(batman_packet->seqno), batman_packet->tq, batman_packet->ttvn,
+	       ntohl(batman_packet->tt_crc), batman_packet->ttl, batman_packet->version,
+	       (batman_packet->flags & DIRECTLINK ? 'D' : '.'),
+	       (batman_packet->flags & VIS_SERVER ? 'V' : '.'),
+	       (batman_packet->flags & PRIMARIES_FIRST_HOP ? 'F' : '.'),
+	       (batman_packet->gw_flags ? 'G' : '.'),
+	       (size_t)buff_len - sizeof(struct ether_header));
 }
 
 static void dump_batman_icmp(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
-- 
1.7.5.3

