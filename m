Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  7 Oct 2012 17:29:04 +0200
Message-Id: <1349623744-23821-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Add filter option for debug tables
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

Users may only want to query information about specific originator or clients
when looking at the debug tables. This can easily be done using a simple grep
when the originator mac is known. More problematic are clients or IP addresses.
The user has to perform the steps already done for ping/traceroute to get the
correct MAC address.

This filter functionality can also be added as part of batctl since the
functionality for mac translation is already in batctl. This even allows to
keep the header of the debug output intact while grep'ing for a specific
address.

This can for example be used to query the TQ of the path until the gateway
originator for a specific IP is reached.

$ ./batctl o -H -F ${IP}|sed -e 's/).*$//' -e 's/^.*(//'

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile     |    2 +-
 debug.c      |   31 ++++++++---
 filter.c     |  168 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 filter.h     |   43 +++++++++++++++
 functions.c  |   11 ++--
 functions.h  |    4 +-
 man/batctl.8 |   12 +++--
 7 files changed, 254 insertions(+), 17 deletions(-)
 create mode 100644 filter.c
 create mode 100644 filter.h

diff --git a/Makefile b/Makefile
index 4379837..a4b6c11 100755
--- a/Makefile
+++ b/Makefile
@@ -24,7 +24,7 @@ export CONFIG_BATCTL_BISECT=n
 
 # batctl build
 BINARY_NAME = batctl
-OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o  hash.o vis.o debugfs.o ioctl.o list-batman.o
+OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o  hash.o vis.o debugfs.o ioctl.o list-batman.o filter.o
 OBJ_BISECT = bisect_iv.o
 MANPAGE = man/batctl.8
 
diff --git a/debug.c b/debug.c
index 9d6ddfc..fa90e17 100644
--- a/debug.c
+++ b/debug.c
@@ -32,6 +32,7 @@
 #include "debug.h"
 #include "debugfs.h"
 #include "functions.h"
