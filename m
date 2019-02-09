Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:42:17 +0100
Message-Id: <20190209134222.15035-16-sven@narfation.org>
In-Reply-To: <20190209134222.15035-1-sven@narfation.org>
References: <20190209134222.15035-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 15/20] batctl: Support generic netlink for
 bridge_loop_avoidance command
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

The bridge_loop_avoidance implementation is using the commands
BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH to set/get the configuration of
the u8 (boolean) BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED attribute.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Simon Wunderlich <sw@simonwunderlich.de>
---
 bridge_loop_avoidance.c | 46 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index d53c278..aac83c5 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -21,13 +21,55 @@
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
 
+static struct simple_boolean_data bridge_loop_avoidance;
+
+static int print_bridge_loop_avoidance(struct nl_msg *msg, void *arg)
+{
+	return sys_simple_print_boolean(msg, arg,
+					BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED);
+}
+
+static int get_bridge_loop_avoidance(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_bridge_loop_avoidance);
+}
+
+static int set_attrs_bridge_loop_avoidance(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED, data->val);
+
+	return 0;
+}
+
+static int set_bridge_loop_avoidance(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_bridge_loop_avoidance, NULL);
+}
+
 static struct settings_data batctl_settings_bridge_loop_avoidance = {
 	.sysfs_name = "bridge_loop_avoidance",
-	.params = sysfs_param_enable,
+	.data = &bridge_loop_avoidance,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_bridge_loop_avoidance,
+	.netlink_set = set_bridge_loop_avoidance,
 };
 
 COMMAND_NAMED(SUBCOMMAND, bridge_loop_avoidance, "bl", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_bridge_loop_avoidance,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_bridge_loop_avoidance,
 	      "[0|1]             \tdisplay or modify bridge_loop_avoidance setting");
-- 
2.20.1

