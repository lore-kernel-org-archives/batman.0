Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Mon,  7 Nov 2011 12:52:39 +0100
Message-Id: <1320666759-11791-1-git-send-email-martin@hundeboll.net>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Human readable log levels instead of
	bitmasks
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

As the number of log levels increases, it becomes less user friendly to
assign a log level, as this is given as a bitmask in decimal form. This
commit changes this, so that one or more log levels can be given as
human readable words (e.g. "batctl ll batman routes").
---
 sys.c |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/sys.c b/sys.c
index 4f2b2c5..1fefc6d 100644
--- a/sys.c
+++ b/sys.c
@@ -174,16 +174,24 @@ err:
 
 static void log_level_usage(void)
 {
-	printf("Usage: batctl [options] loglevel [level]\n");
+	printf("Usage: batctl [options] loglevel [level[ level[ level]...]\n");
 	printf("options:\n");
 	printf(" \t -h print this help\n");
+	printf("levels:\n");
+	printf(" \t none    Debug logging is disabled\n");
+	printf(" \t all     Print messages from all below\n");
+	printf(" \t batman  Messages related to routing / flooding / broadcasting\n");
+	printf(" \t routes  Messages related to route added / changed / deleted\n");
+	printf(" \t tt      Messages related to translation table operations\n");
 }
 
 int handle_loglevel(char *mesh_iface, int argc, char **argv)
 {
 	int optchar, res;
-	int log_level;
+	int log_level = 0;
 	char *path_buff;
+	char str[4];
+	int i;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
@@ -200,7 +208,25 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
 
 	if (argc != 1) {
-		res = write_file(path_buff, SYS_LOG_LEVEL, argv[1], NULL);
+		for (i = 1; i < argc; i++) {
+			if (strcmp(argv[i], "none") == 0) {
+				log_level = 0;
+				break;
+			} else if (strcmp(argv[i], "all") == 0) {
+				log_level = 15;
+				break;
+			} else if (strcmp(argv[i], "batman") == 0)
+				log_level |= (1 << 0);
+			else if (strcmp(argv[i], "routes") == 0)
+				log_level |= (1 << 1);
+			else if (strcmp(argv[i], "tt") == 0)
+				log_level |= (1 << 2);
+			else
+				log_level_usage();
+		}
+
+		snprintf(str, 4, "%u", log_level);
+		res = write_file(path_buff, SYS_LOG_LEVEL, str, NULL);
 		goto out;
 	}
 
-- 
1.7.7.2