+#include "filter.h"
 
 const struct debug_table_data batctl_debug_tables[BATCTL_TABLE_NUM] = {
 	{
@@ -80,6 +81,9 @@ void debug_table_usage(int debug_table)
 	printf(" \t -h print this help\n");
 	printf(" \t -n don't replace mac addresses with bat-host names\n");
 	printf(" \t -H don't show the header\n");
+	printf(" \t -H don't show the header\n");
+	printf(" \t -F addr - add filter to only show lines about this address\n");
+	printf(" \t -T do not try to translate client mac addresses when adding filters\n");
 	printf(" \t -w [interval] watch mode - refresh the table continuously\n");
 
 	if (debug_table == BATCTL_TABLE_ORIGINATORS)
@@ -88,15 +92,17 @@ void debug_table_usage(int debug_table)
 
 int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 {
-	int optchar, read_opt = USE_BAT_HOSTS;
+	int optchar, read_opt = USE_BAT_HOSTS | TRANSLATE_MAC;
 	char full_path[MAX_PATH+1];
 	char *debugfs_mnt;
 	float orig_timeout;
 	float watch_interval = 1;
-	size_t skip_lines = 0;
+	int ret;
 	opterr = 0;
 
-	while ((optchar = getopt(argc, argv, "hnw:t:H")) != -1) {
+	filter_init();
+
+	while ((optchar = getopt(argc, argv, "hnw:t:HTF:")) != -1) {
 		switch (optchar) {
 		case 'h':
 			debug_table_usage(debug_table);
@@ -132,6 +138,13 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 		case 'H':
 			read_opt |= SKIP_HEADER;
 			break;
+		case 'T':
+			read_opt &= ~TRANSLATE_MAC;
+			break;
+		case 'F':
+			read_opt |= USE_FILTER;
+			filter_add(mesh_iface, optarg, read_opt);
+			break;
 		case '?':
 			if (optopt == 't')
 				printf("Error - option '-t' needs a number as argument\n");
@@ -156,12 +169,14 @@ int handle_debug_table(char *mesh_iface, int debug_table, int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
-	if (read_opt & SKIP_HEADER)
-		skip_lines = batctl_debug_tables[debug_table].header_lines;
-
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface, full_path, sizeof(full_path));
-	return read_file(full_path, (char *)batctl_debug_tables[debug_table].debugfs_name,
-			 read_opt, orig_timeout, watch_interval, skip_lines);
+	ret = read_file(full_path, (char *)batctl_debug_tables[debug_table].debugfs_name,
+			read_opt, orig_timeout, watch_interval,
+			batctl_debug_tables[debug_table].header_lines);
+
+	filter_free();
+
+	return ret;
 }
 
 static void log_usage(void)
diff --git a/filter.c b/filter.c
new file mode 100644
index 0000000..453dbbd
--- /dev/null
+++ b/filter.c
@@ -0,0 +1,168 @@
+/*
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+ *
+ * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
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
+#include <stdint.h>
+#include <limits.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+
+#include "main.h"
+#include "filter.h"
+#include "hash.h"
+#include "functions.h"
+
+
+static struct hashtable_t *filter_hash = NULL;
+
+static int compare_mac(void *data1, void *data2)
+{
+	return (memcmp(data1, data2, sizeof(struct ether_addr)) == 0 ? 1 : 0);
+}
+
+static int choose_mac(void *data, int32_t size)
+{
+	unsigned char *key = data;
+	uint32_t hash = 0, m_size = sizeof(struct ether_addr);
+	size_t i;
+
+	for (i = 0; i < m_size; i++) {
+		hash += key[i];
+		hash += (hash << 10);
+		hash ^= (hash >> 6);
+	}
+
+	hash += (hash << 3);
+	hash ^= (hash >> 11);
+	hash += (hash << 15);
+
+	return hash % size;
+}
+
+void filter_add(char *mesh_iface, const char *addr, int read_opt)
+{
+	struct ether_addr *mac_addr;
+	struct filter *filter;
+	struct hashtable_t *swaphash;
+
+	mac_addr = resolve_mac(addr);
+	if (!mac_addr) {
+		fprintf(stderr, "Warning - invalid mac address in detected: %s\n", addr);
+		return;
+	}
+
+	if (read_opt & TRANSLATE_MAC)
+		mac_addr = translate_mac(mesh_iface, mac_addr);
+
+	filter = malloc(sizeof(*filter));
+	if (!filter) {
+		fprintf(stderr, "Error - could not allocate memory: %s\n", strerror(errno));
+		return;
+	}
+
+	memcpy(&filter->mac_addr, mac_addr, sizeof(struct ether_addr));
+
+	hash_add(filter_hash, filter);
+	if (filter_hash->elements * 4 > filter_hash->size) {
+		swaphash = hash_resize(filter_hash, filter_hash->size * 2);
+
+		if (swaphash)
+			filter_hash = swaphash;
+		else
+			fprintf(stderr, "Warning - couldn't resize filter hash table\n");
+	}
+}
+
+int filter_match_line(const char *line)
+{
+	char *line_ptr, *buff_ptr, *space_ptr;
+	int ret = 0;
+	struct ether_addr *mac_addr;
+	struct filter *filter;
+
+	line_ptr = strdup(line);
+	if (!line_ptr)
+		return 0;
+
+	buff_ptr = line_ptr;
+
+	while ((space_ptr = strchr(buff_ptr, ' ')) != NULL) {
+
+		*space_ptr = '\0';
+
+		if (strlen(buff_ptr) == ETH_STR_LEN + 1) {
+			switch (buff_ptr[ETH_STR_LEN]) {
+			case ',':
+			case ')':
+				buff_ptr[ETH_STR_LEN] = '\0';
+				break;
+			}
+		}
+
+		if (strlen(buff_ptr) != ETH_STR_LEN)
+			goto next;
+
+		mac_addr = ether_aton(buff_ptr);
+		if (!mac_addr)
+			goto next;
+
+		filter = filter_find_by_mac(mac_addr);
+		if (filter) {
+			ret = 1;
+			goto out;
+		}
+
+next:
+		buff_ptr = space_ptr + 1;
+	}
+
+out:
+	free(line_ptr);
+	return ret;
+}
+
+void filter_init(void)
+{
+	filter_hash = hash_new(64, compare_mac, choose_mac);
+	if (!filter_hash)
+		printf("Warning - could not create filter hash table\n");
+}
+
+struct filter *filter_find_by_mac(struct ether_addr *mac)
+{
+	if (!filter_hash)
+		return NULL;
+
+	return (struct filter *)hash_find(filter_hash, (char *)mac);
+}
+
+static void filter_entry_free(void *data)
+{
+	free(data);
+}
+
+void filter_free(void)
+{
+	if (filter_hash)
+		hash_delete(filter_hash, filter_entry_free);
+}
diff --git a/filter.h b/filter.h
new file mode 100644
index 0000000..a7d997a
--- /dev/null
+++ b/filter.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <lindner_marek@yahoo.de>
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
+
+
+#ifndef _FILTER_H
+#define _FILTER_H 1
+
+#include <netinet/ether.h>
+
+#define HOST_NAME_MAX_LEN 50
+#define CONF_DIR_LEN 256
+
+
+struct filter {
+	struct ether_addr mac_addr;
+} __attribute__((packed));
+
+void filter_init(void);
+void filter_add(char *mesh_iface, const char *addr, int read_opt);
+struct filter *filter_find_by_mac(struct ether_addr *mac);
+int filter_match_line(const char *line);
+void filter_free(void);
+
+#endif
diff --git a/functions.c b/functions.c
index 15fe290..b40648f 100644
--- a/functions.c
+++ b/functions.c
@@ -38,6 +38,7 @@
 #include "main.h"
 #include "functions.h"
 #include "bat-hosts.h"
+#include "filter.h"
 #include "sys.h"
 #include "debug.h"
 #include "debugfs.h"
@@ -160,7 +161,7 @@ static void file_open_problem_dbg(char *dir, char *fname, char *full_path)
 }
 
 int read_file(char *dir, char *fname, int read_opt,
-	      float orig_timeout, float watch_interval, size_t skip_lines)
+	      float orig_timeout, float watch_interval, size_t header_lines)
 {
 	struct ether_addr *mac_addr;
 	struct bat_host *bat_host;
@@ -195,10 +196,8 @@ open:
 
 read:
 	while (getline(&line_ptr, &len, fp) != -1) {
-		if (line < skip_lines) {
-			line++;
+		if (line++ < header_lines && read_opt & SKIP_HEADER)
 			continue;
-		}
 
 		/* the buffer will be handled elsewhere */
 		if (read_opt & USE_READ_BUFF)
@@ -215,6 +214,10 @@ read:
 			continue;
 		}
 
+		if (read_opt & USE_FILTER && line > header_lines &&
+		    !filter_match_line(line_ptr))
+			continue;
+
 		/* replace mac addresses with bat host names */
 		buff_ptr = line_ptr;
 
diff --git a/functions.h b/functions.h
index fe0011b..2dd91e3 100644
--- a/functions.h
+++ b/functions.h
@@ -35,7 +35,7 @@ char *get_name_by_macaddr(struct ether_addr *mac_addr, int read_opt);
 char *get_name_by_macstr(char *mac_str, int read_opt);
 int file_exists(const char *fpath);
 int read_file(char *dir, char *path, int read_opt,
-	      float orig_timeout, float watch_interval, size_t skip_lines);
+	      float orig_timeout, float watch_interval, size_t header_lines);
 int write_file(char *dir, char *fname, char *arg1, char *arg2);
 struct ether_addr *translate_mac(char *mesh_iface, struct ether_addr *mac);
 struct ether_addr *resolve_mac(const char *asc);
@@ -53,4 +53,6 @@ enum {
 	NO_OLD_ORIGS = 0x40,
 	COMPAT_FILTER = 0x80,
 	SKIP_HEADER = 0x100,
+	USE_FILTER = 0x200,
+	TRANSLATE_MAC = 0x400,
 };
diff --git a/man/batctl.8 b/man/batctl.8
index f8dc99d..1524356 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -158,13 +158,19 @@ mounted batctl will attempt to do this step for you.
 
 All of the debug tables support the following options:
 .RS 10
-\-w     refresh the list every second or add a number to let it refresh at a custom interval in seconds (with optional decimal places)
+\-w        refresh the list every second or add a number to let it refresh at a custom interval in seconds (with optional decimal places)
 .RE
 .RS 10
-\-n     do not replace the MAC addresses with bat\-host names in the output
+\-n        do not replace the MAC addresses with bat\-host names in the output
 .RE
 .RS 10
-\-H     do not show the header of the debug table
+\-H        do not show the header of the debug table
+.RE
+.RS 10
+\-F addr   add filter to only show lines about the address
+.RE
+.RS 10
+\-T        do not try to translate client mac addresses when adding filters
 .RE
 
 .RS 7
-- 
1.7.10.4

