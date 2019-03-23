Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sat, 23 Mar 2019 05:47:41 +0100
Message-Id: <20190323044741.19784-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5] batman-adv: Add multicast-to-unicast
 support for multiple targets
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

With this patch multicast packets with a limited number of destinations
(current default: 16) will be split and transmitted by the originator as
individual unicast transmissions.

Wifi broadcasts with their low bitrate are still a costly undertaking.
In a mesh network this cost multiplies with the overall size of the mesh
network. Therefore using multiple unicast transmissions instead of
broadcast flooding is almost always less burdensome for the mesh
network.

The maximum amount of unicast packets can be configured via the newly
introduced multicast_fanout parameter. If this limit is exceeded
distribution will fall back to classic broadcast flooding.

The multicast-to-unicast conversion is performed on the initial
multicast sender node and counts on a final destination node, mesh-wide
basis (and not next hop, neighbor node basis).

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---
Changelog v5:

* removed intermediate limit checks as they are addressing a minor,
  unlikely matter
* removed unnecessary send.h include in translation-table.c
* changed variable order in batadv_mcast_forw_mode()
  (rev. christmas tree)
* renamed:
    batadv_mcast_forw_tt_send() -> batadv_mcast_forw_tt()
    batadv_mcast_forw_want_all_send() -> batadv_mcast_forw_want_all()
    batadv_mcast_forw_want_all_ipv4_send() -> batadv_mcast_forw_want_all_ipv4()
    batadv_mcast_forw_want_all_ipv6_send() -> batadv_mcast_forw_want_all_ipv6()
  to make it less confusing that they do not consume a given skb

Changelog v4:

* Fixed return value in "batadv_mcast_forw_tt_send()" for an empty
  TT entry: the want-all lists still need to be tried. This fixes
  potential packetloss.

Changelog v3:

* removed sysfs support for multicast_fanout

Changelog v2:

* rebased to master (no conflicts/changes)
* fixed a double free bug in the batman-adv multicast-to-multi-unicast
  patch: led to crashes, especially on netifd restart/shutdown
  -> https://github.com/freifunk-gluon/gluon/issues/1468
* fixed skb memory leaks in error cases
* added netlink support for multicast_fanout
* updated multicast_fanout sysfs ABI doc date to Feb 2019
---
 include/uapi/linux/batman_adv.h    |   7 +
 net/batman-adv/multicast.c         | 199 ++++++++++++++++++++++++++++-
 net/batman-adv/multicast.h         |  18 +++
 net/batman-adv/netlink.c           |  11 ++
 net/batman-adv/soft-interface.c    |   8 +-
 net/batman-adv/translation-table.c |   5 +-
 net/batman-adv/translation-table.h |   4 +
 net/batman-adv/types.h             |   6 +
 8 files changed, 252 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 305bf316..e875e0c5 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -491,6 +491,13 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_THROUGHPUT_OVERRIDE,
 
+	/**
+	 * @BATADV_ATTR_MULTICAST_FANOUT: defines the maximum number of packet
+	 * copies that may be generated for a multicast-to-unicast conversion.
+	 * Once this limit is exceeded distribution will fall back to broadcast.
+	 */
+	BATADV_ATTR_MULTICAST_FANOUT,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index f91b1b62..c4f574d6 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -66,6 +66,7 @@
 #include "hash.h"
 #include "log.h"
 #include "netlink.h"
+#include "send.h"
 #include "soft-interface.h"
 #include "translation-table.h"
 #include "tvlv.h"
