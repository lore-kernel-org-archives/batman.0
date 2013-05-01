Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed,  1 May 2013 15:53:59 +0200
Message-Id: <1367416439-11487-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: remove vis support
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

As the kernel module will not have support for this feature, we can also
drop support from batctl. Keep the old parameter to point current users
to alfred.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 Makefile     |    2 +-
 README       |   93 -----------------
 debug.c      |   26 +++++
 debug.h      |    2 +-
 main.c       |    4 +-
 man/batctl.8 |   12 ---
 sys.c        |    6 --
 sys.h        |    1 -
 vis.c        |  314 ----------------------------------------------------------
 vis.h        |   23 -----
 10 files changed, 29 insertions(+), 454 deletions(-)
 delete mode 100644 vis.c
 delete mode 100644 vis.h

diff --git a/Makefile b/Makefile
index 00cce9d..61b24c6 100755
--- a/Makefile
+++ b/Makefile
@@ -24,7 +24,7 @@ export CONFIG_BATCTL_BISECT=n
 
 # batctl build
 BINARY_NAME = batctl
-OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o  hash.o vis.o debugfs.o ioctl.o list-batman.o translate.o
+OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o  hash.o debugfs.o ioctl.o list-batman.o translate.o
 OBJ_BISECT = bisect_iv.o
 MANPAGE = man/batctl.8
 
diff --git a/README b/README
index fd421e1..f3eb4b3 100644
--- a/README
+++ b/README
@@ -159,7 +159,6 @@ packet types:
                   2 - batman icmp packets
                   4 - batman unicast packets
                   8 - batman broadcast packets
-                 16 - batman vis packets
                  32 - batman fragmented packets
                  64 - batman tt / roaming packets
                 128 - non batman packets
@@ -473,95 +472,3 @@ where:
 - IPv4 is the IP address of a client in the mesh network
 - MAC is the MAC address associated to that IP
 - last-seen is the amount of time since last refresh of this entry
-
-batctl vis_mode
-=================
-
-display or modify the status of the VIS server
-
-Usage: batctl vis_mode|vm [mode]
-
-Example:
-
-$ batctl vis_mode
-client
-
-
-batctl vis_data
-===============
-
-display the VIS data in dot or JSON format
-
-
-Usage:
-
-batctl vis dot {-h}{--no-TT|-T} {--no-2nd|-2} {--numbers|-n}
-or
-batctl vis json {-h}{--no-TT|-T} {--no-2nd|-2} {--numbers|-n}
-
-
-Example:
-(A <- 100% -> B,B-if2 <- 50% -> C)
-
-$ batctl vis_data dot
-digraph {
-	"A" -> "B" [label="1.00"]
-	"A" -> "00:ff:f3:cc:68:ac" [label="TT"]
-	subgraph "cluster_A" {
-		"A" [peripheries=2]
-	}
-	"B" -> "A" [label="1.00"]
-	"B-if2" -> "C" [label="2.00"]
-	"B" -> "22:ff:f3:cc:68:ac" [label="TT"]
-	subgraph "cluster_B" {
-		"B" [peripheries=2]
-		"B-if2"
-	}
-	"C" -> "B-if2" [label="2.00"]
-	"C" -> "44:ff:f3:cc:68:ac" [label="TT"]
-	subgraph "cluster_C" {
-		"C" [peripheries=2]
-	}
-}
-
-
-Explanation:
-
-The vis dot (or json) output is adding an entry for each link between two
-originator's interfaces which are being used for internal routing in batman.
-The labels are similar/compatible to the ETX metric, 1.0 means perfect
-connection (100%), 2.0 means 50%, 3.0 means 33% and so on.
-
-A host's mac address which is currently connected to the interface of a mesh
-node (either the mesh node itself or hosts being bridged into the mesh) is
-being displayed with an "TT"-label. (--no-TT omits this output)
-
-To still have the information about which interfaces belong to which mesh node
-a subgraph/cluster is being added. The subpgraph is being labeled with a mesh
-nodes primary interface mac (= Originator MAC). It also has an additional tag
-[peripheries=2] to make this important MAC address visible, for instance in an
-image. (--no-2nd omits this output)
-After the conversion to a png file with graphviz-tools' fdp, all interfaces of
-a node would be combined in a visual box (see below for details).
-
-
-vis-dot to png
---------------
-
-The vis dot output could then further be converted to an image of the topology
-graph, e.g. with the help of the graphviz-tools. The according commands could
-then look like this:
-
-$ batctl vis_data dot > /tmp/graph.dot
-$ fdp -Tpng /tmp/graph.dot > graph.png
-
-Meaning of the shapes in this image file:
-* Ellipses: All BATMAN-node and host interfaces can be found in here
-            labeled with the according interface MAC-address.
-* Boxes:    interfaces belonging to one BATMAN-node
-* double circled interfaces: the primary interface of a BATMAN-node
-      (which is known to other BATMAN-nodes only, except direct neighbours)
-* Ellipses with a TT-arrow: mesh clients (this can be a BATMAN-node itself
-      with its bat0 interface or computers/devices being bridged into the mesh)
-* Arrows with numbers: the transmit quality (in the form 1/TQ) from one
-      BATMAN interface to another BATMAN interface
diff --git a/debug.c b/debug.c
index c879603..3ea112a 100644
--- a/debug.c
+++ b/debug.c
@@ -173,6 +173,32 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 			 batctl_debug_tables[debug_table].header_lines);
 }
 
