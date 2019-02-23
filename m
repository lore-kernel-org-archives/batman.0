Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 23 Feb 2019 08:41:08 +0100
Message-Id: <20190223074108.29726-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Add hop_penalty setting command
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

OpenWrt was switched to use batctl as abstraction of the sysfs and netlink
configuration interface. The only additional configuration option to finish
this process is hop_penalty. It is required to defines the penalty which
will be applied to an not available via batctl was hop_penalty originator
message's tq-field on every hop.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile      |   1 +
 README.rst    |  15 +++++++
 hop_penalty.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++
 man/batctl.8  |   4 ++
 4 files changed, 135 insertions(+)
 create mode 100644 hop_penalty.c

diff --git a/Makefile b/Makefile
index 4d8b709..55105cc 100755
--- a/Makefile
+++ b/Makefile
@@ -63,6 +63,7 @@ $(eval $(call add_command,event,y))
 $(eval $(call add_command,fragmentation,y))
 $(eval $(call add_command,gateways,y))
 $(eval $(call add_command,gw_mode,y))
+$(eval $(call add_command,hop_penalty,y))
 $(eval $(call add_command,interface,y))
 $(eval $(call add_command,isolation_mark,y))
 $(eval $(call add_command,log,y))
diff --git a/README.rst b/README.rst
index 4c0f544..e30b5b9 100644
--- a/README.rst
+++ b/README.rst
@@ -530,6 +530,21 @@ Usage::
   batctl aggregation|ag [0|1]
 
 
+batctl hop_penalty
+==================
+
+display or modify the hop_penalty (0-255)
+
+Usage::
+
+  batctl hop_penalty|hp [penalty]
+
+Example::
+
+  $ batctl penalty
+  30
+
+
 batctl isolation_mark
 =====================
 
diff --git a/hop_penalty.c b/hop_penalty.c
new file mode 100644
index 0000000..58067bf
--- /dev/null
+++ b/hop_penalty.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
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
+#include <stddef.h>
+#include <stdint.h>
+#include <string.h>
+
+#include "main.h"
+#include "sys.h"
+
+static struct hop_penalty_data {
+	uint8_t hop_penalty;
+} hop_penalty;
+
+static int parse_hop_penalty(struct state *state, int argc, char *argv[])
+{
+	struct settings_data *settings = state->cmd->arg;
+	struct hop_penalty_data *data = settings->data;
+	char *endptr;
+
+	if (argc != 2) {
+		fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n");
+		return -EINVAL;
+	}
+
+	data->hop_penalty = strtoul(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int print_hop_penalty(struct nl_msg *msg, void *arg)
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
+	if (!attrs[BATADV_ATTR_HOP_PENALTY])
+		return NL_OK;
+
+	printf("%u\n", nla_get_u8(attrs[BATADV_ATTR_HOP_PENALTY]));
+
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_hop_penalty(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_hop_penalty);
+}
+
+static int set_attrs_hop_penalty(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct hop_penalty_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_HOP_PENALTY, data->hop_penalty);
+
+	return 0;
+}
+
+static int set_hop_penalty(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_hop_penalty, NULL);
+}
+
+static struct settings_data batctl_settings_hop_penalty = {
+	.sysfs_name = "hop_penalty",
+	.data = &hop_penalty,
+	.parse = parse_hop_penalty,
+	.netlink_get = get_hop_penalty,
+	.netlink_set = set_hop_penalty,
+};
+
+COMMAND_NAMED(SUBCOMMAND, hop_penalty, "hp", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_hop_penalty,
+	      "[penalty]         \tdisplay or modify hop_penalty setting");
diff --git a/man/batctl.8 b/man/batctl.8
index ed8e71f..0fbf1dd 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -97,6 +97,10 @@ when parameter \fB\-t\fP is specified. Parameter \fB\-r\fP will do the same but
 If no parameter is given the current fragmentation mode setting is displayed. Otherwise the parameter is used to enable or
 disable fragmentation.
 .br
+.IP "\fBhop_penalty\fP|\fBhp\fP [\fBpenalty\fP]"
+If no parameter is given the current hop penalty setting is displayed. Otherwise the parameter is used to set the
+hop penalty. The penalty is can be 0-255 (255 sets originator message's TQ to zero when forwarded by this hop).
+.br
 .IP "\fBnetwork_coding\fP|\fBnc\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current network coding mode setting is displayed. Otherwise the parameter is used to enable or
 disable network coding.
-- 
2.20.1

