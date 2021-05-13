Return-Path: <asarmanow@gmail.com>
From: Alexander Sarmanow <asarmanow@gmail.com>
Subject: [PATCH v3 3/4] batctl: transglobal_json: Add transglobal_json command
Date: Thu, 13 May 2021 16:28:11 +0200
Message-Id: <20210513142812.1707215-4-asarmanow@gmail.com>
In-Reply-To: <20210513142812.1707215-1-asarmanow@gmail.com>
References: <20210513142812.1707215-1-asarmanow@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de, Alexander Sarmanow <asarmanow@gmail.com>

This is the JSON analogue of the transglobal table. By using the
netlink_query_common function to query the available netlink attributes.

Signed-off-by: Alexander Sarmanow <asarmanow@gmail.com>
---
 Makefile           |  1 +
 README.rst         | 15 +++++++++
 man/batctl.8       |  3 ++
 transglobal_json.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)
 create mode 100644 transglobal_json.c

diff --git a/Makefile b/Makefile
index 874dc2f..cea3271 100755
--- a/Makefile
+++ b/Makefile
@@ -72,6 +72,7 @@ $(eval $(call add_command,throughput_override,y))
 $(eval $(call add_command,throughputmeter,y))
 $(eval $(call add_command,traceroute,y))
 $(eval $(call add_command,transglobal,y))
+$(eval $(call add_command,transglobal_json,y))
 $(eval $(call add_command,translate,y))
 $(eval $(call add_command,translocal,y))
 
diff --git a/README.rst b/README.rst
index f0ce43a..905e313 100644
--- a/README.rst
+++ b/README.rst
@@ -687,6 +687,21 @@ Flags that mean:
 If any of the flags is not enabled, a '.' will substitute its symbol.
 
 
+batctl transglobal_json
+=======================
+
+display the global translation JSON (analogue of the transglobal table)
+
+Usage::
+
+  batctl transglobal_json|tgj
+
+Example::
+
+  $ batctl translglobal_json
+  [{"orig_address":"fe:fe:00:00:01:01","tt_address":"33:33:00:00:00:01","tt_ttvn":3,"last_ttvn":3,"crc32":1916279217,"tt_vid":0,"tt_flags":0,"best":true},{"orig_address":"fe:fe:00:00:01:02","tt_address":"33:33:00:00:00:02","tt_ttvn":3,"last_ttvn":3,"crc32":1916279217,"tt_vid":0,"tt_flags":0}]
+
+
 batctl dat_cache
 =================
 
diff --git a/man/batctl.8 b/man/batctl.8
index 1130a81..97d5738 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -309,6 +309,9 @@ List of debug JSONs:
 .RS 10
 \- originators_json|oj
 .RE
+.RS 10
+\- transglobal_json|tgj
+.RE
 .RE
 .br
 .IP "[\fBmeshif <netdev>\fP] \fBtranslate\fP|\fBt\fP \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
diff --git a/transglobal_json.c b/transglobal_json.c
new file mode 100644
index 0000000..612ffb8
--- /dev/null
+++ b/transglobal_json.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Alexander Sarmanow <asarmanow@gmail.com>
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
+#include "batman_adv.h"
+#include "debug.h"
+#include "main.h"
+#include "netlink.h"
+#include "genl_json.h"
+
+static int transglobal_json_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlquery_opts *query_opts = arg;
+	struct json_opts *json_opts;
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+
+	json_opts = container_of(query_opts, struct json_opts, query_opts);
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_TRANSTABLE_GLOBAL)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	netlink_print_json_entries(attrs, json_opts);
+	json_opts->is_first = 0;
+
+	return NL_OK;
+}
+
+static int netlink_print_transglobal_json(struct state *state)
+{
+	int ret;
+	struct json_opts json_opts = {
+		.is_first = 1,
+		.query_opts = {
+			.err = 0,
+		},
+	};
+
+	putc('[', stdout);
+	ret = netlink_query_common(state, state->mesh_ifindex,
+				   BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+				   transglobal_json_callback,
+				   NLM_F_DUMP, &json_opts.query_opts);
+	puts("]\n");
+
+	return ret;
+}
+
+static struct debug_json_data batctl_debug_json_transglobal = {
+	.netlink_fn = netlink_print_transglobal_json,
+};
+
+COMMAND_NAMED(DEBUGJSON, transglobal_json, "tgj", handle_debug_json,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_json_transglobal, "");
-- 
2.25.1

