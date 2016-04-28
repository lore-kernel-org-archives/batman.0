Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 28 Apr 2016 22:37:23 +0200
Message-Id: <1461875848-11720-6-git-send-email-andrew@lunn.ch>
In-Reply-To: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 05/10] batman-adv: netlink: add originator
	and neighbor table queries
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

From: Matthias Schiffer <mschiffer@universe-factory.net>

Add BATADV_CMD_GET_ORIGINATORS and BATADV_CMD_GET_NEIGHBORS commands,
using handlers bat_orig_dump and bat_neigh_dump in batadv_algo_ops. Will
always return -EOPNOTSUPP for now, as no implementations exist yet.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 include/uapi/linux/batman_adv.h |   2 +
 net/batman-adv/netlink.c        |  13 ++++
 net/batman-adv/originator.c     | 142 ++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/originator.h     |   2 +
 net/batman-adv/types.h          |   7 ++
 5 files changed, 166 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 25dee3c..35d8e8c 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -88,6 +88,8 @@ enum {
 	BATADV_CMD_GET_HARDIFS,
 	BATADV_CMD_GET_TRANSTABLE_LOCAL,
 	BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+	BATADV_CMD_GET_ORIGINATORS,
+	BATADV_CMD_GET_NEIGHBORS,
 	__BATADV_CMD_MAX,
 };
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 50047d4..3b40eb5 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -212,6 +212,7 @@ batadv_netlink_dump_hardifs(struct sk_buff *msg, struct netlink_callback *cb)
 
 static struct nla_policy batadv_netlink_policy[BATADV_ATTR_MAX + 1] = {
 	[BATADV_ATTR_MESH_IFINDEX]	= { .type = NLA_U32 },
+	[BATADV_ATTR_HARD_IFINDEX]	= { .type = NLA_U32 },
 };
 
 static struct genl_ops batadv_netlink_ops[] = {
@@ -245,6 +246,18 @@ static struct genl_ops batadv_netlink_ops[] = {
 		.policy = batadv_netlink_policy,
 		.dumpit = batadv_tt_global_dump,
 	},
+	{
+		.cmd = BATADV_CMD_GET_ORIGINATORS,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.dumpit = batadv_orig_dump,
+	},
+	{
+		.cmd = BATADV_CMD_GET_NEIGHBORS,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.dumpit = batadv_hardif_neigh_dump,
+	},
 };
 
 void __init batadv_netlink_register(void)
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 1ff4ee4..3e053e1 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -33,6 +33,8 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <net/sock.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "distributed-arp-table.h"
 #include "fragmentation.h"
@@ -40,8 +42,10 @@
 #include "hard-interface.h"
 #include "hash.h"
 #include "multicast.h"
+#include "netlink.h"
 #include "network-coding.h"
 #include "routing.h"
+#include "soft-interface.h"
 #include "translation-table.h"
 
 /* hash class keys */
