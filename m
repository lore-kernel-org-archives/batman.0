Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 11 Jul 2010 20:01:12 +0200
Message-Id: <1278871272-31751-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201007112000.48113.lindner_marek@yahoo.de>
References: <201007112000.48113.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batctl: support for multiple mesh clouds
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

Since the batman-adv kernel supports multiple mesh clouds batctl comes
with a new optional parameter '-m' which allows to specify the mesh
cloud a specific command shall be applied to. It defaults to 'bat0'
which guarantees compatibility with the previous behaviour.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 batctl/debug.c      |   11 +++++----
 batctl/debug.h      |    7 +++--
 batctl/debugfs.c    |    6 ++--
 batctl/debugfs.h    |    3 +-
 batctl/main.c       |   59 +++++++++++++++++++++++++++++++++++++-------------
 batctl/main.h       |    2 +-
 batctl/ping.c       |    4 +-
 batctl/ping.h       |    4 +-
 batctl/sys.c        |   44 ++++++++++++++++++++++++++-----------
 batctl/sys.h        |   10 ++++----
 batctl/traceroute.c |    6 ++--
 batctl/traceroute.h |    4 +-
 batctl/vis.c        |   16 +++++++-------
 batctl/vis.h        |    4 +-
 14 files changed, 114 insertions(+), 66 deletions(-)

diff --git a/batctl/debug.c b/batctl/debug.c
index 3045f67..1dbc204 100644
--- a/batctl/debug.c
+++ b/batctl/debug.c
@@ -70,7 +70,8 @@ void gateways_usage(void)
 	printf(" \t -w [interval] watch mode - refresh the gateway server list continuously\n");
 }
 
-int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(void))
+int handle_debug_table(char *mesh_iface, int argc, char **argv,
+		       char *file_path, void table_usage(void))
 {
 	int optchar, read_opt = USE_BAT_HOSTS;
 	char full_path[MAX_PATH+1];
@@ -114,7 +115,7 @@ int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(
 		case '?':
 			if (optopt == 't')
 				printf("Error - argument -t needs a number\n");
-			
+
 			else if (optopt == 'w') {
 				read_opt |= CLR_CONT_READ;
 				break;
@@ -135,7 +136,7 @@ int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(
 		return EXIT_FAILURE;
 	}
 
-	debugfs_make_path(DEBUG_BATIF_PATH "/", full_path, sizeof(full_path));
+	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
 	return read_file(full_path, file_path, read_opt, orig_timeout, watch_interval);
 }
 
@@ -147,7 +148,7 @@ static void log_usage(void)
 	printf(" \t -n don't replace mac addresses with bat-host names\n");
 }
 
-int log_print(int argc, char **argv)
+int log_print(char *mesh_iface, int argc, char **argv)
 {
 	int optchar, res, read_opt = USE_BAT_HOSTS | LOG_MODE;
 	char full_path[MAX_PATH+1];
@@ -173,7 +174,7 @@ int log_print(int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	debugfs_make_path(DEBUG_BATIF_PATH "/", full_path, sizeof(full_path));
+	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
 	res = read_file(full_path, DEBUG_LOG, read_opt, 0, 0);
 
 	if ((res != EXIT_SUCCESS) && (errno == ENOENT))
diff --git a/batctl/debug.h b/batctl/debug.h
index bc6d16c..8bed80e 100644
--- a/batctl/debug.h
+++ b/batctl/debug.h
@@ -20,7 +20,7 @@
  */
 
 
-#define DEBUG_BATIF_PATH "batman_adv/bat0"
+#define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
 #define DEBUG_ORIGINATORS "originators"
 #define DEBUG_TRANSTABLE_LOCAL "transtable_local"
 #define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
@@ -32,5 +32,6 @@ void originators_usage(void);
 void trans_local_usage(void);
 void trans_global_usage(void);
 void gateways_usage(void);
-int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(void));
-int log_print(int argc, char **argv);
+int handle_debug_table(char *mesh_iface, int argc, char **argv,
+		       char *file_path, void table_usage(void));
+int log_print(char *mesh_iface, int argc, char **argv);
diff --git a/batctl/debugfs.c b/batctl/debugfs.c
index 6d2222f..47a0475 100644
--- a/batctl/debugfs.c
+++ b/batctl/debugfs.c
@@ -50,7 +50,7 @@ void debugfs_force_cleanup(void)
 }
 
 /* construct a full path to a debugfs element */
-int debugfs_make_path(const char *element, char *buffer, int size)
+int debugfs_make_path(const char *fmt, char *mesh_iface, char *buffer, int size)
 {
 	int len;
 
@@ -59,11 +59,11 @@ int debugfs_make_path(const char *element, char *buffer, int size)
 		return -1;
 	}
 
-	len = strlen(debugfs_mountpoint) + strlen(element) + 1;
+	len = strlen(debugfs_mountpoint) + strlen(fmt) + 1;
 	if (len >= size)
 		return len+1;
 
-	snprintf(buffer, size-1, "%s/%s", debugfs_mountpoint, element);
+	snprintf(buffer, size-1, fmt, debugfs_mountpoint, mesh_iface);
 	return 0;
 }
 
