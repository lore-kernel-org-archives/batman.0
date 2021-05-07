Return-Path: <asarmanow@gmail.com>
From: Alexander Sarmanow <asarmanow@gmail.com>
Subject: [PATCH v2 2/2] batctl: Add JSON debug commands
Date: Fri,  7 May 2021 19:14:35 +0200
Message-Id: <20210507171435.370648-1-asarmanow@gmail.com>
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

According to part 1 of this patch following commands will be added to
the JSON debug: meshinfo_json, originators_json, neighbors_json,
translocal_json, transglobal_json.

Signed-off-by: Alexander Sarmanow <asarmanow@gmail.com>
---
 Makefile           |   5 ++
 gateways.c         |   2 +-
 main.c             |  14 +++--
 main.h             |   1 +
 mcast_flags.c      |   2 +-
 meshinfo_json.c    | 139 +++++++++++++++++++++++++++++++++++++++++++++
 neighbors_json.c   |  89 +++++++++++++++++++++++++++++
 netlink.c          |  39 ++++++++-----
 netlink.h          |   2 +-
 originators.c      |   2 +-
 originators_json.c | 107 ++++++++++++++++++++++++++++++++++
 transglobal_json.c | 109 +++++++++++++++++++++++++++++++++++
 translocal_json.c  | 102 +++++++++++++++++++++++++++++++++
 13 files changed, 592 insertions(+), 21 deletions(-)
 create mode 100644 meshinfo_json.c
 create mode 100644 neighbors_json.c
 create mode 100644 originators_json.c
 create mode 100644 transglobal_json.c
 create mode 100644 translocal_json.c

diff --git a/Makefile b/Makefile
index 98bf695..0f85561 100755
--- a/Makefile
+++ b/Makefile
@@ -54,13 +54,16 @@ $(eval $(call add_command,interface,y))
 $(eval $(call add_command,isolation_mark,y))
 $(eval $(call add_command,loglevel,y))
 $(eval $(call add_command,mcast_flags,y))
+$(eval $(call add_command,meshinfo_json,y))
 $(eval $(call add_command,multicast_fanout,y))
 $(eval $(call add_command,multicast_forceflood,y))
 $(eval $(call add_command,multicast_mode,y))
 $(eval $(call add_command,neighbors,y))
+$(eval $(call add_command,neighbors_json,y))
 $(eval $(call add_command,network_coding,y))
 $(eval $(call add_command,orig_interval,y))
 $(eval $(call add_command,originators,y))
+$(eval $(call add_command,originators_json,y))
 $(eval $(call add_command,ping,y))
 $(eval $(call add_command,routing_algo,y))
 $(eval $(call add_command,statistics,y))
@@ -69,8 +72,10 @@ $(eval $(call add_command,throughput_override,y))
 $(eval $(call add_command,throughputmeter,y))
 $(eval $(call add_command,traceroute,y))
 $(eval $(call add_command,transglobal,y))
+$(eval $(call add_command,transglobal_json,y))
 $(eval $(call add_command,translate,y))
 $(eval $(call add_command,translocal,y))
+$(eval $(call add_command,translocal_json,y))
 
 MANPAGE = man/batctl.8
 
diff --git a/gateways.c b/gateways.c
index 867c882..3704c99 100644
--- a/gateways.c
+++ b/gateways.c
@@ -123,7 +123,7 @@ static int netlink_print_gateways(struct state *state, char *orig_iface,
 	/* only parse routing algorithm name */
 	last_err = -EINVAL;
 	info_header = netlink_get_info(state->mesh_ifindex,
-				       BATADV_CMD_GET_ORIGINATORS, NULL);
+				       BATADV_CMD_GET_ORIGINATORS, NULL, 0);
 	free(info_header);
 
 	if (strlen(algo_name_buf) == 0)
diff --git a/main.c b/main.c
index d9b63f3..1371bc0 100644
--- a/main.c
+++ b/main.c
@@ -43,6 +43,10 @@ static void print_usage(void)
 			.label = "debug tables:                                   \tdisplay the corresponding debug table\n",
 			.types = BIT(DEBUGTABLE),
 		},
