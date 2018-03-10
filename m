Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 11 Mar 2018 00:53:21 +0100
Message-Id: <20180310235321.1324-3-linus.luessing@c0d3.blue>
In-Reply-To: <20180310235321.1324-1-linus.luessing@c0d3.blue>
References: <20180310235321.1324-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: add multicast flags
 netlink support
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

Dump the list of multicast flags entries via the netlink socket.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/batman_adv.h |  62 +++++++++++
 net/batman-adv/multicast.c      | 237 ++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/multicast.h      |  18 +++
 net/batman-adv/netlink.c        |  12 ++
 4 files changed, 329 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 85c9fe8a..d17ea7ae 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -92,6 +92,53 @@ enum batadv_tt_client_flags {
 };
 
 /**
+ * enum batadv_mcast_flags_priv - Private, own multicast flags
+ *
+ * These are internal, multicast related flags. Currently they describe certain
+ * multicast related attributes of the segment this originator bridges into the
+ * mesh.
+ *
+ * Those attributes are used to determine the public multicast flags this
+ * originator is going to announce via TT.
+ *
+ * For netlink, if BATADV_MCAST_FLAGS_BRIDGED is unset then all querier
+ * related flags are undefined.
+ */
+enum batadv_mcast_flags_priv {
+	/**
+	 * @BATADV_MCAST_FLAGS_BRIDGED: There is a bridge on top of the mesh
+	 * interface.
+	 */
+	BATADV_MCAST_FLAGS_BRIDGED			= (1 << 0),
+
+	/**
+	 * @BATADV_MCAST_FLAGS_QUERIER_IPV4_EXISTS: Whether an IGMP querier
+	 * exists in the mesh
+	 */
+	BATADV_MCAST_FLAGS_QUERIER_IPV4_EXISTS		= (1 << 1),
+
+	/**
+	 * @BATADV_MCAST_FLAGS_QUERIER_IPV6_EXISTS: Whether an MLD querier
+	 * exists in the mesh
+	 */
+	BATADV_MCAST_FLAGS_QUERIER_IPV6_EXISTS		= (1 << 2),
+
+	/**
+	 * @BATADV_MCAST_FLAGS_QUERIER_IPV4_SHADOWING: If an IGMP querier
+	 * exists, whether it is potentially shadowing multicast listeners
+	 * (i.e. querier is behind our own bridge segment)
+	 */
+	BATADV_MCAST_FLAGS_QUERIER_IPV4_SHADOWING	= (1 << 3),
+
+	/**
+	 * @BATADV_MCAST_FLAGS_QUERIER_IPV6_SHADOWING: If an MLD querier
+	 * exists, whether it is potentially shadowing multicast listeners
+	 * (i.e. querier is behind our own bridge segment)
+	 */
+	BATADV_MCAST_FLAGS_QUERIER_IPV6_SHADOWING	= (1 << 4),
+};
+
+/**
  * enum batadv_nl_attrs - batman-adv netlink attributes
  */
 enum batadv_nl_attrs {
@@ -287,6 +334,16 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_DC_VID,
 
+	/**
+	 * @BATADV_ATTR_MCAST_FLAGS: Per originator multicast flags
+	 */
+	BATADV_ATTR_MCAST_FLAGS,
+
+	/**
+	 * @BATADV_ATTR_MCAST_FLAGS_PRIV: Private, own multicast flags
+	 */
+	BATADV_ATTR_MCAST_FLAGS_PRIV,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
@@ -381,6 +438,11 @@ enum batadv_nl_commands {
 	 */
 	BATADV_CMD_GET_DAT_CACHE,
 
+	/**
+	 * @BATADV_CMD_GET_MCAST_FLAGS: Query list of multicast flags
+	 */
+	BATADV_CMD_GET_MCAST_FLAGS,
+
 	/* add new commands above here */
 
 	/**
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 6eaffe50..9a1182ae 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -40,6 +40,7 @@
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -52,14 +53,20 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <net/addrconf.h>
+#include <net/genetlink.h>
 #include <net/if_inet6.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
+#include <net/netlink.h>
+#include <net/sock.h>
 #include <uapi/linux/batadv_packet.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
+#include "netlink.h"
+#include "soft-interface.h"
 #include "translation-table.h"
 #include "tvlv.h"
 
@@ -1286,6 +1293,236 @@ int batadv_mcast_flags_seq_print_text(struct seq_file *seq, void *offset)
 #endif
 
 /**
+ * batadv_mcast_mesh_info_put() - put multicast info into a netlink message
+ * @msg: buffer for the message
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: 0 or error code.
+ */
+int batadv_mcast_mesh_info_put(struct sk_buff *msg,
+			       struct batadv_priv *bat_priv)
+{
+	u32 flags = bat_priv->mcast.flags;
+	u32 flags_priv = BATADV_NO_FLAGS;
+
+	if (bat_priv->mcast.bridged) {
+		flags_priv |= BATADV_MCAST_FLAGS_BRIDGED;
+
+		if (bat_priv->mcast.querier_ipv4.exists)
+			flags_priv |= BATADV_MCAST_FLAGS_QUERIER_IPV4_EXISTS;
+		if (bat_priv->mcast.querier_ipv6.exists)
+			flags_priv |= BATADV_MCAST_FLAGS_QUERIER_IPV6_EXISTS;
+		if (bat_priv->mcast.querier_ipv4.shadowing)
+			flags_priv |= BATADV_MCAST_FLAGS_QUERIER_IPV4_SHADOWING;
+		if (bat_priv->mcast.querier_ipv6.shadowing)
+			flags_priv |= BATADV_MCAST_FLAGS_QUERIER_IPV6_SHADOWING;
+	}
+
+	if (nla_put_u32(msg, BATADV_ATTR_MCAST_FLAGS, flags) ||
+	    nla_put_u32(msg, BATADV_ATTR_MCAST_FLAGS_PRIV, flags_priv))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+/**
+ * batadv_mcast_flags_dump_entry() - dump one entry of the multicast flags table
+ *  to a netlink socket
+ * @msg: buffer for the message
+ * @portid: netlink port
+ * @seq: Sequence number of netlink message
+ * @orig_node: originator to dump the multicast flags of
+ *
+ * Return: 0 or error code.
+ */
+static int
+batadv_mcast_flags_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+			      struct batadv_orig_node *orig_node)
+{
+	void *hdr;
+
+	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
+			  NLM_F_MULTI, BATADV_CMD_GET_MCAST_FLAGS);
+	if (!hdr)
+		return -ENOBUFS;
+
+	if (nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN,
+		    orig_node->orig)) {
+		genlmsg_cancel(msg, hdr);
+		return -EMSGSIZE;
+	}
+
+	if (test_bit(BATADV_ORIG_CAPA_HAS_MCAST,
+		     &orig_node->capabilities)) {
+		if (nla_put_u32(msg, BATADV_ATTR_MCAST_FLAGS,
+				orig_node->mcast_flags)) {
+			genlmsg_cancel(msg, hdr);
+			return -EMSGSIZE;
+		}
+	}
+
+	genlmsg_end(msg, hdr);
+	return 0;
+}
+
+/**
+ * batadv_mcast_flags_dump_bucket() - dump one bucket of the multicast flags
+ *  table to a netlink socket
+ * @msg: buffer for the message
+ * @portid: netlink port
+ * @seq: Sequence number of netlink message
+ * @head: bucket to dump
+ * @idx_skip: How many entries to skip
+ *
+ * Return: 0 or error code.
+ */
+static int
+batadv_mcast_flags_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
+			       struct hlist_head *head, long *idx_skip)
+{
+	struct batadv_orig_node *orig_node;
+	long idx = 0;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
+		if (!test_bit(BATADV_ORIG_CAPA_HAS_MCAST,
+			      &orig_node->capa_initialized))
+			continue;
+
+		if (idx < *idx_skip)
+			goto skip;
+
+		if (batadv_mcast_flags_dump_entry(msg, portid, seq,
+						  orig_node)) {
+			rcu_read_unlock();
+			*idx_skip = idx;
+
+			return -EMSGSIZE;
+		}
+
+skip:
+		idx++;
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+/**
+ * __batadv_mcast_flags_dump() - dump multicast flags table to a netlink socket
+ * @msg: buffer for the message
+ * @portid: netlink port
+ * @seq: Sequence number of netlink message
+ * @bat_priv: the bat priv with all the soft interface information
+ * @bucket: current bucket to dump
+ * @idx: index in current bucket to the next entry to dump
+ *
+ * Return: 0 or error code.
+ */
+static int
+__batadv_mcast_flags_dump(struct sk_buff *msg, u32 portid, u32 seq,
+			  struct batadv_priv *bat_priv, long *bucket, long *idx)
+{
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	long bucket_tmp = *bucket;
+	struct hlist_head *head;
+	long idx_tmp = *idx;
+
+	while (bucket_tmp < hash->size) {
+		head = &hash->table[bucket_tmp];
+
+		if (batadv_mcast_flags_dump_bucket(msg, portid, seq, head,
+						   &idx_tmp))
+			break;
+
+		bucket_tmp++;
+		idx_tmp = 0;
+	}
+
+	*bucket = bucket_tmp;
+	*idx = idx_tmp;
+
+	return msg->len;
+}
+
+/**
+ * batadv_mcast_netlink_get_primary() - get primary interface from netlink
+ *  callback
+ * @cb: netlink callback structure
+ * @primary_if: the primary interface pointer to return the result in
+ *
+ * Return: 0 or error code.
+ */
+static int
+batadv_mcast_netlink_get_primary(struct netlink_callback *cb,
+				 struct batadv_hard_iface **primary_if)
+{
+	struct batadv_hard_iface *hard_iface = NULL;
+	struct net *net = sock_net(cb->skb->sk);
+	struct net_device *soft_iface;
+	struct batadv_priv *bat_priv;
+	int ifindex;
+	int ret = 0;
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
+	hard_iface = batadv_primary_if_get_selected(bat_priv);
+	if (!hard_iface || hard_iface->if_status != BATADV_IF_ACTIVE) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+out:
+	if (soft_iface)
+		dev_put(soft_iface);
+
+	if (!ret && primary_if)
+		*primary_if = hard_iface;
+	else
+		batadv_hardif_put(hard_iface);
+
+	return ret;
+}
+
+/**
+ * batadv_mcast_flags_dump() - dump multicast flags table to a netlink socket
+ * @msg: buffer for the message
+ * @cb: callback structure containing arguments
+ *
+ * Return: message length.
+ */
+int batadv_mcast_flags_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct batadv_hard_iface *primary_if = NULL;
+	int portid = NETLINK_CB(cb->skb).portid;
+	struct batadv_priv *bat_priv;
+	long *bucket = &cb->args[0];
+	long *idx = &cb->args[1];
+	int ret;
+
+	ret = batadv_mcast_netlink_get_primary(cb, &primary_if);
+	if (ret)
+		return ret;
+
+	bat_priv = netdev_priv(primary_if->soft_iface);
+	ret = __batadv_mcast_flags_dump(msg, portid, cb->nlh->nlmsg_seq,
+					bat_priv, bucket, idx);
+
+	batadv_hardif_put(primary_if);
+	return ret;
+}
+
+/**
  * batadv_mcast_free() - free the multicast optimizations structures
  * @bat_priv: the bat priv with all the soft interface information
  */
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 6b8594e2..3b04ab13 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -21,6 +21,7 @@
 
 #include "main.h"
 
