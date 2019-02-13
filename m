Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Feb 2019 10:55:18 +0100
Message-Id: <20190213095524.10147-16-sw@simonwunderlich.de>
In-Reply-To: <20190213095524.10147-1-sw@simonwunderlich.de>
References: <20190213095524.10147-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 15/21] batman-adv: Add log_level mesh genl
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

In contrast to other modules, batman-adv allows to set the debug message
verbosity per mesh/soft-interface and not per module (via modparam).

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to set/get the
configuration of this feature using the u32 (bitmask) BATADV_ATTR_LOG_LEVEL
attribute.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batman_adv.h |  6 ++++++
 net/batman-adv/netlink.c        | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index b37cb923332e..6d36e4b47eb4 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -449,6 +449,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_HOP_PENALTY,
 
+	/**
+	 * @BATADV_ATTR_LOG_LEVEL: bitmask with to define which debug messages
+	 *  should be send to the debug log/trace ring buffer
+	 */
+	BATADV_ATTR_LOG_LEVEL,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index ce6e6f078765..8c019d46815c 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -53,6 +53,7 @@
 #include "gateway_client.h"
 #include "gateway_common.h"
 #include "hard-interface.h"
+#include "log.h"
 #include "multicast.h"
 #include "originator.h"
 #include "soft-interface.h"
@@ -153,6 +154,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_GW_MODE]			= { .type = NLA_U8 },
 	[BATADV_ATTR_GW_SEL_CLASS]		= { .type = NLA_U32 },
 	[BATADV_ATTR_HOP_PENALTY]		= { .type = NLA_U8 },
+	[BATADV_ATTR_LOG_LEVEL]			= { .type = NLA_U32 },
 };
 
 /**
@@ -335,6 +337,12 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 		       atomic_read(&bat_priv->hop_penalty)))
 		goto nla_put_failure;
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+	if (nla_put_u32(msg, BATADV_ATTR_LOG_LEVEL,
+			atomic_read(&bat_priv->log_level)))
+		goto nla_put_failure;
+#endif /* CONFIG_BATMAN_ADV_DEBUG */
+
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
@@ -547,6 +555,15 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		atomic_set(&bat_priv->hop_penalty, nla_get_u8(attr));
 	}
 
+#ifdef CONFIG_BATMAN_ADV_DEBUG
+	if (info->attrs[BATADV_ATTR_LOG_LEVEL]) {
+		attr = info->attrs[BATADV_ATTR_LOG_LEVEL];
+
+		atomic_set(&bat_priv->log_level,
+			   nla_get_u32(attr) & BATADV_DBG_ALL);
+	}
+#endif /* CONFIG_BATMAN_ADV_DEBUG */
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
-- 
2.11.0

