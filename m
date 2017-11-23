Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 23 Nov 2017 15:04:40 +0100
Message-Id: <20171123140444.17119-7-sven.eckelmann@openmesh.com>
In-Reply-To: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
References: <20171123140444.17119-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 06/10] batctl: Handle nl_cb_alloc errors
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

nl_cb_alloc may return NULL on errors. The processing has to be aborted
when this happens.

Fixes: d8dd1ff1a0fe ("batctl: Use netlink to replace some of debugfs")
Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 netlink.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/netlink.c b/netlink.c
index d7aeb9a..b95063a 100644
--- a/netlink.c
+++ b/netlink.c
@@ -320,11 +320,15 @@ static char *netlink_get_info(int ifindex, uint8_t nl_cmd, const char *header)
 	nlmsg_free(msg);
 
 	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb)
+		goto err_free_sock;
+
 	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, info_callback, &opts);
 	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);
 
 	nl_recvmsgs(sock, cb);
 
+err_free_sock:
 	nl_socket_free(sock);
 
 	return opts.remaining_header;
@@ -425,6 +429,11 @@ int netlink_print_routing_algos(void)
 	opts.remaining_header = strdup("Available routing algorithms:\n");
 
 	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb) {
+		last_err = -ENOMEM;
+		goto err_free_sock;
+	}
+
 	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, netlink_print_common_cb,
 		  &opts);
 	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
@@ -1134,9 +1143,14 @@ static int netlink_print_common(char *mesh_iface, char *orig_iface,
 		}
 	}
 
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb) {
+		last_err = -ENOMEM;
+		goto err_free_sock;
+	}
+
 	bat_hosts_init(read_opt);
 
-	cb = nl_cb_alloc(NL_CB_DEFAULT);
 	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, netlink_print_common_cb, &opts);
 	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, stop_callback, NULL);
 	nl_cb_err(cb, NL_CB_CUSTOM, print_error, NULL);
@@ -1181,6 +1195,7 @@ static int netlink_print_common(char *mesh_iface, char *orig_iface,
 
 	bat_hosts_free();
 
+err_free_sock:
 	nl_socket_free(sock);
 
 	return last_err;
-- 
2.11.0

