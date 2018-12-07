Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  7 Dec 2018 21:32:08 +0100
Message-Id: <20181207203209.22633-20-sven@narfation.org>
In-Reply-To: <20181207203209.22633-1-sven@narfation.org>
References: <20181207203209.22633-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v4 19/20] batctl: Support generic netlink for
 network_coding command
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
Cc: Sven Eckelmann <sven@narfation.org>, Martin Hundeboll <martin@hundeboll.net>, Marek Lindner <mareklindner@neomailbox.ch>

sysfs should be avoided for new settings of network interfaces. To still
provide a common configuration infrastructure, all the existing settings
subcommands also have to be reimplemented via generic netlink while still
using sysfs as fallback.

The network_coding implementation is using the commands
BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH to set/get the configuration of
the u8 (boolean) BATADV_ATTR_NETWORK_CODING attribute.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Martin Hundeboll <martin@hundeboll.net>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
---
 network_coding.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/network_coding.c b/network_coding.c
index a4c4296..1dc23ef 100644
--- a/network_coding.c
+++ b/network_coding.c
@@ -21,13 +21,54 @@
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
 
+static struct simple_boolean_data network_coding;
+
+static int print_network_coding(struct nl_msg *msg, void *arg)
+{
+	return sys_simple_print_boolean(msg, arg, BATADV_ATTR_NETWORK_CODING);
+}
+
+static int get_network_coding(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_GET_MESH,
+				  NULL, print_network_coding);
+}
+
+static int set_attrs_network_coding(struct nl_msg *msg, void *arg)
+{
+	struct state *state = arg;
+	struct settings_data *settings = state->cmd->arg;
+	struct simple_boolean_data *data = settings->data;
+
+	nla_put_u8(msg, BATADV_ATTR_NETWORK_CODING, data->val);
+
+	return 0;
+}
+
+static int set_network_coding(struct state *state)
+{
+	return sys_simple_nlquery(state, BATADV_CMD_SET_MESH,
+				  set_attrs_network_coding, NULL);
+}
+
 static struct settings_data batctl_settings_network_coding = {
 	.sysfs_name = SYS_NETWORK_CODING,
-	.params = sysfs_param_enable,
+	.data = &network_coding,
+	.parse = parse_simple_boolean,
+	.netlink_get = get_network_coding,
+	.netlink_set = set_network_coding,
 };
 
 COMMAND_NAMED(SUBCOMMAND, network_coding, "nc", handle_sys_setting,
-	      COMMAND_FLAG_MESH_IFACE, &batctl_settings_network_coding,
+	      COMMAND_FLAG_MESH_IFACE | COMMAND_FLAG_NETLINK,
+	      &batctl_settings_network_coding,
 	      "[0|1]             \tdisplay or modify network_coding setting");
-- 
2.19.2

