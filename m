Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  4 Sep 2016 20:23:31 +0200
Message-Id: <20160904182331.18118-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Work around uclibc collision for
	__unused
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

uclibc on 64 bit systems uses struct members called __unused. These
conflict with the definition of __unused in batctl. Such a conflict results
in a build error because the struct member will be replaced with the
__attribute__((unused)).

This can be avoided by renaming it to the Linux kernel name
"__maybe_unused".

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 genl.c     |  4 ++--
 main.h     |  2 +-
 netlink.c  | 10 +++++-----
 tp_meter.c |  5 +++--
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/genl.c b/genl.c
index b6f66fd..36fc27e 100644
--- a/genl.c
+++ b/genl.c
@@ -34,7 +34,7 @@
 
 #include "batman_adv.h"
 
-static int mcast_error_handler(struct sockaddr_nl *nla __unused,
+static int mcast_error_handler(struct sockaddr_nl *nla __maybe_unused,
 			       struct nlmsgerr *err, void *arg)
 {
 	int *ret = arg;
@@ -42,7 +42,7 @@ static int mcast_error_handler(struct sockaddr_nl *nla __unused,
 	return NL_STOP;
 }
 
-static int mcast_ack_handler(struct nl_msg *msg __unused, void *arg)
+static int mcast_ack_handler(struct nl_msg *msg __maybe_unused, void *arg)
 {
 	int *ret = arg;
 	*ret = 0;
diff --git a/main.h b/main.h
index 6365cdb..dbde6dd 100644
--- a/main.h
+++ b/main.h
@@ -47,7 +47,7 @@
 #endif
 
 #define __packed __attribute((packed))   /* linux kernel compat */
-#define __unused __attribute__((unused))
+#define __maybe_unused __attribute__((unused))
 #define BIT(nr)                 (1UL << (nr)) /* linux kernel compat */
 
 typedef uint8_t u8; /* linux kernel compat */
diff --git a/netlink.c b/netlink.c
index e8e94b2..8fce3d8 100644
--- a/netlink.c
+++ b/netlink.c
@@ -134,9 +134,9 @@ static int missing_mandatory_attrs(struct nlattr *attrs[],
 	return 0;
 }
 
-static int print_error(struct sockaddr_nl *nla __unused,
+static int print_error(struct sockaddr_nl *nla __maybe_unused,
 		       struct nlmsgerr *nlerr,
-		       void *arg __unused)
+		       void *arg __maybe_unused)
 {
 	if (nlerr->error != -EOPNOTSUPP)
 		fprintf(stderr, "Error received: %s\n",
@@ -147,7 +147,7 @@ static int print_error(struct sockaddr_nl *nla __unused,
 	return NL_STOP;
 }
 
-static int stop_callback(struct nl_msg *msg, void *arg __unused)
+static int stop_callback(struct nl_msg *msg, void *arg __maybe_unused)
 {
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
 	int *error = nlmsg_data(nlh);
@@ -345,7 +345,7 @@ static const int routing_algos_mandatory[] = {
 	BATADV_ATTR_ALGO_NAME,
 };
 
-static int routing_algos_callback(struct nl_msg *msg, void *arg __unused)
+static int routing_algos_callback(struct nl_msg *msg, void *arg __maybe_unused)
 {
 	struct nlattr *attrs[BATADV_ATTR_MAX+1];
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
@@ -1286,7 +1286,7 @@ int netlink_print_bla_backbone(char *mesh_iface, char *orig_iface, int read_opts
 				    bla_backbone_callback);
 }
 
-static int nlquery_error_cb(struct sockaddr_nl *nla __unused,
+static int nlquery_error_cb(struct sockaddr_nl *nla __maybe_unused,
 			    struct nlmsgerr *nlerr, void *arg)
 {
 	struct nlquery_opts *query_opts = arg;
diff --git a/tp_meter.c b/tp_meter.c
index 43c19da..a402e45 100644
--- a/tp_meter.c
+++ b/tp_meter.c
@@ -66,7 +66,7 @@ struct tp_cookie {
 	uint32_t cookie;
 };
 
-static int tpmeter_nl_print_error(struct sockaddr_nl *nla __unused,
+static int tpmeter_nl_print_error(struct sockaddr_nl *nla __maybe_unused,
 				  struct nlmsgerr *nlerr,
 				  void *arg)
 {
@@ -236,7 +236,8 @@ out:
 	return err;
 }
 
-static int no_seq_check(struct nl_msg *msg __unused, void *arg __unused)
+static int no_seq_check(struct nl_msg *msg __maybe_unused,
+			void *arg __maybe_unused)
 {
 	return NL_OK;
 }
-- 
2.9.3

