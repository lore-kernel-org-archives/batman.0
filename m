Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 4/4] batctl: Add throughput_override setting command
Date: Thu, 13 Jun 2019 21:12:17 +0200
Message-Id: <20190613191217.28139-5-sven@narfation.org>
In-Reply-To: <20190613191217.28139-1-sven@narfation.org>
References: <20190613191217.28139-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

B.A.T.M.A.N. V introduced a hard interface specific setting called
throughput. It defines the throughput value to be used by B.A.T.M.A.N. V
when estimating the link throughput using this interface. If the value is
set to 0 then batman-adv will try to estimate the throughput by itself.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile              |   1 +
 README.rst            |  17 +++++++
 man/batctl.8          |   6 +++
 throughput_override.c | 113 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+)
 create mode 100644 throughput_override.c

diff --git a/Makefile b/Makefile
index f071da2..e3747a2 100755
--- a/Makefile
+++ b/Makefile
@@ -67,6 +67,7 @@ $(eval $(call add_command,ping,y))
 $(eval $(call add_command,routing_algo,y))
 $(eval $(call add_command,statistics,y))
 $(eval $(call add_command,tcpdump,y))
+$(eval $(call add_command,throughput_override,y))
 $(eval $(call add_command,throughputmeter,y))
 $(eval $(call add_command,traceroute,y))
 $(eval $(call add_command,transglobal,y))
diff --git a/README.rst b/README.rst
index 92983aa..128f539 100644
--- a/README.rst
+++ b/README.rst
@@ -402,6 +402,23 @@ Example::
   200
 
 
+batctl throughput override
+==========================
+
+display or modify the throughput override in kbit/s for hard interface
+
+Usage::
+
+  batctl hardif $hardif throughput_override|to [kbit]
+
+Example::
+
+  $ batctl hardif eth0 throughput_override 15000
+  $ batctl hardif eth0 throughput_override 15mbit
+  $ batctl hardif eth0 throughput_override
+  15.0 MBit
+
+
 batctl loglevel
 ===============
 
diff --git a/man/batctl.8 b/man/batctl.8
index 690da02..b821896 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -203,6 +203,12 @@ supported routing algorithms are displayed.
 Otherwise the parameter is used to select the routing algorithm for the following
 batX interface to be created.
 .br
+.IP "\fBhardif <hardif>\fP \fBthroughput_override|to\fP [\fBbandwidth\fP]\fP"
+If no parameter is given the current througput override is displayed otherwise
+the parameter is used to set the throughput override for the specified hard
+interface.
+Just enter any number (optionally followed by "kbit" or "mbit").
+.br
 .IP "\fBisolation_mark\fP|\fBmark\fP"
 If no parameter is given the current isolation mark value is displayed.
 Otherwise the parameter is used to set or unset the isolation mark used by the
diff --git a/throughput_override.c b/throughput_override.c
new file mode 100644
index 0000000..28a6588
--- /dev/null
+++ b/throughput_override.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <mareklindner@neomailbox.ch>
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#include <errno.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <string.h>
+
+#include "functions.h"
+#include "main.h"
+#include "sys.h"
+
+static struct throughput_override_data {
+	uint32_t throughput_override;
+} throughput_override;
+
+static int parse_throughput_override(struct state *state, int argc, char *argv[])
+{
+	struct settings_data *settings = state->cmd->arg;
+	struct throughput_override_data *data = settings->data;
+	bool ret;
+
+	if (argc != 2) {
+		fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n");
+		return -EINVAL;
+	}
+
+	ret = parse_throughput(argv[1], "throughput override",
+				&data->throughput_override);
+	if (!ret)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int print_throughput_override(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	int *result = arg;
+	uint32_t mbit;
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
+	if (!attrs[BATADV_ATTR_THROUGHPUT_OVERRIDE])
+		return NL_OK;
+
+	mbit = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT_OVERRIDE]);
+	printf("%u.%u MBit\n", mbit / 10, mbit % 10);
+
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_attrs_elp_isolation(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+
+	nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, state->hif);
+
+	return 0;
+}
+
+static int get_throughput_override(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_HARDIF,
+				  get_attrs_elp_isolation, print_throughput_override);
+}
+
+static int set_attrs_throughput_override(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct throughput_override_data *data = settings->data;
+
+	nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, state->hif);
+	nla_put_u32(msg, BATADV_ATTR_THROUGHPUT_OVERRIDE, data->throughput_override);
+
+	return 0;
+}
+
+static int set_throughput_override(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_HARDIF,
+				  set_attrs_throughput_override, NULL);
+}
+
+static struct settings_data batctl_settings_throughput_override = {
+	.sysfs_name = "throughput_override",
+	.data = &throughput_override,
+	.parse = parse_throughput_override,
+	.netlink_get = get_throughput_override,
+	.netlink_set = set_throughput_override,
+};
+
+COMMAND_NAMED(SUBCOMMAND_HIF, throughput_override, "to", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_throughput_override,
+	      "[mbit]        \tdisplay or modify throughput_override setting");
-- 
2.20.1

