Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 23 Jun 2012 18:40:11 +0200
Message-Id: <1340469612-6543-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1340469612-6543-1-git-send-email-lindner_marek@yahoo.de>
References: <1340469612-6543-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batctl: unify settings handling and
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
 functions.c |    2 +-
 main.c      |   67 +++++++++++-------------------
 main.h      |    1 +
 sys.c       |  131 ++++++++++++++++++++++++++++++++--------------------------
 sys.h       |   30 +++++++++-----
 5 files changed, 118 insertions(+), 113 deletions(-)

diff --git a/functions.c b/functions.c
index 36a4d40..d08c7a0 100644
--- a/functions.c
+++ b/functions.c
@@ -44,7 +44,7 @@ char *line_ptr = NULL;
 const char *sysfs_compile_out_param[] = {
 	SYS_LOG,
 	SYS_LOG_LEVEL,
-	SYS_BRIDGE_LOOP_AVOIDANCE,
+	batctl_settings[BATCTL_SETTINGS_BLA].sysfs_name,
 	NULL,
 };
 
diff --git a/main.c b/main.c
index 1482dbe..ae0b3d2 100644
--- a/main.c
+++ b/main.c
@@ -45,7 +45,7 @@ char module_ver_path[] = "/sys/module/batman_adv/version";
 
 void print_usage(void)
 {
-	int i;
+	int i, opt_indent;
 
 	printf("Usage: batctl [options] command|debug table \n");
 	printf("options:\n");
@@ -56,17 +56,24 @@ void print_usage(void)
 
 	printf("commands:\n");
 	printf(" \tinterface|if               [add|del iface(s)]\tdisplay or modify the interface settings\n");
-	printf(" \tinterval|it                [orig_interval]   \tdisplay or modify the originator interval (in ms)\n");
+	for (i = 0; i < BATCTL_SETTINGS_NUM; i++) {
+		printf(" \t%s|%s", batctl_settings[i].opt_long, batctl_settings[i].opt_short);
+		opt_indent = strlen(batctl_settings[i].opt_long) + strlen(batctl_settings[i].opt_short);
+
+		if (batctl_settings[i].params == sysfs_param_enable)
+			printf("%*s                display or modify %s setting\n",
+			       31 - opt_indent, "[0|1]", batctl_settings[i].opt_long);
+		else if (batctl_settings[i].params == sysfs_param_server)
+			printf("%*s      display or modify %s setting\n",
+			       41 - opt_indent, "[client|server]", batctl_settings[i].opt_long);
+		else
+			printf("                                display or modify %s setting\n",
+			       batctl_settings[i].opt_long);
+	}
 	printf(" \tloglevel|ll                [level]           \tdisplay or modify the log level\n");
 	printf(" \tlog|l                                        \tread the log produced by the kernel module\n");
 	printf(" \tgw_mode|gw                 [mode]            \tdisplay or modify the gateway mode\n");
-	printf(" \tvis_mode|vm                [mode]            \tdisplay or modify the status of the VIS server\n");
 	printf(" \tvis_data|vd                [dot|JSON]        \tdisplay the VIS data in dot or JSON format\n");
-	printf(" \taggregation|ag             [0|1]             \tdisplay or modify the packet aggregation setting\n");
-	printf(" \tbonding|b                  [0|1]             \tdisplay or modify the bonding mode setting\n");
-	printf(" \tbridge_loop_avoidance|bl   [0|1]             \tdisplay or modify the bridge loop avoidance setting\n");
-	printf(" \tfragmentation|f            [0|1]             \tdisplay or modify the fragmentation mode setting\n");
-	printf(" \tap_isolation|ap            [0|1]             \tdisplay or modify the ap isolation mode setting\n");
 	printf("\n");
 
 	printf("debug tables:                                   \tdisplay the corresponding debug table\n");
@@ -153,16 +160,6 @@ int main(int argc, char **argv)
 
 		ret = log_print(mesh_iface, argc - 1, argv + 1);
 
-	} else if ((strcmp(argv[1], "interval") == 0) || (strcmp(argv[1], "it") == 0)) {
-
-		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
-					 SYS_ORIG_INTERVAL, orig_interval_usage, NULL);
-
-	} else if ((strcmp(argv[1], "vis_mode") == 0) || (strcmp(argv[1], "vm") == 0)) {
-
-		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
-					 SYS_VIS_MODE, vis_mode_usage, sysfs_param_server);
-
 	} else if ((strcmp(argv[1], "vis_data") == 0) || (strcmp(argv[1], "vd") == 0)) {
 
 		ret = vis_data(mesh_iface, argc - 1, argv + 1);
@@ -171,31 +168,6 @@ int main(int argc, char **argv)
 
 		ret = handle_gw_setting(mesh_iface, argc - 1, argv + 1);
 
-	} else if ((strcmp(argv[1], "aggregation") == 0) || (strcmp(argv[1], "ag") == 0)) {
-
-		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
-					 SYS_AGGR, aggregation_usage, sysfs_param_enable);
-
-	} else if ((strcmp(argv[1], "bonding") == 0) || (strcmp(argv[1], "b") == 0)) {
-
-		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
-					 SYS_BONDING, bonding_usage, sysfs_param_enable);
-
-	} else if ((strcmp(argv[1], "bridge_loop_avoidance") == 0) || (strcmp(argv[1], "bl") == 0)) {
-
-		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
-					 SYS_BRIDGE_LOOP_AVOIDANCE, bridge_loop_avoidance_usage, sysfs_param_enable);
-
-	} else if ((strcmp(argv[1], "fragmentation") == 0) || (strcmp(argv[1], "f") == 0)) {
-
-		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
-					 SYS_FRAG, fragmentation_usage, sysfs_param_enable);
-
-	} else if ((strcmp(argv[1], "ap_isolation") == 0) || (strcmp(argv[1], "ap") == 0)) {
-
-		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
-					 SYS_AP_ISOLA, ap_isolation_usage, sysfs_param_enable);
-
 	} else if ((strcmp(argv[1], "statistics") == 0) || (strcmp(argv[1], "s") == 0)) {
 
 		ret = ioctl_statistics_get(mesh_iface);
@@ -206,6 +178,15 @@ int main(int argc, char **argv)
 
 	} else {
 
+		for (i = 0; i < BATCTL_SETTINGS_NUM; i++) {
+			if ((strcmp(argv[1], batctl_settings[i].opt_long) != 0) &&
+			    (strcmp(argv[1], batctl_settings[i].opt_short) != 0))
+				continue;
+
+			ret = handle_sys_setting(mesh_iface, i, argc - 1, argv + 1);
+			goto out;
+		}
+
 		for (i = 0; i < BATCTL_TABLE_NUM; i++) {
 			if ((strcmp(argv[1], batctl_debug_tables[i].opt_long) != 0) &&
 			    (strcmp(argv[1], batctl_debug_tables[i].opt_short) != 0))
diff --git a/main.h b/main.h
index 782ffde..4c8b60b 100644
--- a/main.h
+++ b/main.h
@@ -31,6 +31,7 @@
 #define OPT_SHORT_MAX_LEN 5
 
 #define DEBUG_TABLE_PATH_MAX_LEN 20
+#define SETTINGS_PATH_MAX_LEN 25
 
 #define __packed __attribute((packed))   /* linux kernel compat */
 
diff --git a/sys.c b/sys.c
index 5702c6c..63315fe 100644
--- a/sys.c
+++ b/sys.c
@@ -49,6 +49,52 @@ const char *sysfs_param_server[] = {
 	NULL,
 };
 
+const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM] = {
+	{
+		.opt_long = "orig_interval",
+		.opt_short = "it",
+		.sysfs_name = "orig_interval",
+		.params = NULL,
+	},
+	{
+		.opt_long = "ap_isolation",
+		.opt_short = "ap",
+		.sysfs_name = "ap_isolation",
+		.params = sysfs_param_enable,
+	},
+	{
+		.opt_long = "bridge_loop_avoidance",
+		.opt_short = "bl",
+		.sysfs_name = "bridge_loop_avoidance",
+		.params = sysfs_param_enable,
+	},
+	{
+		.opt_long = "vis_mode",
+		.opt_short = "vm",
+		.sysfs_name = "vis_mode",
+		.params = sysfs_param_server,
+	},
+	{
+		.opt_long = "aggregation",
+		.opt_short = "ag",
+		.sysfs_name = "aggregated_ogms",
+		.params = sysfs_param_enable,
+	},
+	{
+		.opt_long = "bonding",
+		.opt_short = "b",
+		.sysfs_name = "bonding",
+		.params = sysfs_param_enable,
+	},
+	{
+		.opt_long = "fragmentation",
+		.opt_short = "f",
+		.sysfs_name = "fragmentation",
+		.params = sysfs_param_enable,
+	},
+
+};
+
 static void interface_usage(void)
 {
 	printf("Usage: batctl interface [options] [add|del iface(s)] \n");
@@ -276,65 +322,23 @@ out:
 	return res;
 }
 
-void aggregation_usage(void)
-{
-	printf("Usage: batctl [options] aggregation [0|1]\n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-}
-
-void bonding_usage(void)
-{
-	printf("Usage: batctl [options] bonding [0|1]\n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-}
-
-void bridge_loop_avoidance_usage(void)
-{
-	printf("Usage: batctl [options] bridge_loop_avoidance [0|1]\n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-}
-
-void gw_mode_usage(void)
-{
-	printf("Usage: batctl [options] gw_mode [mode] [sel_class|bandwidth]\n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-}
-
-void vis_mode_usage(void)
-{
-	printf("Usage: batctl [options] vis_mode [mode]\n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-}
-
-void orig_interval_usage(void)
+void settings_usage(int setting)
 {
-	printf("Usage: batctl [options] interval \n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-}
+	printf("Usage: batctl [options] %s|%s",
+	       (char *)batctl_settings[setting].opt_long, (char *)batctl_settings[setting].opt_short);
 
-void fragmentation_usage(void)
-{
-	printf("Usage: batctl [options] fragmentation [0|1]\n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-}
+	if (batctl_settings[setting].params == sysfs_param_enable)
+		printf(" [0|1]\n");
+	else if (batctl_settings[setting].params == sysfs_param_server)
+		printf(" [client|server]\n");
+	else
+		printf("\n");
 
-void ap_isolation_usage(void)
-{
-	printf("Usage: batctl [options] ap_isolation [0|1]\n");
 	printf("options:\n");
 	printf(" \t -h print this help\n");
 }
 
-int handle_sys_setting(char *mesh_iface, int argc, char **argv,
-		       char *file_path, void setting_usage(void),
-		       const char *sysfs_param[])
+int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 {
 	int optchar, res = EXIT_FAILURE;
 	char *path_buff;
@@ -343,10 +347,10 @@ int handle_sys_setting(char *mesh_iface, int argc, char **argv,
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
 		case 'h':
-			setting_usage();
+			settings_usage(setting);
 			return EXIT_SUCCESS;
 		default:
-			setting_usage();
+			settings_usage(setting);
 			return EXIT_FAILURE;
 		}
 	}
@@ -355,14 +359,15 @@ int handle_sys_setting(char *mesh_iface, int argc, char **argv,
 	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
 
 	if (argc == 1) {
-		res = read_file(path_buff, file_path, NO_FLAGS, 0, 0);
+		res = read_file(path_buff, (char *)batctl_settings[setting].sysfs_name,
+				NO_FLAGS, 0, 0);
 		goto out;
 	}
 
-	if (!sysfs_param)
+	if (!batctl_settings[setting].params)
 		goto write_file;
 
-	ptr = sysfs_param;
+	ptr = batctl_settings[setting].params;
 	while (*ptr) {
 		if (strcmp(*ptr, argv[1]) == 0)
 			goto write_file;
@@ -373,7 +378,7 @@ int handle_sys_setting(char *mesh_iface, int argc, char **argv,
 	printf("Error - the supplied argument is invalid: %s\n", argv[1]);
 	printf("The following values are allowed:\n");
 
-	ptr = sysfs_param;
+	ptr = batctl_settings[setting].params;
 	while (*ptr) {
 		printf(" * %s\n", *ptr);
 		ptr++;
@@ -382,13 +387,21 @@ int handle_sys_setting(char *mesh_iface, int argc, char **argv,
 	goto out;
 
 write_file:
-	res = write_file(path_buff, file_path, argv[1], argc > 2 ? argv[2] : NULL);
+	res = write_file(path_buff, (char *)batctl_settings[setting].sysfs_name,
+			 argv[1], argc > 2 ? argv[2] : NULL);
 
 out:
 	free(path_buff);
 	return res;
 }
 
+void gw_mode_usage(void)
+{
+	printf("Usage: batctl [options] gw_mode [mode] [sel_class|bandwidth]\n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+}
+
 int handle_gw_setting(char *mesh_iface, int argc, char **argv)
 {
 	int optchar, res = EXIT_FAILURE;
diff --git a/sys.h b/sys.h
index f48902e..df9795e 100644
--- a/sys.h
+++ b/sys.h
@@ -23,20 +23,24 @@
 #define SYS_BATIF_PATH_FMT "/sys/class/net/%s/mesh/"
 #define SYS_LOG_LEVEL "log_level"
 #define SYS_LOG "log"
-#define SYS_AGGR "aggregated_ogms"
-#define SYS_BONDING "bonding"
-#define SYS_BRIDGE_LOOP_AVOIDANCE "bridge_loop_avoidance"
 #define SYS_GW_MODE "gw_mode"
 #define SYS_GW_SEL "gw_sel_class"
 #define SYS_GW_BW "gw_bandwidth"
-#define SYS_VIS_MODE "vis_mode"
-#define SYS_ORIG_INTERVAL "orig_interval"
 #define SYS_IFACE_PATH "/sys/class/net"
 #define SYS_IFACE_DIR SYS_IFACE_PATH"/%s/"
 #define SYS_MESH_IFACE_FMT SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
 #define SYS_IFACE_STATUS_FMT SYS_IFACE_PATH"/%s/batman_adv/iface_status"
-#define SYS_FRAG "fragmentation"
-#define SYS_AP_ISOLA "ap_isolation"
+
+enum batctl_settings_list {
+	BATCTL_SETTINGS_ORIG_INTERVAL,
+	BATCTL_SETTINGS_AP_ISOLATION,
+	BATCTL_SETTINGS_BLA,
+	BATCTL_SETTINGS_VIS_MODE,
+	BATCTL_SETTINGS_AGGREGATION,
+	BATCTL_SETTINGS_BONDING,
+	BATCTL_SETTINGS_FRAGMENTATION,
+	BATCTL_SETTINGS_NUM,
+};
 
 enum gw_modes {
 	GW_MODE_OFF,
@@ -44,8 +48,16 @@ enum gw_modes {
 	GW_MODE_SERVER,
 };
 
+struct settings_data {
+	const char opt_long[OPT_LONG_MAX_LEN];
+	const char opt_short[OPT_SHORT_MAX_LEN];
+	const char sysfs_name[SETTINGS_PATH_MAX_LEN];
+	const char **params;
+};
+
 extern const char *sysfs_param_enable[];
 extern const char *sysfs_param_server[];
+extern const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM];
 
 void aggregation_usage(void);
 void bonding_usage(void);
@@ -57,7 +69,5 @@ void vis_mode_usage(void);
 void orig_interval_usage(void);
 int interface(char *mesh_iface, int argc, char **argv);
 int handle_loglevel(char *mesh_iface, int argc, char **argv);
-int handle_sys_setting(char *mesh_iface, int argc, char **argv,
-		       char *file_path, void setting_usage(void),
-		       const char *sysfs_param[]);
+int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv);
 int handle_gw_setting(char *mesh_iface, int argc, char **argv);
-- 
1.7.9.1

