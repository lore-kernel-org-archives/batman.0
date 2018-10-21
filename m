Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:55:11 +0200
Message-Id: <20181021225524.8155-26-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 25/38] batctl: Move originators debug table
 to own file
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

The netlink.c file contains to many different functions and mixes helper
functions with actual command implementations. The debug table commands
should be placed in separate files to better group the command specific
code sections together.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile      |   1 +
 debug.c       |  11 ---
 netlink.c     | 175 ---------------------------------------
 netlink.h     |   2 -
 originators.c | 225 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 226 insertions(+), 188 deletions(-)
 create mode 100644 originators.c

diff --git a/Makefile b/Makefile
index d447663..059c602 100755
--- a/Makefile
+++ b/Makefile
@@ -53,6 +53,7 @@ OBJ += nc_nodes.o
 OBJ += neighbors.o
 OBJ += netlink.o
 OBJ += ping.o
+OBJ += originators.o
 OBJ += routing_algo.o
 OBJ += statistics.o
 OBJ += sys.o
diff --git a/debug.c b/debug.c
index a5e7276..f4cc2ea 100644
--- a/debug.c
+++ b/debug.c
@@ -200,17 +200,6 @@ int debug_print_routing_algos(void)
 	return read_file(full_path, DEBUG_ROUTING_ALGOS, 0, 0, 0, 0);
 }
 
-static struct debug_table_data batctl_debug_table_originators = {
-	.debugfs_name = "originators",
-	.header_lines = 2,
-	.netlink_fn = netlink_print_originators,
-	.option_watch_interval = 1,
-	.option_orig_iface = 1,
-};
-
-COMMAND_NAMED(DEBUGTABLE, originators, "o", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_originators, "");
-
 static struct debug_table_data batctl_debug_table_translocal = {
 	.debugfs_name = "transtable_local",
 	.header_lines = 2,
diff --git a/netlink.c b/netlink.c
index 7735cb6..cbb73ac 100644
--- a/netlink.c
+++ b/netlink.c
@@ -456,145 +456,6 @@ int netlink_print_routing_algos(void)
 	return last_err;
 }
 
