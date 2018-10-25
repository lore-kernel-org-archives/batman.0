Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:22 +0200
Message-Id: <20181025162245.19389-20-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 19/42] batctl: Move claimtable debug table
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
 claimtable.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 debug.c      |   9 ----
 netlink.c    |  84 -------------------------------------
 netlink.h    |   2 -
 5 files changed, 133 insertions(+), 95 deletions(-)
 create mode 100644 claimtable.c

diff --git a/Makefile b/Makefile
index 704a0d8..cdc5948 100755
--- a/Makefile
+++ b/Makefile
@@ -34,6 +34,7 @@ OBJ += backbonetable.o
 ifeq ($(CONFIG_BATCTL_BISECT),y)
 OBJ += $(OBJ_BISECT)
 endif
+OBJ += claimtable.o
 OBJ += debugfs.o
 OBJ += debug.o
 OBJ += functions.o
diff --git a/claimtable.c b/claimtable.c
new file mode 100644
index 0000000..06473d0
--- /dev/null
+++ b/claimtable.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ * Simon Wunderlich <sw@simonwunderlich.de>
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
+static const int bla_claim_mandatory[] = {
+	BATADV_ATTR_BLA_ADDRESS,
+	BATADV_ATTR_BLA_VID,
+	BATADV_ATTR_BLA_BACKBONE,
+	BATADV_ATTR_BLA_CRC,
+};
+
+static int bla_claim_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	uint16_t backbone_crc;
+	uint8_t *backbone;
+	uint8_t *client;
+	uint16_t vid;
+	char c = ' ';
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_BLA_CLAIM)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, bla_claim_mandatory,
+				       ARRAY_SIZE(bla_claim_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	if (attrs[BATADV_ATTR_BLA_OWN])
+		c = '*';
+
+	client = nla_data(attrs[BATADV_ATTR_BLA_ADDRESS]);
+	vid = nla_get_u16(attrs[BATADV_ATTR_BLA_VID]);
+	backbone = nla_data(attrs[BATADV_ATTR_BLA_BACKBONE]);
+	backbone_crc = nla_get_u16(attrs[BATADV_ATTR_BLA_CRC]);
+
+	bat_host = bat_hosts_find_by_mac((char *)client);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       client[0], client[1], client[2],
+		       client[3], client[4], client[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("on %5d by ", BATADV_PRINT_VID(vid));
+
+	bat_host = bat_hosts_find_by_mac((char *)backbone);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       backbone[0], backbone[1], backbone[2],
+		       backbone[3], backbone[4], backbone[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("[%c] (0x%04x)\n", c, backbone_crc);
+
+	return NL_OK;
+}
+
+static int netlink_print_bla_claim(char *mesh_iface, char *orig_iface,
+				   int read_opts, float orig_timeout,
+				   float watch_interval)
+{
+	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+				    orig_timeout, watch_interval,
+				    "Client               VID      Originator        [o] (CRC   )\n",
+				    BATADV_CMD_GET_BLA_CLAIM,
+				    bla_claim_callback);
+}
+
+static struct debug_table_data batctl_debug_table_claimtable = {
+	.debugfs_name = DEBUG_CLAIMTABLE,
+	.header_lines = 2,
+	.netlink_fn = netlink_print_bla_claim,
+};
+
+COMMAND_NAMED(DEBUGTABLE, claimtable, "cl", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_claimtable, "");
diff --git a/debug.c b/debug.c
index 6eba9d8..c8a2845 100644
--- a/debug.c
+++ b/debug.c
@@ -251,15 +251,6 @@ static struct debug_table_data batctl_debug_table_transglobal = {
 COMMAND_NAMED(DEBUGTABLE, transglobal, "tg", handle_debug_table,
 	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_transglobal, "");
 
-static struct debug_table_data batctl_debug_table_claimtable = {
-	.debugfs_name = DEBUG_CLAIMTABLE,
-	.header_lines = 2,
-	.netlink_fn = netlink_print_bla_claim,
-};
-
-COMMAND_NAMED(DEBUGTABLE, claimtable, "cl", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_claimtable, "");
-
 static struct debug_table_data batctl_debug_table_dat_cache = {
 	.debugfs_name = DEBUG_DAT_CACHE,
 	.header_lines = 2,
diff --git a/netlink.c b/netlink.c
index cf7ff65..4d3c6f8 100644
--- a/netlink.c
+++ b/netlink.c
@@ -964,79 +964,6 @@ static int gateways_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static const int bla_claim_mandatory[] = {
-	BATADV_ATTR_BLA_ADDRESS,
-	BATADV_ATTR_BLA_VID,
-	BATADV_ATTR_BLA_BACKBONE,
-	BATADV_ATTR_BLA_CRC,
-};
-
-static int bla_claim_callback(struct nl_msg *msg, void *arg)
-{
-	struct nlattr *attrs[BATADV_ATTR_MAX+1];
-	struct nlmsghdr *nlh = nlmsg_hdr(msg);
-	struct print_opts *opts = arg;
-	struct bat_host *bat_host;
-	struct genlmsghdr *ghdr;
-	uint16_t backbone_crc;
-	uint8_t *backbone;
-	uint8_t *client;
-	uint16_t vid;
-	char c = ' ';
-
-	if (!genlmsg_valid_hdr(nlh, 0)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	ghdr = nlmsg_data(nlh);
-
-	if (ghdr->cmd != BATADV_CMD_GET_BLA_CLAIM)
-		return NL_OK;
-
-	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), batadv_netlink_policy)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	if (missing_mandatory_attrs(attrs, bla_claim_mandatory,
-				       ARRAY_SIZE(bla_claim_mandatory))) {
-		fputs("Missing attributes from kernel\n", stderr);
-		exit(1);
-	}
-
-	if (attrs[BATADV_ATTR_BLA_OWN])
-		c = '*';
-
-	client = nla_data(attrs[BATADV_ATTR_BLA_ADDRESS]);
-	vid = nla_get_u16(attrs[BATADV_ATTR_BLA_VID]);
-	backbone = nla_data(attrs[BATADV_ATTR_BLA_BACKBONE]);
-	backbone_crc = nla_get_u16(attrs[BATADV_ATTR_BLA_CRC]);
-
-	bat_host = bat_hosts_find_by_mac((char *)client);
-	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
-		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
-		       client[0], client[1], client[2],
-		       client[3], client[4], client[5]);
-	else
-		printf("%17s ", bat_host->name);
-
-	printf("on %5d by ", BATADV_PRINT_VID(vid));
-
-	bat_host = bat_hosts_find_by_mac((char *)backbone);
-	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
-		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
-		       backbone[0], backbone[1], backbone[2],
-		       backbone[3], backbone[4], backbone[5]);
-	else
-		printf("%17s ", bat_host->name);
-
-	printf("[%c] (0x%04x)\n", c, backbone_crc);
-
-	return NL_OK;
-}
-
 static const int dat_cache_mandatory[] = {
 	BATADV_ATTR_DAT_CACHE_IP4ADDRESS,
 	BATADV_ATTR_DAT_CACHE_HWADDRESS,
@@ -1388,17 +1315,6 @@ int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opts,
 				    gateways_callback);
 }
 
