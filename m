Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:42:15 +0100
Message-Id: <20190209134222.15035-14-sven@narfation.org>
In-Reply-To: <20190209134222.15035-1-sven@narfation.org>
References: <20190209134222.15035-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 13/20] batctl: Support generic netlink for
 ap_isolation command
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
Cc: Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <a@unstable.cc>

sysfs should be avoided for new settings of network interfaces. To still
provide a common configuration infrastructure, all the existing settings
subcommands also have to be reimplemented via generic netlink while still
using sysfs as fallback.

The ap_isolation implementation is using the commands
BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH and
BATADV_CMD_SET_VLAN/BATADV_CMD_GET_VLAN to set/get the configuration of the
u8 (boolean) BATADV_ATTR_AP_ISOLATION_ENABLED attribute.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Antonio Quartulli <a@unstable.cc>
---
 ap_isolation.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/ap_isolation.c b/ap_isolation.c
index 9cca943..dd1e8c8 100644
--- a/ap_isolation.c
+++ b/ap_isolation.c
@@ -21,13 +21,77 @@
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
 
+static struct simple_boolean_data ap_isolation;
+
+static int print_ap_isolation(struct nl_msg *msg, void *arg)
+{
+	return sys_simple_print_boolean(msg, arg,
+					BATADV_ATTR_AP_ISOLATION_ENABLED);
+}
+
+static int get_attrs_ap_isolation(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+
+	if (state->vid >= 0)
+		nla_put_u16(msg, BATADV_ATTR_VLANID, state->vid);
+
+	return 0;
+}
+
+static int get_ap_isolation(struct state *state)
+{
+	enum batadv_nl_commands nl_cmd = BATADV_CMD_SET_MESH;
+
+	if (state->vid >= 0)
+		nl_cmd = BATADV_CMD_GET_VLAN;
+
+	return sys_simple_nlquery(state, nl_cmd, get_attrs_ap_isolation,
+				  print_ap_isolation);
+}
+
+static int set_attrs_ap_isolation(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_AP_ISOLATION_ENABLED, data->val);
+
+	if (state->vid >= 0)
+		nla_put_u16(msg, BATADV_ATTR_VLANID, state->vid);
+
+	return 0;
+}
+
+static int set_ap_isolation(struct state *state)
+{
+	enum batadv_nl_commands nl_cmd = BATADV_CMD_SET_MESH;
+
+	if (state->vid >= 0)
+		nl_cmd = BATADV_CMD_SET_VLAN;
+
+	return sys_simple_nlquery(state, nl_cmd, set_attrs_ap_isolation, NULL);
+}
+
 static struct settings_data batctl_settings_ap_isolation = {
 	.sysfs_name = "ap_isolation",
-	.params = sysfs_param_enable,
+	.data = &ap_isolation,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_ap_isolation,
+	.netlink_set = set_ap_isolation,
 };
 
 COMMAND_NAMED(SUBCOMMAND, ap_isolation, "ap", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_ap_isolation,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_ap_isolation,
 	      "[0|1]             \tdisplay or modify ap_isolation setting");
-- 
2.20.1