-static const int originators_mandatory[] = {
-	BATADV_ATTR_ORIG_ADDRESS,
-	BATADV_ATTR_NEIGH_ADDRESS,
-	BATADV_ATTR_HARD_IFINDEX,
-	BATADV_ATTR_LAST_SEEN_MSECS,
-};
-
-static int originators_callback(struct nl_msg *msg, void *arg)
-{
-	unsigned throughput_mbits, throughput_kbits;
-	struct nlattr *attrs[BATADV_ATTR_MAX+1];
-	struct nlmsghdr *nlh = nlmsg_hdr(msg);
-	int last_seen_msecs, last_seen_secs;
-	struct print_opts *opts = arg;
-	struct bat_host *bat_host;
-	struct genlmsghdr *ghdr;
-	char ifname[IF_NAMESIZE];
-	float last_seen;
-	uint8_t *neigh;
-	uint8_t *orig;
-	char c = ' ';
-	uint8_t tq;
-
-	if (!genlmsg_valid_hdr(nlh, 0)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	ghdr = nlmsg_data(nlh);
-
-	if (ghdr->cmd != BATADV_CMD_GET_ORIGINATORS)
-		return NL_OK;
-
-	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), batadv_netlink_policy)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	if (missing_mandatory_attrs(attrs, originators_mandatory,
-				       ARRAY_SIZE(originators_mandatory))) {
-		fputs("Missing attributes from kernel\n", stderr);
-		exit(1);
-	}
-
-	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
-	neigh = nla_data(attrs[BATADV_ATTR_NEIGH_ADDRESS]);
-
-	if (!if_indextoname(nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]),
-			    ifname))
-		ifname[0] = '\0';
-
-	if (attrs[BATADV_ATTR_FLAG_BEST])
-		c = '*';
-
-	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
-	last_seen = (float)last_seen_msecs / 1000.0;
-	last_seen_secs = last_seen_msecs / 1000;
-	last_seen_msecs = last_seen_msecs % 1000;
-
-	/* skip timed out originators */
-	if (opts->read_opt & NO_OLD_ORIGS)
-		if (last_seen > opts->orig_timeout)
-			return NL_OK;
-
-	if (attrs[BATADV_ATTR_THROUGHPUT]) {
-		throughput_kbits = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);
-		throughput_mbits = throughput_kbits / 1000;
-		throughput_kbits = throughput_kbits % 1000;
-
-		if (!(opts->read_opt & USE_BAT_HOSTS)) {
-			printf(" %c %02x:%02x:%02x:%02x:%02x:%02x %4i.%03is (%9u.%1u) %02x:%02x:%02x:%02x:%02x:%02x [%10s]\n",
-			       c,
-			       orig[0], orig[1], orig[2],
-			       orig[3], orig[4], orig[5],
-			       last_seen_secs, last_seen_msecs,
-			       throughput_mbits, throughput_kbits / 100,
-			       neigh[0], neigh[1], neigh[2],
-			       neigh[3], neigh[4], neigh[5],
-			       ifname);
-		} else {
-			bat_host = bat_hosts_find_by_mac((char *)orig);
-			if (bat_host)
-				printf(" %c %17s ", c, bat_host->name);
-			else
-				printf(" %c %02x:%02x:%02x:%02x:%02x:%02x ",
-				       c,
-				       orig[0], orig[1], orig[2],
-				       orig[3], orig[4], orig[5]);
-			printf("%4i.%03is (%9u.%1u) ",
-			       last_seen_secs, last_seen_msecs,
-			       throughput_mbits, throughput_kbits / 100);
-			bat_host = bat_hosts_find_by_mac((char *)neigh);
-			if (bat_host)
-				printf(" %c %17s ", c, bat_host->name);
-			else
-				printf(" %02x:%02x:%02x:%02x:%02x:%02x ",
-				       neigh[0], neigh[1], neigh[2],
-				       neigh[3], neigh[4], neigh[5]);
-			printf("[%10s]\n", ifname);
-		}
-	}
-	if (attrs[BATADV_ATTR_TQ]) {
-		tq = nla_get_u8(attrs[BATADV_ATTR_TQ]);
-
-		if (!(opts->read_opt & USE_BAT_HOSTS)) {
-			printf(" %c %02x:%02x:%02x:%02x:%02x:%02x %4i.%03is   (%3i) %02x:%02x:%02x:%02x:%02x:%02x [%10s]\n",
-			       c,
-			       orig[0], orig[1], orig[2],
-			       orig[3], orig[4], orig[5],
-			       last_seen_secs, last_seen_msecs, tq,
-			       neigh[0], neigh[1], neigh[2],
-			       neigh[3], neigh[4], neigh[5],
-			       ifname);
-		} else {
-			bat_host = bat_hosts_find_by_mac((char *)orig);
-			if (bat_host)
-				printf(" %c %17s ", c, bat_host->name);
-			else
-				printf(" %c %02x:%02x:%02x:%02x:%02x:%02x ",
-				       c,
-				       orig[0], orig[1], orig[2],
-				       orig[3], orig[4], orig[5]);
-			printf("%4i.%03is   (%3i) ",
-			       last_seen_secs, last_seen_msecs, tq);
-			bat_host = bat_hosts_find_by_mac((char *)neigh);
-			if (bat_host)
-				printf("%17s ", bat_host->name);
-			else
-				printf("%02x:%02x:%02x:%02x:%02x:%02x ",
-				       neigh[0], neigh[1], neigh[2],
-				       neigh[3], neigh[4], neigh[5]);
-			printf("[%10s]\n", ifname);
-		}
-	}
-
-	return NL_OK;
-}
-
 static const int transglobal_mandatory[] = {
 	BATADV_ATTR_TT_ADDRESS,
 	BATADV_ATTR_ORIG_ADDRESS,
@@ -899,42 +760,6 @@ int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
 	return last_err;
 }
 
