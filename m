Return-Path: <asarmanow@gmail.com>
From: Alexander Sarmanow <asarmanow@gmail.com>
Subject: [PATCH v3 4/4] batctl: translocal_json: Add translocal_json command
Date: Thu, 13 May 2021 16:28:12 +0200
Message-Id: <20210513142812.1707215-5-asarmanow@gmail.com>
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

This is the JSON analogue of the translocal table. By using the
netlink_query_common function to query the available netlink attributes.

Signed-off-by: Alexander Sarmanow <asarmanow@gmail.com>
---
 Makefile          |  1 +
 README.rst        | 15 +++++++++
 man/batctl.8      |  3 ++
 translocal_json.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)
 create mode 100644 translocal_json.c

diff --git a/Makefile b/Makefile
index cea3271..8afbdbe 100755
--- a/Makefile
+++ b/Makefile
@@ -75,6 +75,7 @@ $(eval $(call add_command,transglobal,y))
 $(eval $(call add_command,transglobal_json,y))
 $(eval $(call add_command,translate,y))
 $(eval $(call add_command,translocal,y))
+$(eval $(call add_command,translocal_json,y))
 
 MANPAGE = man/batctl.8
 
diff --git a/README.rst b/README.rst
index 905e313..065c0ab 100644
--- a/README.rst
+++ b/README.rst
@@ -651,6 +651,21 @@ W/Wireless:
 If any of the flags is not enabled, a '.' will substitute its symbol.
 
 
+batctl translocal_json
+======================
+
+display the local translation JSON (analogue of the translocal table)
+
+Usage::
+
+  batctl translocal_json|tlj
+
+Example::
+
+  $ batctl translocal_json
+  [{"tt_address":"33:33:00:00:00:01","crc32":2147984693,"tt_vid":0,"tt_flags":256},{"tt_address":"33:33:00:00:00:01","crc32":2147984693,"tt_vid":0,"tt_flags":256},{"tt_address":"11:11:00:00:00:03","crc32":2147984693,"tt_vid":0,"tt_flags":256}]
+
+
 batctl transglobal
 ==================
 
diff --git a/man/batctl.8 b/man/batctl.8
index 97d5738..2b8a975 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -310,6 +310,9 @@ List of debug JSONs:
 \- originators_json|oj
 .RE
 .RS 10
+\- translocal_json|tlj
+.RE
+.RS 10
 \- transglobal_json|tgj
 .RE
 .RE
diff --git a/translocal_json.c b/translocal_json.c
new file mode 100644
index 0000000..38b64a0
--- /dev/null
+++ b/translocal_json.c
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
+static int translocal_json_callback(struct nl_msg *msg, void *arg)
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
+	if (ghdr->cmd != BATADV_CMD_GET_TRANSTABLE_LOCAL)
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
+static int netlink_print_translocal_json(struct state *state)
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
+				   BATADV_CMD_GET_TRANSTABLE_LOCAL,
+				   translocal_json_callback,
+				   NLM_F_DUMP, &json_opts.query_opts);
+	puts("]\n");
+
+	return ret;
+}
+
+static struct debug_json_data batctl_debug_json_translocal = {
+	.netlink_fn = netlink_print_translocal_json,
+};
+
+COMMAND_NAMED(DEBUGJSON, translocal_json, "tlj", handle_debug_json,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_json_translocal, "");
-- 
2.25.1

