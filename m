Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:41 +0200
Message-Id: <20181025162245.19389-39-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 38/42] batctl: Use external netlink socket
 for debug tables
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

The netlink socket is used by the debug table functionality to retrieve the
tables. The initialization can be centralized and moved to the main
function (controlled by a flag) to share it between the other commands.

Since more commands will use netlink in the future, this flag can reduce
the implementation effort significantly.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 backbonetable.c |   7 ++--
 claimtable.c    |   7 ++--
 dat_cache.c     |   9 ++---
 debug.c         |   5 ++-
 debug.h         |   2 +-
 gateways.c      |  11 ++++---
 main.c          |  18 +++++++++-
 main.h          |   9 +++++
 mcast_flags.c   |  11 ++++---
 neighbors.c     |   7 ++--
 netlink.c       | 100 +++++++++++++++++++++++++++++++++++++-------------------
 netlink.h       |   7 +++-
 originators.c   |  11 ++++---
 transglobal.c   |   7 ++--
 translocal.c    |   7 ++--
 15 files changed, 145 insertions(+), 73 deletions(-)

diff --git a/backbonetable.c b/backbonetable.c
index d2e58d1..b82fbe7 100644
--- a/backbonetable.c
+++ b/backbonetable.c
@@ -104,11 +104,11 @@ static int bla_backbone_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int netlink_print_bla_backbone(char *mesh_iface, char *orig_iface,
+static int netlink_print_bla_backbone(struct state *state, char *orig_iface,
 				      int read_opts, float orig_timeout,
 				      float watch_interval)
 {
-	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+	return netlink_print_common(state, orig_iface, read_opts,
 				    orig_timeout, watch_interval,
 				    "Originator           VID   last seen (CRC   )\n",
 				    BATADV_CMD_GET_BLA_BACKBONE,
@@ -122,4 +122,5 @@ static struct debug_table_data batctl_debug_table_backbonetable = {
 };
 
 COMMAND_NAMED(DEBUGTABLE, backbonetable, "bbt", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_backbonetable, "");
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_backbonetable, "");
diff --git a/claimtable.c b/claimtable.c
index 06f42dc..5410392 100644
--- a/claimtable.c
+++ b/claimtable.c
@@ -109,11 +109,11 @@ static int bla_claim_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int netlink_print_bla_claim(char *mesh_iface, char *orig_iface,
+static int netlink_print_bla_claim(struct state *state, char *orig_iface,
 				   int read_opts, float orig_timeout,
 				   float watch_interval)
 {
-	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+	return netlink_print_common(state, orig_iface, read_opts,
 				    orig_timeout, watch_interval,
 				    "Client               VID      Originator        [o] (CRC   )\n",
 				    BATADV_CMD_GET_BLA_CLAIM,
@@ -127,4 +127,5 @@ static struct debug_table_data batctl_debug_table_claimtable = {
 };
 
 COMMAND_NAMED(DEBUGTABLE, claimtable, "cl", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_claimtable, "");
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_claimtable, "");
diff --git a/dat_cache.c b/dat_cache.c
index a56fb11..edf8c72 100644
--- a/dat_cache.c
+++ b/dat_cache.c
@@ -113,7 +113,7 @@ static int dat_cache_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int netlink_print_dat_cache(char *mesh_iface, char *orig_iface,
+static int netlink_print_dat_cache(struct state *state, char *orig_iface,
 				   int read_opts, float orig_timeout,
 				   float watch_interval)
 {
@@ -121,13 +121,13 @@ static int netlink_print_dat_cache(char *mesh_iface, char *orig_iface,
 	int ret;
 
 	ret = asprintf(&header, "Distributed ARP Table (%s):\n%s\n",
-		       mesh_iface,
+		       state->mesh_iface,
 		       "          IPv4             MAC        VID   last-seen");
 
 	if (ret < 0)
 		return ret;
 
-	ret = netlink_print_common(mesh_iface, orig_iface, read_opts,
+	ret = netlink_print_common(state, orig_iface, read_opts,
 				   orig_timeout, watch_interval, header,
 				   BATADV_CMD_GET_DAT_CACHE,
 				   dat_cache_callback);
@@ -143,4 +143,5 @@ static struct debug_table_data batctl_debug_table_dat_cache = {
 };
 
 COMMAND_NAMED(DEBUGTABLE, dat_cache, "dc", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_dat_cache, "");
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_dat_cache, "");
diff --git a/debug.c b/debug.c
index 17dde92..b908e00 100644
--- a/debug.c
+++ b/debug.c
@@ -168,9 +168,8 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 	}
 
 	if (debug_table->netlink_fn) {
-		err = debug_table->netlink_fn(
-			state->mesh_iface, orig_iface, read_opt, orig_timeout,
-			watch_interval);
+		err = debug_table->netlink_fn(state , orig_iface, read_opt,
+					      orig_timeout, watch_interval);
 		if (err != -EOPNOTSUPP)
 			return err;
 	}
diff --git a/debug.h b/debug.h
index 79c489a..525a46b 100644
--- a/debug.h
+++ b/debug.h
@@ -39,7 +39,7 @@
 struct debug_table_data {
 	const char *debugfs_name;
 	size_t header_lines;
-	int (*netlink_fn)(char *mesh_iface, char *hard_iface, int read_opt,
+	int (*netlink_fn)(struct state *state, char *hard_iface, int read_opt,
 			 float orig_timeout, float watch_interval);
 	unsigned int option_unicast_only:1;
 	unsigned int option_multicast_only:1;
diff --git a/gateways.c b/gateways.c
index ca5d6ec..ff7693f 100644
--- a/gateways.c
+++ b/gateways.c
@@ -127,7 +127,7 @@ static int gateways_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int netlink_print_gateways(char *mesh_iface, char *orig_iface,
+static int netlink_print_gateways(struct state *state, char *orig_iface,
 				  int read_opts, float orig_timeout,
 				  float watch_interval)
 {
@@ -135,9 +135,9 @@ static int netlink_print_gateways(char *mesh_iface, char *orig_iface,
 	char *info_header;
 	int ifindex;
 
-	ifindex = if_nametoindex(mesh_iface);
+	ifindex = if_nametoindex(state->mesh_iface);
 	if (!ifindex) {
-		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
+		fprintf(stderr, "Interface %s is unknown\n", state->mesh_iface);
 		return -ENODEV;
 	}
 
@@ -157,7 +157,7 @@ static int netlink_print_gateways(char *mesh_iface, char *orig_iface,
 	if (!header)
 		return -EINVAL;
 
-	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+	return netlink_print_common(state, orig_iface, read_opts,
 				    orig_timeout, watch_interval,
 				    header,
 				    BATADV_CMD_GET_GATEWAYS,
@@ -171,4 +171,5 @@ static struct debug_table_data batctl_debug_table_gateways = {
 };
 
 COMMAND_NAMED(DEBUGTABLE, gateways, "gwl", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_gateways, "");
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_gateways, "");
diff --git a/main.c b/main.c
index 9fc6bfb..ab7da45 100644
--- a/main.c
+++ b/main.c
@@ -21,7 +21,7 @@
  */
 
 
-
+#include <errno.h>
 #include <getopt.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -32,6 +32,7 @@
 #include "sys.h"
 #include "debug.h"
 #include "functions.h"
+#include "netlink.h"
 
 char mesh_dfl_iface[] = "bat0";
 char module_ver_path[] = "/sys/module/batman_adv/version";
@@ -180,8 +181,23 @@ int main(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	if (cmd->flags & COMMAND_FLAG_NETLINK) {
+		ret = netlink_create(&state);
+		if (ret < 0 && ret != -EOPNOTSUPP) {
+			/* TODO handle -EOPNOTSUPP as error when fallbacks were
+			 * removed
+			 */
+			fprintf(stderr,
+				"Error - failed to connect to batadv\n");
+			exit(EXIT_FAILURE);
+		}
+	}
+
 	ret = cmd->handler(&state, argc, argv);
 
+	if (cmd->flags & COMMAND_FLAG_NETLINK)
+		netlink_destroy(&state);
+
 	return ret;
 
 err:
diff --git a/main.h b/main.h
index 2656dcf..4a48f61 100644
--- a/main.h
+++ b/main.h
@@ -25,6 +25,10 @@
 
 #include <stdint.h>
 
+#include <netlink/genl/ctrl.h>
+#include <netlink/genl/genl.h>
+#include <netlink/netlink.h>
+
 #ifndef SOURCE_VERSION
 #define SOURCE_VERSION "2018.4"
 #endif
@@ -61,6 +65,7 @@ extern char module_ver_path[];
 
 enum command_flags {
 	COMMAND_FLAG_MESH_IFACE = BIT(0),
+	COMMAND_FLAG_NETLINK = BIT(1),
 };
 
 enum command_type {
@@ -71,6 +76,10 @@ enum command_type {
 struct state {
 	char *mesh_iface;
 	const struct command *cmd;
+
+	struct nl_sock *sock;
+	struct nl_cb *cb;
+	int batadv_family;
 };
 
 struct command {
diff --git a/mcast_flags.c b/mcast_flags.c
index e35cce3..0dc4227 100644
--- a/mcast_flags.c
+++ b/mcast_flags.c
@@ -105,7 +105,7 @@ static int mcast_flags_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int netlink_print_mcast_flags(char *mesh_iface, char *orig_iface,
+static int netlink_print_mcast_flags(struct state *state, char *orig_iface,
 				     int read_opts, float orig_timeout,
 				     float watch_interval)
 {
@@ -116,9 +116,9 @@ static int netlink_print_mcast_flags(char *mesh_iface, char *orig_iface,
 	int ifindex;
 	int ret;
 
-	ifindex = if_nametoindex(mesh_iface);
+	ifindex = if_nametoindex(state->mesh_iface);
 	if (!ifindex) {
-		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
+		fprintf(stderr, "Interface %s is unknown\n", state->mesh_iface);
 		return -ENODEV;
 	}
 
@@ -160,7 +160,7 @@ static int netlink_print_mcast_flags(char *mesh_iface, char *orig_iface,
 	if (ret < 0)
 		return ret;
 
-	ret = netlink_print_common(mesh_iface, orig_iface, read_opts,
+	ret = netlink_print_common(state, orig_iface, read_opts,
 				   orig_timeout, watch_interval, header,
 				   BATADV_CMD_GET_MCAST_FLAGS,
 				   mcast_flags_callback);
@@ -176,4 +176,5 @@ static struct debug_table_data batctl_debug_table_mcast_flags = {
 };
 
 COMMAND_NAMED(DEBUGTABLE, mcast_flags, "mf", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_mcast_flags, "");
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_mcast_flags, "");
diff --git a/neighbors.c b/neighbors.c
index f7ea9ec..76b45ea 100644
--- a/neighbors.c
+++ b/neighbors.c
@@ -120,11 +120,11 @@ static int neighbors_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int netlink_print_neighbors(char *mesh_iface, char *orig_iface,
+static int netlink_print_neighbors(struct state *state, char *orig_iface,
 				   int read_opts, float orig_timeout,
 				   float watch_interval)
 {
-	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+	return netlink_print_common(state, orig_iface, read_opts,
 				    orig_timeout, watch_interval,
 				    "IF             Neighbor              last-seen\n",
 				    BATADV_CMD_GET_NEIGHBORS,
@@ -138,4 +138,5 @@ static struct debug_table_data batctl_debug_table_neighbors = {
 };
 
 COMMAND_NAMED(DEBUGTABLE, neighbors, "n", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_neighbors, "");
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_neighbors, "");
diff --git a/netlink.c b/netlink.c
index 26ae27d..8268037 100644
--- a/netlink.c
+++ b/netlink.c
@@ -109,6 +109,59 @@ struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_MCAST_FLAGS_PRIV]		= { .type = NLA_U32 },
 };
 
+int netlink_create(struct state *state)
+{
+	int ret;
+
+	state->sock = NULL;
+	state->cb = NULL;
+	state->batadv_family = 0;
+
+	state->sock = nl_socket_alloc();
+	if (!state->sock)
+		return -ENOMEM;
+
+	ret = genl_connect(state->sock);
+	if (ret < 0)
+		goto err_free_sock;
+
+	state->batadv_family = genl_ctrl_resolve(state->sock, BATADV_NL_NAME);
+	if (state->batadv_family < 0) {
+		ret = -EOPNOTSUPP;
+		goto err_free_sock;
+	}
+
+	state->cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!state->cb) {
+		ret = -ENOMEM;
+		goto err_free_family;
+	}
+
+	return 0;
+
+err_free_family:
+	state->batadv_family = 0;
+
+err_free_sock:
+	nl_socket_free(state->sock);
+	state->sock = NULL;
+
+	return ret;
+}
+
+void netlink_destroy(struct state *state)
+{
+	if (state->cb) {
+		nl_cb_put(state->cb);
+		state->cb = NULL;
+	}
+
+	if (state->sock) {
+		nl_socket_free(state->sock);
+		state->sock = NULL;
+	}
+}
+
 int last_err;
 char algo_name_buf[256] = "";
 int64_t mcast_flags = -EOPNOTSUPP;
@@ -456,7 +509,7 @@ int netlink_print_routing_algos(void)
 	return last_err;
 }
 
-int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
+int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 			 float orig_timeout, float watch_interval,
 			 const char *header, uint8_t nl_cmd,
 			 nl_recvmsg_msg_cb_t callback)
@@ -469,29 +522,19 @@ int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
 		.callback = callback,
 	};
 	int hardifindex = 0;
-	struct nl_sock *sock;
 	struct nl_msg *msg;
-	struct nl_cb *cb;
 	int ifindex;
-	int family;
 
-	sock = nl_socket_alloc();
-	if (!sock)
-		return -ENOMEM;
-
-	genl_connect(sock);
-
-	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
-	if (family < 0) {
+	if (!state->sock) {
 		last_err = -EOPNOTSUPP;
-		goto err_free_sock;
+		return last_err;
 	}
 
-	ifindex = if_nametoindex(mesh_iface);
+	ifindex = if_nametoindex(state->mesh_iface);
 	if (!ifindex) {
-		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
+		fprintf(stderr, "Interface %s is unknown\n", state->mesh_iface);
 		last_err = -ENODEV;
-		goto err_free_sock;
+		return last_err;
 	}
 
 	if (orig_iface) {
@@ -500,21 +543,15 @@ int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
 			fprintf(stderr, "Interface %s is unknown\n",
 				orig_iface);
 			last_err = -ENODEV;
-			goto err_free_sock;
+			return last_err;
 		}
 	}
 
-	cb = nl_cb_alloc(NL_CB_DEFAULT);
-	if (!cb) {
-		last_err = -ENOMEM;
-		goto err_free_sock;
-	}
-
 	bat_hosts_init(read_opt);
 
-	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, netlink_print_common_cb, &opts);
-	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
-	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);
+	nl_cb_set(state->cb, NL_CB_VALID, NL_CB_CUSTOM, netlink_print_common_cb, &opts);
+	nl_cb_set(state->cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
+	nl_cb_err(state->cb, NL_CB_CUSTOM, print_error, NULL);
 
 	do {
 		if (read_opt & CLR_CONT_READ)
@@ -530,20 +567,20 @@ int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
 		if (!msg)
 			continue;
 
-		genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0,
-			    NLM_F_DUMP, nl_cmd, 1);
+		genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, state->batadv_family,
+			    0, NLM_F_DUMP, nl_cmd, 1);
 
 		nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);
 		if (hardifindex)
 			nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX,
 				    hardifindex);
 
-		nl_send_auto_complete(sock, msg);
+		nl_send_auto_complete(state->sock, msg);
 
 		nlmsg_free(msg);
 
 		last_err = 0;
-		nl_recvmsgs(sock, cb);
+		nl_recvmsgs(state->sock, state->cb);
 
 		/* the header should still be printed when no entry was received */
 		if (!last_err)
@@ -556,9 +593,6 @@ int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
 
 	bat_hosts_free();
 
-err_free_sock:
-	nl_socket_free(sock);
-
 	return last_err;
 }
 
diff --git a/netlink.h b/netlink.h
index 0b21ac1..2526b07 100644
--- a/netlink.h
+++ b/netlink.h
@@ -27,6 +27,8 @@
 #include <netlink/genl/ctrl.h>
 #include <stdint.h>
 
+struct state;
+
 struct print_opts {
 	int read_opt;
 	float orig_timeout;
@@ -39,6 +41,9 @@ struct print_opts {
 
 struct ether_addr;
 
+int netlink_create(struct state *state);
+void netlink_destroy(struct state *state);
+
 int netlink_print_routing_algos(void);
 
 char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header);
@@ -52,7 +57,7 @@ extern struct nla_policy batadv_netlink_policy[];
 
 int missing_mandatory_attrs(struct nlattr *attrs[], const int mandatory[],
 			    int num);
-int netlink_print_common(char *mesh_iface, char *orig_iface, int read_opt,
+int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 			 float orig_timeout, float watch_interval,
 			 const char *header, uint8_t nl_cmd,
 			 nl_recvmsg_msg_cb_t callback);
diff --git a/originators.c b/originators.c
index 54526e3..c29300a 100644
--- a/originators.c
+++ b/originators.c
@@ -179,7 +179,7 @@ static int originators_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int netlink_print_originators(char *mesh_iface, char *orig_iface,
+static int netlink_print_originators(struct state *state, char *orig_iface,
 				     int read_opts, float orig_timeout,
 				     float watch_interval)
 {
@@ -187,9 +187,9 @@ static int netlink_print_originators(char *mesh_iface, char *orig_iface,
 	char *info_header;
 	int ifindex;
 
-	ifindex = if_nametoindex(mesh_iface);
+	ifindex = if_nametoindex(state->mesh_iface);
 	if (!ifindex) {
-		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
+		fprintf(stderr, "Interface %s is unknown\n", state->mesh_iface);
 		return -ENODEV;
 	}
 
@@ -209,7 +209,7 @@ static int netlink_print_originators(char *mesh_iface, char *orig_iface,
 	if (!header)
 		return -EINVAL;
 
-	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+	return netlink_print_common(state, orig_iface, read_opts,
 				    orig_timeout, watch_interval, header,
 				    BATADV_CMD_GET_ORIGINATORS,
 				    originators_callback);
@@ -224,4 +224,5 @@ static struct debug_table_data batctl_debug_table_originators = {
 };
 
 COMMAND_NAMED(DEBUGTABLE, originators, "o", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_originators, "");
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_originators, "");
diff --git a/transglobal.c b/transglobal.c
index f61aa9f..fbbce25 100644
--- a/transglobal.c
+++ b/transglobal.c
@@ -138,11 +138,11 @@ static int transglobal_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int netlink_print_transglobal(char *mesh_iface, char *orig_iface,
+static int netlink_print_transglobal(struct state *state, char *orig_iface,
 				     int read_opts, float orig_timeout,
 				     float watch_interval)
 {
-	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+	return netlink_print_common(state, orig_iface, read_opts,
 				    orig_timeout, watch_interval,
 				    "   Client             VID Flags Last ttvn     Via        ttvn  (CRC       )\n",
 				    BATADV_CMD_GET_TRANSTABLE_GLOBAL,
@@ -158,4 +158,5 @@ static struct debug_table_data batctl_debug_table_transglobal = {
 };
 
 COMMAND_NAMED(DEBUGTABLE, transglobal, "tg", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_transglobal, "");
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_transglobal, "");
diff --git a/translocal.c b/translocal.c
index 815dc1e..1057abd 100644
--- a/translocal.c
+++ b/translocal.c
@@ -134,11 +134,11 @@ static int translocal_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int netlink_print_translocal(char *mesh_iface, char *orig_iface,
+static int netlink_print_translocal(struct state *state, char *orig_iface,
 				    int read_opts, float orig_timeout,
 				    float watch_interval)
 {
-	return netlink_print_common(mesh_iface, orig_iface, read_opts,
+	return netlink_print_common(state, orig_iface, read_opts,
 				    orig_timeout, watch_interval,
 				    "Client             VID Flags    Last seen (CRC       )\n",
 				    BATADV_CMD_GET_TRANSTABLE_LOCAL,
@@ -154,4 +154,5 @@ static struct debug_table_data batctl_debug_table_translocal = {
 };
 
 COMMAND_NAMED(DEBUGTABLE, translocal, "tl", handle_debug_table,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_debug_table_translocal, "");
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_debug_table_translocal, "");
-- 
2.11.0

