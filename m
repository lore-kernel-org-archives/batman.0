Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 3/6] batctl: interface: List using shared genl socket
Date: Mon, 10 May 2021 21:49:42 +0200
Message-Id: <20210510194945.103735-4-sven@narfation.org>
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

The interface subcommand doesn't need to allocate a new netlink socket to
query the state of a single interface. But it can also not use the socket
which is automatically pre-configured by COMMAND_FLAG_NETLINK because the
(main sub)command might also be started for interfaces which might not
exist yet.

Instead use the shared functions to pre-allocate the necessary state
information when calling the "list" sub-subcommand.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 interface.c | 77 +++++++++++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 46 deletions(-)

diff --git a/interface.c b/interface.c
index cf9c0c3..a96a328 100644
--- a/interface.c
+++ b/interface.c
@@ -62,65 +62,46 @@ static int get_iface_status_netlink_parse(struct nl_msg *msg, void *arg)
 
 	iface_status[IFACE_STATUS_LEN - 1] = '\0';
 
-	return NL_STOP;
+	return NL_OK;
 }
 
-static char *get_iface_status_netlink(unsigned int meshif, unsigned int hardif,
+static char *get_iface_status_netlink(struct state *state, unsigned int hardif,
 				      char *iface_status)
 {
 	char *ret_status = NULL;
-	struct nl_sock *sock;
 	struct nl_msg *msg;
-	int batadv_family;
-	struct nl_cb *cb;
 	int ret;
 
 	iface_status[0] = '\0';
 
-	sock = nl_socket_alloc();
-	if (!sock)
-		return NULL;
-
-	ret = genl_connect(sock);
-	if (ret < 0)
-		goto err_free_sock;
-
-	batadv_family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
-	if (batadv_family < 0)
-		goto err_free_sock;
-
-	cb = nl_cb_alloc(NL_CB_DEFAULT);
-	if (!cb)
-		goto err_free_sock;
-
-	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, get_iface_status_netlink_parse,
+	nl_cb_set(state->cb, NL_CB_VALID, NL_CB_CUSTOM, get_iface_status_netlink_parse,
 		iface_status);
 
 	msg = nlmsg_alloc();
 	if (!msg)
-		goto err_free_cb;
+		return NULL;
 
-	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, batadv_family,
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, state->batadv_family,
 		    0, 0, BATADV_CMD_GET_HARDIF, 1);
 
-	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, meshif);
+	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, state->mesh_ifindex);
 	nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX, hardif);
 
-	ret = nl_send_auto_complete(sock, msg);
+	ret = nl_send_auto_complete(state->sock, msg);
+	if (ret < 0)
+		goto err_free_msg;
+
+	ret = nl_recvmsgs(state->sock, state->cb);
 	if (ret < 0)
 		goto err_free_msg;
 
-	nl_recvmsgs(sock, cb);
+	nl_wait_for_ack(state->sock);
 
 	if (strlen(iface_status) > 0)
 		ret_status = iface_status;
 
 err_free_msg:
 	nlmsg_free(msg);
-err_free_cb:
-	nl_cb_put(cb);
-err_free_sock:
-	nl_socket_free(sock);
 
 	return ret_status;
 }
@@ -130,20 +111,16 @@ static struct nla_policy link_policy[IFLA_MAX + 1] = {
 	[IFLA_MASTER] = { .type = NLA_U32 },
 };
 
-struct print_interfaces_rtnl_arg {
-	int ifindex;
-};
-
 static int print_interfaces_rtnl_parse(struct nl_msg *msg, void *arg)
 {
-	struct print_interfaces_rtnl_arg *print_arg = arg;
 	char iface_status[IFACE_STATUS_LEN];
 	struct nlattr *attrs[IFLA_MAX + 1];
+	struct state *state = arg;
 	struct ifinfomsg *ifm;
+	unsigned int master;
 	char *ifname;
 	int ret;
 	const char *status;
-	int master;
 
 	ifm = nlmsg_data(nlmsg_hdr(msg));
 	ret = nlmsg_parse(nlmsg_hdr(msg), sizeof(*ifm), attrs, IFLA_MAX,
@@ -161,10 +138,10 @@ static int print_interfaces_rtnl_parse(struct nl_msg *msg, void *arg)
 	master = nla_get_u32(attrs[IFLA_MASTER]);
 
 	/* required on older kernels which don't prefilter the results */
-	if (master != print_arg->ifindex)
+	if (master != state->mesh_ifindex)
 		goto err;
 
-	status = get_iface_status_netlink(master, ifm->ifi_index, iface_status);
+	status = get_iface_status_netlink(state, ifm->ifi_index, iface_status);
 	if (!status)
 		status = "<error reading status>\n";
 
@@ -174,21 +151,29 @@ static int print_interfaces_rtnl_parse(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int print_interfaces(char *mesh_iface)
+static int print_interfaces(struct state *state)
 {
-	struct print_interfaces_rtnl_arg print_arg;
+	int ret;
 
 	if (!file_exists(module_ver_path)) {
 		fprintf(stderr, "Error - batman-adv module has not been loaded\n");
 		return EXIT_FAILURE;
 	}
 
-	print_arg.ifindex = if_nametoindex(mesh_iface);
-	if (!print_arg.ifindex)
+	/* duplicated code here from the main() because interface doesn't always
+	 * need COMMAND_FLAG_MESH_IFACE and COMMAND_FLAG_NETLINK
+	 */
+	if (check_mesh_iface(state))
 		return EXIT_FAILURE;
 
-	query_rtnl_link(print_arg.ifindex, print_interfaces_rtnl_parse,
-			&print_arg);
+	ret = netlink_create(state);
+	if (ret < 0)
+		return EXIT_FAILURE;
+
+	query_rtnl_link(state->mesh_ifindex, print_interfaces_rtnl_parse,
+			state);
+
+	netlink_destroy(state);
 
 	return EXIT_SUCCESS;
 }
@@ -452,7 +437,7 @@ static int interface(struct state *state, int argc, char **argv)
 	rest_argv = &argv[optind];
 
 	if (rest_argc == 0)
-		return print_interfaces(state->mesh_iface);
+		return print_interfaces(state);
 
 	check_root_or_die("batctl interface");
 
-- 
2.30.2