+int print_vis_info(char *mesh_iface)
+{
+	char full_path[MAX_PATH+1];
+	char *debugfs_mnt;
+	FILE *fp;
+
+	debugfs_mnt = debugfs_mount(NULL);
+	if (!debugfs_mnt) {
+		fprintf(stderr, "Error - can't mount or find debugfs\n");
+		return -1;
+	}
+
+	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/vis_data", mesh_iface, full_path, sizeof(full_path));
+	fp = fopen(full_path, "r");
+	if (fp) {
+		fclose(fp);
+		fprintf(stderr, "Error - batctl version is newer than kernel module - the kernel module still supports\n"
+				"vis, but later versions will not. The vis functionality has been moved to the userspace\n"
+				"daemon ''alfred''. Please either downgrade to an older (compatible) batctl version or use alfred.\n");
+	} else {
+		fprintf(stderr, "Error - The installed batctl version and kernel module don't have vis support. The vis functionality\n"
+				"has been moved to the userspace daemon ''alfred''.\n");
+	}
+	return 0;
+}
+
 static void log_usage(void)
 {
 	fprintf(stderr, "Usage: batctl [options] log [parameters]\n");
diff --git a/debug.h b/debug.h
index 2427ece..532c2fe 100644
--- a/debug.h
+++ b/debug.h
@@ -21,7 +21,6 @@
 
 
 #define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
-#define DEBUG_VIS_DATA "vis_data"
 #define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
 #define DEBUG_LOG "log"
 
@@ -48,3 +47,4 @@ extern const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM];
 
 int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv);
 int log_print(char *mesh_iface, int argc, char **argv);
+int print_vis_info(char *mesh_iface);
diff --git a/main.c b/main.c
index 7d667d3..94771e6 100644
--- a/main.c
+++ b/main.c
@@ -36,7 +36,6 @@
 #include "traceroute.h"
 #include "tcpdump.h"
 #include "bisect_iv.h"
-#include "vis.h"
 #include "ioctl.h"
 #include "functions.h"
 #include <err.h>
@@ -74,7 +73,6 @@ void print_usage(void)
 	fprintf(stderr, " \tloglevel|ll                [level]           \tdisplay or modify the log level\n");
 	fprintf(stderr, " \tlog|l                                        \tread the log produced by the kernel module\n");
 	fprintf(stderr, " \tgw_mode|gw                 [mode]            \tdisplay or modify the gateway mode\n");
-	fprintf(stderr, " \tvis_data|vd                [dot|JSON]        \tdisplay the VIS data in dot or JSON format\n");
 	fprintf(stderr, "\n");
 
 	fprintf(stderr, "debug tables:                                   \tdisplay the corresponding debug table\n");
