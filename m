Return-Path: <asarmanow@gmail.com>
From: Alexander Sarmanow <asarmanow@gmail.com>
Subject: [PATCH] batctl: Add JSON debug support
Date: Wed, 28 Apr 2021 12:16:08 +0200
Message-Id: <20210428101608.3944861-1-asarmanow@gmail.com>
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

A JSON output of the debug tables is still missing. Corresponding JSON
output is added for originators, neighbors, translocal, transglobal and
interfaces tables. Same parameters of the debug tables can be used for
the JSON, except the "-w [interval]" (not useful). The table header is
implemented as a JSON equivalent and can be also optionally omitted.

Signed-off-by: Alexander Sarmanow <asarmanow@gmail.com>
---
 Makefile           |   5 ++
 backbonetable.c    |   2 +-
 claimtable.c       |   2 +-
 dat_cache.c        |   2 +-
 debug.c            |  15 +++-
 gateways.c         |   4 +-
 interfaces_json.c  | 167 +++++++++++++++++++++++++++++++++++++++++++++
 main.c             |  14 ++--
 main.h             |   3 +
 mcast_flags.c      |   4 +-
 neighbors.c        |   2 +-
 neighbors_json.c   | 109 +++++++++++++++++++++++++++++
 netlink.c          |  70 +++++++++++++++----
 netlink.h          |   9 ++-
 originators.c      |   4 +-
 originators_json.c | 154 +++++++++++++++++++++++++++++++++++++++++
 transglobal.c      |   2 +-
 transglobal_json.c | 146 +++++++++++++++++++++++++++++++++++++++
 translocal.c       |   2 +-
 translocal_json.c  | 139 +++++++++++++++++++++++++++++++++++++
 20 files changed, 823 insertions(+), 32 deletions(-)
 create mode 100644 interfaces_json.c
 create mode 100644 neighbors_json.c
 create mode 100644 originators_json.c
 create mode 100644 transglobal_json.c
 create mode 100644 translocal_json.c

diff --git a/Makefile b/Makefile
index 98bf695..84c5de6 100755
--- a/Makefile
+++ b/Makefile
@@ -71,6 +71,11 @@ $(eval $(call add_command,traceroute,y))
 $(eval $(call add_command,transglobal,y))
 $(eval $(call add_command,translate,y))
 $(eval $(call add_command,translocal,y))
+$(eval $(call add_command,originators_json,y))
+$(eval $(call add_command,neighbors_json,y))
+$(eval $(call add_command,translocal_json,y))
+$(eval $(call add_command,transglobal_json,y))
+$(eval $(call add_command,interfaces_json,y))
 
 MANPAGE = man/batctl.8
 
