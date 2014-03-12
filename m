Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 12 Mar 2014 17:04:48 +0100
Message-Id: <1394640288-1611-2-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1394640288-1611-1-git-send-email-sw@simonwunderlich.de>
References: <1394640288-1611-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-next v3 2/2] batctl: add option for multiif
	orig table
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

This patch adds batctl support for the recently introduced mesh wide
multi interface optimization in batman-adv.

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
Changes to PATCHv1:

 * check if the supplied interface actually belongs to the interface
 * add README and manpage descriptions
---
 README       |   25 +++++++++++++++++++++++++
 debug.c      |   32 ++++++++++++++++++++++++++------
 man/batctl.8 |    4 +++-
 sys.c        |   28 ++++++++++++++++++++++++++++
 sys.h        |    1 +
 5 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/README b/README
index a4507b7..facc82e 100644
--- a/README
+++ b/README
@@ -305,6 +305,31 @@ fe:fe:00:00:06:01    0.830s   (213) fe:fe:00:00:02:01 [      eth0]: fe:fe:00:00:
 fe:fe:00:00:02:01    0.240s   (255) fe:fe:00:00:02:01 [      eth0]: fe:fe:00:00:03:01 ( 81) fe:fe:00:00:02:01 (255)
 fe:fe:00:00:07:01    0.670s   (200) fe:fe:00:00:02:01 [      eth0]: fe:fe:00:00:03:01 ( 68) fe:fe:00:00:02:01 (200)
 
+Since 2014.1.0, each batman interface has an individual originator table as well which is only used for routing.
+These table explain to which neighbor a packet is forwarded when the packet is received on the specified interface.
+
+Example:
+
+$ batctl originators -i eth0
+[B.A.T.M.A.N. adv master-b82b9b2, IF/MAC: eth0/fe:f0:00:00:02:01 (bat0 BATMAN_IV)]
+  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   Potential nexthops ...
+fe:f1:00:00:03:01    0.170s   (255) fe:f1:00:00:03:01 [      eth1]: fe:f1:00:00:03:01 (255)
+fe:f1:00:00:01:01    0.510s   (253) fe:f1:00:00:01:01 [      eth1]: fe:f1:00:00:01:01 (253)
+fe:f0:00:00:05:01    0.660s   (222) fe:f1:00:00:03:01 [      eth1]: fe:f0:00:00:03:01 (198) fe:f1:00:00:03:01 (222)
+fe:f0:00:00:03:01    0.560s   (252) fe:f1:00:00:03:01 [      eth1]: fe:f1:00:00:03:01 (252) fe:f0:00:00:03:01 (240)
+fe:f0:00:00:04:01    0.250s   (240) fe:f1:00:00:03:01 [      eth1]: fe:f1:00:00:03:01 (240) fe:f0:00:00:03:01 (211)
+fe:f0:00:00:01:01    0.850s   (255) fe:f1:00:00:01:01 [      eth1]: fe:f1:00:00:01:01 (255) fe:f0:00:00:01:01 (238)
+$ batctl originators -i eth1
+[B.A.T.M.A.N. adv master-b82b9b2, IF/MAC: eth1/fe:f1:00:00:02:01 (bat0 BATMAN_IV)]
+  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   Potential nexthops ...
+fe:f1:00:00:03:01    0.880s   (240) fe:f1:00:00:03:01 [      eth1]: fe:f1:00:00:03:01 (240)
+fe:f1:00:00:01:01    0.250s   (239) fe:f1:00:00:01:01 [      eth1]: fe:f1:00:00:01:01 (239)
+fe:f0:00:00:05:01    0.340s   (211) fe:f1:00:00:03:01 [      eth1]: fe:f0:00:00:03:01 (210) fe:f1:00:00:03:01 (211)
+fe:f0:00:00:03:01    0.260s   (253) fe:f0:00:00:03:01 [      eth0]: fe:f1:00:00:03:01 (240) fe:f0:00:00:03:01 (253)
+fe:f0:00:00:04:01    0.010s   (225) fe:f0:00:00:03:01 [      eth0]: fe:f1:00:00:03:01 (224) fe:f0:00:00:03:01 (225)
+fe:f0:00:00:01:01    0.510s   (255) fe:f0:00:00:01:01 [      eth0]: fe:f1:00:00:01:01 (240) fe:f0:00:00:01:01 (255)
+
+
 batctl interface
 ================
 
diff --git a/debug.c b/debug.c
index 6836857..04b2c6d 100644
--- a/debug.c
+++ b/debug.c
@@ -27,6 +27,7 @@
 #include "debug.h"
 #include "debugfs.h"
 #include "functions.h"
