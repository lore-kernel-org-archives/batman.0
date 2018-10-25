Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:30 +0200
Message-Id: <20181025162245.19389-28-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 27/42] batctl: Move translocal debug table
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
 Makefile     |   1 +
 debug.c      |  11 -----
 netlink.c    | 108 ----------------------------------------
 netlink.h    |   2 -
 translocal.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 158 insertions(+), 121 deletions(-)
 create mode 100644 translocal.c

diff --git a/Makefile b/Makefile
index ef0c28b..93db44a 100755
--- a/Makefile
+++ b/Makefile
@@ -62,6 +62,7 @@ OBJ += throughputmeter.o
 OBJ += traceroute.o
 OBJ += transglobal.o
 OBJ += translate.o
+OBJ += translocal.o
 
 MANPAGE = man/batctl.8
 
diff --git a/debug.c b/debug.c
index 5f2ad04..17dde92 100644
--- a/debug.c
+++ b/debug.c
@@ -199,14 +199,3 @@ int debug_print_routing_algos(void)
 	debugfs_make_path(DEBUG_BATIF_PATH_FMT, "", full_path, sizeof(full_path));
 	return read_file(full_path, DEBUG_ROUTING_ALGOS, 0, 0, 0, 0);
 }
-
-static struct debug_table_data batctl_debug_table_translocal = {
-	.debugfs_name = "transtable_local",
-	.header_lines = 2,
-	.netlink_fn = netlink_print_translocal,
-	.option_unicast_only = 1,
-	.option_multicast_only = 1,
-};
-
-COMMAND_NAMED(DEBUGTABLE, translocal, "tl", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_translocal, "");
diff --git a/netlink.c b/netlink.c
index 6583696..26ae27d 100644
--- a/netlink.c
+++ b/netlink.c
@@ -456,103 +456,6 @@ int netlink_print_routing_algos(void)
 	return last_err;
 }
 
-static const int translocal_mandatory[] = {
-	BATADV_ATTR_TT_ADDRESS,
-	BATADV_ATTR_TT_VID,
-	BATADV_ATTR_TT_CRC32,
-	BATADV_ATTR_TT_FLAGS,
-};
-
-static int translocal_callback(struct nl_msg *msg, void *arg)
-{
-	int last_seen_msecs = 0, last_seen_secs = 0;
-	struct nlattr *attrs[BATADV_ATTR_MAX+1];
-	struct nlmsghdr *nlh = nlmsg_hdr(msg);
-	struct print_opts *opts = arg;
-	struct bat_host *bat_host;
-	struct genlmsghdr *ghdr;
-	char r, p, n, x, w, i;
-	uint8_t *addr;
-	int16_t vid;
-	uint32_t crc32;
-	uint32_t flags;
-
-	if (!genlmsg_valid_hdr(nlh, 0)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	ghdr = nlmsg_data(nlh);
-
-	if (ghdr->cmd != BATADV_CMD_GET_TRANSTABLE_LOCAL)
-		return NL_OK;
-
-	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), batadv_netlink_policy)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	if (missing_mandatory_attrs(attrs, translocal_mandatory,
-				    ARRAY_SIZE(translocal_mandatory))) {
-		fputs("Missing attributes from kernel\n", stderr);
-		exit(1);
-	}
-
-	addr = nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
-	vid = nla_get_u16(attrs[BATADV_ATTR_TT_VID]);
-	crc32 = nla_get_u32(attrs[BATADV_ATTR_TT_CRC32]);
-	flags = nla_get_u32(attrs[BATADV_ATTR_TT_FLAGS]);
-	last_seen_msecs = 0, last_seen_secs = 0;
-
-	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
-		return NL_OK;
-
-	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
-		return NL_OK;
-
-	r = '.', p = '.', n = '.', x = '.', w = '.', i = '.';
-	if (flags & BATADV_TT_CLIENT_ROAM)
-		r = 'R';
-	if (flags & BATADV_TT_CLIENT_NEW)
-		n = 'N';
-	if (flags & BATADV_TT_CLIENT_PENDING)
-		x = 'X';
-	if (flags & BATADV_TT_CLIENT_WIFI)
-		w = 'W';
-	if (flags & BATADV_TT_CLIENT_ISOLA)
-		i = 'I';
-
-	if (flags & BATADV_TT_CLIENT_NOPURGE)  {
-		p = 'P';
-	} else {
-		if (!attrs[BATADV_ATTR_LAST_SEEN_MSECS]) {
-			fputs("Received invalid data from kernel.\n", stderr);
-			exit(1);
-		}
-
-		last_seen_msecs = nla_get_u32(
-			attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
-		last_seen_secs = last_seen_msecs / 1000;
-		last_seen_msecs = last_seen_msecs % 1000;
-	}
-
-	bat_host = bat_hosts_find_by_mac((char *)addr);
-	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
-		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
-		       addr[0], addr[1], addr[2],
-		       addr[3], addr[4], addr[5]);
-	else
-		printf("%17s ", bat_host->name);
-
-	printf("%4i [%c%c%c%c%c%c] %3u.%03u   (0x%.8x)\n",
-	       BATADV_PRINT_VID(vid), r, p, n, x, w, i,
-	       last_seen_secs, last_seen_msecs,
-	       crc32);
-
-	return NL_OK;
-}
-
 int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
 			 float orig_timeout, float watch_interval,
 			 const char *header, uint8_t nl_cmd,
