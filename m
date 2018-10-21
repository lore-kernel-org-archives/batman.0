Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:55:06 +0200
Message-Id: <20181021225524.8155-21-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 20/38] batctl: Move dat_cache debug table to
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
 dat_cache.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 debug.c     |   9 ----
 netlink.c   |  96 ----------------------------------
 netlink.h   |   2 -
 5 files changed, 146 insertions(+), 107 deletions(-)
 create mode 100644 dat_cache.c

diff --git a/Makefile b/Makefile
index cdc5948..648c7bc 100755
--- a/Makefile
+++ b/Makefile
@@ -35,6 +35,7 @@ ifeq ($(CONFIG_BATCTL_BISECT),y)
 OBJ += $(OBJ_BISECT)
 endif
 OBJ += claimtable.o
+OBJ += dat_cache.o
 OBJ += debugfs.o
 OBJ += debug.o
 OBJ += functions.o
diff --git a/dat_cache.c b/dat_cache.c
new file mode 100644
index 0000000..39f8f18
--- /dev/null
+++ b/dat_cache.c
@@ -0,0 +1,145 @@
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
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <sys/socket.h>
+
+#include "batadv_packet.h"
+#include "batman_adv.h"
+#include "bat-hosts.h"
+#include "debug.h"
+#include "functions.h"
+#include "main.h"
+#include "netlink.h"
+
+static const int dat_cache_mandatory[] = {
+	BATADV_ATTR_DAT_CACHE_IP4ADDRESS,
+	BATADV_ATTR_DAT_CACHE_HWADDRESS,
+	BATADV_ATTR_DAT_CACHE_VID,
+	BATADV_ATTR_LAST_SEEN_MSECS,
+};
+
+static int dat_cache_callback(struct nl_msg *msg, void *arg)
+{
+	int last_seen_msecs, last_seen_secs, last_seen_mins;
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	struct in_addr in_addr;
+	uint8_t *hwaddr;
+	int16_t vid;
+	char *addr;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_DAT_CACHE)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, dat_cache_mandatory,
+				    ARRAY_SIZE(dat_cache_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	in_addr.s_addr = nla_get_u32(attrs[BATADV_ATTR_DAT_CACHE_IP4ADDRESS]);
+	addr = inet_ntoa(in_addr);
+	hwaddr = nla_data(attrs[BATADV_ATTR_DAT_CACHE_HWADDRESS]);
+	vid = nla_get_u16(attrs[BATADV_ATTR_DAT_CACHE_VID]);
+
+	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+	last_seen_mins = last_seen_msecs / 60000;
+	last_seen_msecs = last_seen_msecs % 60000;
+	last_seen_secs = last_seen_msecs / 1000;
+
+	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
+		return NL_OK;
+
+	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
+		return NL_OK;
+
+	printf(" * %15s ", addr);
+
+	bat_host = bat_hosts_find_by_mac((char *)hwaddr);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       hwaddr[0], hwaddr[1], hwaddr[2],
+		       hwaddr[3], hwaddr[4], hwaddr[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("%4i %6i:%02i\n",
+	       BATADV_PRINT_VID(vid), last_seen_mins, last_seen_secs);
+
+	return NL_OK;
+}
+
+static int netlink_print_dat_cache(char *mesh_iface, char *orig_iface,
+				   int read_opts, float orig_timeout,
+				   float watch_interval)
+{
+	char *header;
+	int ret;
+
+	ret = asprintf(&header, "Distributed ARP Table (%s):\n%s\n",
+		       mesh_iface,
+		       "          IPv4             MAC        VID   last-seen");
+
+	if (ret < 0)
+		return ret;
+
+	ret = netlink_print_common(mesh_iface, orig_iface, read_opts,
+				   orig_timeout, watch_interval, header,
+				   BATADV_CMD_GET_DAT_CACHE,
+				   dat_cache_callback);
+
+	free(header);
+	return ret;
+}
+
+static struct debug_table_data batctl_debug_table_dat_cache = {
+	.debugfs_name = DEBUG_DAT_CACHE,
+	.header_lines = 2,
+	.netlink_fn = netlink_print_dat_cache,
+};
+
+COMMAND_NAMED(DEBUGTABLE, dat_cache, "dc", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_dat_cache, "");
diff --git a/debug.c b/debug.c
index c8a2845..29c8252 100644
--- a/debug.c
+++ b/debug.c
@@ -251,15 +251,6 @@ static struct debug_table_data batctl_debug_table_transglobal = {
 COMMAND_NAMED(DEBUGTABLE, transglobal, "tg", handle_debug_table,
 	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_transglobal, "");
 
-static struct debug_table_data batctl_debug_table_dat_cache = {
-	.debugfs_name = DEBUG_DAT_CACHE,
-	.header_lines = 2,
-	.netlink_fn = netlink_print_dat_cache,
-};
-
-COMMAND_NAMED(DEBUGTABLE, dat_cache, "dc", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_dat_cache, "");
-
 static struct debug_table_data batctl_debug_table_nc_nodes = {
 	.debugfs_name = DEBUG_NC_NODES,
 	.header_lines = 0,
diff --git a/netlink.c b/netlink.c
index 4d3c6f8..42fe4a0 100644
--- a/netlink.c
+++ b/netlink.c
@@ -964,80 +964,6 @@ static int gateways_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static const int dat_cache_mandatory[] = {
-	BATADV_ATTR_DAT_CACHE_IP4ADDRESS,
-	BATADV_ATTR_DAT_CACHE_HWADDRESS,
-	BATADV_ATTR_DAT_CACHE_VID,
-	BATADV_ATTR_LAST_SEEN_MSECS,
-};
-
-static int dat_cache_callback(struct nl_msg *msg, void *arg)
-{
-	int last_seen_msecs, last_seen_secs, last_seen_mins;
-	struct nlattr *attrs[BATADV_ATTR_MAX+1];
-	struct nlmsghdr *nlh = nlmsg_hdr(msg);
-	struct print_opts *opts = arg;
-	struct bat_host *bat_host;
-	struct genlmsghdr *ghdr;
-	struct in_addr in_addr;
-	uint8_t *hwaddr;
-	int16_t vid;
-	char *addr;
-
-	if (!genlmsg_valid_hdr(nlh, 0)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	ghdr = nlmsg_data(nlh);
-
-	if (ghdr->cmd != BATADV_CMD_GET_DAT_CACHE)
-		return NL_OK;
-
-	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), batadv_netlink_policy)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	if (missing_mandatory_attrs(attrs, dat_cache_mandatory,
-				    ARRAY_SIZE(dat_cache_mandatory))) {
-		fputs("Missing attributes from kernel\n", stderr);
-		exit(1);
-	}
-
-	in_addr.s_addr = nla_get_u32(attrs[BATADV_ATTR_DAT_CACHE_IP4ADDRESS]);
-	addr = inet_ntoa(in_addr);
-	hwaddr = nla_data(attrs[BATADV_ATTR_DAT_CACHE_HWADDRESS]);
-	vid = nla_get_u16(attrs[BATADV_ATTR_DAT_CACHE_VID]);
-
-	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
-	last_seen_mins = last_seen_msecs / 60000;
-	last_seen_msecs = last_seen_msecs % 60000;
-	last_seen_secs = last_seen_msecs / 1000;
-
-	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
-		return NL_OK;
-
-	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
-		return NL_OK;
-
-	printf(" * %15s ", addr);
-
-	bat_host = bat_hosts_find_by_mac((char *)hwaddr);
-	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
-		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
-		       hwaddr[0], hwaddr[1], hwaddr[2],
-		       hwaddr[3], hwaddr[4], hwaddr[5]);
-	else
-		printf("%17s ", bat_host->name);
-
-	printf("%4i %6i:%02i\n",
-	       BATADV_PRINT_VID(vid), last_seen_mins, last_seen_secs);
-
-	return NL_OK;
-}
-
 static const int mcast_flags_mandatory[] = {
 	BATADV_ATTR_ORIG_ADDRESS,
 };
@@ -1315,28 +1241,6 @@ int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opts,
 				    gateways_callback);
 }
 
