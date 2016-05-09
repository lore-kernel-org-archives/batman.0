Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon,  9 May 2016 20:07:18 +0200
Message-Id: <1462817239-18104-12-git-send-email-andrew@lunn.ch>
In-Reply-To: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
References: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCHv4 11/12] batman-adv: add B.A.T.M.A.N. Dump
	gateways via netlink
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Dump the list of gateways via the netlink socket.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v2: Add missing includes and forward declarations.
---
 include/uapi/linux/batman_adv.h |   4 ++
 net/batman-adv/gateway_client.c | 131 ++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/gateway_client.h |   2 +
 net/batman-adv/netlink.c        |   9 ++-
 4 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 27f277f..cce4955 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -79,6 +79,9 @@ enum {
 	BATADV_ATTR_NEIGH_ADDRESS,
 	BATADV_ATTR_TQ,
 	BATADV_ATTR_THROUGHPUT,
+	BATADV_ATTR_BANDWIDTH_UP,
+	BATADV_ATTR_BANDWIDTH_DOWN,
+	BATADV_ATTR_ROUTER,
 	__BATADV_ATTR_MAX,
 };
 
@@ -93,6 +96,7 @@ enum {
 	BATADV_CMD_GET_TRANSTABLE_GLOBAL,
 	BATADV_CMD_GET_ORIGINATORS,
 	BATADV_CMD_GET_NEIGHBORS,
+	BATADV_CMD_GET_GATEWAYS,
 	__BATADV_CMD_MAX,
 };
 
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 31ba24e..7f38aea 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -20,6 +20,7 @@
 
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
+#include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/fs.h>
 #include <linux/if_ether.h>
@@ -31,6 +32,7 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
@@ -39,12 +41,18 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/udp.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
+#include <net/sock.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "gateway_common.h"
 #include "hard-interface.h"
+#include "netlink.h"
 #include "originator.h"
 #include "packet.h"
 #include "routing.h"
+#include "soft-interface.h"
 #include "sysfs.h"
 #include "translation-table.h"
 
@@ -662,6 +670,129 @@ out:
 	return 0;
 }
 
+static int
+batadv_gw_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+		     struct batadv_priv *bat_priv,
+		     struct batadv_gw_node *gw_node)
+{
+	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
+	struct batadv_neigh_node *router;
+	struct batadv_gw_node *curr_gw;
+	int ret = -EINVAL;
+	void *hdr;
+
+	router = batadv_orig_router_get(gw_node->orig_node, BATADV_IF_DEFAULT);
+	if (!router)
+		goto out;
+
+	router_ifinfo = batadv_neigh_ifinfo_get(router, BATADV_IF_DEFAULT);
+	if (!router_ifinfo)
+		goto out;
+
+	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
+
+	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
+			  NLM_F_MULTI, BATADV_CMD_GET_GATEWAYS);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto out;
+	}
+
+	ret = -EMSGSIZE;
+
+	if (curr_gw == gw_node)
+		if (nla_put_flag(msg, BATADV_ATTR_FLAG_BEST)) {
+			genlmsg_cancel(msg, hdr);
+			goto out;
+		}
+
+	if (nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN,
+		    gw_node->orig_node->orig) ||
+	    nla_put_u8(msg, BATADV_ATTR_TQ, router_ifinfo->bat_iv.tq_avg) ||
+	    nla_put(msg, BATADV_ATTR_ROUTER, ETH_ALEN,
+		    router->addr) ||
+	    nla_put_string(msg, BATADV_ATTR_HARD_IFNAME,
+			   router->if_incoming->net_dev->name) ||
+	    nla_put_u32(msg, BATADV_ATTR_BANDWIDTH_DOWN,
+			gw_node->bandwidth_down) ||
+	    nla_put_u32(msg, BATADV_ATTR_BANDWIDTH_UP,
+			gw_node->bandwidth_up)) {
+		genlmsg_cancel(msg, hdr);
+		goto out;
+	}
+
+	genlmsg_end(msg, hdr);
+	ret = 0;
+
+out:
+	if (router_ifinfo)
+		batadv_neigh_ifinfo_put(router_ifinfo);
+	if (router)
+		batadv_neigh_node_put(router);
+	return ret;
+}
+
+int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct batadv_hard_iface *primary_if = NULL;
+	struct net *net = sock_net(cb->skb->sk);
+	int portid = NETLINK_CB(cb->skb).portid;
+	struct net_device *soft_iface = NULL;
+	struct batadv_gw_node *gw_node;
+	struct batadv_priv *bat_priv;
+	int idx_skip = cb->args[0];
+	int ifindex;
+	int idx = 0;
+	int ret;
+
+	ifindex = batadv_netlink_get_ifindex(cb->nlh,
+					     BATADV_ATTR_MESH_IFINDEX);
+	if (!ifindex)
+		return -EINVAL;
+
+	soft_iface = dev_get_by_index(net, ifindex);
+	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	bat_priv = netdev_priv(soft_iface);
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.list, list) {
+		if (idx++ < idx_skip)
+			continue;
+
+		if (batadv_gw_dump_entry(msg, portid, cb->nlh->nlmsg_seq,
+					 bat_priv, gw_node)) {
+			idx_skip = idx - 1;
+			ret = msg->len;
+			goto unlock;
+		}
+	}
+
+	idx_skip = idx;
+	ret = msg->len;
+unlock:
+	rcu_read_unlock();
+
+out:
+	if (primary_if)
+		batadv_hardif_put(primary_if);
+	if (soft_iface)
+		dev_put(soft_iface);
+
+	cb->args[0] = idx_skip;
+
+	return ret;
+}
+
 /**
  * batadv_gw_dhcp_recipient_get - check if a packet is a DHCP message
  * @skb: the packet to check
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 582dd8c..f1b2d39 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 
 struct batadv_tvlv_gateway_data;
+struct netlink_callback;
 struct seq_file;
 struct sk_buff;
 
@@ -40,6 +41,7 @@ void batadv_gw_node_delete(struct batadv_priv *bat_priv,
 			   struct batadv_orig_node *orig_node);
 void batadv_gw_node_free(struct batadv_priv *bat_priv);
 int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb);
 bool batadv_gw_out_of_range(struct batadv_priv *bat_priv, struct sk_buff *skb);
 enum batadv_dhcp_recipient
 batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index e188c2b..8fe7df5 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -33,8 +33,9 @@
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
-#include "originator.h"
+#include "gateway_client.h"
 #include "hard-interface.h"
+#include "originator.h"
 #include "soft-interface.h"
 #include "translation-table.h"
 
@@ -270,6 +271,12 @@ static struct genl_ops batadv_netlink_ops[] = {
 		.policy = batadv_netlink_policy,
 		.dumpit = batadv_hardif_neigh_dump,
 	},
+	{
+		.cmd = BATADV_CMD_GET_GATEWAYS,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.dumpit = batadv_gw_dump,
+	},
 };
 
 void __init batadv_netlink_register(void)
-- 
2.8.0.rc3

