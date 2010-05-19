Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 19 May 2010 21:43:53 +0200
Message-Id: <1274298233-21487-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201005192141.32752.sven.eckelmann@gmx.de>
References: <201005192141.32752.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batctl: Get tables from debugfs instead
	of sysfs
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

batctl must read the tables exported by batman-adv from debugfs as the
old files in /sys/class/net/bat0/mesh/ were removed to follow the sysfs
guidelines.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
Please apply on top of batctl-0.2.x branch.

 Makefile |    4 +-
 debug.c  |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 debug.h  |   32 +++++++++++++++++++
 main.c   |    7 ++--
 sys.c    |   51 ------------------------------
 sys.h    |    8 -----
 vis.c    |   20 ++++++-----
 7 files changed, 152 insertions(+), 73 deletions(-)
 create mode 100644 debug.c
 create mode 100644 debug.h

diff --git a/Makefile b/Makefile
index ff877ea..4071af1 100644
--- a/Makefile
+++ b/Makefile
@@ -39,8 +39,8 @@ SRC_FILES = "\(\.c\)\|\(\.h\)\|\(Makefile\)\|\(INSTALL\)\|\(LIESMICH\)\|\(README
 EXTRA_MODULES_C := bisect.c
 EXTRA_MODULES_H := bisect.h
 
-SRC_C = main.c bat-hosts.c functions.c sys.c ping.c traceroute.c tcpdump.c list-batman.c hash.c vis.c debugfs.c $(EXTRA_MODULES_C)
-SRC_H = main.h bat-hosts.h functions.h sys.h ping.h traceroute.h tcpdump.h list-batman.h hash.h allocate.h vis.h debugfs.h $(EXTRA_MODULES_H)
+SRC_C = main.c bat-hosts.c functions.c sys.c debug.c ping.c traceroute.c tcpdump.c list-batman.c hash.c vis.c debugfs.c $(EXTRA_MODULES_C)
+SRC_H = main.h bat-hosts.h functions.h sys.h debug.h ping.h traceroute.h tcpdump.h list-batman.h hash.h allocate.h vis.h debugfs.h $(EXTRA_MODULES_H)
 SRC_O = $(SRC_C:.c=.o)
 
 PACKAGE_NAME = batctl
