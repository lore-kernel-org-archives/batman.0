Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sat, 16 Feb 2019 03:58:54 +0100
Message-Id: <20190216025854.21537-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: replace multicast_mode with
 multicast_forceflood command
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

This patch hides the multicast_mode setting in the UI and adds a new
multicast_forceflood command. multicast_forceflood is basically the
inverse of the current multicast_mode setting.

For the netlink config additions to batman-adv "multicast_mode" was
not added. Instead a "multicast_forceflood" attribute was introduced.

The multicast_mode batctl command is kept for compatibility for now
but should be removed eventually.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 Makefile               |  1 +
 README.rst             |  8 ++---
 functions.c            | 16 ++++++++-
 functions.h            |  1 +
 main.c                 |  3 ++
 main.h                 |  1 +
 man/batctl.8           |  8 +++--
 multicast_forceflood.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++
 multicast_mode.c       |  3 +-
 sys.c                  | 30 +++++++++++++---
 10 files changed, 151 insertions(+), 15 deletions(-)
 create mode 100644 multicast_forceflood.c

diff --git a/Makefile b/Makefile
index 4d8b709..7c050c0 100755
--- a/Makefile
+++ b/Makefile
@@ -68,6 +68,7 @@ $(eval $(call add_command,isolation_mark,y))
 $(eval $(call add_command,log,y))
 $(eval $(call add_command,loglevel,y))
 $(eval $(call add_command,mcast_flags,y))
+$(eval $(call add_command,multicast_forceflood,y))
 $(eval $(call add_command,multicast_mode,y))
 $(eval $(call add_command,nc_nodes,y))
 $(eval $(call add_command,neighbors,y))
diff --git a/README.rst b/README.rst
index 4c0f544..6db68d7 100644
--- a/README.rst
+++ b/README.rst
@@ -468,14 +468,14 @@ Usage::
 Note that network coding requires a working promiscuous mode on all interfaces.
 
 
-batctl multicast_mode
-=====================
+batctl multicast_forceflood
+===========================
 
-display or modify the multicast mode setting
+display or modify the multicast forceflood setting
 
 Usage::
 
-  batctl multicast_mode|mm [0|1]
+  batctl multicast_forceflood|mff [0|1]
 
 
 batctl mcast_flags
diff --git a/functions.c b/functions.c
index 76deab7..a202969 100644
--- a/functions.c
+++ b/functions.c
@@ -175,6 +175,16 @@ static bool ether_addr_valid(const uint8_t *addr)
 	return true;
 }
 
