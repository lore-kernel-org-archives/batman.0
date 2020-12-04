Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 3/8] batman-adv: Prepare infrastructure for newlink settings
Date: Fri,  4 Dec 2020 16:46:26 +0100
Message-Id: <20201204154631.21063-4-sw@simonwunderlich.de>
In-Reply-To: <20201204154631.21063-1-sw@simonwunderlich.de>
References: <20201204154631.21063-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The batadv generic netlink family can be used to retrieve the current state
and set various configuration settings. But there are also settings which
must be set before the actual interface is created.

The rtnetlink already uses IFLA_INFO_DATA to allow net_device families to
transfer such configurations. The minimal required functionality for this
is now available for the batadv rtnl_link_ops. Also a new IFLA class of
attributes will be attached to it because rtnetlink only allows 51
different attributes but batadv_nl_attrs already contains 62 attributes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batman_adv.h | 20 +++++++++++++++++
 net/batman-adv/soft-interface.c | 39 +++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index bb0ae945b36a..b05399d8a127 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -675,4 +675,24 @@ enum batadv_tp_meter_reason {
 	BATADV_TP_REASON_TOO_MANY		= 133,
 };
 
+/**
+ * enum batadv_ifla_attrs - batman-adv ifla nested attributes
+ */
+enum batadv_ifla_attrs {
+	/**
+	 * @IFLA_BATADV_UNSPEC: unspecified attribute which is not parsed by
+	 *  rtnetlink
+	 */
+	IFLA_BATADV_UNSPEC,
+
+	/* add attributes above here, update the policy in soft-interface.c */
+
+	/**
+	 * @__IFLA_BATADV_MAX: internal use
+	 */
+	__IFLA_BATADV_MAX,
+};
+
+#define IFLA_BATADV_MAX (__IFLA_BATADV_MAX - 1)
+
 #endif /* _UAPI_LINUX_BATMAN_ADV_H_ */
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 82e7ca886605..9c7b89689c97 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -38,6 +38,7 @@
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <net/netlink.h>
 #include <uapi/linux/batadv_packet.h>
 #include <uapi/linux/batman_adv.h>
 
@@ -1073,6 +1074,37 @@ static void batadv_softif_init_early(struct net_device *dev)
 	dev->ethtool_ops = &batadv_ethtool_ops;
 }
 
+/**
+ * batadv_softif_validate() - validate configuration of new batadv link
+ * @tb: IFLA_INFO_DATA netlink attributes
+ * @data: enum batadv_ifla_attrs attributes
+ * @extack: extended ACK report struct
+ *
+ * Return: 0 if successful or error otherwise.
+ */
+static int batadv_softif_validate(struct nlattr *tb[], struct nlattr *data[],
+				  struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+/**
+ * batadv_softif_newlink() - pre-initialize and register new batadv link
+ * @src_net: the applicable net namespace
+ * @dev: network device to register
+ * @tb: IFLA_INFO_DATA netlink attributes
+ * @data: enum batadv_ifla_attrs attributes
+ * @extack: extended ACK report struct
+ *
+ * Return: 0 if successful or error otherwise.
+ */
+static int batadv_softif_newlink(struct net *src_net, struct net_device *dev,
+				 struct nlattr *tb[], struct nlattr *data[],
+				 struct netlink_ext_ack *extack)
+{
+	return register_netdevice(dev);
+}
+
 /**
  * batadv_softif_create() - Create and register soft interface
  * @net: the applicable net namespace
@@ -1171,9 +1203,16 @@ bool batadv_softif_is_valid(const struct net_device *net_dev)
 	return false;
 }
 
+static const struct nla_policy batadv_ifla_policy[IFLA_BATADV_MAX + 1] = {
+};
+
 struct rtnl_link_ops batadv_link_ops __read_mostly = {
 	.kind		= "batadv",
 	.priv_size	= sizeof(struct batadv_priv),
 	.setup		= batadv_softif_init_early,
+	.maxtype	= IFLA_BATADV_MAX,
+	.policy		= batadv_ifla_policy,
+	.validate	= batadv_softif_validate,
+	.newlink	= batadv_softif_newlink,
 	.dellink	= batadv_softif_destroy_netlink,
 };
-- 
2.20.1