-int netlink_print_dat_cache(char *mesh_iface, char *orig_iface, int read_opts,
-			    float orig_timeout, float watch_interval)
-{
-	char *header;
-	int ret;
-
-	ret = asprintf(&header, "Distributed ARP Table (%s):\n%s\n",
-		       mesh_iface,
-		       "          IPv4             MAC        VID   last-seen");
-
-	if (ret < 0)
-		return ret;
-
-	ret = netlink_print_common(mesh_iface, orig_iface, read_opts,
-				   orig_timeout, watch_interval, header,
-				   BATADV_CMD_GET_DAT_CACHE,
-				   dat_cache_callback);
-
-	free(header);
-	return ret;
-}
-
 int netlink_print_mcast_flags(char *mesh_iface, char *orig_iface, int read_opts,
 			      float orig_timeout, float watch_interval)
 {
diff --git a/netlink.h b/netlink.h
index 514dfa3..7549838 100644
--- a/netlink.h
+++ b/netlink.h
@@ -51,8 +51,6 @@ int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opt,
 			     float orig_timeout, float watch_interval);
 int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opt,
 			   float orig_timeout, float watch_interval);
-int netlink_print_dat_cache(char *mesh_iface, char *orig_iface, int read_opt,
-			    float orig_timeout, float watch_interval);
 int netlink_print_mcast_flags(char *mesh_iface, char *orig_iface, int read_opt,
 			      float orig_timeout, float watch_interval);
 
-- 
2.19.1