@@ -991,6 +992,7 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 {
 	int ret, tt_count, ip_count, unsnoop_count, total_count;
 	bool is_unsnoopable = false;
+	unsigned int mcast_fanout;
 	struct ethhdr *ethhdr;
 
 	ret = batadv_mcast_forw_mode_check(bat_priv, skb, &is_unsnoopable);
@@ -1025,8 +1027,203 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	case 0:
 		return BATADV_FORW_NONE;
 	default:
-		return BATADV_FORW_ALL;
+		mcast_fanout = atomic_read(&bat_priv->multicast_fanout);
+
+		if (!unsnoop_count && total_count <= mcast_fanout)
+			return BATADV_FORW_SOME;
+	}
+
+	return BATADV_FORW_ALL;
+}
+
+/**
+ * batadv_mcast_forw_tt() - forwards a packet to multicast listeners
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to transmit
+ * @vid: the vlan identifier
+ *
+ * Sends copies of a frame with multicast destination to any multicast
+ * listener registered in the translation table. A transmission is performed
+ * via a batman-adv unicast packet for each such destination node.
+ *
+ * Return: NET_XMIT_DROP on memory allocation failure, NET_XMIT_SUCCESS
+ * otherwise.
+ */
+static int
+batadv_mcast_forw_tt(struct batadv_priv *bat_priv, struct sk_buff *skb,
+		     unsigned short vid)
+{
+	int ret = NET_XMIT_SUCCESS;
+	struct sk_buff *newskb;
+
+	struct batadv_tt_orig_list_entry *orig_entry;
+
+	struct batadv_tt_global_entry *tt_global;
+	const u8 *addr = eth_hdr(skb)->h_dest;
+
+	tt_global = batadv_tt_global_hash_find(bat_priv, addr, vid);
+	if (!tt_global)
+		goto out;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_entry, &tt_global->orig_list, list) {
+		newskb = skb_copy(skb, GFP_ATOMIC);
+		if (!newskb) {
+			ret = NET_XMIT_DROP;
+			break;
+		}
+
+		batadv_send_skb_unicast(bat_priv, newskb, BATADV_UNICAST, 0,
+					orig_entry->orig_node, vid);
+	}
+	rcu_read_unlock();
+
+	batadv_tt_global_entry_put(tt_global);
+
+out:
+	return ret;
+}
+
+/**
+ * batadv_mcast_forw_want_all_ipv4() - forward to nodes with want-all-ipv4
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to transmit
+ * @vid: the vlan identifier
+ *
+ * Sends copies of a frame with multicast destination to any node with a
+ * BATADV_MCAST_WANT_ALL_IPV4 flag set. A transmission is performed via a
+ * batman-adv unicast packet for each such destination node.
+ *
+ * Return: NET_XMIT_DROP on memory allocation failure, NET_XMIT_SUCCESS
+ * otherwise.
+ */
+static int
+batadv_mcast_forw_want_all_ipv4(struct batadv_priv *bat_priv,
+				struct sk_buff *skb, unsigned short vid)
+{
+	struct batadv_orig_node *orig_node;
+	int ret = NET_XMIT_SUCCESS;
+	struct sk_buff *newskb;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_node,
+				 &bat_priv->mcast.want_all_ipv4_list,
+				 mcast_want_all_ipv4_node) {
+		newskb = skb_copy(skb, GFP_ATOMIC);
+		if (!newskb) {
+			ret = NET_XMIT_DROP;
+			break;
+		}
+
+		batadv_send_skb_unicast(bat_priv, newskb, BATADV_UNICAST, 0,
+					orig_node, vid);
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+/**
+ * batadv_mcast_forw_want_all_ipv6() - forward to nodes with want-all-ipv6
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: The multicast packet to transmit
+ * @vid: the vlan identifier
+ *
+ * Sends copies of a frame with multicast destination to any node with a
+ * BATADV_MCAST_WANT_ALL_IPV6 flag set. A transmission is performed via a
+ * batman-adv unicast packet for each such destination node.
+ *
+ * Return: NET_XMIT_DROP on memory allocation failure, NET_XMIT_SUCCESS
+ * otherwise.
+ */
+static int
+batadv_mcast_forw_want_all_ipv6(struct batadv_priv *bat_priv,
+				struct sk_buff *skb, unsigned short vid)
+{
+	struct batadv_orig_node *orig_node;
+	int ret = NET_XMIT_SUCCESS;
+	struct sk_buff *newskb;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_node,
+				 &bat_priv->mcast.want_all_ipv6_list,
+				 mcast_want_all_ipv6_node) {
+		newskb = skb_copy(skb, GFP_ATOMIC);
+		if (!newskb) {
+			ret = NET_XMIT_DROP;
+			break;
+		}
+
+		batadv_send_skb_unicast(bat_priv, newskb, BATADV_UNICAST, 0,
+					orig_node, vid);
 	}
+	rcu_read_unlock();
+	return ret;
+}
+
+/**
+ * batadv_mcast_forw_want_all() - forward packet to nodes in a want-all list
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to transmit
+ * @vid: the vlan identifier
+ *
+ * Sends copies of a frame with multicast destination to any node with a
+ * BATADV_MCAST_WANT_ALL_IPV4 or BATADV_MCAST_WANT_ALL_IPV6 flag set. A
+ * transmission is performed via a batman-adv unicast packet for each such
+ * destination node.
+ *
+ * Return: NET_XMIT_DROP on memory allocation failure or if the protocol family
+ * is neither IPv4 nor IPv6. NET_XMIT_SUCCESS otherwise.
+ */
+static int
+batadv_mcast_forw_want_all(struct batadv_priv *bat_priv,
+			   struct sk_buff *skb, unsigned short vid)
+{
+	switch (ntohs(eth_hdr(skb)->h_proto)) {
+	case ETH_P_IP:
+		return batadv_mcast_forw_want_all_ipv4(bat_priv, skb, vid);
+	case ETH_P_IPV6:
+		return batadv_mcast_forw_want_all_ipv6(bat_priv, skb, vid);
+	default:
+		/* we shouldn't be here... */
+		return NET_XMIT_DROP;
+	}
+}
+
+/**
+ * batadv_mcast_forw_send() - send packet to any detected multicast recpient
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: the multicast packet to transmit
+ * @vid: the vlan identifier
+ *
+ * Sends copies of a frame with multicast destination to any node that signaled
+ * interest in it, that is either via the translation table or the according
+ * want-all flags. A transmission is performed via a batman-adv unicast packet
+ * for each such destination node.
+ *
+ * The given skb is consumed/freed.
+ *
+ * Return: NET_XMIT_DROP on memory allocation failure or if the protocol family
+ * is neither IPv4 nor IPv6. NET_XMIT_SUCCESS otherwise.
+ */
+int batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			   unsigned short vid)
+{
+	int ret;
+
+	ret = batadv_mcast_forw_tt(bat_priv, skb, vid);
+	if (ret != NET_XMIT_SUCCESS) {
+		kfree_skb(skb);
+		return ret;
+	}
+
+	ret = batadv_mcast_forw_want_all(bat_priv, skb, vid);
+	if (ret != NET_XMIT_SUCCESS) {
+		kfree_skb(skb);
+		return ret;
+	}
+
+	consume_skb(skb);
+	return ret;
 }
 
 /**
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 466013fe..83c5ff51 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -35,6 +35,13 @@ enum batadv_forw_mode {
 	 */
 	BATADV_FORW_ALL,
 
