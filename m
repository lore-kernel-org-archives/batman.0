Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  7 Dec 2018 14:58:32 +0100
Message-Id: <20181207135846.6152-6-sven@narfation.org>
In-Reply-To: <20181207135846.6152-1-sven@narfation.org>
References: <20181207135846.6152-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v3 05/19] batman-adv: Add aggregated_ogms mesh
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
Cc: Sven Eckelmann <sven@narfation.org>, Marek Lindner <mareklindner@neomailbox.ch>

The mesh interface can delay OGM messages to aggregate different ogms
together in a single OGM packet.

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to set/get the
configuration of this feature using the BATADV_ATTR_AGGREGATED_OGMS
attribute. Setting the u8 to zero will disable this feature and setting it
to something else is enabling this feature.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Marek Lindner <mareklindner@neomailbox.ch>
---
 include/uapi/linux/batman_adv.h |  6 ++++++
 net/batman-adv/netlink.c        | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 865cdf90..a01d90ed 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -350,6 +350,12 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_VLANID,
 
+	/**
+	 * @BATADV_ATTR_AGGREGATED_OGMS: whether the batman protocol messages
+	 *  of the mesh mesh interface shall be aggregated or not.
+	 */
+	BATADV_ATTR_AGGREGATED_OGMS,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 30ed0672..862d47c4 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -139,6 +139,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_MCAST_FLAGS]		= { .type = NLA_U32 },
 	[BATADV_ATTR_MCAST_FLAGS_PRIV]		= { .type = NLA_U32 },
 	[BATADV_ATTR_VLANID]			= { .type = NLA_U16 },
+	[BATADV_ATTR_AGGREGATED_OGMS]		= { .type = NLA_U8 },
 };
 
 /**
@@ -214,6 +215,10 @@ static int batadv_netlink_mesh_put(struct sk_buff *msg,
 			goto nla_put_failure;
 	}
 
+	if (nla_put_u8(msg, BATADV_ATTR_AGGREGATED_OGMS,
+		       !!atomic_read(&bat_priv->aggregated_ogms)))
+		goto nla_put_failure;
+
 	batadv_hardif_put(primary_if);
 
 	genlmsg_end(msg, hdr);
@@ -295,6 +300,13 @@ static int batadv_netlink_get_mesh(struct sk_buff *skb, struct genl_info *info)
 static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 {
 	struct batadv_priv *bat_priv = info->user_ptr[0];
+	struct nlattr *attr;
+
+	if (info->attrs[BATADV_ATTR_AGGREGATED_OGMS]) {
+		attr = info->attrs[BATADV_ATTR_AGGREGATED_OGMS];
+
+		atomic_set(&bat_priv->aggregated_ogms, !!nla_get_u8(attr));
+	}
 
 	batadv_netlink_notify_mesh(bat_priv);
 
-- 
2.19.2

