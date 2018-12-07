Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  7 Dec 2018 21:32:05 +0100
Message-Id: <20181207203209.22633-17-sven@narfation.org>
In-Reply-To: <20181207203209.22633-1-sven@narfation.org>
References: <20181207203209.22633-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v4 16/20] batctl: Support generic netlink for
 distributed_arp_table command
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

The distributed_arp_table implementation is using the commands
BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH to set/get the configuration of
the u8 (boolean) BATADV_ATTR_DISTRIBUTED_ARP_TABLE attribute.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Antonio Quartulli <a@unstable.cc>
---
 distributed_arp_table.c | 46 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/distributed_arp_table.c b/distributed_arp_table.c
index ba6e5b7..ab3da32 100644
--- a/distributed_arp_table.c
+++ b/distributed_arp_table.c
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
 
+static struct simple_boolean_data distributed_arp_table;
+
+static int print_distributed_arp_table(struct nl_msg *msg, void *arg)
+{
+	return sys_simple_print_boolean(msg, arg,
+					BATADV_ATTR_DISTRIBUTED_ARP_TABLE);
+}
+
+static int get_distributed_arp_table(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_distributed_arp_table);
+}
+
+static int set_attrs_distributed_arp_table(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_DISTRIBUTED_ARP_TABLE, data->val);
+
+	return 0;
+}
+
+static int set_distributed_arp_table(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_distributed_arp_table, NULL);
+}
+
 static struct settings_data batctl_settings_distributed_arp_table = {
 	.sysfs_name = SYS_DAT,
-	.params = sysfs_param_enable,
+	.data = &distributed_arp_table,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_distributed_arp_table,
+	.netlink_set = set_distributed_arp_table,
 };
 
 COMMAND_NAMED(SUBCOMMAND, distributed_arp_table, "dat", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_distributed_arp_table,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_distributed_arp_table,
 	      "[0|1]             \tdisplay or modify distributed_arp_table setting");
-- 
2.19.2

