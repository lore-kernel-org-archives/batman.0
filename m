Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:54:53 +0200
Message-Id: <20181021225524.8155-8-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 07/38] batctl: Move routing_algo command to
 separate file
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

More complex commands in batctl are stored in separate files which are
called like the actual command name. This makes it easier to group
functionality and detect which parts belong to a more complex construct.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile       |   1 +
 main.c         |   3 +-
 routing_algo.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++
 routing_algo.h |  28 +++++++++++
 sys.c          |  92 -----------------------------------
 sys.h          |   3 --
 6 files changed, 158 insertions(+), 96 deletions(-)
 create mode 100644 routing_algo.c
 create mode 100644 routing_algo.h

diff --git a/Makefile b/Makefile
index 9b960b6..9ff4fe4 100755
--- a/Makefile
+++ b/Makefile
@@ -40,6 +40,7 @@ OBJ += log.o
 OBJ += main.o
 OBJ += netlink.o
 OBJ += ping.o
+OBJ += routing_algo.o
 OBJ += statistics.o
 OBJ += sys.o
 OBJ += tcpdump.o
diff --git a/main.c b/main.c
index 6160a72..4abee13 100644
--- a/main.c
+++ b/main.c
@@ -41,6 +41,7 @@
 #include "loglevel.h"
 #include "log.h"
 #include "gw_mode.h"
+#include "routing_algo.h"
 #include "functions.h"
 
 char mesh_dfl_iface[] = "bat0";
@@ -153,7 +154,7 @@ int main(int argc, char **argv)
 #endif
 	} else if ((strcmp(argv[1], "routing_algo") == 0) || (strcmp(argv[1], "ra") == 0)) {
 
-		ret = handle_ra_setting(argc - 1, argv + 1);
+		ret = routing_algo(mesh_iface, argc - 1, argv + 1);
 
 	} else if (check_mesh_iface(mesh_iface) < 0) {
 		fprintf(stderr, "Error - interface %s is not present or not a batman-adv interface\n", mesh_iface);
diff --git a/routing_algo.c b/routing_algo.c
new file mode 100644
index 0000000..89af6c5
--- /dev/null
+++ b/routing_algo.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <mareklindner@neomailbox.ch>
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
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#include <dirent.h>
+#include <errno.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "functions.h"
+#include "main.h"
+#include "sys.h"
+
+#define SYS_SELECTED_RA_PATH	"/sys/module/batman_adv/parameters/routing_algo"
+#define SYS_ROUTING_ALGO_FMT	SYS_IFACE_PATH"/%s/mesh/routing_algo"
+
+static void ra_mode_usage(void)
+{
+	fprintf(stderr, "Usage: batctl [options] routing_algo [algorithm]\n");
+	fprintf(stderr, "options:\n");
+	fprintf(stderr, " \t -h print this help\n");
+}
+
+int routing_algo(char *mesh_iface __maybe_unused, int argc, char **argv)
+{
+	DIR *iface_base_dir;
+	struct dirent *iface_dir;
+	int optchar;
+	char *path_buff;
+	int res = EXIT_FAILURE;
+	int first_iface = 1;
+
+	while ((optchar = getopt(argc, argv, "h")) != -1) {
+		switch (optchar) {
+		case 'h':
+			ra_mode_usage();
+			return EXIT_SUCCESS;
+		default:
+			ra_mode_usage();
+			return EXIT_FAILURE;
+		}
+	}
+
+	check_root_or_die("batctl routing_algo");
+
+	if (argc == 2) {
+		res = write_file(SYS_SELECTED_RA_PATH, "", argv[1], NULL);
+		goto out;
+	}
+
+	path_buff = malloc(PATH_BUFF_LEN);
+	if (!path_buff) {
+		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+		goto out;
+	}
+
+	iface_base_dir = opendir(SYS_IFACE_PATH);
+	if (!iface_base_dir) {
+		fprintf(stderr, "Error - the directory '%s' could not be read: %s\n",
+			SYS_IFACE_PATH, strerror(errno));
+		fprintf(stderr, "Is the batman-adv module loaded and sysfs mounted ?\n");
+		goto free_buff;
+	}
+
+	while ((iface_dir = readdir(iface_base_dir)) != NULL) {
+		snprintf(path_buff, PATH_BUFF_LEN, SYS_ROUTING_ALGO_FMT, iface_dir->d_name);
+		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
+		if (res != EXIT_SUCCESS)
+			continue;
+
+		if (line_ptr[strlen(line_ptr) - 1] == '\n')
+			line_ptr[strlen(line_ptr) - 1] = '\0';
+
+		if (first_iface) {
+			first_iface = 0;
+			printf("Active routing protocol configuration:\n");
+		}
+
+		printf(" * %s: %s\n", iface_dir->d_name, line_ptr);
+
+		free(line_ptr);
+		line_ptr = NULL;
+	}
+
+	closedir(iface_base_dir);
+	free(path_buff);
+
+	if (!first_iface)
+		printf("\n");
+
+	res = read_file("", SYS_SELECTED_RA_PATH, USE_READ_BUFF, 0, 0, 0);
+	if (res != EXIT_SUCCESS)
+		return EXIT_FAILURE;
+
+	printf("Selected routing algorithm (used when next batX interface is created):\n");
+	printf(" => %s\n", line_ptr);
+	free(line_ptr);
+	line_ptr = NULL;
+
+	print_routing_algos();
+	return EXIT_SUCCESS;
+
+free_buff:
+	free(path_buff);
+out:
+	return res;
+}
diff --git a/routing_algo.h b/routing_algo.h
new file mode 100644
index 0000000..db246c6
--- /dev/null
+++ b/routing_algo.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <mareklindner@neomailbox.ch>
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
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#ifndef _BATCTL_ROUTING_ALGO_H
+#define _BATCTL_ROUTING_ALGO_H
+
+int routing_algo(char *mesh_iface, int argc, char **argv);
+
+#endif
diff --git a/sys.c b/sys.c
index 14f322c..2cb288e 100644
--- a/sys.c
+++ b/sys.c
@@ -205,95 +205,3 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 	free(base_dev);
 	return res;
 }
