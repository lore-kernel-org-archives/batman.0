Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 19 Jan 2019 16:56:15 +0100
Message-Id: <20190119155626.6414-9-sven@narfation.org>
In-Reply-To: <20190119155626.6414-1-sven@narfation.org>
References: <20190119155626.6414-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v4 08/19] batman-adv: Add bridge_loop_avoidance
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

The mesh interface can try to detect loops in the same mesh caused by
(indirectly) bridged mesh/soft-interfaces of different nodes. Some of the
loops can also be resolved without breaking the mesh.

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to set/get the
configuration of this feature using the
BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED attribute. Setting the u8 to zero
will disable this feature and setting it to something else is enabling this
feature.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batman_adv.h |  7 +++++++
 net/batman-adv/netlink.c        | 17 +++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index f74ff261..3cb35c66 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -381,6 +381,13 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_BONDING_ENABLED,
 
+	/**
+	 * @BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED: whether the bridge loop
+	 *  avoidance feature is enabled. This feature detects and avoids loops
+	 *  between the mesh and devices bridged with the soft interface
+	 */
+	BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 8a309c78..0a29dc75 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -144,6 +144,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_ISOLATION_MARK]		= { .type = NLA_U32 },
 	[BATADV_ATTR_ISOLATION_MASK]		= { .type = NLA_U32 },
 	[BATADV_ATTR_BONDING_ENABLED]		= { .type = NLA_U8 },
+	[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED]	= { .type = NLA_U8 },
 };
 
 /**
@@ -284,6 +285,12 @@ static int batadv_netlink_mesh_put(struct sk_buff *msg,
 		       !!atomic_read(&bat_priv->bonding)))
 		goto nla_put_failure;
 
+#ifdef CONFIG_BATMAN_ADV_BLA
+	if (nla_put_u8(msg, BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED,
+		       !!atomic_read(&bat_priv->bridge_loop_avoidance)))
+		goto nla_put_failure;
+#endif /* CONFIG_BATMAN_ADV_BLA */
+
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
@@ -398,6 +405,16 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		atomic_set(&bat_priv->bonding, !!nla_get_u8(attr));
 	}
 
+#ifdef CONFIG_BATMAN_ADV_BLA
+	if (info->attrs[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED]) {
+		attr = info->attrs[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED];
+
+		atomic_set(&bat_priv->bridge_loop_avoidance,
+			   !!nla_get_u8(attr));
+		batadv_bla_status_update(bat_priv->soft_iface);
+	}
+#endif /* CONFIG_BATMAN_ADV_BLA */
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
-- 
2.20.1

