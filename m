Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 15 Mar 2010 09:03:05 +0800
Message-Id: <1268614986-17280-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201003150902.33262.lindner_marek@yahoo.de>
References: <201003150902.33262.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batctl: adjust to new /sysfs paths
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

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batctl/functions.c |    7 +++++--
 batctl/functions.h |    2 +-
 batctl/main.c      |   14 +++++++-------
 batctl/proc.c      |   29 +++--------------------------
 batctl/proc.h      |    7 -------
 batctl/sys.c       |   33 ++++++++++++++++++++++++++++-----
 batctl/sys.h       |    7 +++++++
 batctl/vis.c       |    8 ++++----
 8 files changed, 55 insertions(+), 52 deletions(-)

diff --git a/batctl/functions.c b/batctl/functions.c
index 58ba861..a7f4b77 100644
--- a/batctl/functions.c
+++ b/batctl/functions.c
@@ -268,7 +268,7 @@ out:
 	return res;
 }
 
-int write_file(char *dir, char *fname, char *value)
+int write_file(char *dir, char *fname, char *arg1, char *arg2)
 {
 	int fd = 0, res = EXIT_FAILURE;
 	char full_path[500];
@@ -293,7 +293,10 @@ int write_file(char *dir, char *fname, char *value)
 		goto out;
 	}
 
