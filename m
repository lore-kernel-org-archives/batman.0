Return-Path: <asarmanow@gmail.com>
From: Alexander Sarmanow <asarmanow@gmail.com>
Subject: [PATCH v3 2/4] batctl: neighbors_json: Add neighbors_json command
Date: Thu, 13 May 2021 16:28:10 +0200
Message-Id: <20210513142812.1707215-3-asarmanow@gmail.com>
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

This is the JSON analogue of the neighbors table. By using the
netlink_query_common function to query the available netlink attributes.

Signed-off-by: Alexander Sarmanow <asarmanow@gmail.com>
---
 Makefile         |  1 +
 README.rst       | 15 +++++++++
 man/batctl.8     |  3 ++
 neighbors_json.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 101 insertions(+)
 create mode 100644 neighbors_json.c

diff --git a/Makefile b/Makefile
index 9dfcfde..874dc2f 100755
--- a/Makefile
+++ b/Makefile
@@ -59,6 +59,7 @@ $(eval $(call add_command,multicast_fanout,y))
 $(eval $(call add_command,multicast_forceflood,y))
 $(eval $(call add_command,multicast_mode,y))
 $(eval $(call add_command,neighbors,y))
+$(eval $(call add_command,neighbors_json,y))
 $(eval $(call add_command,network_coding,y))
 $(eval $(call add_command,orig_interval,y))
 $(eval $(call add_command,originators,y))
diff --git a/README.rst b/README.rst
index c884bb3..f0ce43a 100644
--- a/README.rst
+++ b/README.rst
@@ -371,6 +371,21 @@ Example::
   [{"hard_ifindex":7,"orig_address":"fe:fe:00:00:01:01","best":true,"last_seen_msecs":700,"neigh_address":"fe:fe:00:00:02:01","tq":119},{"hard_ifindex":2,"orig_address":"fe:fe:00:00:03:01","best":true,"last_seen_msecs":1040,"neigh_address":"fe:fe:00:00:02:01","tq":116},{"hard_ifindex":7,"orig_address":"fe:fe:00:00:04:01","best":true,"last_seen_msecs":700,"neigh_address":"fe:fe:00:00:02:01","tq":119},{"hard_ifindex":2,"orig_address":"fe:fe:00:00:05:01","best":true,"last_seen_msecs":270,"neigh_address":"fe:fe:00:00:02:01","tq":140},{"hard_ifindex":2,"orig_address":"fe:fe:00:00:06:01","best":true,"last_seen_msecs":770,"neigh_address":"fe:fe:00:00:02:01","tq":91}]
 
 
+batctl neighbors_json
+=====================
+
+display the Neighbors JSON (analogue of the neighbors table)
+
+Usage::
+
+  batctl neighbors_json
+
+Example::
+
+  $ batctl neighbors_json|nj
+  [{"hard_ifindex":2,"last_seen_msecs":650,"neigh_address":"fe:fe:00:00:01:01"},{"hard_ifindex":2,"last_seen_msecs":650,"neigh_address":"fe:fe:00:00:01:02"}]
+
+
 batctl interface
 ================
 
diff --git a/man/batctl.8 b/man/batctl.8
index 155791d..1130a81 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -304,6 +304,9 @@ seen by each individual node.
 .RS 7
 List of debug JSONs:
 .RS 10
+\- neighbors_json|nj
+.RE
+.RS 10
 \- originators_json|oj
 .RE
 .RE
diff --git a/neighbors_json.c b/neighbors_json.c
new file mode 100644
index 0000000..7051c63
--- /dev/null
+++ b/neighbors_json.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Alexander Sarmanow <asarmanow@gmail.com>
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#include <net/if.h>
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
+static int neighbors_json_callback(struct nl_msg *msg, void *arg)
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
+	if (ghdr->cmd != BATADV_CMD_GET_NEIGHBORS)
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
+static int netlink_print_neighbors_json(struct state *state)
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
+				   BATADV_CMD_GET_NEIGHBORS,
+				   neighbors_json_callback,
+				   NLM_F_DUMP, &json_opts.query_opts);
+	puts("]\n");
+
+	return ret;
+}
+
+static struct debug_json_data batctl_debug_json_neighbors = {
+	.netlink_fn = netlink_print_neighbors_json,
+};
+
+COMMAND_NAMED(DEBUGJSON, neighbors_json, "nj", handle_debug_json,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_json_neighbors, "");
-- 
2.25.1