diff --git a/batctl/debugfs.h b/batctl/debugfs.h
index 45f6339..a943e5b 100644
--- a/batctl/debugfs.h
+++ b/batctl/debugfs.h
@@ -41,6 +41,7 @@ extern int debugfs_umount(void);
 extern int debugfs_write(const char *entry, const char *value);
 extern int debugfs_read(const char *entry, char *buffer, size_t size);
 extern void debugfs_force_cleanup(void);
-extern int debugfs_make_path(const char *element, char *buffer, int size);
+extern int debugfs_make_path(const char *fmt, char *mesh_iface,
+			     char *buffer, int size);
 
 #endif /* __DEBUGFS_H__ */
diff --git a/batctl/main.c b/batctl/main.c
index 1ee4279..248c0de 100644
--- a/batctl/main.c
+++ b/batctl/main.c
@@ -37,6 +37,7 @@
 #include "bisect.h"
 #include "vis.h"
 
+char mesh_dfl_iface[] = "bat0";
 
 void print_usage(void) {
 	printf("Usage: batctl [options] commands \n");
@@ -61,6 +62,7 @@ void print_usage(void) {
 	printf(" \ttcpdump|td      <interface>       \ttcpdump layer 2 traffic on the given interface\n");
 	printf(" \tbisect          <file1> .. <fileN>\tanalyze given log files for routing stability\n");
 	printf("options:\n");
+	printf(" \t-m mesh interface (default 'bat0')\n");
 	printf(" \t-h print this help (or 'batctl <command> -h' for the command specific help)\n");
 	printf(" \t-v print version\n");
 }
@@ -68,6 +70,7 @@ void print_usage(void) {
 int main(int argc, char **argv)
 {
 	int ret = EXIT_FAILURE;
+	char *mesh_iface = mesh_dfl_iface;
 
 	if ((argc < 2) || (strcmp(argv[1], "-h") == 0)) {
 		print_usage();
@@ -79,6 +82,19 @@ int main(int argc, char **argv)
 		exit(EXIT_SUCCESS);
 	}
 
+	if (strcmp(argv[1], "-m") == 0) {
+		if (argc < 3) {
+			printf("Error - the option '-m' needs a parameter\n");
+			print_usage();
+			exit(EXIT_FAILURE);
+		}
+
+		mesh_iface = argv[2];
+
+		argv += 2;
+		argc -= 2;
+	}
+
 	/* TODO: remove this generic check here and move it into the individual functions */
 	/* check if user is root */
 	if ((strcmp(argv[1], "bisect") != 0) && ((getuid()) || (getgid()))) {
@@ -88,11 +104,11 @@ int main(int argc, char **argv)
 
 	if ((strcmp(argv[1], "ping") == 0) || (strcmp(argv[1], "p") == 0)) {
 
-		ret = ping(argc - 1, argv + 1);
+		ret = ping(mesh_iface, argc - 1, argv + 1);
 
 	} else if ((strcmp(argv[1], "traceroute") == 0) || (strcmp(argv[1], "tr") == 0)) {
 
-		ret = traceroute(argc - 1, argv + 1);
+		ret = traceroute(mesh_iface, argc - 1, argv + 1);
 
 	} else if ((strcmp(argv[1], "tcpdump") == 0) || (strcmp(argv[1], "td") == 0)) {
 
@@ -100,65 +116,76 @@ int main(int argc, char **argv)
 
 	} else if ((strcmp(argv[1], "interface") == 0) || (strcmp(argv[1], "if") == 0)) {
 
-		ret = interface(argc - 1, argv + 1);
+		ret = interface(mesh_iface, argc - 1, argv + 1);
 
 	} else if ((strcmp(argv[1], "originators") == 0) || (strcmp(argv[1], "o") == 0)) {
 
-		ret = handle_debug_table(argc - 1, argv + 1, DEBUG_ORIGINATORS, originators_usage);
+		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
+					 DEBUG_ORIGINATORS, originators_usage);
 
 	} else if ((strcmp(argv[1], "translocal") == 0) || (strcmp(argv[1], "tl") == 0)) {
 
-		ret = handle_debug_table(argc - 1, argv + 1, DEBUG_TRANSTABLE_LOCAL, trans_local_usage);
+		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
+					 DEBUG_TRANSTABLE_LOCAL, trans_local_usage);
 
 	} else if ((strcmp(argv[1], "transglobal") == 0) || (strcmp(argv[1], "tg") == 0)) {
 
-		ret = handle_debug_table(argc - 1, argv + 1, DEBUG_TRANSTABLE_GLOBAL, trans_global_usage);
+		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
+					 DEBUG_TRANSTABLE_GLOBAL, trans_global_usage);
 
 	} else if ((strcmp(argv[1], "loglevel") == 0) || (strcmp(argv[1], "ll") == 0)) {
 
-		ret = handle_loglevel(argc - 1, argv + 1);
+		ret = handle_loglevel(mesh_iface, argc - 1, argv + 1);
 
 	} else if ((strcmp(argv[1], "log") == 0) || (strcmp(argv[1], "l") == 0)) {
 
-		ret = log_print(argc - 1, argv + 1);
+		ret = log_print(mesh_iface, argc - 1, argv + 1);
 
 	} else if ((strcmp(argv[1], "interval") == 0) || (strcmp(argv[1], "it") == 0)) {
 
-		ret = handle_sys_setting(argc - 1, argv + 1, SYS_ORIG_INTERVAL, orig_interval_usage, NULL);
+		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
+					 SYS_ORIG_INTERVAL, orig_interval_usage, NULL);
 
 	} else if ((strcmp(argv[1], "vis_mode") == 0) || (strcmp(argv[1], "vm") == 0)) {
 
-		ret = handle_sys_setting(argc - 1, argv + 1, SYS_VIS_MODE, vis_mode_usage, sysfs_param_server);
+		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
+					 SYS_VIS_MODE, vis_mode_usage, sysfs_param_server);
 
 	} else if ((strcmp(argv[1], "vis_data") == 0) || (strcmp(argv[1], "vd") == 0)) {
 
-		ret = vis_data(argc - 1, argv + 1);
+		ret = vis_data(mesh_iface, argc - 1, argv + 1);
 
 	} else if ((strcmp(argv[1], "gw_mode") == 0) || (strcmp(argv[1], "gw") == 0)) {
 
-		ret = handle_sys_setting(argc - 1, argv + 1, SYS_GW_MODE, gw_mode_usage, sysfs_param_server);
+		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
+					 SYS_GW_MODE, gw_mode_usage, sysfs_param_server);
 
 	} else if ((strcmp(argv[1], "gateways") == 0) || (strcmp(argv[1], "gwl") == 0)) {
 
-		ret = handle_debug_table(argc - 1, argv + 1, DEBUG_GATEWAYS, gateways_usage);
+		ret = handle_debug_table(mesh_iface, argc - 1, argv + 1,
+					 DEBUG_GATEWAYS, gateways_usage);
 
 	} else if ((strcmp(argv[1], "aggregation") == 0) || (strcmp(argv[1], "ag") == 0)) {
 
-		ret = handle_sys_setting(argc - 1, argv + 1, SYS_AGGR, aggregation_usage, sysfs_param_enable);
+		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
+					 SYS_AGGR, aggregation_usage, sysfs_param_enable);
 
 	} else if ((strcmp(argv[1], "bonding") == 0) || (strcmp(argv[1], "b") == 0)) {
 
-		ret = handle_sys_setting(argc - 1, argv + 1, SYS_BONDING, bonding_usage, sysfs_param_enable);
+		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
+					 SYS_BONDING, bonding_usage, sysfs_param_enable);
 
 	} else if ((strcmp(argv[1], "fragmentation") == 0) || (strcmp(argv[1], "f") == 0)) {
 
-		ret = handle_sys_setting(argc - 1, argv + 1, SYS_FRAG, fragmentation_usage, sysfs_param_enable);
+		ret = handle_sys_setting(mesh_iface, argc - 1, argv + 1,
+					 SYS_FRAG, fragmentation_usage, sysfs_param_enable);
 
 	} else if ((strcmp(argv[1], "bisect") == 0)) {
 
 		ret = bisect(argc - 1, argv + 1);
 
 	} else {
+		printf("Error - no command specified\n");
 		print_usage();
 	}
 
