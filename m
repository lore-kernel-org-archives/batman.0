Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:55:10 +0200
Message-Id: <20181021225524.8155-25-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 24/38] batctl: Move neighbors debug table to
 own file
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
 Makefile    |   1 +
 debug.c     |   9 ----
 neighbors.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.c   |  94 -----------------------------------
 netlink.h   |   2 -
 5 files changed, 141 insertions(+), 105 deletions(-)
 create mode 100644 neighbors.c

diff --git a/Makefile b/Makefile
index ac4824b..d447663 100755
--- a/Makefile
+++ b/Makefile
@@ -50,6 +50,7 @@ OBJ += log.o
 OBJ += main.o
 OBJ += mcast_flags.o
 OBJ += nc_nodes.o
+OBJ += neighbors.o
 OBJ += netlink.o
 OBJ += ping.o
 OBJ += routing_algo.o
diff --git a/debug.c b/debug.c
index 531c6aa..a5e7276 100644
--- a/debug.c
+++ b/debug.c
@@ -200,15 +200,6 @@ int debug_print_routing_algos(void)
 	return read_file(full_path, DEBUG_ROUTING_ALGOS, 0, 0, 0, 0);
 }
 
-static struct debug_table_data batctl_debug_table_neighbors = {
-	.debugfs_name = "neighbors",
-	.header_lines = 2,
-	.netlink_fn = netlink_print_neighbors,
-};
-
-COMMAND_NAMED(DEBUGTABLE, neighbors, "n", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_neighbors, "");
-
 static struct debug_table_data batctl_debug_table_originators = {
 	.debugfs_name = "originators",
 	.header_lines = 2,
diff --git a/neighbors.c b/neighbors.c
new file mode 100644
index 0000000..c7a0f45
--- /dev/null
+++ b/neighbors.c
@@ -0,0 +1,140 @@
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
+#include <net/if.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+
+#include "batadv_packet.h"
+#include "batman_adv.h"
+#include "bat-hosts.h"
+#include "debug.h"
+#include "functions.h"
+#include "main.h"
+#include "netlink.h"
+
+static const int neighbors_mandatory[] = {
+	BATADV_ATTR_NEIGH_ADDRESS,
+	BATADV_ATTR_HARD_IFINDEX,
+	BATADV_ATTR_LAST_SEEN_MSECS,
+};
+
+static int neighbors_callback(struct nl_msg *msg, void *arg)
+{
+	unsigned throughput_mbits, throughput_kbits;
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	int last_seen_msecs, last_seen_secs;
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	char ifname[IF_NAMESIZE];
+	struct genlmsghdr *ghdr;
+	uint8_t *neigh;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_NEIGHBORS)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, neighbors_mandatory,
+				    ARRAY_SIZE(neighbors_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	neigh = nla_data(attrs[BATADV_ATTR_NEIGH_ADDRESS]);
+	bat_host = bat_hosts_find_by_mac((char *)neigh);
+
+	if (!if_indextoname(nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]),
+			    ifname))
+		ifname[0] = '\0';
+
+	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+	last_seen_secs = last_seen_msecs / 1000;
+	last_seen_msecs = last_seen_msecs % 1000;
+
+	if (attrs[BATADV_ATTR_THROUGHPUT]) {
+		throughput_kbits = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);
+		throughput_mbits = throughput_kbits / 1000;
+		throughput_kbits = throughput_kbits % 1000;
+
+		if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+			printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+			       neigh[0], neigh[1], neigh[2],
+			       neigh[3], neigh[4], neigh[5]);
+		else
+			printf("%17s ", bat_host->name);
+
+		printf("%4i.%03is (%9u.%1u) [%10s]\n",
+		       last_seen_secs, last_seen_msecs,
+		       throughput_mbits, throughput_kbits / 100,
+		       ifname);
+	} else {
+		printf("   %10s	  ", ifname);
+
+		if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+			printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+			       neigh[0], neigh[1], neigh[2],
+			       neigh[3], neigh[4], neigh[5]);
+		else
+			printf("%17s ", bat_host->name);
+
+		printf("%4i.%03is\n", last_seen_secs, last_seen_msecs);
+	}
+
+	return NL_OK;
+}
+
+static int netlink_print_neighbors(char *mesh_iface, char *orig_iface,
+				   int read_opts, float orig_timeout,
+				   float watch_interval)
+{
+	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+				    orig_timeout, watch_interval,
+				    "IF             Neighbor              last-seen\n",
+				    BATADV_CMD_GET_NEIGHBORS,
+				    neighbors_callback);
+}
+
+static struct debug_table_data batctl_debug_table_neighbors = {
+	.debugfs_name = "neighbors",
+	.header_lines = 2,
+	.netlink_fn = netlink_print_neighbors,
+};
+
+COMMAND_NAMED(DEBUGTABLE, neighbors, "n", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_neighbors, "");
diff --git a/netlink.c b/netlink.c
index 4f2199e..7735cb6 100644
--- a/netlink.c
+++ b/netlink.c
@@ -595,89 +595,6 @@ static int originators_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static const int neighbors_mandatory[] = {
-	BATADV_ATTR_NEIGH_ADDRESS,
-	BATADV_ATTR_HARD_IFINDEX,
-	BATADV_ATTR_LAST_SEEN_MSECS,
-};
-
-static int neighbors_callback(struct nl_msg *msg, void *arg)
-{
-	unsigned throughput_mbits, throughput_kbits;
-	struct nlattr *attrs[BATADV_ATTR_MAX+1];
-	struct nlmsghdr *nlh = nlmsg_hdr(msg);
-	int last_seen_msecs, last_seen_secs;
-	struct print_opts *opts = arg;
-	struct bat_host *bat_host;
-	char ifname[IF_NAMESIZE];
-	struct genlmsghdr *ghdr;
-	uint8_t *neigh;
-
-	if (!genlmsg_valid_hdr(nlh, 0)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	ghdr = nlmsg_data(nlh);
-
-	if (ghdr->cmd != BATADV_CMD_GET_NEIGHBORS)
-		return NL_OK;
-
-	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), batadv_netlink_policy)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	if (missing_mandatory_attrs(attrs, neighbors_mandatory,
-				    ARRAY_SIZE(neighbors_mandatory))) {
-		fputs("Missing attributes from kernel\n", stderr);
-		exit(1);
-	}
-
-	neigh = nla_data(attrs[BATADV_ATTR_NEIGH_ADDRESS]);
-	bat_host = bat_hosts_find_by_mac((char *)neigh);
-
-	if (!if_indextoname(nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]),
-			    ifname))
-		ifname[0] = '\0';
-
-	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
-	last_seen_secs = last_seen_msecs / 1000;
-	last_seen_msecs = last_seen_msecs % 1000;
-
-	if (attrs[BATADV_ATTR_THROUGHPUT]) {
-		throughput_kbits = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);
-		throughput_mbits = throughput_kbits / 1000;
-		throughput_kbits = throughput_kbits % 1000;
-
-		if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
-			printf("%02x:%02x:%02x:%02x:%02x:%02x ",
-			       neigh[0], neigh[1], neigh[2],
-			       neigh[3], neigh[4], neigh[5]);
-		else
-			printf("%17s ", bat_host->name);
-
-		printf("%4i.%03is (%9u.%1u) [%10s]\n",
-		       last_seen_secs, last_seen_msecs,
-		       throughput_mbits, throughput_kbits / 100,
-		       ifname);
-	} else {
-		printf("   %10s	  ", ifname);
-
-		if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
-			printf("%02x:%02x:%02x:%02x:%02x:%02x ",
-			       neigh[0], neigh[1], neigh[2],
-			       neigh[3], neigh[4], neigh[5]);
-		else
-			printf("%17s ", bat_host->name);
-
-		printf("%4i.%03is\n", last_seen_secs, last_seen_msecs);
-	}
-
-	return NL_OK;
-}
-
 static const int transglobal_mandatory[] = {
 	BATADV_ATTR_TT_ADDRESS,
 	BATADV_ATTR_ORIG_ADDRESS,
@@ -1018,17 +935,6 @@ int netlink_print_originators(char *mesh_iface, char *orig_iface,
 				    originators_callback);
 }
 
