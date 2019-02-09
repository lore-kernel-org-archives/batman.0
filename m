Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:42:08 +0100
Message-Id: <20190209134222.15035-7-sven@narfation.org>
In-Reply-To: <20190209134222.15035-1-sven@narfation.org>
References: <20190209134222.15035-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 06/20] batctl: Add netlink simple query
 helper
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

All functions which will use the new configuration interface for meshifs,
hardifs and vlans require a simple method to send messages and have one or
multiple extra functionality:

* add special attributes (attribute_cb)
* return errors which happened during communication via netlink
* parse the reply message (callback)

The sys_simple_nlquery provides this but requires that the netlink socket
and the single use nl_cb was allocated by the initialization helper via
COMMAND_FLAG_MESH_IFACE.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 sys.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sys.h | 10 ++++++++++
 2 files changed, 69 insertions(+)

diff --git a/sys.c b/sys.c
index d4f1d6d..0972394 100644
--- a/sys.c
+++ b/sys.c
@@ -47,6 +47,65 @@ const char *sysfs_param_enable[] = {
 	NULL,
 };
 
+static int sys_simple_nlerror(struct sockaddr_nl *nla __maybe_unused,
+			      struct nlmsgerr *nlerr,	void *arg)
+{
+	int *result = arg;
+
+	if (nlerr->error != -EOPNOTSUPP)
+		fprintf(stderr, "Error received: %s\n",
+			strerror(-nlerr->error));
+
+	*result = nlerr->error;
+
+	return NL_STOP;
+}
+
+int sys_simple_nlquery(struct state *state, enum batadv_nl_commands nl_cmd,
+		       nl_recvmsg_msg_cb_t attribute_cb,
+		       nl_recvmsg_msg_cb_t callback)
+{
+	int result;
+	struct nl_msg *msg;
+	int ret;
+
+	if (!state->sock)
+		return -EOPNOTSUPP;
+
+	if (callback) {
+		result = -EOPNOTSUPP;
+		nl_cb_set(state->cb, NL_CB_VALID, NL_CB_CUSTOM, callback,
+			  &result);
+	} else {
+		result = 0;
+	}
+
+	nl_cb_err(state->cb, NL_CB_CUSTOM, sys_simple_nlerror, &result);
+
+	msg = nlmsg_alloc();
+	if (!msg)
+		return -ENOMEM;
+
+	genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, state->batadv_family, 0, 0,
+		    nl_cmd, 1);
+	nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, state->mesh_ifindex);
+
+	if (attribute_cb) {
+		ret = attribute_cb(msg, state);
+		if (ret < 0) {
+			nlmsg_free(msg);
+			return -ENOMEM;
+		}
+	}
+
+	nl_send_auto_complete(state->sock, msg);
+	nlmsg_free(msg);
+
+	nl_recvmsgs(state->sock, state->cb);
+
+	return result;
+}
+
 static void settings_usage(struct state *state)
 {
 	fprintf(stderr, "Usage: batctl [options] %s|%s [parameters] %s\n",
diff --git a/sys.h b/sys.h
index f212789..2f7f5f4 100644
--- a/sys.h
+++ b/sys.h
@@ -25,6 +25,12 @@
 
 #include "main.h"
 
+#include <linux/genetlink.h>
+#include <netlink/genl/genl.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
+
 #define SYS_BATIF_PATH_FMT	"/sys/class/net/%s/mesh/"
 #define SYS_IFACE_PATH		"/sys/class/net"
 #define SYS_IFACE_DIR		SYS_IFACE_PATH"/%s/"
@@ -47,4 +53,8 @@ extern const char *sysfs_param_enable[];
 
 int handle_sys_setting(struct state *state, int argc, char **argv);
 
+int sys_simple_nlquery(struct state *state, enum batadv_nl_commands nl_cmd,
+		       nl_recvmsg_msg_cb_t attribute_cb,
+		       nl_recvmsg_msg_cb_t callback);
+
 #endif
-- 
2.20.1

