Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Feb 2019 10:55:12 +0100
Message-Id: <20190213095524.10147-10-sw@simonwunderlich.de>
In-Reply-To: <20190213095524.10147-1-sw@simonwunderlich.de>
References: <20190213095524.10147-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 09/21] batman-adv: Add bonding mesh genl
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

The mesh interface can use multiple slave/hard-interface ports at the same
time to transport the traffic to other nodes.

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to set/get the
configuration of this feature using the BATADV_ATTR_BONDING_ENABLED
attribute. Setting the u8 to zero will disable this feature and setting it
to something else is enabling this feature.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batman_adv.h |  6 ++++++
 net/batman-adv/netlink.c        | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index a4dadafe08dd..f74ff261ec8f 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -375,6 +375,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_ISOLATION_MASK,
 
+	/**
+	 * @BATADV_ATTR_BONDING_ENABLED: whether the data traffic going through
+	 *  the mesh will be sent using multiple interfaces at the same time.
+	 */
+	BATADV_ATTR_BONDING_ENABLED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index fc80f003ed6e..310a2c339fd1 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -143,6 +143,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_AP_ISOLATION_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_ISOLATION_MARK]		= { .type = NLA_U32 },
 	[BATADV_ATTR_ISOLATION_MASK]		= { .type = NLA_U32 },
+	[BATADV_ATTR_BONDING_ENABLED]		= { .type = NLA_U8 },
 };
 
 /**
@@ -279,6 +280,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 			bat_priv->isolation_mark_mask))
 		goto nla_put_failure;
 
+	if (nla_put_u8(msg, BATADV_ATTR_BONDING_ENABLED,
+		       !!atomic_read(&bat_priv->bonding)))
+		goto nla_put_failure;
+
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
@@ -387,6 +392,12 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		bat_priv->isolation_mark_mask = nla_get_u32(attr);
 	}
 
+	if (info->attrs[BATADV_ATTR_BONDING_ENABLED]) {
+		attr = info->attrs[BATADV_ATTR_BONDING_ENABLED];
+
+		atomic_set(&bat_priv->bonding, !!nla_get_u8(attr));
+	}
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
-- 
2.11.0

