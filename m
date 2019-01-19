Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 19 Jan 2019 16:56:21 +0100
Message-Id: <20190119155626.6414-15-sven@narfation.org>
In-Reply-To: <20190119155626.6414-1-sven@narfation.org>
References: <20190119155626.6414-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v4 14/19] batman-adv: Add multicast_mode mesh
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
Cc: Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org, Sven Eckelmann <sven@narfation.org>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

The mesh interface can optimize the flooding of multicast packets based on
the content of the global translation tables.

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to set/get the
configuration of this feature using the BATADV_ATTR_MULTICAST_MODE_ENABLED
attribute. Setting the u8 to zero will disable this feature and setting it
to something else is enabling this feature.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/batman_adv.h |  8 ++++++++
 net/batman-adv/netlink.c        | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 6d36e4b4..9f5c85a5 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -455,6 +455,14 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_LOG_LEVEL,
 
+	/**
+	 * @BATADV_ATTR_MULTICAST_MODE_ENABLED: whether multicast optimizations
+	 *  are enabled or disabled. If set to zero then all nodes in the mesh
+	 *  are going to use classic flooding for any multicast packet with no
+	 *  optimizations.
+	 */
+	BATADV_ATTR_MULTICAST_MODE_ENABLED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index d39f8f83..a0fbad39 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -155,6 +155,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_GW_SEL_CLASS]		= { .type = NLA_U32 },
 	[BATADV_ATTR_HOP_PENALTY]		= { .type = NLA_U8 },
 	[BATADV_ATTR_LOG_LEVEL]			= { .type = NLA_U32 },
+	[BATADV_ATTR_MULTICAST_MODE_ENABLED]	= { .type = NLA_U8 },
 };
 
 /**
@@ -343,6 +344,12 @@ static int batadv_netlink_mesh_put(struct sk_buff *msg,
 		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_DEBUG */
 
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	if (nla_put_u8(msg, BATADV_ATTR_MULTICAST_MODE_ENABLED,
+		       !!atomic_read(&bat_priv->multicast_mode)))
+		goto nla_put_failure;
+#endif /* CONFIG_BATMAN_ADV_MCAST */
+
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
@@ -564,6 +571,14 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 	}
 #endif /* CONFIG_BATMAN_ADV_DEBUG */
 
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	if (info->attrs[BATADV_ATTR_MULTICAST_MODE_ENABLED]) {
+		attr = info->attrs[BATADV_ATTR_MULTICAST_MODE_ENABLED];
+
+		atomic_set(&bat_priv->multicast_mode, !!nla_get_u8(attr));
+	}
+#endif /* CONFIG_BATMAN_ADV_MCAST */
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
-- 
2.20.1

