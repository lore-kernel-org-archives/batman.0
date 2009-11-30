Return-Path: <andrew@lunn.ch>
Date: Mon, 30 Nov 2009 22:14:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091130211445.GN4150@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] /proc vis rework
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


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Folks

A while back i suggested we re-work the /proc/net/batman/vis format.
Attached are two patches to achieve this. One patch is for the kernel
model sources and the second extends batctl so that it can read from
the /proc file and output dot or json format as before. The patch
includes documentation for the new new batctl command in the man page.

I've tested the dot output using graphviz dot. However i don't have
any tools which use the json output. So that format is not tested.

    Andrew

--OBd5C1Lgu00Gd/Tn
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="batctl.diff"

Index: batctl/vis.c
===================================================================
--- batctl/vis.c	(revision 0)
+++ batctl/vis.c	(revision 0)
@@ -0,0 +1,323 @@
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
+    orig = strtok_r(line, " ", &line_save_ptr);
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
+  
+
Index: batctl/vis.h
===================================================================
--- batctl/vis.h	(revision 0)
+++ batctl/vis.h	(revision 0)
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
Index: batctl/functions.c
===================================================================
--- batctl/functions.c	(revision 1489)
+++ batctl/functions.c	(working copy)
@@ -99,7 +99,7 @@
 	return get_name_by_macaddr(mac_addr, read_opt);
 }
 
