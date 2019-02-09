Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:40:51 +0100
Message-Id: <20190209134109.14908-2-sven@narfation.org>
In-Reply-To: <20190209134109.14908-1-sven@narfation.org>
References: <20190209134109.14908-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 01/19] batman-adv: Move common genl doit
 code pre/post hooks
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

The commit ff4c92d85c6f ("genetlink: introduce pre_doit/post_doit hooks")
intoduced a mechanism to run specific code for doit hooks before/after the
hooks are run. Since all doit hooks are requiring the batadv softif, it
should be retrieved/freed in these helpers to simplify the code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/netlink.c | 143 +++++++++++++++++++++++++++------------
 1 file changed, 100 insertions(+), 43 deletions(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 5fe833cc..e56c40d1 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -20,8 +20,10 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/genetlink.h>
@@ -54,6 +56,8 @@
 #include "tp_meter.h"
 #include "translation-table.h"
 
+struct net;
+
 struct genl_family batadv_netlink_family;
 
 /* multicast groups */
@@ -61,6 +65,18 @@ enum batadv_netlink_multicast_groups {
 	BATADV_NL_MCGRP_TPMETER,
 };
 
+/**
+ * enum batadv_genl_ops_flags - flags for genl_ops's internal_flags
+ */
+enum batadv_genl_ops_flags {
+	/**
+	 * @BATADV_FLAG_NEED_MESH: request requires valid soft interface in
+	 *  attribute BATADV_ATTR_MESH_IFINDEX and expects a pointer to it to be
+	 *  saved in info->user_ptr[0]
+	 */
+	BATADV_FLAG_NEED_MESH = BIT(0),
+};
+
 static const struct genl_multicast_group batadv_netlink_mcgrps[] = {
 	[BATADV_NL_MCGRP_TPMETER] = { .name = BATADV_NL_MCAST_GROUP_TPMETER },
 };
@@ -329,40 +345,24 @@ int batadv_netlink_tpmeter_notify(struct batadv_priv *bat_priv, const u8 *dst,
 static int
 batadv_netlink_tp_meter_start(struct sk_buff *skb, struct genl_info *info)
 {
-	struct net *net = genl_info_net(info);
-	struct net_device *soft_iface;
-	struct batadv_priv *bat_priv;
+	struct batadv_priv *bat_priv = info->user_ptr[0];
 	struct sk_buff *msg = NULL;
 	u32 test_length;
 	void *msg_head;
-	int ifindex;
 	u32 cookie;
 	u8 *dst;
 	int ret;
 
-	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
-		return -EINVAL;
-
 	if (!info->attrs[BATADV_ATTR_ORIG_ADDRESS])
 		return -EINVAL;
 
 	if (!info->attrs[BATADV_ATTR_TPMETER_TEST_TIME])
 		return -EINVAL;
 
-	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
-	if (!ifindex)
-		return -EINVAL;
-
 	dst = nla_data(info->attrs[BATADV_ATTR_ORIG_ADDRESS]);
 
 	test_length = nla_get_u32(info->attrs[BATADV_ATTR_TPMETER_TEST_TIME]);
 
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
-
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
 		ret = -ENOMEM;
@@ -377,15 +377,11 @@ batadv_netlink_tp_meter_start(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	bat_priv = netdev_priv(soft_iface);
 	batadv_tp_start(bat_priv, dst, test_length, &cookie);
 
 	ret = batadv_netlink_tp_meter_put(msg, cookie);
 
  out:
-	if (soft_iface)
-		dev_put(soft_iface);
-
 	if (ret) {
 		if (msg)
 			nlmsg_free(msg);
@@ -406,38 +402,17 @@ batadv_netlink_tp_meter_start(struct sk_buff *skb, struct genl_info *info)
 static int
 batadv_netlink_tp_meter_cancel(struct sk_buff *skb, struct genl_info *info)
 {
-	struct net *net = genl_info_net(info);
-	struct net_device *soft_iface;
-	struct batadv_priv *bat_priv;
-	int ifindex;
+	struct batadv_priv *bat_priv = info->user_ptr[0];
 	u8 *dst;
 	int ret = 0;
 
-	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
-		return -EINVAL;
-
 	if (!info->attrs[BATADV_ATTR_ORIG_ADDRESS])
 		return -EINVAL;
 
-	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
-	if (!ifindex)
-		return -EINVAL;
-
 	dst = nla_data(info->attrs[BATADV_ATTR_ORIG_ADDRESS]);
 
-	soft_iface = dev_get_by_index(net, ifindex);
-	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
-		ret = -ENODEV;
-		goto out;
-	}
-
-	bat_priv = netdev_priv(soft_iface);
 	batadv_tp_stop(bat_priv, dst, BATADV_TP_REASON_CANCEL);
 
-out:
-	if (soft_iface)
-		dev_put(soft_iface);
-
 	return ret;
 }
 
@@ -545,6 +520,84 @@ batadv_netlink_dump_hardifs(struct sk_buff *msg, struct netlink_callback *cb)
 	return msg->len;
 }
 
+/**
+ * batadv_get_softif_from_info() - Retrieve soft interface from genl attributes
+ * @net: the applicable net namespace
+ * @info: receiver information
+ *
+ * Return: Pointer to soft interface (with increased refcnt) on success, error
+ *  pointer on error
+ */
+static struct net_device *
+batadv_get_softif_from_info(struct net *net, struct genl_info *info)
+{
+	struct net_device *soft_iface;
+	int ifindex;
+
+	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
+		return ERR_PTR(-EINVAL);
+
+	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
+
+	soft_iface = dev_get_by_index(net, ifindex);
+	if (!soft_iface)
+		return ERR_PTR(-ENODEV);
+
+	if (!batadv_softif_is_valid(soft_iface))
+		goto err_put_softif;
+
+	return soft_iface;
+
+err_put_softif:
+	dev_put(soft_iface);
+
+	return ERR_PTR(-EINVAL);
+}
+
+/**
+ * batadv_pre_doit() - Prepare batman-adv genl doit request
+ * @ops: requested netlink operation
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int batadv_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
+			   struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct net_device *soft_iface;
+	struct batadv_priv *bat_priv;
+
+	if (ops->internal_flags & BATADV_FLAG_NEED_MESH) {
+		soft_iface = batadv_get_softif_from_info(net, info);
+		if (IS_ERR(soft_iface))
+			return PTR_ERR(soft_iface);
+
+		bat_priv = netdev_priv(soft_iface);
+		info->user_ptr[0] = bat_priv;
+	}
+
+	return 0;
+}
+
+/**
+ * batadv_post_doit() - End batman-adv genl doit request
+ * @ops: requested netlink operation
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ */
+static void batadv_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
+			     struct genl_info *info)
+{
+	struct batadv_priv *bat_priv;
+
+	if (ops->internal_flags & BATADV_FLAG_NEED_MESH && info->user_ptr[0]) {
+		bat_priv = info->user_ptr[0];
+		dev_put(bat_priv->soft_iface);
+	}
+}
+
 static const struct genl_ops batadv_netlink_ops[] = {
 	{
 		.cmd = BATADV_CMD_GET_MESH_INFO,
@@ -557,12 +610,14 @@ static const struct genl_ops batadv_netlink_ops[] = {
 		.flags = GENL_ADMIN_PERM,
 		.policy = batadv_netlink_policy,
 		.doit = batadv_netlink_tp_meter_start,
+		.internal_flags = BATADV_FLAG_NEED_MESH,
 	},
 	{
 		.cmd = BATADV_CMD_TP_METER_CANCEL,
 		.flags = GENL_ADMIN_PERM,
 		.policy = batadv_netlink_policy,
 		.doit = batadv_netlink_tp_meter_cancel,
+		.internal_flags = BATADV_FLAG_NEED_MESH,
 	},
 	{
 		.cmd = BATADV_CMD_GET_ROUTING_ALGOS,
@@ -639,6 +694,8 @@ struct genl_family batadv_netlink_family __ro_after_init = {
 	.version = 1,
 	.maxattr = BATADV_ATTR_MAX,
 	.netnsok = true,
+	.pre_doit = batadv_pre_doit,
+	.post_doit = batadv_post_doit,
 	.module = THIS_MODULE,
 	.ops = batadv_netlink_ops,
 	.n_ops = ARRAY_SIZE(batadv_netlink_ops),
-- 
2.20.1

