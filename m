Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:42 +0200
Message-Id: <20181025162245.19389-40-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 39/42] batctl: Move routing_algo specific
 code it command source file
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

It is easier to work on the actual command implementation when its source
code is also saved it the correct source file. Only the shared code should
be in the shared code location.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 debug.c        |  15 -------
 debug.h        |   1 -
 functions.c    |  10 -----
 functions.h    |   1 -
 netlink.c      | 116 ++++---------------------------------------------
 netlink.h      |   8 +++-
 routing_algo.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 147 insertions(+), 137 deletions(-)

diff --git a/debug.c b/debug.c
index b908e00..2979dff 100644
--- a/debug.c
+++ b/debug.c
@@ -183,18 +183,3 @@ int handle_debug_table(struct state *state, int argc, char **argv)
 			 read_opt, orig_timeout, watch_interval,
 			 debug_table->header_lines);
 }
-
-int debug_print_routing_algos(void)
-{
-	char full_path[MAX_PATH+1];
-	char *debugfs_mnt;
-
-	debugfs_mnt = debugfs_mount(NULL);
-	if (!debugfs_mnt) {
-		fprintf(stderr, "Error - can't mount or find debugfs\n");
-		return -1;
-	}
-
-	debugfs_make_path(DEBUG_BATIF_PATH_FMT, "", full_path, sizeof(full_path));
-	return read_file(full_path, DEBUG_ROUTING_ALGOS, 0, 0, 0, 0);
-}
diff --git a/debug.h b/debug.h
index 525a46b..2dac1b7 100644
--- a/debug.h
+++ b/debug.h
@@ -48,6 +48,5 @@ struct debug_table_data {
 };
 
 int handle_debug_table(struct state *state, int argc, char **argv);
-int debug_print_routing_algos(void);
 
 #endif
diff --git a/functions.c b/functions.c
index 0a7b587..bdede8b 100644
--- a/functions.c
+++ b/functions.c
@@ -905,16 +905,6 @@ int vlan_get_link(const char *ifname, char **parent)
 	return arg.vid;
 }
 
