Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 23 Nov 2018 17:13:44 +0100
Message-Id: <20181123161359.13342-5-sven@narfation.org>
In-Reply-To: <20181123161359.13342-1-sven@narfation.org>
References: <20181123161359.13342-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v2 04/19] batman-adv: Prepare framework for
 vlan genl config
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

The batman-adv configuration interface was implemented solely using sysfs.
This approach was condemned by non-batadv developers as "huge mistake".
Instead a netlink/genl based implementation was suggested.

Beside the mesh/soft-interface specific configuration, the VLANs on top of
the mesh/soft-interface have configuration settings. The genl interface
reflects this by allowing to get/set it using the vlan specific commands
BATADV_CMD_GET_VLAN/BATADV_CMD_SET_VLAN.

The set command BATADV_CMD_SET_MESH will also notify interested userspace
listeners of the "config" mcast group using the BATADV_CMD_SET_VLAN command
message type that settings might have been changed and what the current
values are.

Cc: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h |  17 +++
 net/batman-adv/netlink.c        | 193 +++++++++++++++++++++++++++++++-
 2 files changed, 208 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index eb5097df..865cdf90 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -345,6 +345,11 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_MCAST_FLAGS_PRIV,
 
+	/**
+	 * @BATADV_ATTR_VLANID: VLAN id on top of soft interface
+	 */
+	BATADV_ATTR_VLANID,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
@@ -465,6 +470,18 @@ enum batadv_nl_commands {
 	 */
 	BATADV_CMD_SET_HARDIF,
 
+	/**
+	 * @BATADV_CMD_GET_VLAN: Get attributes from a VLAN of the
+	 *  current softif
+	 */
+	BATADV_CMD_GET_VLAN,
+
+	/**
+	 * @BATADV_CMD_SET_VLAN: Set attributes for VLAN of the
+	 *  current softif
+	 */
+	BATADV_CMD_SET_VLAN,
+
 	/* add new commands above here */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 68116eb8..30ed0672 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -30,6 +30,7 @@
 #include <linux/genetlink.h>
 #include <linux/gfp.h>
 #include <linux/if_ether.h>
+#include <linux/if_vlan.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -84,6 +85,13 @@ enum batadv_genl_ops_flags {
 	 *  safed in info->user_ptr[1]
 	 */
 	BATADV_FLAG_NEED_HARDIF = BIT(1),
+
+	/**
+	 * @BATADV_FLAG_NEED_VLAN: request requires valid vlan in
+	 *  attribute BATADV_ATTR_VLANID and expects a pointer to it to be
+	 *  safed in info->user_ptr[1]
+	 */
+	BATADV_FLAG_NEED_VLAN = BIT(2),
 };
 
 static const struct genl_multicast_group batadv_netlink_mcgrps[] = {
@@ -130,6 +138,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_DAT_CACHE_VID]		= { .type = NLA_U16 },
 	[BATADV_ATTR_MCAST_FLAGS]		= { .type = NLA_U32 },
 	[BATADV_ATTR_MCAST_FLAGS_PRIV]		= { .type = NLA_U32 },
