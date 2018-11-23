Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 23 Nov 2018 17:13:42 +0100
Message-Id: <20181123161359.13342-3-sven@narfation.org>
In-Reply-To: <20181123161359.13342-1-sven@narfation.org>
References: <20181123161359.13342-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v2 02/19] batman-adv: Prepare framework for
 mesh genl config
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

The main objects for this configuration is the mesh/soft-interface object.
Its actual object in memory already contains most of the available
configuration settings. The genl interface reflects this by allowing to
get/set it using the mesh specific commands.

The BATADV_CMD_GET_MESH_INFO (or short version BATADV_CMD_GET_MESH) is
reused as get command because it already provides the content of other
information from the mesh/soft-interface which are not yet configuration
specific.

The set command BATADV_CMD_SET_MESH will also notify interested userspace
listeners of the "config" mcast group using the BATADV_CMD_SET_MESH command
message type that settings might have been changed and what the current
values are.

Cc: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h |  16 +++-
 net/batman-adv/netlink.c        | 159 +++++++++++++++++++-------------
 2 files changed, 110 insertions(+), 65 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 324a0e11..2d6a175e 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -27,6 +27,7 @@
 
 #define BATADV_NL_NAME "batadv"
 
+#define BATADV_NL_MCAST_GROUP_CONFIG	"config"
 #define BATADV_NL_MCAST_GROUP_TPMETER	"tpmeter"
 
 /**
@@ -372,10 +373,14 @@ enum batadv_nl_commands {
 	BATADV_CMD_UNSPEC,
 
 	/**
-	 * @BATADV_CMD_GET_MESH_INFO: Query basic information about batman-adv
-	 * device
+	 * @BATADV_CMD_GET_MESH: Get attributes from softif/mesh
 	 */
-	BATADV_CMD_GET_MESH_INFO,
+	BATADV_CMD_GET_MESH,
+
+	/**
+	 * @BATADV_CMD_GET_MESH_INFO: Alias for @BATADV_CMD_GET_MESH
+	 */
+	BATADV_CMD_GET_MESH_INFO = BATADV_CMD_GET_MESH,
 
 	/**
 	 * @BATADV_CMD_TP_METER: Start a tp meter session
@@ -443,6 +448,11 @@ enum batadv_nl_commands {
 	 */
 	BATADV_CMD_GET_MCAST_FLAGS,
 
+	/**
+	 * @BATADV_CMD_SET_MESH: Set attributes for softif/mesh
+	 */
+	BATADV_CMD_SET_MESH,
+
 	/* add new commands above here */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index b20801a3..d89761f8 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -62,6 +62,7 @@ struct genl_family batadv_netlink_family;
 
 /* multicast groups */
 enum batadv_netlink_multicast_groups {
+	BATADV_NL_MCGRP_CONFIG,
 	BATADV_NL_MCGRP_TPMETER,
 };
 
@@ -78,6 +79,7 @@ enum batadv_genl_ops_flags {
 };
 
 static const struct genl_multicast_group batadv_netlink_mcgrps[] = {
+	[BATADV_NL_MCGRP_CONFIG] = { .name = BATADV_NL_MCAST_GROUP_CONFIG },
 	[BATADV_NL_MCGRP_TPMETER] = { .name = BATADV_NL_MCAST_GROUP_TPMETER },
 };
 
@@ -138,20 +140,29 @@ batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype)
 }
 
 /**
- * batadv_netlink_mesh_info_put() - fill in generic information about mesh
- *  interface
- * @msg: netlink message to be sent back
- * @soft_iface: interface for which the data should be taken
+ * batadv_netlink_mesh_put() - Fill message with mesh attributes
+ * @msg: Netlink message to dump into
+ * @bat_priv: the bat priv with all the soft interface information
+ * @cmd: type of message to generate
+ * @portid: Port making netlink request
+ * @seq: sequence number for message
+ * @flags: Additional flags for message
  *
- * Return: 0 on success, < 0 on error
+ * Return: 0 on success or negative error number in case of failure
  */
-static int
-batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
+static int batadv_netlink_mesh_put(struct sk_buff *msg,
+				   struct batadv_priv *bat_priv,
+				   enum batadv_nl_commands cmd,
+				   u32 portid, u32 seq, int flags)
 {
-	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct net_device *soft_iface = bat_priv->soft_iface;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct net_device *hard_iface;
-	int ret = -ENOBUFS;
+	void *hdr;
+
+	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family, flags, cmd);
+	if (!hdr)
+		return -ENOBUFS;
 
 	if (nla_put_string(msg, BATADV_ATTR_VERSION, BATADV_SOURCE_VERSION) ||
 	    nla_put_string(msg, BATADV_ATTR_ALGO_NAME,
@@ -162,16 +173,16 @@ batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
 		    soft_iface->dev_addr) ||
 	    nla_put_u8(msg, BATADV_ATTR_TT_TTVN,
 		       (u8)atomic_read(&bat_priv->tt.vn)))
