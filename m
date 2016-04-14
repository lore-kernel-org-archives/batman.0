Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Thu, 14 Apr 2016 17:29:57 +0800
Message-Id: <1460626198-31226-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: tcpdump - filter OGM and OGMv2
	packets independently
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
Cc: Antonio Quartulli <a@unstable.cc>, Antonio Quartulli <antonio@open-mesh.com>

for debugging purposes it might be required to dump either OGMs
or OGM2s only. For this reason it is better to make the tcpdump
engine more flexible and accept distinct filters for the two
packet types.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 tcpdump.c | 15 ++++++++-------
 tcpdump.h | 15 ++++++++-------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index a30e34b..745f5d4 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -64,10 +64,11 @@ if ((size_t)(buff_len) < (check_len)) { \
 	return; \
 }
 
-static unsigned short dump_level_all = DUMP_TYPE_BATOGM | DUMP_TYPE_BATELP |
-				       DUMP_TYPE_BATICMP | DUMP_TYPE_BATUCAST |
-				       DUMP_TYPE_BATBCAST | DUMP_TYPE_BATUTVLV |
-				       DUMP_TYPE_BATFRAG | DUMP_TYPE_NONBAT;
+static unsigned short dump_level_all = DUMP_TYPE_BATOGM | DUMP_TYPE_BATOGM2 |
+				       DUMP_TYPE_BATELP | DUMP_TYPE_BATICMP |
+				       DUMP_TYPE_BATUCAST | DUMP_TYPE_BATBCAST |
+				       DUMP_TYPE_BATUTVLV | DUMP_TYPE_BATFRAG |
+				       DUMP_TYPE_NONBAT;
 static unsigned short dump_level;
 
 static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read_opt, int time_printed);
@@ -82,8 +83,8 @@ static void tcpdump_usage(void)
 	fprintf(stderr, " \t -p dump specific packet type\n");
 	fprintf(stderr, " \t -x dump all packet types except specified\n");
 	fprintf(stderr, "packet types:\n");
-	fprintf(stderr, " \t\t%3d - batman ogm/ogmv2 packets\n",
-		DUMP_TYPE_BATOGM);
+	fprintf(stderr, " \t\t%3d - batman ogm packets\n", DUMP_TYPE_BATOGM);
+	fprintf(stderr, " \t\t%3d - batman ogmv2 packets\n", DUMP_TYPE_BATOGM2);
 	fprintf(stderr, " \t\t%3d - batman elp packets\n", DUMP_TYPE_BATELP);
 	fprintf(stderr, " \t\t%3d - batman icmp packets\n", DUMP_TYPE_BATICMP);
 	fprintf(stderr, " \t\t%3d - batman unicast packets\n", DUMP_TYPE_BATUCAST);
@@ -963,7 +964,7 @@ static void parse_eth_hdr(unsigned char *packet_buff, ssize_t buff_len, int read
 				dump_batman_iv_ogm(packet_buff, buff_len, read_opt, time_printed);
 			break;
 		case BATADV_OGM2:
-			if (dump_level & DUMP_TYPE_BATOGM)
+			if (dump_level & DUMP_TYPE_BATOGM2)
 				dump_batman_ogm2(packet_buff, buff_len,
 						 read_opt, time_printed);
 			break;
diff --git a/tcpdump.h b/tcpdump.h
index 5ec474f..229ee70 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -38,13 +38,14 @@
 #endif
 
 #define DUMP_TYPE_BATOGM 1
-#define DUMP_TYPE_BATELP 2
-#define DUMP_TYPE_BATICMP 4
-#define DUMP_TYPE_BATUCAST 8
-#define DUMP_TYPE_BATBCAST 16
-#define DUMP_TYPE_BATUTVLV 32
-#define DUMP_TYPE_BATFRAG 64
-#define DUMP_TYPE_NONBAT 128
+#define DUMP_TYPE_BATOGM2 2
+#define DUMP_TYPE_BATELP 4
+#define DUMP_TYPE_BATICMP 8
+#define DUMP_TYPE_BATUCAST 16
+#define DUMP_TYPE_BATBCAST 32
+#define DUMP_TYPE_BATUTVLV 64
+#define DUMP_TYPE_BATFRAG 128
+#define DUMP_TYPE_NONBAT 256
 
 #define IEEE80211_FCTL_FTYPE 0x0c00
 #define IEEE80211_FCTL_TODS 0x0001
-- 
2.8.1

