Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 28 Feb 2010 04:30:49 +0800
Message-Id: <1267302649-22040-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1267302649-22040-1-git-send-email-lindner_marek@yahoo.de>
References: <201002280430.09575.lindner_marek@yahoo.de>
	<1267302649-22040-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: follow /proc to sysfs conversion
	& introduce input validation
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

batman-adv is in the process of migrating to sysfs, hence batctl needs
to adapt the file paths. In addition batctl makes use of the input
validation support of the new files in sysfs.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batctl/functions.c |    9 +++-
 batctl/functions.h |    3 +
 batctl/main.c      |    8 ++--
 batctl/proc.c      |   34 ---------------
 batctl/proc.h      |    4 --
 batctl/sys.c       |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 batctl/sys.h       |   10 +++-
 7 files changed, 141 insertions(+), 48 deletions(-)

diff --git a/batctl/functions.c b/batctl/functions.c
index 2ead2fc..cf4d264 100644
--- a/batctl/functions.c
+++ b/batctl/functions.c
@@ -35,8 +35,6 @@
 #include "functions.h"
 #include "bat-hosts.h"
 
-#define BATMAN_ADV_TAG "batman-adv:"
-
 static struct timeval start_time;
 static char *host_name;
 char *line_ptr = NULL;
@@ -174,6 +172,13 @@ open:
 
 read:
 	while ((read = getline(&line_ptr, &len, fp)) != -1) {
+		if (read_opt & SEARCH_ARGS) {
+			/* omit log lines which don't start with the correct tag */
+			if (strncmp(line_ptr, SEARCH_ARGS_TAG, strlen(SEARCH_ARGS_TAG)) == 0)
+				break;
+
+			continue;
+		}
 
 		/* the buffer will be handled elsewhere */
 		if (read_opt & USE_READ_BUFF)
diff --git a/batctl/functions.h b/batctl/functions.h
index 88fa53b..c21e9a3 100644
--- a/batctl/functions.h
+++ b/batctl/functions.h
@@ -25,6 +25,8 @@
 
 
 #define ETH_STR_LEN 17
+#define BATMAN_ADV_TAG "batman-adv:"
+#define SEARCH_ARGS_TAG "commands:"
 
 /* return time delta from start to end in milliseconds */
 void start_timer(void);
@@ -45,4 +47,5 @@ enum {
 	USE_BAT_HOSTS = 0x04,
 	LOG_MODE = 0x08,
 	USE_READ_BUFF = 0x10,
+	SEARCH_ARGS = 0x20,
 };
diff --git a/batctl/main.c b/batctl/main.c
index 6e4493d..99bfb5b 100644
--- a/batctl/main.c
+++ b/batctl/main.c
@@ -102,15 +102,15 @@ int main(int argc, char **argv)
 
 	} else if ((strcmp(argv[1], "originators") == 0) || (strcmp(argv[1], "o") == 0)) {
 
-		ret = handle_table(argc - 1, argv + 1, PROC_ORIGINATORS, originators_usage);
+		ret = handle_sys_table(argc - 1, argv + 1, SYS_ORIGINATORS, originators_usage);
 
 	} else if ((strcmp(argv[1], "translocal") == 0) || (strcmp(argv[1], "tl") == 0)) {
 
-		ret = handle_table(argc - 1, argv + 1, PROC_TRANSTABLE_LOCAL, trans_local_usage);
+		ret = handle_sys_table(argc - 1, argv + 1, SYS_TRANSTABLE_LOCAL, trans_local_usage);
 
 	} else if ((strcmp(argv[1], "transglobal") == 0) || (strcmp(argv[1], "tg") == 0)) {
 
-		ret = handle_table(argc - 1, argv + 1, PROC_TRANSTABLE_GLOBAL, trans_global_usage);
+		ret = handle_sys_table(argc - 1, argv + 1, SYS_TRANSTABLE_GLOBAL, trans_global_usage);
 
 	} else if ((strcmp(argv[1], "loglevel") == 0) || (strcmp(argv[1], "ll") == 0)) {
 
@@ -142,7 +142,7 @@ int main(int argc, char **argv)
 
 	} else if ((strcmp(argv[1], "aggregation") == 0) || (strcmp(argv[1], "ag") == 0)) {
 
-		ret = handle_proc_setting(argc - 1, argv + 1, PROC_AGGR, aggregation_usage);
+		ret = handle_sys_setting(argc - 1, argv + 1, SYS_AGGR, aggregation_usage);
 
 	} else if ((strcmp(argv[1], "bisect") == 0)) {
 
diff --git a/batctl/proc.c b/batctl/proc.c
index 3294662..e323a52 100644
--- a/batctl/proc.c
+++ b/batctl/proc.c
@@ -68,33 +68,6 @@ int interface(int argc, char **argv)
 	return EXIT_SUCCESS;
 }
 