+	/**
+	 * @BATADV_FORW_SOME: forward the packet to some nodes (currently via
+	 *  a multicast-to-unicast conversion and the BATMAN unicast routing
+	 *  protocol)
+	 */
+	BATADV_FORW_SOME,
+
 	/**
 	 * @BATADV_FORW_SINGLE: forward the packet to a single node (currently
 	 *  via the BATMAN unicast routing protocol)
@@ -51,6 +58,9 @@ enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		       struct batadv_orig_node **mcast_single_orig);
 
+int batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			   unsigned short vid);
+
 void batadv_mcast_init(struct batadv_priv *bat_priv);
 
 int batadv_mcast_flags_seq_print_text(struct seq_file *seq, void *offset);
@@ -73,6 +83,14 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	return BATADV_FORW_ALL;
 }
 
+static inline int
+batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff *skb,
+		       unsigned short vid)
+{
+	kfree_skb(skb);
+	return NET_XMIT_DROP;
+}
+
 static inline int batadv_mcast_init(struct batadv_priv *bat_priv)
 {
 	return 0;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 67a58da2..f0458727 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -157,6 +157,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_HOP_PENALTY]		= { .type = NLA_U8 },
 	[BATADV_ATTR_LOG_LEVEL]			= { .type = NLA_U32 },
 	[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED]	= { .type = NLA_U8 },
+	[BATADV_ATTR_MULTICAST_FANOUT]		= { .type = NLA_U32 },
 	[BATADV_ATTR_NETWORK_CODING_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_ORIG_INTERVAL]		= { .type = NLA_U32 },
 	[BATADV_ATTR_ELP_INTERVAL]		= { .type = NLA_U32 },
@@ -353,6 +354,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	if (nla_put_u8(msg, BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED,
 		       !atomic_read(&bat_priv->multicast_mode)))
 		goto nla_put_failure;
+
+	if (nla_put_u32(msg, BATADV_ATTR_MULTICAST_FANOUT,
+			atomic_read(&bat_priv->multicast_fanout)))
+		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
 #ifdef CONFIG_BATMAN_ADV_NC
@@ -592,6 +597,12 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 
 		atomic_set(&bat_priv->multicast_mode, !nla_get_u8(attr));
 	}
+
+	if (info->attrs[BATADV_ATTR_MULTICAST_FANOUT]) {
+		attr = info->attrs[BATADV_ATTR_MULTICAST_FANOUT];
+
+		atomic_set(&bat_priv->multicast_fanout, nla_get_u32(attr));
+	}
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
 #ifdef CONFIG_BATMAN_ADV_NC
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 2e367230..db8ac4df 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -209,7 +209,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	unsigned short vid;
 	u32 seqno;
 	int gw_mode;
-	enum batadv_forw_mode forw_mode;
+	enum batadv_forw_mode forw_mode = BATADV_FORW_SINGLE;
 	struct batadv_orig_node *mcast_single_orig = NULL;
 	int network_offset = ETH_HLEN;
 	__be16 proto;
@@ -317,7 +317,8 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 			if (forw_mode == BATADV_FORW_NONE)
 				goto dropped;
 
-			if (forw_mode == BATADV_FORW_SINGLE)
+			if (forw_mode == BATADV_FORW_SINGLE ||
+			    forw_mode == BATADV_FORW_SOME)
 				do_bcast = false;
 		}
 	}
@@ -377,6 +378,8 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 			ret = batadv_send_skb_unicast(bat_priv, skb,
 						      BATADV_UNICAST, 0,
 						      mcast_single_orig, vid);
+		} else if (forw_mode == BATADV_FORW_SOME) {
+			ret = batadv_mcast_forw_send(bat_priv, skb, vid);
 		} else {
 			if (batadv_dat_snoop_outgoing_arp_request(bat_priv,
 								  skb))
@@ -818,6 +821,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 	bat_priv->mcast.querier_ipv6.shadowing = false;
 	bat_priv->mcast.flags = BATADV_NO_FLAGS;
 	atomic_set(&bat_priv->multicast_mode, 1);
+	atomic_set(&bat_priv->multicast_fanout, 16);
 	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv4, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv6, 0);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 26c4e249..6ebe6e84 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -205,7 +205,7 @@ batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
  * Return: a pointer to the corresponding tt_global_entry struct if the client
  * is found, NULL otherwise.
  */