-int print_routing_algos(void)
-{
-	int err;
-
-	err = netlink_print_routing_algos();
-	if (err == -EOPNOTSUPP)
-		err = debug_print_routing_algos();
-	return err;
-}
-
 int query_rtnl_link(int ifindex, nl_recvmsg_msg_cb_t func, void *arg)
 {
 	struct ifinfomsg rt_hdr = {
diff --git a/functions.h b/functions.h
index d3144d0..c16ba2e 100644
--- a/functions.h
+++ b/functions.h
@@ -57,7 +57,6 @@ int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface);
 void get_random_bytes(void *buf, size_t buflen);
 void check_root_or_die(const char *cmd);
 
-int print_routing_algos(void);
 extern char *line_ptr;
 
 enum {
diff --git a/netlink.c b/netlink.c
index 8268037..5285759 100644
--- a/netlink.c
+++ b/netlink.c
@@ -179,9 +179,8 @@ int missing_mandatory_attrs(struct nlattr *attrs[], const int mandatory[],
 	return 0;
 }
 
-static int print_error(struct sockaddr_nl *nla __maybe_unused,
-		       struct nlmsgerr *nlerr,
-		       void *arg __maybe_unused)
+int netlink_print_error(struct sockaddr_nl *nla __maybe_unused,
+			struct nlmsgerr *nlerr,	void *arg __maybe_unused)
 {
 	if (nlerr->error != -EOPNOTSUPP)
 		fprintf(stderr, "Error received: %s\n",
@@ -192,7 +191,7 @@ static int print_error(struct sockaddr_nl *nla __maybe_unused,
 	return NL_STOP;
 }
 
-static int stop_callback(struct nl_msg *msg, void *arg __maybe_unused)
+int netlink_stop_callback(struct nl_msg *msg, void *arg __maybe_unused)
 {
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
 	int *error = nlmsg_data(nlh);
@@ -381,7 +380,7 @@ char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
 		goto err_free_sock;
 
 	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, info_callback, &opts);
-	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);
+	nl_cb_err(cb, NL_CB_CUSTOM, netlink_print_error, NULL);
 
 	nl_recvmsgs(sock, cb);
 
@@ -391,7 +390,7 @@ char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
 	return opts.remaining_header;
 }
 
-static void netlink_print_remaining_header(struct print_opts *opts)
+void netlink_print_remaining_header(struct print_opts *opts)
 {
 	if (!opts->remaining_header)
 		return;
@@ -401,7 +400,7 @@ static void netlink_print_remaining_header(struct print_opts *opts)
 	opts->remaining_header = NULL;
 }
 
-static int netlink_print_common_cb(struct nl_msg *msg, void *arg)
+int netlink_print_common_cb(struct nl_msg *msg, void *arg)
 {
 	struct print_opts *opts = arg;
 
@@ -410,105 +409,6 @@ static int netlink_print_common_cb(struct nl_msg *msg, void *arg)
 	return opts->callback(msg, arg);
 }
 
-static const int routing_algos_mandatory[] = {
-	BATADV_ATTR_ALGO_NAME,
-};
-
-static int routing_algos_callback(struct nl_msg *msg, void *arg __maybe_unused)
-{
-	struct nlattr *attrs[BATADV_ATTR_MAX+1];
-	struct nlmsghdr *nlh = nlmsg_hdr(msg);
-	struct genlmsghdr *ghdr;
-	const char *algo_name;
-
-	if (!genlmsg_valid_hdr(nlh, 0)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	ghdr = nlmsg_data(nlh);
-
-	if (ghdr->cmd != BATADV_CMD_GET_ROUTING_ALGOS)
-		return NL_OK;
-
-	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
-		      genlmsg_len(ghdr), batadv_netlink_policy)) {
-		fputs("Received invalid data from kernel.\n", stderr);
-		exit(1);
-	}
-
-	if (missing_mandatory_attrs(attrs, routing_algos_mandatory,
-				    ARRAY_SIZE(routing_algos_mandatory))) {
-		fputs("Missing attributes from kernel\n", stderr);
-		exit(1);
-	}
-
-	algo_name = nla_get_string(attrs[BATADV_ATTR_ALGO_NAME]);
-
-	printf(" * %s\n", algo_name);
-
-	return NL_OK;
-}
-
-int netlink_print_routing_algos(void)
-{
-	struct nl_sock *sock;
-	struct nl_msg *msg;
-	struct nl_cb *cb;
-	int family;
-	struct print_opts opts = {
-		.callback = routing_algos_callback,
-	};
-
-	sock = nl_socket_alloc();
-	if (!sock)
-		return -ENOMEM;
-
-	genl_connect(sock);
-
-	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
-	if (family < 0) {
-		last_err = -EOPNOTSUPP;
-		goto err_free_sock;
-	}
-
-	msg = nlmsg_alloc();
-	if (!msg) {
-		last_err = -ENOMEM;
-		goto err_free_sock;
-	}
-
-	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_DUMP,
-		    BATADV_CMD_GET_ROUTING_ALGOS, 1);
-
-	nl_send_auto_complete(sock, msg);
-
-	nlmsg_free(msg);
-
-	opts.remaining_header = strdup("Available routing algorithms:\n");
-
-	cb = nl_cb_alloc(NL_CB_DEFAULT);
-	if (!cb) {
-		last_err = -ENOMEM;
-		goto err_free_sock;
-	}
-
-	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, netlink_print_common_cb,
-		  &opts);
-	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
-	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);
-
-	nl_recvmsgs(sock, cb);
-
-err_free_sock:
-	nl_socket_free(sock);
-
-	if (!last_err)
-		netlink_print_remaining_header(&opts);
-
-	return last_err;
-}
-
 int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 			 float orig_timeout, float watch_interval,
 			 const char *header, uint8_t nl_cmd,
@@ -550,8 +450,8 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 	bat_hosts_init(read_opt);
 
 	nl_cb_set(state->cb, NL_CB_VALID, NL_CB_CUSTOM, netlink_print_common_cb, &opts);
-	nl_cb_set(state->cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
-	nl_cb_err(state->cb, NL_CB_CUSTOM, print_error, NULL);
+	nl_cb_set(state->cb, NL_CB_FINISH, NL_CB_CUSTOM, netlink_stop_callback, NULL);
+	nl_cb_err(state->cb, NL_CB_CUSTOM, netlink_print_error, NULL);
 
 	do {
 		if (read_opt & CLR_CONT_READ)
diff --git a/netlink.h b/netlink.h
index 2526b07..b91ca10 100644
--- a/netlink.h
+++ b/netlink.h
@@ -44,8 +44,6 @@ struct ether_addr;
 int netlink_create(struct state *state);
 void netlink_destroy(struct state *state);
 
-int netlink_print_routing_algos(void);
-
 char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header);
 int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
 			  struct ether_addr *mac_out);