diff --git a/batctl/main.h b/batctl/main.h
index 261256d..793d282 100644
--- a/batctl/main.h
+++ b/batctl/main.h
@@ -23,4 +23,4 @@
 
 #define SOURCE_VERSION "devel"  /*put exactly one distinct word inside the string like "0.3-pre-alpha" or "0.3-rc1" or "0.3" */
 
-#define SOCKET_PATH "batman_adv/bat0/socket"
+#define SOCKET_PATH_FMT "%s/batman_adv/%s/socket"
diff --git a/batctl/ping.c b/batctl/ping.c
index 7820e32..affd6ad 100644
--- a/batctl/ping.c
+++ b/batctl/ping.c
@@ -65,7 +65,7 @@ void sig_handler(int sig)
 	}
 }
 
-int ping(int argc, char **argv)
+int ping(char *mesh_iface, int argc, char **argv)
 {
 	struct icmp_packet_rr icmp_packet_out, icmp_packet_in;
 	struct timeval tv;
@@ -149,7 +149,7 @@ int ping(int argc, char **argv)
 		goto out;
 	}
 
-	debugfs_make_path(SOCKET_PATH, icmp_socket, sizeof(icmp_socket));
+	debugfs_make_path(SOCKET_PATH_FMT, mesh_iface, icmp_socket, sizeof(icmp_socket));
 
 	ping_fd = open(icmp_socket, O_RDWR);
 
