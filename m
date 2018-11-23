Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 23 Nov 2018 17:13:55 +0100
Message-Id: <20181123161359.13342-16-sven@narfation.org>
In-Reply-To: <20181123161359.13342-1-sven@narfation.org>
References: <20181123161359.13342-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v2 15/19] batman-adv: Add network_coding mesh
 genl configuration
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
Cc: Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org, Sven Eckelmann <sven@narfation.org>

The mesh interface can use (in an homogeneous mesh) network coding, a
mechanism that aims to increase the overall network throughput by fusing
multiple packets in one transmission.

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to set/get the
configuration of this feature using the BATADV_ATTR_NETWORK_CODING
attribute. Setting the u8 to zero will disable this feature and setting it
to something else is enabling this feature.

Cc: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h |  7 +++++++
 net/batman-adv/netlink.c        | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index c2ee1818..8a3f8920 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -462,6 +462,13 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_MULTICAST_MODE,
 
+	/**
+	 * @BATADV_ATTR_NETWORK_CODING: whether Network Coding (using some magic
+	 *  to send fewer wifi packets but still the same content) is enabled or
+	 *  not.
+	 */
+	BATADV_ATTR_NETWORK_CODING,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 1b2ea342..7f42c5ec 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -55,6 +55,7 @@
 #include "hard-interface.h"
 #include "log.h"
 #include "multicast.h"
+#include "network-coding.h"
 #include "originator.h"
 #include "soft-interface.h"
 #include "tp_meter.h"
@@ -156,6 +157,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_HOP_PENALTY]		= { .type = NLA_U8 },
 	[BATADV_ATTR_LOG_LEVEL]			= { .type = NLA_U32 },
 	[BATADV_ATTR_MULTICAST_MODE]		= { .type = NLA_U8 },
+	[BATADV_ATTR_NETWORK_CODING]		= { .type = NLA_U8 },
 };
 
 /**
@@ -349,6 +351,12 @@ static int batadv_netlink_mesh_put(struct sk_buff *msg,
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
+#ifdef CONFIG_BATMAN_ADV_NC
+	if (nla_put_u8(msg, BATADV_ATTR_NETWORK_CODING,
+		       !!atomic_read(&bat_priv->network_coding)))
+		goto nla_put_failure;
+#endif /* CONFIG_BATMAN_ADV_NC */
+
 	batadv_hardif_put(primary_if);
 
 	genlmsg_end(msg, hdr);
@@ -577,6 +585,15 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	}
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
+#ifdef CONFIG_BATMAN_ADV_NC
+	if (info->attrs[BATADV_ATTR_NETWORK_CODING]) {
+		attr = info->attrs[BATADV_ATTR_NETWORK_CODING];
+
+		atomic_set(&bat_priv->network_coding, !!nla_get_u8(attr));
+		batadv_nc_status_update(bat_priv->soft_iface);
+	}
+#endif /* CONFIG_BATMAN_ADV_NC */
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
-- 
2.19.1

