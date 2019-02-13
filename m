Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Feb 2019 10:55:15 +0100
Message-Id: <20190213095524.10147-13-sw@simonwunderlich.de>
In-Reply-To: <20190213095524.10147-1-sw@simonwunderlich.de>
References: <20190213095524.10147-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 12/21] batman-adv: Add fragmentation mesh
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The mesh interface can fragment unicast packets when the packet size
exceeds the outgoing slave/hard-interface MTU.

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to set/get the
configuration of this feature using the BATADV_ATTR_FRAGMENTATION_ENABLED
attribute. Setting the u8 to zero will disable this feature and setting it
to something else is enabling this feature.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batman_adv.h |  7 +++++++
 net/batman-adv/netlink.c        | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index f303a1496476..847841b8de5d 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -396,6 +396,13 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED,
 
+	/**
+	 * @BATADV_ATTR_FRAGMENTATION_ENABLED: whether the data traffic going
+	 *  through the mesh will be fragmented or silently discarded if the
+	 *  packet size exceeds the outgoing interface MTU.
+	 */
+	BATADV_ATTR_FRAGMENTATION_ENABLED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 3028c2a5c782..5b2160d2f482 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -146,6 +146,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_BONDING_ENABLED]		= { .type = NLA_U8 },
 	[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED]	= { .type = NLA_U8 },
+	[BATADV_ATTR_FRAGMENTATION_ENABLED]	= { .type = NLA_U8 },
 };
 
 /**
@@ -298,6 +299,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
+	if (nla_put_u8(msg, BATADV_ATTR_FRAGMENTATION_ENABLED,
+		       !!atomic_read(&bat_priv->fragmentation)))
+		goto nla_put_failure;
+
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
@@ -432,6 +437,13 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	}
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
+	if (info->attrs[BATADV_ATTR_FRAGMENTATION_ENABLED]) {
+		attr = info->attrs[BATADV_ATTR_FRAGMENTATION_ENABLED];
+
+		atomic_set(&bat_priv->fragmentation, !!nla_get_u8(attr));
+		batadv_update_min_mtu(bat_priv->soft_iface);
+	}
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
-- 
2.11.0

