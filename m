Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 20 Dec 2009 01:11:04 +0800
Message-Id: <1261242667-11525-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1261242667-11525-1-git-send-email-lindner_marek@yahoo.de>
References: <200912200101.55746.lindner_marek@yahoo.de>
	<1261242667-11525-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batctl: Parse the new /proc vis format.
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

Add code to batctl so that it can parse /proc/net/batman-adv/vis and
generate either graphvis dot or JSON output.

Tested and bugs found and fixed by Linus Luessing.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Linus Luessing <linus.luessing@web.de>
---
 batctl/Makefile     |    4 +-
 batctl/functions.c  |    2 +-
 batctl/functions.h  |    1 +
 batctl/main.c       |   10 +-
 batctl/man/batctl.8 |   17 +++-
 batctl/vis.c        |  326 +++++++++++++++++++++++++++++++++++++++++++++++++++
 batctl/vis.h        |   21 ++++
 7 files changed, 372 insertions(+), 9 deletions(-)
 create mode 100644 batctl/vis.c
 create mode 100644 batctl/vis.h

diff --git a/batctl/Makefile b/batctl/Makefile
index b5255d2..8ecdd76 100644
--- a/batctl/Makefile
+++ b/batctl/Makefile
@@ -39,8 +39,8 @@ SRC_FILES = "\(\.c\)\|\(\.h\)\|\(Makefile\)\|\(INSTALL\)\|\(LIESMICH\)\|\(README
 EXTRA_MODULES_C := bisect.c
 EXTRA_MODULES_H := bisect.h
 
-SRC_C = main.c bat-hosts.c functions.c proc.c sys.c ping.c traceroute.c tcpdump.c list-batman.c hash.c $(EXTRA_MODULES_C)
-SRC_H = main.h bat-hosts.h functions.h proc.h sys.h ping.h traceroute.h tcpdump.h list-batman.h hash.h allocate.h $(EXTRA_MODULES_H)
+SRC_C = main.c bat-hosts.c functions.c proc.c sys.c ping.c traceroute.c tcpdump.c list-batman.c hash.c vis.c $(EXTRA_MODULES_C)
+SRC_H = main.h bat-hosts.h functions.h proc.h sys.h ping.h traceroute.h tcpdump.h list-batman.h hash.h allocate.h vis.h $(EXTRA_MODULES_H)
 SRC_O = $(SRC_C:.c=.o)
 
 PACKAGE_NAME = batctl
diff --git a/batctl/functions.c b/batctl/functions.c
index 697be1f..8d38764 100644
--- a/batctl/functions.c
+++ b/batctl/functions.c
@@ -99,7 +99,7 @@ char *get_name_by_macstr(char *mac_str, int read_opt)
 	return get_name_by_macaddr(mac_addr, read_opt);
 }
 
