Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:20 +0200
Message-Id: <20181025162245.19389-18-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 17/42] batctl: Convert sysfs settings to
 command infrastructure
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
sysfs settings also have to be converted.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c |   8 +--
 main.c      |  67 ++++++----------------
 main.h      |   5 --
 sys.c       | 187 +++++++++++++++++++++++++++++++++---------------------------
 sys.h       |  25 ++------
 5 files changed, 130 insertions(+), 162 deletions(-)

diff --git a/functions.c b/functions.c
index faa9478..0a7b587 100644
--- a/functions.c
+++ b/functions.c
@@ -69,10 +69,10 @@ char *line_ptr = NULL;
 const char *fs_compile_out_param[] = {
 	SYS_LOG,
 	SYS_LOG_LEVEL,
-	batctl_settings[BATCTL_SETTINGS_BLA].sysfs_name,
-	batctl_settings[BATCTL_SETTINGS_DAT].sysfs_name,
-	batctl_settings[BATCTL_SETTINGS_NETWORK_CODING].sysfs_name,
-	batctl_settings[BATCTL_SETTINGS_MULTICAST_MODE].sysfs_name,
+	SYS_BLA,
+	SYS_DAT,
+	SYS_NETWORK_CODING,
+	SYS_MULTICAST_MODE,
 	DEBUG_DAT_CACHE,
 	DEBUG_BACKBONETABLE,
 	DEBUG_DAT_CACHE,
diff --git a/main.c b/main.c
index f5920a4..9fc6bfb 100644
--- a/main.c
+++ b/main.c
@@ -46,10 +46,8 @@ static void print_usage(void)
 		DEBUGTABLE,
 	};
 	const struct command **p;
-	int opt_indent;
 	char buf[32];
 	size_t i;
-	size_t j;
 
 	fprintf(stderr, "Usage: batctl [options] command|debug table [parameters]\n");
 	fprintf(stderr, "options:\n");
@@ -83,23 +81,6 @@ static void print_usage(void)
 
 			fprintf(stderr, " \t%-27s%s\n", buf, cmd->usage);
 		}
-
-		if (type[i] == SUBCOMMAND) {
-			for (j = 0; j < BATCTL_SETTINGS_NUM; j++) {
-				fprintf(stderr, " \t%s|%s", batctl_settings[j].opt_long, batctl_settings[j].opt_short);
-				opt_indent = strlen(batctl_settings[j].opt_long) + strlen(batctl_settings[j].opt_short);
-
-				if (batctl_settings[j].params == sysfs_param_enable)
-					fprintf(stderr, "%*s                display or modify %s setting\n",
-						31 - opt_indent, "[0|1]", batctl_settings[j].opt_long);
-				else if (batctl_settings[j].params == sysfs_param_server)
-					fprintf(stderr, "%*s      display or modify %s setting\n",
-						41 - opt_indent, "[client|server]", batctl_settings[j].opt_long);
-				else
-					fprintf(stderr, "                                display or modify %s setting\n",
-						batctl_settings[j].opt_long);
-			}
-		}
 	}
 }
 
