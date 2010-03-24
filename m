Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Mar 2010 12:52:43 +0800
Message-Id: <1269406363-9593-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <201003241252.18954.lindner_marek@yahoo.de>
References: <201003241252.18954.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/5] batctl: adapt batctl to new sysfs
	interface handling
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
 batctl/Makefile     |    4 +-
 batctl/functions.c  |    3 +-
 batctl/functions.h  |    1 +
 batctl/main.c       |    3 +-
 batctl/man/batctl.8 |    6 +--
 batctl/proc.c       |  114 -------------------------------------------------
 batctl/proc.h       |   28 ------------
 batctl/sys.c        |  118 +++++++++++++++++++++++++++++++++++++++++++++++++++
 batctl/sys.h        |    4 ++
 9 files changed, 130 insertions(+), 151 deletions(-)
 delete mode 100644 batctl/proc.c
 delete mode 100644 batctl/proc.h

diff --git a/batctl/Makefile b/batctl/Makefile
index 595b996..db375f7 100644
--- a/batctl/Makefile
+++ b/batctl/Makefile
@@ -39,8 +39,8 @@ SRC_FILES = "\(\.c\)\|\(\.h\)\|\(Makefile\)\|\(INSTALL\)\|\(LIESMICH\)\|\(README
 EXTRA_MODULES_C := bisect.c
 EXTRA_MODULES_H := bisect.h
 
-SRC_C = main.c bat-hosts.c functions.c proc.c sys.c ping.c traceroute.c tcpdump.c list-batman.c hash.c vis.c $(EXTRA_MODULES_C)
-SRC_H = main.h bat-hosts.h functions.h proc.h sys.h ping.h traceroute.h tcpdump.h list-batman.h hash.h allocate.h vis.h $(EXTRA_MODULES_H)
+SRC_C = main.c bat-hosts.c functions.c sys.c ping.c traceroute.c tcpdump.c list-batman.c hash.c vis.c $(EXTRA_MODULES_C)
+SRC_H = main.h bat-hosts.h functions.h sys.h ping.h traceroute.h tcpdump.h list-batman.h hash.h allocate.h vis.h $(EXTRA_MODULES_H)
 SRC_O = $(SRC_C:.c=.o)
 
 PACKAGE_NAME = batctl
diff --git a/batctl/functions.c b/batctl/functions.c
index a7f4b77..7d8be51 100644
--- a/batctl/functions.c
+++ b/batctl/functions.c
@@ -164,7 +164,8 @@ open:
 	fp = fopen(full_path, "r");
 
 	if (!fp) {
-		printf("Error - can't open file '%s': %s\n", full_path, strerror(errno));
+		if (!(read_opt & SILENCE_ERRORS))
+			printf("Error - can't open file '%s': %s\n", full_path, strerror(errno));
 		goto out;
 	}
 
diff --git a/batctl/functions.h b/batctl/functions.h
index 3756392..63740d2 100644
--- a/batctl/functions.h
+++ b/batctl/functions.h
@@ -48,4 +48,5 @@ enum {
 	LOG_MODE = 0x08,
 	USE_READ_BUFF = 0x10,
 	SEARCH_ARGS = 0x20,
+	SILENCE_ERRORS = 0x40,
 };
diff --git a/batctl/main.c b/batctl/main.c
index da7fb4a..1cabcdd 100644
--- a/batctl/main.c
+++ b/batctl/main.c
@@ -29,7 +29,6 @@
 #include <string.h>
 
 #include "main.h"
-#include "proc.h"
 #include "sys.h"
 #include "ping.h"
 #include "traceroute.h"
