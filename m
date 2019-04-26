Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 26 Apr 2019 19:31:48 +0200
Message-Id: <20190426173148.18677-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2] batctl: Add noflood command
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

Adds support for the new 'noflood' setting in batman-adv.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
Changelog v2:
* added noflood.c
---
 Makefile     |   1 +
 README.rst   |  10 +++++
 batman_adv.h |  10 +++++
 man/batctl.8 |   7 ++++
 noflood.c    | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+)
 create mode 100644 noflood.c

diff --git a/Makefile b/Makefile
index df8b7b9..6a363d7 100755
--- a/Makefile
+++ b/Makefile
@@ -61,6 +61,7 @@ $(eval $(call add_command,multicast_mode,y))
 $(eval $(call add_command,nc_nodes,y))
 $(eval $(call add_command,neighbors,y))
 $(eval $(call add_command,network_coding,y))
+$(eval $(call add_command,noflood,y))
 $(eval $(call add_command,orig_interval,y))
 $(eval $(call add_command,originators,y))
 $(eval $(call add_command,ping,y))
diff --git a/README.rst b/README.rst
index 03ea5e5..67d42f6 100644
--- a/README.rst
+++ b/README.rst
@@ -571,6 +571,16 @@ Usage::
 * Example 4: ``batctl mark 0x0f``
 
 
+batctl noflood
+=======================
+
+display or modify noflood setting (<disabled>|<cautious>|<aggressive>)
+
+Usage::
+
+  batctl noflood|nf [0|1|2]
+
+
 batctl translocal
 =================
 
diff --git a/batman_adv.h b/batman_adv.h
index 67f4636..ea2ffda 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -480,6 +480,16 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_MULTICAST_FANOUT,
 
+	/**
+	 * @BATADV_ATTR_NOFLOOD: defines if and how strictly flooding prevention
+	 * is configured. If the value is 0 then flood prevention is disabled.
+	 * If the value is 1 then flood prevention is enabled for all multicast
+	 * /broadcast packets excluding ICMPv6 and IGMP (cautious mode). If set
+	 * to 2 then flood prevention is enabled for all multicast/broadcast
+	 * packets (aggressive mode).
+	 */
+        BATADV_ATTR_NOFLOOD,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/man/batctl.8 b/man/batctl.8
index 8d7332a..7518f9c 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -116,6 +116,13 @@ If no parameter is given the current multicast fanout setting is displayed. Othe
 the multicast fanout. The multicast fanout defines the maximum number of packet copies that may be generated for a
 multicast-to-unicast conversion. Once this limit is exceeded distribution will fall back to broadcast.
 .br
+.IP "\fBnoflood\fP|\fBnf\fP [\fB0|1|2\fP]"
+If no parameter is given the current noflood setting is displayed. Otherwise the parameter is used to set the
+the noflood option. The noflood option defines if and how strictly flooding prevention is configured. If the value is
+0 then flood prevention is disabled. If the value is 1 then flood prevention is enabled for all multicast/broadcast
+packets excluding ICMPv6 and IGMP (cautious mode). If set to 2 then flood prevention is enabled for all multicast/broadcast
+packets (aggressive mode).
+.br
 .IP "\fBloglevel\fP|\fBll\fP [\fBlevel\fP[ \fBlevel\fP[ \fBlevel\fP]] \fB...\fP]"
 If no parameter is given the current log level settings are displayed otherwise the parameter(s) is/are used to set the log
 level. Level 'none' disables all verbose logging. Level 'batman' enables messages related to routing / flooding / broadcasting.
diff --git a/noflood.c b/noflood.c
new file mode 100644
index 0000000..c60063c
--- /dev/null
+++ b/noflood.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing <linus.luessing@c0d3.blue>
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
+static struct noflood_data {
+	uint32_t noflood;
+} noflood;
+
+static int parse_noflood(struct state *state, int argc, char *argv[])
+{
+	struct settings_data *settings = state->cmd->arg;
+	struct noflood_data *data = settings->data;
+	char *endptr;
+
+	if (argc != 2) {
+		fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n");
+		return -EINVAL;
+	}
+
+	data->noflood = strtoul(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0') {
+		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int print_noflood(struct nl_msg *msg, void *arg)
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
+	if (!attrs[BATADV_ATTR_NOFLOOD])
+		return NL_OK;
+
+	printf("%u\n", nla_get_u8(attrs[BATADV_ATTR_NOFLOOD]));
+
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_noflood(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_noflood);
+}
+
+static int set_attrs_noflood(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct noflood_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_NOFLOOD, data->noflood);
+
+	return 0;
+}
+
+static int set_noflood(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_noflood, NULL);
+}
+
+static struct settings_data batctl_settings_noflood = {
+	.sysfs_name = NULL,
+	.data = &noflood,
+	.parse = parse_noflood,
+	.netlink_get = get_noflood,
+	.netlink_set = set_noflood,
+};
+
+COMMAND_NAMED(SUBCOMMAND, noflood, "nf", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_noflood,
+	      "[0|1|2]        \tdisplay or modify noflood setting (<disabled>|<cautious>|<aggressive>)");
-- 
2.20.1