diff --git a/backbonetable.c b/backbonetable.c
index 17fbd1d..714ae55 100644
--- a/backbonetable.c
+++ b/backbonetable.c
@@ -98,7 +98,7 @@ static int netlink_print_bla_backbone(struct state *state, char *orig_iface,
 				    orig_timeout, watch_interval,
 				    "Originator           VID   last seen (CRC   )\n",
 				    BATADV_CMD_GET_BLA_BACKBONE,
-				    bla_backbone_callback);
+				    bla_backbone_callback, false);
 }
 
 static struct debug_table_data batctl_debug_table_backbonetable = {
diff --git a/claimtable.c b/claimtable.c
index b6bf9f5..a1c3868 100644
--- a/claimtable.c
+++ b/claimtable.c
@@ -103,7 +103,7 @@ static int netlink_print_bla_claim(struct state *state, char *orig_iface,
 				    orig_timeout, watch_interval,
 				    "Client               VID      Originator        [o] (CRC   )\n",
 				    BATADV_CMD_GET_BLA_CLAIM,
-				    bla_claim_callback);
+				    bla_claim_callback, false);
 }
 
 static struct debug_table_data batctl_debug_table_claimtable = {
diff --git a/dat_cache.c b/dat_cache.c
index 8d47171..15a212b 100644
--- a/dat_cache.c
+++ b/dat_cache.c
@@ -116,7 +116,7 @@ static int netlink_print_dat_cache(struct state *state, char *orig_iface,
 	ret = netlink_print_common(state, orig_iface, read_opts,
 				   orig_timeout, watch_interval, header,
 				   BATADV_CMD_GET_DAT_CACHE,
-				   dat_cache_callback);
+				   dat_cache_callback, false);
 
 	free(header);
 	return ret;
diff --git a/debug.c b/debug.c
index 458c137..5d5024e 100644
--- a/debug.c
+++ b/debug.c
@@ -27,7 +27,9 @@ static void debug_table_usage(struct state *state)
 	fprintf(stderr, " \t -h print this help\n");
 	fprintf(stderr, " \t -n don't replace mac addresses with bat-host names\n");
 	fprintf(stderr, " \t -H don't show the header\n");
-	fprintf(stderr, " \t -w [interval] watch mode - refresh the table continuously\n");
+
+	if (state->cmd->type != DEBUGJSON)
+		fprintf(stderr, " \t -w [interval] watch mode - refresh the table continuously\n");
 
 	if (debug_table->option_timeout_interval)
 		fprintf(stderr, " \t -t timeout interval - don't print originators not seen for x.y seconds \n");
@@ -60,6 +62,12 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			read_opt &= ~USE_BAT_HOSTS;
 			break;
 		case 'w':
+			if (state->cmd->type == DEBUGJSON) {
+				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
+				debug_table_usage(state);
+				return EXIT_FAILURE;
+			}
+
 			read_opt |= CLR_CONT_READ;
 			if (optarg[0] == '-') {
 				optind--;
@@ -123,6 +131,11 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			} else if (optopt == 'i') {
 				fprintf(stderr, "Error - option '-i' needs an interface as argument\n");
 			} else if (optopt == 'w') {
+				if (state->cmd->type == DEBUGJSON) {
+					fprintf(stderr, "Error - unrecognised option '-w'\n");
+					debug_table_usage(state);
+					return EXIT_FAILURE;
+				}
 				read_opt |= CLR_CONT_READ;
 				break;
 			}
diff --git a/gateways.c b/gateways.c
index 7625bd8..4bfa1ed 100644
--- a/gateways.c
+++ b/gateways.c
@@ -123,7 +123,7 @@ static int netlink_print_gateways(struct state *state, char *orig_iface,
 	/* only parse routing algorithm name */
 	last_err = -EINVAL;
 	info_header = netlink_get_info(state->mesh_ifindex,
-				       BATADV_CMD_GET_ORIGINATORS, NULL);
+				       BATADV_CMD_GET_ORIGINATORS, NULL, false);
 	free(info_header);
 
 	if (strlen(algo_name_buf) == 0)
@@ -141,7 +141,7 @@ static int netlink_print_gateways(struct state *state, char *orig_iface,
 				    orig_timeout, watch_interval,
 				    header,
 				    BATADV_CMD_GET_GATEWAYS,
-				    gateways_callback);
+				    gateways_callback, false);
 }
 
 static struct debug_table_data batctl_debug_table_gateways = {
diff --git a/interfaces_json.c b/interfaces_json.c
new file mode 100644
index 0000000..65cde95
--- /dev/null
+++ b/interfaces_json.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <mareklindner@neomailbox.ch>
+ * Alexander Sarmanow <asarmanow@gmail.com>
+ *
+ * License-Filename: LICENSES/preferred/GPL-2.0
+ */
+
+#include <unistd.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <dirent.h>
+#include <net/if.h>
+#include <linux/if_link.h>
+#include <linux/rtnetlink.h>
+#include <netlink/netlink.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+
+#include "main.h"
+#include "sys.h"
+#include "functions.h"
+#include "debug.h"
+
+#define IFACE_STATUS_LEN 256
+
+static int get_iface_status_netlink_parse(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[NUM_BATADV_ATTR];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	char *iface_status = arg;
+	struct genlmsghdr *ghdr;
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+	if (ghdr->cmd != BATADV_CMD_GET_HARDIF)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy))
+		return NL_OK;
+
+	if (attrs[BATADV_ATTR_ACTIVE])
+		strncpy(iface_status, "active", IFACE_STATUS_LEN);
+	else
+		strncpy(iface_status, "inactive", IFACE_STATUS_LEN);
+
+	iface_status[IFACE_STATUS_LEN - 1] = '\0';
+
+	return NL_STOP;
+}
+
+static char *get_iface_status_netlink(unsigned int meshif, unsigned int hardif,
+				      char *iface_status)
+{
+	char *ret_status = NULL;
+	struct nl_sock *sock;
+	struct nl_msg *msg;
+	int batadv_family;
+	struct nl_cb *cb;
+	int ret;
+
+	iface_status[0] = '\0';
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		return NULL;
+
+	ret = genl_connect(sock);
+	if (ret < 0)
+		goto err_free_sock;
+
+	batadv_family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
+	if (batadv_family < 0)
+		goto err_free_sock;
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb)
+		goto err_free_sock;
+
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, get_iface_status_netlink_parse,
+		iface_status);
+
+	msg = nlmsg_alloc();
+	if (!msg)
+		goto err_free_cb;
+
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, batadv_family,
+		    0, 0, BATADV_CMD_GET_HARDIF, 1);
+
+	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, meshif);
+	nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, hardif);
+
+	ret = nl_send_auto_complete(sock, msg);
+	if (ret < 0)
+		goto err_free_msg;
+
+	nl_recvmsgs(sock, cb);
+
+	if (strlen(iface_status) > 0)
+		ret_status = iface_status;
+
+err_free_msg:
+	nlmsg_free(msg);
+err_free_cb:
+	nl_cb_put(cb);
+err_free_sock:
+	nl_socket_free(sock);
+
+	return ret_status;
+}
+
+static int interfaces_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct genlmsghdr *ghdr;
+	char iface_status[IFACE_STATUS_LEN];
+	const char *status;
+	char *ifname;
+	int ifindex;
+	int master;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+	    genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ifname = nla_data(attrs[BATADV_ATTR_HARD_IFNAME]);
+	master = nla_get_u32(attrs[BATADV_ATTR_MESH_IFINDEX]);
+	ifindex = nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]);
+
+	status = get_iface_status_netlink(master, ifindex, iface_status);
+	if (!status)
+		status = "<error reading status>\n";
+
+	printf("{\"%s\":\"%s\"}", ifname, status);
+
+	return NL_OK;
+}
+
+static int netlink_print_interfaces_json(struct state *state, char *orig_iface,
+					 int read_opts, float orig_timeout,
+					 float watch_interval)
+{
+	return netlink_print_common(state, orig_iface, read_opts, orig_timeout,
+				    watch_interval, NULL, BATADV_CMD_GET_HARDIF,
+				    interfaces_callback, true);
+}
+
+static struct debug_table_data batctl_debug_table_interfaces = {
+	.netlink_fn = netlink_print_interfaces_json,
+};
+
+COMMAND_NAMED(DEBUGJSON, interfaces_json, "ifj", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_interfaces, "");
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
index 81b7a27..2efd136 100644
--- a/main.h
+++ b/main.h
@@ -44,6 +44,8 @@ extern char module_ver_path[];
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
 
