Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:54:50 +0200
Message-Id: <20181021225524.8155-5-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 04/38] batctl: Move loglevel command to
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
 Makefile   |   1 +
 loglevel.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 loglevel.h |  28 +++++++++++
 main.c     |   3 +-
 sys.c      | 114 ------------------------------------------
 sys.h      |   1 -
 6 files changed, 175 insertions(+), 116 deletions(-)
 create mode 100644 loglevel.c
 create mode 100644 loglevel.h

diff --git a/Makefile b/Makefile
index 6f620be..1271200 100755
--- a/Makefile
+++ b/Makefile
@@ -34,6 +34,7 @@ OBJ += genl.o
 OBJ += hash.o
 OBJ += icmp_helper.o
 OBJ += interface.o
+OBJ += loglevel.o
 OBJ += main.o
 OBJ += netlink.o
 OBJ += ping.o
diff --git a/loglevel.c b/loglevel.c
new file mode 100644
index 0000000..584cb37
--- /dev/null
+++ b/loglevel.c
@@ -0,0 +1,144 @@
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
+#include "main.h"
+#include "sys.h"
+
+static void log_level_usage(void)
+{
+	fprintf(stderr, "Usage: batctl [options] loglevel [parameters] [level[ level[ level]]...]\n");
+	fprintf(stderr, "parameters:\n");
+	fprintf(stderr, " \t -h print this help\n");
+	fprintf(stderr, "levels:\n");
+	fprintf(stderr, " \t none    Debug logging is disabled\n");
+	fprintf(stderr, " \t all     Print messages from all below\n");
+	fprintf(stderr, " \t batman  Messages related to routing / flooding / broadcasting\n");
+	fprintf(stderr, " \t routes  Messages related to route added / changed / deleted\n");
+	fprintf(stderr, " \t tt      Messages related to translation table operations\n");
+	fprintf(stderr, " \t bla     Messages related to bridge loop avoidance\n");
+	fprintf(stderr, " \t dat     Messages related to arp snooping and distributed arp table\n");
+	fprintf(stderr, " \t nc      Messages related to network coding\n");
+	fprintf(stderr, " \t mcast   Messages related to multicast\n");
+	fprintf(stderr, " \t tp      Messages related to throughput meter\n");
+}
+
+int loglevel(char *mesh_iface, int argc, char **argv)
+{
+	int optchar, res = EXIT_FAILURE;
+	int log_level = 0;
+	char *path_buff;
+	char str[4];
+	int i;
+
+	while ((optchar = getopt(argc, argv, "h")) != -1) {
+		switch (optchar) {
+		case 'h':
+			log_level_usage();
+			return EXIT_SUCCESS;
+		default:
+			log_level_usage();
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
+	if (argc != 1) {
+		check_root_or_die("batctl loglevel");
+
+		for (i = 1; i < argc; i++) {
+			if (strcmp(argv[i], "none") == 0) {
+				log_level = 0;
+				break;
+			} else if (strcmp(argv[i], "all") == 0) {
+				log_level = 255;
+				break;
+			} else if (strcmp(argv[i], "batman") == 0)
+				log_level |= BIT(0);
+			else if (strcmp(argv[i], "routes") == 0)
+				log_level |= BIT(1);
+			else if (strcmp(argv[i], "tt") == 0)
+				log_level |= BIT(2);
+			else if (strcmp(argv[i], "bla") == 0)
+				log_level |= BIT(3);
+			else if (strcmp(argv[i], "dat") == 0)
+				log_level |= BIT(4);
+			else if (strcmp(argv[i], "nc") == 0)
+				log_level |= BIT(5);
+			else if (strcmp(argv[i], "mcast") == 0)
+				log_level |= BIT(6);
+			else if (strcmp(argv[i], "tp") == 0)
+				log_level |= BIT(7);
+			else {
+				log_level_usage();
+				goto out;
+			}
+		}
+
+		snprintf(str, sizeof(str), "%i", log_level);
+		res = write_file(path_buff, SYS_LOG_LEVEL, str, NULL);
+		goto out;
+	}
+
+	res = read_file(path_buff, SYS_LOG_LEVEL, USE_READ_BUFF, 0, 0, 0);
+
+	if (res != EXIT_SUCCESS)
+		goto out;
+
+	log_level = strtol(line_ptr, (char **) NULL, 10);
+
+	printf("[%c] %s (%s)\n", (!log_level) ? 'x' : ' ',
+	       "all debug output disabled", "none");
+	printf("[%c] %s (%s)\n", (log_level & BIT(0)) ? 'x' : ' ',
+	       "messages related to routing / flooding / broadcasting",
+	       "batman");
+	printf("[%c] %s (%s)\n", (log_level & BIT(1)) ? 'x' : ' ',
+	       "messages related to route added / changed / deleted", "routes");
+	printf("[%c] %s (%s)\n", (log_level & BIT(2)) ? 'x' : ' ',
+	       "messages related to translation table operations", "tt");
+	printf("[%c] %s (%s)\n", (log_level & BIT(3)) ? 'x' : ' ',
+	       "messages related to bridge loop avoidance", "bla");
+	printf("[%c] %s (%s)\n", (log_level & BIT(4)) ? 'x' : ' ',
+	       "messages related to arp snooping and distributed arp table", "dat");
+	printf("[%c] %s (%s)\n", (log_level & BIT(5)) ? 'x' : ' ',
+	       "messages related to network coding", "nc");
+	printf("[%c] %s (%s)\n", (log_level & BIT(6)) ? 'x' : ' ',
+	       "messages related to multicast", "mcast");
+	printf("[%c] %s (%s)\n", (log_level & BIT(7)) ? 'x' : ' ',
+	       "messages related to throughput meter", "tp");
+
+out:
+	free(path_buff);
+	return res;
+}
diff --git a/loglevel.h b/loglevel.h
new file mode 100644
index 0000000..2644f46
--- /dev/null
+++ b/loglevel.h
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
+#ifndef _BATCTL_LOGLEVEL_H
+#define _BATCTL_LOGLEVEL_H
+
+int loglevel(char *mesh_iface, int argc, char **argv);
+
+#endif
diff --git a/main.c b/main.c
index 3a6011b..ac4bc47 100644
--- a/main.c
+++ b/main.c
@@ -38,6 +38,7 @@
 #include "tp_meter.h"
 #include "bisect_iv.h"
 #include "statistics.h"
+#include "loglevel.h"
 #include "functions.h"
 
 char mesh_dfl_iface[] = "bat0";
@@ -169,7 +170,7 @@ int main(int argc, char **argv)
 
 	} else if ((strcmp(argv[1], "loglevel") == 0) || (strcmp(argv[1], "ll") == 0)) {
 
-		ret = handle_loglevel(mesh_iface, argc - 1, argv + 1);
+		ret = loglevel(mesh_iface, argc - 1, argv + 1);
 
 	} else if ((strcmp(argv[1], "log") == 0) || (strcmp(argv[1], "l") == 0)) {
 
diff --git a/sys.c b/sys.c
index e0c2073..366f7a2 100644
--- a/sys.c
+++ b/sys.c
@@ -117,120 +117,6 @@ const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM] = {
 	},
 };
 
