Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 29 May 2011 19:17:40 +0200
Message-Id: <1306689460-30162-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1306689460-30162-1-git-send-email-lindner_marek@yahoo.de>
References: <1306689460-30162-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: tcpdump - add option to select
	all packet types except specified
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
 tcpdump.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 6f1adc1..3e68844 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -51,8 +51,9 @@ if ((size_t)(buff_len) < (check_len)) { \
 	return; \
 }
 
-static unsigned short dump_level = DUMP_TYPE_BATOGM | DUMP_TYPE_BATICMP | DUMP_TYPE_BATUCAST |
+static unsigned short dump_level_all = DUMP_TYPE_BATOGM | DUMP_TYPE_BATICMP | DUMP_TYPE_BATUCAST |
 		DUMP_TYPE_BATBCAST | DUMP_TYPE_BATVIS | DUMP_TYPE_BATFRAG | DUMP_TYPE_BATTT | DUMP_TYPE_NONBAT;
+static unsigned short dump_level;
 
 static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed);
 
@@ -63,6 +64,8 @@ static void tcpdump_usage(void)
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't convert addresses to bat-host names\n");
 	printf(" \t -p dump specific packet type\n");
+	printf(" \t -x dump all packet types except specified\n");
+	printf("packet types:\n");
 	printf(" \t\t%3d - batman ogm packets\n", DUMP_TYPE_BATOGM);
 	printf(" \t\t%3d - batman icmp packets\n", DUMP_TYPE_BATICMP);
 	printf(" \t\t%3d - batman unicast packets\n", DUMP_TYPE_BATUCAST);
@@ -621,7 +624,9 @@ int tcpdump(int argc, char **argv)
 	unsigned char packet_buff[2000];
 	int monitor_header_len = -1;
 
-	while ((optchar = getopt(argc, argv, "hnp:")) != -1) {
+	dump_level = dump_level_all;
+
+	while ((optchar = getopt(argc, argv, "hnp:x:")) != -1) {
 		switch (optchar) {
 		case 'h':
 			tcpdump_usage();
@@ -632,10 +637,16 @@ int tcpdump(int argc, char **argv)
 			break;
 		case 'p':
 			tmp = strtol(optarg, NULL , 10);
-			if ((tmp > 0) && (tmp <= dump_level))
+			if ((tmp > 0) && (tmp <= dump_level_all))
 				dump_level = tmp;
 			found_args += ((*((char*)(optarg - 1)) == optchar ) ? 1 : 2);
 			break;
+		case 'x':
+			tmp = strtol(optarg, NULL , 10);
+			if ((tmp > 0) && (tmp <= dump_level_all))
+				dump_level &= ~tmp;
+			found_args += ((*((char*)(optarg - 1)) == optchar ) ? 1 : 2);
+			break;
 		default:
 			tcpdump_usage();
 			return EXIT_FAILURE;
-- 
1.7.2.3

