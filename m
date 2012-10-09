Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  9 Oct 2012 22:08:59 +0200
Message-Id: <1349813340-5049-3-git-send-email-sven@narfation.org>
In-Reply-To: <1349813340-5049-1-git-send-email-sven@narfation.org>
References: <1349813340-5049-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 3/4] batctl: Allow to skip header in debug
	table output
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Fixed some printf-strings

 debug.c      |   17 ++++++++++++++---
 debug.h      |    1 +
 functions.c  |    7 ++++++-
 functions.h  |    3 ++-
 main.c       |    2 +-
 man/batctl.8 |    3 +++
 sys.c        |   14 +++++++-------
 7 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/debug.c b/debug.c
index 9b5146f..eb7d5ca 100644
--- a/debug.c
+++ b/debug.c
@@ -38,31 +38,37 @@ const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 		.opt_long = "originators",
 		.opt_short = "o",
 		.debugfs_name = "originators",
+		.header_lines = 2,
 	},
 	{
 		.opt_long = "gateways",
 		.opt_short = "gwl",
 		.debugfs_name = "gateways",
+		.header_lines = 1,
 	},
 	{
 		.opt_long = "translocal",
 		.opt_short = "tl",
 		.debugfs_name = "transtable_local",
+		.header_lines = 1,
 	},
 	{
 		.opt_long = "transglobal",
 		.opt_short = "tg",
 		.debugfs_name = "transtable_global",
+		.header_lines = 2,
 	},
 	{
 		.opt_long = "claimtable",
 		.opt_short = "cl",
 		.debugfs_name = "bla_claim_table",
+		.header_lines = 2,
 	},
 	{
 		.opt_long = "backbonetable",
 		.opt_short = "bbt",
 		.debugfs_name = "bla_backbone_table",
+		.header_lines = 2,
 	},
 };
 
@@ -73,6 +79,7 @@ void debug_table_usage(int debug_table)
 	printf("parameters:\n");
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't replace mac addresses with bat-host names\n");
+	printf(" \t -H don't show the header\n");
 	printf(" \t -w [interval] watch mode - refresh the table continuously\n");
 
 	if (debug_table == BATCTL_TABLE_ORIGINATORS)
@@ -88,7 +95,7 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 	float watch_interval = 1;
 	opterr = 0;
 
-	while ((optchar = getopt(argc, argv, "hnw:t:")) != -1) {
+	while ((optchar = getopt(argc, argv, "hnw:t:H")) != -1) {
 		switch (optchar) {
 		case 'h':
 			debug_table_usage(debug_table);
@@ -121,6 +128,9 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 				return EXIT_FAILURE;
 			}
 			break;
+		case 'H':
+			read_opt |= SKIP_HEADER;
+			break;
 		case '?':
 			if (optopt == 't')
 				printf("Error - option '-t' needs a number as argument\n");
@@ -147,7 +157,8 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
 	return read_file(full_path, (char *)batctl_debug_tables[debug_table].debugfs_name,
-			 read_opt, orig_timeout, watch_interval);
+			 read_opt, orig_timeout, watch_interval,
+			 batctl_debug_tables[debug_table].header_lines);
 }
 
 static void log_usage(void)
@@ -185,6 +196,6 @@ int log_print(char *mesh_iface, int argc, char **argv)
 	}
 
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
-	res = read_file(full_path, DEBUG_LOG, read_opt, 0, 0);
+	res = read_file(full_path, DEBUG_LOG, read_opt, 0, 0, 0);
 	return res;
 }
diff --git a/debug.h b/debug.h
index cd9dce0..6580848 100644
--- a/debug.h
+++ b/debug.h
@@ -39,6 +39,7 @@ struct debug_table_data {
        const char opt_long[OPT_LONG_MAX_LEN];
        const char opt_short[OPT_SHORT_MAX_LEN];
        const char debugfs_name[DEBUG_TABLE_PATH_MAX_LEN];
+       size_t header_lines;
 };
 
 extern const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM];