-static int check_proc_dir(char *dir)
+int check_proc_dir(char *dir)
 {
 	struct stat st;
 
diff --git a/batctl/functions.h b/batctl/functions.h
index f819754..445a619 100644
--- a/batctl/functions.h
+++ b/batctl/functions.h
@@ -34,6 +34,7 @@ char *get_name_by_macaddr(struct ether_addr *mac_addr, int read_opt);
 char *get_name_by_macstr(char *mac_str, int read_opt);
 int read_file(char *dir, char *path, int read_opt);
 int write_file(char *dir, char *path, char *value);
+int check_proc_dir(char *dir);
 
 extern char read_buff[10];
 
diff --git a/batctl/main.c b/batctl/main.c
index c0f1f88..ee5ed17 100644
--- a/batctl/main.c
+++ b/batctl/main.c
@@ -35,6 +35,7 @@
 #include "traceroute.h"
 #include "tcpdump.h"
 #include "bisect.h"
+#include "vis.h"
 
 
 void print_usage(void) {
@@ -47,7 +48,7 @@ void print_usage(void) {
 	printf(" \tlog|l                           \tread the log produced by the kernel module\n");
 	printf(" \ttranslocal|tl                   \tdisplay the local translation table\n");
 	printf(" \ttransglobal|tg                  \tdisplay the global translation table\n");
-	printf(" \tvisformat|vf  [format]          \tdisplay or modify the vis output format\n");
+	printf(" \tvis [dot|JSON]                  \tdisplay the VIS data in dot or JSON format\n");
 	printf(" \taggregation|ag   [0|1]          \tdisplay or modify the packet aggregation setting\n");
 	printf("\n");
 	printf(" \tping|p        <destination>     \tping another batman adv host via layer 2\n");
@@ -74,7 +75,8 @@ int main(int argc, char **argv)
 	}
 
 	/* check if user is root */
-	if ((strcmp(argv[1], "bisect") != 0) && ((getuid()) || (getgid()))) {
+	if (((strcmp(argv[1], "bisect") != 0) && (strcmp(argv[1], "vis") != 0))
+	    && ((getuid()) || (getgid()))) {
 		fprintf(stderr, "Error - you must be root to run '%s' !\n", argv[0]);
 		exit(EXIT_FAILURE);
 	}
@@ -119,9 +121,9 @@ int main(int argc, char **argv)
 
 		ret = handle_proc_setting(argc - 1, argv + 1, PROC_ORIG_INTERVAL, orig_interval_usage);
 
-	} else if ((strcmp(argv[1], "visformat") == 0) || (strcmp(argv[1], "vf") == 0)) {
+	} else if (strcmp(argv[1], "vis") == 0) {
 
-		ret = handle_proc_setting(argc - 1, argv + 1, PROC_VIS_FORMAT, vis_format_usage);
+		ret = vis(argc - 1, argv + 1);
 
 	} else if ((strcmp(argv[1], "aggregation") == 0) || (strcmp(argv[1], "ag") == 0)) {
 
diff --git a/batctl/man/batctl.8 b/batctl/man/batctl.8
index cdedacb..1aa68df 100644
--- a/batctl/man/batctl.8
+++ b/batctl/man/batctl.8
@@ -63,8 +63,21 @@ Once started batctl will refresh the displayed local translation table every sec
 .IP "\fBtransglobal|tg\fP"
 Once started batctl will refresh the displayed global translation table every second. Use the "\-b" option to let batctl display the table only once (useful for scripts). If "\-n" was given batctl will not replace the mac addresses with bat\-host names in the output.
 .br
-.IP "\fBvisformat|vf	[format]\fP"
-If no parameter is given the current vis format settings are displayed otherwise the parameter is used to set the vis format.
+.IP "\fBvis dot\fP"
+Display the visualisation data in graphviz dot(1) format. If
+"\--numbers" or "\-n" batctl will not replace the mac addresses with
+bat-host names in the output. With "\--no-HNA" or "\-h" the HNA
+entries are not displayed, so the pure mesh topology can be seen. With
+"\--no-2nd" or "\-2" a dot cluster is not formed around primary and
+secondary addresses from the same device.
+.br
+.IP "\fBvis json\fP"
+Display the visualisation data in JSON format. If
+"\--numbers" or "\-n" batctl will not replace the mac addresses with
+bat-host names in the output. With "\--no-HNA" or "\-h" the HNA
+entries are not displayed, so the pure mesh topology can be seen. With
+"\--no-2nd" or "\-2" a dot cluster is not formed around primary and
+secondary addresses from the same device.
 .br
 .IP "\fBaggregation|ag	[0|1]\fP"
 If no parameter is given the current aggregation settings are displayed otherwise the parameter is used to enable or disable the packet aggregation.
diff --git a/batctl/vis.c b/batctl/vis.c
new file mode 100644
index 0000000..450310c
--- /dev/null
+++ b/batctl/vis.c
@@ -0,0 +1,326 @@
+/* Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Andrew Lunn <andrew@lunn.ch>
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
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <getopt.h>
+#include <string.h>
+
+#include "main.h"
+#include "vis.h"
+#include "functions.h"
+#include "bat-hosts.h"
+#include "proc.h"
+
+#define TQ_MAX_VALUE 255
+
+typedef void (*print_tq_t)(char * orig, char * from, const long tq);
+typedef void (*print_HNA_t)(char * orig, char * from);
+typedef void (*print_1st_t)(char * orig);
+typedef void (*print_2nd_t)(char * orig, char * from);
+typedef void (*print_header_t)(void);
+typedef void (*print_footer_t)(void);
+
+struct funcs 
+{
+  print_tq_t print_tq;
+  print_HNA_t print_HNA;
+  print_1st_t print_1st;
+  print_2nd_t print_2nd;
+  print_header_t print_header;
+  print_footer_t print_footer;
+};
+
+static bool with_HNA = true;
+static bool with_2nd = true;
+static bool with_names = true;
+
+static void 
+usage(void)
+{
+  printf("batctl vis dot {--no-HNA|-h} {--no-2nd|-2} {--numbers|-n}\n");
+  printf("or\n");
+  printf("batctl vis json {--no-HNA|-h} {--no-2nd|-2} {--numbers|-n}\n");
+}
+
+static void 
+dot_print_tq(char * orig, char * from, const long tq)
+{
+  int int_part = TQ_MAX_VALUE / tq;
+  int frac_part = (1000 * TQ_MAX_VALUE / tq) - (int_part * 1000);
+        
+  printf("\t\"%s\" -> ",
+         get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
+  printf("\"%s\" [label=\"%d.%d\"]\n", 
+         get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)),
+         int_part, frac_part);
+}
+
+static void 
+dot_print_HNA(char * orig, char * from)
+{
+        printf("\t\"%s\" -> ",
+               get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
+        printf("\"%s\" [label=\"HNA\"]\n", 
+               get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)));
+}
+
+static void
+dot_print_1st(char * orig)
+{
+  printf("\tsubgraph \"cluster_%s\" {\n",
+         get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
+  printf("\t\t\"%s\" [peripheries=2]\n",
+         get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
+  printf("\t}\n");
+}
+
+static void
+dot_print_2nd(char * orig, char * from)
+{
+  printf("\tsubgraph \"cluster_%s\" {\n",
+         get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
+  printf("\t\t\"%s\" [peripheries=2]\n",
+         get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
+  printf("\t\t\"%s\"\n",
+         get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)));
+  printf("\t}\n");
+}
+
+static void
+dot_print_header(void) 
+{
+  printf("digraph {\n");
+}
+
+static void
+dot_print_footer(void) 
+{
+  printf("}\n");
+}
+
+const struct funcs dot_funcs = 
+  { dot_print_tq,
+    dot_print_HNA,
+    dot_print_1st,
+    dot_print_2nd,
+    dot_print_header,
+    dot_print_footer
+};
+
+static void 
+json_print_tq(char * orig, char * from, const long tq)
+{
+  int int_part = TQ_MAX_VALUE / tq;
+  int frac_part = (1000 * TQ_MAX_VALUE / tq) - (int_part * 1000);
+        
+  printf("\t{ router : \"%s\", ",
+         get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
+  printf("neighbor : \"%s\", label : \"%d.%d\" }\n", 
+         get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)),
+         int_part, frac_part);
+}
+
+static void 
+json_print_HNA(char * orig, char * from)
+{
+  printf("\t{ router : \"%s\", ",
+         get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
+  printf("gateway : \"%s\", label : \"HNA\" }\n", 
+         get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)));
+}
+
+static void
+json_print_1st(char * orig)
+{
+  printf("\t{ primary : \"%s\" }\n",
+         get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
+}
+
+static void
+json_print_2nd(char * orig, char * from)
+{
+  printf("\t{ secondary : \"%s\", ",
+         get_name_by_macstr(from, (with_names ? USE_BAT_HOSTS : 0)));
+
+  printf("of : \"%s\" }\n",
+         get_name_by_macstr(orig, (with_names ? USE_BAT_HOSTS : 0)));
+}
+
+const struct funcs json_funcs = 
+  { json_print_tq,
+    json_print_HNA,
+    json_print_1st,
+    json_print_2nd,
+    NULL,
+    NULL
+};
+
+static FILE *
+open_vis(void) 
+{
+  char full_path[500];
+  
+  if (check_proc_dir("/proc") != EXIT_SUCCESS)
+    return NULL;
+
+  strncpy(full_path, PROC_ROOT_PATH, strlen(PROC_ROOT_PATH));
+  full_path[strlen(PROC_ROOT_PATH)] = '\0';
+  strncat(full_path, "vis", sizeof(full_path) - strlen(full_path));
+
+  return fopen(full_path, "r");
+}
+
+static int 
+format(const struct funcs *funcs)
+{
+  size_t len = 0;
+  ssize_t read;
+  char * line = NULL;
+  char * orig, * from;
+  char * duplet;
+  char * line_save_ptr;
+  char * duplet_save_ptr;
+  char * endptr;
+  char * value;
+  long tq;
+  char * flag;
+  
+  FILE * fp = open_vis(); 
+
+  if (!fp)
+    return EXIT_FAILURE;
+  
+  if (funcs->print_header)
+    funcs->print_header();
+  
+  while ((read = getline(&line, &len, fp)) != -1) {
+    /* First MAC address is the originator */
+    orig = strtok_r(line, ",", &line_save_ptr);
+
+    duplet_save_ptr = line_save_ptr;
+    while ((duplet = strtok_r(NULL, ",", &duplet_save_ptr)) != NULL) {
+      flag = strtok(duplet, " ");
+      if (!flag) 
+        continue;
+      if (!strcmp(flag, "TQ")) {
+        from = strtok(NULL, " ");
+        value = strtok(NULL, " ");
+        tq = strtoul(value, &endptr, 0);
+        funcs->print_tq(orig, from, tq);
+        continue;
+      }
+      if (!strcmp(flag, "HNA")) {
+        /* We have an HNA record */
+        if (!with_HNA) 
+          continue;
+        from = strtok(NULL, " ");
+        funcs->print_HNA(orig, from);
+        continue;
+      }
+      if (!strcmp(flag, "SEC") && with_2nd) {
+        /* We found a secondary interface MAC address.*/
+        from = strtok(NULL, " ");
+        funcs->print_2nd(orig, from);
+      }
+      if (!strcmp(flag, "PRIMARY") && with_2nd) {
+        /* We found a primary interface MAC address.*/
+        funcs->print_1st(orig);
+      }
+    }
+  }
+  
+  if (funcs->print_footer)
+    funcs->print_footer();
+  
+  if (line)
+    free(line);
+  return EXIT_SUCCESS;
+}
+
+int 
+vis(int argc, char *argv[])
+{
+  bool dot = false;
+  bool json = false;
+  int c;
+
+  if (argc <=1) {
+    usage();
+    return EXIT_FAILURE;
+  }
+  
+  /* Do we know the requested format? */
+  if (strcmp(argv[1], "dot") == 0)
+    dot=true;
+  if (strcmp(argv[1], "json") == 0)
+    json=true;
+  
+  if (!dot && !json) {
+    usage();
+    return EXIT_FAILURE;
+  }
+  
+  /* Move over the output format */
+  argc--;
+  argv++;
+  
+  while (1) {
+    int option_index = 0;
+    static struct option long_options[] = {
+      {"no-HNA", 0, 0, 'h'},
+      {"no-2nd", 0, 0, '2'},
+      {"numbers", 0, 0, 'n'},
+      {0, 0, 0, 0}
+    };
+    
+    c = getopt_long(argc, argv, "h2n", long_options, &option_index);
+    if (c == -1)
+      break;
+    
+    switch(c) {
+      case 'h':
+        with_HNA = false;
+        break;
+      case '2':
+        with_2nd = false;
+        break;
+      case 'n':
+        with_names = false;
+        break;
+      default:
+        usage();
+        return -1;
+    }
+  }
+  
+  if (with_names)
+	  bat_hosts_init();
+  
+  if (dot) 
+    return format(&dot_funcs);
+  
+  if (json)
+    return format(&json_funcs);
+
+  return EXIT_FAILURE;
+}
diff --git a/batctl/vis.h b/batctl/vis.h
new file mode 100644
index 0000000..734528e
--- /dev/null
+++ b/batctl/vis.h
@@ -0,0 +1,21 @@
+/* Copyright (C) 2009 B.A.T.M.A.N. contributors:
+ * Andrew Lunn <andrew@lunn.ch>
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
+int vis(int argc, char * argv[]);
+
-- 
1.6.5.7

