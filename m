Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:25 +0200
Message-Id: <20181025162245.19389-23-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v3 22/42] batctl: Move mcast_flags debug
 table to own file
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
 debug.c       |   9 ---
 gateways.c    |   3 +-
 mcast_flags.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.c     | 133 +------------------------------------------
 netlink.h     |   5 +-
 6 files changed, 186 insertions(+), 144 deletions(-)
 create mode 100644 mcast_flags.c

diff --git a/Makefile b/Makefile
index 3a8e785..a725986 100755
--- a/Makefile
+++ b/Makefile
@@ -48,6 +48,7 @@ OBJ += interface.o
 OBJ += loglevel.o
 OBJ += log.o
 OBJ += main.o
+OBJ += mcast_flags.o
 OBJ += netlink.o
 OBJ += ping.o
 OBJ += routing_algo.o
diff --git a/debug.c b/debug.c
index 7bf8bff..4b480a3 100644
--- a/debug.c
+++ b/debug.c
@@ -249,12 +249,3 @@ static struct debug_table_data batctl_debug_table_nc_nodes = {
 
 COMMAND_NAMED(DEBUGTABLE, nc_nodes, "nn", handle_debug_table,
 	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_nc_nodes, "");
-
-static struct debug_table_data batctl_debug_table_mcast_flags = {
-	.debugfs_name = DEBUG_MCAST_FLAGS,
-	.header_lines = 6,
-	.netlink_fn = netlink_print_mcast_flags,
-};
-
-COMMAND_NAMED(DEBUGTABLE, mcast_flags, "mf", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_mcast_flags, "");
diff --git a/gateways.c b/gateways.c
index f81bf20..ca5d6ec 100644
--- a/gateways.c
+++ b/gateways.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
  *
- * Andrew Lunn <andrew@lunn.ch>
- * Sven Eckelmann <sven@narfation.org>
+ * Linus Lüssing <linus.luessing@c0d3.blue>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of version 2 of the GNU General Public
diff --git a/mcast_flags.c b/mcast_flags.c
new file mode 100644
index 0000000..e35cce3
--- /dev/null
+++ b/mcast_flags.c
@@ -0,0 +1,179 @@
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
+#include <netinet/if_ether.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <stdbool.h>
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
+static const int mcast_flags_mandatory[] = {
+	BATADV_ATTR_ORIG_ADDRESS,
+};
+
+static int mcast_flags_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	uint32_t flags;
+	uint8_t *addr;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_MCAST_FLAGS)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, mcast_flags_mandatory,
+				    ARRAY_SIZE(mcast_flags_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	addr = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
+
+	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
+		return NL_OK;
+
+	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
+		return NL_OK;
+
+	bat_host = bat_hosts_find_by_mac((char *)addr);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       addr[0], addr[1], addr[2],
+		       addr[3], addr[4], addr[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	if (attrs[BATADV_ATTR_MCAST_FLAGS]) {
+		flags = nla_get_u32(attrs[BATADV_ATTR_MCAST_FLAGS]);
+
+		printf("[%c%c%c]\n",
+		       flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
+		       flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
+		       flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
+	} else {
+		printf("-\n");
+	}
+
+	return NL_OK;
+}
+
+static int netlink_print_mcast_flags(char *mesh_iface, char *orig_iface,
+				     int read_opts, float orig_timeout,
+				     float watch_interval)
+{
+	char querier4, querier6, shadowing4, shadowing6;
+	char *info_header;
+	char *header;
+	bool bridged;
+	int ifindex;
+	int ret;
+
+	ifindex = if_nametoindex(mesh_iface);
+	if (!ifindex) {
+		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
+		return -ENODEV;
+	}
+
+	/* only parse own multicast flags */
+	info_header = netlink_get_info(ifindex, BATADV_CMD_GET_MCAST_FLAGS, NULL);
+	free(info_header);
+
+	if (mcast_flags == -EOPNOTSUPP || mcast_flags_priv == -EOPNOTSUPP)
+		return -EOPNOTSUPP;
+
+	bridged = mcast_flags_priv & BATADV_MCAST_FLAGS_BRIDGED;
+
+	if (bridged) {
+                querier4 = (mcast_flags_priv & BATADV_MCAST_FLAGS_QUERIER_IPV4_EXISTS) ? '.' : '4';
+                querier6 = (mcast_flags_priv & BATADV_MCAST_FLAGS_QUERIER_IPV6_EXISTS) ? '.' : '6';
+                shadowing4 = (mcast_flags_priv & BATADV_MCAST_FLAGS_QUERIER_IPV4_SHADOWING) ? '4' : '.';
+                shadowing6 = (mcast_flags_priv & BATADV_MCAST_FLAGS_QUERIER_IPV6_SHADOWING) ? '6' : '.';
+        } else {
+                querier4 = '?';
+                querier6 = '?';
+                shadowing4 = '?';
+                shadowing6 = '?';
+        }
+
+	ret = asprintf(&header,
+		"Multicast flags (own flags: [%c%c%c])\n"
+		 "* Bridged [U]\t\t\t\t%c\n"
+		 "* No IGMP/MLD Querier [4/6]:\t\t%c/%c\n"
+		 "* Shadowing IGMP/MLD Querier [4/6]:\t%c/%c\n"
+		 "-------------------------------------------\n"
+		 "       %-10s %s\n",
+		 (mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES) ? 'U' : '.',
+		 (mcast_flags & BATADV_MCAST_WANT_ALL_IPV4) ? '4' : '.',
+		 (mcast_flags & BATADV_MCAST_WANT_ALL_IPV6) ? '6' : '.',
+		 bridged ? 'U' : '.',
+		 querier4, querier6, shadowing4, shadowing6,
+		 "Originator", "Flags");
+
+	if (ret < 0)
+		return ret;
+
+	ret = netlink_print_common(mesh_iface, orig_iface, read_opts,
+				   orig_timeout, watch_interval, header,
+				   BATADV_CMD_GET_MCAST_FLAGS,
+				   mcast_flags_callback);
+
+	free(header);
+	return ret;
+}
+
+static struct debug_table_data batctl_debug_table_mcast_flags = {
+	.debugfs_name = DEBUG_MCAST_FLAGS,
+	.header_lines = 6,
+	.netlink_fn = netlink_print_mcast_flags,
+};
+
+COMMAND_NAMED(DEBUGTABLE, mcast_flags, "mf", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_mcast_flags, "");
diff --git a/netlink.c b/netlink.c
index c3b2bad..4f2199e 100644
--- a/netlink.c
+++ b/netlink.c
@@ -111,8 +111,8 @@ struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 
 int last_err;
 char algo_name_buf[256] = "";
-static int64_t mcast_flags = -EOPNOTSUPP;
-static int64_t mcast_flags_priv = -EOPNOTSUPP;
+int64_t mcast_flags = -EOPNOTSUPP;
+int64_t mcast_flags_priv = -EOPNOTSUPP;
 
 int missing_mandatory_attrs(struct nlattr *attrs[], const int mandatory[],
 			    int num)
@@ -876,72 +876,6 @@ static int translocal_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static const int mcast_flags_mandatory[] = {
-	BATADV_ATTR_ORIG_ADDRESS,
-};
-
-static int mcast_flags_callback(struct nl_msg *msg, void *arg)
-{
-	struct nlattr *attrs[BATADV_ATTR_MAX+1];
-	struct nlmsghdr *nlh = nlmsg_hdr(msg);
-	struct print_opts *opts = arg;
-	struct bat_host *bat_host;
-	struct genlmsghdr *ghdr;
-	uint32_t flags;
-	uint8_t *addr;
-
-	if (!genlmsg_valid_hdr(nlh, 0)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	ghdr = nlmsg_data(nlh);
-
-	if (ghdr->cmd != BATADV_CMD_GET_MCAST_FLAGS)
-		return NL_OK;
-
-	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), batadv_netlink_policy)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	if (missing_mandatory_attrs(attrs, mcast_flags_mandatory,
-				    ARRAY_SIZE(mcast_flags_mandatory))) {
-		fputs("Missing attributes from kernel\n", stderr);
-		exit(1);
-	}
-
-	addr = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
-
-	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
-		return NL_OK;
-
-	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
-		return NL_OK;
-
-	bat_host = bat_hosts_find_by_mac((char *)addr);
-	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
-		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
-		       addr[0], addr[1], addr[2],
-		       addr[3], addr[4], addr[5]);
-	else
-		printf("%17s ", bat_host->name);
-
-	if (attrs[BATADV_ATTR_MCAST_FLAGS]) {
-		flags = nla_get_u32(attrs[BATADV_ATTR_MCAST_FLAGS]);
-
-		printf("[%c%c%c]\n",
-		       flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.',
-		       flags & BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.',
-		       flags & BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.');
-	} else {
-		printf("-\n");
-	}
-
-	return NL_OK;
-}
-
 int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
 			 float orig_timeout, float watch_interval,
 			 const char *header, uint8_t nl_cmd,
@@ -1117,69 +1051,6 @@ int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opts,
 				    translocal_callback);
 }
 
