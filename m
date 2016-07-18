Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 18 Jul 2016 12:12:08 +0200
Message-Id: <1468836728-21890-11-git-send-email-sven@narfation.org>
In-Reply-To: <6098496.c9QsHxvAun@sven-edge>
References: <6098496.c9QsHxvAun@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH v11 11/11] batctl: Use debugfs fallback when
	netlink not supported
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

The batman-adv release v2016.2 already has the batadv netlink family . Thus
the fallback to debugfs not only has to be triggered when the the netlink
family doesn't exist but also when the cmd returns a -EOPNOTSUPP. This
still has the problem that the header is generated via a different command
then the actual table entries. Falling back to debugfs would cause a second
header entry for the table.

The header print functionality is therefore refactored to only gather the
data for the header and print the actual header either with the first
received entry or when the CMD finished without any result.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.h |   1 -
 netlink.c   | 146 +++++++++++++++++++++++++++++++++++++++++-------------------
 2 files changed, 99 insertions(+), 48 deletions(-)

diff --git a/functions.h b/functions.h
index 1f311ca..e24dea0 100644
--- a/functions.h
+++ b/functions.h
@@ -61,7 +61,6 @@ enum {
 	SKIP_HEADER = 0x100,
 	UNICAST_ONLY = 0x200,
 	MULTICAST_ONLY = 0x400,
-	PARSE_ONLY = 0x800,
 };
 
 #endif
diff --git a/netlink.c b/netlink.c
index 423fc9b..54d4cc2 100644
--- a/netlink.c
+++ b/netlink.c
@@ -54,6 +54,9 @@ struct print_opts {
 	int read_opt;
 	float orig_timeout;
 	float watch_interval;
+	nl_recvmsg_msg_cb_t callback;
+	char *remaining_header;
+	const char *static_header;
 	uint8_t nl_cmd;
 };
 
@@ -139,7 +142,7 @@ static int print_error(struct sockaddr_nl *nla __unused,
 		fprintf(stderr, "Error received: %s\n",
 			strerror(-nlerr->error));
 
-	last_err = -nlerr->error;
+	last_err = nlerr->error;
 
 	return NL_STOP;
 }
@@ -182,6 +185,7 @@ static int info_callback(struct nl_msg *msg, void *arg)
 	uint8_t ttvn = 0;
 	uint16_t bla_group_id = 0;
 	const char *algo_name;
