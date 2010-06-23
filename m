Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 23 Jun 2010 16:20:39 +0200
Message-Id: <1277302839-20197-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201006231620.11058.lindner_marek@yahoo.de>
References: <201006231620.11058.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: add debug log support
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
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

batctl offers the possibilities to read the debug log file in
the debugfs folder of batman-adv (given that the debug log was
compiled in).

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batctl/debug.c      |   43 +++++++++++++++++++++++++++++++++++++++++++
 batctl/debug.h      |    2 ++
 batctl/functions.c  |   34 ++--------------------------------
 batctl/man/batctl.8 |    4 ++--
 batctl/sys.c        |   40 ----------------------------------------
 batctl/sys.h        |    1 -
 6 files changed, 49 insertions(+), 75 deletions(-)

diff --git a/batctl/debug.c b/batctl/debug.c
index 0e877fa..c57355a 100644
--- a/batctl/debug.c
+++ b/batctl/debug.c
@@ -101,3 +101,46 @@ int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(
 	debugfs_make_path(DEBUG_BATIF_PATH "/", full_path, sizeof(full_path));
 	return read_file(full_path, file_path, read_opt);
 }
+
+static void log_usage(void)
+{
+	printf("Usage: batctl [options] log \n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+	printf(" \t -n don't replace mac addresses with bat-host names\n");
+}
+
+int log_print(int argc, char **argv)
+{
+	int optchar, res, read_opt = USE_BAT_HOSTS | LOG_MODE;
+	char full_path[MAX_PATH+1];
+	char *debugfs_mnt;
+
+	while ((optchar = getopt(argc, argv, "hn")) != -1) {
+		switch (optchar) {
+		case 'h':
+			log_usage();
+			return EXIT_SUCCESS;
+		case 'n':
+			read_opt &= ~USE_BAT_HOSTS;
+			break;
+		default:
+			log_usage();
+			return EXIT_FAILURE;
+		}
+	}
+
+	debugfs_mnt = debugfs_mount(NULL);
+	if (!debugfs_mnt) {
+		printf("Error - can't mount or find debugfs\n");
+		return EXIT_FAILURE;
+	}
+
+	debugfs_make_path(DEBUG_BATIF_PATH "/", full_path, sizeof(full_path));
+	res = read_file(full_path, DEBUG_LOG, read_opt);
+
+	if ((res != EXIT_SUCCESS) && (errno == ENOENT))
+		printf("To read the debug log you need to compile the module with debugging enabled (see the README)\n");
+
+	return res;
+}
diff --git a/batctl/debug.h b/batctl/debug.h
index 8b03b10..bc6d16c 100644
--- a/batctl/debug.h
+++ b/batctl/debug.h
@@ -26,9 +26,11 @@
 #define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
 #define DEBUG_GATEWAYS "gateways"
 #define DEBUG_VIS_DATA "vis_data"
+#define DEBUG_LOG "log"
 
 void originators_usage(void);
 void trans_local_usage(void);
 void trans_global_usage(void);
 void gateways_usage(void);
 int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(void));
+int log_print(int argc, char **argv);
diff --git a/batctl/functions.c b/batctl/functions.c
index 7be9511..9b697b3 100644
--- a/batctl/functions.c
+++ b/batctl/functions.c
@@ -99,24 +99,6 @@ char *get_name_by_macstr(char *mac_str, int read_opt)
 	return get_name_by_macaddr(mac_addr, read_opt);
 }
 
