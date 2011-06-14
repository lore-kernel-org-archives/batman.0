Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 14 Jun 2011 16:22:42 +0200
Message-Id: <1308061362-28727-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: tcpdump - cleanup tt_query packet
	parser
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
 tcpdump.c |   30 +++++++++++++++++++++++-------
 1 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 4e09274..5500899 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -254,6 +254,7 @@ static void dump_vlan(unsigned char *packet_buff, ssize_t buff_len, int read_opt
 static void dump_batman_tt(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed)
 {
 	struct tt_query_packet *tt_query_packet;
+	char *tt_desc, *tt_data, tt_type;
 
 	LEN_CHECK((size_t)buff_len - sizeof(struct ether_header), sizeof(struct tt_query_packet), "BAT TT");
 
@@ -262,17 +263,32 @@ static void dump_batman_tt(unsigned char *packet_buff, ssize_t buff_len, int rea
 	if (!time_printed)
 		print_time();
 
+	switch (tt_query_packet->flags & TT_QUERY_TYPE_MASK) {
+	case TT_REQUEST:
+		tt_desc = "request";
+		tt_data = "crc";
+		tt_type = 'Q';
+		break;
+	case TT_RESPONSE:
+		tt_desc = "response";
+		tt_data = "entries";
+		tt_type = 'P';
+		break;
+	default:
+		tt_desc = "unknown";
+		tt_data = "unknown";
+		tt_type = '?';
+		break;
+	}
+
 	printf("BAT %s > ",
 	       get_name_by_macaddr((struct ether_addr *)tt_query_packet->src, read_opt));
 
-	printf("%s: TT %s, ttvn %d, %s %d, ttl %2d, v %d, flags [%c%c%c], length %zu\n",
+	printf("%s: TT %s, ttvn %d, %s %d, ttl %2d, v %d, flags [%c%c], length %zu\n",
 	       get_name_by_macaddr((struct ether_addr *)tt_query_packet->dst, read_opt),
-	       tt_query_packet->flags & TT_RESPONSE ? "response" : "request",
-	       tt_query_packet->ttvn, tt_query_packet->flags & TT_RESPONSE ? "entries" : "crc",
-	       ntohs(tt_query_packet->tt_data), tt_query_packet->ttl, tt_query_packet->version,
-	       (tt_query_packet->flags & TT_REQUEST ? 'Q' : '.'),
-	       (tt_query_packet->flags & TT_RESPONSE ? 'P' : '.'),
-	       (tt_query_packet->flags & TT_FULL_TABLE ? 'F' : '.'),
+	       tt_desc, tt_query_packet->ttvn, tt_data, ntohs(tt_query_packet->tt_data),
+	       tt_query_packet->ttl, tt_query_packet->version,
+	       tt_type, (tt_query_packet->flags & TT_FULL_TABLE ? 'F' : '.'),
 	       (size_t)buff_len - sizeof(struct ether_header));
 }
 
-- 
1.7.5.3