-int netlink_print_mcast_flags(char *mesh_iface, char *orig_iface, int read_opts,
-			      float orig_timeout, float watch_interval)
-{
-	char querier4, querier6, shadowing4, shadowing6;
-	char *info_header;
-	char *header;
-	bool bridged;
-	int ifindex;
-	int ret;
-
-	ifindex = if_nametoindex(mesh_iface);
-	if (!ifindex) {
-		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
-		return -ENODEV;
-	}
-
-	/* only parse own multicast flags */
-	info_header = netlink_get_info(ifindex, BATADV_CMD_GET_MCAST_FLAGS, NULL);
-	free(info_header);
-
-	if (mcast_flags == -EOPNOTSUPP || mcast_flags_priv == -EOPNOTSUPP)
-		return -EOPNOTSUPP;
-
-	bridged = mcast_flags_priv & BATADV_MCAST_FLAGS_BRIDGED;
-
-	if (bridged) {
-                querier4 = (mcast_flags_priv & BATADV_MCAST_FLAGS_QUERIER_IPV4_EXISTS) ? '.' : '4';
-                querier6 = (mcast_flags_priv & BATADV_MCAST_FLAGS_QUERIER_IPV6_EXISTS) ? '.' : '6';
-                shadowing4 = (mcast_flags_priv & BATADV_MCAST_FLAGS_QUERIER_IPV4_SHADOWING) ? '4' : '.';
-                shadowing6 = (mcast_flags_priv & BATADV_MCAST_FLAGS_QUERIER_IPV6_SHADOWING) ? '6' : '.';
-        } else {
-                querier4 = '?';
-                querier6 = '?';
-                shadowing4 = '?';
-                shadowing6 = '?';
-        }
-
-	ret = asprintf(&header,
-		"Multicast flags (own flags: [%c%c%c])\n"
-		 "* Bridged [U]\t\t\t\t%c\n"
-		 "* No IGMP/MLD Querier [4/6]:\t\t%c/%c\n"
-		 "* Shadowing IGMP/MLD Querier [4/6]:\t%c/%c\n"
-		 "-------------------------------------------\n"
-		 "       %-10s %s\n",
-		 (mcast_flags & BATADV_MCAST_WANT_ALL_UNSNOOPABLES) ? 'U' : '.',
-		 (mcast_flags & BATADV_MCAST_WANT_ALL_IPV4) ? '4' : '.',
-		 (mcast_flags & BATADV_MCAST_WANT_ALL_IPV6) ? '6' : '.',
-		 bridged ? 'U' : '.',
-		 querier4, querier6, shadowing4, shadowing6,
-		 "Originator", "Flags");
-
-	if (ret < 0)
-		return ret;
-
-	ret = netlink_print_common(mesh_iface, orig_iface, read_opts,
-				   orig_timeout, watch_interval, header,
-				   BATADV_CMD_GET_MCAST_FLAGS,
-				   mcast_flags_callback);
-
-	free(header);
-	return ret;
-}
-
 static int nlquery_error_cb(struct sockaddr_nl *nla __maybe_unused,
 			    struct nlmsgerr *nlerr, void *arg)
 {
diff --git a/netlink.h b/netlink.h
index ecf4b01..e0fa466 100644
--- a/netlink.h
+++ b/netlink.h
@@ -25,6 +25,7 @@
 
 #include <netlink/genl/genl.h>
 #include <netlink/genl/ctrl.h>
+#include <stdint.h>
 
 struct print_opts {
 	int read_opt;
@@ -47,8 +48,6 @@ int netlink_print_transglobal(char *mesh_iface, char *orig_iface, int read_opt,
 			      float orig_timeout, float watch_interval);
 int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opt,
 			     float orig_timeout, float watch_interval);
-int netlink_print_mcast_flags(char *mesh_iface, char *orig_iface, int read_opt,
-			      float orig_timeout, float watch_interval);
 
 char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header);
 int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
@@ -68,5 +67,7 @@ int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
 
 extern char algo_name_buf[256];
 extern int last_err;
+extern int64_t mcast_flags;
+extern int64_t mcast_flags_priv;
 
 #endif /* _BATCTL_NETLINK_H */
-- 
2.11.0

