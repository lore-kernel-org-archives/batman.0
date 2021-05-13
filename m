Return-Path: <asarmanow@gmail.com>
From: Alexander Sarmanow <asarmanow@gmail.com>
Subject: [PATCH v3 1/2] batctl: netlink: Make netlink_query_common non-static
Date: Thu, 13 May 2021 16:02:33 +0200
Message-Id: <20210513140234.1624460-2-asarmanow@gmail.com>
In-Reply-To: <20210513140234.1624460-1-asarmanow@gmail.com>
References: <20210513140234.1624460-1-asarmanow@gmail.com>
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
To: sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de, Alexander Sarmanow <asarmanow@gmail.com>

With a view to the introduction of a JSON debug support the
netlink_query_common can be used for simple query of batman-adv
atttirubtes without any filters.

Signed-off-by: Alexander Sarmanow <asarmanow@gmail.com>
---
 netlink.c | 12 ++++--------
 netlink.h |  8 ++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/netlink.c b/netlink.c
index eb5888b..2c45645 100644
--- a/netlink.c
+++ b/netlink.c
@@ -29,10 +29,6 @@
 #include "functions.h"
 #include "main.h"
 
-struct nlquery_opts {
-	int err;
-};
-
 struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_VERSION] = {
 		.type = NLA_STRING,
@@ -623,10 +619,10 @@ static int nlquery_stop_cb(struct nl_msg *msg, void *arg)
 	return NL_STOP;
 }
 
-static int netlink_query_common(struct state *state,
-				unsigned int mesh_ifindex, uint8_t nl_cmd,
-				nl_recvmsg_msg_cb_t callback, int flags,
-				struct nlquery_opts *query_opts)
+int netlink_query_common(struct state *state,
+			 unsigned int mesh_ifindex, uint8_t nl_cmd,
+			 nl_recvmsg_msg_cb_t callback, int flags,
+			 struct nlquery_opts *query_opts)
 {
 	struct nl_msg *msg;
 	struct nl_cb *cb;
diff --git a/netlink.h b/netlink.h
index 2cc5862..c93f500 100644
--- a/netlink.h
+++ b/netlink.h
@@ -25,6 +25,10 @@ struct print_opts {
 	uint8_t nl_cmd;
 };
 
+struct nlquery_opts {
+	int err;
+};
+
 struct ether_addr;
 
 int netlink_create(struct state *state);
@@ -54,6 +58,10 @@ int netlink_print_error(struct sockaddr_nl *nla, struct nlmsgerr *nlerr,
 			void *arg);
 void netlink_print_remaining_header(struct print_opts *opts);
 
+int netlink_query_common(struct state *state, unsigned int mesh_ifindex,
+			 uint8_t nl_cmd, nl_recvmsg_msg_cb_t callback, int flags,
+			 struct nlquery_opts *query_opts);
+
 extern char algo_name_buf[256];
 extern int last_err;
 extern int64_t mcast_flags;
-- 
2.25.1

