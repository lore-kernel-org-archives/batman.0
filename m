Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Tue,  5 Dec 2017 15:35:09 +0100
Message-Id: <20171205143514.4441-2-sven.eckelmann@openmesh.com>
In-Reply-To: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [RFC v2 1/6] batman-adv: Change nl references to genl
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jiri Pirko <jiri@mellanox.com>, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven.eckelmann@openmesh.com>

The batman-adv netlink functionality is actually not pure netlink but is
using NETLINK_GENERIC and related API. The code should therefore also use
this "genl" instead of "nl" to make this more clear.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
---
 include/uapi/linux/batman_adv.h | 14 +++++++-------
 net/batman-adv/main.c           |  2 +-
 net/batman-adv/netlink.c        | 10 ++++++----
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index ae00c99cbed0..a0fed6c01a46 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -25,9 +25,9 @@
 #ifndef _UAPI_LINUX_BATMAN_ADV_H_
 #define _UAPI_LINUX_BATMAN_ADV_H_
 
-#define BATADV_NL_NAME "batadv"
+#define BATADV_GENL_NAME "batadv"
 
-#define BATADV_NL_MCAST_GROUP_TPMETER	"tpmeter"
+#define BATADV_GENL_MCAST_GROUP_TPMETER "tpmeter"
 
 /**
  * enum batadv_tt_client_flags - TT client specific flags
@@ -92,9 +92,9 @@ enum batadv_tt_client_flags {
 };
 
 /**
- * enum batadv_nl_attrs - batman-adv netlink attributes
+ * enum batadv_genl_attrs - batman-adv netlink attributes
  */
-enum batadv_nl_attrs {
+enum batadv_genl_attrs {
 	/**
 	 * @BATADV_ATTR_UNSPEC: unspecified attribute to catch errors
 	 */
@@ -280,7 +280,7 @@ enum batadv_nl_attrs {
 	__BATADV_ATTR_AFTER_LAST,
 
 	/**
-	 * @NUM_BATADV_ATTR: total number of batadv_nl_attrs available
+	 * @NUM_BATADV_ATTR: total number of batadv_genl_attrs available
 	 */
 	NUM_BATADV_ATTR = __BATADV_ATTR_AFTER_LAST,
 
@@ -291,9 +291,9 @@ enum batadv_nl_attrs {
 };
 
 /**
- * enum batadv_nl_commands - supported batman-adv netlink commands
+ * enum batadv_genl_commands - supported batman-adv netlink commands
  */
-enum batadv_nl_commands {
+enum batadv_genl_commands {
 	/**
 	 * @BATADV_CMD_UNSPEC: unspecified command to catch errors
 	 */
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index fc6dcea30238..a56ae758f799 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -687,4 +687,4 @@ MODULE_DESCRIPTION(BATADV_DRIVER_DESC);
 MODULE_SUPPORTED_DEVICE(BATADV_DRIVER_DEVICE);
 MODULE_VERSION(BATADV_SOURCE_VERSION);
 MODULE_ALIAS_RTNL_LINK("batadv");
-MODULE_ALIAS_GENL_FAMILY(BATADV_NL_NAME);
+MODULE_ALIAS_GENL_FAMILY(BATADV_GENL_NAME);
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index a68443d3f119..a9679bdca432 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -58,11 +58,13 @@ struct genl_family batadv_netlink_family;
 
 /* multicast groups */
 enum batadv_netlink_multicast_groups {
-	BATADV_NL_MCGRP_TPMETER,
+	BATADV_GENL_MCGRP_TPMETER,
 };
 
 static const struct genl_multicast_group batadv_netlink_mcgrps[] = {
-	[BATADV_NL_MCGRP_TPMETER] = { .name = BATADV_NL_MCAST_GROUP_TPMETER },
+	[BATADV_GENL_MCGRP_TPMETER] = {
+		.name = BATADV_GENL_MCAST_GROUP_TPMETER
+	},
 };
 
 static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
@@ -298,7 +300,7 @@ int batadv_netlink_tpmeter_notify(struct batadv_priv *bat_priv, const u8 *dst,
 
 	genlmsg_multicast_netns(&batadv_netlink_family,
 				dev_net(bat_priv->soft_iface), msg, 0,
-				BATADV_NL_MCGRP_TPMETER, GFP_KERNEL);
+				BATADV_GENL_MCGRP_TPMETER, GFP_KERNEL);
 
 	return 0;
 
@@ -611,7 +613,7 @@ static const struct genl_ops batadv_netlink_ops[] = {
 
 struct genl_family batadv_netlink_family __ro_after_init = {
 	.hdrsize = 0,
-	.name = BATADV_NL_NAME,
+	.name = BATADV_GENL_NAME,
 	.version = 1,
 	.maxattr = BATADV_ATTR_MAX,
 	.netnsok = true,
-- 
2.11.0