+	const char *extra_header;
 	int ret;
 
 	if (!genlmsg_valid_hdr(nlh, 0)) {
@@ -230,54 +234,64 @@ static int info_callback(struct nl_msg *msg, void *arg)
 		if (attrs[BATADV_ATTR_BLA_CRC])
 			bla_group_id = nla_get_u16(attrs[BATADV_ATTR_BLA_CRC]);
 
-		if (!(opts->read_opt & PARSE_ONLY)) {
-			switch (opts->nl_cmd) {
-			case BATADV_CMD_GET_TRANSTABLE_LOCAL:
-				ret = asprintf(&extra_info, ", TTVN: %u", ttvn);
-				if (ret < 0)
-					extra_info = NULL;
-				break;
-			case BATADV_CMD_GET_BLA_BACKBONE:
-			case BATADV_CMD_GET_BLA_CLAIM:
-				ret = asprintf(&extra_info, ", group id: 0x%04x",
-					       bla_group_id);
-				if (ret < 0)
-					extra_info = NULL;
-				break;
-			default:
-				extra_info = strdup("");
-				break;
-			}
-
-			printf("[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%02x:%02x:%02x:%02x:%02x:%02x (%s/%02x:%02x:%02x:%02x:%02x:%02x %s)%s]\n",
+		switch (opts->nl_cmd) {
+		case BATADV_CMD_GET_TRANSTABLE_LOCAL:
+			ret = asprintf(&extra_info, ", TTVN: %u", ttvn);
+			if (ret < 0)
+				extra_info = NULL;
+			break;
+		case BATADV_CMD_GET_BLA_BACKBONE:
+		case BATADV_CMD_GET_BLA_CLAIM:
+			ret = asprintf(&extra_info, ", group id: 0x%04x",
+				       bla_group_id);
+			if (ret < 0)
+				extra_info = NULL;
+			break;
+		default:
+			extra_info = strdup("");
+			break;
+		}
+
+		if (opts->static_header)
+			extra_header = opts->static_header;
+		else
+			extra_header = "";
+
+		ret = asprintf(&opts->remaining_header,
+			       "[B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%02x:%02x:%02x:%02x:%02x:%02x (%s/%02x:%02x:%02x:%02x:%02x:%02x %s)%s]\n%s",
 			       version, primary_if,
 			       primary_mac[0], primary_mac[1], primary_mac[2],
 			       primary_mac[3], primary_mac[4], primary_mac[5],
 			       mesh_name,
 			       mesh_mac[0], mesh_mac[1], mesh_mac[2],
 			       mesh_mac[3], mesh_mac[4], mesh_mac[5],
-			       algo_name, extra_info);
+			       algo_name, extra_info, extra_header);
+		if (ret < 0)
+			opts->remaining_header = NULL;
 
-			if (extra_info)
-				free(extra_info);
-		}
+		if (extra_info)
+			free(extra_info);
 	} else {
-		if (!(opts->read_opt & PARSE_ONLY))
-			printf("BATMAN mesh %s disabled\n", mesh_name);
+		ret = asprintf(&opts->remaining_header,
+			       "BATMAN mesh %s disabled\n", mesh_name);
+		if (ret < 0)
+			opts->remaining_header = NULL;
 	}
 
 	return NL_STOP;
 }
 
-static void netlink_print_info(int ifindex, uint8_t nl_cmd, int read_opt)
+static char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
 {
 	struct nl_sock *sock;
 	struct nl_msg *msg;
 	struct nl_cb *cb;
 	int family;
 	struct print_opts opts = {
-		.read_opt = read_opt,
+		.read_opt = 0,
 		.nl_cmd = nl_cmd,
+		.remaining_header = NULL,
+		.static_header = header,
 	};
 
 	sock = nl_socket_alloc();
@@ -285,7 +299,7 @@ static void netlink_print_info(int ifindex, uint8_t nl_cmd, int read_opt)
 
 	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
 	if (family < 0)
-		return;
+		return NULL;
 
 	msg = nlmsg_alloc();
 	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, 0,
@@ -304,6 +318,27 @@ static void netlink_print_info(int ifindex, uint8_t nl_cmd, int read_opt)
 	nl_recvmsgs(sock, cb);
 
 	nl_socket_free(sock);
+
+	return opts.remaining_header;
+}
+
+static void netlink_print_remaining_header(struct print_opts *opts)
+{
+	if (!opts->remaining_header)
+		return;
+
+	fputs(opts->remaining_header, stdout);
+	free(opts->remaining_header);
+	opts->remaining_header = NULL;
+}
+
+static int netlink_print_common_cb(struct nl_msg *msg, void *arg)
+{
+	struct print_opts *opts = arg;
+
+	netlink_print_remaining_header(opts);
+
+	return opts->callback(msg, arg);
 }
 
 static const int routing_algos_mandatory[] = {
@@ -352,6 +387,9 @@ int netlink_print_routing_algos(void)
 	struct nl_msg *msg;
 	struct nl_cb *cb;
 	int family;
+	struct print_opts opts = {
+		.callback = routing_algos_callback,
+	};
 
 	sock = nl_socket_alloc();
 	genl_connect(sock);
@@ -368,19 +406,21 @@ int netlink_print_routing_algos(void)
 
 	nlmsg_free(msg);
 
+	opts.remaining_header = strdup("Available routing algorithms:\n");
+
 	cb = nl_cb_alloc(NL_CB_DEFAULT);
-	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, routing_algos_callback,
-		  NULL);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, netlink_print_common_cb,
+		  &opts);
 	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
 	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);
 
