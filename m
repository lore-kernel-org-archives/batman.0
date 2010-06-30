Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 30 Jun 2010 20:03:13 +0200
Message-Id: <1277920995-25503-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Add timeout filtering option for
	originators
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

This commit introduces the -t switch for originator table output. It
makes use of the new last-seen field in batman-adv, the user can specify
a timeout interval in seconds (with 3 digits precision before and after
a possible dot) if he/she considers a node as dead after this time.
(of course this is just influencing the displaying and not actually
declearing a node as dead for routing decisions)

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 batctl/debug.c     |   35 ++++++++++++++++++++++++++++++++---
 batctl/functions.c |   14 +++++++++++++-
 batctl/functions.h |    3 ++-
 batctl/sys.c       |    8 ++++----
 4 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/batctl/debug.c b/batctl/debug.c
index c57355a..04d2ebc 100644
--- a/batctl/debug.c
+++ b/batctl/debug.c
@@ -40,6 +40,7 @@ void originators_usage(void)
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't replace mac addresses with bat-host names\n");
 	printf(" \t -w watch mode - refresh the originator table continuously\n");
+	printf(" \t -t timeout interval - don't print originators not seen for xxx.xxx seconds \n");
 }
 
 void trans_local_usage(void)
@@ -74,8 +75,13 @@ int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(
 	int optchar, read_opt = USE_BAT_HOSTS;
 	char full_path[MAX_PATH+1];
 	char *debugfs_mnt;
+	int orig_timeout_secs;
+	int orig_timeout_msecs;
+	char msecs_buff[4];
+	memset(msecs_buff, '0', sizeof(msecs_buff));
+	msecs_buff[3] = '\0';
 
-	while ((optchar = getopt(argc, argv, "hnw")) != -1) {
+	while ((optchar = getopt(argc, argv, "hnwt:")) != -1) {
 		switch (optchar) {
 		case 'h':
 			table_usage();
@@ -86,6 +92,29 @@ int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(
 		case 'w':
 			read_opt |= CLR_CONT_READ;
 			break;
+		case 't':
+			if (table_usage != originators_usage) {
+				table_usage();
+				return EXIT_FAILURE;
+			}
+
+			read_opt |= NO_OLD_ORIGS;
+			if (sscanf(optarg, "%3d.%3s", &orig_timeout_secs,
+						msecs_buff) == 2) {
+				if (strlen(msecs_buff) < 3)
+					msecs_buff[strlen(msecs_buff)] = '0';
+				sscanf(msecs_buff, "%d", &orig_timeout_msecs);
+				orig_timeout_msecs += 1000 * orig_timeout_secs;
+			}
+			else if (sscanf(optarg, "%3d", &orig_timeout_secs) == 1) { ; }
+			else {
+				printf("Error - provided argument of -t is not a number\n");
+				return EXIT_FAILURE;
+			}
+			break;
+		case '?':
+			if (optopt == 't' && table_usage == originators_usage)
+				return EXIT_FAILURE;
 		default:
 			table_usage();
 			return EXIT_FAILURE;
@@ -99,7 +128,7 @@ int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(
 	}
 
 	debugfs_make_path(DEBUG_BATIF_PATH "/", full_path, sizeof(full_path));
-	return read_file(full_path, file_path, read_opt);
+	return read_file(full_path, file_path, read_opt, orig_timeout_msecs);
 }
 
 static void log_usage(void)
@@ -137,7 +166,7 @@ int log_print(int argc, char **argv)
 	}
 
 	debugfs_make_path(DEBUG_BATIF_PATH "/", full_path, sizeof(full_path));
-	res = read_file(full_path, DEBUG_LOG, read_opt);
+	res = read_file(full_path, DEBUG_LOG, read_opt, 0);
 
 	if ((res != EXIT_SUCCESS) && (errno == ENOENT))
 		printf("To read the debug log you need to compile the module with debugging enabled (see the README)\n");
diff --git a/batctl/functions.c b/batctl/functions.c
index 9b697b3..272e08b 100644
--- a/batctl/functions.c
+++ b/batctl/functions.c
@@ -117,11 +117,13 @@ static int check_sys_dir(char *dir)
 	return EXIT_FAILURE;
 }
 
-int read_file(char *dir, char *fname, int read_opt)
+int read_file(char *dir, char *fname, int read_opt, int orig_timeout)
 {
 	struct ether_addr *mac_addr;
 	struct bat_host *bat_host;
 	int res = EXIT_FAILURE;
+	int last_seen_secs;
+	int last_seen_msecs;
 	char full_path[500], *buff_ptr, *space_ptr, extra_char;
 	size_t len = 0;
 	ssize_t read;
@@ -157,6 +159,16 @@ read:
 		if (read_opt & USE_READ_BUFF)
 			break;
 
+		/* skip timed out originators */
+		if (read_opt & NO_OLD_ORIGS) {
+			if (sscanf(line_ptr, "%*s %3d.%3d",
+					&last_seen_secs, &last_seen_msecs) == 2) {
+				last_seen_msecs += 1000 * last_seen_secs;
+				if (last_seen_msecs > orig_timeout)
+					continue;
+			}
+		}
+
 		if (!(read_opt & USE_BAT_HOSTS)) {
 			printf("%s", line_ptr);
 			continue;
diff --git a/batctl/functions.h b/batctl/functions.h
index 885df34..10903e0 100644
--- a/batctl/functions.h
+++ b/batctl/functions.h
@@ -33,7 +33,7 @@ double end_timer(void);
 char *ether_ntoa_long(const struct ether_addr *addr);
 char *get_name_by_macaddr(struct ether_addr *mac_addr, int read_opt);
 char *get_name_by_macstr(char *mac_str, int read_opt);
-int read_file(char *dir, char *path, int read_opt);
+int read_file(char *dir, char *path, int read_opt, int orig_timeout);
 int write_file(char *dir, char *fname, char *arg1, char *arg2);
 
 extern char *line_ptr;
@@ -46,4 +46,5 @@ enum {
 	LOG_MODE = 0x08,
 	USE_READ_BUFF = 0x10,
 	SILENCE_ERRORS = 0x20,
+	NO_OLD_ORIGS = 0x40,
 };
diff --git a/batctl/sys.c b/batctl/sys.c
index 321dfc9..7135841 100644
--- a/batctl/sys.c
+++ b/batctl/sys.c
@@ -79,7 +79,7 @@ static int print_interfaces(void)
 
 	while ((iface_dir = readdir(iface_base_dir)) != NULL) {
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, iface_dir->d_name);
-		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS);
+		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS, 0);
 		if (res != EXIT_SUCCESS)
 			continue;
 
@@ -93,7 +93,7 @@ static int print_interfaces(void)
 		line_ptr = NULL;
 
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_IFACE_STATUS_FMT, iface_dir->d_name);
-		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS);
+		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS, 0);
 		if (res != EXIT_SUCCESS) {
 			printf("<error reading status>\n");
 			continue;
@@ -196,7 +196,7 @@ int handle_loglevel(int argc, char **argv)
 		goto out;
 	}
 
-	res = read_file(SYS_BATIF_PATH, SYS_LOG_LEVEL, SINGLE_READ | USE_READ_BUFF);
+	res = read_file(SYS_BATIF_PATH, SYS_LOG_LEVEL, SINGLE_READ | USE_READ_BUFF, 0);
 
 	if (res != EXIT_SUCCESS)
 		goto out;
@@ -271,7 +271,7 @@ int handle_sys_setting(int argc, char **argv,
 	}
 
 	if (argc == 1)
-		return read_file(SYS_BATIF_PATH, file_path, SINGLE_READ);
+		return read_file(SYS_BATIF_PATH, file_path, SINGLE_READ, 0);
 
 	if (!sysfs_param)
 		goto write_file;
-- 
1.5.6.5

