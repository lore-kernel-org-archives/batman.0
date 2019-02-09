Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:40:53 +0100
Message-Id: <20190209134109.14908-4-sven@narfation.org>
In-Reply-To: <20190209134109.14908-1-sven@narfation.org>
References: <20190209134109.14908-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 03/19] batman-adv: Prepare framework for
 hardif genl config
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

The batman-adv configuration interface was implemented solely using sysfs.
This approach was condemned by non-batadv developers as "huge mistake".
Instead a netlink/genl based implementation was suggested.

Beside the mesh/soft-interface specific configuration, the
slave/hard-interface have B.A.T.M.A.N. V specific configuration settings.
The genl interface reflects this by allowing to get/set it using the
hard-interface specific commands.

The BATADV_CMD_GET_HARDIFS (or short version BATADV_CMD_GET_HARDIF) is
reused as get command because it already allow sto dump the content of
other information from the slave/hard-interface which are not yet
configuration specific.

The set command BATADV_CMD_SET_HARDIF will also notify interested userspace
listeners of the "config" mcast group using the BATADV_CMD_SET_HARDIF
command message type that settings might have been changed and what the
current values are.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batman_adv.h |  16 ++-
 net/batman-adv/netlink.c        | 240 +++++++++++++++++++++++++++++---
 2 files changed, 233 insertions(+), 23 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index b3394aac..62456a08 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -398,9 +398,15 @@ enum batadv_nl_commands {
 	BATADV_CMD_GET_ROUTING_ALGOS,
 
 	/**
-	 * @BATADV_CMD_GET_HARDIFS: Query list of hard interfaces
+	 * @BATADV_CMD_GET_HARDIF: Get attributes from a hardif of the
+	 *  current softif
 	 */
-	BATADV_CMD_GET_HARDIFS,
+	BATADV_CMD_GET_HARDIF,
+
+	/**
+	 * @BATADV_CMD_GET_HARDIFS: Alias for @BATADV_CMD_GET_HARDIF
+	 */
+	BATADV_CMD_GET_HARDIFS = BATADV_CMD_GET_HARDIF,
 
 	/**
 	 * @BATADV_CMD_GET_TRANSTABLE_LOCAL: Query list of local translations
@@ -453,6 +459,12 @@ enum batadv_nl_commands {
 	 */
 	BATADV_CMD_SET_MESH,
 
+	/**
+	 * @BATADV_CMD_SET_HARDIF: Set attributes for hardif of the
+	 *  current softif
+	 */
+	BATADV_CMD_SET_HARDIF,
+
 	/* add new commands above here */
 
 	/**
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 179cc7cf..a184e422 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -21,6 +21,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bitops.h>
+#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
 #include <linux/err.h>
@@ -76,6 +77,13 @@ enum batadv_genl_ops_flags {
 	 *  saved in info->user_ptr[0]
 	 */
 	BATADV_FLAG_NEED_MESH = BIT(0),
+
+	/**
+	 * @BATADV_FLAG_NEED_HARDIF: request requires valid hard interface in
+	 *  attribute BATADV_ATTR_HARD_IFINDEX and expects a pointer to it to be
+	 *  saved in info->user_ptr[1]
+	 */
+	BATADV_FLAG_NEED_HARDIF = BIT(1),
 };
 
 static const struct genl_multicast_group batadv_netlink_mcgrps[] = {
@@ -446,29 +454,38 @@ batadv_netlink_tp_meter_cancel(struct sk_buff *skb, struct genl_info *info)
 }
 
 /**
- * batadv_netlink_dump_hardif_entry() - Dump one hard interface into a message
+ * batadv_netlink_hardif_fill() - Fill message with hardif attributes
  * @msg: Netlink message to dump into
+ * @bat_priv: the bat priv with all the soft interface information
+ * @hard_iface: hard interface which was modified
+ * @cmd: type of message to generate
  * @portid: Port making netlink request
+ * @seq: sequence number for message
+ * @flags: Additional flags for message
  * @cb: Control block containing additional options
- * @hard_iface: Hard interface to dump
  *
- * Return: error code, or 0 on success
+ * Return: 0 on success or negative error number in case of failure
  */
-static int
-batadv_netlink_dump_hardif_entry(struct sk_buff *msg, u32 portid,
-				 struct netlink_callback *cb,
-				 struct batadv_hard_iface *hard_iface)
+static int batadv_netlink_hardif_fill(struct sk_buff *msg,
+				      struct batadv_priv *bat_priv,
+				      struct batadv_hard_iface *hard_iface,
+				      enum batadv_nl_commands cmd,
+				      u32 portid, u32 seq, int flags,
+				      struct netlink_callback *cb)
 {
 	struct net_device *net_dev = hard_iface->net_dev;
 	void *hdr;
 
-	hdr = genlmsg_put(msg, portid, cb->nlh->nlmsg_seq,
-			  &batadv_netlink_family, NLM_F_MULTI,
-			  BATADV_CMD_GET_HARDIFS);
+	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family, flags, cmd);
 	if (!hdr)