-static int check_proc_dir(char *dir)
+int check_proc_dir(char *dir)
 {
 	struct stat st;
 
Index: batctl/functions.h
===================================================================
--- batctl/functions.h	(revision 1489)
+++ batctl/functions.h	(working copy)
@@ -34,6 +34,7 @@
 char *get_name_by_macstr(char *mac_str, int read_opt);
 int read_file(char *dir, char *path, int read_opt);
 int write_file(char *dir, char *path, char *value);
+int check_proc_dir(char *dir);
 
 extern char read_buff[10];
 
Index: batctl/main.c
===================================================================
--- batctl/main.c	(revision 1489)
+++ batctl/main.c	(working copy)
@@ -35,6 +35,7 @@
 #include "traceroute.h"
 #include "tcpdump.h"
 #include "bisect.h"
+#include "vis.h"
 
 
 void print_usage(void) {
@@ -47,7 +48,7 @@
 	printf(" \tlog|l                           \tread the log produced by the kernel module\n");
 	printf(" \ttranslocal|tl                   \tdisplay the local translation table\n");
 	printf(" \ttransglobal|tg                  \tdisplay the global translation table\n");
-	printf(" \tvisformat|vf  [format]          \tdisplay or modify the vis output format\n");
+	printf(" \tvis [dot|JSON]                  \tdisplay the VIS data in dot or JSON format\n");
 	printf(" \taggregation|ag   [0|1]          \tdisplay or modify the packet aggregation setting\n");
 	printf("\n");
 	printf(" \tping|p        <destination>     \tping another batman adv host via layer 2\n");
@@ -74,7 +75,8 @@
 	}
 
 	/* check if user is root */
-	if ((strcmp(argv[1], "bisect") != 0) && ((getuid()) || (getgid()))) {
+	if (((strcmp(argv[1], "bisect") != 0) && (strcmp(argv[1], "vis") != 0))
+	    && ((getuid()) || (getgid()))) {
 		fprintf(stderr, "Error - you must be root to run '%s' !\n", argv[0]);
 		exit(EXIT_FAILURE);
 	}
@@ -119,9 +121,9 @@
 
 		ret = handle_proc_setting(argc - 1, argv + 1, PROC_ORIG_INTERVAL, orig_interval_usage);
 
-	} else if ((strcmp(argv[1], "visformat") == 0) || (strcmp(argv[1], "vf") == 0)) {
+	} if (strcmp(argv[1], "vis") == 0) {
 
-		ret = handle_proc_setting(argc - 1, argv + 1, PROC_VIS_FORMAT, vis_format_usage);
+		ret = vis(argc - 1, argv + 1);
 
 	} else if ((strcmp(argv[1], "aggregation") == 0) || (strcmp(argv[1], "ag") == 0)) {
 
Index: batctl/man/batctl.8
===================================================================
--- batctl/man/batctl.8	(revision 1489)
+++ batctl/man/batctl.8	(working copy)
@@ -63,9 +63,22 @@
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
 .br
+.IP "\fBvis json\fP"
+Display the visualisation data in JSON format. If
+"\--numbers" or "\-n" batctl will not replace the mac addresses with
+bat-host names in the output. With "\--no-HNA" or "\-h" the HNA
+entries are not displayed, so the pure mesh topology can be seen. With
+"\--no-2nd" or "\-2" a dot cluster is not formed around primary and
+secondary addresses from the same device.
+.br
 .IP "\fBaggregation|ag	[0|1]\fP"
 If no parameter is given the current aggregation settings are displayed otherwise the parameter is used to enable or disable the packet aggregation.
 .br
Index: batctl/Makefile
===================================================================
--- batctl/Makefile	(revision 1489)
+++ batctl/Makefile	(working copy)
@@ -39,8 +39,8 @@
 EXTRA_MODULES_C := bisect.c
 EXTRA_MODULES_H := bisect.h
 
-SRC_C = main.c bat-hosts.c functions.c proc.c sys.c ping.c traceroute.c tcpdump.c list-batman.c hash.c $(EXTRA_MODULES_C)
-SRC_H = main.h bat-hosts.h functions.h proc.h sys.h ping.h traceroute.h tcpdump.h list-batman.h hash.h allocate.h $(EXTRA_MODULES_H)
+SRC_C = main.c bat-hosts.c functions.c proc.c sys.c ping.c traceroute.c tcpdump.c list-batman.c hash.c vis.c $(EXTRA_MODULES_C)
+SRC_H = main.h bat-hosts.h functions.h proc.h sys.h ping.h traceroute.h tcpdump.h list-batman.h hash.h allocate.h vis.h $(EXTRA_MODULES_H)
 SRC_O = $(SRC_C:.c=.o)
 
 PACKAGE_NAME = batctl

--OBd5C1Lgu00Gd/Tn
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="proc.diff"

diff --git a/drivers/staging/batman-adv/proc.c b/drivers/staging/batman-adv/proc.c
index ed4c734..e214936 100644
--- a/drivers/staging/batman-adv/proc.c
+++ b/drivers/staging/batman-adv/proc.c
@@ -322,91 +322,76 @@ static int proc_transt_global_open(struct inode *inode, struct file *file)
 	return single_open(file, proc_transt_global_read, NULL);
 }
 
-/* insert interface to the list of interfaces of one originator */
+/* While scanning for vis-entries of a particular vis-originator
+ * this list collects its interfaces to create a subgraph/cluster
+ * out of them later
+ */
+struct if_list_entry {
+	uint8_t addr[ETH_ALEN];
+	bool primary;
+	struct hlist_node list;
+};
+
+/* insert interface to the list of interfaces of one originator, if it
+ * does not already exist in the list */
 
 static void proc_vis_insert_interface(const uint8_t *interface,
-				      struct vis_if_list **if_entry,
+				      struct hlist_head *if_list,
 				      bool primary)
 {
-	/* Did we get an empty list? (then insert imediately) */
-	if (*if_entry == NULL) {
-		*if_entry = kmalloc(sizeof(struct vis_if_list), GFP_KERNEL);
-		if (*if_entry == NULL)
+	struct if_list_entry *entry;
+	struct hlist_node *pos;
+
+
+	hlist_for_each_entry(entry, pos, if_list, list) {
+		if (compare_orig(entry->addr, (void *)interface))
 			return;
+	}
 
-		(*if_entry)->primary = primary;
-		(*if_entry)->next = NULL;
-		memcpy((*if_entry)->addr, interface, ETH_ALEN);
-	} else {
-		struct vis_if_list *head_if_entry = *if_entry;
-		/* Do we already have this interface in our list? */
-		while (!compare_orig((*if_entry)->addr, (void *)interface)) {
-
-			/* Or did we reach the end (then append the interface) */
-			if ((*if_entry)->next == NULL) {
-				(*if_entry)->next = kmalloc(sizeof(struct vis_if_list), GFP_KERNEL);
-				if ((*if_entry)->next == NULL)
-					return;
-
-				memcpy((*if_entry)->next->addr, interface, ETH_ALEN);
-				(*if_entry)->next->primary = primary;
-				(*if_entry)->next->next = NULL;
-				break;
-			}
-			*if_entry = (*if_entry)->next;
+	/* its a new address, add it to the list */
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return;
+	memcpy(entry->addr, interface, ETH_ALEN);
+	entry->primary = primary;
+	hlist_add_head(&entry->list, if_list);
+}
+
+static void proc_vis_read_prim_sec(struct seq_file *seq,
+				   struct hlist_head *if_list)
+{
+	struct if_list_entry *entry;
+	struct hlist_node *pos, *n;
+	char tmp_addr_str[ETH_STR_LEN];
+
+	hlist_for_each_entry_safe(entry, pos, n, if_list, list) {
+		if (entry->primary)
+			seq_printf(seq, "PRIMARY, ");
+		else {
+			addr_to_string(tmp_addr_str, entry->addr);
+			seq_printf(seq, "SEC %s, ", tmp_addr_str);
 		}
-		/* Rewind the list to its head */
-		*if_entry = head_if_entry;
+		hlist_del(&entry->list);
+		kfree(entry);
 	}
 }
-/* read an entry  */
 
+/* read an entry  */
 static void proc_vis_read_entry(struct seq_file *seq,
 				struct vis_info_entry *entry,
-				struct vis_if_list **if_entry,
-				uint8_t *vis_orig,
-				uint8_t current_format,
-				uint8_t first_line)
+				struct hlist_head *if_list,
+				uint8_t *vis_orig)
 {
-	char from[40];
 	char to[40];
-	int int_part, frac_part;
 
 	addr_to_string(to, entry->dest);
 	if (entry->quality == 0) {
-#ifndef VIS_SUBCLUSTERS_DISABLED
-		proc_vis_insert_interface(vis_orig, if_entry, true);
-#endif /* VIS_SUBCLUSTERS_DISABLED */
-		addr_to_string(from, vis_orig);
-		if (current_format == DOT_DRAW) {
-			seq_printf(seq, "\t\"%s\" -> \"%s\" [label=\"HNA\"]\n",
-				   from, to);
-		} else {
-			seq_printf(seq,
-				   "%s\t{ router : \"%s\", gateway   : \"%s\", label : \"HNA\" }",
-				   (first_line ? "" : ",\n"), from, to);
-		}
+		proc_vis_insert_interface(vis_orig, if_list, true);
+		seq_printf(seq, "HNA %s, ", to);
 	} else {
-#ifndef VIS_SUBCLUSTERS_DISABLED
-		proc_vis_insert_interface(entry->src, if_entry, compare_orig(entry->src, vis_orig));
-#endif /* VIS_SUBCLUSTERS_DISABLED */
-		addr_to_string(from, entry->src);
-
-		/* kernel has no printf-support for %f? it'd be better to return
-		 * this in float. */
-
-		int_part = TQ_MAX_VALUE / entry->quality;
-		frac_part = 1000 * TQ_MAX_VALUE / entry->quality - int_part * 1000;
-
-		if (current_format == DOT_DRAW) {
-			seq_printf(seq,
-				   "\t\"%s\" -> \"%s\" [label=\"%d.%d\"]\n",
-				   from, to, int_part, frac_part);
-		} else {
-			seq_printf(seq,
-				   "%s\t{ router : \"%s\", neighbour : \"%s\", label : %d.%d }",
-				   (first_line ? "" : ",\n"), from, to, int_part, frac_part);
-		}
+		proc_vis_insert_interface(entry->src, if_list,
+					  compare_orig(entry->src, vis_orig));
+		seq_printf(seq, "TQ %s %d, ", to, entry->quality);
 	}
 }
 
@@ -416,72 +401,40 @@ static int proc_vis_read(struct seq_file *seq, void *offset)
 	struct hash_it_t *hashit = NULL;
 	struct vis_info *info;
 	struct vis_info_entry *entries;
-	struct vis_if_list *if_entries = NULL;
+	HLIST_HEAD(vis_if_list);
 	int i;
-	uint8_t current_format, first_line = 1;
-#ifndef VIS_SUBCLUSTERS_DISABLED
+	uint8_t current_format;
 	char tmp_addr_str[ETH_STR_LEN];
-	struct vis_if_list *tmp_if_next;
-#endif /* VIS_SUBCLUSTERS_DISABLED */
 
 	current_format = vis_format;
 
 	rcu_read_lock();
 	if (list_empty(&if_list) || (!is_vis_server())) {
 		rcu_read_unlock();
-		if (current_format == DOT_DRAW)
-			seq_printf(seq, "digraph {\n}\n");
 		goto end;
 	}
 
 	rcu_read_unlock();
 
-	if (current_format == DOT_DRAW)
-		seq_printf(seq, "digraph {\n");
-
 	spin_lock(&vis_hash_lock);
 	while (NULL != (hashit = hash_iterate(vis_hash, hashit))) {
 		info = hashit->bucket->data;
 		entries = (struct vis_info_entry *)
 			((char *)info + sizeof(struct vis_info));
+		addr_to_string(tmp_addr_str, info->packet.vis_orig);
+		seq_printf(seq, "%s,", tmp_addr_str);
 
 		for (i = 0; i < info->packet.entries; i++) {
-			proc_vis_read_entry(seq, &entries[i], &if_entries,
-					    info->packet.vis_orig,
-					    current_format, first_line);
-			if (first_line)
-				first_line = 0;
+			proc_vis_read_entry(seq, &entries[i], &vis_if_list,
+					    info->packet.vis_orig);
 		}
 
-#ifndef VIS_SUBCLUSTERS_DISABLED
-		/* Generate subgraphs from the collected items */
-		if (current_format == DOT_DRAW) {
-
-			addr_to_string(tmp_addr_str, info->packet.vis_orig);
-			seq_printf(seq, "\tsubgraph \"cluster_%s\" {\n", tmp_addr_str);
-			while (if_entries != NULL) {
-
-				addr_to_string(tmp_addr_str, if_entries->addr);
-				if (if_entries->primary)
-					seq_printf(seq, "\t\t\"%s\" [peripheries=2]\n", tmp_addr_str);
-				else
-					seq_printf(seq, "\t\t\"%s\"\n", tmp_addr_str);
-
-				/* ... and empty the list while doing this */
-				tmp_if_next = if_entries->next;
-				kfree(if_entries);
-				if_entries = tmp_if_next;
-			}
-			seq_printf(seq, "\t}\n");
-		}
-#endif /* VIS_SUBCLUSTERS_DISABLED */
-	}
-	spin_unlock(&vis_hash_lock);
+		/* add primary/secondary records */
+		proc_vis_read_prim_sec(seq, &vis_if_list);
 
-	if (current_format == DOT_DRAW)
-		seq_printf(seq, "}\n");
-	else
 		seq_printf(seq, "\n");
+	}
+	spin_unlock(&vis_hash_lock);
 end:
 	return 0;
 }
diff --git a/drivers/staging/batman-adv/proc.h b/drivers/staging/batman-adv/proc.h
index 16d3efd..761c5f8 100644
--- a/drivers/staging/batman-adv/proc.h
+++ b/drivers/staging/batman-adv/proc.h
@@ -38,12 +38,3 @@
 void cleanup_procfs(void);
 int setup_procfs(void);
 
-/* While scanning for vis-entries of a particular vis-originator
- * this list collects its interfaces to create a subgraph/cluster
- * out of them later
- */
-struct vis_if_list {
-	uint8_t addr[ETH_ALEN];
-	bool primary;
-	struct vis_if_list *next;
-};

--OBd5C1Lgu00Gd/Tn--