-	printf("Available routing algorithms:\n");
-
 	nl_recvmsgs(sock, cb);
-
 	nl_socket_free(sock);
 
-	return 0;
+	if (!last_err)
+		netlink_print_remaining_header(&opts);
+
+	return last_err;
 }
 
 static const int originators_mandatory[] = {
@@ -1040,7 +1080,9 @@ static int netlink_print_common(char *mesh_iface, char *orig_iface,
 	struct print_opts opts = {
 		.read_opt = read_opt,
 		.orig_timeout = orig_timeout,
-		.watch_interval = watch_interval
+		.watch_interval = watch_interval,
+		.remaining_header = NULL,
+		.callback = callback,
 	};
 	int hardifindex = 0;
 	struct nl_sock *sock;
@@ -1074,7 +1116,7 @@ static int netlink_print_common(char *mesh_iface, char *orig_iface,
 	bat_hosts_init(read_opt);
 
 	cb = nl_cb_alloc(NL_CB_DEFAULT);
-	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, callback, &opts);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, netlink_print_common_cb, &opts);
 	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
 	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);
 
@@ -1083,11 +1125,10 @@ static int netlink_print_common(char *mesh_iface, char *orig_iface,
 			/* clear screen, set cursor back to 0,0 */
 			printf("\033[2J\033[0;0f");
 
-		if (!(read_opt & SKIP_HEADER)) {
-			netlink_print_info(ifindex, nl_cmd, 0);
-			if (header)
-				printf("%s", header);
-		}
+		if (!(read_opt & SKIP_HEADER))
+			opts.remaining_header = netlink_get_info(ifindex,
+								 nl_cmd,
+								 header);
 
 		msg = nlmsg_alloc();
 		genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0,
@@ -1104,6 +1145,11 @@ static int netlink_print_common(char *mesh_iface, char *orig_iface,
 
 		last_err = 0;
 		nl_recvmsgs(sock, cb);
+
+		/* the header should still be printed when no entry was received */
+		if (!last_err)
+			netlink_print_remaining_header(&opts);
+
 		if (!last_err && read_opt & (CONT_READ|CLR_CONT_READ))
 			usleep(1000000 * watch_interval);
 
@@ -1120,7 +1166,8 @@ int netlink_print_originators(char *mesh_iface, char *orig_iface,
 			      int read_opts, float orig_timeout,
 			      float watch_interval)
 {
-	char *header;
+	char *header = NULL;
+	char *info_header;
 	int ifindex;
 
 	ifindex = if_nametoindex(mesh_iface);
@@ -1129,7 +1176,9 @@ int netlink_print_originators(char *mesh_iface, char *orig_iface,
 		return -ENODEV;
 	}
 
-	netlink_print_info(ifindex, BATADV_CMD_GET_ORIGINATORS, PARSE_ONLY);
+	/* only parse routing algorithm name */
+	info_header = netlink_get_info(ifindex, BATADV_CMD_GET_ORIGINATORS, NULL);
+	free(info_header);
 
 	if (strlen(algo_name_buf) == 0)
 		return -EINVAL;
@@ -1184,7 +1233,8 @@ int netlink_print_translocal(char *mesh_iface, char *orig_iface, int read_opts,
 int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opts,
 			   float orig_timeout,
 			   float watch_interval)
-{	char *header;
+{	char *header = NULL;
+	char *info_header;
 	int ifindex;
 
 	ifindex = if_nametoindex(mesh_iface);
@@ -1193,7 +1243,9 @@ int netlink_print_gateways(char *mesh_iface, char *orig_iface, int read_opts,
 		return -ENODEV;
 	}
 
-	netlink_print_info(ifindex, BATADV_CMD_GET_ORIGINATORS, PARSE_ONLY);
+	/* only parse routing algorithm name */
+	info_header = netlink_get_info(ifindex, BATADV_CMD_GET_ORIGINATORS, NULL);
+	free(info_header);
 
 	if (strlen(algo_name_buf) == 0)
 		return -EINVAL;
-- 
2.8.1