-		return -EMSGSIZE;
+		return -ENOBUFS;
+
+	if (cb)
+		genl_dump_check_consistent(cb, hdr);
 
-	genl_dump_check_consistent(cb, hdr);
+	if (nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX,
+			bat_priv->soft_iface->ifindex))
+		goto nla_put_failure;
 
 	if (nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX,
 			net_dev->ifindex) ||
@@ -486,24 +503,107 @@ batadv_netlink_dump_hardif_entry(struct sk_buff *msg, u32 portid,
 	genlmsg_end(msg, hdr);
 	return 0;
 
- nla_put_failure:
+nla_put_failure:
 	genlmsg_cancel(msg, hdr);
 	return -EMSGSIZE;
 }
 
 /**
- * batadv_netlink_dump_hardifs() - Dump all hard interface into a messages
+ * batadv_netlink_notify_hardif() - send hardif attributes to listener
+ * @bat_priv: the bat priv with all the soft interface information
+ * @hard_iface: hard interface which was modified
+ *
+ * Return: 0 on success, < 0 on error
+ */
+static int batadv_netlink_notify_hardif(struct batadv_priv *bat_priv,
+					struct batadv_hard_iface *hard_iface)
+{
+	struct sk_buff *msg;
+	int ret;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = batadv_netlink_hardif_fill(msg, bat_priv, hard_iface,
+					 BATADV_CMD_SET_HARDIF, 0, 0, 0, NULL);
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
+ * batadv_netlink_get_hardif() - Get hardif attributes
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_netlink_get_hardif(struct sk_buff *skb,
+				     struct genl_info *info)
+{
+	struct batadv_hard_iface *hard_iface = info->user_ptr[1];
+	struct batadv_priv *bat_priv = info->user_ptr[0];
+	struct sk_buff *msg;
+	int ret;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = batadv_netlink_hardif_fill(msg, bat_priv, hard_iface,
+					 BATADV_CMD_GET_HARDIF,
+					 info->snd_portid, info->snd_seq, 0,
+					 NULL);
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
+ * batadv_netlink_set_hardif() - Set hardif attributes
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_netlink_set_hardif(struct sk_buff *skb,
+				     struct genl_info *info)
+{
+	struct batadv_hard_iface *hard_iface = info->user_ptr[1];
+	struct batadv_priv *bat_priv = info->user_ptr[0];
+
+	batadv_netlink_notify_hardif(bat_priv, hard_iface);
+
+	return 0;
+}
+
+/**
+ * batadv_netlink_dump_hardif() - Dump all hard interface into a messages
  * @msg: Netlink message to dump into
  * @cb: Parameters from query
  *
  * Return: error code, or length of reply message on success
  */
 static int
-batadv_netlink_dump_hardifs(struct sk_buff *msg, struct netlink_callback *cb)
+batadv_netlink_dump_hardif(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct net *net = sock_net(cb->skb->sk);
 	struct net_device *soft_iface;
 	struct batadv_hard_iface *hard_iface;
+	struct batadv_priv *bat_priv;
 	int ifindex;
 	int portid = NETLINK_CB(cb->skb).portid;
 	int skip = cb->args[0];
@@ -523,6 +623,8 @@ batadv_netlink_dump_hardifs(struct sk_buff *msg, struct netlink_callback *cb)
 		return -ENODEV;
 	}
 
+	bat_priv = netdev_priv(soft_iface);
+
 	rtnl_lock();
 	cb->seq = batadv_hardif_generation << 1 | 1;
 
@@ -533,8 +635,10 @@ batadv_netlink_dump_hardifs(struct sk_buff *msg, struct netlink_callback *cb)
 		if (i++ < skip)
 			continue;
 
-		if (batadv_netlink_dump_hardif_entry(msg, portid, cb,
-						     hard_iface)) {
+		if (batadv_netlink_hardif_fill(msg, bat_priv, hard_iface,
+					       BATADV_CMD_GET_HARDIF,
+					       portid, cb->nlh->nlmsg_seq,
+					       NLM_F_MULTI, cb)) {
 			i--;
 			break;
 		}
@@ -583,6 +687,52 @@ batadv_get_softif_from_info(struct net *net, struct genl_info *info)
 	return ERR_PTR(-EINVAL);
 }
 
+/**
+ * batadv_get_hardif_from_info() - Retrieve hardif from genl attributes
+ * @bat_priv: the bat priv with all the soft interface information
+ * @net: the applicable net namespace
+ * @info: receiver information
+ *
+ * Return: Pointer to hard interface (with increased refcnt) on success, error
+ *  pointer on error
+ */
+static struct batadv_hard_iface *
+batadv_get_hardif_from_info(struct batadv_priv *bat_priv, struct net *net,
+			    struct genl_info *info)
+{
+	struct batadv_hard_iface *hard_iface;
+	struct net_device *hard_dev;
+	unsigned int hardif_index;
+
+	if (!info->attrs[BATADV_ATTR_HARD_IFINDEX])
+		return ERR_PTR(-EINVAL);
+
+	hardif_index = nla_get_u32(info->attrs[BATADV_ATTR_HARD_IFINDEX]);
+
+	hard_dev = dev_get_by_index(net, hardif_index);
+	if (!hard_dev)
+		return ERR_PTR(-ENODEV);
+
+	hard_iface = batadv_hardif_get_by_netdev(hard_dev);
+	if (!hard_iface)
+		goto err_put_harddev;
+
+	if (hard_iface->soft_iface != bat_priv->soft_iface)
+		goto err_put_hardif;
+
+	/* hard_dev is referenced by hard_iface and not needed here */
+	dev_put(hard_dev);
+
+	return hard_iface;
+
+err_put_hardif:
+	batadv_hardif_put(hard_iface);
+err_put_harddev:
+	dev_put(hard_dev);
+
+	return ERR_PTR(-EINVAL);
+}
+
 /**
  * batadv_pre_doit() - Prepare batman-adv genl doit request
  * @ops: requested netlink operation
@@ -595,8 +745,21 @@ static int batadv_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 			   struct genl_info *info)
 {
 	struct net *net = genl_info_net(info);
+	struct batadv_hard_iface *hard_iface;
+	struct batadv_priv *bat_priv = NULL;
 	struct net_device *soft_iface;
-	struct batadv_priv *bat_priv;
+	u8 user_ptr1_flags;
+	u8 mesh_dep_flags;
+	int ret;
+
+	user_ptr1_flags = BATADV_FLAG_NEED_HARDIF;
+	if (WARN_ON(hweight8(ops->internal_flags & user_ptr1_flags) > 1))
+		return -EINVAL;
+
+	mesh_dep_flags = BATADV_FLAG_NEED_HARDIF;
+	if (WARN_ON((ops->internal_flags & mesh_dep_flags) &&
+		    (~ops->internal_flags & BATADV_FLAG_NEED_MESH)))
+		return -EINVAL;
 
 	if (ops->internal_flags & BATADV_FLAG_NEED_MESH) {
 		soft_iface = batadv_get_softif_from_info(net, info);
@@ -607,7 +770,23 @@ static int batadv_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		info->user_ptr[0] = bat_priv;
 	}
 
+	if (ops->internal_flags & BATADV_FLAG_NEED_HARDIF) {
+		hard_iface = batadv_get_hardif_from_info(bat_priv, net, info);
+		if (IS_ERR(hard_iface)) {
+			ret = PTR_ERR(hard_iface);
+			goto err_put_softif;
+		}
+
+		info->user_ptr[1] = hard_iface;
+	}
+
 	return 0;
+
+err_put_softif:
+	if (bat_priv)
+		dev_put(bat_priv->soft_iface);
+
+	return ret;
 }
 
 /**
@@ -619,8 +798,16 @@ static int batadv_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 static void batadv_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 			     struct genl_info *info)
 {
+	struct batadv_hard_iface *hard_iface;
 	struct batadv_priv *bat_priv;
 
+	if (ops->internal_flags & BATADV_FLAG_NEED_HARDIF &&
+	    info->user_ptr[1]) {
+		hard_iface = info->user_ptr[1];
+
+		batadv_hardif_put(hard_iface);
+	}
+
 	if (ops->internal_flags & BATADV_FLAG_NEED_MESH && info->user_ptr[0]) {
 		bat_priv = info->user_ptr[0];
 		dev_put(bat_priv->soft_iface);
@@ -656,10 +843,13 @@ static const struct genl_ops batadv_netlink_ops[] = {
 		.dumpit = batadv_algo_dump,
 	},
 	{
-		.cmd = BATADV_CMD_GET_HARDIFS,
-		.flags = GENL_ADMIN_PERM,
+		.cmd = BATADV_CMD_GET_HARDIF,
+		/* can be retrieved by unprivileged users */
 		.policy = batadv_netlink_policy,
-		.dumpit = batadv_netlink_dump_hardifs,
+		.dumpit = batadv_netlink_dump_hardif,
+		.doit = batadv_netlink_get_hardif,
+		.internal_flags = BATADV_FLAG_NEED_MESH |
+				  BATADV_FLAG_NEED_HARDIF,
 	},
 	{
 		.cmd = BATADV_CMD_GET_TRANSTABLE_LOCAL,
@@ -722,6 +912,14 @@ static const struct genl_ops batadv_netlink_ops[] = {
 		.doit = batadv_netlink_set_mesh,
 		.internal_flags = BATADV_FLAG_NEED_MESH,
 	},
+	{
+		.cmd = BATADV_CMD_SET_HARDIF,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.doit = batadv_netlink_set_hardif,
+		.internal_flags = BATADV_FLAG_NEED_MESH |
+				  BATADV_FLAG_NEED_HARDIF,
+	},
 };
 
 struct genl_family batadv_netlink_family __ro_after_init = {
-- 
2.20.1