diff --git a/batctl/ping.h b/batctl/ping.h
index d578f2a..a5eeb1e 100644
--- a/batctl/ping.h
+++ b/batctl/ping.h
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
@@ -21,4 +21,4 @@
 
 
 
-int ping(int argc, char **argv);
+int ping(char *mesh_iface, int argc, char **argv);
diff --git a/batctl/sys.c b/batctl/sys.c
index a5cf2ca..79d9612 100644
--- a/batctl/sys.c
+++ b/batctl/sys.c
@@ -56,7 +56,7 @@ static void interface_usage(void)
 	printf(" \t -h print this help\n");
 }
 
-static int print_interfaces(void)
+static int print_interfaces(char *mesh_iface)
 {
 	DIR *iface_base_dir;
 	struct dirent *iface_dir;
@@ -89,6 +89,9 @@ static int print_interfaces(void)
 		if (strcmp(line_ptr, "none") == 0)
 			goto free_line;
 
+		if (strcmp(line_ptr, mesh_iface) != 0)
+			goto free_line;
+
 		free(line_ptr);
 		line_ptr = NULL;
 
@@ -116,7 +119,7 @@ err:
 	return EXIT_FAILURE;
 }
 
-int interface(int argc, char **argv)
+int interface(char *mesh_iface, int argc, char **argv)
 {
 	char *path_buff;
 	int i, res, optchar;
@@ -133,7 +136,7 @@ int interface(int argc, char **argv)
 	}
 
 	if (argc == 1)
-		return print_interfaces();
+		return print_interfaces(mesh_iface);
 
 	if ((strcmp(argv[1], "add") != 0) && (strcmp(argv[1], "a") != 0) &&
 	    (strcmp(argv[1], "del") != 0) && (strcmp(argv[1], "d") != 0)) {
@@ -152,7 +155,7 @@ int interface(int argc, char **argv)
 		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, argv[i]);
 
 		if (argv[1][0] == 'a')
