Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:40:56 +0100
Message-Id: <20190209134109.14908-7-sven@narfation.org>
In-Reply-To: <20190209134109.14908-1-sven@narfation.org>
References: <20190209134109.14908-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 06/19] batman-adv: Add ap_isolation
 mesh/vlan genl configuration
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
Cc: Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <a@unstable.cc>

The mesh interface can drop messages between clients to implement a
mesh-wide AP isolation.

The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH and
BATADV_CMD_SET_VLAN/BATADV_CMD_GET_VLAN commands allow to set/get the
configuration of this feature using the BATADV_ATTR_AP_ISOLATION_ENABLED
attribute. Setting the u8 to zero will disable this feature and setting it
to something else is enabling this feature.

This feature also requires that skbuff which should be handled as isolated
are marked. The BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH commands allow to
set/get the mark/mask using the u32 attributes BATADV_ATTR_ISOLATION_MARK
and BATADV_ATTR_ISOLATION_MASK.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Antonio Quartulli <a@unstable.cc>
---
 include/uapi/linux/batman_adv.h | 19 +++++++
 net/batman-adv/netlink.c        | 89 +++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index f8941e80..a4dadafe 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -356,6 +356,25 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_AGGREGATED_OGMS_ENABLED,
 
+	/**
+	 * @BATADV_ATTR_AP_ISOLATION_ENABLED: whether the data traffic going
+	 *  from a wireless client to another wireless client will be silently
+	 *  dropped.
+	 */
+	BATADV_ATTR_AP_ISOLATION_ENABLED,
+
+	/**
+	 * @BATADV_ATTR_ISOLATION_MARK: the isolation mark which is used to
+	 *  classify clients as "isolated" by the Extended Isolation feature.
+	 */
+	BATADV_ATTR_ISOLATION_MARK,
+
+	/**
+	 * @BATADV_ATTR_ISOLATION_MASK: the isolation (bit)mask which is used to
+	 *  classify clients as "isolated" by the Extended Isolation feature.
+	 */
+	BATADV_ATTR_ISOLATION_MASK,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 82665dc2..fc80f003 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -140,6 +140,9 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_MCAST_FLAGS_PRIV]		= { .type = NLA_U32 },
 	[BATADV_ATTR_VLANID]			= { .type = NLA_U16 },
 	[BATADV_ATTR_AGGREGATED_OGMS_ENABLED]	= { .type = NLA_U8 },
+	[BATADV_ATTR_AP_ISOLATION_ENABLED]	= { .type = NLA_U8 },
+	[BATADV_ATTR_ISOLATION_MARK]		= { .type = NLA_U32 },
+	[BATADV_ATTR_ISOLATION_MASK]		= { .type = NLA_U32 },
 };
 
 /**
@@ -157,6 +160,52 @@ batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype)
 	return attr ? nla_get_u32(attr) : 0;
 }
 
+/**
+ * batadv_netlink_mesh_fill_ap_isolation() - Add ap_isolation softif attribute
+ * @msg: Netlink message to dump into
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_netlink_mesh_fill_ap_isolation(struct sk_buff *msg,
+						 struct batadv_priv *bat_priv)
+{
+	struct batadv_softif_vlan *vlan;
+	u8 ap_isolation;
+
+	vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
+	if (!vlan)
+		return 0;
+
+	ap_isolation = atomic_read(&vlan->ap_isolation);
+	batadv_softif_vlan_put(vlan);
+
+	return nla_put_u8(msg, BATADV_ATTR_AP_ISOLATION_ENABLED,
+			  !!ap_isolation);
+}
+
+/**
+ * batadv_option_set_ap_isolation() - Set ap_isolation from genl msg
+ * @attr: parsed BATADV_ATTR_AP_ISOLATION_ENABLED attribute
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_netlink_set_mesh_ap_isolation(struct nlattr *attr,
+						struct batadv_priv *bat_priv)
+{
+	struct batadv_softif_vlan *vlan;
+
+	vlan = batadv_softif_vlan_get(bat_priv, BATADV_NO_FLAGS);
+	if (!vlan)
+		return -ENOENT;
+
+	atomic_set(&vlan->ap_isolation, !!nla_get_u8(attr));
+	batadv_softif_vlan_put(vlan);
+
+	return 0;
+}
+
 /**
  * batadv_netlink_mesh_fill() - Fill message with mesh attributes
  * @msg: Netlink message to dump into
@@ -219,6 +268,17 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 		       !!atomic_read(&bat_priv->aggregated_ogms)))
 		goto nla_put_failure;
 
+	if (batadv_netlink_mesh_fill_ap_isolation(msg, bat_priv))
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_ISOLATION_MARK,
+			bat_priv->isolation_mark))
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_ISOLATION_MASK,
+			bat_priv->isolation_mark_mask))
+		goto nla_put_failure;
+
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
@@ -309,6 +369,24 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		atomic_set(&bat_priv->aggregated_ogms, !!nla_get_u8(attr));
 	}
 
+	if (info->attrs[BATADV_ATTR_AP_ISOLATION_ENABLED]) {
+		attr = info->attrs[BATADV_ATTR_AP_ISOLATION_ENABLED];
+
+		batadv_netlink_set_mesh_ap_isolation(attr, bat_priv);
+	}
+
+	if (info->attrs[BATADV_ATTR_ISOLATION_MARK]) {
+		attr = info->attrs[BATADV_ATTR_ISOLATION_MARK];
+
+		bat_priv->isolation_mark = nla_get_u32(attr);
+	}
+
+	if (info->attrs[BATADV_ATTR_ISOLATION_MASK]) {
+		attr = info->attrs[BATADV_ATTR_ISOLATION_MASK];
+
+		bat_priv->isolation_mark_mask = nla_get_u32(attr);
+	}
+
 	batadv_netlink_notify_mesh(bat_priv);
 
 	return 0;
@@ -705,6 +783,10 @@ static int batadv_netlink_vlan_fill(struct sk_buff *msg,
 	if (nla_put_u32(msg, BATADV_ATTR_VLANID, vlan->vid & VLAN_VID_MASK))
 		goto nla_put_failure;
 
+	if (nla_put_u8(msg, BATADV_ATTR_AP_ISOLATION_ENABLED,
+		       !!atomic_read(&vlan->ap_isolation)))
+		goto nla_put_failure;
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
@@ -785,6 +867,13 @@ static int batadv_netlink_set_vlan(struct sk_buff *skb, struct genl_info *info)
 {
 	struct batadv_softif_vlan *vlan = info->user_ptr[1];
 	struct batadv_priv *bat_priv = info->user_ptr[0];
+	struct nlattr *attr;
+
+	if (info->attrs[BATADV_ATTR_AP_ISOLATION_ENABLED]) {
+		attr = info->attrs[BATADV_ATTR_AP_ISOLATION_ENABLED];
+
+		atomic_set(&vlan->ap_isolation, !!nla_get_u8(attr));
+	}
 
 	batadv_netlink_notify_vlan(bat_priv, vlan);
 
-- 
2.20.1

