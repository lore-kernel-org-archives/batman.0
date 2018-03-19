Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 19 Mar 2018 17:41:52 +0100
Message-Id: <20180319164153.11536-3-sw@simonwunderlich.de>
In-Reply-To: <20180319164153.11536-1-sw@simonwunderlich.de>
References: <20180319164153.11536-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: add DAT cache netlink support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Linus Lüssing <linus.luessing@c0d3.blue>

Dump the list of DAT cache entries via the netlink socket.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batman_adv.h        |  20 +++++
 net/batman-adv/distributed-arp-table.c | 152 +++++++++++++++++++++++++++++++++
 net/batman-adv/distributed-arp-table.h |   8 ++
 net/batman-adv/netlink.c               |  76 ++++++++++-------
 4 files changed, 223 insertions(+), 33 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 56ae28934070..95ab5dbd09fa 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -272,6 +272,21 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_BLA_CRC,
 
+	/**
+	 * @BATADV_ATTR_DAT_CACHE_IP4ADDRESS: Client IPv4 address
+	 */
+	BATADV_ATTR_DAT_CACHE_IP4ADDRESS,
+
+	/**
+	 * @BATADV_ATTR_DAT_CACHE_HWADDRESS: Client MAC address
+	 */
+	BATADV_ATTR_DAT_CACHE_HWADDRESS,
+
+	/**
+	 * @BATADV_ATTR_DAT_CACHE_VID: VLAN ID
+	 */
+	BATADV_ATTR_DAT_CACHE_VID,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
@@ -361,6 +376,11 @@ enum batadv_nl_commands {
 	 */
 	BATADV_CMD_GET_BLA_BACKBONE,
 
+	/**
+	 * @BATADV_CMD_GET_DAT_CACHE: Query list of DAT cache entries
+	 */
+	BATADV_CMD_GET_DAT_CACHE,
+
 	/* add new commands above here */
 
 	/**
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 4469dcc1558f..75dda9454ccf 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -33,6 +33,7 @@
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
+#include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
@@ -43,13 +44,19 @@
 #include <linux/string.h>
 #include <linux/workqueue.h>
 #include <net/arp.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
+#include <net/sock.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "bridge_loop_avoidance.h"
 #include "hard-interface.h"
 #include "hash.h"
 #include "log.h"
+#include "netlink.h"
 #include "originator.h"
 #include "send.h"
+#include "soft-interface.h"
 #include "translation-table.h"
 #include "tvlv.h"
 
@@ -852,6 +859,151 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 #endif
 
 /**
+ * batadv_dat_cache_dump_entry() - dump one entry of the DAT cache table to a
+ *  netlink socket
+ * @msg: buffer for the message
+ * @portid: netlink port
+ * @seq: Sequence number of netlink message
+ * @dat_entry: entry to dump
+ *
+ * Return: 0 or error code.
+ */
+static int
+batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+			    struct batadv_dat_entry *dat_entry)
+{
+	int msecs;
+	void *hdr;
+
+	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
+			  NLM_F_MULTI, BATADV_CMD_GET_DAT_CACHE);
+	if (!hdr)
+		return -ENOBUFS;
+
+	msecs = jiffies_to_msecs(jiffies - dat_entry->last_update);
+
+	if (nla_put_in_addr(msg, BATADV_ATTR_DAT_CACHE_IP4ADDRESS,
+			    dat_entry->ip) ||
+	    nla_put(msg, BATADV_ATTR_DAT_CACHE_HWADDRESS, ETH_ALEN,
+		    dat_entry->mac_addr) ||
+	    nla_put_u16(msg, BATADV_ATTR_DAT_CACHE_VID, dat_entry->vid) ||
+	    nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS, msecs)) {
+		genlmsg_cancel(msg, hdr);
+		return -EMSGSIZE;
+	}
+
+	genlmsg_end(msg, hdr);
+	return 0;
+}
+
+/**
+ * batadv_dat_cache_dump_bucket() - dump one bucket of the DAT cache table to
+ *  a netlink socket
+ * @msg: buffer for the message
+ * @portid: netlink port
+ * @seq: Sequence number of netlink message
+ * @head: bucket to dump
+ * @idx_skip: How many entries to skip
+ *
+ * Return: 0 or error code.
+ */
+static int
+batadv_dat_cache_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
+			     struct hlist_head *head, int *idx_skip)
+{
+	struct batadv_dat_entry *dat_entry;
+	int idx = 0;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
+		if (idx < *idx_skip)
+			goto skip;
+
+		if (batadv_dat_cache_dump_entry(msg, portid, seq,
+						dat_entry)) {
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
+ * batadv_dat_cache_dump() - dump DAT cache table to a netlink socket
+ * @msg: buffer for the message
+ * @cb: callback structure containing arguments
+ *
+ * Return: message length.
+ */
+int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct batadv_hard_iface *primary_if = NULL;
+	int portid = NETLINK_CB(cb->skb).portid;
+	struct net *net = sock_net(cb->skb->sk);
+	struct net_device *soft_iface;
+	struct batadv_hashtable *hash;
+	struct batadv_priv *bat_priv;
+	int bucket = cb->args[0];
+	struct hlist_head *head;
+	int idx = cb->args[1];
+	int ifindex;
+	int ret = 0;
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
+	hash = bat_priv->dat.hash;
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
+		if (batadv_dat_cache_dump_bucket(msg, portid,
+						 cb->nlh->nlmsg_seq, head,
+						 &idx))
+			break;
+
+		bucket++;
+		idx = 0;
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
+	if (soft_iface)
+		dev_put(soft_iface);
+
+	return ret;
+}
+
+/**
  * batadv_arp_get_type() - parse an ARP packet and gets the type
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to analyse
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index e24aa9601c52..a04596028337 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -28,6 +28,7 @@
 
 #include "originator.h"
 
+struct netlink_callback;
 struct seq_file;
 struct sk_buff;
 
@@ -81,6 +82,7 @@ batadv_dat_init_own_addr(struct batadv_priv *bat_priv,
 int batadv_dat_init(struct batadv_priv *bat_priv);
 void batadv_dat_free(struct batadv_priv *bat_priv);
 int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb);
 
 /**
  * batadv_dat_inc_counter() - increment the correct DAT packet counter
@@ -169,6 +171,12 @@ static inline void batadv_dat_free(struct batadv_priv *bat_priv)
 {
 }
 
+static inline int
+batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void batadv_dat_inc_counter(struct batadv_priv *bat_priv,
 					  u8 subtype)
 {
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 129af56b944d..2b3e7c3f87fa 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -45,6 +45,7 @@
 
 #include "bat_algo.h"
 #include "bridge_loop_avoidance.h"
+#include "distributed-arp-table.h"
 #include "gateway_client.h"
 #include "hard-interface.h"
 #include "originator.h"
@@ -64,39 +65,42 @@ static const struct genl_multicast_group batadv_netlink_mcgrps[] = {
 };
 
 static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
-	[BATADV_ATTR_VERSION]		= { .type = NLA_STRING },
-	[BATADV_ATTR_ALGO_NAME]		= { .type = NLA_STRING },
-	[BATADV_ATTR_MESH_IFINDEX]	= { .type = NLA_U32 },
-	[BATADV_ATTR_MESH_IFNAME]	= { .type = NLA_STRING },
-	[BATADV_ATTR_MESH_ADDRESS]	= { .len = ETH_ALEN },
-	[BATADV_ATTR_HARD_IFINDEX]	= { .type = NLA_U32 },
-	[BATADV_ATTR_HARD_IFNAME]	= { .type = NLA_STRING },
-	[BATADV_ATTR_HARD_ADDRESS]	= { .len = ETH_ALEN },
-	[BATADV_ATTR_ORIG_ADDRESS]	= { .len = ETH_ALEN },
-	[BATADV_ATTR_TPMETER_RESULT]	= { .type = NLA_U8 },
-	[BATADV_ATTR_TPMETER_TEST_TIME]	= { .type = NLA_U32 },
-	[BATADV_ATTR_TPMETER_BYTES]	= { .type = NLA_U64 },
-	[BATADV_ATTR_TPMETER_COOKIE]	= { .type = NLA_U32 },
-	[BATADV_ATTR_ACTIVE]		= { .type = NLA_FLAG },
-	[BATADV_ATTR_TT_ADDRESS]	= { .len = ETH_ALEN },
-	[BATADV_ATTR_TT_TTVN]		= { .type = NLA_U8 },
-	[BATADV_ATTR_TT_LAST_TTVN]	= { .type = NLA_U8 },
-	[BATADV_ATTR_TT_CRC32]		= { .type = NLA_U32 },
-	[BATADV_ATTR_TT_VID]		= { .type = NLA_U16 },
-	[BATADV_ATTR_TT_FLAGS]		= { .type = NLA_U32 },
-	[BATADV_ATTR_FLAG_BEST]		= { .type = NLA_FLAG },
-	[BATADV_ATTR_LAST_SEEN_MSECS]	= { .type = NLA_U32 },
-	[BATADV_ATTR_NEIGH_ADDRESS]	= { .len = ETH_ALEN },
-	[BATADV_ATTR_TQ]		= { .type = NLA_U8 },
-	[BATADV_ATTR_THROUGHPUT]	= { .type = NLA_U32 },
-	[BATADV_ATTR_BANDWIDTH_UP]	= { .type = NLA_U32 },
-	[BATADV_ATTR_BANDWIDTH_DOWN]	= { .type = NLA_U32 },
-	[BATADV_ATTR_ROUTER]		= { .len = ETH_ALEN },
-	[BATADV_ATTR_BLA_OWN]		= { .type = NLA_FLAG },
-	[BATADV_ATTR_BLA_ADDRESS]	= { .len = ETH_ALEN },
-	[BATADV_ATTR_BLA_VID]		= { .type = NLA_U16 },
-	[BATADV_ATTR_BLA_BACKBONE]	= { .len = ETH_ALEN },
-	[BATADV_ATTR_BLA_CRC]		= { .type = NLA_U16 },
+	[BATADV_ATTR_VERSION]			= { .type = NLA_STRING },
+	[BATADV_ATTR_ALGO_NAME]			= { .type = NLA_STRING },
+	[BATADV_ATTR_MESH_IFINDEX]		= { .type = NLA_U32 },
+	[BATADV_ATTR_MESH_IFNAME]		= { .type = NLA_STRING },
+	[BATADV_ATTR_MESH_ADDRESS]		= { .len = ETH_ALEN },
+	[BATADV_ATTR_HARD_IFINDEX]		= { .type = NLA_U32 },
+	[BATADV_ATTR_HARD_IFNAME]		= { .type = NLA_STRING },
+	[BATADV_ATTR_HARD_ADDRESS]		= { .len = ETH_ALEN },
+	[BATADV_ATTR_ORIG_ADDRESS]		= { .len = ETH_ALEN },
+	[BATADV_ATTR_TPMETER_RESULT]		= { .type = NLA_U8 },
+	[BATADV_ATTR_TPMETER_TEST_TIME]		= { .type = NLA_U32 },
+	[BATADV_ATTR_TPMETER_BYTES]		= { .type = NLA_U64 },
+	[BATADV_ATTR_TPMETER_COOKIE]		= { .type = NLA_U32 },
+	[BATADV_ATTR_ACTIVE]			= { .type = NLA_FLAG },
+	[BATADV_ATTR_TT_ADDRESS]		= { .len = ETH_ALEN },
+	[BATADV_ATTR_TT_TTVN]			= { .type = NLA_U8 },
+	[BATADV_ATTR_TT_LAST_TTVN]		= { .type = NLA_U8 },
+	[BATADV_ATTR_TT_CRC32]			= { .type = NLA_U32 },
+	[BATADV_ATTR_TT_VID]			= { .type = NLA_U16 },
+	[BATADV_ATTR_TT_FLAGS]			= { .type = NLA_U32 },
+	[BATADV_ATTR_FLAG_BEST]			= { .type = NLA_FLAG },
+	[BATADV_ATTR_LAST_SEEN_MSECS]		= { .type = NLA_U32 },
+	[BATADV_ATTR_NEIGH_ADDRESS]		= { .len = ETH_ALEN },
+	[BATADV_ATTR_TQ]			= { .type = NLA_U8 },
+	[BATADV_ATTR_THROUGHPUT]		= { .type = NLA_U32 },
+	[BATADV_ATTR_BANDWIDTH_UP]		= { .type = NLA_U32 },
+	[BATADV_ATTR_BANDWIDTH_DOWN]		= { .type = NLA_U32 },
+	[BATADV_ATTR_ROUTER]			= { .len = ETH_ALEN },
+	[BATADV_ATTR_BLA_OWN]			= { .type = NLA_FLAG },
+	[BATADV_ATTR_BLA_ADDRESS]		= { .len = ETH_ALEN },
+	[BATADV_ATTR_BLA_VID]			= { .type = NLA_U16 },
+	[BATADV_ATTR_BLA_BACKBONE]		= { .len = ETH_ALEN },
+	[BATADV_ATTR_BLA_CRC]			= { .type = NLA_U16 },
+	[BATADV_ATTR_DAT_CACHE_IP4ADDRESS]	= { .type = NLA_U32 },
+	[BATADV_ATTR_DAT_CACHE_HWADDRESS]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_DAT_CACHE_VID]		= { .type = NLA_U16 },
 };
 
 /**
@@ -604,6 +608,12 @@ static const struct genl_ops batadv_netlink_ops[] = {
 		.policy = batadv_netlink_policy,
 		.dumpit = batadv_bla_backbone_dump,
 	},
+	{
+		.cmd = BATADV_CMD_GET_DAT_CACHE,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.dumpit = batadv_dat_cache_dump,
+	},
 
 };
 
-- 
2.11.0

