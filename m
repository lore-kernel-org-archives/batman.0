Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:54:52 +0200
Message-Id: <20181021225524.8155-7-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 06/38] batctl: Move gw_mode command to
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
 Makefile  |   1 +
 gw_mode.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 gw_mode.h |  28 +++++++++
 main.c    |   3 +-
 sys.c     | 129 -----------------------------------------
 sys.h     |  10 ----
 6 files changed, 199 insertions(+), 140 deletions(-)
 create mode 100644 gw_mode.c
 create mode 100644 gw_mode.h

diff --git a/Makefile b/Makefile
index a988058..9b960b6 100755
--- a/Makefile
+++ b/Makefile
@@ -31,6 +31,7 @@ OBJ += debugfs.o
 OBJ += debug.o
 OBJ += functions.o
 OBJ += genl.o
+OBJ += gw_mode.o
 OBJ += hash.o
 OBJ += icmp_helper.o
 OBJ += interface.o
diff --git a/gw_mode.c b/gw_mode.c
new file mode 100644
index 0000000..a92644e
--- /dev/null
+++ b/gw_mode.c
@@ -0,0 +1,168 @@
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
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "functions.h"
+#include "sys.h"
+
+#define SYS_GW_MODE		"gw_mode"
+#define SYS_GW_SEL		"gw_sel_class"
+#define SYS_GW_BW		"gw_bandwidth"
+
+enum gw_modes {
+	GW_MODE_OFF,
+	GW_MODE_CLIENT,
+	GW_MODE_SERVER,
+};
+
+static void gw_mode_usage(void)
+{
+	fprintf(stderr, "Usage: batctl [options] gw_mode [mode] [sel_class|bandwidth]\n");
+	fprintf(stderr, "options:\n");
+	fprintf(stderr, " \t -h print this help\n");
+}
+
+int gw_mode(char *mesh_iface, int argc, char **argv)
+{
+	int optchar, res = EXIT_FAILURE;
+	char *path_buff, gw_mode;
+	const char **ptr;
+
+	while ((optchar = getopt(argc, argv, "h")) != -1) {
+		switch (optchar) {
+		case 'h':
+			gw_mode_usage();
+			return EXIT_SUCCESS;
+		default:
+			gw_mode_usage();
+			return EXIT_FAILURE;
+		}
+	}
+
+	path_buff = malloc(PATH_BUFF_LEN);
+	if (!path_buff) {
+		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
+		return EXIT_FAILURE;
+	}
+
+	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
+
+	if (argc == 1) {
+		res = read_file(path_buff, SYS_GW_MODE, USE_READ_BUFF, 0, 0, 0);
+
+		if (res != EXIT_SUCCESS)
+			goto out;
+
+		if (line_ptr[strlen(line_ptr) - 1] == '\n')
+			line_ptr[strlen(line_ptr) - 1] = '\0';
+
+		if (strcmp(line_ptr, "client") == 0)
+			gw_mode = GW_MODE_CLIENT;
+		else if (strcmp(line_ptr, "server") == 0)
+			gw_mode = GW_MODE_SERVER;
+		else
+			gw_mode = GW_MODE_OFF;
+
+		free(line_ptr);
+		line_ptr = NULL;
+
+		switch (gw_mode) {
+		case GW_MODE_CLIENT:
+			res = read_file(path_buff, SYS_GW_SEL, USE_READ_BUFF, 0, 0, 0);
+			break;
+		case GW_MODE_SERVER:
+			res = read_file(path_buff, SYS_GW_BW, USE_READ_BUFF, 0, 0, 0);
+			break;
+		default:
+			printf("off\n");
+			goto out;
+		}
+
+		if (res != EXIT_SUCCESS)
+			goto out;
+
+		if (line_ptr[strlen(line_ptr) - 1] == '\n')
+			line_ptr[strlen(line_ptr) - 1] = '\0';
+
+		switch (gw_mode) {
+		case GW_MODE_CLIENT:
+			printf("client (selection class: %s)\n", line_ptr);
+			break;
+		case GW_MODE_SERVER:
+			printf("server (announced bw: %s)\n", line_ptr);
+			break;
+		default:
+			goto out;
+		}
+
+		free(line_ptr);
+		line_ptr = NULL;
+		goto out;
+	}
+
+	check_root_or_die("batctl gw_mode");
+
+	if (strcmp(argv[1], "client") == 0)
+		gw_mode = GW_MODE_CLIENT;
+	else if (strcmp(argv[1], "server") == 0)
+		gw_mode = GW_MODE_SERVER;
+	else if (strcmp(argv[1], "off") == 0)
+		gw_mode = GW_MODE_OFF;
+	else
+		goto opt_err;
+
+	res = write_file(path_buff, SYS_GW_MODE, argv[1], NULL);
+	if (res != EXIT_SUCCESS)
+		goto out;
+
+	if (argc == 2)
+		goto out;
+
+	switch (gw_mode) {
+	case GW_MODE_CLIENT:
+		res = write_file(path_buff, SYS_GW_SEL, argv[2], NULL);
+		break;
+	case GW_MODE_SERVER:
+		res = write_file(path_buff, SYS_GW_BW, argv[2], NULL);
+		break;
+	}
+
+	goto out;
+
+opt_err:
+	fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
+	fprintf(stderr, "The following values are allowed:\n");
+
+	ptr = sysfs_param_server;
+	while (*ptr) {
+		fprintf(stderr, " * %s\n", *ptr);
+		ptr++;
+	}
+
+out:
+	free(path_buff);
+	return res;
+}
diff --git a/gw_mode.h b/gw_mode.h
new file mode 100644
index 0000000..d4d3fb5
--- /dev/null
+++ b/gw_mode.h
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
+#ifndef _BATCTL_GW_MODE_H
+#define _BATCTL_GW_MODE_H
+
+int gw_mode(char *mesh_iface, int argc, char **argv);
+
+#endif
diff --git a/main.c b/main.c
index 5b3e570..6160a72 100644
--- a/main.c
+++ b/main.c
@@ -40,6 +40,7 @@
 #include "statistics.h"
 #include "loglevel.h"
 #include "log.h"