-static struct batadv_tt_global_entry *
+struct batadv_tt_global_entry *
 batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 			   unsigned short vid)
 {
@@ -300,8 +300,7 @@ static void batadv_tt_global_entry_release(struct kref *ref)
  *  possibly release it
  * @tt_global_entry: tt_global_entry to be free'd
  */
-static void
-batadv_tt_global_entry_put(struct batadv_tt_global_entry *tt_global_entry)
+void batadv_tt_global_entry_put(struct batadv_tt_global_entry *tt_global_entry)
 {
 	kref_put(&tt_global_entry->common.refcount,
 		 batadv_tt_global_entry_release);
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 61bca75e..5b41f217 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -41,6 +41,10 @@ int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb);
 void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
 			       s32 match_vid, const char *message);
+struct batadv_tt_global_entry *
+batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
+			   unsigned short vid);
+void batadv_tt_global_entry_put(struct batadv_tt_global_entry *tt_global_entry);
 int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
 				const u8 *addr, unsigned short vid);
 struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a21b34ed..d22cf01e 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1565,6 +1565,12 @@ struct batadv_priv {
 	 *  node's sender/originating side
 	 */
 	atomic_t multicast_mode;
+
+	/**
+	 * @multicast_fanout: Maximum number of packet copies to generate for a
+	 *  multicast-to-unicast conversion
+	 */
+	atomic_t multicast_fanout;
 #endif
 
 	/** @orig_interval: OGM broadcast interval in milliseconds */
-- 
2.20.1

