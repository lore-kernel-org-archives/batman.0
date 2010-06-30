Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 30 Jun 2010 20:03:14 +0200
Message-Id: <1277920995-25503-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1277920995-25503-1-git-send-email-linus.luessing@web.de>
References: <1277920995-25503-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Add an optional interval for
	watch-mode
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

If you are running a very mobile mesh network with a fast originator
interval, then the last-seen interval might not update fast enough
depending on the actual scenario, because the default polling interval
of batctl is 1 second. With this patch, an optional interval in seconds
and a precision of 3 digits before and after an optional dot can be
added, making the batctl-watch-mode updates faster.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 batctl/debug.c     |   79 ++++++++++++++++++++++++++++++++++++---------------
 batctl/functions.c |    7 ++--
 batctl/functions.h |    3 +-
 batctl/sys.c       |    8 ++--
 4 files changed, 66 insertions(+), 31 deletions(-)

diff --git a/batctl/debug.c b/batctl/debug.c
index 04d2ebc..7f0e8f3 100644
--- a/batctl/debug.c
+++ b/batctl/debug.c
@@ -39,7 +39,7 @@ void originators_usage(void)
 	printf("options:\n");
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w watch mode - refresh the originator table continuously\n");
+	printf(" \t -w [interval] watch mode - refresh the originator table continuously\n");
 	printf(" \t -t timeout interval - don't print originators not seen for xxx.xxx seconds \n");
 }
 
@@ -49,7 +49,7 @@ void trans_local_usage(void)
 	printf("options:\n");
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w watch mode - refresh the local translation table continuously\n");
+	printf(" \t -w [interval] watch mode - refresh the local translation table continuously\n");
 }
 
 void trans_global_usage(void)
@@ -58,7 +58,7 @@ void trans_global_usage(void)
 	printf("options:\n");
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w watch mode - refresh the global translation table continuously\n");
+	printf(" \t -w [interval] watch mode - refresh the global translation table continuously\n");
 }
 
 void gateways_usage(void)
@@ -67,7 +67,32 @@ void gateways_usage(void)
 	printf("options:\n");
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w watch mode - refresh the gateway server list continuously\n");
+	printf(" \t -w [interval] watch mode - refresh the gateway server list continuously\n");
+}
+
+/* secstring is a string containing a time in seconds with an optional decimal
+ * dot. secstring has a maxmimum precision of "xxx.xxx".
+ * A return of -1 means an error in conversion. */
+int secstr_to_msecs(char *secstring) {
+	int seconds;
+	int mseconds;
+	char msecs_buff[4];
+	msecs_buff[3] = '\0';
+	memset(msecs_buff, '0', sizeof(msecs_buff)-1);
+
+	if (sscanf(secstring, "%3d.%3s", &seconds,
+			msecs_buff) == 2) {
+		if (strlen(msecs_buff) < 3)
+			msecs_buff[strlen(msecs_buff)] = '0';
+		sscanf(msecs_buff, "%d", &mseconds);
+		mseconds += 1000 * seconds;
+	}
+	else if (sscanf(secstring, "%3d", &seconds) == 1)
+		return (1000 * seconds);
+	else
+		return -1;
+
+	return mseconds;
 }
 
 int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(void))
