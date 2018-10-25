Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:08 +0200
Message-Id: <20181025162245.19389-6-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 05/42] batctl: Move log command to
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
 Makefile |  1 +
 debug.c  | 41 -------------------------------------
 debug.h  |  1 -
 log.c    | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 log.h    | 28 ++++++++++++++++++++++++++
 main.c   |  1 +
 6 files changed, 100 insertions(+), 42 deletions(-)
 create mode 100644 log.c
 create mode 100644 log.h

diff --git a/Makefile b/Makefile
index 1271200..a988058 100755
--- a/Makefile
+++ b/Makefile
@@ -35,6 +35,7 @@ OBJ += hash.o
 OBJ += icmp_helper.o
 OBJ += interface.o
 OBJ += loglevel.o
+OBJ += log.o
 OBJ += main.o
 OBJ += netlink.o
 OBJ += ping.o
diff --git a/debug.c b/debug.c
index 185e26d..9bc4d0c 100644
--- a/debug.c
+++ b/debug.c
@@ -268,44 +268,3 @@ int debug_print_routing_algos(void)
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT, "", full_path, sizeof(full_path));
 	return read_file(full_path, DEBUG_ROUTING_ALGOS, 0, 0, 0, 0);
 }
-
-static void log_usage(void)
-{
-	fprintf(stderr, "Usage: batctl [options] log [parameters]\n");
-	fprintf(stderr, "parameters:\n");
-	fprintf(stderr, " \t -h print this help\n");
-	fprintf(stderr, " \t -n don't replace mac addresses with bat-host names\n");
-}
-
-int log_print(char *mesh_iface, int argc, char **argv)
-{
-	int optchar, res, read_opt = USE_BAT_HOSTS | LOG_MODE;
-	char full_path[MAX_PATH+1];
-	char *debugfs_mnt;
-
-	while ((optchar = getopt(argc, argv, "hn")) != -1) {
-		switch (optchar) {
-		case 'h':
-			log_usage();
-			return EXIT_SUCCESS;
-		case 'n':
-			read_opt &= ~USE_BAT_HOSTS;
-			break;
-		default:
-			log_usage();
-			return EXIT_FAILURE;
-		}
-	}
-
-	check_root_or_die("batctl log");
-
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt) {
-		fprintf(stderr, "Error - can't mount or find debugfs\n");
-		return EXIT_FAILURE;
-	}
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
-	res = read_file(full_path, DEBUG_LOG, read_opt, 0, 0, 0);
-	return res;
-}
diff --git a/debug.h b/debug.h
index 5508eaf..d9a2e3a 100644
--- a/debug.h
+++ b/debug.h
@@ -57,7 +57,6 @@ struct debug_table_data {
 extern const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM];
 
 int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv);
-int log_print(char *mesh_iface, int argc, char **argv);
 int debug_print_routing_algos(void);
 
 #endif
diff --git a/log.c b/log.c
new file mode 100644
index 0000000..fc31c66
--- /dev/null
+++ b/log.c
@@ -0,0 +1,70 @@
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
+
+#include "debug.h"
+#include "debugfs.h"
+#include "functions.h"
+
+static void log_usage(void)
+{
+	fprintf(stderr, "Usage: batctl [options] log [parameters]\n");
+	fprintf(stderr, "parameters:\n");
+	fprintf(stderr, " \t -h print this help\n");
+	fprintf(stderr, " \t -n don't replace mac addresses with bat-host names\n");
+}
+
+int log_print(char *mesh_iface, int argc, char **argv)
+{
+	int optchar, res, read_opt = USE_BAT_HOSTS | LOG_MODE;
+	char full_path[MAX_PATH+1];
+	char *debugfs_mnt;
+
+	while ((optchar = getopt(argc, argv, "hn")) != -1) {
+		switch (optchar) {
+		case 'h':
+			log_usage();
+			return EXIT_SUCCESS;
+		case 'n':
+			read_opt &= ~USE_BAT_HOSTS;
+			break;
+		default:
+			log_usage();
+			return EXIT_FAILURE;
+		}
+	}
+
+	check_root_or_die("batctl log");
+
+	debugfs_mnt = debugfs_mount(NULL);
+	if (!debugfs_mnt) {
+		fprintf(stderr, "Error - can't mount or find debugfs\n");
+		return EXIT_FAILURE;
+	}
+
+	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
+	res = read_file(full_path, DEBUG_LOG, read_opt, 0, 0, 0);
+	return res;
+}
diff --git a/log.h b/log.h
new file mode 100644
index 0000000..4ba00e3
--- /dev/null
+++ b/log.h
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
+#ifndef _BATCTL_LOG_H
+#define _BATCTL_LOG_H
+
+int log_print(char *mesh_iface, int argc, char **argv);
+
+#endif
diff --git a/main.c b/main.c
index ac4bc47..5b3e570 100644
--- a/main.c
+++ b/main.c
@@ -39,6 +39,7 @@
 #include "bisect_iv.h"
 #include "statistics.h"
 #include "loglevel.h"
+#include "log.h"
 #include "functions.h"
 
 char mesh_dfl_iface[] = "bat0";
-- 
2.11.0