+#include "sys.h"
 
 const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 	{
@@ -89,8 +90,10 @@ static void debug_table_usage(int debug_table)
 	fprintf(stderr, " \t -H don't show the header\n");
 	fprintf(stderr, " \t -w [interval] watch mode - refresh the table continuously\n");
 
-	if (debug_table == BATCTL_TABLE_ORIGINATORS)
+	if (debug_table == BATCTL_TABLE_ORIGINATORS) {
 		fprintf(stderr, " \t -t timeout interval - don't print originators not seen for x.y seconds \n");
+		fprintf(stderr, " \t -i [interface] - show multiif originator table for a specific interface\n");
+	}
 }
 
 int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
@@ -98,11 +101,12 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 	int optchar, read_opt = USE_BAT_HOSTS;
 	char full_path[MAX_PATH+1];
 	char *debugfs_mnt;
+	char *orig_iface = NULL;
 	float orig_timeout;
 	float watch_interval = 1;
 	opterr = 0;
 
-	while ((optchar = getopt(argc, argv, "hnw:t:H")) != -1) {
+	while ((optchar = getopt(argc, argv, "hnw:t:Hi:")) != -1) {
 		switch (optchar) {
 		case 'h':
 			debug_table_usage(debug_table);
@@ -138,11 +142,24 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 		case 'H':
 			read_opt |= SKIP_HEADER;
 			break;
+		case 'i':
+			if (debug_table != BATCTL_TABLE_ORIGINATORS) {
+				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
+				debug_table_usage(debug_table);
+				return EXIT_FAILURE;
+			}
+
+			if (check_mesh_iface_ownership(mesh_iface, optarg) != EXIT_SUCCESS)
+				return EXIT_FAILURE;
+
+			orig_iface = optarg;
+			break;
 		case '?':
-			if (optopt == 't')
+			if (optopt == 't') {
 				fprintf(stderr, "Error - option '-t' needs a number as argument\n");
-
-			else if (optopt == 'w') {
+			} else if (optopt == 'i') {
+				fprintf(stderr, "Error - option '-i' needs an interface as argument\n");
+			} else if (optopt == 'w') {
 				read_opt |= CLR_CONT_READ;
 				break;
 			}
@@ -162,7 +179,10 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
+	if (orig_iface)
+		debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", orig_iface, full_path, sizeof(full_path));
+	else
+		debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
 	return read_file(full_path, (char *)batctl_debug_tables[debug_table].debugfs_name,
 			 read_opt, orig_timeout, watch_interval,
 			 batctl_debug_tables[debug_table].header_lines);
diff --git a/man/batctl.8 b/man/batctl.8
index b808293..8ef1123 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -192,7 +192,9 @@ All of the debug tables support the following options:
 
 .RS 7
 The originator table also supports the "\-t" filter option to remove all originators from the output that have not been seen
-for the specified amount of seconds (with optional decimal places).
+for the specified amount of seconds (with optional decimal places). It furthermore supports the "\-i" parameter to specify an
+interface for which the originator table should be printed. If this parameter is not supplied, the default originator table
+is printed.
 
 List of debug tables:
 .RS 10
diff --git a/sys.c b/sys.c
index 0b98d82..14c3cf5 100644
--- a/sys.c
+++ b/sys.c
@@ -596,3 +596,31 @@ out:
 
 	return ret;
 }
+
+int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface)
+{
+	char path_buff[PATH_BUFF_LEN];
+	int res;
+
+	/* check if this device actually belongs to the mesh interface */
+	snprintf(path_buff, sizeof(path_buff), SYS_MESH_IFACE_FMT, hard_iface);
+	path_buff[sizeof(path_buff) - 1] = '\0';
+	res = read_file("", path_buff, USE_READ_BUFF | SILENCE_ERRORS, 0, 0, 0);
+	if (res != EXIT_SUCCESS) {
+		fprintf(stderr, "Error - the directory '%s' could not be read: %s\n",
+			path_buff, strerror(errno));
+		fprintf(stderr, "Is the batman-adv module loaded and sysfs mounted ?\n");
+		return EXIT_FAILURE;
+	}
+
+	if (line_ptr[strlen(line_ptr) - 1] == '\n')
+		line_ptr[strlen(line_ptr) - 1] = '\0';
+
+	if (strcmp(line_ptr, mesh_iface) != 0) {
+		fprintf(stderr, "Error - interface %s is part of batman network %s, not %s\n",
+			hard_iface, line_ptr, mesh_iface);
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
+}
diff --git a/sys.h b/sys.h
index 5aec020..8296bd4 100644
--- a/sys.h
+++ b/sys.h
@@ -72,5 +72,6 @@ int handle_loglevel(char *mesh_iface, int argc, char **argv);
 int handle_sys_setting(char *mesh_iface, int setting, int argc, char **argv);
 int handle_gw_setting(char *mesh_iface, int argc, char **argv);
 int check_mesh_iface(char *mesh_iface);
+int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface);
 
 #endif
-- 
1.7.10.4