-static int check_proc_dir(char *dir)
-{
-	struct stat st;
-
-	if (stat("/proc/", &st) != 0) {
-		printf("Error - the folder '/proc' was not found on the system\n");
-		printf("Please make sure that the proc filesystem is properly mounted\n");
-		return EXIT_FAILURE;
-	}
-
-	if (stat(dir, &st) == 0)
-		return EXIT_SUCCESS;
-
-	printf("Error - the folder '%s' was not found within the proc filesystem\n", dir);
-	printf("Please make sure that the batman-adv kernel module is loaded\n");
-	return EXIT_FAILURE;
-}
-
 static int check_sys_dir(char *dir)
 {
 	struct stat st;
@@ -148,10 +130,7 @@ int read_file(char *dir, char *fname, int read_opt)
 	if (read_opt & USE_BAT_HOSTS)
 		bat_hosts_init();
 
-	if (strstr(dir, "/proc/")) {
-		if (check_proc_dir(dir) != EXIT_SUCCESS)
-			goto out;
-	} else if (strstr(dir, "/sys/")) {
+	if (strstr(dir, "/sys/")) {
 		if (check_sys_dir(dir) != EXIT_SUCCESS)
 			goto out;
 	}
@@ -178,12 +157,6 @@ read:
 		if (read_opt & USE_READ_BUFF)
 			break;
 
-		if (read_opt & LOG_MODE) {
-			/* omit log lines which don't start with the correct tag */
-			if (strncmp(line_ptr, BATMAN_ADV_TAG, strlen(BATMAN_ADV_TAG)) != 0)
-				continue;
-		}
-
 		if (!(read_opt & USE_BAT_HOSTS)) {
 			printf("%s", line_ptr);
 			continue;
@@ -267,10 +240,7 @@ int write_file(char *dir, char *fname, char *arg1, char *arg2)
 	char full_path[500];
 	ssize_t write_len;
 
-	if (strstr(dir, "/proc/")) {
-		if (check_proc_dir(dir) != EXIT_SUCCESS)
-			goto out;
-	} else if (strstr(dir, "/sys/")) {
+	if (strstr(dir, "/sys/")) {
 		if (check_sys_dir(dir) != EXIT_SUCCESS)
 			goto out;
 	}
diff --git a/batctl/man/batctl.8 b/batctl/man/batctl.8
index 0684d4f..cc464d2 100644
--- a/batctl/man/batctl.8
+++ b/batctl/man/batctl.8
@@ -65,8 +65,8 @@ If no parameter is given the current originator interval setting is displayed ot
 .IP "\fBloglevel\fP|\fBll\fP      [\fBlevel\fP]"
 If no parameter is given the current log level settings are displayed otherwise the parameter is used to set the log level. Level 0 disables all verbose logging. Level 1 enables messages related to routing / flooding / broadcasting. Level 2 enables messages related to route or hna added / changed / deleted. Level 3 enables all messages. The messages are sent to the kernel log. Use \fBdmesg\fP(1) to see them. Make sure to have debugging output enabled when compiling the module otherwise the output as well as the loglevel options won't be available.
 .br
-.IP "\fBlog\fP|\fBl\fP            [\fBlogfile\fP][\fB\-w\fP][\fB\-n\fP]\fP"
-batctl will read the file logfile, or stdin if the logfile parameter is not given, applying filtering so only the B.A.T.M.A.N. Advanced messages are displayed. Once the end of the file has been reached batctl will exit unless the option "\-w" was specified which causes batctl to continue reading the file and print log output whenever new log data has been appended to the file.
+.IP "\fBlog\fP|\fBl\fP            [\fB\-n\fP]\fP"
+batctl will read the batman-adv debug log which has to be compiled into the kernel module. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output.
 .br
 .IP "\fBgw_mode|gw\fP       [\fBoff\fP|\fBclient\fP|\fBserver\fP] [\fBgw_class\fP]\fP"
 If no parameter is given the current gateway mode is displayed otherwise the parameter is used to set the gateway mode. The second (optional) argument specifies the gateway class. Its function depends on whether the node is a server or a client. If the node is a server this parameter is used to inform other nodes in the network about this node's internet connection bandwidth. Just enter any number (optionally followed by "kbit" or "mbit") and the batman-adv module will guess your appropriate gateway class. Use "/" to separate the down\(hy and upload rates. You can omit the upload rate and the module will assume an upload of download / 5.
diff --git a/batctl/sys.c b/batctl/sys.c
index 9137424..2d1543f 100644
--- a/batctl/sys.c
+++ b/batctl/sys.c
@@ -169,46 +169,6 @@ err:
 	return EXIT_FAILURE;
 }
 
-static void log_usage(void)
-{
-	printf("Usage: batctl [options] log [logfile]\n");
-	printf("Note: if no logfile was specified stdin is read");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w watch mode - read the log file continuously\n");
-}
-
-int log_print(int argc, char **argv)
-{
-	int optchar, read_opt = USE_BAT_HOSTS | LOG_MODE;
-	int found_args = 1;
-
-	while ((optchar = getopt(argc, argv, "hnw")) != -1) {
-		switch (optchar) {
-		case 'h':
-			log_usage();
-			return EXIT_SUCCESS;
-		case 'n':
-			read_opt &= ~USE_BAT_HOSTS;
-			found_args += 1;
-			break;
-		case 'w':
-			read_opt |= CONT_READ;
-			found_args += 1;
-			break;
-		default:
-			log_usage();
-			return EXIT_FAILURE;
-		}
-	}
-
-	if (argc > found_args)
-		return read_file("", argv[found_args], read_opt);
-	else
-		return read_file("", "/proc/self/fd/0", read_opt);
-}
-
 static void log_level_usage(void)
 {
 	printf("Usage: batctl [options] loglevel [level]\n");
diff --git a/batctl/sys.h b/batctl/sys.h
index 3bbe030..ded6a41 100644
--- a/batctl/sys.h
+++ b/batctl/sys.h
@@ -41,7 +41,6 @@ void bonding_usage(void);
 void gw_mode_usage(void);
 void vis_mode_usage(void);
 void orig_interval_usage(void);
-int log_print(int argc, char **argv);
 int interface(int argc, char **argv);
 int handle_loglevel(int argc, char **argv);
 int handle_sys_setting(int argc, char **argv, char *file_path,
-- 
1.7.1