+#define BOOL_STRING(x) (x ? "true" : "false")
+
 #ifndef container_of
 #define container_of(ptr, type, member) __extension__ ({ \
 	const __typeof__(((type *)0)->member) *__pmember = (ptr); \
@@ -69,6 +71,7 @@ enum command_type {
 	SUBCOMMAND_VID,
 	SUBCOMMAND_HIF,
 	DEBUGTABLE,
+	DEBUGJSON,
 };
 
 struct state {
diff --git a/mcast_flags.c b/mcast_flags.c
index 721f549..6fc2780 100644
--- a/mcast_flags.c
+++ b/mcast_flags.c
@@ -105,7 +105,7 @@ static int netlink_print_mcast_flags(struct state *state, char *orig_iface,
 
 	/* only parse own multicast flags */
 	info_header = netlink_get_info(state->mesh_ifindex,
-				       BATADV_CMD_GET_MCAST_FLAGS, NULL);
+				       BATADV_CMD_GET_MCAST_FLAGS, NULL, false);
 	free(info_header);
 
 	if (mcast_flags == -EOPNOTSUPP || mcast_flags_priv == -EOPNOTSUPP)
@@ -147,7 +147,7 @@ static int netlink_print_mcast_flags(struct state *state, char *orig_iface,
 	ret = netlink_print_common(state, orig_iface, read_opts,
 				   orig_timeout, watch_interval, header,
 				   BATADV_CMD_GET_MCAST_FLAGS,
-				   mcast_flags_callback);
+				   mcast_flags_callback, false);
 
 	free(header);
 	return ret;
diff --git a/neighbors.c b/neighbors.c
index af76d0f..a54045b 100644
--- a/neighbors.c
+++ b/neighbors.c
@@ -114,7 +114,7 @@ static int netlink_print_neighbors(struct state *state, char *orig_iface,
 				    orig_timeout, watch_interval,
 				    "IF             Neighbor              last-seen\n",
 				    BATADV_CMD_GET_NEIGHBORS,
-				    neighbors_callback);
+				    neighbors_callback, false);
 }
 
 static struct debug_table_data batctl_debug_table_neighbors = {
diff --git a/neighbors_json.c b/neighbors_json.c
new file mode 100644
index 0000000..d89dc7a
--- /dev/null
+++ b/neighbors_json.c
@@ -0,0 +1,109 @@
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
+static int neighbors_callback(struct nl_msg *msg, void *arg)
+{
+	unsigned throughput_kbits;
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	int last_seen_msecs;
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	char ifname[IF_NAMESIZE];
+	struct genlmsghdr *ghdr;
+	uint8_t *neigh;
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
+	neigh = nla_data(attrs[BATADV_ATTR_NEIGH_ADDRESS]);
+	bat_host = bat_hosts_find_by_mac((char *)neigh);
+
+	if (!if_indextoname(nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]),
+			    ifname))
+		ifname[0] = '\0';
+
+	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("{\"neighbor\":\"%02x:%02x:%02x:%02x:%02x:%02x\",",
+			neigh[0], neigh[1], neigh[2],
+			neigh[3], neigh[4], neigh[5]);
+	else
+		printf("{\"neighbor\":\"%s\",", bat_host->name);
+
+	if (attrs[BATADV_ATTR_THROUGHPUT]) {
+		throughput_kbits = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);
+		printf("\"throughput_kbits\":%u,", throughput_kbits);
+	}
+
+	printf("\"last_seen\":%d,\"ifname\":\"%s\"}", last_seen_msecs, ifname);
+
+	return NL_OK;
+}
+
+static int netlink_print_neighbors_json(struct state *state, char *orig_iface,
+				   int read_opts, float orig_timeout,
+				   float watch_interval)
+{
+	return netlink_print_common(state, orig_iface, read_opts,
+				    orig_timeout, watch_interval, NULL,
+				    BATADV_CMD_GET_NEIGHBORS,
+				    neighbors_callback, true);
+}
+
+static struct debug_table_data batctl_debug_table_neighbors = {
+	.netlink_fn = netlink_print_neighbors_json,
+};
+
+COMMAND_NAMED(DEBUGJSON, neighbors_json, "nj", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_neighbors, "");
diff --git a/netlink.c b/netlink.c
index 31c9b01..f42643e 100644
--- a/netlink.c
+++ b/netlink.c
@@ -318,15 +318,29 @@ static int info_callback(struct nl_msg *msg, void *arg)
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
+		if (opts->is_json) {
+			ret = asprintf(&opts->remaining_header,
+				       "{\"version\":\"%s\",\"main_if\":\"%s\",\"main_mac\":\"%02x:%02x:%02x:%02x:%02x:%02x\",\"mesh_if\":\"%s\",\"mesh_mac\":\"%02x:%02x:%02x:%02x:%02x:%02x\",\"algo_name\":\"%s\",\"extra_info\":\"%s\",\"data\":[",
+				       version, primary_if,
+				       primary_mac[0], primary_mac[1],
+				       primary_mac[2], primary_mac[3],
+				       primary_mac[4], primary_mac[5],
+				       mesh_name,
+				       mesh_mac[0], mesh_mac[1], mesh_mac[2],
+				       mesh_mac[3], mesh_mac[4], mesh_mac[5],
+				       algo_name, extra_info);
+		} else {
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
+		}
 		if (ret < 0)
 			opts->remaining_header = NULL;
 