diff --git a/debug.c b/debug.c
new file mode 100644
index 0000000..e8edb9d
--- /dev/null
+++ b/debug.c
@@ -0,0 +1,103 @@
+/*
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <lindner_marek@yahoo.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <dirent.h>
+
+#include "main.h"
+#include "debug.h"
+#include "debugfs.h"
+#include "functions.h"
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
+void gateways_usage(void)
+{
+	printf("Usage: batctl [options] gateways \n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+	printf(" \t -n don't replace mac addresses with bat-host names\n");
+	printf(" \t -w watch mode - refresh the gateway server list continuously\n");
+}
+
+int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(void))
+{
+	int optchar, read_opt = USE_BAT_HOSTS;
+	char full_path[MAX_PATH+1];
+	char *debugfs_mnt;
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
+	debugfs_mnt = debugfs_mount(NULL);
+	if (!debugfs_mnt) {
+		printf("Error - can't mount or find debugfs\n");
+		return EXIT_FAILURE;
+	}
+
+	debugfs_make_path(DEBUG_BATIF_PATH "/", full_path, sizeof(full_path));
+	return read_file(full_path, file_path, read_opt);
+}
\ No newline at end of file
diff --git a/debug.h b/debug.h
new file mode 100644
index 0000000..2c6e228
--- /dev/null
+++ b/debug.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2009-2010 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <lindner_marek@yahoo.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+
+#define DEBUG_BATIF_PATH "batman_adv/bat0"
+#define DEBUG_ORIGINATORS "originators"
+#define DEBUG_TRANSTABLE_LOCAL "transtable_local"
+#define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
+#define DEBUG_VIS_DATA "vis_data"
+
+void originators_usage(void);
+void trans_local_usage(void);
+void trans_global_usage(void);
+int handle_debug_table(int argc, char **argv, char *file_path, void table_usage(void));
diff --git a/main.c b/main.c
index 87bd853..55a59db 100644
--- a/main.c
+++ b/main.c
@@ -30,6 +30,7 @@
 
 #include "main.h"
 #include "sys.h"
+#include "debug.h"
 #include "ping.h"
 #include "traceroute.h"
 #include "tcpdump.h"
@@ -99,15 +100,15 @@ int main(int argc, char **argv)
 
 	} else if ((strcmp(argv[1], "originators") == 0) || (strcmp(argv[1], "o") == 0)) {
 
-		ret = handle_sys_table(argc - 1, argv + 1, SYS_ORIGINATORS, originators_usage);
+		ret = handle_debug_table(argc - 1, argv + 1, DEBUG_ORIGINATORS, originators_usage);
 
 	} else if ((strcmp(argv[1], "translocal") == 0) || (strcmp(argv[1], "tl") == 0)) {
 
-		ret = handle_sys_table(argc - 1, argv + 1, SYS_TRANSTABLE_LOCAL, trans_local_usage);
+		ret = handle_debug_table(argc - 1, argv + 1, DEBUG_TRANSTABLE_LOCAL, trans_local_usage);
 
 	} else if ((strcmp(argv[1], "transglobal") == 0) || (strcmp(argv[1], "tg") == 0)) {
 
-		ret = handle_sys_table(argc - 1, argv + 1, SYS_TRANSTABLE_GLOBAL, trans_global_usage);
+		ret = handle_debug_table(argc - 1, argv + 1, DEBUG_TRANSTABLE_GLOBAL, trans_global_usage);
 
 	} else if ((strcmp(argv[1], "loglevel") == 0) || (strcmp(argv[1], "ll") == 0)) {
 
diff --git a/sys.c b/sys.c
index c8a7c26..2de9c4a 100644
--- a/sys.c
+++ b/sys.c
@@ -242,57 +242,6 @@ out:
 	return res;
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
-int handle_sys_table(int argc, char **argv, char *file_path, void table_usage(void))
-{
-	int optchar, read_opt = USE_BAT_HOSTS;
-
-	while ((optchar = getopt(argc, argv, "hnw")) != -1) {
-		switch (optchar) {
-		case 'h':
-			table_usage();
-			return EXIT_SUCCESS;
-		case 'n':
-			read_opt &= ~USE_BAT_HOSTS;
-			break;
-		case 'w':
-			read_opt |= CLR_CONT_READ;
-			break;
-		default:
-			table_usage();
-			return EXIT_FAILURE;
-		}
-	}
-
-	return read_file(SYS_BATIF_PATH, file_path, read_opt);
-}
-
 void aggregation_usage(void)
 {
 	printf("Usage: batctl [options] aggregation [0|1]\n");
diff --git a/sys.h b/sys.h
index 01f9b95..4736f71 100644
--- a/sys.h
+++ b/sys.h
@@ -24,25 +24,17 @@
 #define SYS_BATIF_PATH "/sys/class/net/bat0/mesh/"
 #define SYS_LOG_LEVEL "parameters/debug"
 #define SYS_LOG "log"
-#define SYS_ORIGINATORS "originators"
-#define SYS_TRANSTABLE_LOCAL "transtable_local"
-#define SYS_TRANSTABLE_GLOBAL "transtable_global"
 #define SYS_AGGR "aggregate_ogm"
 #define SYS_VIS_MODE "vis_mode"
-#define SYS_VIS_DATA "vis_data"
 #define SYS_ORIG_INTERVAL "orig_interval"
 #define SYS_IFACE_PATH "/sys/class/net"
 #define SYS_MESH_IFACE_FMT SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
 #define SYS_IFACE_STATUS_FMT SYS_IFACE_PATH"/%s/batman_adv/iface_status"
 
-void originators_usage(void);
-void trans_local_usage(void);
-void trans_global_usage(void);
 void aggregation_usage(void);
 void vis_mode_usage(void);
 void orig_interval_usage(void);
 int log_print(int argc, char **argv);
 int interface(int argc, char **argv);
 int handle_loglevel(int argc, char **argv);
-int handle_sys_table(int argc, char **argv, char *file_path, void table_usage(void));
 int handle_sys_setting(int argc, char **argv, char *file_path, void setting_usage(void));
diff --git a/vis.c b/vis.c
index d09b8db..36152cf 100644
--- a/vis.c
+++ b/vis.c
@@ -31,7 +31,8 @@
 #include "vis.h"
 #include "functions.h"
 #include "bat-hosts.h"
-#include "sys.h"
+#include "debug.h"
+#include "debugfs.h"
 
 #define TQ_MAX_VALUE 255
 
@@ -57,9 +58,9 @@ static bool with_names = true;
 
 static void usage(void)
 {
-	printf("batctl vis dot {-h}{--no-HNA|-H} {--no-2nd|-2} {--numbers|-n}\n");
+	printf("batctl vis_data dot {-h}{--no-HNA|-H} {--no-2nd|-2} {--numbers|-n}\n");
 	printf("or\n");
-	printf("batctl vis json {-h}{--no-HNA|-H} {--no-2nd|-2} {--numbers|-n}\n");
+	printf("batctl vis_data json {-h}{--no-HNA|-H} {--no-2nd|-2} {--numbers|-n}\n");
 }
 
 static void dot_print_tq(char *orig, char *from, const long tq)
@@ -165,15 +166,16 @@ const struct funcs json_funcs = { json_print_tq,
 
 static FILE *open_vis(void)
 {
-	char full_path[500];
+	char full_path[MAX_PATH+1];
+	char *debugfs_mnt;
 
-	if (check_proc_dir("/proc") != EXIT_SUCCESS)
+	debugfs_mnt = debugfs_mount(NULL);
+	if (!debugfs_mnt) {
+		printf("Error - can't mount or find debugfs\n");
 		return NULL;
+	}
 
-	strncpy(full_path, SYS_BATIF_PATH, strlen(SYS_BATIF_PATH));
-	full_path[strlen(SYS_BATIF_PATH)] = '\0';
-	strncat(full_path, SYS_VIS_DATA,
-		sizeof(full_path) - strlen(full_path));
+	debugfs_make_path(DEBUG_BATIF_PATH "/" DEBUG_VIS_DATA, full_path, sizeof(full_path));
 
 	return fopen(full_path, "r");
 }
-- 
1.7.1

