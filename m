Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon,  9 May 2016 20:07:19 +0200
Message-Id: <1462817239-18104-13-git-send-email-andrew@lunn.ch>
In-Reply-To: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
References: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCHv4 12/12] batman-adv: add B.A.T.M.A.N. Dump
	BLA claims via netlink
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

Dump the list of bridge loop avoidance claims via the netlink socket.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v2: Missing includes and forward declarations
    Fix exit on error when dumping.
---
 include/uapi/linux/batman_adv.h        |   6 ++
 net/batman-adv/bridge_loop_avoidance.c | 166 +++++++++++++++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.h |  10 +-
 net/batman-adv/netlink.c               |   7 ++
 4 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index cce4955..6a97a2c 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -82,6 +82,11 @@ enum {
 	BATADV_ATTR_BANDWIDTH_UP,
 	BATADV_ATTR_BANDWIDTH_DOWN,
 	BATADV_ATTR_ROUTER,
+	BATADV_ATTR_BLA_OWN,
+	BATADV_ATTR_BLA_ADDRESS,
+	BATADV_ATTR_BLA_VID,
+	BATADV_ATTR_BLA_BACKBONE,
+	BATADV_ATTR_BLA_CRC,
 	__BATADV_ATTR_MAX,
 };
 
@@ -97,6 +102,7 @@ enum {
 	BATADV_CMD_GET_ORIGINATORS,
 	BATADV_CMD_GET_NEIGHBORS,
 	BATADV_CMD_GET_GATEWAYS,
+	BATADV_CMD_GET_BLA_CLAIM,
 	__BATADV_CMD_MAX,
 };
 
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 748a9ea..99458f3 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -35,6 +35,7 @@
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
@@ -45,11 +46,17 @@
 #include <linux/string.h>
 #include <linux/workqueue.h>
 #include <net/arp.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
+#include <net/sock.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "hard-interface.h"
 #include "hash.h"
+#include "netlink.h"
 #include "originator.h"
 #include "packet.h"
+#include "soft-interface.h"
 #include "sysfs.h"
 #include "translation-table.h"
 
