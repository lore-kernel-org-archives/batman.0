Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:42:20 +0100
Message-Id: <20190209134222.15035-19-sven@narfation.org>
In-Reply-To: <20190209134222.15035-1-sven@narfation.org>
References: <20190209134222.15035-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 18/20] batctl: Support generic netlink for
 multicast_mode command
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

sysfs should be avoided for new settings of network interfaces. To still
provide a common configuration infrastructure, all the existing settings
subcommands also have to be reimplemented via generic netlink while still
using sysfs as fallback.

The multicast_mode implementation is using the commands
BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH to set/get the configuration of the
u8 (boolean) BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED attribute and print
its reverse as multicast_mode.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Linus Lüssing <linus.luessing@c0d3.blue>
---
 multicast_mode.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/multicast_mode.c b/multicast_mode.c
index 1c56faa..836a744 100644
--- a/multicast_mode.c
+++ b/multicast_mode.c
@@ -21,13 +21,75 @@
  */
 
 #include "main.h"
+
+#include <errno.h>
+#include <linux/genetlink.h>
+#include <netlink/genl/genl.h>
+
+#include "batman_adv.h"
+#include "netlink.h"
 #include "sys.h"
 
+static struct simple_boolean_data multicast_mode;
+
+static int print_multicast_mode(struct nl_msg *msg, void *arg)
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
+	if (!attrs[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED])
+		return NL_OK;
+
+	printf("%s\n", !nla_get_u8(attrs[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED]) ? "enabled" : "disabled");
+
+	*result = 0;
+	return NL_STOP;
+}
+
+static int get_multicast_mode(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_multicast_mode);
+}
+
+static int set_attrs_multicast_mode(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED, !data->val);
+
+	return 0;
+}
+
+static int set_multicast_mode(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_multicast_mode, NULL);
+}
+
 static struct settings_data batctl_settings_multicast_mode = {
 	.sysfs_name = "multicast_mode",
-	.params = sysfs_param_enable,
+	.data = &multicast_mode,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_multicast_mode,
+	.netlink_set = set_multicast_mode,
 };
 
 COMMAND_NAMED(SUBCOMMAND, multicast_mode, "mm", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_multicast_mode,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_multicast_mode,
 	      "[0|1]             \tdisplay or modify multicast_mode setting");
-- 
2.20.1

