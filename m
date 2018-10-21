Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Oct 2018 00:55:04 +0200
Message-Id: <20181021225524.8155-19-sven@narfation.org>
In-Reply-To: <20181021225524.8155-1-sven@narfation.org>
References: <20181021225524.8155-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 18/38] batctl: Move backbonetable debug table
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
 Makefile        |   1 +
 backbonetable.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++
 debug.c         |   9 ----
 main.h          |   8 ++++
 netlink.c       | 108 +++--------------------------------------
 netlink.h       |  19 +++++++-
 6 files changed, 156 insertions(+), 113 deletions(-)
 create mode 100644 backbonetable.c

diff --git a/Makefile b/Makefile
index 842795b..704a0d8 100755
--- a/Makefile
+++ b/Makefile
@@ -30,6 +30,7 @@ BINARY_NAME = batctl
 OBJ_BISECT = bisect_iv.o
 
 OBJ += bat-hosts.o
+OBJ += backbonetable.o
 ifeq ($(CONFIG_BATCTL_BISECT),y)
 OBJ += $(OBJ_BISECT)
 endif
diff --git a/backbonetable.c b/backbonetable.c
new file mode 100644
index 0000000..2512142
--- /dev/null
+++ b/backbonetable.c
@@ -0,0 +1,124 @@
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
+static const int bla_backbone_mandatory[] = {
+	BATADV_ATTR_BLA_VID,
+	BATADV_ATTR_BLA_BACKBONE,
+	BATADV_ATTR_BLA_CRC,
+	BATADV_ATTR_LAST_SEEN_MSECS,
+};
+
+static int bla_backbone_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	int last_seen_msecs, last_seen_secs;
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	uint16_t backbone_crc;
+	uint8_t *backbone;
+	uint16_t vid;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_BLA_BACKBONE)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, bla_backbone_mandatory,
+				    ARRAY_SIZE(bla_backbone_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	/* don't show own backbones */
+	if (attrs[BATADV_ATTR_BLA_OWN])
+		return NL_OK;
+
+	vid = nla_get_u16(attrs[BATADV_ATTR_BLA_VID]);
+	backbone = nla_data(attrs[BATADV_ATTR_BLA_BACKBONE]);
+	backbone_crc = nla_get_u16(attrs[BATADV_ATTR_BLA_CRC]);
+
+	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+	last_seen_secs = last_seen_msecs / 1000;
+	last_seen_msecs = last_seen_msecs % 1000;
+
+	bat_host = bat_hosts_find_by_mac((char *)backbone);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
+		       backbone[0], backbone[1], backbone[2],
+		       backbone[3], backbone[4], backbone[5]);
+	else
+		printf("%17s ", bat_host->name);
+
+	printf("on %5d %4i.%03is (0x%04x)\n",
+	       BATADV_PRINT_VID(vid), last_seen_secs, last_seen_msecs,
+	       backbone_crc);
+
+	return NL_OK;
+}
+
+static int netlink_print_bla_backbone(char *mesh_iface, char *orig_iface,
+				      int read_opts, float orig_timeout,
+				      float watch_interval)
+{
+	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+				    orig_timeout, watch_interval,
+				    "Originator           VID   last seen (CRC   )\n",
+				    BATADV_CMD_GET_BLA_BACKBONE,
+				    bla_backbone_callback);
+}
+
+static struct debug_table_data batctl_debug_table_backbonetable = {
+	.debugfs_name = DEBUG_BACKBONETABLE,
+	.header_lines = 2,
+	.netlink_fn = netlink_print_bla_backbone,
+};
+
+COMMAND_NAMED(DEBUGTABLE, backbonetable, "bbt", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_backbonetable, "");
diff --git a/debug.c b/debug.c
index 016b148..6eba9d8 100644
--- a/debug.c
+++ b/debug.c
@@ -260,15 +260,6 @@ static struct debug_table_data batctl_debug_table_claimtable = {
 COMMAND_NAMED(DEBUGTABLE, claimtable, "cl", handle_debug_table,
 	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_claimtable, "");
 
-static struct debug_table_data batctl_debug_table_backbonetable = {
-	.debugfs_name = DEBUG_BACKBONETABLE,
-	.header_lines = 2,
-	.netlink_fn = netlink_print_bla_backbone,
-};
-
-COMMAND_NAMED(DEBUGTABLE, backbonetable, "bbt", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_backbonetable, "");
-
 static struct debug_table_data batctl_debug_table_dat_cache = {
 	.debugfs_name = DEBUG_DAT_CACHE,
 	.header_lines = 2,
diff --git a/main.h b/main.h
index 8d91480..2656dcf 100644
--- a/main.h
+++ b/main.h
@@ -51,6 +51,14 @@ extern char module_ver_path[];
 #define BATADV_PRINT_VID(vid) (vid & BATADV_VLAN_HAS_TAG ? \
 			       (int)(vid & VLAN_VID_MASK) : -1)
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
+
+#ifndef container_of
+#define container_of(ptr, type, member) __extension__ ({ \
+	const __typeof__(((type *)0)->member) *__pmember = (ptr); \
+	(type *)((char *)__pmember - offsetof(type, member)); })
+#endif
+
 enum command_flags {
 	COMMAND_FLAG_MESH_IFACE = BIT(0),
 };