-void originators_usage(void)
-{
-	printf("Usage: batctl [options] originators \n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w watch mode - refresh the originator table continuously\n");
-}
-
-void trans_local_usage(void)
-{
-	printf("Usage: batctl [options] translocal \n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w watch mode - refresh the local translation table continuously\n");
-}
-
-void trans_global_usage(void)
-{
-	printf("Usage: batctl [options] transglobal \n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w watch mode - refresh the global translation table continuously\n");
-}
-
 void gw_srv_list_usage(void)
 {
 	printf("Usage: batctl [options] gw_srv_list \n");
@@ -118,13 +91,6 @@ void vis_server_usage(void)
 	printf(" \t -h print this help\n");
 }
 
-void aggregation_usage(void)
-{
-	printf("Usage: batctl [options] aggregation \n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-}
-
 void gw_mode_usage(void)
 {
 	printf("Usage: batctl [options] gw_mode [mode]\n");
diff --git a/batctl/proc.h b/batctl/proc.h
index d867b78..74ac398 100644
--- a/batctl/proc.h
+++ b/batctl/proc.h
@@ -21,13 +21,9 @@
 
 #define PROC_ROOT_PATH "/proc/net/batman-adv/"
 #define PROC_INTERFACES "interfaces"
-#define PROC_ORIGINATORS "originators"
 #define PROC_ORIG_INTERVAL "orig_interval"
-#define PROC_TRANSTABLE_LOCAL "transtable_local"
-#define PROC_TRANSTABLE_GLOBAL "transtable_global"
 #define PROC_VIS_SERVER "vis_server"
 #define PROC_VIS_DATA "vis_data"
-#define PROC_AGGR "aggregate_ogm"
 #define PROC_GW_MODE "gateway_mode"
 #define PROC_GW_SRV_LIST "gateway_srv_list"
 
diff --git a/batctl/sys.c b/batctl/sys.c
index d67a915..65f1ebd 100644
--- a/batctl/sys.c
+++ b/batctl/sys.c
@@ -94,11 +94,11 @@ int handle_loglevel(int argc, char **argv)
 	}
 
 	if (argc != 1) {
-		res = write_file(SYS_ROOT_PATH, SYS_LOG_LEVEL, argv[1]);
+		res = write_file(SYS_MODULE_PATH, SYS_LOG_LEVEL, argv[1]);
 		goto out;
 	}
 
-	res = read_file(SYS_ROOT_PATH, SYS_LOG_LEVEL, SINGLE_READ | USE_READ_BUFF);
+	res = read_file(SYS_MODULE_PATH, SYS_LOG_LEVEL, SINGLE_READ | USE_READ_BUFF);
 
 	if (res != EXIT_SUCCESS)
 		goto out;
@@ -118,3 +118,120 @@ out:
 
 	return res;
 }
+
+void originators_usage(void)
+{
+	printf("Usage: batctl [options] originators \n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+	printf(" \t -n don't replace mac addresses with bat-host names\n");
+	printf(" \t -w watch mode - refresh the originator table continuously\n");
+}
+
+void trans_local_usage(void)
+{
+	printf("Usage: batctl [options] translocal \n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+	printf(" \t -n don't replace mac addresses with bat-host names\n");
+	printf(" \t -w watch mode - refresh the local translation table continuously\n");
+}
+
+void trans_global_usage(void)
+{
+	printf("Usage: batctl [options] transglobal \n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+	printf(" \t -n don't replace mac addresses with bat-host names\n");
+	printf(" \t -w watch mode - refresh the global translation table continuously\n");
+}
+
+int handle_sys_table(int argc, char **argv, char *file_path, void table_usage(void))
+{
+	int optchar, read_opt = USE_BAT_HOSTS;
+
+	while ((optchar = getopt(argc, argv, "hnw")) != -1) {
+		switch (optchar) {
+		case 'h':
+			table_usage();
+			return EXIT_SUCCESS;
+		case 'n':
+			read_opt &= ~USE_BAT_HOSTS;
+			break;
+		case 'w':
+			read_opt |= CLR_CONT_READ;
+			break;
+		default:
+			table_usage();
+			return EXIT_FAILURE;
+		}
+	}
+
+	return read_file(SYS_BATIF_PATH, file_path, read_opt);
+}
+
+void aggregation_usage(void)
+{
+	printf("Usage: batctl [options] aggregation \n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+}
+
+int handle_sys_setting(int argc, char **argv, char *file_path, void setting_usage(void))
+{
+	int optchar, res;
+	char *space_ptr, *comma_char, *cmds = NULL;
+
+	while ((optchar = getopt(argc, argv, "h")) != -1) {
+		switch (optchar) {
+		case 'h':
+			setting_usage();
+			return EXIT_SUCCESS;
+		default:
+			setting_usage();
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (argc == 1)
+		return read_file(SYS_BATIF_PATH, file_path, SINGLE_READ);
+
+	res = read_file(SYS_BATIF_PATH, file_path, SEARCH_ARGS);
+	if (res != EXIT_SUCCESS)
+		return res;
+
+	while ((space_ptr = strchr(line_ptr, ' ')) != NULL) {
+		*space_ptr = '\0';
+
+		if (strncmp(line_ptr, SEARCH_ARGS_TAG, strlen(SEARCH_ARGS_TAG)) == 0) {
+			cmds = space_ptr + 1;
+			goto next;
+		}
+
+		comma_char = NULL;
+		if (line_ptr[strlen(line_ptr) - 1] == ',') {
+			comma_char = line_ptr + strlen(line_ptr) - 1;
+			*comma_char = '\0';
+		}
+
+		if (strcmp(line_ptr, argv[1]) == 0)
+			goto write_file;
+
+		*space_ptr = ' ';
+		if (comma_char)
+			*comma_char = ',';
+
+next:
+		line_ptr = space_ptr + 1;
+	}
+
+	if (!cmds)
+		goto write_file;
+
+	printf("Error - the supplied argument is invalid: %s\n", argv[1]);
+	printf("The following values are allowed: %s", cmds);
+	return EXIT_FAILURE;
+
+write_file:
+	return write_file(SYS_BATIF_PATH, file_path, argv[1]);
+}
diff --git a/batctl/sys.h b/batctl/sys.h
index 812da63..0d6f334 100644
--- a/batctl/sys.h
+++ b/batctl/sys.h
@@ -20,10 +20,16 @@
  */
 
 
-#define SYS_ROOT_PATH "/sys/module/batman_adv/"
+#define SYS_MODULE_PATH "/sys/module/batman_adv/"
+#define SYS_BATIF_PATH "/sys/devices/virtual/net/bat0/mesh/"
 #define SYS_LOG_LEVEL "parameters/debug"
 #define SYS_LOG "log"
-
+#define SYS_ORIGINATORS "originators"
+#define SYS_TRANSTABLE_LOCAL "transtable_local"
+#define SYS_TRANSTABLE_GLOBAL "transtable_global"
+#define SYS_AGGR "aggregate_ogm"
 
 int log_print(int argc, char **argv);
 int handle_loglevel(int argc, char **argv);
+int handle_sys_table(int argc, char **argv, char *file_path, void table_usage(void));
+int handle_sys_setting(int argc, char **argv, char *file_path, void setting_usage(void));
-- 
1.6.6.2

