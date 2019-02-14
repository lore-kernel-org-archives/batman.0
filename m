Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu, 14 Feb 2019 13:54:15 +0100
Message-Id: <20190214125415.6472-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: add switch for setting
 multicast_fanout
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
Cc: Martin Weinelt <martin@darmstadt.freifunk.net>, David Bauer <mail@david-bauer.net>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

This patch adds an option for the new multicast_fanout setting in
batman-adv.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 Makefile           |   1 +
 README.rst         |  10 +++++
 batman_adv.h       |   7 ++++
 man/batctl.8       |   5 +++
 multicast_fanout.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+)
 create mode 100644 multicast_fanout.c

diff --git a/Makefile b/Makefile
index 4d8b709..15bc3ec 100755
--- a/Makefile
+++ b/Makefile
@@ -69,6 +69,7 @@ $(eval $(call add_command,log,y))
 $(eval $(call add_command,loglevel,y))
 $(eval $(call add_command,mcast_flags,y))
 $(eval $(call add_command,multicast_mode,y))
+$(eval $(call add_command,multicast_fanout,y))
 $(eval $(call add_command,nc_nodes,y))
 $(eval $(call add_command,neighbors,y))
 $(eval $(call add_command,network_coding,y))
diff --git a/README.rst b/README.rst
index 4c0f544..a3a61ac 100644
--- a/README.rst
+++ b/README.rst
@@ -478,6 +478,16 @@ Usage::
   batctl multicast_mode|mm [0|1]
 
 
+batctl multicast_fanout
+=====================
+
+display or modify the multicast fanout setting
+
+Usage::
+
+  batctl multicast_fanout|mo [fanout]
+
+
 batctl mcast_flags
 ==================
 
diff --git a/batman_adv.h b/batman_adv.h
index 9b12d2a..2f956e6 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -491,6 +491,13 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_THROUGHPUT_OVERRIDE,
 
+	/**
+	 * @BATADV_ATTR_MULTICAST_FANOUT: defines the maximum number of packet
+	 * copies that may be generated for a multicast-to-unicast conversion.
+	 * Once this limit is exceeded distribution will fall back to broadcast.
+	 */
+	BATADV_ATTR_MULTICAST_FANOUT,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/man/batctl.8 b/man/batctl.8
index ed8e71f..92c0e32 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -105,6 +105,11 @@ disable network coding.
 If no parameter is given the current multicast mode setting is displayed. Otherwise the parameter is used to enable or
 disable multicast optimizations (i.e. disabling means always sending own multicast frames via classic flooding).
 .br
+.IP "\fBmulticast_fanout\fP|\fBmo\fP [\fBfanout\fP]"
+If no parameter is given the current multicast fanout setting is displayed. Otherwise the parameter is used to set
+the multicast fanout. The multicast fanout defines the maximum number of packet copies that may be generated for a
+multicast-to-unicast conversion. Once this limit is exceeded distribution will fall back to broadcast.
+.br
 .IP "\fBloglevel\fP|\fBll\fP [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
 If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log
 level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting.
diff --git a/multicast_fanout.c b/multicast_fanout.c
new file mode 100644
index 0000000..b48912b
--- /dev/null
+++ b/multicast_fanout.c
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
+static struct multicast_fanout_data {
+	uint32_t multicast_fanout;
+} multicast_fanout;
+
+static int parse_multicast_fanout(struct state *state, int argc, char *argv[])
+{
+	struct settings_data *settings = state->cmd->arg;
+	struct multicast_fanout_data *data = settings->data;
+	char *endptr;
+
+	if (argc != 2) {
+		fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n");
+		return -EINVAL;
+	}
+
+	data->multicast_fanout = strtoul(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int print_multicast_fanout(struct nl_msg *msg, void *arg)
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
+	if (!attrs[BATADV_ATTR_MULTICAST_FANOUT])
+		return NL_OK;
+
+	printf("%u\n", nla_get_u32(attrs[BATADV_ATTR_MULTICAST_FANOUT]));
+
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_multicast_fanout(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_multicast_fanout);
+}
+
+static int set_attrs_multicast_fanout(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct multicast_fanout_data *data = settings->data;
+
+	nla_put_u32(msg, BATADV_ATTR_MULTICAST_FANOUT, data->multicast_fanout);
+
+	return 0;
+}
+
+static int set_multicast_fanout(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_multicast_fanout, NULL);
+}
+
+static struct settings_data batctl_settings_multicast_fanout = {
+	.sysfs_name = "multicast_fanout",
+	.data = &multicast_fanout,
+	.parse = parse_multicast_fanout,
+	.netlink_get = get_multicast_fanout,
+	.netlink_set = set_multicast_fanout,
+};
+
+COMMAND_NAMED(SUBCOMMAND, multicast_fanout, "mo", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_multicast_fanout,
+	      "[fanout]        \tdisplay or modify multicast_fanout setting");
-- 
2.11.0

