Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 19 Jan 2019 16:56:18 +0100
Message-Id: <20190119155626.6414-12-sven@narfation.org>
In-Reply-To: <20190119155626.6414-1-sven@narfation.org>
References: <20190119155626.6414-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v4 11/19] batman-adv: Add gateway mesh genl
 configuration
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
Cc: Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org, Sven Eckelmann <sven@narfation.org>, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <a@unstable.cc>

The mesh/soft-interface can optimize the handling of DHCP packets. Instead
of flooding them through the whole mesh, it can be forwarded as unicast to
a specific gateway server. The originator which injects the packets in the
mesh has to select (based on sel_class thresholds) a responsible gateway
server. This is done by switching this originator to the gw_mode client.
The servers announce their forwarding bandwidth (download/upload) when the
gw_mode server was selected.

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to set/get the
configuration of this feature using the attributes:

* u8 BATADV_ATTR_GW_MODE (0 == off, 1 == client, 2 == server)
* u32 BATADV_ATTR_GW_BANDWIDTH_DOWN (in 100 kbit/s steps)
* u32 BATADV_ATTR_GW_BANDWIDTH_UP (in 100 kbit/s steps)
* u32 BATADV_ATTR_GW_SEL_CLASS

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Antonio Quartulli <a@unstable.cc>
---
 include/uapi/linux/batman_adv.h | 40 ++++++++++++++
 net/batman-adv/gateway_client.c |  1 -
 net/batman-adv/gateway_common.c |  1 +
 net/batman-adv/gateway_common.h |  6 ---
 net/batman-adv/netlink.c        | 92 +++++++++++++++++++++++++++++++++
 net/batman-adv/soft-interface.c |  2 +-
 net/batman-adv/sysfs.c          |  1 +
 7 files changed, 135 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 847841b8..165272be 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -139,6 +139,20 @@ enum batadv_mcast_flags_priv {
 	BATADV_MCAST_FLAGS_QUERIER_IPV6_SHADOWING	= (1 << 4),
 };
 
+/**
+ * enum batadv_gw_modes - gateway mode of node
+ */
+enum batadv_gw_modes {
+	/** @BATADV_GW_MODE_OFF: gw mode disabled */
+	BATADV_GW_MODE_OFF,
+
+	/** @BATADV_GW_MODE_CLIENT: send DHCP requests to gw servers */
+	BATADV_GW_MODE_CLIENT,
+
+	/** @BATADV_GW_MODE_SERVER: announce itself as gatway server */
+	BATADV_GW_MODE_SERVER,
+};
+
 /**
  * enum batadv_nl_attrs - batman-adv netlink attributes
  */
@@ -403,6 +417,32 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_FRAGMENTATION_ENABLED,
 
+	/**
+	 * @BATADV_ATTR_GW_BANDWIDTH_DOWN: defines the download bandwidth which
+	 *  is propagated by this node if %BATADV_ATTR_GW_BANDWIDTH_MODE was set
+	 *  to 'server'.
+	 */
+	BATADV_ATTR_GW_BANDWIDTH_DOWN,
+
+	/**
+	 * @BATADV_ATTR_GW_BANDWIDTH_UP: defines the upload bandwidth which
+	 *  is propagated by this node if %BATADV_ATTR_GW_BANDWIDTH_MODE was set
+	 *  to 'server'.
+	 */
+	BATADV_ATTR_GW_BANDWIDTH_UP,
+
+	/**
+	 * @BATADV_ATTR_GW_MODE: defines the state of the gateway features.
+	 * Possible values are specified in enum batadv_gw_modes
+	 */
+	BATADV_ATTR_GW_MODE,
+
+	/**
+	 * @BATADV_ATTR_GW_SEL_CLASS: defines the selection criteria this node
+	 *  will use to choose a gateway if gw_mode was set to 'client'.
+	 */
+	BATADV_ATTR_GW_SEL_CLASS,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 0a6b9b30..f5811f61 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -47,7 +47,6 @@
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
-#include "gateway_common.h"
 #include "hard-interface.h"
 #include "log.h"
 #include "netlink.h"
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 53d03adc..e064de45 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -28,6 +28,7 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <uapi/linux/batadv_packet.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "gateway_client.h"
 #include "log.h"
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index 89bae100..128467a0 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -25,12 +25,6 @@
 
 struct net_device;
 
-enum batadv_gw_modes {
-	BATADV_GW_MODE_OFF,
-	BATADV_GW_MODE_CLIENT,
-	BATADV_GW_MODE_SERVER,
-};
-
 /**
  * enum batadv_bandwidth_units - bandwidth unit types
  */
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 45f6aee5..8db3a2a4 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -51,6 +51,7 @@
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
 #include "gateway_client.h"
+#include "gateway_common.h"
 #include "hard-interface.h"
 #include "multicast.h"
 #include "originator.h"
