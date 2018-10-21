Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:55:02 +0200
Message-Id: <20181021225524.8155-17-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 16/38] batctl: Convert debug table to command
 infrastructure
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

Most of the commands were already converted to the new command
infrastructure. To use the new state and pre-initialization steps, the
debugfs tables also have to be converted.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debug.c     | 228 +++++++++++++++++++++++++++++-----------------------
 debug.h     |  35 +++-----
 functions.c |  10 +--
 main.c      |  19 +----
 main.h      |   2 +-
 5 files changed, 150 insertions(+), 144 deletions(-)

diff --git a/debug.c b/debug.c
index 9bc4d0c..016b148 100644
--- a/debug.c
+++ b/debug.c
@@ -32,101 +32,34 @@
 #include "netlink.h"
 #include "sys.h"
 
-const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
-	{
-		.opt_long = "neighbors",
-		.opt_short = "n",
-		.debugfs_name = "neighbors",
-		.header_lines = 2,
-		.netlink_fn = netlink_print_neighbors,
-	},
-	{
-		.opt_long = "originators",
-		.opt_short = "o",
-		.debugfs_name = "originators",
-		.header_lines = 2,
-		.netlink_fn = netlink_print_originators,
-	},
-	{
-		.opt_long = "gateways",
-		.opt_short = "gwl",
-		.debugfs_name = "gateways",
-		.header_lines = 1,
-		.netlink_fn = netlink_print_gateways,
-	},
-	{
-		.opt_long = "translocal",
-		.opt_short = "tl",
-		.debugfs_name = "transtable_local",
-		.header_lines = 2,
-		.netlink_fn = netlink_print_translocal,
-	},
-	{
-		.opt_long = "transglobal",
-		.opt_short = "tg",
-		.debugfs_name = "transtable_global",
-		.header_lines = 2,
-		.netlink_fn = netlink_print_transglobal,
-	},
-	{
-		.opt_long = "claimtable",
-		.opt_short = "cl",
-		.debugfs_name = "bla_claim_table",
-		.header_lines = 2,
-		.netlink_fn = netlink_print_bla_claim,
-	},
-	{
-		.opt_long = "backbonetable",
-		.opt_short = "bbt",
-		.debugfs_name = "bla_backbone_table",
-		.header_lines = 2,
-		.netlink_fn = netlink_print_bla_backbone,
-	},
-	{
-		.opt_long = "dat_cache",
-		.opt_short = "dc",
-		.debugfs_name = "dat_cache",
-		.header_lines = 2,
-		.netlink_fn = netlink_print_dat_cache,
-	},
-	{
-		.opt_long = "nc_nodes",
-		.opt_short = "nn",
-		.debugfs_name = "nc_nodes",
-		.header_lines = 0,
-	},
-	{
-		.opt_long = "mcast_flags",
-		.opt_short = "mf",
-		.debugfs_name = "mcast_flags",
-		.header_lines = 6,
-		.netlink_fn = netlink_print_mcast_flags,
-	},
-};
-
-static void debug_table_usage(int debug_table)
+static void debug_table_usage(struct state *state)
 {
+	struct debug_table_data *debug_table = state->cmd->arg;
+
 	fprintf(stderr, "Usage: batctl [options] %s|%s [parameters]\n",
-	       batctl_debug_tables[debug_table].opt_long, batctl_debug_tables[debug_table].opt_short);
+		state->cmd->name, state->cmd->abbr);
 	fprintf(stderr, "parameters:\n");
 	fprintf(stderr, " \t -h print this help\n");
 	fprintf(stderr, " \t -n don't replace mac addresses with bat-host names\n");
 	fprintf(stderr, " \t -H don't show the header\n");
 	fprintf(stderr, " \t -w [interval] watch mode - refresh the table continuously\n");
 
-	if (debug_table == BATCTL_TABLE_ORIGINATORS) {
+	if (debug_table->option_watch_interval)
 		fprintf(stderr, " \t -t timeout interval - don't print originators not seen for x.y seconds \n");
+
+	if (debug_table->option_orig_iface)
 		fprintf(stderr, " \t -i [interface] - show multiif originator table for a specific interface\n");
-	}
 
-	if (debug_table == BATCTL_TABLE_TRANSLOCAL ||
-	    debug_table == BATCTL_TABLE_TRANSGLOBAL) {
-		fprintf(stderr, " \t -u|-m print unicast or multicast mac addresses only\n");
-	}
+	if (debug_table->option_unicast_only)
+		fprintf(stderr, " \t -u print unicast mac addresses only\n");
+
+	if (debug_table->option_multicast_only)
+		fprintf(stderr, " \t -m print multicast mac addresses only\n");
 }
 