@@ -342,7 +356,8 @@ static int info_callback(struct nl_msg *msg, void *arg)
 	return NL_STOP;
 }
 
-char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
+char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header,
+		       bool is_json)
 {
 	struct nl_sock *sock;
 	struct nl_msg *msg;
@@ -353,6 +368,7 @@ char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
 		.nl_cmd = nl_cmd,
 		.remaining_header = NULL,
 		.static_header = header,
+		.is_json = is_json,
 	};
 
 	sock = nl_socket_alloc();
@@ -399,12 +415,34 @@ char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
 
 void netlink_print_remaining_header(struct print_opts *opts)
 {
-	if (!opts->remaining_header)
+	if (!opts->remaining_header) {
+		if (!opts->is_json)
+			return;
+
+		if (opts->is_first)
+			fputs("[", stdout);
+		if (opts->is_last) {
+			if (!(opts->read_opt & SKIP_HEADER))
+				fputs("]}\n", stdout);
+			else
+				fputs("]\n", stdout);
+		}
+		if (!opts->is_first && !opts->is_last)
+			fputs(",", stdout);
+
+		opts->is_first = false;
+
 		return;
+	}
 
 	fputs(opts->remaining_header, stdout);
 	free(opts->remaining_header);
 	opts->remaining_header = NULL;
+
+	opts->is_first = false;
+
+	if (opts->is_last && opts->is_json)
+		fputs("]}\n", stdout);
 }
 
 int netlink_print_common_cb(struct nl_msg *msg, void *arg)