-
-static void ra_mode_usage(void)
-{
-	fprintf(stderr, "Usage: batctl [options] routing_algo [algorithm]\n");
-	fprintf(stderr, "options:\n");
-	fprintf(stderr, " \t -h print this help\n");
-}
-
-int handle_ra_setting(int argc, char **argv)
-{
-	DIR *iface_base_dir;
-	struct dirent *iface_dir;
-	int optchar;
-	char *path_buff;
-	int res = EXIT_FAILURE;
-	int first_iface = 1;
-
-	while ((optchar = getopt(argc, argv, "h")) != -1) {
-		switch (optchar) {
-		case 'h':
-			ra_mode_usage();
-			return EXIT_SUCCESS;
-		default:
-			ra_mode_usage();
-			return EXIT_FAILURE;
-		}
-	}
-
-	check_root_or_die("batctl routing_algo");
-
-	if (argc == 2) {
-		res = write_file(SYS_SELECTED_RA_PATH, "", argv[1], NULL);
-		goto out;
-	}
-
-	path_buff = malloc(PATH_BUFF_LEN);
-	if (!path_buff) {
-		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
-		goto out;
-	}
-
-	iface_base_dir = opendir(SYS_IFACE_PATH);
-	if (!iface_base_dir) {
-		fprintf(stderr, "Error - the directory '%s' could not be read: %s\n",
-			SYS_IFACE_PATH, strerror(errno));
-		fprintf(stderr, "Is the batman-adv module loaded and sysfs mounted ?\n");
-		goto free_buff;
-	}
-
-	while ((iface_dir = readdir(iface_base_dir)) != NULL) {
-		snprintf(path_buff, PATH_BUFF_LEN, SYS_ROUTING_ALGO_FMT, iface_dir->d_name);
-		res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
-		if (res != EXIT_SUCCESS)
-			continue;
-
-		if (line_ptr[strlen(line_ptr) - 1] == '\n')
-			line_ptr[strlen(line_ptr) - 1] = '\0';
-
-		if (first_iface) {
-			first_iface = 0;
-			printf("Active routing protocol configuration:\n");
-		}
-
-		printf(" * %s: %s\n", iface_dir->d_name, line_ptr);
-
-		free(line_ptr);
-		line_ptr = NULL;
-	}
-
-	closedir(iface_base_dir);
-	free(path_buff);
-
-	if (!first_iface)
-		printf("\n");
-
-	res = read_file("", SYS_SELECTED_RA_PATH, USE_READ_BUFF, 0, 0, 0);
-	if (res != EXIT_SUCCESS)
-		return EXIT_FAILURE;
-
-	printf("Selected routing algorithm (used when next batX interface is created):\n");
-	printf(" => %s\n", line_ptr);
-	free(line_ptr);
-	line_ptr = NULL;
-
-	print_routing_algos();
-	return EXIT_SUCCESS;
-
-free_buff:
-	free(path_buff);
-out:
-	return res;
-}
diff --git a/sys.h b/sys.h
index e1d0f9b..5f0280f 100644
--- a/sys.h
+++ b/sys.h
@@ -33,8 +33,6 @@
 #define SYS_MESH_IFACE_FMT	SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
 #define SYS_IFACE_STATUS_FMT	SYS_IFACE_PATH"/%s/batman_adv/iface_status"
 #define SYS_VLAN_PATH		SYS_IFACE_PATH"/%s/mesh/vlan%d/"
-#define SYS_ROUTING_ALGO_FMT	SYS_IFACE_PATH"/%s/mesh/routing_algo"
-#define SYS_SELECTED_RA_PATH	"/sys/module/batman_adv/parameters/routing_algo"
 #define VLAN_ID_MAX_LEN		4
 
 enum batctl_settings_list {
@@ -63,6 +61,5 @@ extern const char *sysfs_param_server[];
 extern const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM];
 
 int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv);
-int handle_ra_setting(int argc, char **argv);
 
 #endif
-- 
2.19.1