+		{
+			.label = "debug JSONs:                                   \tdisplay the corresponding debug JSON\n",
+			.types = BIT(DEBUGJSON),
+		},
 	};
 	const char *default_prefixes[] = {
 		"",
@@ -67,9 +71,9 @@ static void print_usage(void)
 	char buf[64];
 	size_t i;
 
-	fprintf(stderr, "Usage: batctl [options] command|debug table [parameters]\n");
+	fprintf(stderr, "Usage: batctl [options] command|debug table|debug json [parameters]\n");
 	fprintf(stderr, "options:\n");
-	fprintf(stderr, " \t-h print this help (or 'batctl <command|debug table> -h' for the parameter help)\n");
+	fprintf(stderr, " \t-h print this help (or 'batctl <command|debug table|debug json> -h' for the parameter help)\n");
 	fprintf(stderr, " \t-v print version\n");
 
 	for (i = 0; i < sizeof(type) / sizeof(*type); i++) {
@@ -87,6 +91,7 @@ static void print_usage(void)
 				continue;
 
 			switch (cmd->type) {
+			case DEBUGJSON:
 			case DEBUGTABLE:
 			case SUBCOMMAND_MIF:
 				prefixes = meshif_prefixes;
@@ -167,7 +172,8 @@ static const struct command *find_command(struct state *state, const char *name)
 		/* fall through */
 	case SP_MESHIF:
 		types |= BIT(SUBCOMMAND_MIF) |
-			 BIT(DEBUGTABLE);
+			 BIT(DEBUGTABLE)     |
+			 BIT(DEBUGJSON);
 		break;
 	case SP_VLAN:
 		types = BIT(SUBCOMMAND_VID);
@@ -380,7 +386,7 @@ int main(int argc, char **argv)
 	cmd = find_command(&state, argv[0]);
 	if (!cmd) {
 		fprintf(stderr,
-			"Error - no valid command or debug table specified: %s\n",
+			"Error - no valid command or debug table/JSON specified: %s\n",
 			argv[0]);
 		goto err;
 	}
diff --git a/main.h b/main.h
index b1ff050..2efd136 100644
--- a/main.h
+++ b/main.h
@@ -71,6 +71,7 @@ enum command_type {
 	SUBCOMMAND_VID,
 	SUBCOMMAND_HIF,
 	DEBUGTABLE,
+	DEBUGJSON,
 };
 
 struct state {
diff --git a/mcast_flags.c b/mcast_flags.c
index cb6e89d..87fb077 100644
--- a/mcast_flags.c
+++ b/mcast_flags.c
@@ -105,7 +105,7 @@ static int netlink_print_mcast_flags(struct state *state, char *orig_iface,
 
 	/* only parse own multicast flags */
 	info_header = netlink_get_info(state->mesh_ifindex,
-				       BATADV_CMD_GET_MCAST_FLAGS, NULL);
+				       BATADV_CMD_GET_MCAST_FLAGS, NULL, 0);
 	free(info_header);
 
 	if (mcast_flags == -EOPNOTSUPP || mcast_flags_priv == -EOPNOTSUPP)
diff --git a/meshinfo_json.c b/meshinfo_json.c
new file mode 100644
index 0000000..8c6f675
--- /dev/null
+++ b/meshinfo_json.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Alexander Sarmanow <asarmanow@gmail.com>
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#include <errno.h>
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
+
+static const int info_mandatory[] = {
+	BATADV_ATTR_MESH_IFINDEX,
+	BATADV_ATTR_MESH_IFNAME,
+};
+
+static int meshinfo_callback(struct nl_msg *msg, void *arg)
+{
+	struct print_opts *opts = arg;
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	int selected_attrs[10] = { BATADV_ATTR_MESH_IFNAME,
+				   BATADV_ATTR_MESH_ADDRESS,
+				   BATADV_ATTR_HARD_IFNAME,
+				   BATADV_ATTR_VERSION,
+				   BATADV_ATTR_ALGO_NAME,
+				   BATADV_ATTR_HARD_ADDRESS,
+				   BATADV_ATTR_TT_TTVN };
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_MESH_INFO)
+		return NL_OK;
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, info_mandatory,
+				    ARRAY_SIZE(info_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	netlink_print_json_entries(attrs, selected_attrs,
+				   ARRAY_SIZE(selected_attrs), opts);
+	opts->is_first = 0;
+
+	return NL_OK;
+}
+
+static int netlink_print_meshinfo_json(struct state *state, char *orig_iface,
+				       int read_opts, float orig_timeout,
+				       float watch_interval)
+{
+	(void) orig_iface;
+	(void) orig_timeout;
+	(void) watch_interval;
+       	(void) read_opts;
+	struct nl_sock *sock;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	struct print_opts opts = {
+		.is_json = 1,
+		.is_first = 1,
+	};
+	int family;
+
+	if (!state->sock) {
+		last_err = -EOPNOTSUPP;
+		return last_err;
+	}
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		return -1;
+
+	genl_connect(sock);
+
+	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
+	if (family < 0) {
+		nl_socket_free(sock);
+		return -1;
+	}
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		nl_socket_free(sock);
+		return -1;
+	}
+
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, 0,
+		    BATADV_CMD_GET_MESH_INFO, 1);
+
+	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, state->mesh_ifindex);
+
+	nl_send_auto_complete(sock, msg);
+
+	nlmsg_free(msg);
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb)
+		goto err_free_sock;
+
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, meshinfo_callback, &opts);
+	nl_cb_err(cb, NL_CB_CUSTOM, netlink_print_error, NULL);
+
+	nl_recvmsgs(sock, cb);
+
+err_free_sock:
+	nl_socket_free(sock);
+
+	return 0;
+}
+
+static struct debug_table_data batctl_debug_json_meshinfo = {
+	.netlink_fn = netlink_print_meshinfo_json,
+};
+
+COMMAND_NAMED(DEBUGJSON, meshinfo_json, "mij", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_json_meshinfo, "");
diff --git a/neighbors_json.c b/neighbors_json.c
new file mode 100644
index 0000000..5182e47
--- /dev/null
+++ b/neighbors_json.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Andrew Lunn <andrew@lunn.ch>
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
+#include "batadv_packet.h"
+#include "batman_adv.h"
+#include "bat-hosts.h"
+#include "debug.h"
+#include "functions.h"
+#include "main.h"
+#include "netlink.h"
+
+static const int neighbors_mandatory[] = {
+	BATADV_ATTR_NEIGH_ADDRESS,
+	BATADV_ATTR_HARD_IFINDEX,
+	BATADV_ATTR_LAST_SEEN_MSECS,
+};
+
+static int neighbors_json_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct genlmsghdr *ghdr;
+	int selected_attrs[4] = { BATADV_ATTR_NEIGH_ADDRESS,
+				  BATADV_ATTR_HARD_IFINDEX,
+				  BATADV_ATTR_LAST_SEEN_MSECS,
+				  BATADV_ATTR_THROUGHPUT };
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
+	if (missing_mandatory_attrs(attrs, neighbors_mandatory,
+				    ARRAY_SIZE(neighbors_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	netlink_print_json_entries(attrs, selected_attrs,
+				   ARRAY_SIZE(selected_attrs), opts);
+	opts->is_first = 0;
+
+	return NL_OK;
+}
+
+static int netlink_print_neighbors_json(struct state *state, char *orig_iface,
+					int read_opts, float orig_timeout,
+					float watch_interval)
+{
+	return netlink_print_common(state, orig_iface, read_opts,
+				    orig_timeout, watch_interval, NULL,
+				    BATADV_CMD_GET_NEIGHBORS,
+				    neighbors_json_callback, true);
+}
+
+static struct debug_table_data batctl_debug_json_neighbors = {
+	.netlink_fn = netlink_print_neighbors_json,
+};
+
+COMMAND_NAMED(DEBUGJSON, neighbors_json, "nj", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_json_neighbors, "");
diff --git a/netlink.c b/netlink.c
index 26ae5ef..db44d82 100644
--- a/netlink.c
+++ b/netlink.c
@@ -363,17 +363,21 @@ static int info_callback(struct nl_msg *msg, void *arg)
 		else
 			extra_header = "";
 
-		ret = asprintf(&opts->remaining_header,
-			       "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%02x:%02x:%02x:%02x:%02x:%02x (%s/%02x:%02x:%02x:%02x:%02x:%02x %s)%s]\n%s",
-			       version, primary_if,
-			       primary_mac[0], primary_mac[1], primary_mac[2],
-			       primary_mac[3], primary_mac[4], primary_mac[5],
-			       mesh_name,
-			       mesh_mac[0], mesh_mac[1], mesh_mac[2],
-			       mesh_mac[3], mesh_mac[4], mesh_mac[5],
-			       algo_name, extra_info, extra_header);
-		if (ret < 0)
-			opts->remaining_header = NULL;
+		if (!opts->is_json) {
+			ret = asprintf(&opts->remaining_header,
+				       "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%02x:%02x:%02x:%02x:%02x:%02x (%s/%02x:%02x:%02x:%02x:%02x:%02x %s)%s]\n%s",
+				       version, primary_if,
+				       primary_mac[0], primary_mac[1],
+				       primary_mac[2], primary_mac[3],
+				       primary_mac[4], primary_mac[5],
+				       mesh_name,
+				       mesh_mac[0], mesh_mac[1], mesh_mac[2],
+				       mesh_mac[3], mesh_mac[4], mesh_mac[5],
+				       algo_name, extra_info, extra_header);
+
+			if (ret < 0)
+				opts->remaining_header = NULL;
+		}
 
 		if (extra_info)
 			free(extra_info);
@@ -387,7 +391,8 @@ static int info_callback(struct nl_msg *msg, void *arg)
 	return NL_STOP;
 }
 
-char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
+char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header,
+		       uint8_t is_json)
 {
 	struct nl_sock *sock;
 	struct nl_msg *msg;
@@ -398,6 +403,7 @@ char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
 		.nl_cmd = nl_cmd,
 		.remaining_header = NULL,
 		.static_header = header,
+		.is_json = is_json,
 	};
 
 	sock = nl_socket_alloc();