diff --git a/netlink.c b/netlink.c
index f0fd1d9..cf7ff65 100644
--- a/netlink.c
+++ b/netlink.c
@@ -43,24 +43,6 @@
 #include "functions.h"
 #include "main.h"
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
-
-#ifndef container_of
-#define container_of(ptr, type, member) __extension__ ({ \
-	const __typeof__(((type *)0)->member) *__pmember = (ptr); \
-	(type *)((char *)__pmember - offsetof(type, member)); })
-#endif
-
-struct print_opts {
-	int read_opt;
-	float orig_timeout;
-	float watch_interval;
-	nl_recvmsg_msg_cb_t callback;
-	char *remaining_header;
-	const char *static_header;
-	uint8_t nl_cmd;
-};
-
 struct nlquery_opts {
 	int err;
 };
@@ -132,8 +114,8 @@ static char algo_name_buf[256] = "";
 static int64_t mcast_flags = -EOPNOTSUPP;
 static int64_t mcast_flags_priv = -EOPNOTSUPP;
 
-static int missing_mandatory_attrs(struct nlattr *attrs[],
-				   const int mandatory[], int num)
+int missing_mandatory_attrs(struct nlattr *attrs[], const int mandatory[],
+			    int num)
 {
 	int i;
 
@@ -1055,74 +1037,6 @@ static int bla_claim_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static const int bla_backbone_mandatory[] = {
-	BATADV_ATTR_BLA_VID,
-	BATADV_ATTR_BLA_BACKBONE,
-	BATADV_ATTR_BLA_CRC,
-	BATADV_ATTR_LAST_SEEN_MSECS,
-};
-
-static int bla_backbone_callback(struct nl_msg *msg, void *arg)
-{
-	struct nlattr *attrs[BATADV_ATTR_MAX+1];
-	struct nlmsghdr *nlh = nlmsg_hdr(msg);
-	int last_seen_msecs, last_seen_secs;
-	struct print_opts *opts = arg;
-	struct bat_host *bat_host;
-	struct genlmsghdr *ghdr;
-	uint16_t backbone_crc;
-	uint8_t *backbone;
-	uint16_t vid;
-
-	if (!genlmsg_valid_hdr(nlh, 0)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	ghdr = nlmsg_data(nlh);
-
-	if (ghdr->cmd != BATADV_CMD_GET_BLA_BACKBONE)
-		return NL_OK;
-
-	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), batadv_netlink_policy)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	if (missing_mandatory_attrs(attrs, bla_backbone_mandatory,
-				       ARRAY_SIZE(bla_backbone_mandatory))) {
-		fputs("Missing attributes from kernel\n", stderr);
-		exit(1);
-	}
-
-	/* don't show own backbones */
-	if (attrs[BATADV_ATTR_BLA_OWN])
-		return NL_OK;
-
-	vid = nla_get_u16(attrs[BATADV_ATTR_BLA_VID]);
-	backbone = nla_data(attrs[BATADV_ATTR_BLA_BACKBONE]);
-	backbone_crc = nla_get_u16(attrs[BATADV_ATTR_BLA_CRC]);
-
-	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
-	last_seen_secs = last_seen_msecs / 1000;
-	last_seen_msecs = last_seen_msecs % 1000;
-
-	bat_host = bat_hosts_find_by_mac((char *)backbone);
-	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
-		printf("%02x:%02x:%02x:%02x:%02x:%02x ",
-		       backbone[0], backbone[1], backbone[2],
-		       backbone[3], backbone[4], backbone[5]);
-	else
-		printf("%17s ", bat_host->name);
-
-	printf("on %5d %4i.%03is (0x%04x)\n",
-	       BATADV_PRINT_VID(vid), last_seen_secs, last_seen_msecs,
-	       backbone_crc);
-
-	return NL_OK;
-}
-
 static const int dat_cache_mandatory[] = {
 	BATADV_ATTR_DAT_CACHE_IP4ADDRESS,
 	BATADV_ATTR_DAT_CACHE_HWADDRESS,
@@ -1263,10 +1177,10 @@ static int mcast_flags_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int netlink_print_common(char *mesh_iface, char *orig_iface,
-				int read_opt, float orig_timeout,
-				float watch_interval, const char *header,
-				uint8_t nl_cmd, nl_recvmsg_msg_cb_t callback)
+int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
+			 float orig_timeout, float watch_interval,
+			 const char *header, uint8_t nl_cmd,
+			 nl_recvmsg_msg_cb_t callback)
 {
 	struct print_opts opts = {
 		.read_opt = read_opt,
@@ -1485,16 +1399,6 @@ int netlink_print_bla_claim(char *mesh_iface, char *orig_iface, int read_opts,
 				    bla_claim_callback);
 }
 
-int netlink_print_bla_backbone(char *mesh_iface, char *orig_iface, int read_opts,
-			       float orig_timeout, float watch_interval)
-{
-	return netlink_print_common(mesh_iface, orig_iface, read_opts,
-				    orig_timeout, watch_interval,
-				    "Originator           VID   last seen (CRC   )\n",
-				    BATADV_CMD_GET_BLA_BACKBONE,
-				    bla_backbone_callback);
-}
-
 int netlink_print_dat_cache(char *mesh_iface, char *orig_iface, int read_opts,
 			    float orig_timeout, float watch_interval)
 {
diff --git a/netlink.h b/netlink.h
index 089e25e..7bda0d3 100644
--- a/netlink.h
+++ b/netlink.h
@@ -26,6 +26,16 @@
 #include <netlink/genl/genl.h>
 #include <netlink/genl/ctrl.h>
 
+struct print_opts {
+	int read_opt;
+	float orig_timeout;
+	float watch_interval;
+	nl_recvmsg_msg_cb_t callback;
+	char *remaining_header;
+	const char *static_header;
+	uint8_t nl_cmd;
+};
+
 struct ether_addr;
 
 int netlink_print_routing_algos(void);
@@ -43,8 +53,6 @@ int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opt,
 			   float orig_timeout, float watch_interval);
 int netlink_print_bla_claim(char *mesh_iface, char *orig_iface, int read_opt,
 			    float orig_timeout, float watch_interval);
-int netlink_print_bla_backbone(char *mesh_iface, char *orig_iface, int read_opt,
-			       float orig_timeout, float watch_interval);
 int netlink_print_dat_cache(char *mesh_iface, char *orig_iface, int read_opt,
 			    float orig_timeout, float watch_interval);
 int netlink_print_mcast_flags(char *mesh_iface, char *orig_iface, int read_opt,
@@ -58,4 +66,11 @@ int get_primarymac_netlink(const char *mesh_iface, uint8_t *primarymac);
 
 extern struct nla_policy batadv_netlink_policy[];
 
+int missing_mandatory_attrs(struct nlattr *attrs[], const int mandatory[],
+			    int num);
+int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
+			 float orig_timeout, float watch_interval,
+			 const char *header, uint8_t nl_cmd,
+			 nl_recvmsg_msg_cb_t callback);
+
 #endif /* _BATCTL_NETLINK_H */
-- 
2.19.1