+	[BATADV_ATTR_VLANID]			= { .type = NLA_U16 },
 };
 
 /**
@@ -652,6 +661,123 @@ batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 	return msg->len;
 }
 
+/**
+ * batadv_netlink_vlan_put() - Fill message with vlan attributes
+ * @msg: Netlink message to dump into
+ * @bat_priv: the bat priv with all the soft interface information
+ * @vlan: vlan which was modified
+ * @cmd: type of message to generate
+ * @portid: Port making netlink request
+ * @seq: sequence number for message
+ * @flags: Additional flags for message
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_netlink_vlan_put(struct sk_buff *msg,
+				   struct batadv_priv *bat_priv,
+				   struct batadv_softif_vlan *vlan,
+				   enum batadv_nl_commands cmd,
+				   u32 portid, u32 seq, int flags)
+{
+	void *hdr;
+
+	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family, flags, cmd);
+	if (!hdr)
+		return -ENOBUFS;
+
+	if (nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX,
+			bat_priv->soft_iface->ifindex))
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_VLANID, vlan->vid & VLAN_VID_MASK))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+/**
+ * batadv_netlink_notify_vlan() - send vlan attributes to listener
+ * @bat_priv: the bat priv with all the soft interface information
+ * @vlan: vlan which was modified
+ *
+ * Return: 0 on success, < 0 on error
+ */
+static int batadv_netlink_notify_vlan(struct batadv_priv *bat_priv,
+				      struct batadv_softif_vlan *vlan)
+{
+	struct sk_buff *msg;
+	int ret;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = batadv_netlink_vlan_put(msg, bat_priv, vlan,
+				      BATADV_CMD_SET_VLAN, 0, 0, 0);
+	if (ret < 0) {
+		nlmsg_free(msg);
+		return ret;
+	}
+
+	genlmsg_multicast_netns(&batadv_netlink_family,
+				dev_net(bat_priv->soft_iface), msg, 0,
+				BATADV_NL_MCGRP_CONFIG, GFP_KERNEL);
+
+	return 0;
+}
+
+/**
+ * batadv_netlink_get_vlan() - Get vlan attributes
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_netlink_get_vlan(struct sk_buff *skb, struct genl_info *info)
+{
+	struct batadv_softif_vlan *vlan = info->user_ptr[1];
+	struct batadv_priv *bat_priv = info->user_ptr[0];
+	struct sk_buff *msg;
+	int ret;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = batadv_netlink_vlan_put(msg, bat_priv, vlan, BATADV_CMD_GET_VLAN,
+				      info->snd_portid, info->snd_seq, 0);
+	if (ret < 0) {
+		nlmsg_free(msg);
+		return ret;
+	}
+
+	ret = genlmsg_reply(msg, info);
+
+	return ret;
+}
+
+/**
+ * batadv_netlink_set_vlan() - Get vlan attributes
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_netlink_set_vlan(struct sk_buff *skb, struct genl_info *info)
+{
+	struct batadv_softif_vlan *vlan = info->user_ptr[1];
+	struct batadv_priv *bat_priv = info->user_ptr[0];
+
+	batadv_netlink_notify_vlan(bat_priv, vlan);
+
+	return 0;
+}
+
 /**
  * batadv_get_softif_from_info() - Retrieve soft interface from genl attributes
  * @net: the applicable net namespace
@@ -727,6 +853,33 @@ batadv_get_hardif_from_info(struct batadv_priv *bat_priv, struct net *net,
 	return ERR_PTR(-EINVAL);
 }
 
+/**
+ * batadv_get_vlan_from_info() - Retrieve vlan from genl attributes
+ * @bat_priv: the bat priv with all the soft interface information
+ * @net: the applicable net namespace
+ * @info: receiver information
+ *
+ * Return: Pointer to vlan on success, error pointer on error
+ */
+static struct batadv_softif_vlan *
+batadv_get_vlan_from_info(struct batadv_priv *bat_priv, struct net *net,
+			  struct genl_info *info)
+{
+	struct batadv_softif_vlan *vlan;
+	u16 vid;
+
+	if (!info->attrs[BATADV_ATTR_VLANID])
+		return ERR_PTR(-EINVAL);
+
+	vid = nla_get_u16(info->attrs[BATADV_ATTR_VLANID]);
+
+	vlan = batadv_softif_vlan_get(bat_priv, vid | BATADV_VLAN_HAS_TAG);
+	if (!vlan)
+		return ERR_PTR(-ENOENT);
+
+	return vlan;
+}
+
 /**
  * batadv_pre_doit() - Prepare batman-adv genl doit request
  * @ops: requested netlink operation
@@ -740,12 +893,15 @@ static int batadv_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 {
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_priv *bat_priv = NULL;
+	struct batadv_softif_vlan *vlan;
 	int ret;
 
-	if (WARN_ON(ops->internal_flags & BATADV_FLAG_NEED_HARDIF))
+	if (WARN_ON((ops->internal_flags & BATADV_FLAG_NEED_HARDIF) &&
+		    (ops->internal_flags & BATADV_FLAG_NEED_VLAN)))
 		return -EINVAL;
 
-	if (WARN_ON((ops->internal_flags & BATADV_FLAG_NEED_HARDIF) &&
+	if (WARN_ON(((ops->internal_flags & BATADV_FLAG_NEED_HARDIF) ||
+		     (ops->internal_flags & BATADV_FLAG_NEED_VLAN)) &&
 		    (~ops->internal_flags & BATADV_FLAG_NEED_MESH)))
 		return -EINVAL;
 
@@ -770,6 +926,17 @@ static int batadv_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		info->user_ptr[1] = hard_iface;
 	}
 
+	if (ops->internal_flags & BATADV_FLAG_NEED_VLAN) {
+		vlan = batadv_get_vlan_from_info(bat_priv, genl_info_net(info),
+						 info);
+		if (IS_ERR(vlan)) {
+			ret = PTR_ERR(vlan);
+			goto err_put_softif;
+		}
+
+		info->user_ptr[1] = vlan;
+	}
+
 	return 0;
 
 err_put_softif:
@@ -789,6 +956,7 @@ static void batadv_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 			     struct genl_info *info)
 {
 	struct batadv_hard_iface *hard_iface;
+	struct batadv_softif_vlan *vlan;
 	struct batadv_priv *bat_priv;
 	struct net_device *hard_dev;
 
@@ -801,6 +969,11 @@ static void batadv_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		dev_put(hard_dev);
 	}
 
+	if (ops->internal_flags & BATADV_FLAG_NEED_VLAN && info->user_ptr[1]) {
+		vlan = info->user_ptr[1];
+		batadv_softif_vlan_put(vlan);
+	}
+
 	if (ops->internal_flags & BATADV_FLAG_NEED_MESH && info->user_ptr[0]) {
 		bat_priv = info->user_ptr[0];
 		dev_put(bat_priv->soft_iface);
@@ -913,6 +1086,22 @@ static const struct genl_ops batadv_netlink_ops[] = {
 		.internal_flags = BATADV_FLAG_NEED_MESH |
 				  BATADV_FLAG_NEED_HARDIF,
 	},
+	{
+		.cmd = BATADV_CMD_GET_VLAN,
+		/* can be retrieved by unprivileged users */
+		.policy = batadv_netlink_policy,
+		.doit = batadv_netlink_get_vlan,
+		.internal_flags = BATADV_FLAG_NEED_MESH |
+				  BATADV_FLAG_NEED_VLAN,
+	},
+	{
+		.cmd = BATADV_CMD_SET_VLAN,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.doit = batadv_netlink_set_vlan,
+		.internal_flags = BATADV_FLAG_NEED_MESH |
+				  BATADV_FLAG_NEED_VLAN,
+	},
 };
 
 struct genl_family batadv_netlink_family __ro_after_init = {
-- 
2.19.1