+#include "gw_mode.h"
 #include "functions.h"
 
 char mesh_dfl_iface[] = "bat0";
@@ -179,7 +180,7 @@ int main(int argc, char **argv)
 
 	} else if ((strcmp(argv[1], "gw_mode") == 0) || (strcmp(argv[1], "gw") == 0)) {
 
-		ret = handle_gw_setting(mesh_iface, argc - 1, argv + 1);
+		ret = gw_mode(mesh_iface, argc - 1, argv + 1);
 
 	} else if ((strcmp(argv[1], "statistics") == 0) || (strcmp(argv[1], "s") == 0)) {
 
diff --git a/sys.c b/sys.c
index 366f7a2..14f322c 100644
--- a/sys.c
+++ b/sys.c
@@ -206,135 +206,6 @@ int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv)
 	return res;
 }
 
-static void gw_mode_usage(void)
-{
-	fprintf(stderr, "Usage: batctl [options] gw_mode [mode] [sel_class|bandwidth]\n");
-	fprintf(stderr, "options:\n");
-	fprintf(stderr, " \t -h print this help\n");
-}
-
-int handle_gw_setting(char *mesh_iface, int argc, char **argv)
-{
-	int optchar, res = EXIT_FAILURE;
-	char *path_buff, gw_mode;
-	const char **ptr;
-
-	while ((optchar = getopt(argc, argv, "h")) != -1) {
-		switch (optchar) {
-		case 'h':
-			gw_mode_usage();
-			return EXIT_SUCCESS;
-		default:
-			gw_mode_usage();
-			return EXIT_FAILURE;
-		}
-	}
-
-	path_buff = malloc(PATH_BUFF_LEN);
-	if (!path_buff) {
-		fprintf(stderr, "Error - could not allocate path buffer: out of memory ?\n");
-		return EXIT_FAILURE;
-	}
-
-	snprintf(path_buff, PATH_BUFF_LEN, SYS_BATIF_PATH_FMT, mesh_iface);
-
-	if (argc == 1) {
-		res = read_file(path_buff, SYS_GW_MODE, USE_READ_BUFF, 0, 0, 0);
-
-		if (res != EXIT_SUCCESS)
-			goto out;
-
-		if (line_ptr[strlen(line_ptr) - 1] == '\n')
-			line_ptr[strlen(line_ptr) - 1] = '\0';
-
-		if (strcmp(line_ptr, "client") == 0)
-			gw_mode = GW_MODE_CLIENT;
-		else if (strcmp(line_ptr, "server") == 0)
-			gw_mode = GW_MODE_SERVER;
-		else
-			gw_mode = GW_MODE_OFF;
-
-		free(line_ptr);
-		line_ptr = NULL;
-
-		switch (gw_mode) {
-		case GW_MODE_CLIENT:
-			res = read_file(path_buff, SYS_GW_SEL, USE_READ_BUFF, 0, 0, 0);
-			break;
-		case GW_MODE_SERVER:
-			res = read_file(path_buff, SYS_GW_BW, USE_READ_BUFF, 0, 0, 0);
-			break;
-		default:
-			printf("off\n");
-			goto out;
-		}
-
-		if (res != EXIT_SUCCESS)
-			goto out;
-
-		if (line_ptr[strlen(line_ptr) - 1] == '\n')
-			line_ptr[strlen(line_ptr) - 1] = '\0';
-
-		switch (gw_mode) {
-		case GW_MODE_CLIENT:
-			printf("client (selection class: %s)\n", line_ptr);
-			break;
-		case GW_MODE_SERVER:
-			printf("server (announced bw: %s)\n", line_ptr);
-			break;
-		default:
-			goto out;
-		}
-
-		free(line_ptr);
-		line_ptr = NULL;
-		goto out;
-	}
-
-	check_root_or_die("batctl gw_mode");
-
-	if (strcmp(argv[1], "client") == 0)
-		gw_mode = GW_MODE_CLIENT;
-	else if (strcmp(argv[1], "server") == 0)
-		gw_mode = GW_MODE_SERVER;
-	else if (strcmp(argv[1], "off") == 0)
-		gw_mode = GW_MODE_OFF;
-	else
-		goto opt_err;
-
-	res = write_file(path_buff, SYS_GW_MODE, argv[1], NULL);
-	if (res != EXIT_SUCCESS)
-		goto out;
-
-	if (argc == 2)
-		goto out;
-
-	switch (gw_mode) {
-	case GW_MODE_CLIENT:
-		res = write_file(path_buff, SYS_GW_SEL, argv[2], NULL);
-		break;
-	case GW_MODE_SERVER:
-		res = write_file(path_buff, SYS_GW_BW, argv[2], NULL);
-		break;
-	}
-
-	goto out;
-
-opt_err:
-	fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
-	fprintf(stderr, "The following values are allowed:\n");
-
-	ptr = sysfs_param_server;
-	while (*ptr) {
-		fprintf(stderr, " * %s\n", *ptr);
-		ptr++;
-	}
-
-out:
-	free(path_buff);
-	return res;
-}
-
 static void ra_mode_usage(void)
 {
 	fprintf(stderr, "Usage: batctl [options] routing_algo [algorithm]\n");
diff --git a/sys.h b/sys.h
index 5e98ab1..e1d0f9b 100644
--- a/sys.h
+++ b/sys.h
@@ -28,9 +28,6 @@
 #define SYS_BATIF_PATH_FMT	"/sys/class/net/%s/mesh/"
 #define SYS_LOG_LEVEL		"log_level"
 #define SYS_LOG			"log"
-#define SYS_GW_MODE		"gw_mode"
-#define SYS_GW_SEL		"gw_sel_class"
-#define SYS_GW_BW		"gw_bandwidth"
 #define SYS_IFACE_PATH		"/sys/class/net"
 #define SYS_IFACE_DIR		SYS_IFACE_PATH"/%s/"
 #define SYS_MESH_IFACE_FMT	SYS_IFACE_PATH"/%s/batman_adv/mesh_iface"
@@ -54,12 +51,6 @@ enum batctl_settings_list {
 	BATCTL_SETTINGS_NUM,
 };
 
-enum gw_modes {
-	GW_MODE_OFF,
-	GW_MODE_CLIENT,
-	GW_MODE_SERVER,
-};
-
 struct settings_data {
 	const char opt_long[OPT_LONG_MAX_LEN];
 	const char opt_short[OPT_SHORT_MAX_LEN];
@@ -72,7 +63,6 @@ extern const char *sysfs_param_server[];
 extern const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM];
 
 int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv);
-int handle_gw_setting(char *mesh_iface, int argc, char **argv);
 int handle_ra_setting(int argc, char **argv);
 
 #endif
-- 
2.19.1