@@ -142,12 +123,12 @@ static const struct command *find_command(const char *name)
 int main(int argc, char **argv)
 {
 	const struct command *cmd;
-	int i, ret = EXIT_FAILURE;
 	struct state state = {
 		.mesh_iface = mesh_dfl_iface,
 		.cmd = NULL,
 	};
 	int opt;
+	int ret;
 
 	while ((opt = getopt(argc, argv, "+hm:v")) != -1) {
 		switch (opt) {
@@ -181,42 +162,26 @@ int main(int argc, char **argv)
 	argc -= optind;
 	optind = 0;
 
-	if ((cmd = find_command(argv[0]))) {
-		state.cmd = cmd;
-
-		if (cmd->flags & COMMAND_FLAG_MESH_IFACE &&
-		    check_mesh_iface(state.mesh_iface) < 0) {
-			fprintf(stderr,
-				"Error - interface %s is not present or not a batman-adv interface\n",
-				state.mesh_iface);
-			exit(EXIT_FAILURE);
-		}
-
-		ret = cmd->handler(&state, argc, argv);
-	} else {
-		if (check_mesh_iface(state.mesh_iface) < 0) {
-			fprintf(stderr,
-				"Error - interface %s is not present or not a batman-adv interface\n",
-				state.mesh_iface);
-			exit(EXIT_FAILURE);
-		}
-
-		for (i = 0; i < BATCTL_SETTINGS_NUM; i++) {
-			if ((strcmp(argv[0], batctl_settings[i].opt_long) != 0) &&
-			    (strcmp(argv[0], batctl_settings[i].opt_short) != 0))
-				continue;
-
-			ret = handle_sys_setting(state.mesh_iface, i, argc, argv);
-			goto out;
-		}
-
+	cmd = find_command(argv[0]);
+	if (!cmd) {
 		fprintf(stderr,
 			"Error - no valid command or debug table specified: %s\n",
 			argv[0]);
-		print_usage();
+		goto err;
 	}
 
-out:
+	state.cmd = cmd;
+
+	if (cmd->flags & COMMAND_FLAG_MESH_IFACE &&
+	    check_mesh_iface(state.mesh_iface) < 0) {
+		fprintf(stderr,
+			"Error - interface %s is not present or not a batman-adv interface\n",
+			state.mesh_iface);
+		exit(EXIT_FAILURE);
+	}
+
+	ret = cmd->handler(&state, argc, argv);
+
 	return ret;
 
 err:
diff --git a/main.h b/main.h
index 5fa248c..8d91480 100644
--- a/main.h
+++ b/main.h
@@ -31,11 +31,6 @@
 
 #define EXIT_NOSUCCESS 2
 
-#define OPT_LONG_MAX_LEN 25
-#define OPT_SHORT_MAX_LEN 5
-
-#define SETTINGS_PATH_MAX_LEN 25
-
 #if BYTE_ORDER == BIG_ENDIAN
 #define __BIG_ENDIAN_BITFIELD
 #elif BYTE_ORDER == LITTLE_ENDIAN
diff --git a/sys.c b/sys.c
index 2cb288e..08b389e 100644
--- a/sys.c
+++ b/sys.c
@@ -54,87 +54,18 @@ const char *sysfs_param_server[] = {
 	NULL,
 };
 
-const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM] = {
-	{
-		.opt_long = "orig_interval",
-		.opt_short = "it",
-		.sysfs_name = "orig_interval",
-		.params = NULL,
-	},
-	{
-		.opt_long = "ap_isolation",
-		.opt_short = "ap",
-		.sysfs_name = "ap_isolation",
-		.params = sysfs_param_enable,
-	},
-	{
-		.opt_long = "bridge_loop_avoidance",
-		.opt_short = "bl",
-		.sysfs_name = "bridge_loop_avoidance",
-		.params = sysfs_param_enable,
-	},
-	{
-		.opt_long = "distributed_arp_table",
-		.opt_short = "dat",
-		.sysfs_name = "distributed_arp_table",
-		.params = sysfs_param_enable,
-	},
-	{
-		.opt_long = "aggregation",
-		.opt_short = "ag",
-		.sysfs_name = "aggregated_ogms",
-		.params = sysfs_param_enable,
-	},
-	{
-		.opt_long = "bonding",
-		.opt_short = "b",
-		.sysfs_name = "bonding",
-		.params = sysfs_param_enable,
-	},
-	{
-		.opt_long = "fragmentation",
-		.opt_short = "f",
-		.sysfs_name = "fragmentation",
-		.params = sysfs_param_enable,
-	},
-	{
-		.opt_long = "network_coding",
-		.opt_short = "nc",
-		.sysfs_name = "network_coding",
-		.params = sysfs_param_enable,
-	},
-	{
-		.opt_long = "isolation_mark",
-		.opt_short = "mark",
-		.sysfs_name = "isolation_mark",
-		.params = NULL,
-	},
-	{
-		.opt_long = "multicast_mode",
-		.opt_short = "mm",
-		.sysfs_name = "multicast_mode",
-		.params = sysfs_param_enable,
-	},
-};
-
-static void settings_usage(int setting)
+static void settings_usage(struct state *state)
 {
-	fprintf(stderr, "Usage: batctl [options] %s|%s [parameters]",
-	       (char *)batctl_settings[setting].opt_long, (char *)batctl_settings[setting].opt_short);
-
-	if (batctl_settings[setting].params == sysfs_param_enable)
-		fprintf(stderr, " [0|1]\n");
-	else if (batctl_settings[setting].params == sysfs_param_server)
-		fprintf(stderr, " [client|server]\n");
-	else
-		fprintf(stderr, "\n");
+	fprintf(stderr, "Usage: batctl [options] %s|%s [parameters] %s\n",
+		state->cmd->name, state->cmd->abbr, state->cmd->usage);
 
 	fprintf(stderr, "parameters:\n");
 	fprintf(stderr, " \t -h print this help\n");
 }
 
-int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
+int handle_sys_setting(struct state *state, int argc, char **argv)
 {
+	struct settings_data *settings = state->cmd->arg;
 	int vid, optchar, res = EXIT_FAILURE;
 	char *path_buff, *base_dev = NULL;
 	const char **ptr;
@@ -142,10 +73,10 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
 		case 'h':
-			settings_usage(setting);
+			settings_usage(state);
 			return EXIT_SUCCESS;
 		default:
-			settings_usage(setting);
+			settings_usage(state);
 			return EXIT_FAILURE;
 		}
 	}
@@ -157,27 +88,27 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
+	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, state->mesh_iface);
 
 	/* if the specified interface is a VLAN then change the path to point
 	 * to the proper "vlan%{vid}" subfolder in the sysfs tree.
 	 */
-	vid = vlan_get_link(mesh_iface, &base_dev);
+	vid = vlan_get_link(state->mesh_iface, &base_dev);
 	if (vid >= 0)
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_VLAN_PATH, base_dev, vid);
 
 	if (argc == 1) {
-		res = read_file(path_buff, (char *)batctl_settings[setting].sysfs_name,
+		res = read_file(path_buff, settings->sysfs_name,
 				NO_FLAGS, 0, 0, 0);
 		goto out;
 	}
 
 	check_root_or_die("batctl");
 
-	if (!batctl_settings[setting].params)
+	if (!settings->params)
 		goto write_file;
 
-	ptr = batctl_settings[setting].params;
+	ptr = settings->params;
 	while (*ptr) {
 		if (strcmp(*ptr, argv[1]) == 0)
 			goto write_file;
@@ -188,7 +119,7 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 	fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
 	fprintf(stderr, "The following values are allowed:\n");
 
-	ptr = batctl_settings[setting].params;
+	ptr = settings->params;
 	while (*ptr) {
 		fprintf(stderr, " * %s\n", *ptr);
 		ptr++;
@@ -197,7 +128,7 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 	goto out;
 
 write_file:
-	res = write_file(path_buff, (char *)batctl_settings[setting].sysfs_name,
+	res = write_file(path_buff, settings->sysfs_name,
 			 argv[1], argc > 2 ? argv[2] : NULL);
 
 out:
@@ -205,3 +136,93 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 	free(base_dev);
 	return res;
 }
+
+static struct settings_data batctl_settings_orig_interval = {
+	.sysfs_name = "orig_interval",
+	.params = NULL,
+};
+
+COMMAND_NAMED(SUBCOMMAND, orig_interval, "it", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_orig_interval,
+	      "[interval]        \tdisplay or modify orig_interval setting");
+
+static struct settings_data batctl_settings_ap_isolation = {
+	.sysfs_name = "ap_isolation",
+	.params = sysfs_param_enable,
+};
+
+COMMAND_NAMED(SUBCOMMAND, ap_isolation, "ap", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_ap_isolation,
+	      "[0|1]             \tdisplay or modify ap_isolation setting");
+
+static struct settings_data batctl_settings_bridge_loop_avoidance = {
+	.sysfs_name = SYS_BLA,
+	.params = sysfs_param_enable,
+};
+
+COMMAND_NAMED(SUBCOMMAND, bridge_loop_avoidance, "bl", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_bridge_loop_avoidance,
+	      "[0|1]             \tdisplay or modify bridge_loop_avoidance setting");
+
+static struct settings_data batctl_settings_distributed_arp_table = {
+	.sysfs_name = SYS_DAT,
+	.params = sysfs_param_enable,
+};
+
+COMMAND_NAMED(SUBCOMMAND, distributed_arp_table, "dat", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_distributed_arp_table,
+	      "[0|1]             \tdisplay or modify distributed_arp_table setting");
+
+static struct settings_data batctl_settings_aggregation = {
+	.sysfs_name = "aggregated_ogms",
+	.params = sysfs_param_enable,
+};
+
+COMMAND_NAMED(SUBCOMMAND, aggregation, "ag", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_aggregation,
+	      "[0|1]             \tdisplay or modify aggregation setting");
+
+static struct settings_data batctl_settings_bonding = {
+	.sysfs_name = "bonding",
+	.params = sysfs_param_enable,
+};
+
+COMMAND_NAMED(SUBCOMMAND, bonding, "b", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_bonding,
+	      "[0|1]             \tdisplay or modify bonding setting");
+
+static struct settings_data batctl_settings_fragmentation = {
+	.sysfs_name = "fragmentation",
+	.params = sysfs_param_enable,
+};
+
+COMMAND_NAMED(SUBCOMMAND, fragmentation, "f", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_fragmentation,
+	      "[0|1]             \tdisplay or modify fragmentation setting");
+
+static struct settings_data batctl_settings_network_coding = {
+	.sysfs_name = SYS_NETWORK_CODING,
+	.params = sysfs_param_enable,
+};
+
+COMMAND_NAMED(SUBCOMMAND, network_coding, "nc", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_network_coding,
+	      "[0|1]             \tdisplay or modify network_coding setting");
+
+static struct settings_data batctl_settings_isolation_mark = {
+	.sysfs_name = "isolation_mark",
+	.params = NULL,
+};
+
+COMMAND_NAMED(SUBCOMMAND, isolation_mark, "mark", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_isolation_mark,
+	      "[mark]            \tdisplay or modify isolation_mark setting");
+
+static struct settings_data batctl_settings_multicast_mode = {
+	.sysfs_name = SYS_MULTICAST_MODE,
+	.params = sysfs_param_enable,
+};
+
+COMMAND_NAMED(SUBCOMMAND, multicast_mode, "mm", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_multicast_mode,
+	      "[0|1]             \tdisplay or modify multicast_mode setting");
diff --git a/sys.h b/sys.h
index 5f0280f..20e1934 100644
--- a/sys.h
+++ b/sys.h
@@ -28,6 +28,10 @@
 #define SYS_BATIF_PATH_FMT	"/sys/class/net/%s/mesh/"
 #define SYS_LOG_LEVEL		"log_level"
 #define SYS_LOG			"log"
+#define SYS_BLA			"bridge_loop_avoidance"
+#define SYS_DAT			"distributed_arp_table"
+#define SYS_NETWORK_CODING	"network_coding"
+#define SYS_MULTICAST_MODE	"multicast_mode"
 #define SYS_IFACE_PATH		"/sys/class/net"
 #define SYS_IFACE_DIR		SYS_IFACE_PATH"/%s/"
 #define SYS_MESH_IFACE_FMT	SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
@@ -35,31 +39,14 @@
 #define SYS_VLAN_PATH		SYS_IFACE_PATH"/%s/mesh/vlan%d/"
 #define VLAN_ID_MAX_LEN		4
 
-enum batctl_settings_list {
-	BATCTL_SETTINGS_ORIG_INTERVAL,
-	BATCTL_SETTINGS_AP_ISOLATION,
-	BATCTL_SETTINGS_BLA,
-	BATCTL_SETTINGS_DAT,
-	BATCTL_SETTINGS_AGGREGATION,
-	BATCTL_SETTINGS_BONDING,
-	BATCTL_SETTINGS_FRAGMENTATION,
-	BATCTL_SETTINGS_NETWORK_CODING,
-	BATCTL_SETTINGS_ISOLATION_MARK,
-	BATCTL_SETTINGS_MULTICAST_MODE,
-	BATCTL_SETTINGS_NUM,
-};
-
 struct settings_data {
-	const char opt_long[OPT_LONG_MAX_LEN];
-	const char opt_short[OPT_SHORT_MAX_LEN];
-	const char sysfs_name[SETTINGS_PATH_MAX_LEN];
+	const char *sysfs_name;
 	const char **params;
 };
 
 extern const char *sysfs_param_enable[];
 extern const char *sysfs_param_server[];
-extern const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM];
 
-int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv);
+int handle_sys_setting(struct state *state, int argc, char **argv);
 
 #endif
-- 
2.11.0

