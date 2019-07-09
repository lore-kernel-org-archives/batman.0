Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v3 3/6] batctl: Add elp_interval setting command
Date: Tue,  9 Jul 2019 19:26:48 +0200
Message-Id: <20190709172651.5869-4-sven@narfation.org>
In-Reply-To: <20190709172651.5869-1-sven@narfation.org>
References: <20190709172651.5869-1-sven@narfation.org>
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
elp_interval. It defines the interval in milliseconds in which batman-adv
emits probing packets for neighbor sensing (ELP).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile       |   1 +
 README.rst     |  16 +++++++
 elp_interval.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++
 man/batctl.8   |   4 ++
 4 files changed, 132 insertions(+)
 create mode 100644 elp_interval.c

diff --git a/Makefile b/Makefile
index b7bd545..f071da2 100755
--- a/Makefile
+++ b/Makefile
@@ -45,6 +45,7 @@ $(eval $(call add_command,bridge_loop_avoidance,y))
 $(eval $(call add_command,claimtable,y))
 $(eval $(call add_command,dat_cache,y))
 $(eval $(call add_command,distributed_arp_table,y))
+$(eval $(call add_command,elp_interval,y))
 $(eval $(call add_command,event,y))
 $(eval $(call add_command,fragmentation,y))
 $(eval $(call add_command,gateways,y))
diff --git a/README.rst b/README.rst
index bc54412..92983aa 100644
--- a/README.rst
+++ b/README.rst
@@ -386,6 +386,22 @@ Example::
   1000
 
 
+batctl elp interval
+===================
+
+display or modify the elp interval in ms for hard interface
+
+Usage::
+
+  batctl hardif $hardif elp_interval|et [interval]
+
+Example::
+
+  $ batctl hardif eth0 elp_interval 200
+  $ batctl hardif eth0 elp_interval
+  200
+
+
 batctl loglevel
 ===============
 
diff --git a/elp_interval.c b/elp_interval.c
new file mode 100644
index 0000000..0a5e989
--- /dev/null
+++ b/elp_interval.c
@@ -0,0 +1,111 @@
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
+#include "main.h"
+#include "sys.h"
+
+static struct elp_interval_data {
+	uint32_t elp_interval;
+} elp_interval;
+
+static int parse_elp_interval(struct state *state, int argc, char *argv[])
+{
+	struct settings_data *settings = state->cmd->arg;
+	struct elp_interval_data *data = settings->data;
+	char *endptr;
+
+	if (argc != 2) {
+		fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n");
+		return -EINVAL;
+	}
+
+	data->elp_interval = strtoul(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int print_elp_interval(struct nl_msg *msg, void *arg)
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
+	if (!attrs[BATADV_ATTR_ELP_INTERVAL])
+		return NL_OK;
+
+	printf("%u\n", nla_get_u32(attrs[BATADV_ATTR_ELP_INTERVAL]));
+
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_attrs_elp_interval(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+
+	nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, state->hif);
+
+	return 0;
+}
+
+static int get_elp_interval(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_HARDIF,
+				  get_attrs_elp_interval, print_elp_interval);
+}
+
+static int set_attrs_elp_interval(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct elp_interval_data *data = settings->data;
+
+	nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, state->hif);
+	nla_put_u32(msg, BATADV_ATTR_ELP_INTERVAL, data->elp_interval);
+
+	return 0;
+}
+
+static int set_elp_interval(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_HARDIF,
+				  set_attrs_elp_interval, NULL);
+}
+
+static struct settings_data batctl_settings_elp_interval = {
+	.sysfs_name = "elp_interval",
+	.data = &elp_interval,
+	.parse = parse_elp_interval,
+	.netlink_get = get_elp_interval,
+	.netlink_set = set_elp_interval,
+};
+
+COMMAND_NAMED(SUBCOMMAND_HIF, elp_interval, "et", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_elp_interval,
+	      "[interval]        \tdisplay or modify elp_interval setting");
diff --git a/man/batctl.8 b/man/batctl.8
index a5656cf..eef7cd8 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -97,6 +97,10 @@ the bonding mode.
 batctl will monitor for events from the netlink kernel interface of batman-adv. The local timestamp of the event will be printed
 when parameter \fB\-t\fP is specified. Parameter \fB\-r\fP will do the same but with relative timestamps.
 .br
+.IP "\fBhardif <hardif>\fP \fBelp_interval\fP|\fBet\fP [\fBinterval\fP]"
+If no parameter is given the current ELP interval setting of the hard interface is displayed otherwise the parameter is used to set the
+ELP interval. The interval is in units of milliseconds.
+.br
 .IP "\fBfragmentation\fP|\fBf\fP [\fB0\fP|\fB1\fP]"
 If no parameter is given the current fragmentation mode setting is displayed. Otherwise the parameter is used to enable or
 disable fragmentation.
-- 
2.20.1

