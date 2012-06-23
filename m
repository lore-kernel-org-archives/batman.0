Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 23 Jun 2012 18:40:10 +0200
Message-Id: <1340469612-6543-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batctl: unify debug table handling and
	remove redundant code
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
 debug.c |  111 +++++++++++++++++++++++++++++----------------------------------
 debug.h |   27 +++++++++++----
 main.c  |   74 +++++++++++++++++-------------------------
 main.h  |    5 +++
 4 files changed, 105 insertions(+), 112 deletions(-)

diff --git a/debug.c b/debug.c
index 5dca633..8aa36c2 100644
--- a/debug.c
+++ b/debug.c
@@ -33,64 +33,53 @@
 #include "debugfs.h"
 #include "functions.h"
 
-void originators_usage(void)
+const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
+	{
+		.opt_long = "originators",
+		.opt_short = "o",
+		.debugfs_name = "originators",
+	},
+	{
+		.opt_long = "gateways",
+		.opt_short = "gwl",
+		.debugfs_name = "gateways",
+	},
+	{
+		.opt_long = "translocal",
+		.opt_short = "tl",
+		.debugfs_name = "transtable_local",
+	},
+	{
+		.opt_long = "transglobal",
+		.opt_short = "tg",
+		.debugfs_name = "transtable_global",
+	},
+	{
+		.opt_long = "claimtable",
+		.opt_short = "cl",
+		.debugfs_name = "bla_claim_table",
+	},
+	{
+		.opt_long = "backbonetable",
+		.opt_short = "bbt",
+		.debugfs_name = "bla_backbone_table",
+	},
+};
+
+void debug_table_usage(int debug_table)
 {
-	printf("Usage: batctl [options] originators \n");
+	printf("Usage: batctl [options] %s|%s\n",
+	       batctl_debug_tables[debug_table].opt_long, batctl_debug_tables[debug_table].opt_short);
 	printf("options:\n");
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w [interval] watch mode - refresh the originator table continuously\n");
-	printf(" \t -t timeout interval - don't print originators not seen for x.y seconds \n");
-}
-
-void trans_local_usage(void)
-{
-	printf("Usage: batctl [options] translocal \n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w [interval] watch mode - refresh the local translation table continuously\n");
-}
-
-void trans_global_usage(void)
-{
-	printf("Usage: batctl [options] transglobal \n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w [interval] watch mode - refresh the global translation table continuously\n");
-}
-
-void bla_claim_table_usage(void)
-{
-	printf("Usage: batctl [options] claimtable \n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w [interval] watch mode - refresh the bridge loop avoidance claim table continuously\n");
-}
+	printf(" \t -w [interval] watch mode - refresh the table continuously\n");
 