@@ -147,6 +148,10 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_FRAGMENTATION_ENABLED]	= { .type = NLA_U8 },
+	[BATADV_ATTR_GW_BANDWIDTH_DOWN]		= { .type = NLA_U32 },
+	[BATADV_ATTR_GW_BANDWIDTH_UP]		= { .type = NLA_U32 },
+	[BATADV_ATTR_GW_MODE]			= { .type = NLA_U8 },
+	[BATADV_ATTR_GW_SEL_CLASS]		= { .type = NLA_U32 },
 };
 
 /**
@@ -303,6 +308,28 @@ static int batadv_netlink_mesh_put(struct sk_buff *msg,
 		       !!atomic_read(&bat_priv->fragmentation)))
 		goto nla_put_failure;
 
+	if (nla_put_u32(msg, BATADV_ATTR_GW_BANDWIDTH_DOWN,
+			atomic_read(&bat_priv->gw.bandwidth_down)))
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_GW_BANDWIDTH_UP,
+			atomic_read(&bat_priv->gw.bandwidth_up)))
+		goto nla_put_failure;
+
+	if (nla_put_u8(msg, BATADV_ATTR_GW_MODE,
+		       atomic_read(&bat_priv->gw.mode)))
+		goto nla_put_failure;
+
+	if (bat_priv->algo_ops->gw.get_best_gw_node &&
+	    bat_priv->algo_ops->gw.is_eligible) {
+		/* GW selection class is not available if the routing algorithm
+		 * in use does not implement the GW API
+		 */
+		if (nla_put_u32(msg, BATADV_ATTR_GW_SEL_CLASS,
+				atomic_read(&bat_priv->gw.sel_class)))
+			goto nla_put_failure;
+	}
+
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
@@ -444,6 +471,71 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		batadv_update_min_mtu(bat_priv->soft_iface);
 	}
 
+	if (info->attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN]) {
+		attr = info->attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN];
+
+		atomic_set(&bat_priv->gw.bandwidth_down, nla_get_u32(attr));
+		batadv_gw_tvlv_container_update(bat_priv);
+	}
+
+	if (info->attrs[BATADV_ATTR_GW_BANDWIDTH_UP]) {
+		attr = info->attrs[BATADV_ATTR_GW_BANDWIDTH_UP];
+
+		atomic_set(&bat_priv->gw.bandwidth_up, nla_get_u32(attr));
+		batadv_gw_tvlv_container_update(bat_priv);
+	}
+
+	if (info->attrs[BATADV_ATTR_GW_MODE]) {
+		u8 gw_mode;
+
+		attr = info->attrs[BATADV_ATTR_GW_MODE];
+		gw_mode = nla_get_u8(attr);
+
+		if (gw_mode <= BATADV_GW_MODE_SERVER) {
+			/* Invoking batadv_gw_reselect() is not enough to really
+			 * de-select the current GW. It will only instruct the
+			 * gateway client code to perform a re-election the next
+			 * time that this is needed.
+			 *
+			 * When gw client mode is being switched off the current
+			 * GW must be de-selected explicitly otherwise no GW_ADD
+			 * uevent is thrown on client mode re-activation. This
+			 * is operation is performed in
+			 * batadv_gw_check_client_stop().
+			 */
+			batadv_gw_reselect(bat_priv);
+
+			/* always call batadv_gw_check_client_stop() before
+			 * changing the gateway state
+			 */
+			batadv_gw_check_client_stop(bat_priv);
+			atomic_set(&bat_priv->gw.mode, gw_mode);
+			batadv_gw_tvlv_container_update(bat_priv);
+		}
+	}
+
+	if (info->attrs[BATADV_ATTR_GW_SEL_CLASS] &&
+	    bat_priv->algo_ops->gw.get_best_gw_node &&
+	    bat_priv->algo_ops->gw.is_eligible) {
+		/* setting the GW selection class is allowed only if the routing
+		 * algorithm in use implements the GW API
+		 */
+
+		u32 sel_class_max = 0xffffffffu;
+		u32 sel_class;
+
+		attr = info->attrs[BATADV_ATTR_GW_SEL_CLASS];
+		sel_class = nla_get_u32(attr);
+
+		if (!bat_priv->algo_ops->gw.store_sel_class)
+			sel_class_max = BATADV_TQ_MAX_VALUE;
+
+		if (sel_class >= 1 && sel_class <= sel_class_max) {
+			atomic_set(&bat_priv->gw.sel_class, sel_class);
+			batadv_gw_reselect(bat_priv);
+		}
+	}
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 5357dcae..d27a543f 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -50,13 +50,13 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <uapi/linux/batadv_packet.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "bat_algo.h"
 #include "bridge_loop_avoidance.h"
 #include "debugfs.h"
 #include "distributed-arp-table.h"
 #include "gateway_client.h"
-#include "gateway_common.h"
 #include "hard-interface.h"
 #include "multicast.h"
 #include "network-coding.h"
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index e1b81626..64fd5932 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -40,6 +40,7 @@
 #include <linux/stringify.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/batadv_packet.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
-- 
2.20.1