@@ -494,6 +500,9 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 		}
 	}
 
+	if (is_json)
+		printf("[");
+
 	bat_hosts_init(read_opt);
 
 	nl_cb_set(state->cb, NL_CB_VALID, NL_CB_CUSTOM, netlink_print_common_cb, &opts);
@@ -508,7 +517,8 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 		if (!(read_opt & SKIP_HEADER))
 			opts.remaining_header = netlink_get_info(state->mesh_ifindex,
 								 nl_cmd,
-								 header);
+								 header,
+								 is_json);
 
 		msg = nlmsg_alloc();
 		if (!msg)
@@ -529,6 +539,9 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 		last_err = 0;
 		nl_recvmsgs(state->sock, state->cb);
 
+		if (is_json)
+			printf("]");
+
 		/* the header should still be printed when no entry was received */
 		if (!last_err)
 			netlink_print_remaining_header(&opts);
diff --git a/netlink.h b/netlink.h
index c766741..47390fc 100644
--- a/netlink.h
+++ b/netlink.h
@@ -44,7 +44,7 @@ struct ether_addr;
 int netlink_create(struct state *state);
 void netlink_destroy(struct state *state);
 
-char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header);
+char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header, uint8_t is_json);
 int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
 			  struct ether_addr *mac_out);
 int get_nexthop_netlink(const char *mesh_iface, const struct ether_addr *mac,
diff --git a/originators.c b/originators.c
index 674656c..c3af740 100644
--- a/originators.c
+++ b/originators.c
@@ -175,7 +175,7 @@ static int netlink_print_originators(struct state *state, char *orig_iface,
 	/* only parse routing algorithm name */
 	last_err = -EINVAL;
 	info_header = netlink_get_info(state->mesh_ifindex,
-				       BATADV_CMD_GET_ORIGINATORS, NULL);
+				       BATADV_CMD_GET_ORIGINATORS, NULL, 0);
 	free(info_header);
 
 	if (strlen(algo_name_buf) == 0)
diff --git a/originators_json.c b/originators_json.c
new file mode 100644
index 0000000..91dcb44
--- /dev/null
+++ b/originators_json.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ * Sven Eckelmann <sven@narfation.org>
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
+#include "batadv_packet.h"
+#include "batman_adv.h"
+#include "bat-hosts.h"
+#include "debug.h"
+#include "functions.h"
+#include "main.h"
+#include "netlink.h"
+
+static const int originators_mandatory[] = {
+	BATADV_ATTR_ORIG_ADDRESS,
+	BATADV_ATTR_NEIGH_ADDRESS,
+	BATADV_ATTR_HARD_IFINDEX,
+	BATADV_ATTR_LAST_SEEN_MSECS,
+};
+
+static int originators_json_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	int last_seen_msecs;
+	struct print_opts *opts = arg;
+	struct genlmsghdr *ghdr;
+	float last_seen;
+	int selected_attrs[6] = { BATADV_ATTR_ORIG_ADDRESS,
+				  BATADV_ATTR_NEIGH_ADDRESS,
+				  BATADV_ATTR_HARD_IFINDEX,
+				  BATADV_ATTR_LAST_SEEN_MSECS,
+				  BATADV_ATTR_THROUGHPUT,
+				  BATADV_ATTR_TQ };
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
+	if (missing_mandatory_attrs(attrs, originators_mandatory,
+				       ARRAY_SIZE(originators_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+	last_seen = (float)last_seen_msecs / 1000.0;
+
+	/* skip timed out originators */
+	if (opts->read_opt & NO_OLD_ORIGS)
+		if (last_seen > opts->orig_timeout)
+			return NL_OK;
+
+	netlink_print_json_entries(attrs, selected_attrs,
+				   ARRAY_SIZE(selected_attrs), opts);
+	opts->is_first = 0;
+
+	return NL_OK;
+}
+
+static int netlink_print_originators_json(struct state *state, char *orig_iface,
+					  int read_opts, float orig_timeout,
+					  float watch_interval)
+{
+	return netlink_print_common(state, orig_iface, read_opts,
+				    orig_timeout, watch_interval, NULL,
+				    BATADV_CMD_GET_ORIGINATORS,
+				    originators_json_callback, 1);
+}
+
+static struct debug_table_data batctl_debug_json_originators = {
+	.netlink_fn = netlink_print_originators_json,
+	.option_timeout_interval = 1,
+	.option_orig_iface = 1,
+};
+
+COMMAND_NAMED(DEBUGJSON, originators_json, "oj", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_json_originators, "");
diff --git a/transglobal_json.c b/transglobal_json.c
new file mode 100644
index 0000000..faff8ec
--- /dev/null
+++ b/transglobal_json.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Andrew Lunn <andrew(a)lunn.ch&gt;
+ * Sven Eckelmann <sven(a)narfation.org&gt;
+ * Alexander Sarmanow <asarmanow(a)gmail.com&gt;
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
+#include "batadv_packet.h"
+#include "batman_adv.h"
+#include "bat-hosts.h"
+#include "debug.h"
+#include "functions.h"
+#include "main.h"
+#include "netlink.h"
+
+static const int transglobal_mandatory[] = {
+	BATADV_ATTR_TT_ADDRESS,
+	BATADV_ATTR_ORIG_ADDRESS,
+	BATADV_ATTR_TT_VID,
+	BATADV_ATTR_TT_TTVN,
+	BATADV_ATTR_TT_LAST_TTVN,
+	BATADV_ATTR_TT_CRC32,
+	BATADV_ATTR_TT_FLAGS,
+};
+
+static int transglobal_json_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct genlmsghdr *ghdr;
+	uint8_t *addr;
+	int selected_attrs[8] = { BATADV_ATTR_TT_ADDRESS,
+				  BATADV_ATTR_ORIG_ADDRESS,
+			      	  BATADV_ATTR_TT_VID,
+			      	  BATADV_ATTR_TT_TTVN,
+			      	  BATADV_ATTR_TT_LAST_TTVN,
+			      	  BATADV_ATTR_TT_CRC32,
+			      	  BATADV_ATTR_TT_FLAGS,
+			      	  BATADV_ATTR_FLAG_BEST };
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
+	if (missing_mandatory_attrs(attrs, transglobal_mandatory,
+				    ARRAY_SIZE(transglobal_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	addr = nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
+
+	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
+		return NL_OK;
+
+	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
+		return NL_OK;
+
+	netlink_print_json_entries(attrs, selected_attrs,
+				   ARRAY_SIZE(selected_attrs), opts);
+	opts->is_first = 0;
+
+
+	return NL_OK;
+}
+
+static int netlink_print_transglobal_json(struct state *state, char *orig_iface,
+					  int read_opts, float orig_timeout,
+					  float watch_interval)
+{
+	return netlink_print_common(state, orig_iface, read_opts,
+				    orig_timeout, watch_interval, NULL,
+				    BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+				    transglobal_json_callback, true);
+}
+
+static struct debug_table_data batctl_debug_json_transglobal = {
+	.netlink_fn = netlink_print_transglobal_json,
+	.option_unicast_only = 1,
+	.option_multicast_only = 1,
+};
+
+COMMAND_NAMED(DEBUGJSON, transglobal_json, "tgj", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_json_transglobal, "");
diff --git a/translocal_json.c b/translocal_json.c
new file mode 100644
index 0000000..e78150e
--- /dev/null
+++ b/translocal_json.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Andrew Lunn <andrew@lunn.ch>
+ * Sven Eckelmann <sven@narfation.org>
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
+#include "batadv_packet.h"
+#include "batman_adv.h"
+#include "bat-hosts.h"
+#include "debug.h"
+#include "functions.h"
+#include "main.h"
+#include "netlink.h"
+
+static const int translocal_mandatory[] = {
+	BATADV_ATTR_TT_ADDRESS,
+	BATADV_ATTR_TT_VID,
+	BATADV_ATTR_TT_CRC32,
+	BATADV_ATTR_TT_FLAGS,
+};
+
+static int translocal_json_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct genlmsghdr *ghdr;
+	uint8_t *addr;
+	int selected_attrs[5] = { BATADV_ATTR_TT_ADDRESS,
+				  BATADV_ATTR_TT_VID,
+				  BATADV_ATTR_TT_CRC32,
+				  BATADV_ATTR_TT_FLAGS,
+				  BATADV_ATTR_LAST_SEEN_MSECS };
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
+	if (missing_mandatory_attrs(attrs, translocal_mandatory,
+				    ARRAY_SIZE(translocal_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	addr = nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
+
+	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
+		return NL_OK;
+
+	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
+		return NL_OK;
+
+	netlink_print_json_entries(attrs, selected_attrs,
+				   ARRAY_SIZE(selected_attrs), opts);
+	opts->is_first = 0;
+
+	return NL_OK;
+}
+
+static int netlink_print_translocal_json(struct state *state, char *orig_iface,
+					 int read_opts, float orig_timeout,
+					 float watch_interval)
+{
+	return netlink_print_common(state, orig_iface, read_opts,
+				    orig_timeout, watch_interval, NULL,
+				    BATADV_CMD_GET_TRANSTABLE_LOCAL,
+				    translocal_json_callback, 1);
+}
+
+static struct debug_table_data batctl_debug_json_translocal = {
+	.netlink_fn = netlink_print_translocal_json,
+	.option_unicast_only = 1,
+	.option_multicast_only = 1,
+};
+
+COMMAND_NAMED(DEBUGJSON, translocal_json, "tlj", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_json_translocal, "");
-- 
2.25.1

