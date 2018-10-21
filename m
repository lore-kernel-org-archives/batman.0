Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:55:07 +0200
Message-Id: <20181021225524.8155-22-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 21/38] batctl: Move gateways debug table to
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
 Makefile   |   1 +
 debug.c    |   9 ---
 gateways.c | 173 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.c  | 130 +---------------------------------------
 netlink.h  |   8 +--
 5 files changed, 181 insertions(+), 140 deletions(-)
 create mode 100644 gateways.c

diff --git a/Makefile b/Makefile
index 648c7bc..3a8e785 100755
--- a/Makefile
+++ b/Makefile
@@ -39,6 +39,7 @@ OBJ += dat_cache.o
 OBJ += debugfs.o
 OBJ += debug.o
 OBJ += functions.o
+OBJ += gateways.o
 OBJ += genl.o
 OBJ += gw_mode.o
 OBJ += hash.o
diff --git a/debug.c b/debug.c
index 29c8252..7bf8bff 100644
--- a/debug.c
+++ b/debug.c
@@ -220,15 +220,6 @@ static struct debug_table_data batctl_debug_table_originators = {
 COMMAND_NAMED(DEBUGTABLE, originators, "o", handle_debug_table,
 	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_originators, "");
 
-static struct debug_table_data batctl_debug_table_gateways = {
-	.debugfs_name = "gateways",
-	.header_lines = 1,
-	.netlink_fn = netlink_print_gateways,
-};
-
-COMMAND_NAMED(DEBUGTABLE, gateways, "gwl", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_gateways, "");
-
 static struct debug_table_data batctl_debug_table_translocal = {
 	.debugfs_name = "transtable_local",
 	.header_lines = 2,
diff --git a/gateways.c b/gateways.c
new file mode 100644
index 0000000..d027a32
--- /dev/null
+++ b/gateways.c
@@ -0,0 +1,173 @@
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
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
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
+static const int gateways_mandatory[] = {
+	BATADV_ATTR_ORIG_ADDRESS,
+	BATADV_ATTR_ROUTER,
+	BATADV_ATTR_HARD_IFNAME,
+	BATADV_ATTR_BANDWIDTH_DOWN,
+	BATADV_ATTR_BANDWIDTH_UP,
+};
+
+static int gateways_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	const char *primary_if;
+	uint32_t bandwidth_down;
+	uint32_t bandwidth_up;
+	uint32_t throughput;
+	uint8_t *router;
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
+	if (ghdr->cmd != BATADV_CMD_GET_GATEWAYS)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, gateways_mandatory,
+				    ARRAY_SIZE(gateways_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	if (attrs[BATADV_ATTR_FLAG_BEST])
+		c = '*';
+
+	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
+	router = nla_data(attrs[BATADV_ATTR_ROUTER]);
+	primary_if = nla_get_string(attrs[BATADV_ATTR_HARD_IFNAME]);
+	bandwidth_down = nla_get_u32(attrs[BATADV_ATTR_BANDWIDTH_DOWN]);
+	bandwidth_up = nla_get_u32(attrs[BATADV_ATTR_BANDWIDTH_UP]);
+
+	printf("%c ", c);
+
+	bat_host = bat_hosts_find_by_mac((char *)orig);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       orig[0], orig[1], orig[2],
+		       orig[3], orig[4], orig[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	if (attrs[BATADV_ATTR_THROUGHPUT]) {
+		throughput = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);
+		printf("(%9u.%1u) ", throughput / 10, throughput % 10);
+	} else if (attrs[BATADV_ATTR_TQ]) {
+		tq = nla_get_u8(attrs[BATADV_ATTR_TQ]);
+		printf("(%3i) ", tq);
+	}
+
+	bat_host = bat_hosts_find_by_mac((char *)router);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       router[0], router[1], router[2],
+		       router[3], router[4], router[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("[%10s]: %u.%u/%u.%u MBit\n",
+	       primary_if, bandwidth_down / 10, bandwidth_down % 10,
+	       bandwidth_up / 10, bandwidth_up % 10);
+
+	return NL_OK;
+}
+
+static int netlink_print_gateways(char *mesh_iface, char *orig_iface,
+				  int read_opts, float orig_timeout,
+				  float watch_interval)
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
+		header = "  Router            ( TQ) Next Hop          [outgoingIf]  Bandwidth\n";
+	if (!strcmp("BATMAN_V", algo_name_buf))
+		header = "  Router            ( throughput) Next Hop          [outgoingIf]  Bandwidth\n";
+
+	if (!header)
+		return -EINVAL;
+
+	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+				    orig_timeout, watch_interval,
+				    header,
+				    BATADV_CMD_GET_GATEWAYS,
+				    gateways_callback);
+}
+
+static struct debug_table_data batctl_debug_table_gateways = {
+	.debugfs_name = "gateways",
+	.header_lines = 1,
+	.netlink_fn = netlink_print_gateways,
+};
+
+COMMAND_NAMED(DEBUGTABLE, gateways, "gwl", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_gateways, "");
diff --git a/netlink.c b/netlink.c
index 42fe4a0..c3b2bad 100644
--- a/netlink.c
+++ b/netlink.c
@@ -109,8 +109,8 @@ struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_MCAST_FLAGS_PRIV]		= { .type = NLA_U32 },
 };
 
-static int last_err;
-static char algo_name_buf[256] = "";
+int last_err;
+char algo_name_buf[256] = "";
 static int64_t mcast_flags = -EOPNOTSUPP;
 static int64_t mcast_flags_priv = -EOPNOTSUPP;
 
