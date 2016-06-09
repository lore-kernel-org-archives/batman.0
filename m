Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu,  9 Jun 2016 16:58:53 +0200
Message-Id: <1465484333-8187-6-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1465484333-8187-1-git-send-email-sw@simonwunderlich.de>
References: <1465484333-8187-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH v9 5/5] batctl: Translate mac addresses via
	netlink
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

From: Sven Eckelmann <sven@narfation.org>

The debugfs entries are only available on the main network namespace. All
other network namespaces have to fall back to netlink to read the global
translation table.

batctl has therefore try to access the translation table via netlink and
try to fall back to the debugfs table in case the batman-adv module doesn't
support BATADV_CMD_GET_TRANSTABLE_GLOBAL.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c |   6 +-
 netlink.c   | 185 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.h   |   5 ++
 3 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/functions.c b/functions.c
index f994ced..d236d64 100644
--- a/functions.c
+++ b/functions.c
@@ -463,6 +463,7 @@ struct ether_addr *translate_mac(const char *mesh_iface,
 	struct ether_addr in_mac;
 	static struct ether_addr out_mac;
 	struct ether_addr *mac_result;
+	int ret;
 
 	/* input mac has to be copied because it could be in the shared
 	 * ether_aton buffer
@@ -471,7 +472,10 @@ struct ether_addr *translate_mac(const char *mesh_iface,
 	memcpy(&out_mac, mac, sizeof(out_mac));
 	mac_result = &out_mac;
 
-	translate_mac_debugfs(mesh_iface, &in_mac, mac_result);
+	ret = translate_mac_netlink(mesh_iface, &in_mac, mac_result);
+
+	if (ret == -EOPNOTSUPP)
+		translate_mac_debugfs(mesh_iface, &in_mac, mac_result);
 
 	return mac_result;
 }
diff --git a/netlink.c b/netlink.c
index b044046..9c2a7f7 100644
--- a/netlink.c
+++ b/netlink.c
@@ -22,6 +22,7 @@
 #include "netlink.h"
 #include "main.h"
 
+#include <stdbool.h>
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
@@ -43,6 +44,12 @@
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
 
+#ifndef container_of
+#define container_of(ptr, type, member) __extension__ ({ \
+	const __typeof__(((type *)0)->member) *__pmember = (ptr); \
+	(type *)((char *)__pmember - offsetof(type, member)); })
+#endif
+
 struct print_opts {
 	int read_opt;
 	float orig_timeout;
@@ -50,6 +57,10 @@ struct print_opts {
 	uint8_t nl_cmd;
 };
 
+struct nlquery_opts {
+	int err;
+};
+
 struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_VERSION]		= { .type = NLA_STRING },
 	[BATADV_ATTR_ALGO_NAME]		= { .type = NLA_STRING },
@@ -1191,3 +1202,177 @@ int netlink_print_bla_backbone(char *mesh_iface, char *orig_iface, int read_opts
 				    BATADV_CMD_GET_BLA_BACKBONE,
 				    bla_backbone_callback);
 }
+
+static int nlquery_error_cb(struct sockaddr_nl *nla __unused,
+			    struct nlmsgerr *nlerr, void *arg)
+{
+	struct nlquery_opts *query_opts = arg;
+
+	query_opts->err = nlerr->error;
+
+	return NL_STOP;
+}
+
+static int nlquery_stop_cb(struct nl_msg *msg, void *arg)
+{
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct nlquery_opts *query_opts = arg;
+	int *error = nlmsg_data(nlh);
+
+	if (*error)
+		query_opts->err = *error;
+
+	return NL_STOP;
+}
+
+static int netlink_query_common(const char *mesh_iface, uint8_t nl_cmd,
+				nl_recvmsg_msg_cb_t callback,
+				struct nlquery_opts *query_opts)
+{
+	struct nl_sock *sock;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int ifindex;
+	int family;
+	int ret;
+
+	query_opts->err = 0;
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		return -ENOMEM;
+
+	ret = genl_connect(sock);
+	if (ret < 0) {
+		query_opts->err = ret;
+		goto err_free_sock;
+	}
+
+	family = genl_ctrl_resolve(sock, BATADV_NL_NAME);
+	if (family < 0) {
+		query_opts->err = -EOPNOTSUPP;
+		goto err_free_sock;
+	}
+
+	ifindex = if_nametoindex(mesh_iface);
+	if (!ifindex) {
+		query_opts->err = -ENODEV;
+		goto err_free_sock;
+	}
+
+	cb = nl_cb_alloc(NL_CB_DEFAULT);
+	if (!cb) {
+		query_opts->err = -ENOMEM;
+		goto err_free_sock;
+	}
+
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, callback, query_opts);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, nlquery_stop_cb, query_opts);
+	nl_cb_err(cb, NL_CB_CUSTOM, nlquery_error_cb, query_opts);
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		query_opts->err = -ENOMEM;
+		goto err_free_cb;
+	}
+
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0, NLM_F_DUMP,
+		    nl_cmd, 1);
+
+	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, ifindex);
+	nl_send_auto_complete(sock, msg);
+	nlmsg_free(msg);
+
+	nl_recvmsgs(sock, cb);
+
+err_free_cb:
+	nl_cb_put(cb);
+err_free_sock:
+	nl_socket_free(sock);
+
+	return query_opts->err;
+}
+
+static const int translate_mac_netlink_mandatory[] = {
+	BATADV_ATTR_TT_ADDRESS,
+	BATADV_ATTR_ORIG_ADDRESS,
+};
+
+struct translate_mac_netlink_opts {
+	struct ether_addr mac;
+	bool found;
+	struct nlquery_opts query_opts;
+};
+
+static int translate_mac_netlink_cb(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX+1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct nlquery_opts *query_opts = arg;
+	struct translate_mac_netlink_opts *opts;
+	struct genlmsghdr *ghdr;
+	uint8_t *addr;
+	uint8_t *orig;
+
+	opts = container_of(query_opts, struct translate_mac_netlink_opts,
+			    query_opts);
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (ghdr->cmd != BATADV_CMD_GET_TRANSTABLE_GLOBAL)
+		return NL_OK;
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	if (missing_mandatory_attrs(attrs, translate_mac_netlink_mandatory,
+				    ARRAY_SIZE(translate_mac_netlink_mandatory)))
+		return NL_OK;
+
+	addr = nla_data(attrs[BATADV_ATTR_TT_ADDRESS]);
+	orig = nla_data(attrs[BATADV_ATTR_ORIG_ADDRESS]);
+
+	if (!attrs[BATADV_ATTR_FLAG_BEST])
+		return NL_OK;
+
+	if (memcmp(&opts->mac, addr, ETH_ALEN) != 0)
+		return NL_OK;
+
+	memcpy(&opts->mac, orig, ETH_ALEN);
+	opts->found = true;
+	opts->query_opts.err = 0;
+
+	return NL_STOP;
+}
+
+int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
+			  struct ether_addr *mac_out)
+{
+	struct translate_mac_netlink_opts opts = {
+		.found = false,
+		.query_opts = {
+			.err = 0,
+		},
+	};
+	int ret;
+
+	memcpy(&opts.mac, mac, ETH_ALEN);
+
+	ret = netlink_query_common(mesh_iface,
+				   BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+			           translate_mac_netlink_cb, &opts.query_opts);
+	if (ret < 0)
+		return ret;
+
+	if (!opts.found)
+		return -ENOENT;
+
+	memcpy(mac_out, &opts.mac, ETH_ALEN);
+
+	return 0;
+}
diff --git a/netlink.h b/netlink.h
index 5ff7ace..b2084fb 100644
--- a/netlink.h
+++ b/netlink.h
@@ -25,6 +25,8 @@
 #include <netlink/genl/genl.h>
 #include <netlink/genl/ctrl.h>
 
+struct ether_addr;
+
 int netlink_print_routing_algos(void);
 int netlink_print_originators(char *mesh_iface, char *orig_iface, int read_opt,
 			      float orig_timeout, float watch_interval);
@@ -43,6 +45,9 @@ int netlink_print_bla_claim(char *mesh_iface, char *orig_iface, int read_opt,
 int netlink_print_bla_backbone(char *mesh_iface, char *orig_iface, int read_opt,
 			       float orig_timeout, float watch_interval);
 
+int translate_mac_netlink(const char *mesh_iface, const struct ether_addr *mac,
+			  struct ether_addr *mac_out);
+
 extern struct nla_policy batadv_netlink_policy[];
 
 #endif /* _BATCTL_NETLINK_H */
-- 
2.8.1

