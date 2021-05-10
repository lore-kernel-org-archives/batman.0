Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6/6] batctl: routing_algo: List using shared genl socket
Date: Mon, 10 May 2021 21:49:45 +0200
Message-Id: <20210510194945.103735-7-sven@narfation.org>
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
get the list of interfaces. There is already a netlink socket available
which was used to query the routing algorithm of each interface.
Just use this batadv genl socket to also dump the list of all available
routing algorithms.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 routing_algo.c | 53 ++++++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 36 deletions(-)

diff --git a/routing_algo.c b/routing_algo.c
index 8fb4fab..0adf32f 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -79,58 +79,35 @@ static int routing_algos_callback(struct nl_msg *msg, void *arg __maybe_unused)
 	return NL_OK;
 }
 
-static int print_routing_algos(void)
+static int print_routing_algos(struct state *state)
 {
-	struct nl_sock *sock;
 	struct nl_msg *msg;
 	struct nl_cb *cb;
-	int family;
 	struct print_opts opts = {
 		.callback = routing_algos_callback,
 	};
 
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
 	msg = nlmsg_alloc();
-	if (!msg) {
-		last_err = -ENOMEM;
-		goto err_free_sock;
-	}
-
-	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_DUMP,
-		    BATADV_CMD_GET_ROUTING_ALGOS, 1);
-
-	nl_send_auto_complete(sock, msg);
+	if (!msg)
+		return -ENOMEM;
 
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, state->batadv_family, 0,
+		    NLM_F_DUMP, BATADV_CMD_GET_ROUTING_ALGOS, 1);
+	nl_send_auto_complete(state->sock, msg);
 	nlmsg_free(msg);
 
 	opts.remaining_header = strdup("Available routing algorithms:\n");
 
 	cb = nl_cb_alloc(NL_CB_DEFAULT);
-	if (!cb) {
-		last_err = -ENOMEM;
-		goto err_free_sock;
-	}
+	if (!cb)
+		return -ENOMEM;
 
 	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, netlink_print_common_cb,
 		  &opts);
 	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, netlink_stop_callback, NULL);
 	nl_cb_err(cb, NL_CB_CUSTOM, netlink_print_error, NULL);
 
-	nl_recvmsgs(sock, cb);
-
-err_free_sock:
-	nl_socket_free(sock);
+	nl_recvmsgs(state->sock, cb);
 
 	if (!last_err)
 		netlink_print_remaining_header(&opts);
@@ -316,19 +293,23 @@ static int routing_algo(struct state *state, int argc, char **argv)
 		return EXIT_FAILURE;
 
 	print_ra_interfaces(state);
-	netlink_destroy(state);
 
 	res = read_file(SYS_SELECTED_RA_PATH, USE_READ_BUFF);
 	if (res != EXIT_SUCCESS)
-		return EXIT_FAILURE;
+		goto err_free_netlink;
 
 	printf("Selected routing algorithm (used when next batX interface is created):\n");
 	printf(" => %s\n", line_ptr);
 	free(line_ptr);
 	line_ptr = NULL;
 
-	print_routing_algos();
-	return EXIT_SUCCESS;
+	print_routing_algos(state);
+	res = EXIT_SUCCESS;
+
+err_free_netlink:
+	netlink_destroy(state);
+
+	return res;
 }
 
 COMMAND(SUBCOMMAND, routing_algo, "ra", 0, NULL,
-- 
2.30.2