@@ -75,13 +100,11 @@ int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(
 	int optchar, read_opt = USE_BAT_HOSTS;
 	char full_path[MAX_PATH+1];
 	char *debugfs_mnt;
-	int orig_timeout_secs;
-	int orig_timeout_msecs;
-	char msecs_buff[4];
-	memset(msecs_buff, '0', sizeof(msecs_buff));
-	msecs_buff[3] = '\0';
+	int orig_timeout = 0;
+	int watch_interval = 1000;
+	opterr = 0;
 
-	while ((optchar = getopt(argc, argv, "hnwt:")) != -1) {
+	while ((optchar = getopt(argc, argv, "hnw:t:")) != -1) {
 		switch (optchar) {
 		case 'h':
 			table_usage();
@@ -91,6 +114,16 @@ int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(
 			break;
 		case 'w':
 			read_opt |= CLR_CONT_READ;
+			if (optarg[0] == '-') {
+				optind--;
+				break;
+			}
+
+			watch_interval = secstr_to_msecs(optarg);
+			if (watch_interval < 0) {
+				printf("Error - provided argument of -w is not a number\n");
+				return EXIT_FAILURE;
+			}
 			break;
 		case 't':
 			if (table_usage != originators_usage) {
@@ -99,22 +132,22 @@ int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(
 			}
 
 			read_opt |= NO_OLD_ORIGS;
-			if (sscanf(optarg, "%3d.%3s", &orig_timeout_secs,
-						msecs_buff) == 2) {
-				if (strlen(msecs_buff) < 3)
-					msecs_buff[strlen(msecs_buff)] = '0';
-				sscanf(msecs_buff, "%d", &orig_timeout_msecs);
-				orig_timeout_msecs += 1000 * orig_timeout_secs;
-			}
-			else if (sscanf(optarg, "%3d", &orig_timeout_secs) == 1) { ; }
-			else {
+			orig_timeout = secstr_to_msecs(optarg);
+			if (orig_timeout < 0) {
 				printf("Error - provided argument of -t is not a number\n");
 				return EXIT_FAILURE;
 			}
 			break;
 		case '?':
-			if (optopt == 't' && table_usage == originators_usage)
-				return EXIT_FAILURE;
+			if (optopt == 't')
+				printf("Error - argument -t needs a number\n");
+			
+			if (optopt == 'w') {
+				read_opt |= CLR_CONT_READ;
+				break;
+			}
+
+			return EXIT_FAILURE;
 		default:
 			table_usage();
 			return EXIT_FAILURE;
@@ -128,7 +161,7 @@ int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(
 	}
 
 	debugfs_make_path(DEBUG_BATIF_PATH "/", full_path, sizeof(full_path));
-	return read_file(full_path, file_path, read_opt, orig_timeout_msecs);
+	return read_file(full_path, file_path, read_opt, orig_timeout, watch_interval);
 }
 
 static void log_usage(void)
@@ -166,7 +199,7 @@ int log_print(int argc, char **argv)
 	}
 
 	debugfs_make_path(DEBUG_BATIF_PATH "/", full_path, sizeof(full_path));
-	res = read_file(full_path, DEBUG_LOG, read_opt, 0);
+	res = read_file(full_path, DEBUG_LOG, read_opt, 0, 0);
 
 	if ((res != EXIT_SUCCESS) && (errno == ENOENT))
 		printf("To read the debug log you need to compile the module with debugging enabled (see the README)\n");
diff --git a/batctl/functions.c b/batctl/functions.c
index 272e08b..573ecb6 100644
--- a/batctl/functions.c
+++ b/batctl/functions.c
@@ -117,7 +117,8 @@ static int check_sys_dir(char *dir)
 	return EXIT_FAILURE;
 }
 
-int read_file(char *dir, char *fname, int read_opt, int orig_timeout)
+int read_file(char *dir, char *fname, int read_opt,
+	      int orig_timeout, int watch_interval)
 {
 	struct ether_addr *mac_addr;
 	struct bat_host *bat_host;
@@ -223,14 +224,14 @@ written:
 	}
 
 	if (read_opt & CONT_READ) {
-		sleep(1);
+		usleep(1000 * watch_interval);
 		goto read;
 	}
 
 	if (read_opt & CLR_CONT_READ) {
 		if (fp)
 			fclose(fp);
-		sleep(1);
+		usleep(1000 * watch_interval);
 		goto open;
 	}
 
diff --git a/batctl/functions.h b/batctl/functions.h
index 10903e0..0a8666a 100644
--- a/batctl/functions.h
+++ b/batctl/functions.h
@@ -33,7 +33,8 @@ double end_timer(void);
 char *ether_ntoa_long(const struct ether_addr *addr);
 char *get_name_by_macaddr(struct ether_addr *mac_addr, int read_opt);
 char *get_name_by_macstr(char *mac_str, int read_opt);
-int read_file(char *dir, char *path, int read_opt, int orig_timeout);
+int read_file(char *dir, char *path, int read_opt,
+	      int orig_timeout, int watch_interval);
 int write_file(char *dir, char *fname, char *arg1, char *arg2);
 
 extern char *line_ptr;
diff --git a/batctl/sys.c b/batctl/sys.c
index 7135841..4c07866 100644
--- a/batctl/sys.c
+++ b/batctl/sys.c
@@ -79,7 +79,7 @@ static int print_interfaces(void)
 
 	while ((iface_dir = readdir(iface_base_dir)) != NULL) {
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, iface_dir->d_name);
-		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS, 0);
+		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS, 0, 0);
 		if (res != EXIT_SUCCESS)
 			continue;
 
@@ -93,7 +93,7 @@ static int print_interfaces(void)
 		line_ptr = NULL;
 
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_IFACE_STATUS_FMT, iface_dir->d_name);
-		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS, 0);
+		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS, 0, 0);
 		if (res != EXIT_SUCCESS) {
 			printf("<error reading status>\n");
 			continue;
@@ -196,7 +196,7 @@ int handle_loglevel(int argc, char **argv)
 		goto out;
 	}
 
-	res = read_file(SYS_BATIF_PATH, SYS_LOG_LEVEL, SINGLE_READ | USE_READ_BUFF, 0);
+	res = read_file(SYS_BATIF_PATH, SYS_LOG_LEVEL, SINGLE_READ | USE_READ_BUFF, 0, 0);
 
 	if (res != EXIT_SUCCESS)
 		goto out;
@@ -271,7 +271,7 @@ int handle_sys_setting(int argc, char **argv,
 	}
 
 	if (argc == 1)
-		return read_file(SYS_BATIF_PATH, file_path, SINGLE_READ, 0);
+		return read_file(SYS_BATIF_PATH, file_path, SINGLE_READ, 0, 0);
 
 	if (!sysfs_param)
 		goto write_file;
-- 
1.5.6.5