-int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
+int handle_debug_table(struct state *state, int argc, char **argv)
 {
+	struct debug_table_data *debug_table = state->cmd->arg;
 	int optchar, read_opt = USE_BAT_HOSTS;
 	char full_path[MAX_PATH+1];
 	char *debugfs_mnt;
@@ -138,7 +71,7 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 	while ((optchar = getopt(argc, argv, "hnw:t:Humi:")) != -1) {
 		switch (optchar) {
 		case 'h':
-			debug_table_usage(debug_table);
+			debug_table_usage(state);
 			return EXIT_SUCCESS;
 		case 'n':
 			read_opt &= ~USE_BAT_HOSTS;
@@ -156,9 +89,9 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 			}
 			break;
 		case 't':
-			if (debug_table != BATCTL_TABLE_ORIGINATORS) {
+			if (debug_table->option_watch_interval) {
 				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
-				debug_table_usage(debug_table);
+				debug_table_usage(state);
 				return EXIT_FAILURE;
 			}
 
@@ -172,33 +105,31 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 			read_opt |= SKIP_HEADER;
 			break;
 		case 'u':
-			if (debug_table != BATCTL_TABLE_TRANSLOCAL &&
-			    debug_table != BATCTL_TABLE_TRANSGLOBAL) {
+			if (debug_table->option_unicast_only) {
 				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
-				debug_table_usage(debug_table);
+				debug_table_usage(state);
 				return EXIT_FAILURE;
 			}
 
 			read_opt |= UNICAST_ONLY;
 			break;
 		case 'm':
-			if (debug_table != BATCTL_TABLE_TRANSLOCAL &&
-			    debug_table != BATCTL_TABLE_TRANSGLOBAL) {
+			if (debug_table->option_multicast_only) {
 				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
-				debug_table_usage(debug_table);
+				debug_table_usage(state);
 				return EXIT_FAILURE;
 			}
 
 			read_opt |= MULTICAST_ONLY;
 			break;
 		case 'i':
-			if (debug_table != BATCTL_TABLE_ORIGINATORS) {
+			if (debug_table->option_orig_iface) {
 				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
-				debug_table_usage(debug_table);
+				debug_table_usage(state);
 				return EXIT_FAILURE;
 			}
 
-			if (check_mesh_iface_ownership(mesh_iface, optarg) != EXIT_SUCCESS)
+			if (check_mesh_iface_ownership(state->mesh_iface, optarg) != EXIT_SUCCESS)
 				return EXIT_FAILURE;
 
 			orig_iface = optarg;
@@ -217,7 +148,7 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 
 			return EXIT_FAILURE;
 		default:
-			debug_table_usage(debug_table);
+			debug_table_usage(state);
 			return EXIT_FAILURE;
 		}
 	}
@@ -226,7 +157,7 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 
 	if (read_opt & UNICAST_ONLY && read_opt & MULTICAST_ONLY) {
 		fprintf(stderr, "Error - '-u' and '-m' are exclusive options\n");
-		debug_table_usage(debug_table);
+		debug_table_usage(state);
 		return EXIT_FAILURE;
 	}
 
@@ -236,9 +167,9 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	if (batctl_debug_tables[debug_table].netlink_fn) {
-		err = batctl_debug_tables[debug_table].netlink_fn(
-			mesh_iface, orig_iface, read_opt, orig_timeout,
+	if (debug_table->netlink_fn) {
+		err = debug_table->netlink_fn(
+			state->mesh_iface, orig_iface, read_opt, orig_timeout,
 			watch_interval);
 		if (err != -EOPNOTSUPP)
 			return err;
@@ -247,11 +178,11 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 	if (orig_iface)
 		debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", orig_iface, full_path, sizeof(full_path));
 	else
-		debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
+		debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", state->mesh_iface, full_path, sizeof(full_path));
 
-	return read_file(full_path, (char *)batctl_debug_tables[debug_table].debugfs_name,
+	return read_file(full_path, debug_table->debugfs_name,
 			 read_opt, orig_timeout, watch_interval,
-			 batctl_debug_tables[debug_table].header_lines);
+			 debug_table->header_lines);
 }
 
 int debug_print_routing_algos(void)
@@ -268,3 +199,98 @@ int debug_print_routing_algos(void)
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT, "", full_path, sizeof(full_path));
 	return read_file(full_path, DEBUG_ROUTING_ALGOS, 0, 0, 0, 0);
 }
+
+static struct debug_table_data batctl_debug_table_neighbors = {
+	.debugfs_name = "neighbors",
+	.header_lines = 2,
+	.netlink_fn = netlink_print_neighbors,
+};
+
+COMMAND_NAMED(DEBUGTABLE, neighbors, "n", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_neighbors, "");
+
+static struct debug_table_data batctl_debug_table_originators = {
+	.debugfs_name = "originators",
+	.header_lines = 2,
+	.netlink_fn = netlink_print_originators,
+	.option_watch_interval = 1,
+	.option_orig_iface = 1,
+};
+
+COMMAND_NAMED(DEBUGTABLE, originators, "o", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_originators, "");
+
+static struct debug_table_data batctl_debug_table_gateways = {
+	.debugfs_name = "gateways",
+	.header_lines = 1,
+	.netlink_fn = netlink_print_gateways,
+};
+
+COMMAND_NAMED(DEBUGTABLE, gateways, "gwl", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_gateways, "");
+
+static struct debug_table_data batctl_debug_table_translocal = {
+	.debugfs_name = "transtable_local",
+	.header_lines = 2,
+	.netlink_fn = netlink_print_translocal,
+	.option_unicast_only = 1,
+	.option_multicast_only = 1,
+};
+
+COMMAND_NAMED(DEBUGTABLE, translocal, "tl", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_translocal, "");
+
+static struct debug_table_data batctl_debug_table_transglobal = {
+	.debugfs_name = "transtable_global",
+	.header_lines = 2,
+	.netlink_fn = netlink_print_transglobal,
+	.option_unicast_only = 1,
+	.option_multicast_only = 1,
+};
+
+COMMAND_NAMED(DEBUGTABLE, transglobal, "tg", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_transglobal, "");
+
+static struct debug_table_data batctl_debug_table_claimtable = {
+	.debugfs_name = DEBUG_CLAIMTABLE,
+	.header_lines = 2,
+	.netlink_fn = netlink_print_bla_claim,
+};
+
+COMMAND_NAMED(DEBUGTABLE, claimtable, "cl", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_claimtable, "");
+
+static struct debug_table_data batctl_debug_table_backbonetable = {
+	.debugfs_name = DEBUG_BACKBONETABLE,
+	.header_lines = 2,
+	.netlink_fn = netlink_print_bla_backbone,
+};
+
+COMMAND_NAMED(DEBUGTABLE, backbonetable, "bbt", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_backbonetable, "");
+
+static struct debug_table_data batctl_debug_table_dat_cache = {
+	.debugfs_name = DEBUG_DAT_CACHE,
+	.header_lines = 2,
+	.netlink_fn = netlink_print_dat_cache,
+};
+
+COMMAND_NAMED(DEBUGTABLE, dat_cache, "dc", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_dat_cache, "");
+
+static struct debug_table_data batctl_debug_table_nc_nodes = {
+	.debugfs_name = DEBUG_NC_NODES,
+	.header_lines = 0,
+};
+
+COMMAND_NAMED(DEBUGTABLE, nc_nodes, "nn", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_nc_nodes, "");
+
+static struct debug_table_data batctl_debug_table_mcast_flags = {
+	.debugfs_name = DEBUG_MCAST_FLAGS,
+	.header_lines = 6,
+	.netlink_fn = netlink_print_mcast_flags,
+};
+
+COMMAND_NAMED(DEBUGTABLE, mcast_flags, "mf", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_mcast_flags, "");
diff --git a/debug.h b/debug.h
index d9a2e3a..79c489a 100644
--- a/debug.h
+++ b/debug.h
@@ -28,35 +28,26 @@
 
 #define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
 #define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
+#define DEBUG_BACKBONETABLE "bla_backbone_table"
+#define DEBUG_CLAIMTABLE "bla_claim_table"
+#define DEBUG_DAT_CACHE "dat_cache"
+#define DEBUG_NC_NODES "nc_nodes"
+#define DEBUG_MCAST_FLAGS "mcast_flags"
 #define DEBUG_LOG "log"
 #define DEBUG_ROUTING_ALGOS "routing_algos"
 
-enum batctl_debug_tables {
-	BATCTL_TABLE_NEIGHBORS,
-	BATCTL_TABLE_ORIGINATORS,
-	BATCTL_TABLE_GATEWAYS,
-	BATCTL_TABLE_TRANSLOCAL,
-	BATCTL_TABLE_TRANSGLOBAL,
-	BATCTL_TABLE_BLA_CLAIMS,
-	BATCTL_TABLE_BLA_BACKBONES,
-	BATCTL_TABLE_DAT,
-	BATCTL_TABLE_NETWORK_CODING_NODES,
-	BATCTL_TABLE_MCAST_FLAGS,
-	BATCTL_TABLE_NUM,
-};
-
 struct debug_table_data {
-       const char opt_long[OPT_LONG_MAX_LEN];
-       const char opt_short[OPT_SHORT_MAX_LEN];
-       const char debugfs_name[DEBUG_TABLE_PATH_MAX_LEN];
-       size_t header_lines;
-       int (*netlink_fn)(char *mesh_iface, char *hard_iface, int read_opt,
+	const char *debugfs_name;
+	size_t header_lines;
+	int (*netlink_fn)(char *mesh_iface, char *hard_iface, int read_opt,
 			 float orig_timeout, float watch_interval);
+	unsigned int option_unicast_only:1;
+	unsigned int option_multicast_only:1;
+	unsigned int option_watch_interval:1;
+	unsigned int option_orig_iface:1;
 };
 
-extern const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM];
-
-int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv);
+int handle_debug_table(struct state *state, int argc, char **argv);
 int debug_print_routing_algos(void);
 
 #endif
diff --git a/functions.c b/functions.c
index e0e9978..faa9478 100644
--- a/functions.c
+++ b/functions.c
@@ -73,11 +73,11 @@ const char *fs_compile_out_param[] = {
 	batctl_settings[BATCTL_SETTINGS_DAT].sysfs_name,
 	batctl_settings[BATCTL_SETTINGS_NETWORK_CODING].sysfs_name,
 	batctl_settings[BATCTL_SETTINGS_MULTICAST_MODE].sysfs_name,
-	batctl_debug_tables[BATCTL_TABLE_BLA_CLAIMS].debugfs_name,
-	batctl_debug_tables[BATCTL_TABLE_BLA_BACKBONES].debugfs_name,
-	batctl_debug_tables[BATCTL_TABLE_DAT].debugfs_name,
-	batctl_debug_tables[BATCTL_TABLE_NETWORK_CODING_NODES].debugfs_name,
-	batctl_debug_tables[BATCTL_TABLE_MCAST_FLAGS].debugfs_name,
+	DEBUG_DAT_CACHE,
+	DEBUG_BACKBONETABLE,
+	DEBUG_DAT_CACHE,
+	DEBUG_NC_NODES,
+	DEBUG_MCAST_FLAGS,
 	NULL,
 };
 
diff --git a/main.c b/main.c
index 251d753..f5920a4 100644
--- a/main.c
+++ b/main.c
@@ -43,6 +43,7 @@ static void print_usage(void)
 {
 	enum command_type type[] = {
 		SUBCOMMAND,
+		DEBUGTABLE,
 	};
 	const struct command **p;
 	int opt_indent;
@@ -63,6 +64,9 @@ static void print_usage(void)
 		case SUBCOMMAND:
 			fprintf(stderr, "commands:\n");
 			break;
+		case DEBUGTABLE:
+			fprintf(stderr, "debug tables:                                   \tdisplay the corresponding debug table\n");
+			break;
 		}
 
 		for (p = __start___command; p < __stop___command; p++) {
@@ -97,12 +101,6 @@ static void print_usage(void)
 			}
 		}
 	}
-
-	fprintf(stderr, "\n");
-
-	fprintf(stderr, "debug tables:                                   \tdisplay the corresponding debug table\n");
-	for (i = 0; i < BATCTL_TABLE_NUM; i++)
-		fprintf(stderr, " \t%s|%s\n", batctl_debug_tables[i].opt_long, batctl_debug_tables[i].opt_short);
 }
 
 static void version(void)
@@ -212,15 +210,6 @@ int main(int argc, char **argv)
 			goto out;
 		}
 
-		for (i = 0; i < BATCTL_TABLE_NUM; i++) {
-			if ((strcmp(argv[0], batctl_debug_tables[i].opt_long) != 0) &&
-			    (strcmp(argv[0], batctl_debug_tables[i].opt_short) != 0))
-				continue;
-
-			ret = handle_debug_table(state.mesh_iface, i, argc, argv);
-			goto out;
-		}
-
 		fprintf(stderr,
 			"Error - no valid command or debug table specified: %s\n",
 			argv[0]);
diff --git a/main.h b/main.h
index 052304c..5fa248c 100644
--- a/main.h
+++ b/main.h
@@ -34,7 +34,6 @@
 #define OPT_LONG_MAX_LEN 25
 #define OPT_SHORT_MAX_LEN 5
 
-#define DEBUG_TABLE_PATH_MAX_LEN 20
 #define SETTINGS_PATH_MAX_LEN 25
 
 #if BYTE_ORDER == BIG_ENDIAN
@@ -63,6 +62,7 @@ enum command_flags {
 
 enum command_type {
 	SUBCOMMAND,
+	DEBUGTABLE,
 };
 
 struct state {
-- 
2.19.1

