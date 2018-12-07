Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  7 Dec 2018 21:32:00 +0100
Message-Id: <20181207203209.22633-12-sven@narfation.org>
In-Reply-To: <20181207203209.22633-1-sven@narfation.org>
References: <20181207203209.22633-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v4 11/20] batctl: Add helper to read/write
 boolean configuration values
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

Most of the available settings commands in batctl only operate on a single
boolean value. Both the reading, parsing and writing of these values can
mostly be handled by the same set of helper functions. Only the actual
setting/getting of the correct attribute has to be handled by the actual
settings command implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 17 +++++++++++++++++
 functions.h |  1 +
 sys.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 sys.h       |  8 ++++++++
 4 files changed, 81 insertions(+)

diff --git a/functions.c b/functions.c
index ead7e97..bb6dc31 100644
--- a/functions.c
+++ b/functions.c
@@ -1201,6 +1201,23 @@ void check_root_or_die(const char *cmd)
 	}
 }
 
+int parse_bool(const char *val, bool *res)
+{
+	if (strcasecmp(val, "0") == 0 ||
+	    strcasecmp(val, "disable") == 0 ||
+	    strcasecmp(val, "disabled") == 0) {
+		*res = false;
+		return 0;
+	} else if (strcasecmp(val, "1") == 0 ||
+		   strcasecmp(val, "enable") == 0 ||
+		   strcasecmp(val, "enabled") == 0) {
+		*res = true;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 bool parse_throughput(char *buff, const char *description, uint32_t *throughput)
 {
 	enum batadv_bandwidth_units bw_unit_type = BATADV_BW_UNIT_KBIT;
diff --git a/functions.h b/functions.h
index 4a6ab61..5f39104 100644
--- a/functions.h
+++ b/functions.h
@@ -72,6 +72,7 @@ int check_mesh_iface_ownership(char *mesh_iface, char *hard_iface);
 void get_random_bytes(void *buf, size_t buflen);
 void check_root_or_die(const char *cmd);
 
+int parse_bool(const char *val, bool *res);
 bool parse_throughput(char *buff, const char *description,
 		      uint32_t *throughput);
 
diff --git a/sys.c b/sys.c
index a44502c..ede8b09 100644
--- a/sys.c
+++ b/sys.c
@@ -47,6 +47,34 @@ const char *sysfs_param_enable[] = {
 	NULL,
 };
 
+int parse_simple_boolean(struct state *state, int argc, char *argv[])
+{
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+	int ret;
+
+	if (argc != 2) {
+		fprintf(stderr, "Error - incorrect number of arguments (expected 1)\n");
+		return -EINVAL;
+	}
+
+	ret = parse_bool(argv[1], &data->val);
+	if (ret < 0) {
+		fprintf(stderr, "Error - the supplied argument is invalid: %s\n", argv[1]);
+		fprintf(stderr, "The following values are allowed:\n");
+		fprintf(stderr, " * 0\n");
+		fprintf(stderr, " * disable\n");
+		fprintf(stderr, " * disabled\n");
+		fprintf(stderr, " * 1\n");
+		fprintf(stderr, " * enable\n");
+		fprintf(stderr, " * enabled\n");
+
+		return ret;
+	}
+
+	return 0;
+}
+
 static int sys_simple_nlerror(struct sockaddr_nl *nla __maybe_unused,
 			      struct nlmsgerr *nlerr,	void *arg)
 {
@@ -106,6 +134,33 @@ int sys_simple_nlquery(struct state *state, enum batadv_nl_commands nl_cmd,
 	return result;
 }
 
+int sys_simple_print_boolean(struct nl_msg *msg, void *arg,
+			     enum batadv_nl_attrs attr)
+{
+	struct nlattr *attrs[BATADV_ATTR_MAX + 1];
+	struct nlmsghdr *nlh = nlmsg_hdr(msg);
+	struct genlmsghdr *ghdr;
+	int *result = arg;
+
+	if (!genlmsg_valid_hdr(nlh, 0))
+		return NL_OK;
+
+	ghdr = nlmsg_data(nlh);
+
+	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+		      genlmsg_len(ghdr), batadv_netlink_policy)) {
+		return NL_OK;
+	}
+
+	if (!attrs[attr])
+		return NL_OK;
+
+	printf("%s\n", nla_get_u8(attrs[attr]) ? "enabled" : "disabled");
+
+	*result = 0;
+	return NL_STOP;
+}
+
 static void settings_usage(struct state *state)
 {
 	fprintf(stderr, "Usage: batctl [options] %s|%s [parameters] %s\n",
diff --git a/sys.h b/sys.h
index 57224d5..f32f134 100644
--- a/sys.h
+++ b/sys.h
@@ -27,6 +27,7 @@
 
 #include <linux/genetlink.h>
 #include <netlink/genl/genl.h>
+#include <stdbool.h>
 
 #include "batman_adv.h"
 #include "netlink.h"
@@ -57,10 +58,17 @@ struct settings_data {
 
 extern const char *sysfs_param_enable[];
 
+struct simple_boolean_data {
+	bool val;
+};
+
 int handle_sys_setting(struct state *state, int argc, char **argv);
+int parse_simple_boolean(struct state *state, int argc, char *argv[]);
 
 int sys_simple_nlquery(struct state *state, enum batadv_nl_commands nl_cmd,
 		       nl_recvmsg_msg_cb_t attribute_cb,
 		       nl_recvmsg_msg_cb_t callback);
+int sys_simple_print_boolean(struct nl_msg *msg, void *arg,
+			     enum batadv_nl_attrs attr);
 
 #endif
-- 
2.19.2

