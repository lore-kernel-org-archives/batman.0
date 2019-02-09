Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:41:00 +0100
Message-Id: <20190209134109.14908-11-sven@narfation.org>
In-Reply-To: <20190209134109.14908-1-sven@narfation.org>
References: <20190209134109.14908-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 10/19] batman-adv: Add fragmentation mesh
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
Cc: Sven Eckelmann <sven@narfation.org>, Andreas Langer <an.langer@gmx.de>, Martin Hundeboll <martin@hundeboll.net>, Marek Lindner <mareklindner@neomailbox.ch>

The mesh interface can fragment unicast packets when the packet size
exceeds the outgoing slave/hard-interface MTU.

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to set/get the
configuration of this feature using the BATADV_ATTR_FRAGMENTATION_ENABLED
attribute. Setting the u8 to zero will disable this feature and setting it
to something else is enabling this feature.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Andreas Langer <an.langer@gmx.de>
Cc: Martin Hundeboll <martin@hundeboll.net>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
---
 include/uapi/linux/batman_adv.h |  7 +++++++
 net/batman-adv/netlink.c        | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index f303a149..847841b8 100644
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
index 3028c2a5..5b2160d2 100644
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
2.20.1

