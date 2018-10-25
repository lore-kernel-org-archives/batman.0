Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:14 +0200
Message-Id: <20181025162245.19389-12-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 11/42] batctl: Use command structure for
 remaining subcommands
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

The command datastructure was extended to be usable for mesh_iface and
non-mesh_iface subcommands. The referenced subcommands only have to use the
same function signature to work correctly.

The introduction of dummy parameter to the functions allows therefore to
convert all non-settings and non-debug-tables subcommands to the new
infrastructure.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bisect_iv.c    |  5 ++++-
 bisect_iv.h    |  4 ----
 interface.c    |  6 +++---
 interface.h    | 30 ------------------------------
 main.c         | 23 +----------------------
 routing_algo.c |  4 +++-
 routing_algo.h | 28 ----------------------------
 tcpdump.c      |  4 +++-
 tcpdump.h      |  2 --
 9 files changed, 14 insertions(+), 92 deletions(-)
 delete mode 100644 interface.h
 delete mode 100644 routing_algo.h

diff --git a/bisect_iv.c b/bisect_iv.c
index d71ceda..f87f915 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -32,6 +32,7 @@
 #include "bisect_iv.h"
 #include "bat-hosts.h"
 #include "hash.h"
+#include "main.h"
 #include "functions.h"
 
 static struct hashtable_t *node_hash = NULL;
@@ -1440,7 +1441,7 @@ static int get_orig_addr(char *orig_name, char *orig_addr)
 	return 0;
 }
 
-int bisect_iv(int argc, char **argv)
+static int bisect_iv(char *mesh_iface __maybe_unused, int argc, char **argv)
 {
 	int ret = EXIT_FAILURE, res, optchar, found_args = 1;
 	int read_opt = USE_BAT_HOSTS, num_parsed_files;
@@ -1593,3 +1594,5 @@ int bisect_iv(int argc, char **argv)
 	bat_hosts_free();
 	return ret;
 }
+
+COMMAND(bisect_iv, "bisect_iv", 0);
diff --git a/bisect_iv.h b/bisect_iv.h
index 7932c2f..5f5200c 100644
--- a/bisect_iv.h
+++ b/bisect_iv.h
@@ -33,10 +33,6 @@
 #define RT_FLAG_UPDATE 2
 #define RT_FLAG_DELETE 3
 
-int bisect_iv(int argc, char **argv);
-
-
-
 struct bat_node {
 	char name[NAME_LEN];
 	struct list_head orig_event_list;
diff --git a/interface.c b/interface.c
index 5951b47..485ed0a 100644
--- a/interface.c
+++ b/interface.c
@@ -20,8 +20,6 @@
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
-#include "interface.h"
-
 #include <unistd.h>
 #include <stdio.h>
 #include <stdbool.h>
@@ -299,7 +297,7 @@ static int set_master_interface(const char *iface, unsigned int ifmaster)
 	return err;
 }
 
-int interface(char *mesh_iface, int argc, char **argv)
+static int interface(char *mesh_iface, int argc, char **argv)
 {
 	int i, optchar;
 	int ret;
@@ -459,3 +457,5 @@ int interface(char *mesh_iface, int argc, char **argv)
 err:
 	return EXIT_FAILURE;
 }
+
+COMMAND(interface, "if", 0);
diff --git a/interface.h b/interface.h
deleted file mode 100644
index 83ca129..0000000
--- a/interface.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <mareklindner@neomailbox.ch>
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
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#ifndef _BATCTL_INTERFACE_H
-#define _BATCTL_INTERFACE_H
-
-#include "main.h"
-
-int interface(char *mesh_iface, int argc, char **argv);
-
-#endif
diff --git a/main.c b/main.c
index dacfb12..fa4371c 100644
--- a/main.c
+++ b/main.c
@@ -30,10 +30,6 @@
 #include "main.h"
 #include "sys.h"
 #include "debug.h"
-#include "interface.h"
-#include "tcpdump.h"
-#include "bisect_iv.h"
-#include "routing_algo.h"
 #include "functions.h"
 
 char mesh_dfl_iface[] = "bat0";
@@ -152,24 +148,7 @@ int main(int argc, char **argv)
 		exit(EXIT_SUCCESS);
 	}
 
-	if ((strcmp(argv[1], "interface") == 0) || (strcmp(argv[1], "if") == 0)) {
-
-		ret = interface(mesh_iface, argc - 1, argv + 1);
-
-	} else if ((strcmp(argv[1], "tcpdump") == 0) || (strcmp(argv[1], "td") == 0)) {
-
-		ret = tcpdump(argc - 1, argv + 1);
-
-#ifdef BATCTL_BISECT
-	} else if ((strcmp(argv[1], "bisect_iv") == 0)) {
-
-		ret = bisect_iv(argc - 1, argv + 1);
-#endif
-	} else if ((strcmp(argv[1], "routing_algo") == 0) || (strcmp(argv[1], "ra") == 0)) {
-
-		ret = routing_algo(mesh_iface, argc - 1, argv + 1);
-
-	} else if ((cmd = find_command(argv[1]))) {
+	if ((cmd = find_command(argv[1]))) {
 		if (cmd->flags & COMMAND_FLAG_MESH_IFACE &&
 		    check_mesh_iface(mesh_iface) < 0) {
 			fprintf(stderr, "Error - interface %s is not present or not a batman-adv interface\n", mesh_iface);
diff --git a/routing_algo.c b/routing_algo.c
index 89af6c5..2026224 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -41,7 +41,7 @@ static void ra_mode_usage(void)
 	fprintf(stderr, " \t -h print this help\n");
 }
 
-int routing_algo(char *mesh_iface __maybe_unused, int argc, char **argv)
+static int routing_algo(char *mesh_iface __maybe_unused, int argc, char **argv)
 {
 	DIR *iface_base_dir;
 	struct dirent *iface_dir;
@@ -125,3 +125,5 @@ int routing_algo(char *mesh_iface __maybe_unused, int argc, char **argv)
 out:
 	return res;
 }
+
+COMMAND(routing_algo, "ra", 0);
diff --git a/routing_algo.h b/routing_algo.h
deleted file mode 100644
index db246c6..0000000
--- a/routing_algo.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
- *
- * Marek Lindner <mareklindner@neomailbox.ch>
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
- * License-Filename: LICENSES/preferred/GPL-2.0
- */
-
-#ifndef _BATCTL_ROUTING_ALGO_H
-#define _BATCTL_ROUTING_ALGO_H
-
-int routing_algo(char *mesh_iface, int argc, char **argv);
-
-#endif
diff --git a/tcpdump.c b/tcpdump.c
index dc4ccd3..fd2b35a 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1210,7 +1210,7 @@ static void sig_handler(int sig)
 	}
 }
 
-int tcpdump(int argc, char **argv)
+static int tcpdump(char *mesh_iface __maybe_unused, int argc, char **argv)
 {
 	struct timeval tv;
 	struct dump_if *dump_if, *dump_if_tmp;
@@ -1351,3 +1351,5 @@ int tcpdump(int argc, char **argv)
 	bat_hosts_free();
 	return ret;
 }
+
+COMMAND(tcpdump, "td", 0);
diff --git a/tcpdump.h b/tcpdump.h
index f73211b..db92fce 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -113,6 +113,4 @@ struct prism_header {
 #define PRISM_HEADER_LEN sizeof(struct prism_header)
 #define RADIOTAP_HEADER_LEN sizeof(struct radiotap_header)
 
-int tcpdump(int argc, char **argv);
-
 #endif
-- 
2.11.0