+static void print_inv_bool(char *line)
+{
+	if (!strncmp("enabled", line, strlen("enabled")))
+		printf("disabled\n");
+	else if (!strncmp("disabled", line, strlen("disabled")))
+		printf("enabled\n");
+	else
+		printf("%s", line);
+}
+
 int read_file(const char *dir, const char *fname, int read_opt,
 	      float orig_timeout, float watch_interval, size_t header_lines)
 {
@@ -237,7 +247,11 @@ int read_file(const char *dir, const char *fname, int read_opt,
 			continue;
 
 		if (!(read_opt & USE_BAT_HOSTS)) {
-			printf("%s", line_ptr);
+			if (read_opt & INVERSE_BOOL)
+				print_inv_bool(line_ptr);
+			else
+				printf("%s", line_ptr);
+
 			continue;
 		}
 
diff --git a/functions.h b/functions.h
index e2bbb4e..b3f2159 100644
--- a/functions.h
+++ b/functions.h
@@ -91,6 +91,7 @@ enum {
 	SKIP_HEADER = 0x100,
 	UNICAST_ONLY = 0x200,
 	MULTICAST_ONLY = 0x400,
+	INVERSE_BOOL = 0x800,
 };
 
 #endif
diff --git a/main.c b/main.c
index 2a28642..199c7a4 100644
--- a/main.c
+++ b/main.c
@@ -74,6 +74,9 @@ static void print_usage(void)
 			if (cmd->type != type[i])
 				continue;
 
+			if (!cmd->usage)
+				continue;
+
 			if (strcmp(cmd->name, cmd->abbr) == 0)
 				snprintf(buf, sizeof(buf), "%s", cmd->name);
 			else
diff --git a/main.h b/main.h
index fca2a32..92d0e61 100644
--- a/main.h
+++ b/main.h
@@ -67,6 +67,7 @@ extern char module_ver_path[];
 enum command_flags {
 	COMMAND_FLAG_MESH_IFACE = BIT(0),
 	COMMAND_FLAG_NETLINK = BIT(1),
+	COMMAND_FLAG_INVERSE = BIT(2),
 };
 
 enum command_type {
diff --git a/man/batctl.8 b/man/batctl.8
index ed8e71f..695067f 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -101,9 +101,11 @@ disable fragmentation.
 If no parameter is given the current network coding mode setting is displayed. Otherwise the parameter is used to enable or
 disable network coding.
 .br
-.IP "\fBmulticast_mode\fP|\fBmm\fP [\fB0\fP|\fB1\fP]"
-If no parameter is given the current multicast mode setting is displayed. Otherwise the parameter is used to enable or
-disable multicast optimizations (i.e. disabling means always sending own multicast frames via classic flooding).
+.IP "\fBmulticast_forceflood\fP|\fBmff\fP [\fB0\fP|\fB1\fP]"
+If no parameter is given the current multicast forceflood setting is displayed. Otherwise the parameter is used to enable or
+disable multicast forceflood. This setting defines whether multicast optimizations should be replaced by simple broadcast-like
+flooding of multicast packets. If set to non-zero then all nodes in the mesh are going to use classic flooding for any
+multicast packet with no optimizations.
 .br
 .IP "\fBloglevel\fP|\fBll\fP [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
 If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log
diff --git a/multicast_forceflood.c b/multicast_forceflood.c
new file mode 100644
index 0000000..daaa6d0
--- /dev/null
+++ b/multicast_forceflood.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing <linus.luessing@c0d3.blue>
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
+#include "main.h"
+
+#include <errno.h>
+#include <linux/genetlink.h>
+#include <netlink/genl/genl.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
+#include "sys.h"
+
+static struct simple_boolean_data multicast_forceflood;
+
+static int print_multicast_forceflood(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	int *result = arg;
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	if (!attrs[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED])
+		return NL_OK;
+
+	printf("%s\n", nla_get_u8(attrs[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED]) ? "enabled" : "disabled");
+
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_multicast_forceflood(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_multicast_forceflood);
+}
+
+static int set_attrs_multicast_forceflood(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED, data->val);
+
+	return 0;
+}
+
+static int set_multicast_forceflood(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_multicast_forceflood, NULL);
+}
+
+static struct settings_data batctl_settings_multicast_forceflood = {
+	.sysfs_name = "multicast_mode",
+	.data = &multicast_forceflood,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_multicast_forceflood,
+	.netlink_set = set_multicast_forceflood,
+};
+
+COMMAND_NAMED(SUBCOMMAND, multicast_forceflood, "mff", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK | COMMAND_FLAG_INVERSE,
+	      &batctl_settings_multicast_forceflood,
+	      "[0|1]             \tdisplay or modify multicast_forceflood setting");
diff --git a/multicast_mode.c b/multicast_mode.c
index 836a744..fb17586 100644
--- a/multicast_mode.c
+++ b/multicast_mode.c
@@ -91,5 +91,4 @@ static struct settings_data batctl_settings_multicast_mode = {
 
 COMMAND_NAMED(SUBCOMMAND, multicast_mode, "mm", handle_sys_setting,
 	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
-	      &batctl_settings_multicast_mode,
-	      "[0|1]             \tdisplay or modify multicast_mode setting");
+	      &batctl_settings_multicast_mode, NULL);
diff --git a/sys.c b/sys.c
index 9a7966f..b0864cd 100644
--- a/sys.c
+++ b/sys.c
@@ -156,7 +156,8 @@ int sys_simple_print_boolean(struct nl_msg *msg, void *arg,
 static void settings_usage(struct state *state)
 {
 	fprintf(stderr, "Usage: batctl [options] %s|%s [parameters] %s\n",
-		state->cmd->name, state->cmd->abbr, state->cmd->usage);
+		state->cmd->name, state->cmd->abbr,
+		state->cmd->usage ? state->cmd->usage : "");
 
 	fprintf(stderr, "parameters:\n");
 	fprintf(stderr, " \t -h print this help\n");
@@ -167,6 +168,7 @@ static int sys_read_setting(struct state *state, const char *path_buff,
 {
 	struct settings_data *settings = state->cmd->arg;
 	int res = EXIT_FAILURE;
+	int read_opt = NO_FLAGS;
 
 	if (settings->netlink_get) {
 		res = settings->netlink_get(state);
@@ -176,8 +178,12 @@ static int sys_read_setting(struct state *state, const char *path_buff,
 			return EXIT_SUCCESS;
 	}
 
-	if (sysfs_name)
-		res = read_file(path_buff, sysfs_name, NO_FLAGS, 0, 0, 0);
+	if (sysfs_name) {
+		if (state->cmd->flags & COMMAND_FLAG_INVERSE)
+			read_opt |= INVERSE_BOOL;
+
+		res = read_file(path_buff, sysfs_name, read_opt, 0, 0, 0);
+	}
 
 	return res;
 }
@@ -187,6 +193,7 @@ static int sys_write_setting(struct state *state, const char *path_buff,
 {
 	struct settings_data *settings = state->cmd->arg;
 	int res = EXIT_FAILURE;
+	char *argv1 = argv[1];
 
 	if (settings->netlink_set) {
 		res = settings->netlink_set(state);
@@ -196,9 +203,22 @@ static int sys_write_setting(struct state *state, const char *path_buff,
 			return EXIT_SUCCESS;
 	}
 
-	if (sysfs_name)
+	if (sysfs_name) {
+		if (state->cmd->flags & COMMAND_FLAG_INVERSE) {
+			if (!strncmp("0", argv[1], strlen("0")) ||
+			    !strncmp("disable", argv[1], strlen("disable")) ||
+			    !strncmp("disabled", argv[1], strlen("disabled"))) {
+				argv1 = "enabled";
+			} else if (!strncmp("1", argv[1], strlen("1")) ||
+				   !strncmp("enable", argv[1], strlen("enable")) ||
+				   !strncmp("enabled", argv[1], strlen("enabled"))) {
+				argv1 = "disabled";
+			}
+		}
+
 		res = write_file(path_buff, sysfs_name,
-				 argv[1], argc > 2 ? argv[2] : NULL);
+				 argv1, argc > 2 ? argv[2] : NULL);
+	}
 
 	return res;
 }
-- 
2.11.0