@@ -41,7 +40,7 @@
 void print_usage(void) {
 	printf("Usage: batctl [options] commands \n");
 	printf("commands:\n");
-	printf(" \tinterface|if   [none|interface]  \tdisplay or modify the interface settings\n");
+	printf(" \tinterface|if   [add|del iface(s)]\tdisplay or modify the interface settings\n");
 	printf(" \toriginators|o                    \tdisplay the originator table\n");
 	printf(" \tinterval|it    [orig_interval]   \tdisplay or modify the originator interval (in ms)\n");
 	printf(" \tloglevel|ll    [level]           \tdisplay or modify the log level\n");
diff --git a/batctl/man/batctl.8 b/batctl/man/batctl.8
index 43af853..ad165bf 100644
--- a/batctl/man/batctl.8
+++ b/batctl/man/batctl.8
@@ -53,10 +53,8 @@ protocol.
 .br
 .TP
 .I \fBcommands:
-.IP "\fBinterface\fP|\fBif\fP     [\fBnone\fP|\fBinterface\fP]"
-If no parameter is given the current interface settings are displayed
-otherwise the parameter(s) are added as new interfaces. Use the "none"
-keyword to deactivate all interfaces.
+.IP "\fBinterface\fP|\fBif\fP     [\fBadd\fP|\fBdel iface(s)\fP]"
+If no parameter is given or the first parameter is neither "add" nor "del" the current interface settings are displayed. In order to add or delete interfaces specify "add" or "del" as first argument and append the interface names you wish to add or delete.
 .br
 .IP "\fBoriginators\fP|\fBo\fP    [\fB\-b\fP][\fB\-n\fP]"
 Once started batctl will display the list of announced gateways in the network. Use the "\-w" option to let batctl refresh the list every second. If "\-n" is given batctl will not replace the MAC addresses with bat\-host names in the output.
diff --git a/batctl/proc.c b/batctl/proc.c
deleted file mode 100644
index 192d4fb..0000000
--- a/batctl/proc.c
+++ /dev/null
@@ -1,114 +0,0 @@
-/*
- * Copyright (C) 2009 B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <lindner_marek@yahoo.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- */
-
-
-#include <sys/time.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-#include "main.h"
-#include "proc.h"
-#include "functions.h"
-
-static void interface_usage(void)
-{
-	printf("Usage: batctl interface [options] [none|interface] \n");
-	printf("options:\n");
-	printf(" \t -h print this help\n");
-}
-
-int interface(int argc, char **argv)
-{
-	int i, res, optchar;
-
-	while ((optchar = getopt(argc, argv, "h")) != -1) {
-		switch (optchar) {
-		case 'h':
-			interface_usage();
-			return EXIT_SUCCESS;
-		default:
-			interface_usage();
-			return EXIT_FAILURE;
-		}
-	}
-
-	if (argc == 1)
-		return read_file(PROC_ROOT_PATH, PROC_INTERFACES, SINGLE_READ);
-
-	for (i = 1; i < argc; i++) {
-		if (strcmp(argv[i], "none") == 0)
-			res = write_file(PROC_ROOT_PATH, PROC_INTERFACES, "", NULL);
-		else
-			res = write_file(PROC_ROOT_PATH, PROC_INTERFACES, argv[i], NULL);
-
-		if (res != EXIT_SUCCESS)
-			return res;
-	}
-
-	return EXIT_SUCCESS;
-}
-
-int handle_table(int argc, char **argv, char *file_path, void table_usage(void))
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
-	return read_file(PROC_ROOT_PATH, file_path, read_opt);
-}
-
-int handle_proc_setting(int argc, char **argv, char *file_path, void setting_usage(void))
-{
-	int optchar;
-
-	while ((optchar = getopt(argc, argv, "h")) != -1) {
-		switch (optchar) {
-		case 'h':
-			setting_usage();
-			return EXIT_SUCCESS;
-		default:
-			setting_usage();
-			return EXIT_FAILURE;
-		}
-	}
-
-	if (argc == 1)
-		return read_file(PROC_ROOT_PATH, file_path, SINGLE_READ);
-
-	return write_file(PROC_ROOT_PATH, file_path, argv[1], NULL);
-}
diff --git a/batctl/proc.h b/batctl/proc.h
deleted file mode 100644
index 61d6058..0000000
--- a/batctl/proc.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Copyright (C) 2009 B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <lindner_marek@yahoo.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
- */
-
-#define PROC_ROOT_PATH "/proc/net/batman-adv/"
-#define PROC_INTERFACES "interfaces"
-
-int interface(int argc, char **argv);
-
-int handle_table(int argc, char **argv, char *file_path, void table_usage(void));
-int handle_proc_setting(int argc, char **argv, char *file_path, void setting_usage(void));
diff --git a/batctl/sys.c b/batctl/sys.c
index cd8979a..1b0b784 100644
--- a/batctl/sys.c
+++ b/batctl/sys.c
@@ -25,11 +25,129 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <sys/types.h>
+#include <dirent.h>
 
 #include "main.h"
 #include "sys.h"
 #include "functions.h"
 
