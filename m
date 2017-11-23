Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 23 Nov 2017 15:04:38 +0100
Message-Id: <20171123140444.17119-5-sven.eckelmann@openmesh.com>
In-Reply-To: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
References: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 04/10] batctl: Handle nlmsg_alloc errors
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
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>

nlmsg_alloc may return NULL on errors. The processing has to be aborted
when this happens.

Fixes: d8dd1ff1a0fe ("batctl: Use netlink to replace some of debugfs")
Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 netlink.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/netlink.c b/netlink.c
index 7fb1ee1..e3d7892 100644
--- a/netlink.c
+++ b/netlink.c
@@ -302,6 +302,11 @@ static char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
 		return NULL;
 
 	msg = nlmsg_alloc();
+	if (!msg) {
+		nl_socket_free(sock);
+		return NULL;
+	}
+
 	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, 0,
 		    BATADV_CMD_GET_MESH_INFO, 1);
 
@@ -399,6 +404,11 @@ int netlink_print_routing_algos(void)
 		return -EOPNOTSUPP;
 
 	msg = nlmsg_alloc();
+	if (!msg) {
+		last_err = -ENOMEM;
+		goto err_free_sock;
+	}
+
 	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_DUMP,
 		    BATADV_CMD_GET_ROUTING_ALGOS, 1);
 
@@ -415,6 +425,8 @@ int netlink_print_routing_algos(void)
 	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);
 
 	nl_recvmsgs(sock, cb);
+
+err_free_sock:
 	nl_socket_free(sock);
 
 	if (!last_err)
@@ -1131,6 +1143,9 @@ static int netlink_print_common(char *mesh_iface, char *orig_iface,
 								 header);
 
 		msg = nlmsg_alloc();
+		if (!msg)
+			continue;
+
 		genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0,
 			    NLM_F_DUMP, nl_cmd, 1);
 
-- 
2.11.0