-int netlink_print_bla_claim(char *mesh_iface, char *orig_iface, int read_opts,
-			    float orig_timeout,
-			    float watch_interval)
-{
-	return netlink_print_common(mesh_iface, orig_iface, read_opts,
-				    orig_timeout, watch_interval,
-				    "Client               VID      Originator        [o] (CRC   )\n",
-				    BATADV_CMD_GET_BLA_CLAIM,
-				    bla_claim_callback);
-}
-
 int netlink_print_dat_cache(char *mesh_iface, char *orig_iface, int read_opts,
 			    float orig_timeout, float watch_interval)
 {
diff --git a/netlink.h b/netlink.h
index 7bda0d3..514dfa3 100644
--- a/netlink.h
+++ b/netlink.h
@@ -51,8 +51,6 @@ int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opt,
 			     float orig_timeout, float watch_interval);
 int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opt,
 			   float orig_timeout, float watch_interval);
-int netlink_print_bla_claim(char *mesh_iface, char *orig_iface, int read_opt,
-			    float orig_timeout, float watch_interval);
 int netlink_print_dat_cache(char *mesh_iface, char *orig_iface, int read_opt,
 			    float orig_timeout, float watch_interval);
 int netlink_print_mcast_flags(char *mesh_iface, char *orig_iface, int read_opt,
-- 
2.11.0