@@ -62,6 +60,12 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 			 const char *header, uint8_t nl_cmd,
 			 nl_recvmsg_msg_cb_t callback);
 
+int netlink_print_common_cb(struct nl_msg *msg, void *arg);
+int netlink_stop_callback(struct nl_msg *msg, void *arg);
+int netlink_print_error(struct sockaddr_nl *nla, struct nlmsgerr *nlerr,
+			void *arg);
+void netlink_print_remaining_header(struct print_opts *opts);
+
 extern char algo_name_buf[256];
 extern int last_err;
 extern int64_t mcast_flags;
diff --git a/routing_algo.c b/routing_algo.c
index ded9284..18d9ef7 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -23,12 +23,21 @@
 #include <dirent.h>
 #include <errno.h>
 #include <getopt.h>
+#include <netinet/if_ether.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 
+#include "batadv_packet.h"
+#include "batman_adv.h"
+#include "debug.h"
+#include "debugfs.h"
 #include "functions.h"
 #include "main.h"
+#include "netlink.h"
 #include "sys.h"
 
 #define SYS_SELECTED_RA_PATH	"/sys/module/batman_adv/parameters/routing_algo"
@@ -41,6 +50,130 @@ static void ra_mode_usage(void)
 	fprintf(stderr, " \t -h print this help\n");
 }
 
+static const int routing_algos_mandatory[] = {
+	BATADV_ATTR_ALGO_NAME,
+};
+
+static int routing_algos_callback(struct nl_msg *msg, void *arg __maybe_unused)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	const char *algo_name;
+
+	if (!genlmsg_valid_hdr(nlh, 0)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_ROUTING_ALGOS)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		fputs("Received invalid data from kernel.\n", stderr);
+		exit(1);
+	}
+
+	if (missing_mandatory_attrs(attrs, routing_algos_mandatory,
+				    ARRAY_SIZE(routing_algos_mandatory))) {
+		fputs("Missing attributes from kernel\n", stderr);
+		exit(1);
+	}
+
+	algo_name = nla_get_string(attrs[BATADV_ATTR_ALGO_NAME]);
+
+	printf(" * %s\n", algo_name);
+
+	return NL_OK;
+}
+
+static int netlink_print_routing_algos(void)
+{
+	struct nl_sock *sock;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int family;
+	struct print_opts opts = {
+		.callback = routing_algos_callback,
+	};
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		return -ENOMEM;
+
+	genl_connect(sock);
+
+	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
+	if (family < 0) {
+		last_err = -EOPNOTSUPP;
+		goto err_free_sock;
+	}
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		last_err = -ENOMEM;
+		goto err_free_sock;
+	}
+
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_DUMP,
+		    BATADV_CMD_GET_ROUTING_ALGOS, 1);
+
+	nl_send_auto_complete(sock, msg);
+
+	nlmsg_free(msg);
+
+	opts.remaining_header = strdup("Available routing algorithms:\n");
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb) {
+		last_err = -ENOMEM;
+		goto err_free_sock;
+	}
+
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, netlink_print_common_cb,
+		  &opts);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, netlink_stop_callback, NULL);
+	nl_cb_err(cb, NL_CB_CUSTOM, netlink_print_error, NULL);
+
+	nl_recvmsgs(sock, cb);
+
+err_free_sock:
+	nl_socket_free(sock);
+
+	if (!last_err)
+		netlink_print_remaining_header(&opts);
+
+	return last_err;
+}
+
+static int debug_print_routing_algos(void)
+{
+	char full_path[MAX_PATH+1];
+	char *debugfs_mnt;
+
+	debugfs_mnt = debugfs_mount(NULL);
+	if (!debugfs_mnt) {
+		fprintf(stderr, "Error - can't mount or find debugfs\n");
+		return -1;
+	}
+
+	debugfs_make_path(DEBUG_BATIF_PATH_FMT, "", full_path, sizeof(full_path));
+	return read_file(full_path, DEBUG_ROUTING_ALGOS, 0, 0, 0, 0);
+}
+
+static int print_routing_algos(void)
+{
+	int err;
+
+	err = netlink_print_routing_algos();
+	if (err == -EOPNOTSUPP)
+		err = debug_print_routing_algos();
+	return err;
+}
+
 static int routing_algo(struct state *state __maybe_unused, int argc, char **argv)
 {
 	DIR *iface_base_dir;
-- 
2.11.0

