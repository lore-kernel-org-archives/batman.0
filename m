Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:29 +0200
Message-Id: <20181025162245.19389-27-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 26/42] batctl: Move transglobal debug
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
 debug.c       |  11 ----
 netlink.c     | 112 ----------------------------------------
 netlink.h     |   2 -
 transglobal.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 162 insertions(+), 125 deletions(-)
 create mode 100644 transglobal.c

diff --git a/Makefile b/Makefile
index 059c602..ef0c28b 100755
--- a/Makefile
+++ b/Makefile
@@ -60,6 +60,7 @@ OBJ += sys.o
 OBJ += tcpdump.o
 OBJ += throughputmeter.o
 OBJ += traceroute.o
+OBJ += transglobal.o
 OBJ += translate.o
 
 MANPAGE = man/batctl.8
diff --git a/debug.c b/debug.c
index f4cc2ea..5f2ad04 100644
--- a/debug.c
+++ b/debug.c
@@ -210,14 +210,3 @@ static struct debug_table_data batctl_debug_table_translocal = {
 
 COMMAND_NAMED(DEBUGTABLE, translocal, "tl", handle_debug_table,
 	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_translocal, "");
-
-static struct debug_table_data batctl_debug_table_transglobal = {
-	.debugfs_name = "transtable_global",
-	.header_lines = 2,
-	.netlink_fn = netlink_print_transglobal,
-	.option_unicast_only = 1,
-	.option_multicast_only = 1,
-};
-
-COMMAND_NAMED(DEBUGTABLE, transglobal, "tg", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_transglobal, "");
diff --git a/netlink.c b/netlink.c
index cbb73ac..6583696 100644
--- a/netlink.c
+++ b/netlink.c
@@ -456,107 +456,6 @@ int netlink_print_routing_algos(void)
 	return last_err;
 }
 
-static const int transglobal_mandatory[] = {
-	BATADV_ATTR_TT_ADDRESS,
-	BATADV_ATTR_ORIG_ADDRESS,
-	BATADV_ATTR_TT_VID,
-	BATADV_ATTR_TT_TTVN,
-	BATADV_ATTR_TT_LAST_TTVN,
-	BATADV_ATTR_TT_CRC32,
-	BATADV_ATTR_TT_FLAGS,
-};
-
-static int transglobal_callback(struct nl_msg *msg, void *arg)
-{
-	struct nlattr *attrs[BATADV_ATTR_MAX+1];
-	struct nlmsghdr *nlh = nlmsg_hdr(msg);
-	struct print_opts *opts = arg;
-	struct bat_host *bat_host;
-	struct genlmsghdr *ghdr;
-	char c, r, w, i, t;
-	uint8_t last_ttvn;
-	uint32_t crc32;
-	uint32_t flags;
-	uint8_t *addr;
-	uint8_t *orig;
-	uint8_t ttvn;
-	int16_t vid;
-
-	if (!genlmsg_valid_hdr(nlh, 0)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	ghdr = nlmsg_data(nlh);
-
-	if (ghdr->cmd != BATADV_CMD_GET_TRANSTABLE_GLOBAL)
-		return NL_OK;
-
-	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), batadv_netlink_policy)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	if (missing_mandatory_attrs(attrs, transglobal_mandatory,
-				    ARRAY_SIZE(transglobal_mandatory))) {
-		fputs("Missing attributes from kernel\n", stderr);
-		exit(1);
-	}
-
-	addr = nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
-	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
-	vid = nla_get_u16(attrs[BATADV_ATTR_TT_VID]);
-	ttvn = nla_get_u8(attrs[BATADV_ATTR_TT_TTVN]);
-	last_ttvn = nla_get_u8(attrs[BATADV_ATTR_TT_LAST_TTVN]);
-	crc32 = nla_get_u32(attrs[BATADV_ATTR_TT_CRC32]);
-	flags = nla_get_u32(attrs[BATADV_ATTR_TT_FLAGS]);
-
-	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
-		return NL_OK;
-
-	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
-		return NL_OK;
-
-	c = ' ', r = '.', w = '.', i = '.', t = '.';
-	if (attrs[BATADV_ATTR_FLAG_BEST])
-		c = '*';
-	if (flags & BATADV_TT_CLIENT_ROAM)
-		r = 'R';
-	if (flags & BATADV_TT_CLIENT_WIFI)
-		w = 'W';
-	if (flags & BATADV_TT_CLIENT_ISOLA)
-		i = 'I';
-	if (flags & BATADV_TT_CLIENT_TEMP)
-		t = 'T';
-
-	printf(" %c ", c);
-
-	bat_host = bat_hosts_find_by_mac((char *)addr);
-	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
-		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
-		       addr[0], addr[1], addr[2],
-		       addr[3], addr[4], addr[5]);
-	else
-		printf("%17s ", bat_host->name);
-
-	printf("%4i [%c%c%c%c] (%3u) ",
-	       BATADV_PRINT_VID(vid), r, w, i, t, ttvn);
-
-	bat_host = bat_hosts_find_by_mac((char *)orig);
-	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
-		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
-		       orig[0], orig[1], orig[2],
-		       orig[3], orig[4], orig[5]);
-	else
-		printf("%17s ", bat_host->name);
-
-	printf("(%3u) (0x%.8x)\n",
-	       last_ttvn, crc32);
-
-	return NL_OK;
-}
-
 static const int translocal_mandatory[] = {
 	BATADV_ATTR_TT_ADDRESS,
 	BATADV_ATTR_TT_VID,
@@ -760,17 +659,6 @@ int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
 	return last_err;
 }
 