diff --git a/functions.c b/functions.c
index 7bec322..556da36 100644
--- a/functions.c
+++ b/functions.c
@@ -160,7 +160,7 @@ static void file_open_problem_dbg(char *dir, char *fname, char *full_path)
 }
 
 int read_file(char *dir, char *fname, int read_opt,
-	      float orig_timeout, float watch_interval)
+	      float orig_timeout, float watch_interval, size_t header_lines)
 {
 	struct ether_addr *mac_addr;
 	struct bat_host *bat_host;
@@ -169,6 +169,7 @@ int read_file(char *dir, char *fname, int read_opt,
 	char full_path[500], *buff_ptr, *space_ptr, extra_char;
 	size_t len = 0;
 	FILE *fp = NULL;
+	size_t line;
 
 	if (read_opt & USE_BAT_HOSTS)
 		bat_hosts_init(read_opt);
@@ -178,6 +179,7 @@ int read_file(char *dir, char *fname, int read_opt,
 	strncat(full_path, fname, sizeof(full_path) - strlen(full_path));
 
 open:
+	line = 0;
 	fp = fopen(full_path, "r");
 
 	if (!fp) {
@@ -193,6 +195,9 @@ open:
 
 read:
 	while (getline(&line_ptr, &len, fp) != -1) {
+		if (line++ < header_lines && read_opt & SKIP_HEADER)
+			continue;
+
 		/* the buffer will be handled elsewhere */
 		if (read_opt & USE_READ_BUFF)
 			break;
diff --git a/functions.h b/functions.h
index 0ec1d1a..fe0011b 100644
--- a/functions.h
+++ b/functions.h
@@ -35,7 +35,7 @@ char *get_name_by_macaddr(struct ether_addr *mac_addr, int read_opt);
 char *get_name_by_macstr(char *mac_str, int read_opt);
 int file_exists(const char *fpath);
 int read_file(char *dir, char *path, int read_opt,
-	      float orig_timeout, float watch_interval);
+	      float orig_timeout, float watch_interval, size_t skip_lines);
 int write_file(char *dir, char *fname, char *arg1, char *arg2);
 struct ether_addr *translate_mac(char *mesh_iface, struct ether_addr *mac);
 struct ether_addr *resolve_mac(const char *asc);
@@ -52,4 +52,5 @@ enum {
 	SILENCE_ERRORS = 0x20,
 	NO_OLD_ORIGS = 0x40,
 	COMPAT_FILTER = 0x80,
+	SKIP_HEADER = 0x100,
 };
diff --git a/main.c b/main.c
index 01a435b..647818d 100644
--- a/main.c
+++ b/main.c
@@ -118,7 +118,7 @@ int main(int argc, char **argv)
 	if (strcmp(argv[1], "-v") == 0) {
 		printf("batctl %s [batman-adv: ", SOURCE_VERSION);
 
-		ret = read_file("", module_ver_path, USE_READ_BUFF | SILENCE_ERRORS, 0, 0);
+		ret = read_file("", module_ver_path, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
 		if ((line_ptr) && (line_ptr[strlen(line_ptr) - 1] == '\n'))
 			line_ptr[strlen(line_ptr) - 1] = '\0';
 
diff --git a/man/batctl.8 b/man/batctl.8
index 234171f..f8dc99d 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -163,6 +163,9 @@ All of the debug tables support the following options:
 .RS 10
 \-n     do not replace the MAC addresses with bat\-host names in the output
 .RE
+.RS 10
+\-H     do not show the header of the debug table
+.RE
 
 .RS 7
 The originator table also supports the "\-t" filter option to remove all originators from the output that have not been seen
diff --git a/sys.c b/sys.c
index 6f94483..b046164 100644
--- a/sys.c
+++ b/sys.c
@@ -130,7 +130,7 @@ static int print_interfaces(char *mesh_iface)
 
 	while ((iface_dir = readdir(iface_base_dir)) != NULL) {
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, iface_dir->d_name);
-		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0);
+		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
 		if (res != EXIT_SUCCESS)
 			continue;
 
@@ -147,7 +147,7 @@ static int print_interfaces(char *mesh_iface)
 		line_ptr = NULL;
 
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_IFACE_STATUS_FMT, iface_dir->d_name);
-		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0);
+		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
 		if (res != EXIT_SUCCESS) {
 			printf("<error reading status>\n");
 			continue;
@@ -309,7 +309,7 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv)
 		goto out;
 	}
 
-	res = read_file(path_buff, SYS_LOG_LEVEL, USE_READ_BUFF, 0, 0);
+	res = read_file(path_buff, SYS_LOG_LEVEL, USE_READ_BUFF, 0, 0, 0);
 
 	if (res != EXIT_SUCCESS)
 		goto out;
@@ -371,7 +371,7 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 
 	if (argc == 1) {
 		res = read_file(path_buff, (char *)batctl_settings[setting].sysfs_name,
-				NO_FLAGS, 0, 0);
+				NO_FLAGS, 0, 0, 0);
 		goto out;
 	}
 
@@ -434,7 +434,7 @@ int handle_gw_setting(char *mesh_iface, int argc, char **argv)
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
 
 	if (argc == 1) {
-		res = read_file(path_buff, SYS_GW_MODE, USE_READ_BUFF, 0, 0);
+		res = read_file(path_buff, SYS_GW_MODE, USE_READ_BUFF, 0, 0, 0);
 
 		if (res != EXIT_SUCCESS)
 			goto out;
@@ -454,10 +454,10 @@ int handle_gw_setting(char *mesh_iface, int argc, char **argv)
 
 		switch (gw_mode) {
 		case GW_MODE_CLIENT:
-			res = read_file(path_buff, SYS_GW_SEL, USE_READ_BUFF, 0, 0);
+			res = read_file(path_buff, SYS_GW_SEL, USE_READ_BUFF, 0, 0, 0);
 			break;
 		case GW_MODE_SERVER:
-			res = read_file(path_buff, SYS_GW_BW, USE_READ_BUFF, 0, 0);
+			res = read_file(path_buff, SYS_GW_BW, USE_READ_BUFF, 0, 0, 0);
 			break;
 		default:
 			printf("off\n");
-- 
1.7.10.4