@@ -419,7 +457,7 @@ int netlink_print_common_cb(struct nl_msg *msg, void *arg)
 int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 			 float orig_timeout, float watch_interval,
 			 const char *header, uint8_t nl_cmd,
-			 nl_recvmsg_msg_cb_t callback)
+			 nl_recvmsg_msg_cb_t callback, bool is_json)
 {
 	struct print_opts opts = {
 		.read_opt = read_opt,
@@ -427,6 +465,9 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 		.watch_interval = watch_interval,
 		.remaining_header = NULL,
 		.callback = callback,
+		.is_json = is_json,
+		.is_first = true,
+		.is_last = false,
 	};
 	int hardifindex = 0;
 	struct nl_msg *msg;
@@ -460,7 +501,8 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 		if (!(read_opt & SKIP_HEADER))
 			opts.remaining_header = netlink_get_info(state->mesh_ifindex,
 								 nl_cmd,
-								 header);
+								 header,
+								 is_json);
 
 		msg = nlmsg_alloc();
 		if (!msg)
@@ -481,6 +523,8 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 		last_err = 0;
 		nl_recvmsgs(state->sock, state->cb);
 
+		opts.is_last = true;
+
 		/* the header should still be printed when no entry was received */
 		if (!last_err)
 			netlink_print_remaining_header(&opts);
diff --git a/netlink.h b/netlink.h
index 4ee2f39..b7adade 100644
--- a/netlink.h
+++ b/netlink.h
@@ -12,6 +12,7 @@
 #include <netlink/genl/genl.h>
 #include <netlink/genl/ctrl.h>
 #include <stdint.h>
+#include <stdbool.h>
 
 struct state;
 
@@ -21,8 +22,12 @@ struct print_opts {
 	float watch_interval;
 	nl_recvmsg_msg_cb_t callback;
 	char *remaining_header;
+	char *remaining_entry;
 	const char *static_header;
 	uint8_t nl_cmd;
+	bool is_json;
+	bool is_first;
+	bool is_last;
 };
 
 struct ether_addr;
@@ -30,7 +35,7 @@ struct ether_addr;
 int netlink_create(struct state *state);
 void netlink_destroy(struct state *state);
 
-char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header);
+char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header, bool is_json);
 int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
 			  struct ether_addr *mac_out);
 int get_nexthop_netlink(const char *mesh_iface, const struct ether_addr *mac,
@@ -46,7 +51,7 @@ int missing_mandatory_attrs(struct nlattr *attrs[], const int mandatory[],
 int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 			 float orig_timeout, float watch_interval,
 			 const char *header, uint8_t nl_cmd,
-			 nl_recvmsg_msg_cb_t callback);
+			 nl_recvmsg_msg_cb_t callback, bool is_json);
 
 int netlink_print_common_cb(struct nl_msg *msg, void *arg);
 int netlink_stop_callback(struct nl_msg *msg, void *arg);
diff --git a/originators.c b/originators.c
index 8a29dd7..4acf2d0 100644
--- a/originators.c
+++ b/originators.c
@@ -175,7 +175,7 @@ static int netlink_print_originators(struct state *state, char *orig_iface,
 	/* only parse routing algorithm name */
 	last_err = -EINVAL;
 	info_header = netlink_get_info(state->mesh_ifindex,
-				       BATADV_CMD_GET_ORIGINATORS, NULL);
+				       BATADV_CMD_GET_ORIGINATORS, NULL, false);
 	free(info_header);
 
 	if (strlen(algo_name_buf) == 0)