-int netlink_print_originators(char *mesh_iface, char *orig_iface,
-			      int read_opts, float orig_timeout,
-			      float watch_interval)
-{
-	char *header = NULL;
-	char *info_header;
-	int ifindex;
-
-	ifindex = if_nametoindex(mesh_iface);
-	if (!ifindex) {
-		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
-		return -ENODEV;
-	}
-
-	/* only parse routing algorithm name */
-	last_err = -EINVAL;
-	info_header = netlink_get_info(ifindex, BATADV_CMD_GET_ORIGINATORS, NULL);
-	free(info_header);
-
-	if (strlen(algo_name_buf) == 0)
-		return last_err;
-
-	if (!strcmp("BATMAN_IV", algo_name_buf))
-		header = "   Originator        last-seen (#/255) Nexthop           [outgoingIF]\n";
-	if (!strcmp("BATMAN_V", algo_name_buf))
-		header = "   Originator        last-seen ( throughput)  Nexthop           [outgoingIF]\n";
-
-	if (!header)
-		return -EINVAL;
-
-	return netlink_print_common(mesh_iface, orig_iface, read_opts,
-				    orig_timeout, watch_interval, header,
-				    BATADV_CMD_GET_ORIGINATORS,
-				    originators_callback);
-}
-
 int netlink_print_transglobal(char *mesh_iface, char *orig_iface,
 			      int read_opts, float orig_timeout,
 			      float watch_interval)