-	write_len = write(fd, value, strlen(value) + 1);
+	if (arg2)
+		write_len = dprintf(fd, "%s %s", arg1, arg2);
+	else
+		write_len = write(fd, arg1, strlen(arg1) + 1);
 
 	if (write_len < 0) {
 		printf("Error - can't write to file '%s': %s\n", full_path, strerror(errno));
diff --git a/batctl/functions.h b/batctl/functions.h
index c21e9a3..3756392 100644
--- a/batctl/functions.h
+++ b/batctl/functions.h
@@ -35,7 +35,7 @@ char *ether_ntoa_long(const struct ether_addr *addr);
 char *get_name_by_macaddr(struct ether_addr *mac_addr, int read_opt);
 char *get_name_by_macstr(char *mac_str, int read_opt);
 int read_file(char *dir, char *path, int read_opt);
-int write_file(char *dir, char *path, char *value);
+int write_file(char *dir, char *fname, char *arg1, char *arg2);
 int check_proc_dir(char *dir);
 
 extern char *line_ptr;
diff --git a/batctl/main.c b/batctl/main.c
index e0b7f55..a07e75b 100644
--- a/batctl/main.c
+++ b/batctl/main.c
@@ -47,10 +47,10 @@ void print_usage(void) {
 	printf(" \tloglevel|ll    [level]           \tdisplay or modify the log level\n");
 	printf(" \tlog|l                            \tread the log produced by the kernel module\n");
 	printf(" \tgw_mode|gw     [mode]            \tdisplay or modify the gateway mode\n");
-	printf(" \tgw_srv_list|gwl                  \tdisplay the gateway server list\n");
+	printf(" \tgateways|gwl                     \tdisplay the gateway server list\n");
 	printf(" \ttranslocal|tl                    \tdisplay the local translation table\n");
 	printf(" \ttransglobal|tg                   \tdisplay the global translation table\n");
-	printf(" \tvis_server|vs  [enable|disable]  \tdisplay or modify the status of the VIS server\n");
+	printf(" \tvis_mode|vm    [mode]            \tdisplay or modify the status of the VIS server\n");
 	printf(" \tvis_data|vd    [dot|JSON]        \tdisplay the VIS data in dot or JSON format\n");
 	printf(" \taggregation|ag [0|1]             \tdisplay or modify the packet aggregation setting\n");
 	printf(" \tbonding|b      [0|1]             \tdisplay or modify the bonding mode setting\n");
@@ -125,9 +125,9 @@ int main(int argc, char **argv)
 
 		ret = handle_proc_setting(argc - 1, argv + 1, PROC_ORIG_INTERVAL, orig_interval_usage);
 
-	} else if ((strcmp(argv[1], "vis_server") == 0) || (strcmp(argv[1], "vs") == 0)) {
+	} else if ((strcmp(argv[1], "vis_mode") == 0) || (strcmp(argv[1], "vm") == 0)) {
 
-		ret = handle_proc_setting(argc - 1, argv + 1, PROC_VIS_SERVER, vis_server_usage);
+		ret = handle_sys_setting(argc - 1, argv + 1, SYS_VIS_MODE, vis_mode_usage);
 
 	} else if ((strcmp(argv[1], "vis_data") == 0) || (strcmp(argv[1], "vd") == 0)) {
 
@@ -135,11 +135,11 @@ int main(int argc, char **argv)
 
 	} else if ((strcmp(argv[1], "gw_mode") == 0) || (strcmp(argv[1], "gw") == 0)) {
 
-		ret = handle_proc_setting(argc - 1, argv + 1, PROC_GW_MODE, gw_mode_usage);
+		ret = handle_sys_setting(argc - 1, argv + 1, SYS_GW_MODE, gw_mode_usage);
 
-	} else if ((strcmp(argv[1], "gw_srv_list") == 0) || (strcmp(argv[1], "gwl") == 0)) {
+	} else if ((strcmp(argv[1], "gateways") == 0) || (strcmp(argv[1], "gwl") == 0)) {
 
-		ret = handle_table(argc - 1, argv + 1, PROC_GW_SRV_LIST, gw_srv_list_usage);
+		ret = handle_sys_table(argc - 1, argv + 1, SYS_GATEWAYS, gateways_usage);
 
 	} else if ((strcmp(argv[1], "aggregation") == 0) || (strcmp(argv[1], "ag") == 0)) {
 
diff --git a/batctl/proc.c b/batctl/proc.c
index e323a52..9f5c24f 100644
--- a/batctl/proc.c
+++ b/batctl/proc.c
@@ -57,9 +57,9 @@ int interface(int argc, char **argv)
 
 	for (i = 1; i < argc; i++) {
 		if (strcmp(argv[i], "none") == 0)
-			res = write_file(PROC_ROOT_PATH, PROC_INTERFACES, "");
+			res = write_file(PROC_ROOT_PATH, PROC_INTERFACES, "", NULL);
 		else
-			res = write_file(PROC_ROOT_PATH, PROC_INTERFACES, argv[i]);
+			res = write_file(PROC_ROOT_PATH, PROC_INTERFACES, argv[i], NULL);
 
 		if (res != EXIT_SUCCESS)
 			return res;
@@ -68,15 +68,6 @@ int interface(int argc, char **argv)
 	return EXIT_SUCCESS;
 }
 
-void gw_srv_list_usage(void)
-{
-	printf("Usage: batctl [options] gw_srv_list \n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w watch mode - refresh the gateway server list continuously\n");
-}
-
 void orig_interval_usage(void)
 {
 	printf("Usage: batctl [options] interval \n");
@@ -84,20 +75,6 @@ void orig_interval_usage(void)
 	printf(" \t -h print this help\n");
 }
 
-void vis_server_usage(void)
-{
-	printf("Usage: batctl [options] vis_server \n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-}
-
-void gw_mode_usage(void)
-{
-	printf("Usage: batctl [options] gw_mode [mode]\n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-}
-
 int handle_table(int argc, char **argv, char *file_path, void table_usage(void))
 {
 	int optchar, read_opt = USE_BAT_HOSTS;
@@ -140,5 +117,5 @@ int handle_proc_setting(int argc, char **argv, char *file_path, void setting_usa
 	if (argc == 1)
 		return read_file(PROC_ROOT_PATH, file_path, SINGLE_READ);
 
-	return write_file(PROC_ROOT_PATH, file_path, argv[1]);
+	return write_file(PROC_ROOT_PATH, file_path, argv[1], NULL);
 }
diff --git a/batctl/proc.h b/batctl/proc.h
index fba9a19..0b5a6f2 100644
--- a/batctl/proc.h
+++ b/batctl/proc.h
@@ -22,16 +22,9 @@
 #define PROC_ROOT_PATH "/proc/net/batman-adv/"
 #define PROC_INTERFACES "interfaces"
 #define PROC_ORIG_INTERVAL "orig_interval"
-#define PROC_VIS_SERVER "vis_server"
-#define PROC_VIS_DATA "vis_data"
-#define PROC_GW_MODE "gateway_mode"
-#define PROC_GW_SRV_LIST "gateway_srv_list"
 
 int interface(int argc, char **argv);
 
 void orig_interval_usage(void);
-void vis_server_usage(void);
-void gw_mode_usage(void);
-void gw_srv_list_usage(void);
 int handle_table(int argc, char **argv, char *file_path, void table_usage(void));
 int handle_proc_setting(int argc, char **argv, char *file_path, void setting_usage(void));
diff --git a/batctl/sys.c b/batctl/sys.c
index 5b4a9fa..7d035d6 100644
--- a/batctl/sys.c
+++ b/batctl/sys.c
@@ -73,7 +73,7 @@ int log_print(int argc, char **argv)
 
 static void log_level_usage(void)
 {
-	printf("Usage: batctl [options] loglevel \n");
+	printf("Usage: batctl [options] loglevel [level]\n");
 	printf("options:\n");
 	printf(" \t -h print this help\n");
 }
@@ -94,7 +94,7 @@ int handle_loglevel(int argc, char **argv)
 	}
 
 	if (argc != 1) {
-		res = write_file(SYS_MODULE_PATH, SYS_LOG_LEVEL, argv[1]);
+		res = write_file(SYS_MODULE_PATH, SYS_LOG_LEVEL, argv[1], NULL);
 		goto out;
 	}
 
@@ -146,6 +146,15 @@ void trans_global_usage(void)
 	printf(" \t -w watch mode - refresh the global translation table continuously\n");
 }
 
+void gateways_usage(void)
+{
+	printf("Usage: batctl [options] gateways \n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+	printf(" \t -n don't replace mac addresses with bat-host names\n");
+	printf(" \t -w watch mode - refresh the gateway server list continuously\n");
+}
+
 int handle_sys_table(int argc, char **argv, char *file_path, void table_usage(void))
 {
 	int optchar, read_opt = USE_BAT_HOSTS;
@@ -172,14 +181,28 @@ int handle_sys_table(int argc, char **argv, char *file_path, void table_usage(vo
 
 void aggregation_usage(void)
 {
-	printf("Usage: batctl [options] aggregation \n");
+	printf("Usage: batctl [options] aggregation [0|1]\n");
 	printf("options:\n");
 	printf(" \t -h print this help\n");
 }
 
 void bonding_usage(void)
 {
-	printf("Usage: batctl [options] bonding \n");
+	printf("Usage: batctl [options] bonding [0|1]\n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+}
+
+void gw_mode_usage(void)
+{
+	printf("Usage: batctl [options] gw_mode [mode]\n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+}
+
+void vis_mode_usage(void)
+{
+	printf("Usage: batctl [options] vis_mode [mode]\n");
 	printf("options:\n");
 	printf(" \t -h print this help\n");
 }
@@ -240,5 +263,5 @@ next:
 	return EXIT_FAILURE;
 
 write_file:
-	return write_file(SYS_BATIF_PATH, file_path, argv[1]);
+	return write_file(SYS_BATIF_PATH, file_path, argv[1], argc > 2 ? argv[2] : NULL);
 }
diff --git a/batctl/sys.h b/batctl/sys.h
index 3560f98..4f10cee 100644
--- a/batctl/sys.h
+++ b/batctl/sys.h
@@ -29,12 +29,19 @@
 #define SYS_TRANSTABLE_GLOBAL "transtable_global"
 #define SYS_AGGR "aggregate_ogm"
 #define SYS_BONDING "bonding"
+#define SYS_GW_MODE "gw_mode"
+#define SYS_GATEWAYS "gateways"
+#define SYS_VIS_MODE "vis_mode"
+#define SYS_VIS_DATA "vis_data"
 
 void originators_usage(void);
 void trans_local_usage(void);
 void trans_global_usage(void);
 void aggregation_usage(void);
 void bonding_usage(void);
+void gw_mode_usage(void);
+void gateways_usage(void);
+void vis_mode_usage(void);
 int log_print(int argc, char **argv);
 int handle_loglevel(int argc, char **argv);
 int handle_sys_table(int argc, char **argv, char *file_path, void table_usage(void));
diff --git a/batctl/vis.c b/batctl/vis.c
index 58a68b7..bf7fa6c 100644
--- a/batctl/vis.c
+++ b/batctl/vis.c
@@ -29,7 +29,7 @@
 #include "vis.h"
 #include "functions.h"
 #include "bat-hosts.h"
-#include "proc.h"
+#include "sys.h"
 
 #define TQ_MAX_VALUE 255
 
@@ -168,9 +168,9 @@ static FILE *open_vis(void)
 	if (check_proc_dir("/proc") != EXIT_SUCCESS)
 		return NULL;
 
-	strncpy(full_path, PROC_ROOT_PATH, strlen(PROC_ROOT_PATH));
-	full_path[strlen(PROC_ROOT_PATH)] = '\0';
-	strncat(full_path, PROC_VIS_DATA,
+	strncpy(full_path, SYS_BATIF_PATH, strlen(SYS_BATIF_PATH));
+	full_path[strlen(SYS_BATIF_PATH)] = '\0';
+	strncat(full_path, SYS_VIS_DATA,
 		sizeof(full_path) - strlen(full_path));
 
 	return fopen(full_path, "r");
-- 
1.7.0

