Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 18 Feb 2014 15:13:24 +0100
Message-Id: <1392732804-23206-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: add option for multiif orig table
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 debug.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/debug.c b/debug.c
index d57324d..78c6e55 100644
--- a/debug.c
+++ b/debug.c
@@ -89,8 +89,10 @@ static void debug_table_usage(int debug_table)
 	fprintf(stderr, " \t -H don't show the header\n");
 	fprintf(stderr, " \t -w [interval] watch mode - refresh the table continuously\n");
 
-	if (debug_table == BATCTL_TABLE_ORIGINATORS)
+	if (debug_table == BATCTL_TABLE_ORIGINATORS) {
 		fprintf(stderr, " \t -t timeout interval - don't print originators not seen for x.y seconds \n");
+		fprintf(stderr, " \t -i [interface] - show multiif originator table for a specific interface\n");
+	}
 }
 
 int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
@@ -98,11 +100,12 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 	int optchar, read_opt = USE_BAT_HOSTS;
 	char full_path[MAX_PATH+1];
 	char *debugfs_mnt;
+	char *orig_iface = NULL;
 	float orig_timeout;
 	float watch_interval = 1;
 	opterr = 0;
 
-	while ((optchar = getopt(argc, argv, "hnw:t:H")) != -1) {
+	while ((optchar = getopt(argc, argv, "hnw:t:Hi:")) != -1) {
 		switch (optchar) {
 		case 'h':
 			debug_table_usage(debug_table);
@@ -138,11 +141,21 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 		case 'H':
 			read_opt |= SKIP_HEADER;
 			break;
+		case 'i':
+			if (debug_table != BATCTL_TABLE_ORIGINATORS) {
+				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
+				debug_table_usage(debug_table);
+				return EXIT_FAILURE;
+			}
+
+			orig_iface = optarg;
+			break;
 		case '?':
-			if (optopt == 't')
+			if (optopt == 't') {
 				fprintf(stderr, "Error - option '-t' needs a number as argument\n");
-
-			else if (optopt == 'w') {
+			} else if (optopt == 'i') {
+				fprintf(stderr, "Error - option '-i' needs an interface as argument\n");
+			} else if (optopt == 'w') {
 				read_opt |= CLR_CONT_READ;
 				break;
 			}
@@ -162,7 +175,10 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
+	if (orig_iface)
+		debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", orig_iface, full_path, sizeof(full_path));
+	else
+		debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
 	return read_file(full_path, (char *)batctl_debug_tables[debug_table].debugfs_name,
 			 read_opt, orig_timeout, watch_interval,
 			 batctl_debug_tables[debug_table].header_lines);
-- 
1.7.10.4