-		goto out;
+		goto nla_put_failure;
 
 #ifdef CONFIG_BATMAN_ADV_BLA
 	if (nla_put_u16(msg, BATADV_ATTR_BLA_CRC,
 			ntohs(bat_priv->bla.claim_dest.group)))
-		goto out;
+		goto nla_put_failure;
 #endif
 
 	if (batadv_mcast_mesh_info_put(msg, bat_priv))
-		goto out;
+		goto nla_put_failure;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (primary_if && primary_if->if_status == BATADV_IF_ACTIVE) {
@@ -183,77 +194,94 @@ batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
 				   hard_iface->name) ||
 		    nla_put(msg, BATADV_ATTR_HARD_ADDRESS, ETH_ALEN,
 			    hard_iface->dev_addr))
-			goto out;
+			goto nla_put_failure;
 	}
 
-	ret = 0;
+	batadv_hardif_put(primary_if);
 
- out:
+	genlmsg_end(msg, hdr);
+	return 0;
+
+nla_put_failure:
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
-	return ret;
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
 }
 
 /**
- * batadv_netlink_get_mesh_info() - handle incoming BATADV_CMD_GET_MESH_INFO
- *  netlink request
- * @skb: received netlink message
- * @info: receiver information
+ * batadv_netlink_notify_mesh() - send softif attributes to listener
+ * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: 0 on success, < 0 on error
  */
-static int
-batadv_netlink_get_mesh_info(struct sk_buff *skb, struct genl_info *info)
+static int batadv_netlink_notify_mesh(struct batadv_priv *bat_priv)
 {
-	struct net *net = genl_info_net(info);
-	struct net_device *soft_iface;
-	struct sk_buff *msg = NULL;
-	void *msg_head;
-	int ifindex;
+	struct sk_buff *msg;
 	int ret;
 
-	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
-		return -EINVAL;
-
-	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
-	if (!ifindex)
-		return -EINVAL;
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
 
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
+	ret = batadv_netlink_mesh_put(msg, bat_priv, BATADV_CMD_SET_MESH,
+				      0, 0, 0);
+	if (ret < 0) {
+		nlmsg_free(msg);
+		return ret;
 	}
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	genlmsg_multicast_netns(&batadv_netlink_family,
+				dev_net(bat_priv->soft_iface), msg, 0,
+				BATADV_NL_MCGRP_CONFIG, GFP_KERNEL);
 
-	msg_head = genlmsg_put(msg, info->snd_portid, info->snd_seq,
-			       &batadv_netlink_family, 0,
-			       BATADV_CMD_GET_MESH_INFO);
-	if (!msg_head) {
-		ret = -ENOBUFS;
-		goto out;
-	}
+	return 0;
+}
 
-	ret = batadv_netlink_mesh_info_put(msg, soft_iface);
+/**
+ * batadv_netlink_get_mesh() - Get softif attributes
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_netlink_get_mesh(struct sk_buff *skb, struct genl_info *info)
+{
+	struct batadv_priv *bat_priv = info->user_ptr[0];
+	struct sk_buff *msg;
+	int ret;
 
- out:
-	if (soft_iface)
-		dev_put(soft_iface);
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
 
-	if (ret) {
-		if (msg)
-			nlmsg_free(msg);
+	ret = batadv_netlink_mesh_put(msg, bat_priv, BATADV_CMD_GET_MESH,
+				      info->snd_portid, info->snd_seq, 0);
+	if (ret < 0) {
+		nlmsg_free(msg);
 		return ret;
 	}
 
-	genlmsg_end(msg, msg_head);
-	return genlmsg_reply(msg, info);
+	ret = genlmsg_reply(msg, info);
+
+	return ret;
+}
+
+/**
+ * batadv_netlink_set_mesh() - Set softif attributes
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
+{
+	struct batadv_priv *bat_priv = info->user_ptr[0];
+
+	batadv_netlink_notify_mesh(bat_priv);
+
+	return 0;
 }
 
 /**
@@ -597,10 +625,11 @@ static void batadv_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 
 static const struct genl_ops batadv_netlink_ops[] = {
 	{
-		.cmd = BATADV_CMD_GET_MESH_INFO,
-		.flags = GENL_ADMIN_PERM,
+		.cmd = BATADV_CMD_GET_MESH,
+		/* can be retrieved by unprivileged users */
 		.policy = batadv_netlink_policy,
-		.doit = batadv_netlink_get_mesh_info,
+		.doit = batadv_netlink_get_mesh,
+		.internal_flags = BATADV_FLAG_NEED_MESH,
 	},
 	{
 		.cmd = BATADV_CMD_TP_METER,
@@ -682,7 +711,13 @@ static const struct genl_ops batadv_netlink_ops[] = {
 		.policy = batadv_netlink_policy,
 		.dumpit = batadv_mcast_flags_dump,
 	},
-
+	{
+		.cmd = BATADV_CMD_SET_MESH,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.doit = batadv_netlink_set_mesh,
+		.internal_flags = BATADV_FLAG_NEED_MESH,
+	},
 };
 
 struct genl_family batadv_netlink_family __ro_after_init = {
-- 
2.19.1