+struct netlink_callback;
 struct seq_file;
 struct sk_buff;
 
@@ -54,6 +55,11 @@ void batadv_mcast_init(struct batadv_priv *bat_priv);
 
 int batadv_mcast_flags_seq_print_text(struct seq_file *seq, void *offset);
 
+int batadv_mcast_mesh_info_put(struct sk_buff *msg,
+			       struct batadv_priv *bat_priv);
+
+int batadv_mcast_flags_dump(struct sk_buff *msg, struct netlink_callback *cb);
+
 void batadv_mcast_free(struct batadv_priv *bat_priv);
 
 void batadv_mcast_purge_orig(struct batadv_orig_node *orig_node);
@@ -72,6 +78,18 @@ static inline int batadv_mcast_init(struct batadv_priv *bat_priv)
 	return 0;
 }
 
+static inline int
+batadv_mcast_mesh_info_put(struct sk_buff *msg, struct batadv_priv *bat_priv)
+{
+	return 0;
+}
+
+static inline int batadv_mcast_flags_dump(struct sk_buff *msg,
+					  struct netlink_callback *cb)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void batadv_mcast_free(struct batadv_priv *bat_priv)
 {
 }
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 7812b531..4ea33c22 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -48,6 +48,7 @@
 #include "distributed-arp-table.h"
 #include "gateway_client.h"
 #include "hard-interface.h"