+#define PATH_BUFF_LEN 200
+
+static void interface_usage(void)
+{
+	printf("Usage: batctl interface [options] [add|del iface(s)] \n");
+	printf("options:\n");
+	printf(" \t -h print this help\n");
+}
+
+static int print_interfaces(void)
+{
+	DIR *iface_base_dir;
+	struct dirent *iface_dir;
+	char *path_buff;
+	int res;
+
+	path_buff = malloc(PATH_BUFF_LEN);
+	if (!path_buff) {
+		printf("Error - could not allocate path buffer: out of memory ?\n");
+		goto err;
+	}
+
+	iface_base_dir = opendir(SYS_IFACE_PATH);
+	if (!iface_base_dir) {
+		printf("Error - the directory '%s' could not be read: %s\n",
+		       SYS_IFACE_PATH, strerror(errno));
+		printf("Is the batman-adv module loaded and sysfs mounted ?\n");
+		goto err_buff;
+	}
+
+	while ((iface_dir = readdir(iface_base_dir)) != NULL) {
+		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, iface_dir->d_name);
+		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS);
+		if (res != EXIT_SUCCESS)
+			continue;
+
+		if (line_ptr[strlen(line_ptr) - 1] == '\n')
+			line_ptr[strlen(line_ptr) - 1] = '\0';
+
+		if (strcmp(line_ptr, "status: none") == 0)
+			goto free_line;
+
+		free(line_ptr);
+		line_ptr = NULL;
+
+		snprintf(path_buff, PATH_BUFF_LEN, SYS_IFACE_STATUS_FMT, iface_dir->d_name);
+		res = read_file("", path_buff, SINGLE_READ | USE_READ_BUFF | SILENCE_ERRORS);
+		if (res != EXIT_SUCCESS) {
+			printf("<error reading status>\n");
+			continue;
+		}
+
+		printf("%s: %s", iface_dir->d_name, line_ptr);
+
+free_line:
+		free(line_ptr);
+		line_ptr = NULL;
+	}
+
+	free(path_buff);
+	closedir(iface_base_dir);
+	return EXIT_SUCCESS;
+
+err_buff:
+	free(path_buff);
+err:
+	return EXIT_FAILURE;
+}
+
+int interface(int argc, char **argv)
+{
+	char *path_buff;
+	int i, res, optchar;
+
+	while ((optchar = getopt(argc, argv, "h")) != -1) {
+		switch (optchar) {
+		case 'h':
+			interface_usage();
+			return EXIT_SUCCESS;
+		default:
+			interface_usage();
+			return EXIT_FAILURE;
+		}
+	}
+
+	if ((argc == 1) ||
+	    ((strcmp(argv[1], "add") != 0) &&
+	    (strcmp(argv[1], "del") != 0)))
+		return print_interfaces();
+
+	path_buff = malloc(PATH_BUFF_LEN);
+	if (!path_buff) {
+		printf("Error - could not allocate path buffer: out of memory ?\n");
+		goto err;
+	}
+
+	for (i = 2; i < argc; i++) {
+		snprintf(path_buff, PATH_BUFF_LEN, SYS_MESH_IFACE_FMT, argv[i]);
+
+		if (strcmp(argv[1], "add") == 0)
+			res = write_file("", path_buff, "bat0", NULL);
+		else
+			res = write_file("", path_buff, "none", NULL);
+
+		if (res != EXIT_SUCCESS)
+			goto err_buff;
+	}
+
+	free(path_buff);
+	return EXIT_SUCCESS;
+
+err_buff:
+	free(path_buff);
+err:
+	return EXIT_FAILURE;
+}
 
 static void log_usage(void)
 {
diff --git a/batctl/sys.h b/batctl/sys.h
index 19d19f5..6d78622 100644
--- a/batctl/sys.h
+++ b/batctl/sys.h
@@ -34,6 +34,9 @@
 #define SYS_VIS_MODE "vis_mode"
 #define SYS_VIS_DATA "vis_data"
 #define SYS_ORIG_INTERVAL "orig_interval"
+#define SYS_IFACE_PATH "/sys/class/net"
+#define SYS_MESH_IFACE_FMT SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
+#define SYS_IFACE_STATUS_FMT SYS_IFACE_PATH"/%s/batman_adv/iface_status"
 
 void originators_usage(void);
 void trans_local_usage(void);
@@ -45,6 +48,7 @@ void gateways_usage(void);
 void vis_mode_usage(void);
 void orig_interval_usage(void);
 int log_print(int argc, char **argv);
+int interface(int argc, char **argv);
 int handle_loglevel(int argc, char **argv);
 int handle_sys_table(int argc, char **argv, char *file_path, void table_usage(void));
 int handle_sys_setting(int argc, char **argv, char *file_path, void setting_usage(void));
-- 
1.7.0