@@ -283,7 +283,7 @@ static int info_callback(struct nl_msg *msg, void *arg)
 	return NL_STOP;
 }
 
-static char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
+char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
 {
 	struct nl_sock *sock;
 	struct nl_msg *msg;
@@ -876,94 +876,6 @@ static int translocal_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static const int gateways_mandatory[] = {
-	BATADV_ATTR_ORIG_ADDRESS,
-	BATADV_ATTR_ROUTER,
-	BATADV_ATTR_HARD_IFNAME,
-	BATADV_ATTR_BANDWIDTH_DOWN,
-	BATADV_ATTR_BANDWIDTH_UP,
-};
-
-static int gateways_callback(struct nl_msg *msg, void *arg)
-{
-	struct nlattr *attrs[BATADV_ATTR_MAX+1];
-	struct nlmsghdr *nlh = nlmsg_hdr(msg);
-	struct print_opts *opts = arg;
-	struct bat_host *bat_host;
-	struct genlmsghdr *ghdr;
-	const char *primary_if;
-	uint32_t bandwidth_down;
-	uint32_t bandwidth_up;
-	uint32_t throughput;
-	uint8_t *router;
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
-	if (ghdr->cmd != BATADV_CMD_GET_GATEWAYS)
-		return NL_OK;
-
-	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), batadv_netlink_policy)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	if (missing_mandatory_attrs(attrs, gateways_mandatory,
-				    ARRAY_SIZE(gateways_mandatory))) {
-		fputs("Missing attributes from kernel\n", stderr);
-		exit(1);
-	}
-
-	if (attrs[BATADV_ATTR_FLAG_BEST])
-		c = '*';
-
-	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
-	router = nla_data(attrs[BATADV_ATTR_ROUTER]);
-	primary_if = nla_get_string(attrs[BATADV_ATTR_HARD_IFNAME]);
-	bandwidth_down = nla_get_u32(attrs[BATADV_ATTR_BANDWIDTH_DOWN]);
-	bandwidth_up = nla_get_u32(attrs[BATADV_ATTR_BANDWIDTH_UP]);
-
-	printf("%c ", c);
-
-	bat_host = bat_hosts_find_by_mac((char *)orig);
-	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
-		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
-		       orig[0], orig[1], orig[2],
-		       orig[3], orig[4], orig[5]);
-	else
-		printf("%17s ", bat_host->name);
-
-	if (attrs[BATADV_ATTR_THROUGHPUT]) {
-		throughput = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);
-		printf("(%9u.%1u) ", throughput / 10, throughput % 10);
-	} else if (attrs[BATADV_ATTR_TQ]) {
-		tq = nla_get_u8(attrs[BATADV_ATTR_TQ]);
-		printf("(%3i) ", tq);
-	}
-
-	bat_host = bat_hosts_find_by_mac((char *)router);
-	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
-		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
-		       router[0], router[1], router[2],
-		       router[3], router[4], router[5]);
-	else
-		printf("%17s ", bat_host->name);
-
-	printf("[%10s]: %u.%u/%u.%u MBit\n",
-	       primary_if, bandwidth_down / 10, bandwidth_down % 10,
-	       bandwidth_up / 10, bandwidth_up % 10);
-
-	return NL_OK;
-}
-
 static const int mcast_flags_mandatory[] = {
 	BATADV_ATTR_ORIG_ADDRESS,
 };
@@ -1205,42 +1117,6 @@ int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opts,
 				    translocal_callback);
 }
 
-int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opts,
-			   float orig_timeout,
-			   float watch_interval)
-{	char *header = NULL;
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
-		header = "  Router            ( TQ) Next Hop          [outgoingIf]  Bandwidth\n";
-	if (!strcmp("BATMAN_V", algo_name_buf))
-		header = "  Router            ( throughput) Next Hop          [outgoingIf]  Bandwidth\n";
-
-	if (!header)
-		return -EINVAL;
-
-	return netlink_print_common(mesh_iface, orig_iface, read_opts,
-				    orig_timeout, watch_interval,
-				    header,
-				    BATADV_CMD_GET_GATEWAYS,
-				    gateways_callback);
-}
-
 int netlink_print_mcast_flags(char *mesh_iface, char *orig_iface, int read_opts,
 			      float orig_timeout, float watch_interval)
 {
diff --git a/netlink.h b/netlink.h
index 7549838..ecf4b01 100644
--- a/netlink.h
+++ b/netlink.h
@@ -43,17 +43,14 @@ int netlink_print_originators(char *mesh_iface, char *orig_iface, int read_opt,
 			      float orig_timeout, float watch_interval);
 int netlink_print_neighbors(char *mesh_iface, char *orig_iface, int read_opt,
 			    float orig_timeout, float watch_interval);
-int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opt,
-			   float orig_timeout, float watch_interval);
 int netlink_print_transglobal(char *mesh_iface, char *orig_iface, int read_opt,
 			      float orig_timeout, float watch_interval);
 int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opt,
 			     float orig_timeout, float watch_interval);
-int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opt,
-			   float orig_timeout, float watch_interval);
 int netlink_print_mcast_flags(char *mesh_iface, char *orig_iface, int read_opt,
 			      float orig_timeout, float watch_interval);
 
+char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header);
 int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
 			  struct ether_addr *mac_out);
 int get_nexthop_netlink(const char *mesh_iface, const struct ether_addr *mac,
@@ -69,4 +66,7 @@ int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
 			 const char *header, uint8_t nl_cmd,
 			 nl_recvmsg_msg_cb_t callback);
 
+extern char algo_name_buf[256];
+extern int last_err;
+
 #endif /* _BATCTL_NETLINK_H */
-- 
2.19.1