@@ -659,17 +562,6 @@ int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
 	return last_err;
 }
 
-int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opts,
-			     float orig_timeout,
-			     float watch_interval)
-{
-	return netlink_print_common(mesh_iface, orig_iface, read_opts,
-				    orig_timeout, watch_interval,
-				    "Client             VID Flags    Last seen (CRC       )\n",
-				    BATADV_CMD_GET_TRANSTABLE_LOCAL,
-				    translocal_callback);
-}
-
 static int nlquery_error_cb(struct sockaddr_nl *nla __maybe_unused,
 			    struct nlmsgerr *nlerr, void *arg)
 {
diff --git a/netlink.h b/netlink.h
index 1cec0f7..0b21ac1 100644
--- a/netlink.h
+++ b/netlink.h
@@ -40,8 +40,6 @@ struct print_opts {
 struct ether_addr;
 
 int netlink_print_routing_algos(void);
-int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opt,
-			     float orig_timeout, float watch_interval);
 
 char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header);
 int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
diff --git a/translocal.c b/translocal.c
new file mode 100644
index 0000000..815dc1e
--- /dev/null
+++ b/translocal.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ * Sven Eckelmann <sven@narfation.org>
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
+#include <netinet/if_ether.h>
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
+static const int translocal_mandatory[] = {
+	BATADV_ATTR_TT_ADDRESS,
+	BATADV_ATTR_TT_VID,
+	BATADV_ATTR_TT_CRC32,
+	BATADV_ATTR_TT_FLAGS,
+};
+
+static int translocal_callback(struct nl_msg *msg, void *arg)
+{
+	int last_seen_msecs = 0, last_seen_secs = 0;
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	char r, p, n, x, w, i;
+	uint8_t *addr;
+	int16_t vid;
+	uint32_t crc32;
+	uint32_t flags;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_TRANSTABLE_LOCAL)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, translocal_mandatory,
+				    ARRAY_SIZE(translocal_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	addr = nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
+	vid = nla_get_u16(attrs[BATADV_ATTR_TT_VID]);
+	crc32 = nla_get_u32(attrs[BATADV_ATTR_TT_CRC32]);
+	flags = nla_get_u32(attrs[BATADV_ATTR_TT_FLAGS]);
+	last_seen_msecs = 0, last_seen_secs = 0;
+
+	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
+		return NL_OK;
+
+	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
+		return NL_OK;
+
+	r = '.', p = '.', n = '.', x = '.', w = '.', i = '.';
+	if (flags & BATADV_TT_CLIENT_ROAM)
+		r = 'R';
+	if (flags & BATADV_TT_CLIENT_NEW)
+		n = 'N';
+	if (flags & BATADV_TT_CLIENT_PENDING)
+		x = 'X';
+	if (flags & BATADV_TT_CLIENT_WIFI)
+		w = 'W';
+	if (flags & BATADV_TT_CLIENT_ISOLA)
+		i = 'I';
+
+	if (flags & BATADV_TT_CLIENT_NOPURGE)  {
+		p = 'P';
+	} else {
+		if (!attrs[BATADV_ATTR_LAST_SEEN_MSECS]) {
+			fputs("Received invalid data from kernel.\n", stderr);
+			exit(1);
+		}
+
+		last_seen_msecs = nla_get_u32(
+			attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+		last_seen_secs = last_seen_msecs / 1000;
+		last_seen_msecs = last_seen_msecs % 1000;
+	}
+
+	bat_host = bat_hosts_find_by_mac((char *)addr);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       addr[0], addr[1], addr[2],
+		       addr[3], addr[4], addr[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("%4i [%c%c%c%c%c%c] %3u.%03u   (0x%.8x)\n",
+	       BATADV_PRINT_VID(vid), r, p, n, x, w, i,
+	       last_seen_secs, last_seen_msecs,
+	       crc32);
+
+	return NL_OK;
+}
+
+static int netlink_print_translocal(char *mesh_iface, char *orig_iface,
+				    int read_opts, float orig_timeout,
+				    float watch_interval)
+{
+	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+				    orig_timeout, watch_interval,
+				    "Client             VID Flags    Last seen (CRC       )\n",
+				    BATADV_CMD_GET_TRANSTABLE_LOCAL,
+				    translocal_callback);
+}
+
+static struct debug_table_data batctl_debug_table_translocal = {
+	.debugfs_name = "transtable_local",
+	.header_lines = 2,
+	.netlink_fn = netlink_print_translocal,
+	.option_unicast_only = 1,
+	.option_multicast_only = 1,
+};
+
+COMMAND_NAMED(DEBUGTABLE, translocal, "tl", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_translocal, "");
-- 
2.11.0