@@ -192,7 +192,7 @@ static int netlink_print_originators(struct state *state, char *orig_iface,
 	return netlink_print_common(state, orig_iface, read_opts,
 				    orig_timeout, watch_interval, header,
 				    BATADV_CMD_GET_ORIGINATORS,
-				    originators_callback);
+				    originators_callback, false);
 }
 
 static struct debug_table_data batctl_debug_table_originators = {
diff --git a/originators_json.c b/originators_json.c
new file mode 100644
index 0000000..d0caec3
--- /dev/null
+++ b/originators_json.c
@@ -0,0 +1,154 @@
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
+static int originators_callback(struct nl_msg *msg, void *arg)
+{
+	unsigned throughput_kbits;
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	int last_seen_msecs;
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	char ifname[IF_NAMESIZE];
+	float last_seen;
+	uint8_t *neigh;
+	uint8_t *orig;
+	bool c = false;
+	uint8_t tq;
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
+	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
+	neigh = nla_data(attrs[BATADV_ATTR_NEIGH_ADDRESS]);
+
+	if (!if_indextoname(nla_get_u32(attrs[BATADV_ATTR_HARD_IFINDEX]),
+			    ifname))
+		ifname[0] = '\0';
+
+	if (attrs[BATADV_ATTR_FLAG_BEST])
+		c = true;
+
+	last_seen_msecs = nla_get_u32(attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+	last_seen = (float)last_seen_msecs / 1000.0;
+
+	/* skip timed out originators */
+	if (opts->read_opt & NO_OLD_ORIGS)
+		if (last_seen > opts->orig_timeout)
+			return NL_OK;
+
+	printf("{\"best\":%s,", BOOL_STRING(c));
+
+	if (!(opts->read_opt & USE_BAT_HOSTS)) {
+		printf("\"originator\":\"%02x:%02x:%02x:%02x:%02x:%02x\",",
+			orig[0], orig[1], orig[2],
+			orig[3], orig[4], orig[5]);
+		printf("\"next_hop\":\"%02x:%02x:%02x:%02x:%02x:%02x\",",
+			neigh[0], neigh[1], neigh[2],
+			neigh[3], neigh[4], neigh[5]);
+	} else {
+		bat_host = bat_hosts_find_by_mac((char *)orig);
+		if (bat_host) {
+			printf("\"originator\":\"%s\",",
+				bat_host->name);
+		} else {
+			printf("\"originator\":\"%02x:%02x:%02x:%02x:%02x:%02x\",",
+				orig[0], orig[1], orig[2],
+				orig[3], orig[4], orig[5]);
+		}
+		bat_host = bat_hosts_find_by_mac((char *)neigh);
+		if (bat_host)
+			printf("\"next_hop\":\"%s\",",
+				bat_host->name);
+		else
+			printf("\"next_hop\":\"%02x:%02x:%02x:%02x:%02x:%02x\",",
+				neigh[0], neigh[1], neigh[2],
+				neigh[3], neigh[4], neigh[5]);
+	}
+	if (attrs[BATADV_ATTR_THROUGHPUT]) {
+		throughput_kbits = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);
+		printf("\"throughput_kbits\":%u,", throughput_kbits);
+	}
+	if (attrs[BATADV_ATTR_TQ]) {
+		tq = nla_get_u8(attrs[BATADV_ATTR_TQ]);
+		printf("\"tq\":%i,", tq);
+	}
+
+	printf("\"last_seen\":%d,\"outgoing_iface\":\"%s\"}",
+		last_seen_msecs, ifname);
+
+	return NL_OK;
+}
+
+static int netlink_print_originators_json(struct state *state, char *orig_iface,
+				     int read_opts, float orig_timeout,
+				     float watch_interval)
+{
+	return netlink_print_common(state, orig_iface, read_opts,
+				    orig_timeout, watch_interval, NULL,
+				    BATADV_CMD_GET_ORIGINATORS,
+				    originators_callback, true);
+}
+
+static struct debug_table_data batctl_debug_table_originators = {
+	.netlink_fn = netlink_print_originators_json,
+	.option_timeout_interval = 1,
+	.option_orig_iface = 1,
+};
+
+COMMAND_NAMED(DEBUGJSON, originators_json, "oj", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_originators, "");
diff --git a/transglobal.c b/transglobal.c
index 4eae95d..abe0339 100644
--- a/transglobal.c
+++ b/transglobal.c
@@ -132,7 +132,7 @@ static int netlink_print_transglobal(struct state *state, char *orig_iface,
 				    orig_timeout, watch_interval,
 				    "   Client             VID Flags Last ttvn     Via        ttvn  (CRC       )\n",
 				    BATADV_CMD_GET_TRANSTABLE_GLOBAL,
-				    transglobal_callback);
+				    transglobal_callback, false);
 }
 
 static struct debug_table_data batctl_debug_table_transglobal = {
diff --git a/transglobal_json.c b/transglobal_json.c
new file mode 100644
index 0000000..a687f57
--- /dev/null
+++ b/transglobal_json.c
@@ -0,0 +1,146 @@
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
+static int transglobal_callback(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	char c, r, w, i, t;
+	uint8_t last_ttvn;
+	uint32_t crc32;
+	uint32_t flags;
+	uint8_t *addr;
+	uint8_t *orig;
+	uint8_t ttvn;
+	int16_t vid;
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
+	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
+	vid = nla_get_u16(attrs[BATADV_ATTR_TT_VID]);
+	ttvn = nla_get_u8(attrs[BATADV_ATTR_TT_TTVN]);
+	last_ttvn = nla_get_u8(attrs[BATADV_ATTR_TT_LAST_TTVN]);
+	crc32 = nla_get_u32(attrs[BATADV_ATTR_TT_CRC32]);
+	flags = nla_get_u32(attrs[BATADV_ATTR_TT_FLAGS]);
+
+	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
+		return NL_OK;
+
+	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
+		return NL_OK;
+
+	c = false, r = false, w = false, i = false, t = false;
+	if (attrs[BATADV_ATTR_FLAG_BEST])
+		c = true;
+	if (flags & BATADV_TT_CLIENT_ROAM)
+		r = true;
+	if (flags & BATADV_TT_CLIENT_WIFI)
+		w = true;
+	if (flags & BATADV_TT_CLIENT_ISOLA)
+		i = true;
+	if (flags & BATADV_TT_CLIENT_TEMP)
+		t = true;
+
+	printf("{\"best\":%s,", BOOL_STRING(c));
+
+	bat_host = bat_hosts_find_by_mac((char *)addr);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("\"client\":\"%02x:%02x:%02x:%02x:%02x:%02x\",",
+		       addr[0], addr[1], addr[2],
+		       addr[3], addr[4], addr[5]);
+	else
+		printf("\"client\":\"%s\",", bat_host->name);
+
+	printf("\"vid\":%i,\"flag_r\":%s,\"flag_w\":%s,\"flag_i\":%s,\"flag_t\":%s,\"ttvn\":%u,",
+		BATADV_PRINT_VID(vid), BOOL_STRING(r), BOOL_STRING(w),
+		BOOL_STRING(i), BOOL_STRING(t), ttvn);
+
+	bat_host = bat_hosts_find_by_mac((char *)orig);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("\"orig\":\"%02x:%02x:%02x:%02x:%02x:%02x\",",
+		       orig[0], orig[1], orig[2],
+		       orig[3], orig[4], orig[5]);
+	else
+		printf("\"orig\":\"%s\",", bat_host->name);
+
+	printf("\"last_ttvn\":%u,\"crc\":\"0x%.8x\"}", last_ttvn, crc32);
+
+	return NL_OK;
+}
+
+static int netlink_print_transglobal_json(struct state *state, char *orig_iface,
+				     int read_opts, float orig_timeout,
+				     float watch_interval)
+{
+	return netlink_print_common(state, orig_iface, read_opts,
+				    orig_timeout, watch_interval, NULL,
+				    BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+				    transglobal_callback, true);
+}
+
+static struct debug_table_data batctl_debug_table_transglobal = {
+	.netlink_fn = netlink_print_transglobal_json,
+	.option_unicast_only = 1,
+	.option_multicast_only = 1,
+};
+
+COMMAND_NAMED(DEBUGJSON, transglobal_json, "tgj", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_transglobal, "");
diff --git a/translocal.c b/translocal.c
index a3ad3da..d72125c 100644
--- a/translocal.c
+++ b/translocal.c
@@ -128,7 +128,7 @@ static int netlink_print_translocal(struct state *state, char *orig_iface,
 				    orig_timeout, watch_interval,
 				    "Client             VID Flags    Last seen (CRC       )\n",
 				    BATADV_CMD_GET_TRANSTABLE_LOCAL,
-				    translocal_callback);
+				    translocal_callback, false);
 }
 
 static struct debug_table_data batctl_debug_table_translocal = {
diff --git a/translocal_json.c b/translocal_json.c
new file mode 100644
index 0000000..ad2ff46
--- /dev/null
+++ b/translocal_json.c
@@ -0,0 +1,139 @@
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
+static int translocal_callback(struct nl_msg *msg, void *arg)
+{
+	int last_seen_msecs = 0;
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct print_opts *opts = arg;
+	struct bat_host *bat_host;
+	struct genlmsghdr *ghdr;
+	char r, p, n, x, w, i;
+	uint8_t *addr;
+	int16_t vid;
+	uint32_t crc32;
+	uint32_t flags;
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
+	vid = nla_get_u16(attrs[BATADV_ATTR_TT_VID]);
+	crc32 = nla_get_u32(attrs[BATADV_ATTR_TT_CRC32]);
+	flags = nla_get_u32(attrs[BATADV_ATTR_TT_FLAGS]);
+	last_seen_msecs = 0;
+
+	if (opts->read_opt & MULTICAST_ONLY && !(addr[0] & 0x01))
+		return NL_OK;
+
+	if (opts->read_opt & UNICAST_ONLY && (addr[0] & 0x01))
+		return NL_OK;
+
+	r = false, p = false, n = false, x = false, w = false, i = false;
+	if (flags & BATADV_TT_CLIENT_ROAM)
+		r = true;
+	if (flags & BATADV_TT_CLIENT_NEW)
+		n = true;
+	if (flags & BATADV_TT_CLIENT_PENDING)
+		x = true;
+	if (flags & BATADV_TT_CLIENT_WIFI)
+		w = true;
+	if (flags & BATADV_TT_CLIENT_ISOLA)
+		i = true;
+
+	if (flags & BATADV_TT_CLIENT_NOPURGE)  {
+		p = true;
+	} else {
+		if (!attrs[BATADV_ATTR_LAST_SEEN_MSECS]) {
+			fputs("Received invalid data from kernel.\n", stderr);
+			exit(1);
+		}
+
+		last_seen_msecs = nla_get_u32(
+			attrs[BATADV_ATTR_LAST_SEEN_MSECS]);
+	}
+
+	bat_host = bat_hosts_find_by_mac((char *)addr);
+	if (!(opts->read_opt & USE_BAT_HOSTS) || !bat_host)
+		printf("{\"client\":\"%02x:%02x:%02x:%02x:%02x:%02x\",",
+			addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
+	else
+		printf("{\"client\":\"%s\",", bat_host->name);
+
+	printf("\"vid\":%i,\"flag_r\":%s,\"flag_n\":%s,\"flag_x\":%s,\"flag_w\":%s,\"flag_i\":%s,\"flag_p\":%s,\"last_seen\":%d,\"crc\":\"0x%.8x\"}",
+		BATADV_PRINT_VID(vid), BOOL_STRING(r), BOOL_STRING(n),
+		BOOL_STRING(x), BOOL_STRING(w), BOOL_STRING(i), BOOL_STRING(p),
+		last_seen_msecs, crc32);
+
+	return NL_OK;
+}
+
+static int netlink_print_translocal_json(struct state *state, char *orig_iface,
+				    int read_opts, float orig_timeout,
+				    float watch_interval)
+{
+	return netlink_print_common(state, orig_iface, read_opts,
+				    orig_timeout, watch_interval, NULL,
+				    BATADV_CMD_GET_TRANSTABLE_LOCAL,
+				    translocal_callback, true);
+}
+
+static struct debug_table_data batctl_debug_table_translocal = {
+	.netlink_fn = netlink_print_translocal_json,
+	.option_unicast_only = 1,
+	.option_multicast_only = 1,
+};
+
+COMMAND_NAMED(DEBUGJSON, translocal_json, "tlj", handle_debug_table,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_translocal, "");
-- 
2.25.1

