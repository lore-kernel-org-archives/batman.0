Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH] batctl: Add per interface hop penalty command
Date: Mon,  1 Jun 2020 22:35:38 +0200
Message-Id: <20200601203538.5318-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Maximilian Wilhelm <max@rfc2324.org>

This patch extends the hop penalty setting to be configurable not only
on a node scope but also on a per hard interface basis.

Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
 Makefile         |   1 +
 README.rst       |   7 ++-
 if_hop_penalty.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++
 man/batctl.8     |   4 ++
 4 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 if_hop_penalty.c

diff --git a/Makefile b/Makefile
index 780c2c0..34096f7 100755
--- a/Makefile
+++ b/Makefile
@@ -51,6 +51,7 @@ $(eval $(call add_command,fragmentation,y))
 $(eval $(call add_command,gateways,y))
 $(eval $(call add_command,gw_mode,y))
 $(eval $(call add_command,hop_penalty,y))
+$(eval $(call add_command,if_hop_penalty,y))
 $(eval $(call add_command,interface,y))
 $(eval $(call add_command,isolation_mark,y))
 $(eval $(call add_command,loglevel,y))
diff --git a/README.rst b/README.rst
index 128f539..4830347 100644
--- a/README.rst
+++ b/README.rst
@@ -562,8 +562,13 @@ Usage::
=20
 Example::
=20
-  $ batctl penalty
+  $ batctl hop_penalty
   30
+  $ batctl hardif eth0 hop_penalty
+  0
+  $ batctl hardif eth0 hop_penalty 50
+  $ batctl hardif eth0 hop_penalty
+  50
=20
=20
 batctl isolation_mark
diff --git a/if_hop_penalty.c b/if_hop_penalty.c
new file mode 100644
index 0000000..71d684b
--- /dev/null
+++ b/if_hop_penalty.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+ *
+ * Linus L=C3=BCssing <linus.luessing@c0d3.blue>
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
+static struct if_hop_penalty_data {
+	uint8_t hop_penalty;
+} if_hop_penalty;
+
+static int parse_if_hop_penalty(struct state *state, int argc, char *arg=
v[])
+{
+	struct settings_data *settings =3D state->cmd->arg;
+	struct if_hop_penalty_data *data =3D settings->data;
+	char *endptr;
+
+	if (argc !=3D 2) {
+		fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n"=
);
+		return -EINVAL;
+	}
+
+	data->hop_penalty =3D strtoul(argv[1], &endptr, 0);
+	if (!endptr || *endptr !=3D '\0') {
+		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv=
[1]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int print_if_hop_penalty(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	int *result =3D arg;
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr =3D nlmsg_data(nlh);
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
+	*result =3D 0;
+	return NL_STOP;
+}
+
+static int get_attrs_if_hop_penalty(struct nl_msg *msg, void *arg)
+{
+	struct state *state =3D arg;
+
+	nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, state->hif);
+
+	return 0;
+}
+
+static int get_if_hop_penalty(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_HARDIF,
+				  get_attrs_if_hop_penalty,
+				  print_if_hop_penalty);
+}
+
+static int set_attrs_if_hop_penalty(struct nl_msg *msg, void *arg)
+{
+	struct state *state =3D arg;
+	struct settings_data *settings =3D state->cmd->arg;
+	struct if_hop_penalty_data *data =3D settings->data;
+
+	nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, state->hif);
+	nla_put_u8(msg, BATADV_ATTR_HOP_PENALTY, data->hop_penalty);
+
+	return 0;
+}
+
+static int set_if_hop_penalty(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_HARDIF,
+				  set_attrs_if_hop_penalty, NULL);
+}
+
+static struct settings_data batctl_settings_if_hop_penalty =3D {
+	.sysfs_name =3D NULL,
+	.data =3D &if_hop_penalty,
+	.parse =3D parse_if_hop_penalty,
+	.netlink_get =3D get_if_hop_penalty,
+	.netlink_set =3D set_if_hop_penalty,
+};
+
+COMMAND_NAMED(SUBCOMMAND_HIF, hop_penalty, "hp", handle_sys_setting,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_if_hop_penalty,
+	      "[penalty]         \tdisplay or modify hop_penalty setting");
diff --git a/man/batctl.8 b/man/batctl.8
index 6e75cdd..d4d5fe5 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -109,6 +109,10 @@ disable fragmentation.
 If no parameter is given the current hop penalty setting is displayed. O=
therwise the parameter is used to set the
 hop penalty. The penalty is can be 0-255 (255 sets originator message's =
TQ to zero when forwarded by this hop).
 .br
+.IP "[\fBhardif <hardif>\fP] \fBhop_penalty\fP|\fBhp\fP [\fBpenalty\fP]"
+If no parameter is given the current hop penalty setting of the hard int=
erface is displayed. Otherwise the parameter is used to set the
+hop penalty. The penalty can be 0-255 (255 sets originator message's TQ =
to zero when forwarded over this interface).
+.br
 .IP "[\fBmeshif <netdev>\fP] \fBnetwork_coding\fP|\fBnc\fP [\fB0\fP|\fB1=
\fP]"
 If no parameter is given the current network coding mode setting is disp=
layed. Otherwise the parameter is used to enable or
 disable network coding.
--=20
2.27.0.rc2