-void bla_backbone_table_usage(void)
-{
-	printf("Usage: batctl [options] backbone table\n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w [interval] watch mode - refresh the bridge loop avoidance backbone table continuously\n");
-}
-
-
-void gateways_usage(void)
-{
-	printf("Usage: batctl [options] gateways \n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-	printf(" \t -n don't replace mac addresses with bat-host names\n");
-	printf(" \t -w [interval] watch mode - refresh the gateway server list continuously\n");
+	if (debug_table == BATCTL_TABLE_ORIGINATORS)
+		printf(" \t -t timeout interval - don't print originators not seen for x.y seconds \n");
 }
 
-int handle_debug_table(char *mesh_iface, int argc, char **argv,
-		       char *file_path, void table_usage(void))
+int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 {
 	int optchar, read_opt = USE_BAT_HOSTS;
 	char full_path[MAX_PATH+1];
@@ -102,7 +91,7 @@ int handle_debug_table(char *mesh_iface, int argc, char **argv,
 	while ((optchar = getopt(argc, argv, "hnw:t:")) != -1) {
 		switch (optchar) {
 		case 'h':
-			table_usage();
+			debug_table_usage(debug_table);
 			return EXIT_SUCCESS;
 		case 'n':
 			read_opt &= ~USE_BAT_HOSTS;
@@ -115,36 +104,37 @@ int handle_debug_table(char *mesh_iface, int argc, char **argv,
 			}
 
 			if (!sscanf(optarg, "%f", &watch_interval)) {
-				printf("Error - provided argument of -w is not a number\n");
+				printf("Error - provided argument of '-%c' is not a number\n", optchar);
 				return EXIT_FAILURE;
 			}
 			break;
 		case 't':
-			if (table_usage != originators_usage) {
-				table_usage();
+			if (debug_table != BATCTL_TABLE_ORIGINATORS) {
+				printf("Error - unrecognised option '-%c'\n", optchar);
+				debug_table_usage(debug_table);
 				return EXIT_FAILURE;
 			}
 
 			read_opt |= NO_OLD_ORIGS;
 			if (!sscanf(optarg, "%f", &orig_timeout)) {
-				printf("Error - provided argument of -t is not a number\n");
+				printf("Error - provided argument of '-%c' is not a number\n", optchar);
 				return EXIT_FAILURE;
 			}
 			break;
 		case '?':
 			if (optopt == 't')
-				printf("Error - argument -t needs a number\n");
+				printf("Error - option '-t' needs a number as argument\n");
 
 			else if (optopt == 'w') {
 				read_opt |= CLR_CONT_READ;
 				break;
 			}
 			else
-				printf("Error - unrecognised option -%c\n", optopt);
+				printf("Error - unrecognised option: '-%c'\n", optopt);
 
 			return EXIT_FAILURE;
 		default:
-			table_usage();
+			debug_table_usage(debug_table);
 			return EXIT_FAILURE;
 		}
 	}
@@ -156,7 +146,8 @@ int handle_debug_table(char *mesh_iface, int argc, char **argv,
 	}
 
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
-	return read_file(full_path, file_path, read_opt, orig_timeout, watch_interval);
+	return read_file(full_path, (char *)batctl_debug_tables[debug_table].debugfs_name,
+			 read_opt, orig_timeout, watch_interval);
 }
 
 static void log_usage(void)
diff --git a/debug.h b/debug.h
index 2c6d24c..36badf7 100644
--- a/debug.h
+++ b/debug.h
@@ -21,21 +21,32 @@
 
 
 #define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
-#define DEBUG_ORIGINATORS "originators"
-#define DEBUG_TRANSTABLE_LOCAL "transtable_local"
-#define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
-#define DEBUG_BLA_CLAIM_TABLE "bla_claim_table"
-#define DEBUG_BLA_BACKBONE_TABLE "bla_backbone_table"
-#define DEBUG_GATEWAYS "gateways"
 #define DEBUG_VIS_DATA "vis_data"
 #define DEBUG_LOG "log"
 
+enum batctl_debug_tables {
+	BATCTL_TABLE_ORIGINATORS,
+	BATCTL_TABLE_GATEWAYS,
+	BATCTL_TABLE_TRANSLOCAL,
+	BATCTL_TABLE_TRANSGLOBAL,
+	BATCTL_TABLE_BLA_CLAIMS,
+	BATCTL_TABLE_BLA_BACKBONES,
+	BATCTL_TABLE_NUM,
+};
+
+struct debug_table_data {
+       const char opt_long[OPT_LONG_MAX_LEN];
+       const char opt_short[OPT_SHORT_MAX_LEN];
+       const char debugfs_name[DEBUG_TABLE_PATH_MAX_LEN];
+};
+
+extern const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM];
+
 void originators_usage(void);
 void trans_local_usage(void);
 void trans_global_usage(void);
 void bla_claim_table_usage(void);
 void bla_backbone_table_usage(void);
 void gateways_usage(void);
-int handle_debug_table(char *mesh_iface, int argc, char **argv,
-		       char *file_path, void table_usage(void));
+int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv);
 int log_print(char *mesh_iface, int argc, char **argv);
diff --git a/main.c b/main.c
index 929b762..1482dbe 100644
--- a/main.c
+++ b/main.c
@@ -43,20 +43,23 @@
 char mesh_dfl_iface[] = "bat0";
 char module_ver_path[] = "/sys/module/batman_adv/version";
 
-void print_usage(void) {
-	printf("Usage: batctl [options] commands \n");
+void print_usage(void)
+{
+	int i;
+
+	printf("Usage: batctl [options] command|debug table \n");
+	printf("options:\n");
+	printf(" \t-m mesh interface (default 'bat0')\n");
+	printf(" \t-h print this help (or 'batctl <command|debug table> -h' for the specific help)\n");
+	printf(" \t-v print version\n");
+	printf("\n");
+
 	printf("commands:\n");
 	printf(" \tinterface|if               [add|del iface(s)]\tdisplay or modify the interface settings\n");
-	printf(" \toriginators|o                                \tdisplay the originator table\n");
 	printf(" \tinterval|it                [orig_interval]   \tdisplay or modify the originator interval (in ms)\n");
 	printf(" \tloglevel|ll                [level]           \tdisplay or modify the log level\n");
 	printf(" \tlog|l                                        \tread the log produced by the kernel module\n");
 	printf(" \tgw_mode|gw                 [mode]            \tdisplay or modify the gateway mode\n");
-	printf(" \tgateways|gwl                                 \tdisplay the gateway server list\n");
-	printf(" \ttranslocal|tl                                \tdisplay the local translation table\n");
-	printf(" \ttransglobal|tg                               \tdisplay the global translation table\n");
-	printf(" \tclaimtable|cl                                \tdisplay the bridge loop avoidance claim table\n");
-	printf(" \tbackbonetable|bbl                            \tdisplay the bridge loop avoidance backbone table\n");
 	printf(" \tvis_mode|vm                [mode]            \tdisplay or modify the status of the VIS server\n");
 	printf(" \tvis_data|vd                [dot|JSON]        \tdisplay the VIS data in dot or JSON format\n");
 	printf(" \taggregation|ag             [0|1]             \tdisplay or modify the packet aggregation setting\n");
@@ -65,20 +68,22 @@ void print_usage(void) {
 	printf(" \tfragmentation|f            [0|1]             \tdisplay or modify the fragmentation mode setting\n");
 	printf(" \tap_isolation|ap            [0|1]             \tdisplay or modify the ap isolation mode setting\n");
 	printf("\n");
+
+	printf("debug tables:                                   \tdisplay the corresponding debug table\n");
+	for (i = 0; i < BATCTL_TABLE_NUM; i++)
+		printf(" \t%s|%s\n", batctl_debug_tables[i].opt_long, batctl_debug_tables[i].opt_short);
+
+	printf("\n");
 	printf(" \tstatistics|s                                 \tprint mesh statistics\n");
 	printf(" \tping|p                     <destination>     \tping another batman adv host via layer 2\n");
 	printf(" \ttraceroute|tr              <destination>     \ttraceroute another batman adv host via layer 2\n");
 	printf(" \ttcpdump|td                 <interface>       \ttcpdump layer 2 traffic on the given interface\n");
 	printf(" \tbisect                     <file1> .. <fileN>\tanalyze given log files for routing stability\n");
-	printf("options:\n");
-	printf(" \t-m mesh interface (default 'bat0')\n");
-	printf(" \t-h print this help (or 'batctl <command> -h' for the command specific help)\n");
-	printf(" \t-v print version\n");
 }
 
 int main(int argc, char **argv)
 {
-	int ret = EXIT_FAILURE;
+	int i, ret = EXIT_FAILURE;
 	char *mesh_iface = mesh_dfl_iface;
 
 	if ((argc > 1) && (strcmp(argv[1], "-m") == 0)) {
@@ -140,31 +145,6 @@ int main(int argc, char **argv)
 
 		ret = interface(mesh_iface, argc - 1, argv + 1);
 
-	} else if ((strcmp(argv[1], "originators") == 0) || (strcmp(argv[1], "o") == 0)) {
-
-		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
-					 DEBUG_ORIGINATORS, originators_usage);
-
-	} else if ((strcmp(argv[1], "translocal") == 0) || (strcmp(argv[1], "tl") == 0)) {
-
-		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
-					 DEBUG_TRANSTABLE_LOCAL, trans_local_usage);
-
-	} else if ((strcmp(argv[1], "transglobal") == 0) || (strcmp(argv[1], "tg") == 0)) {
-
-		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
-					 DEBUG_TRANSTABLE_GLOBAL, trans_global_usage);
-
-	} else if ((strcmp(argv[1], "claimtable") == 0) || (strcmp(argv[1], "cl") == 0)) {
-
-		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
-					 DEBUG_BLA_CLAIM_TABLE, bla_claim_table_usage);
-	} else if ((strcmp(argv[1], "backbonetable") == 0) || (strcmp(argv[1], "bbl") == 0)) {
-
-		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
-					 DEBUG_BLA_BACKBONE_TABLE,
-					 bla_backbone_table_usage);
-
 	} else if ((strcmp(argv[1], "loglevel") == 0) || (strcmp(argv[1], "ll") == 0)) {
 
 		ret = handle_loglevel(mesh_iface, argc - 1, argv + 1);
@@ -191,11 +171,6 @@ int main(int argc, char **argv)
 
 		ret = handle_gw_setting(mesh_iface, argc - 1, argv + 1);
 
-	} else if ((strcmp(argv[1], "gateways") == 0) || (strcmp(argv[1], "gwl") == 0)) {
-
-		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
-					 DEBUG_GATEWAYS, gateways_usage);
-
 	} else if ((strcmp(argv[1], "aggregation") == 0) || (strcmp(argv[1], "ag") == 0)) {
 
 		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
@@ -230,10 +205,21 @@ int main(int argc, char **argv)
 		ret = bisect(argc - 1, argv + 1);
 
 	} else {
-		printf("Error - no command specified\n");
+
+		for (i = 0; i < BATCTL_TABLE_NUM; i++) {
+			if ((strcmp(argv[1], batctl_debug_tables[i].opt_long) != 0) &&
+			    (strcmp(argv[1], batctl_debug_tables[i].opt_short) != 0))
+				continue;
+
+			ret = handle_debug_table(mesh_iface, i, argc - 1, argv + 1);
+			goto out;
+		}
+
+		printf("Error - no valid command or debug table specified: %s\n", argv[1]);
 		print_usage();
 	}
 
+out:
 	return ret;
 
 err:
diff --git a/main.h b/main.h
index 4819cf4..782ffde 100644
--- a/main.h
+++ b/main.h
@@ -27,6 +27,11 @@
 
 #define EXIT_NOSUCCESS 2
 
+#define OPT_LONG_MAX_LEN 25
+#define OPT_SHORT_MAX_LEN 5
+
+#define DEBUG_TABLE_PATH_MAX_LEN 20
+
 #define __packed __attribute((packed))   /* linux kernel compat */
 
 extern char module_ver_path[];
-- 
1.7.9.1