@@ -1983,6 +1990,165 @@ out:
 }
 
 /**
+ * batadv_bla_claim_dump_entry - dump one entry of the backbone table
+ * to a netlink socket
+ * @msg: buffer for the message
+ * @portid: netlink port
+ * @seq: Sequence number of netlink message
+ * @primary_if: primary interface
+ * @claim: entry to dump
+ *
+ * Return: 0 or error code.
+ */
+static int
+batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+			    struct batadv_hard_iface *primary_if,
+			    struct batadv_bla_claim *claim)
+{
+	u8 *primary_addr = primary_if->net_dev->dev_addr;
+	u16 backbone_crc;
+	bool is_own;
+	void *hdr;
+	int ret = -EINVAL;
+
+	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
+			  NLM_F_MULTI, BATADV_CMD_GET_BLA_CLAIM);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto out;
+	}
+
+	is_own = batadv_compare_eth(claim->backbone_gw->orig,
+				    primary_addr);
+
+	spin_lock_bh(&claim->backbone_gw->crc_lock);
+	backbone_crc = claim->backbone_gw->crc;
+	spin_unlock_bh(&claim->backbone_gw->crc_lock);
+
+	if (is_own)
+		if (nla_put_flag(msg, BATADV_ATTR_BLA_OWN)) {
+			genlmsg_cancel(msg, hdr);
+			goto out;
+		}
+
+	if (nla_put(msg, BATADV_ATTR_BLA_ADDRESS, ETH_ALEN, claim->addr) ||
+	    nla_put_u16(msg, BATADV_ATTR_BLA_VID, claim->vid) ||
+	    nla_put(msg, BATADV_ATTR_BLA_BACKBONE, ETH_ALEN,
+		    claim->backbone_gw->orig) ||
+	    nla_put_u16(msg, BATADV_ATTR_BLA_CRC,
+			backbone_crc)) {
+		genlmsg_cancel(msg, hdr);
+		goto out;
+	}
+
+	genlmsg_end(msg, hdr);
+	ret = 0;
+
+out:
+	return ret;
+}
+
+/**
+ * batadv_bla_claim_dump_bucket - dump one bucket of the backbone table
+ * to a netlink socket
+ * @msg: buffer for the message
+ * @portid: netlink port
+ * @seq: Sequence number of netlink message
+ * @primary_if: primary interface
+ * @head: bucket to dump
+ * @idx_skip: How many entries to skip
+ *
+ * Return: always 0.
+ */
+static int
+batadv_bla_claim_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
+			     struct batadv_hard_iface *primary_if,
+			     struct hlist_head *head, int *idx_skip)
+{
+	struct batadv_bla_claim *claim;
+	int idx = 0;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(claim, head, hash_entry) {
+		if (idx++ < *idx_skip)
+			continue;
+		if (batadv_bla_claim_dump_entry(msg, portid, seq,
+						primary_if, claim)) {
+			*idx_skip = idx - 1;
+			goto unlock;
+		}
+	}
+
+	*idx_skip = idx;
+unlock:
+	rcu_read_unlock();
+	return 0;
+}
+
+/**
+ * batadv_bla_claim_dump - dump backbone table to a netlink socket
+ * @msg: buffer for the message
+ * @cb: callback structure containing arguments
+ *
+ * Return: message length.
+ */
+int batadv_bla_claim_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct batadv_hard_iface *primary_if = NULL;
+	int portid = NETLINK_CB(cb->skb).portid;
+	struct net *net = sock_net(cb->skb->sk);
+	struct net_device *soft_iface = NULL;
+	struct batadv_hashtable *hash;
+	struct batadv_priv *bat_priv;
+	int bucket = cb->args[0];
+	struct hlist_head *head;
+	int idx = cb->args[1];
+	int ifindex;
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
+	hash = bat_priv->bla.claim_hash;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	while (bucket < hash->size) {
+		head = &hash->table[bucket];
+
+		if (batadv_bla_claim_dump_bucket(msg, portid,
+						 cb->nlh->nlmsg_seq,
+						 primary_if, head, &idx))
+			break;
+		bucket++;
+	}
+
+	cb->args[0] = bucket;
+	cb->args[1] = idx;
+
+	ret = msg->len;
+
+out:
+	if (primary_if)
+		batadv_hardif_put(primary_if);
+
+	return 0;
+}
+
+/**
  * batadv_bla_backbone_table_seq_print_text - print the backbone table in a seq
  *  file
  * @seq: seq file to print on
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 0f01dae..a80b9e9 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 
 struct net_device;
+struct netlink_callback;
 struct seq_file;
 struct sk_buff;
 
@@ -35,6 +36,7 @@ bool batadv_bla_is_backbone_gw(struct sk_buff *skb,
 			       struct batadv_orig_node *orig_node,
 			       int hdr_size);
 int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_bla_claim_dump(struct sk_buff *msg, struct netlink_callback *cb);
 int batadv_bla_backbone_table_seq_print_text(struct seq_file *seq,
 					     void *offset);
 bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
@@ -47,7 +49,7 @@ void batadv_bla_update_orig_address(struct batadv_priv *bat_priv,
 void batadv_bla_status_update(struct net_device *net_dev);
 int batadv_bla_init(struct batadv_priv *bat_priv);
 void batadv_bla_free(struct batadv_priv *bat_priv);
-
+int batadv_bla_claim_dump(struct sk_buff *msg, struct netlink_callback *cb);
 #define BATADV_BLA_CRC_INIT	0
 #else /* ifdef CONFIG_BATMAN_ADV_BLA */
 
@@ -112,6 +114,12 @@ static inline void batadv_bla_free(struct batadv_priv *bat_priv)
 {
 }
 
+static inline int batadv_bla_claim_dump(struct sk_buff *msg,
+					struct netlink_callback *cb)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* ifdef CONFIG_BATMAN_ADV_BLA */
 
 #endif /* ifndef _NET_BATMAN_ADV_BLA_H_ */
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 8fe7df5..671d5b6 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -33,6 +33,7 @@
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
+#include "bridge_loop_avoidance.h"
 #include "gateway_client.h"
 #include "hard-interface.h"
 #include "originator.h"
@@ -277,6 +278,12 @@ static struct genl_ops batadv_netlink_ops[] = {
 		.policy = batadv_netlink_policy,
 		.dumpit = batadv_gw_dump,
 	},
+	{
+		.cmd = BATADV_CMD_GET_BLA_CLAIM,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.dumpit = batadv_bla_claim_dump,
+	},
 };
 
 void __init batadv_netlink_register(void)
-- 
2.8.0.rc3