+#include "multicast.h"
 #include "originator.h"
 #include "soft-interface.h"
 #include "tp_meter.h"
@@ -101,6 +102,8 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_DC_ADDRESS]	= { .type = NLA_U32 },
 	[BATADV_ATTR_DC_HWADDRESS]	= { .len = ETH_ALEN },
 	[BATADV_ATTR_DC_VID]		= { .type = NLA_U16 },
+	[BATADV_ATTR_MCAST_FLAGS]	= { .type = NLA_U32 },
+	[BATADV_ATTR_MCAST_FLAGS_PRIV]	= { .type = NLA_U32 },
 };
 
 /**
@@ -151,6 +154,9 @@ batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
 		goto out;
 #endif
 
+	if (batadv_mcast_mesh_info_put(msg, bat_priv))
+		goto out;
+
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (primary_if && primary_if->if_status == BATADV_IF_ACTIVE) {
 		hard_iface = primary_if->net_dev;
@@ -614,6 +620,12 @@ static const struct genl_ops batadv_netlink_ops[] = {
 		.policy = batadv_netlink_policy,
 		.dumpit = batadv_dat_cache_dump,
 	},
+	{
+		.cmd = BATADV_CMD_GET_MCAST_FLAGS,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.dumpit = batadv_mcast_flags_dump,
+	},
 
 };
 
-- 
2.11.0