-			res = write_file("", path_buff, "bat0", NULL);
+			res = write_file("", path_buff, mesh_iface, NULL);
 		else
 			res = write_file("", path_buff, "none", NULL);
 
@@ -176,9 +179,10 @@ static void log_level_usage(void)
 	printf(" \t -h print this help\n");
 }
 
-int handle_loglevel(int argc, char **argv)
+int handle_loglevel(char *mesh_iface, int argc, char **argv)
 {
 	int optchar, res;
+	char *path_buff;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
 		switch (optchar) {
@@ -191,12 +195,15 @@ int handle_loglevel(int argc, char **argv)
 		}
 	}
 
+	path_buff = malloc(PATH_BUFF_LEN);
+	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
+
 	if (argc != 1) {
-		res = write_file(SYS_BATIF_PATH, SYS_LOG_LEVEL, argv[1], NULL);
+		res = write_file(path_buff, SYS_LOG_LEVEL, argv[1], NULL);
 		goto out;
 	}
 
-	res = read_file(SYS_BATIF_PATH, SYS_LOG_LEVEL, SINGLE_READ | USE_READ_BUFF, 0, 0);
+	res = read_file(path_buff, SYS_LOG_LEVEL, SINGLE_READ | USE_READ_BUFF, 0, 0);
 
 	if (res != EXIT_SUCCESS)
 		goto out;
@@ -214,6 +221,7 @@ out:
 	if (errno == ENOENT)
 		printf("To increase the log level you need to compile the module with debugging enabled (see the README)\n");
 
+	free(path_buff);
 	return res;
 }
 
@@ -259,11 +267,12 @@ void fragmentation_usage(void)
 	printf(" \t -h print this help\n");
 }
 