@@ -698,6 +702,75 @@ int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
+int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct net *net = sock_net(cb->skb->sk);
+	struct net_device *soft_iface = NULL;
+	struct net_device *hard_iface = NULL;
+	struct batadv_hard_iface *hardif = BATADV_IF_DEFAULT;
+	struct batadv_priv *bat_priv;
+	struct batadv_hard_iface *primary_if = NULL;
+	int ret;
+	int ifindex, hard_ifindex;
+
+	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
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
+	hard_ifindex = batadv_netlink_get_ifindex(cb->nlh,
+						  BATADV_ATTR_HARD_IFINDEX);
+	if (hard_ifindex) {
+		hard_iface = dev_get_by_index(net, hard_ifindex);
+		if (hard_iface)
+			hardif = batadv_hardif_get_by_netdev(hard_iface);
+
+		if (!hardif) {
+			ret = -ENODEV;
+			goto out;
+		}
+
+		if (hardif->soft_iface != soft_iface) {
+			ret = -ENOENT;
+			goto out;
+		}
+	}
+
+	if (!bat_priv->bat_algo_ops->bat_neigh_dump) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	bat_priv->bat_algo_ops->bat_neigh_dump(msg, cb, bat_priv, hardif);
+
+	ret = msg->len;
+
+ out:
+	if (hardif)
+		batadv_hardif_put(hardif);
+	if (hard_iface)
+		dev_put(hard_iface);
+	if (primary_if)
+		batadv_hardif_put(primary_if);
+	if (soft_iface)
+		dev_put(soft_iface);
+
+	return ret;
+}
+
 /**
  * batadv_orig_ifinfo_release - release orig_ifinfo from lists and queue for
  *  free after rcu grace period
@@ -1294,6 +1367,75 @@ out:
 	return 0;
 }
 
+int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct net *net = sock_net(cb->skb->sk);
+	struct net_device *soft_iface = NULL;
+	struct net_device *hard_iface = NULL;
+	struct batadv_hard_iface *hardif = BATADV_IF_DEFAULT;
+	struct batadv_priv *bat_priv;
+	struct batadv_hard_iface *primary_if = NULL;
+	int ret;
+	int ifindex, hard_ifindex;
+
+	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
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
+	hard_ifindex = batadv_netlink_get_ifindex(cb->nlh,
+						  BATADV_ATTR_HARD_IFINDEX);
+	if (hard_ifindex) {
+		hard_iface = dev_get_by_index(net, hard_ifindex);
+		if (hard_iface)
+			hardif = batadv_hardif_get_by_netdev(hard_iface);
+
+		if (!hardif) {
+			ret = -ENODEV;
+			goto out;
+		}
+
+		if (hardif->soft_iface != soft_iface) {
+			ret = -ENOENT;
+			goto out;
+		}
+	}
+
+	if (!bat_priv->bat_algo_ops->bat_orig_dump) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	bat_priv->bat_algo_ops->bat_orig_dump(msg, cb, bat_priv, hardif);
+
+	ret = msg->len;
+
+ out:
+	if (hardif)
+		batadv_hardif_put(hardif);
+	if (hard_iface)
+		dev_put(hard_iface);
+	if (primary_if)
+		batadv_hardif_put(primary_if);
+	if (soft_iface)
+		dev_put(soft_iface);
+
+	return ret;
+}
+
 int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num)
 {
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 64a8951..a8eb520 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -61,6 +61,7 @@ batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
 			struct batadv_hard_iface *if_outgoing);
 void batadv_neigh_ifinfo_put(struct batadv_neigh_ifinfo *neigh_ifinfo);
 
+int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb);
 int batadv_hardif_neigh_seq_print_text(struct seq_file *seq, void *offset);
 
 struct batadv_orig_ifinfo *
@@ -72,6 +73,7 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 void batadv_orig_ifinfo_put(struct batadv_orig_ifinfo *orig_ifinfo);
 
 int batadv_orig_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb);
 int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 6a577f4..cbe98a8 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -28,6 +28,7 @@
 #include <linux/if_ether.h>
 #include <linux/kref.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/sched.h> /* for linux/wait.h */
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -1311,9 +1312,15 @@ struct batadv_algo_ops {
 		 struct batadv_hard_iface *if_outgoing2);
 	void (*bat_neigh_print)(struct batadv_priv *priv, struct seq_file *seq);
 	void (*bat_neigh_free)(struct batadv_neigh_node *neigh);
+	void (*bat_neigh_dump)(struct sk_buff *msg, struct netlink_callback *cb,
+			       struct batadv_priv *priv,
+			       struct batadv_hard_iface *hard_iface);
 	/* orig_node handling API */
 	void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file *seq,
 			       struct batadv_hard_iface *hard_iface);
+	void (*bat_orig_dump)(struct sk_buff *msg, struct netlink_callback *cb,
+			      struct batadv_priv *priv,
+			      struct batadv_hard_iface *hard_iface);
 	void (*bat_orig_free)(struct batadv_orig_node *orig_node);
 	int (*bat_orig_add_if)(struct batadv_orig_node *orig_node,
 			       int max_if_num);
-- 
2.8.0.rc3