diff --git a/netlink.h b/netlink.h
index bfac3a5..a099482 100644
--- a/netlink.h
+++ b/netlink.h
@@ -40,8 +40,6 @@ struct print_opts {
 struct ether_addr;
 
 int netlink_print_routing_algos(void);
-int netlink_print_originators(char *mesh_iface, char *orig_iface, int read_opt,
-			      float orig_timeout, float watch_interval);
 int netlink_print_transglobal(char *mesh_iface, char *orig_iface, int read_opt,
 			      float orig_timeout, float watch_interval);
 int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opt,
diff --git a/originators.c b/originators.c
new file mode 100644
index 0000000..fd2aa66
--- /dev/null
+++ b/originators.c
@@ -0,0 +1,225 @@
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
+#include <errno.h>
+#include <net/if.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+
+#include "batadv_packet.h"
+#include "batman_adv.h"
+#include "bat-hosts.h"
+#include "debug.h"
+#include "functions.h"
+#include "main.h"
+#include "netlink.h"
+
+static const int originators_mandatory[] = {
+	BATADV_ATTR_ORIG_ADDRESS,
+	BATADV_ATTR_NEIGH_ADDRESS,
+	BATADV_ATTR_HARD_IFINDEX,
+	BATADV_ATTR_LAST_SEEN_MSECS,
+};
+
+static int originators_callback(struct nl_msg *msg, void *arg)
+{
+	unsigned throughput_mbits, throughput_kbits;
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	int last_seen_msecs, last_seen_secs;
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	char ifname[IF_NAMESIZE];
+	float last_seen;
+	uint8_t *neigh;
+	uint8_t *orig;
+	char c = ' ';
+	uint8_t tq;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_ORIGINATORS)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, originators_mandatory,
+				       ARRAY_SIZE(originators_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
+	neigh = nla_data(attrs[BATADV_ATTR_NEIGH_ADDRESS]);
+
+	if (!if_indextoname(nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]),
+			    ifname))
+		ifname[0] = '\0';
+
+	if (attrs[BATADV_ATTR_FLAG_BEST])
+		c = '*';
+
+	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+	last_seen = (float)last_seen_msecs / 1000.0;
+	last_seen_secs = last_seen_msecs / 1000;
+	last_seen_msecs = last_seen_msecs % 1000;
+
+	/* skip timed out originators */
+	if (opts->read_opt & NO_OLD_ORIGS)
+		if (last_seen > opts->orig_timeout)
+			return NL_OK;
+
+	if (attrs[BATADV_ATTR_THROUGHPUT]) {
+		throughput_kbits = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);
+		throughput_mbits = throughput_kbits / 1000;
+		throughput_kbits = throughput_kbits % 1000;
+
+		if (!(opts->read_opt & USE_BAT_HOSTS)) {
+			printf(" %c %02x:%02x:%02x:%02x:%02x:%02x %4i.%03is (%9u.%1u) %02x:%02x:%02x:%02x:%02x:%02x [%10s]\n",
+			       c,
+			       orig[0], orig[1], orig[2],
+			       orig[3], orig[4], orig[5],
+			       last_seen_secs, last_seen_msecs,
+			       throughput_mbits, throughput_kbits / 100,
+			       neigh[0], neigh[1], neigh[2],
+			       neigh[3], neigh[4], neigh[5],
+			       ifname);
+		} else {
+			bat_host = bat_hosts_find_by_mac((char *)orig);
+			if (bat_host)
+				printf(" %c %17s ", c, bat_host->name);
+			else
+				printf(" %c %02x:%02x:%02x:%02x:%02x:%02x ",
+				       c,
+				       orig[0], orig[1], orig[2],
+				       orig[3], orig[4], orig[5]);
+			printf("%4i.%03is (%9u.%1u) ",
+			       last_seen_secs, last_seen_msecs,
+			       throughput_mbits, throughput_kbits / 100);
+			bat_host = bat_hosts_find_by_mac((char *)neigh);
+			if (bat_host)
+				printf(" %c %17s ", c, bat_host->name);
+			else
+				printf(" %02x:%02x:%02x:%02x:%02x:%02x ",
+				       neigh[0], neigh[1], neigh[2],
+				       neigh[3], neigh[4], neigh[5]);
+			printf("[%10s]\n", ifname);
+		}
+	}
+	if (attrs[BATADV_ATTR_TQ]) {
+		tq = nla_get_u8(attrs[BATADV_ATTR_TQ]);
+
+		if (!(opts->read_opt & USE_BAT_HOSTS)) {
+			printf(" %c %02x:%02x:%02x:%02x:%02x:%02x %4i.%03is   (%3i) %02x:%02x:%02x:%02x:%02x:%02x [%10s]\n",
+			       c,
+			       orig[0], orig[1], orig[2],
+			       orig[3], orig[4], orig[5],
+			       last_seen_secs, last_seen_msecs, tq,
+			       neigh[0], neigh[1], neigh[2],
+			       neigh[3], neigh[4], neigh[5],
+			       ifname);
+		} else {
+			bat_host = bat_hosts_find_by_mac((char *)orig);
+			if (bat_host)
+				printf(" %c %17s ", c, bat_host->name);
+			else
+				printf(" %c %02x:%02x:%02x:%02x:%02x:%02x ",
+				       c,
+				       orig[0], orig[1], orig[2],
+				       orig[3], orig[4], orig[5]);
+			printf("%4i.%03is   (%3i) ",
+			       last_seen_secs, last_seen_msecs, tq);
+			bat_host = bat_hosts_find_by_mac((char *)neigh);
+			if (bat_host)
+				printf("%17s ", bat_host->name);
+			else
+				printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+				       neigh[0], neigh[1], neigh[2],
+				       neigh[3], neigh[4], neigh[5]);
+			printf("[%10s]\n", ifname);
+		}
+	}
+
+	return NL_OK;
+}
+
+static int netlink_print_originators(char *mesh_iface, char *orig_iface,
+				     int read_opts, float orig_timeout,
+				     float watch_interval)
+{
+	char *header = NULL;
+	char *info_header;
+	int ifindex;
+
+	ifindex = if_nametoindex(mesh_iface);
+	if (!ifindex) {
+		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
+		return -ENODEV;
+	}
+
+	/* only parse routing algorithm name */
+	last_err = -EINVAL;
+	info_header = netlink_get_info(ifindex, BATADV_CMD_GET_ORIGINATORS, NULL);
+	free(info_header);
+
+	if (strlen(algo_name_buf) == 0)
+		return last_err;
+
+	if (!strcmp("BATMAN_IV", algo_name_buf))
+		header = "   Originator        last-seen (#/255) Nexthop           [outgoingIF]\n";
+	if (!strcmp("BATMAN_V", algo_name_buf))
+		header = "   Originator        last-seen ( throughput)  Nexthop           [outgoingIF]\n";
+
+	if (!header)
+		return -EINVAL;
+
+	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+				    orig_timeout, watch_interval, header,
+				    BATADV_CMD_GET_ORIGINATORS,
+				    originators_callback);
+}
+
+static struct debug_table_data batctl_debug_table_originators = {
+	.debugfs_name = "originators",
+	.header_lines = 2,
+	.netlink_fn = netlink_print_originators,
+	.option_watch_interval = 1,
+	.option_orig_iface = 1,
+};
+
+COMMAND_NAMED(DEBUGTABLE, originators, "o", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_originators, "");
-- 
2.19.1