-int netlink_print_transglobal(char *mesh_iface, char *orig_iface,
-			      int read_opts, float orig_timeout,
-			      float watch_interval)
-{
-	return netlink_print_common(mesh_iface, orig_iface, read_opts,
-				    orig_timeout, watch_interval,
-				    "   Client             VID Flags Last ttvn     Via        ttvn  (CRC       )\n",
-				    BATADV_CMD_GET_TRANSTABLE_GLOBAL,
-				    transglobal_callback);
-}
-
 int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opts,
 			     float orig_timeout,
 			     float watch_interval)
diff --git a/netlink.h b/netlink.h
index a099482..1cec0f7 100644
--- a/netlink.h
+++ b/netlink.h
@@ -40,8 +40,6 @@ struct print_opts {
 struct ether_addr;
 
 int netlink_print_routing_algos(void);
-int netlink_print_transglobal(char *mesh_iface, char *orig_iface, int read_opt,
-			      float orig_timeout, float watch_interval);
 int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opt,
 			     float orig_timeout, float watch_interval);
 
diff --git a/transglobal.c b/transglobal.c
new file mode 100644
index 0000000..f61aa9f
--- /dev/null
+++ b/transglobal.c
@@ -0,0 +1,161 @@
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
+static const int transglobal_mandatory[] = {
+	BATADV_ATTR_TT_ADDRESS,
+	BATADV_ATTR_ORIG_ADDRESS,
+	BATADV_ATTR_TT_VID,
+	BATADV_ATTR_TT_TTVN,
+	BATADV_ATTR_TT_LAST_TTVN,
+	BATADV_ATTR_TT_CRC32,
+	BATADV_ATTR_TT_FLAGS,
+};
+
+static int transglobal_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	char c, r, w, i, t;
+	uint8_t last_ttvn;
+	uint32_t crc32;
+	uint32_t flags;
+	uint8_t *addr;
+	uint8_t *orig;
+	uint8_t ttvn;
+	int16_t vid;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_TRANSTABLE_GLOBAL)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, transglobal_mandatory,
+				    ARRAY_SIZE(transglobal_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	addr = nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
+	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
+	vid = nla_get_u16(attrs[BATADV_ATTR_TT_VID]);
+	ttvn = nla_get_u8(attrs[BATADV_ATTR_TT_TTVN]);
+	last_ttvn = nla_get_u8(attrs[BATADV_ATTR_TT_LAST_TTVN]);
+	crc32 = nla_get_u32(attrs[BATADV_ATTR_TT_CRC32]);
+	flags = nla_get_u32(attrs[BATADV_ATTR_TT_FLAGS]);
+
+	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
+		return NL_OK;
+
+	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
+		return NL_OK;
+
+	c = ' ', r = '.', w = '.', i = '.', t = '.';
+	if (attrs[BATADV_ATTR_FLAG_BEST])
+		c = '*';
+	if (flags & BATADV_TT_CLIENT_ROAM)
+		r = 'R';
+	if (flags & BATADV_TT_CLIENT_WIFI)
+		w = 'W';
+	if (flags & BATADV_TT_CLIENT_ISOLA)
+		i = 'I';
+	if (flags & BATADV_TT_CLIENT_TEMP)
+		t = 'T';
+
+	printf(" %c ", c);
+
+	bat_host = bat_hosts_find_by_mac((char *)addr);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       addr[0], addr[1], addr[2],
+		       addr[3], addr[4], addr[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("%4i [%c%c%c%c] (%3u) ",
+	       BATADV_PRINT_VID(vid), r, w, i, t, ttvn);
+
+	bat_host = bat_hosts_find_by_mac((char *)orig);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       orig[0], orig[1], orig[2],
+		       orig[3], orig[4], orig[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("(%3u) (0x%.8x)\n",
+	       last_ttvn, crc32);
+
+	return NL_OK;
+}
+
+static int netlink_print_transglobal(char *mesh_iface, char *orig_iface,
+				     int read_opts, float orig_timeout,
+				     float watch_interval)
+{
+	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+				    orig_timeout, watch_interval,
+				    "   Client             VID Flags Last ttvn     Via        ttvn  (CRC       )\n",
+				    BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+				    transglobal_callback);
+}
+
+static struct debug_table_data batctl_debug_table_transglobal = {
+	.debugfs_name = "transtable_global",
+	.header_lines = 2,
+	.netlink_fn = netlink_print_transglobal,
+	.option_unicast_only = 1,
+	.option_multicast_only = 1,
+};
+
+COMMAND_NAMED(DEBUGTABLE, transglobal, "tg", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_transglobal, "");
-- 
2.11.0