@@ -168,7 +166,7 @@ int main(int argc, char **argv)
 
 	} else if ((strcmp(argv[1], "vis_data") == 0) || (strcmp(argv[1], "vd") == 0)) {
 
-		ret = vis_data(mesh_iface, argc - 1, argv + 1);
+		ret = print_vis_info(mesh_iface);
 
 	} else if ((strcmp(argv[1], "gw_mode") == 0) || (strcmp(argv[1], "gw") == 0)) {
 
diff --git a/man/batctl.8 b/man/batctl.8
index 38060d6..d04385b 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -72,9 +72,6 @@ this option won't be available.
 If no parameter is given the current distributed arp table setting is displayed. Otherwise the parameter is used to
 enable or disable the distributed arp table.
 .br
-.IP "\fBvis_mode|vm\fP [\fBclient|server\fP]\fP"
-If no parameter is given the current vis mode is displayed otherwise the parameter is used to set the vis mode.
-.br
 .IP "\fBaggregation\fP|\fBag\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current aggregation setting is displayed. Otherwise the parameter is used to enable or disable
 OGM packet aggregation.
@@ -154,12 +151,6 @@ least XX TQ better than the currently selected gateway (XX has to be a number be
 .RE
 .RE
 .br
-.IP "\fBvis_data|vd dot\fP [\fB\-n\fP|\fB\-\-numbers\fP][\fB\-T\fP|\fB\-\-no-TT\fP][\fB\-2\fP|\fB\-\-no-2nd\fP]"
-Display the visualisation data in graphviz \fBdot\fP(1) format. If "\-\-numbers" or "\-n" is given batctl will not replace
-the MAC addresses with bat-host names in the output. With "\-\-no-TT" or "\-T" the TT entries are not displayed, so the pure
-mesh topology can be seen. With "\-\-no-2nd" or "\-2" a dot cluster is not formed around primary and secondary addresses
-from the same device.
-.br
 .PP
 .I \fBdebug tables:
 .IP
@@ -269,9 +260,6 @@ except specified). The following packet types are available:
 8 - batman broadcast packets
 .RE
 .RS 16
-16 - batman vis packets
-.RE
-.RS 16
 32 - batman fragmented packets
 .RE
 .RS 16
diff --git a/sys.c b/sys.c
index 3258105..b1d7ea8 100644
--- a/sys.c
+++ b/sys.c
@@ -75,12 +75,6 @@ const struct settings_data batctl_settings[BATCTL_SETTINGS_NUM] = {
 		.params = sysfs_param_enable,
 	},
 	{
-		.opt_long = "vis_mode",
-		.opt_short = "vm",
-		.sysfs_name = "vis_mode",
-		.params = sysfs_param_server,
-	},
-	{
 		.opt_long = "aggregation",
 		.opt_short = "ag",
 		.sysfs_name = "aggregated_ogms",
diff --git a/sys.h b/sys.h
index a7187af..a588e0b 100644
--- a/sys.h
+++ b/sys.h
@@ -36,7 +36,6 @@ enum batctl_settings_list {
 	BATCTL_SETTINGS_AP_ISOLATION,
 	BATCTL_SETTINGS_BLA,
 	BATCTL_SETTINGS_DAT,
-	BATCTL_SETTINGS_VIS_MODE,
 	BATCTL_SETTINGS_AGGREGATION,
 	BATCTL_SETTINGS_BONDING,
 	BATCTL_SETTINGS_FRAGMENTATION,
diff --git a/vis.c b/vis.c
deleted file mode 100644
index 33c7a7f..0000000
--- a/vis.c
+++ /dev/null
@@ -1,314 +0,0 @@
-/*
- * Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
- *
- * Andrew Lunn <andrew@lunn.ch>
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
-#define _GNU_SOURCE
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdint.h>
-#include <stdbool.h>
-#include <getopt.h>
-#include <string.h>
-
-#include "main.h"
-#include "vis.h"
-#include "functions.h"
-#include "bat-hosts.h"
-#include "debug.h"
-#include "debugfs.h"
-
-#define TQ_MAX_VALUE 255
-
-typedef void (*print_tq_t) (char *orig, char *from, const long tq);
-typedef void (*print_TT_t) (char *orig, char *from);
-typedef void (*print_1st_t) (char *orig);
-typedef void (*print_2nd_t) (char *orig, char *from);
-typedef void (*print_header_t) (void);
-typedef void (*print_footer_t) (void);
-
-struct funcs {
-	print_tq_t print_tq;
-	print_TT_t print_TT;
-	print_1st_t print_1st;
-	print_2nd_t print_2nd;
-	print_header_t print_header;
-	print_footer_t print_footer;
-};
-
-static bool with_TT = true;
-static bool with_2nd = true;
-static bool with_names = true;
-
-static void usage(void)
-{
-	fprintf(stderr, "batctl vis_data dot {-h}{--no-TT|-T} {--no-2nd|-2} {--numbers|-n}\n");
-	fprintf(stderr, "or\n");
-	fprintf(stderr, "batctl vis_data json {-h}{--no-TT|-T} {--no-2nd|-2} {--numbers|-n}\n");
-}
-
-static void dot_print_tq(char *orig, char *from, const long tq)
-{
-	int int_part = TQ_MAX_VALUE / tq;
-	int frac_part = (1000 * TQ_MAX_VALUE / tq) - (int_part * 1000);
-
-	printf("\t\"%s\" -> ",
-	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
-	printf("\"%s\" [label=\"%d.%03d\"]\n",
-	       get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)),
-	       int_part, frac_part);
-}
-
-static void dot_print_TT(char *orig, char *from)
-{
-	printf("\t\"%s\" -> ",
-	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
-	printf("\"%s\" [label=\"TT\"]\n",
-	       get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)));
-}
-
-static void dot_print_1st(char *orig)
-{
-	printf("\tsubgraph \"cluster_%s\" {\n",
-	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
-	printf("\t\t\"%s\" [peripheries=2]\n",
-	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
-	printf("\t}\n");
-}
-
-static void dot_print_2nd(char *orig, char *from)
-{
-	printf("\tsubgraph \"cluster_%s\" {\n",
-	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
-	printf("\t\t\"%s\" [peripheries=2]\n",
-	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
-	printf("\t\t\"%s\"\n",
-	       get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)));
-	printf("\t}\n");
-}
-
-static void dot_print_header(void)
-{
-	printf("digraph {\n");
-}
-
-static void dot_print_footer(void)
-{
-	printf("}\n");
-}
-
-const struct funcs dot_funcs = { dot_print_tq,
-	dot_print_TT,
-	dot_print_1st,
-	dot_print_2nd,
-	dot_print_header,
-	dot_print_footer
-};
-
-static void json_print_tq(char *orig, char *from, const long tq)
-{
-	int int_part = TQ_MAX_VALUE / tq;
-	int frac_part = (1000 * TQ_MAX_VALUE / tq) - (int_part * 1000);
-
-	printf("{ \"router\" : \"%s\", ",
-	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
-	printf("\"neighbor\" : \"%s\", \"label\" : \"%d.%03d\" }\n",
-	       get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)),
-	       int_part, frac_part);
-}
-
-static void json_print_TT(char *orig, char *from)
-{
-	printf("{ \"router\" : \"%s\", ",
-	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
-	printf("\"gateway\" : \"%s\", \"label\" : \"TT\" }\n",
-	       get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)));
-}
-
-static void json_print_1st(char *orig)
-{
-	printf("{ \"primary\" : \"%s\" }\n",
-	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
-}
-
-static void json_print_2nd(char *orig, char *from)
-{
-	printf("{ \"secondary\" : \"%s\", ",
-	       get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)));
-
-	printf("\"of\" : \"%s\" }\n",
-	       get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
-}
-
-const struct funcs json_funcs = { json_print_tq,
-	json_print_TT,
-	json_print_1st,
-	json_print_2nd,
-	NULL,
-	NULL
-};
-
-static FILE *open_vis(char *mesh_iface)
-{
-	char full_path[MAX_PATH+1];
-	char *debugfs_mnt;
-
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt) {
-		fprintf(stderr, "Error - can't mount or find debugfs\n");
-		return NULL;
-	}
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/" DEBUG_VIS_DATA, mesh_iface, full_path, sizeof(full_path));
-
-	return fopen(full_path, "r");
-}
-
-static int format(char *mesh_iface, const struct funcs *funcs)
-{
-	size_t len = 0;
-	char *line = NULL;
-	char *orig, *from;
-	char *duplet;
-	char *line_save_ptr, *component_save_ptr;
-	char *duplet_save_ptr;
-	char *endptr;
-	char *value;
-	long tq;
-	char *flag;
-
-	FILE *fp = open_vis(mesh_iface);
-
-	if (!fp)
-		return EXIT_FAILURE;
-
-	if (funcs->print_header)
-		funcs->print_header();
-
-	while (getline(&line, &len, fp) != -1) {
-		/* First MAC address is the originator */
-		orig = strtok_r(line, ",", &line_save_ptr);
-
-		duplet_save_ptr = line_save_ptr;
-		while ((duplet = strtok_r(NULL, ",", &duplet_save_ptr)) != NULL) {
-			flag = strtok_r(duplet, " ", &component_save_ptr);
-			if (!flag)
-				continue;
-			if (!strcmp(flag, "TQ")) {
-				from = strtok_r(NULL, " ", &component_save_ptr);
-				value = strtok_r(NULL, " ", &component_save_ptr);
-				tq = strtoul(value, &endptr, 0);
-				funcs->print_tq(orig, from, tq);
-				continue;
-			}
-			if (!strcmp(flag, "TT")) {
-				/* We have a TT record */
-				if (!with_TT)
-					continue;
-				from = strtok_r(NULL, " ", &component_save_ptr);
-				funcs->print_TT(orig, from);
-				continue;
-			}
-			if (!strcmp(flag, "SEC") && with_2nd) {
-				/* We found a secondary interface MAC address. */
-				from = strtok_r(NULL, " ", &component_save_ptr);
-				funcs->print_2nd(orig, from);
-			}
-			if (!strcmp(flag, "PRIMARY") && with_2nd) {
-				/* We found a primary interface MAC address. */
-				funcs->print_1st(orig);
-			}
-		}
-	}
-
-	if (funcs->print_footer)
-		funcs->print_footer();
-
-	if (line)
-		free(line);
-	return EXIT_SUCCESS;
-}
-
-int vis_data(char *mesh_iface, int argc, char *argv[])
-{
-	bool dot = false;
-	bool json = false;
-	int c;
-
-	if (argc <= 1) {
-		usage();
-		return EXIT_FAILURE;
-	}
-
-	/* Do we know the requested format? */
-	if (strcmp(argv[1], "dot") == 0)
-		dot = true;
-	if (strcmp(argv[1], "json") == 0)
-		json = true;
-
-	if (!dot && !json) {
-		usage();
-		return EXIT_FAILURE;
-	}
-
-	/* Move over the output format */
-	argc--;
-	argv++;
-
-	while (1) {
-		int option_index = 0;
-		static struct option long_options[] = {
-			{"no-TT", 0, 0, 'T'},
-			{"no-2nd", 0, 0, '2'},
-			{"numbers", 0, 0, 'n'},
-			{0, 0, 0, 0}
-		};
-
-		c = getopt_long(argc, argv, "hT2n", long_options, &option_index);
-		if (c == -1)
-			break;
-
-		switch (c) {
-		case 'T':
-			with_TT = false;
-			break;
-		case '2':
-			with_2nd = false;
-			break;
-		case 'n':
-			with_names = false;
-			break;
-		case 'h':
-		default:
-			usage();
-			return -1;
-		}
-	}
-
-	if (with_names)
-		bat_hosts_init(USE_BAT_HOSTS);
-
-	if (dot)
-		return format(mesh_iface, &dot_funcs);
-
-	if (json)
-		return format(mesh_iface, &json_funcs);
-
-	return EXIT_FAILURE;
-}
diff --git a/vis.h b/vis.h
deleted file mode 100644
index 3a68363..0000000
--- a/vis.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
- *
- * Andrew Lunn <andrew@lunn.ch>
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
-int vis_data(char *mesh_iface, int argc, char * argv[]);
-
-- 
1.7.10.4

