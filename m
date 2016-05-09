Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Mon,  9 May 2016 18:41:53 +0200
Message-Id: <1462812114-16577-3-git-send-email-sven@open-mesh.com>
In-Reply-To: <6307812.WAqRcEYAvX@bentobox>
References: <6307812.WAqRcEYAvX@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v7 3/4] batctl: Add attributes/command for
	BATADV_CMD_GET_MESH_INFO
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

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

BATADV_CMD_GET_MESH_INFO will be used as common function to retrieve
information from the kernel. This information can be used to display a
header for debugfs tables.

Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Forwarded: https://patchwork.open-mesh.org/patch/16080/
---
 batman_adv.h | 18 ++++++++++++++++++
 netlink.c    | 14 ++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/batman_adv.h b/batman_adv.h
index ba611a7..a908140 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -24,12 +24,28 @@
  * enum batadv_nl_attrs - batman-adv netlink attributes
  *
  * @BATADV_ATTR_UNSPEC: unspecified attribute to catch errors
+ * @BATADV_ATTR_VERSION: batman-adv version string
+ * @BATADV_ATTR_ALGO_NAME: name of routing algorithm
+ * @BATADV_ATTR_MESH_IFINDEX: index of the batman-adv interface
+ * @BATADV_ATTR_MESH_IFNAME: name of the batman-adv interface
+ * @BATADV_ATTR_MESH_ADDRESS: mac address of the batman-adv interface
+ * @BATADV_ATTR_HARD_IFINDEX: index of the non-batman-adv interface
+ * @BATADV_ATTR_HARD_IFNAME: name of the non-batman-adv interface
+ * @BATADV_ATTR_HARD_ADDRESS: mac address of the non-batman-adv interface
  * @__BATADV_ATTR_AFTER_LAST: internal use
  * @NUM_BATADV_ATTR: total number of batadv_nl_attrs available
  * @BATADV_ATTR_MAX: highest attribute number currently defined
  */
 enum batadv_nl_attrs {
 	BATADV_ATTR_UNSPEC,
+	BATADV_ATTR_VERSION,
+	BATADV_ATTR_ALGO_NAME,
+	BATADV_ATTR_MESH_IFINDEX,
+	BATADV_ATTR_MESH_IFNAME,
+	BATADV_ATTR_MESH_ADDRESS,
+	BATADV_ATTR_HARD_IFINDEX,
+	BATADV_ATTR_HARD_IFNAME,
+	BATADV_ATTR_HARD_ADDRESS,
 	/* add attributes above here, update the policy in netlink.c */
 	__BATADV_ATTR_AFTER_LAST,
 	NUM_BATADV_ATTR = __BATADV_ATTR_AFTER_LAST,
@@ -40,11 +56,13 @@ enum batadv_nl_attrs {
  * enum batadv_nl_commands - supported batman-adv netlink commands
  *
  * @BATADV_CMD_UNSPEC: unspecified command to catch errors
+ * @BATADV_CMD_GET_MESH_INFO: Query basic information about batman-adv device
  * @__BATADV_CMD_AFTER_LAST: internal use
  * @BATADV_CMD_MAX: highest used command number
  */
 enum batadv_nl_commands {
 	BATADV_CMD_UNSPEC,
+	BATADV_CMD_GET_MESH_INFO,
 	/* add new commands above here */
 	__BATADV_CMD_AFTER_LAST,
 	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
diff --git a/netlink.c b/netlink.c
index 409953a..2404a25 100644
--- a/netlink.c
+++ b/netlink.c
@@ -22,7 +22,21 @@
 #include "netlink.h"
 #include "main.h"
 
+#include <net/ethernet.h>
+
 #include "batman_adv.h"
 
 struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
+	[BATADV_ATTR_VERSION]		= { .type = NLA_STRING },
+	[BATADV_ATTR_ALGO_NAME]		= { .type = NLA_STRING },
+	[BATADV_ATTR_MESH_IFINDEX]	= { .type = NLA_U32 },
+	[BATADV_ATTR_MESH_IFNAME]	= { .type = NLA_STRING },
+	[BATADV_ATTR_MESH_ADDRESS]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_HARD_IFINDEX]	= { .type = NLA_U32 },
+	[BATADV_ATTR_HARD_IFNAME]	= { .type = NLA_STRING },
+	[BATADV_ATTR_HARD_ADDRESS]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
 };
-- 
2.8.1