-int handle_sys_setting(int argc, char **argv,
+int handle_sys_setting(char *mesh_iface, int argc, char **argv,
 		       char *file_path, void setting_usage(void),
 		       const char *sysfs_param[])
 {
-	int optchar;
+	int optchar, res = EXIT_FAILURE;
+	char *path_buff;
 	const char **ptr;
 
 	while ((optchar = getopt(argc, argv, "h")) != -1) {
@@ -277,8 +286,13 @@ int handle_sys_setting(int argc, char **argv,
 		}
 	}
 
-	if (argc == 1)
-		return read_file(SYS_BATIF_PATH, file_path, SINGLE_READ, 0, 0);
+	path_buff = malloc(PATH_BUFF_LEN);
+	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
+
+	if (argc == 1) {
+		res = read_file(path_buff, file_path, SINGLE_READ, 0, 0);
+		goto out;
+	}
 
 	if (!sysfs_param)
 		goto write_file;
@@ -300,8 +314,12 @@ int handle_sys_setting(int argc, char **argv,
 		ptr++;
 	}
 
-	return EXIT_FAILURE;
+	goto out;
 
 write_file:
-	return write_file(SYS_BATIF_PATH, file_path, argv[1], argc > 2 ? argv[2] : NULL);
+	res = write_file(path_buff, file_path, argv[1], argc > 2 ? argv[2] : NULL);
+
+out:
+	free(path_buff);
+	return res;
 }
diff --git a/batctl/sys.h b/batctl/sys.h
index 7e0d52e..71362f1 100644
--- a/batctl/sys.h
+++ b/batctl/sys.h
@@ -20,7 +20,7 @@
  */
 
 
-#define SYS_BATIF_PATH "/sys/class/net/bat0/mesh/"
+#define SYS_BATIF_PATH_FMT "/sys/class/net/%s/mesh/"
 #define SYS_LOG_LEVEL "log_level"
 #define SYS_LOG "log"
 #define SYS_AGGR "aggregated_ogms"
@@ -42,8 +42,8 @@ void fragmentation_usage(void);
 void gw_mode_usage(void);
 void vis_mode_usage(void);
 void orig_interval_usage(void);
-int interface(int argc, char **argv);
-int handle_loglevel(int argc, char **argv);
-int handle_sys_setting(int argc, char **argv, char *file_path,
-		       void setting_usage(void),
+int interface(char *mesh_iface, int argc, char **argv);
+int handle_loglevel(char *mesh_iface, int argc, char **argv);
+int handle_sys_setting(char *mesh_iface, int argc, char **argv,
+		       char *file_path, void setting_usage(void),
 		       const char *sysfs_param[]);
diff --git a/batctl/traceroute.c b/batctl/traceroute.c
index f5b63f9..bcfe146 100644
--- a/batctl/traceroute.c
+++ b/batctl/traceroute.c
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2007-2010 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <a.langer@q-dsl.de>, Marek Lindner <lindner_marek@yahoo.de>
@@ -48,7 +48,7 @@ void traceroute_usage(void)
 	printf(" \t -n don't convert addresses to bat-host names\n");
 }
 
-int traceroute(int argc, char **argv)
+int traceroute(char *mesh_iface, int argc, char **argv)
 {
 	struct icmp_packet icmp_packet_out, icmp_packet_in;
 	struct bat_host *bat_host;
@@ -108,7 +108,7 @@ int traceroute(int argc, char **argv)
 		goto out;
 	}
 
-	debugfs_make_path(SOCKET_PATH, icmp_socket, sizeof(icmp_socket));
+	debugfs_make_path(SOCKET_PATH_FMT, mesh_iface, icmp_socket, sizeof(icmp_socket));
 
 	trace_fd = open(icmp_socket, O_RDWR);
 
diff --git a/batctl/traceroute.h b/batctl/traceroute.h
index f1a2dd2..0eff114 100644
--- a/batctl/traceroute.h
+++ b/batctl/traceroute.h
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
@@ -21,4 +21,4 @@
 
 
 
-int traceroute(int argc, char **argv);
+int traceroute(char *mesh_iface, int argc, char **argv);
diff --git a/batctl/vis.c b/batctl/vis.c
index 36152cf..ad612ff 100644
--- a/batctl/vis.c
+++ b/batctl/vis.c
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
@@ -164,7 +164,7 @@ const struct funcs json_funcs = { json_print_tq,
 	NULL
 };
 
-static FILE *open_vis(void)
+static FILE *open_vis(char *mesh_iface)
 {
 	char full_path[MAX_PATH+1];
 	char *debugfs_mnt;
@@ -175,12 +175,12 @@ static FILE *open_vis(void)
 		return NULL;
 	}
 
-	debugfs_make_path(DEBUG_BATIF_PATH "/" DEBUG_VIS_DATA, full_path, sizeof(full_path));
+	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_VIS_DATA, mesh_iface, full_path, sizeof(full_path));
 
 	return fopen(full_path, "r");
 }
 
-static int format(const struct funcs *funcs)
+static int format(char *mesh_iface, const struct funcs *funcs)
 {
 	size_t len = 0;
 	ssize_t read;
@@ -194,7 +194,7 @@ static int format(const struct funcs *funcs)
 	long tq;
 	char *flag;
 
-	FILE *fp = open_vis();
+	FILE *fp = open_vis(mesh_iface);
 
 	if (!fp)
 		return EXIT_FAILURE;
@@ -246,7 +246,7 @@ static int format(const struct funcs *funcs)
 	return EXIT_SUCCESS;
 }
 
-int vis_data(int argc, char *argv[])
+int vis_data(char *mesh_iface, int argc, char *argv[])
 {
 	bool dot = false;
 	bool json = false;
@@ -306,10 +306,10 @@ int vis_data(int argc, char *argv[])
 		bat_hosts_init();
 
 	if (dot)
-		return format(&dot_funcs);
+		return format(mesh_iface, &dot_funcs);
 
 	if (json)
-		return format(&json_funcs);
+		return format(mesh_iface, &json_funcs);
 
 	return EXIT_FAILURE;
 }
diff --git a/batctl/vis.h b/batctl/vis.h
index 7e6b85f..effed51 100644
--- a/batctl/vis.h
+++ b/batctl/vis.h
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
@@ -19,5 +19,5 @@
  *
  */
 
-int vis_data(int argc, char * argv[]);
+int vis_data(char *mesh_iface, int argc, char * argv[]);
 
-- 
1.7.0.4

