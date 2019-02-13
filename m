Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Feb 2019 10:55:14 +0100
Message-Id: <20190213095524.10147-12-sw@simonwunderlich.de>
In-Reply-To: <20190213095524.10147-1-sw@simonwunderlich.de>
References: <20190213095524.10147-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 11/21] batman-adv: Add distributed_arp_table
 mesh genl configuration
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

The mesh interface can use a distributed hash table to answer ARP requests
without flooding the request through the whole mesh.

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to set/get the
configuration of this feature using the
BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED attribute. Setting the u8 to zero
will disable this feature and setting it to something else is enabling this
feature.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batman_adv.h |  8 ++++++++
 net/batman-adv/netlink.c        | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 3cb35c661056..f303a1496476 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -388,6 +388,14 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED,
 
+	/**
+	 * @BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED: whether the distributed
+	 *  arp table feature is enabled. This feature uses a distributed hash
+	 *  table to answer ARP requests without flooding the request through
+	 *  the whole mesh.
+	 */
+	BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 40c940da9498..3028c2a5c782 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -145,6 +145,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_ISOLATION_MASK]		= { .type = NLA_U32 },
 	[BATADV_ATTR_BONDING_ENABLED]		= { .type = NLA_U8 },
 	[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED]	= { .type = NLA_U8 },
+	[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED]	= { .type = NLA_U8 },
 };
 
 /**
@@ -291,6 +292,12 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_BLA */
 
+#ifdef CONFIG_BATMAN_ADV_DAT
+	if (nla_put_u8(msg, BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED,
+		       !!atomic_read(&bat_priv->distributed_arp_table)))
+		goto nla_put_failure;
+#endif /* CONFIG_BATMAN_ADV_DAT */
+
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
@@ -415,6 +422,16 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	}
 #endif /* CONFIG_BATMAN_ADV_BLA */
 
+#ifdef CONFIG_BATMAN_ADV_DAT
+	if (info->attrs[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED]) {
+		attr = info->attrs[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED];
+
+		atomic_set(&bat_priv->distributed_arp_table,
+			   !!nla_get_u8(attr));
+		batadv_dat_status_update(bat_priv->soft_iface);
+	}
+#endif /* CONFIG_BATMAN_ADV_DAT */
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
-- 
2.11.0