-static void log_level_usage(void)
-{
-	fprintf(stderr, "Usage: batctl [options] loglevel [parameters] [level[ level[ level]]...]\n");
-	fprintf(stderr, "parameters:\n");
-	fprintf(stderr, " \t -h print this help\n");
-	fprintf(stderr, "levels:\n");
-	fprintf(stderr, " \t none    Debug logging is disabled\n");
-	fprintf(stderr, " \t all     Print messages from all below\n");
-	fprintf(stderr, " \t batman  Messages related to routing / flooding / broadcasting\n");
-	fprintf(stderr, " \t routes  Messages related to route added / changed / deleted\n");
-	fprintf(stderr, " \t tt      Messages related to translation table operations\n");
-	fprintf(stderr, " \t bla     Messages related to bridge loop avoidance\n");
-	fprintf(stderr, " \t dat     Messages related to arp snooping and distributed arp table\n");
-	fprintf(stderr, " \t nc      Messages related to network coding\n");
-	fprintf(stderr, " \t mcast   Messages related to multicast\n");
-	fprintf(stderr, " \t tp      Messages related to throughput meter\n");
-}
-
-int handle_loglevel(char *mesh_iface, int argc, char **argv)
-{
-	int optchar, res = EXIT_FAILURE;
-	int log_level = 0;
-	char *path_buff;
-	char str[4];
-	int i;
-
-	while ((optchar = getopt(argc, argv, "h")) != -1) {
-		switch (optchar) {
-		case 'h':
-			log_level_usage();
-			return EXIT_SUCCESS;
-		default:
-			log_level_usage();
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
-	if (argc != 1) {
-		check_root_or_die("batctl loglevel");
-
-		for (i = 1; i < argc; i++) {
-			if (strcmp(argv[i], "none") == 0) {
-				log_level = 0;
-				break;
-			} else if (strcmp(argv[i], "all") == 0) {
-				log_level = 255;
-				break;
-			} else if (strcmp(argv[i], "batman") == 0)
-				log_level |= BIT(0);
-			else if (strcmp(argv[i], "routes") == 0)
-				log_level |= BIT(1);
-			else if (strcmp(argv[i], "tt") == 0)
-				log_level |= BIT(2);
-			else if (strcmp(argv[i], "bla") == 0)
-				log_level |= BIT(3);
-			else if (strcmp(argv[i], "dat") == 0)
-				log_level |= BIT(4);
-			else if (strcmp(argv[i], "nc") == 0)
-				log_level |= BIT(5);
-			else if (strcmp(argv[i], "mcast") == 0)
-				log_level |= BIT(6);
-			else if (strcmp(argv[i], "tp") == 0)
-				log_level |= BIT(7);
-			else {
-				log_level_usage();
-				goto out;
-			}
-		}
-
-		snprintf(str, sizeof(str), "%i", log_level);
-		res = write_file(path_buff, SYS_LOG_LEVEL, str, NULL);
-		goto out;
-	}
-
-	res = read_file(path_buff, SYS_LOG_LEVEL, USE_READ_BUFF, 0, 0, 0);
-
-	if (res != EXIT_SUCCESS)
-		goto out;
-
-	log_level = strtol(line_ptr, (char **) NULL, 10);
-
-	printf("[%c] %s (%s)\n", (!log_level) ? 'x' : ' ',
-	       "all debug output disabled", "none");
-	printf("[%c] %s (%s)\n", (log_level & BIT(0)) ? 'x' : ' ',
-	       "messages related to routing / flooding / broadcasting",
-	       "batman");
-	printf("[%c] %s (%s)\n", (log_level & BIT(1)) ? 'x' : ' ',
-	       "messages related to route added / changed / deleted", "routes");
-	printf("[%c] %s (%s)\n", (log_level & BIT(2)) ? 'x' : ' ',
-	       "messages related to translation table operations", "tt");
-	printf("[%c] %s (%s)\n", (log_level & BIT(3)) ? 'x' : ' ',
-	       "messages related to bridge loop avoidance", "bla");
-	printf("[%c] %s (%s)\n", (log_level & BIT(4)) ? 'x' : ' ',
-	       "messages related to arp snooping and distributed arp table", "dat");
-	printf("[%c] %s (%s)\n", (log_level & BIT(5)) ? 'x' : ' ',
-	       "messages related to network coding", "nc");
-	printf("[%c] %s (%s)\n", (log_level & BIT(6)) ? 'x' : ' ',
-	       "messages related to multicast", "mcast");
-	printf("[%c] %s (%s)\n", (log_level & BIT(7)) ? 'x' : ' ',
-	       "messages related to throughput meter", "tp");
-
-out:
-	free(path_buff);
-	return res;
-}
-
 static void settings_usage(int setting)
 {
 	fprintf(stderr, "Usage: batctl [options] %s|%s [parameters]",
diff --git a/sys.h b/sys.h
index 95b2a1e..5e98ab1 100644
--- a/sys.h
+++ b/sys.h
@@ -71,7 +71,6 @@ extern const char *sysfs_param_enable[];
 extern const char *sysfs_param_server[];
 extern const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM];
 
-int handle_loglevel(char *mesh_iface, int argc, char **argv);
 int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv);
 int handle_gw_setting(char *mesh_iface, int argc, char **argv);
 int handle_ra_setting(int argc, char **argv);
-- 
2.19.1

