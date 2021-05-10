Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 4/6] batctl: Get meshif info using shared genl socket
Date: Mon, 10 May 2021 21:49:43 +0200
Message-Id: <20210510194945.103735-5-sven@narfation.org>
In-Reply-To: <20210510194945.103735-1-sven@narfation.org>
References: <20210510194945.103735-1-sven@narfation.org>
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

All subcommands which are using the netlink_get_info helper are already
creating state object with batadv genl socket. It is not necessary to
create a new one just to request data from the kernel.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 gateways.c    |  3 +--
 mcast_flags.c |  3 +--
 netlink.c     | 40 +++++++++++++---------------------------
 netlink.h     |  2 +-
 originators.c |  3 +--
 5 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/gateways.c b/gateways.c
index 7625bd8..bdd6795 100644
--- a/gateways.c
+++ b/gateways.c
@@ -122,8 +122,7 @@ static int netlink_print_gateways(struct state *state, char *orig_iface,
 
 	/* only parse routing algorithm name */
 	last_err = -EINVAL;
-	info_header = netlink_get_info(state->mesh_ifindex,
-				       BATADV_CMD_GET_ORIGINATORS, NULL);
+	info_header = netlink_get_info(state, BATADV_CMD_GET_ORIGINATORS, NULL);
 	free(info_header);
 
 	if (strlen(algo_name_buf) == 0)
diff --git a/mcast_flags.c b/mcast_flags.c
index 721f549..44344e0 100644
--- a/mcast_flags.c
+++ b/mcast_flags.c
@@ -104,8 +104,7 @@ static int netlink_print_mcast_flags(struct state *state, char *orig_iface,
 	int ret;
 
 	/* only parse own multicast flags */
-	info_header = netlink_get_info(state->mesh_ifindex,
-				       BATADV_CMD_GET_MCAST_FLAGS, NULL);
+	info_header = netlink_get_info(state, BATADV_CMD_GET_MCAST_FLAGS, NULL);
 	free(info_header);
 
 	if (mcast_flags == -EOPNOTSUPP || mcast_flags_priv == -EOPNOTSUPP)
diff --git a/netlink.c b/netlink.c
index 31c9b01..e3a7b7c 100644
--- a/netlink.c
+++ b/netlink.c
@@ -339,60 +339,46 @@ static int info_callback(struct nl_msg *msg, void *arg)
 			opts->remaining_header = NULL;
 	}
 
-	return NL_STOP;
+	return NL_OK;
 }
 
-char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
+char *netlink_get_info(struct state *state, uint8_t nl_cmd, const char *header)
 {
-	struct nl_sock *sock;
 	struct nl_msg *msg;
 	struct nl_cb *cb;
-	int family;
 	struct print_opts opts = {
 		.read_opt = 0,
 		.nl_cmd = nl_cmd,
 		.remaining_header = NULL,
 		.static_header = header,
 	};
-
-	sock = nl_socket_alloc();
-	if (!sock)
-		return NULL;
-
-	genl_connect(sock);
-
-	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
-	if (family < 0) {
-		nl_socket_free(sock);
-		return NULL;
-	}
+	int ret;
 
 	msg = nlmsg_alloc();
-	if (!msg) {
-		nl_socket_free(sock);
+	if (!msg)
 		return NULL;
-	}
 
-	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, 0,
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, state->batadv_family, 0, 0,
 		    BATADV_CMD_GET_MESH_INFO, 1);
 
-	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);
+	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, state->mesh_ifindex);
 
-	nl_send_auto_complete(sock, msg);
+	nl_send_auto_complete(state->sock, msg);
 
 	nlmsg_free(msg);
 
 	cb = nl_cb_alloc(NL_CB_DEFAULT);
 	if (!cb)
-		goto err_free_sock;
+		return NULL;
 
 	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, info_callback, &opts);
 	nl_cb_err(cb, NL_CB_CUSTOM, netlink_print_error, NULL);
 
-	nl_recvmsgs(sock, cb);
+	ret = nl_recvmsgs(state->sock, cb);
+	if (ret < 0)
+		return opts.remaining_header;
 
-err_free_sock:
-	nl_socket_free(sock);
+	nl_wait_for_ack(state->sock);
 
 	return opts.remaining_header;
 }
@@ -458,7 +444,7 @@ int netlink_print_common(struct state *state, char *orig_iface, int read_opt,
 			printf("\033[2J\033[0;0f");
 
 		if (!(read_opt & SKIP_HEADER))
-			opts.remaining_header = netlink_get_info(state->mesh_ifindex,
+			opts.remaining_header = netlink_get_info(state,
 								 nl_cmd,
 								 header);
 
diff --git a/netlink.h b/netlink.h
index 4ee2f39..48a2a23 100644
--- a/netlink.h
+++ b/netlink.h
@@ -30,7 +30,7 @@ struct ether_addr;
 int netlink_create(struct state *state);
 void netlink_destroy(struct state *state);
 
-char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header);
+char *netlink_get_info(struct state *state, uint8_t nl_cmd, const char *header);
 int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
 			  struct ether_addr *mac_out);
 int get_nexthop_netlink(const char *mesh_iface, const struct ether_addr *mac,
diff --git a/originators.c b/originators.c
index 8a29dd7..a8b313e 100644
--- a/originators.c
+++ b/originators.c
@@ -174,8 +174,7 @@ static int netlink_print_originators(struct state *state, char *orig_iface,
 
 	/* only parse routing algorithm name */
 	last_err = -EINVAL;
-	info_header = netlink_get_info(state->mesh_ifindex,
-				       BATADV_CMD_GET_ORIGINATORS, NULL);
+	info_header = netlink_get_info(state, BATADV_CMD_GET_ORIGINATORS, NULL);
 	free(info_header);
 
 	if (strlen(algo_name_buf) == 0)
-- 
2.30.2

