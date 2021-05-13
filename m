Return-Path: <asarmanow@gmail.com>
From: Alexander Sarmanow <asarmanow@gmail.com>
Subject: [PATCH v3 1/4] batctl: originators_json: Add originators_json command
Date: Thu, 13 May 2021 16:28:09 +0200
Message-Id: <20210513142812.1707215-2-asarmanow@gmail.com>
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

This is the JSON analogue of the originators table. By using the
netlink_query_common function to query the available netlink attributes.

Signed-off-by: Alexander Sarmanow <asarmanow@gmail.com>
---
 Makefile           |  1 +
 README.rst         | 15 +++++++++
 man/batctl.8       |  3 ++
 originators_json.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+)
 create mode 100644 originators_json.c

diff --git a/Makefile b/Makefile
index cee4f0c..9dfcfde 100755
--- a/Makefile
+++ b/Makefile
@@ -62,6 +62,7 @@ $(eval $(call add_command,neighbors,y))
 $(eval $(call add_command,network_coding,y))
 $(eval $(call add_command,orig_interval,y))
 $(eval $(call add_command,originators,y))
+$(eval $(call add_command,originators_json,y))
 $(eval $(call add_command,ping,y))
 $(eval $(call add_command,routing_algo,y))
 $(eval $(call add_command,statistics,y))
diff --git a/README.rst b/README.rst
index 9c55ad5..c884bb3 100644
--- a/README.rst
+++ b/README.rst
@@ -356,6 +356,21 @@ Example::
   fe:f0:00:00:01:01    0.510s   (255) fe:f0:00:00:01:01 [      eth0]: fe:f1:00:00:01:01 (240) fe:f0:00:00:01:01 (255)
 
 
+batctl originators_json
+=======================
+
+Check the Originators JSON (it's a JSON analogue of the Originators table)
+
+Usage::
+
+  batctl originators_json|oj
+
+Example::
+
+  $ batctl originators_json
+  [{"hard_ifindex":7,"orig_address":"fe:fe:00:00:01:01","best":true,"last_seen_msecs":700,"neigh_address":"fe:fe:00:00:02:01","tq":119},{"hard_ifindex":2,"orig_address":"fe:fe:00:00:03:01","best":true,"last_seen_msecs":1040,"neigh_address":"fe:fe:00:00:02:01","tq":116},{"hard_ifindex":7,"orig_address":"fe:fe:00:00:04:01","best":true,"last_seen_msecs":700,"neigh_address":"fe:fe:00:00:02:01","tq":119},{"hard_ifindex":2,"orig_address":"fe:fe:00:00:05:01","best":true,"last_seen_msecs":270,"neigh_address":"fe:fe:00:00:02:01","tq":140},{"hard_ifindex":2,"orig_address":"fe:fe:00:00:06:01","best":true,"last_seen_msecs":770,"neigh_address":"fe:fe:00:00:02:01","tq":91}]
+
+
 batctl interface
 ================
 
diff --git a/man/batctl.8 b/man/batctl.8
index b2abedc..155791d 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -303,6 +303,9 @@ seen by each individual node.
 
 .RS 7
 List of debug JSONs:
+.RS 10
+\- originators_json|oj
+.RE
 .RE
 .br
 .IP "[\fBmeshif <netdev>\fP] \fBtranslate\fP|\fBt\fP \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
diff --git a/originators_json.c b/originators_json.c
new file mode 100644
index 0000000..fc71098
--- /dev/null
+++ b/originators_json.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Alexander Sarmanow <asarmanow@gmail.com>
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#include <errno.h>
+#include <net/if.h>
+#include <netinet/if_ether.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+
+#include "batman_adv.h"
+#include "debug.h"
+#include "main.h"
+#include "netlink.h"
+#include "genl_json.h"
+
+static int originators_json_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct nlquery_opts *query_opts = arg;
+	struct json_opts *json_opts;
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
+	if (ghdr->cmd != BATADV_CMD_GET_ORIGINATORS)
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
+static int netlink_print_originators_json(struct state *state)
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
+				   BATADV_CMD_GET_ORIGINATORS,
+				   originators_json_callback,
+				   NLM_F_DUMP, &json_opts.query_opts);
+	puts("]\n");
+
+	return ret;
+}
+
+static struct debug_json_data batctl_debug_json_originators = {
+	.netlink_fn = netlink_print_originators_json,
+};
+
+COMMAND_NAMED(DEBUGJSON, originators_json, "oj", handle_debug_json,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_json_originators, "");
-- 
2.25.1