-int netlink_print_neighbors(char *mesh_iface, char *orig_iface, int read_opts,
-			    float orig_timeout,
-			    float watch_interval)
-{
-	return netlink_print_common(mesh_iface, orig_iface, read_opts,
-				    orig_timeout, watch_interval,
-				    "IF             Neighbor              last-seen\n",
-				    BATADV_CMD_GET_NEIGHBORS,
-				    neighbors_callback);
-}
-
 int netlink_print_transglobal(char *mesh_iface, char *orig_iface,
 			      int read_opts, float orig_timeout,
 			      float watch_interval)
diff --git a/netlink.h b/netlink.h
index e0fa466..bfac3a5 100644
--- a/netlink.h
+++ b/netlink.h
@@ -42,8 +42,6 @@ struct ether_addr;
 int netlink_print_routing_algos(void);
 int netlink_print_originators(char *mesh_iface, char *orig_iface, int read_opt,
 			      float orig_timeout, float watch_interval);
-int netlink_print_neighbors(char *mesh_iface, char *orig_iface, int read_opt,
-			    float orig_timeout, float watch_interval);
 int netlink_print_transglobal(char *mesh_iface, char *orig_iface, int read_opt,
 			      float orig_timeout, float watch_interval);
 int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opt,
-- 
2.19.1

