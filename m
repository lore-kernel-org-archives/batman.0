Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/6] batctl: throughputmeter: Use global genl socket
Date: Mon, 10 May 2021 21:49:41 +0200
Message-Id: <20210510194945.103735-3-sven@narfation.org>
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

The batctl framework can take care of creating the netlink socket and
gathering the data for a mesh interface. It is not necessary to duplicate
all the code to create, setup and destroy the batadv genl socket for a
standard socket.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 throughputmeter.c | 105 ++++++++++------------------------------------
 1 file changed, 21 insertions(+), 84 deletions(-)

diff --git a/throughputmeter.c b/throughputmeter.c
index f50f521..7f89651 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -34,7 +34,7 @@
 #include "netlink.h"
 
 static struct ether_addr *dst_mac;
-static char *tp_mesh_iface;
+static struct state *tp_state;
 
 struct tp_result {
 	int error;
@@ -151,62 +151,34 @@ static int tp_meter_cookie_callback(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-static int tp_meter_start(char *mesh_iface, struct ether_addr *dst_mac,
+
+static int tp_meter_start(struct state *state, struct ether_addr *dst_mac,
 			  uint32_t time, struct tp_cookie *cookie)
 {
-	struct nl_sock *sock;
 	struct nl_msg *msg;
 	struct nl_cb *cb;
-	int ifindex;
-	int family;
-	int ret;
 	int err = 0;
 
-	sock = nl_socket_alloc();
-	if (!sock)
-		return -ENOMEM;
-
-	ret = genl_connect(sock);
-	if (ret < 0) {
-		err = -EOPNOTSUPP;
-		goto out;
-	}
-
-	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
-	if (family < 0) {
-		err = -EOPNOTSUPP;
-		goto out;
-	}
-
-	ifindex = if_nametoindex(mesh_iface);
-	if (!ifindex) {
-		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
-		err = -ENODEV;
-		goto out;
-	}
-
 	cb = nl_cb_alloc(NL_CB_DEFAULT);
 	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, tp_meter_cookie_callback,
 		  cookie);
 	nl_cb_err(cb, NL_CB_CUSTOM, tpmeter_nl_print_error, cookie);
 
 	msg = nlmsg_alloc();
-	if (!msg) {
-		err = -ENOMEM;
-		goto out;
-	}
+	if (!msg)
+		return -ENOMEM;
 
-	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0,
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, state->batadv_family, 0,
 		    0, BATADV_CMD_TP_METER, 1);
 
-	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);
+	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, state->mesh_ifindex);
 	nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN, dst_mac);
 	nla_put_u32(msg, BATADV_ATTR_TPMETER_TEST_TIME, time);
 
-	nl_send_auto_complete(sock, msg);
+	nl_send_auto_complete(state->sock, msg);
 	nlmsg_free(msg);
 
-	nl_recvmsgs(sock, cb);
+	nl_recvmsgs(state->sock, cb);
 
 	nl_cb_put(cb);
 
@@ -215,9 +187,6 @@ static int tp_meter_start(char *mesh_iface, struct ether_addr *dst_mac,
 	else if (!cookie->found)
 		err= -EINVAL;
 
-out:
-	nl_socket_free(sock);
-
 	return err;
 }
 
@@ -251,57 +220,24 @@ static int tp_recv_result(struct nl_sock *sock, struct tp_result *result)
 	return err;
 }
 
-static int tp_meter_stop(char *mesh_iface, struct ether_addr *dst_mac)
+static int tp_meter_stop(struct state *state, struct ether_addr *dst_mac)
 {
-	struct nl_sock *sock;
 	struct nl_msg *msg;
-	int ifindex;
-	int family;
-	int ret;
-	int err = 0;
-
-	sock = nl_socket_alloc();
-	if (!sock)
-		return -ENOMEM;
-
-	ret = genl_connect(sock);
-	if (ret < 0) {
-		err = -EOPNOTSUPP;
-		goto out;
-	}
-
-	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
-	if (family < 0) {
-		err = -EOPNOTSUPP;
-		goto out;
-	}
-
-	ifindex = if_nametoindex(mesh_iface);
-	if (!ifindex) {
-		fprintf(stderr, "Interface %s is unknown\n", mesh_iface);
-		err = -ENODEV;
-		goto out;
-	}
 
 	msg = nlmsg_alloc();
-	if (!msg) {
-		err = -ENOMEM;
-		goto out;
-	}
+	if (!msg)
+		return -ENOMEM;
 
-	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0,
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, state->batadv_family, 0,
 		    0, BATADV_CMD_TP_METER_CANCEL, 1);
 
-	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);
+	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, state->mesh_ifindex);
 	nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN, dst_mac);
 
-	nl_send_auto_complete(sock, msg);
+	nl_send_auto_complete(state->sock, msg);
 	nlmsg_free(msg);
 
-out:
-	nl_socket_free(sock);
-
-	return err;
+	return 0;
 }
 
 static struct nl_sock *tp_prepare_listening_sock(void)
@@ -358,7 +294,7 @@ void tp_sig_handler(int sig)
 	case SIGINT:
 	case SIGTERM:
 		fflush(stdout);
-		tp_meter_stop(tp_mesh_iface, dst_mac);
+		tp_meter_stop(tp_state, dst_mac);
 		break;
 	default:
 		break;
@@ -443,7 +379,7 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 		dst_string = ether_ntoa_long(dst_mac);
 
 	/* for sighandler */
-	tp_mesh_iface = state->mesh_iface;
+	tp_state = state;
 	signal(SIGINT, tp_sig_handler);
 	signal(SIGTERM, tp_sig_handler);
 
@@ -451,7 +387,7 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 	if (!listen_sock)
 		goto out;
 
-	ret = tp_meter_start(state->mesh_iface, dst_mac, time, &cookie);
+	ret = tp_meter_start(state, dst_mac, time, &cookie);
 	if (ret < 0) {
 		printf("Failed to send tp_meter request to kernel: %d\n", ret);
 		goto out;
@@ -529,5 +465,6 @@ static int throughputmeter(struct state *state, int argc, char **argv)
 	return ret;
 }
 
-COMMAND(SUBCOMMAND_MIF, throughputmeter, "tp", COMMAND_FLAG_MESH_IFACE, NULL,
+COMMAND(SUBCOMMAND_MIF, throughputmeter, "tp",
+	COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK, NULL,
 	"<destination>     \tstart a throughput measurement");
-- 
2.30.2

