Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon,  9 May 2016 20:07:16 +0200
Message-Id: <1462817239-18104-10-git-send-email-andrew@lunn.ch>
In-Reply-To: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
References: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCHv4 09/12] batman-adv: add B.A.T.M.A.N. V
	bat_{orig, neigh}_dump implementations
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

From: Matthias Schiffer <mschiffer@universe-factory.net>

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v2: Add missing includes
---
 include/uapi/linux/batman_adv.h |   1 +
 net/batman-adv/bat_iv_ogm.c     |   3 +
 net/batman-adv/bat_v.c          | 262 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index baf4ac8..27f277f 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -78,6 +78,7 @@ enum {
 	BATADV_ATTR_LAST_SEEN_MSECS,
 	BATADV_ATTR_NEIGH_ADDRESS,
 	BATADV_ATTR_TQ,
+	BATADV_ATTR_THROUGHPUT,
 	__BATADV_ATTR_MAX,
 };
 
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 632e60a..9abfdbb 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -35,6 +35,7 @@
 #include <linux/kref.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/pkt_sched.h>
 #include <linux/printk.h>
 #include <linux/random.h>
@@ -48,6 +49,8 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "bitarray.h"
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index c16cd44..5daa300 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -20,24 +20,33 @@
 
 #include <linux/atomic.h>
 #include <linux/bug.h>
+#include <linux/errno.h>
+#include <linux/if_ether.h>
 #include <linux/cache.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "bat_v_elp.h"
 #include "bat_v_ogm.h"
 #include "hard-interface.h"
 #include "hash.h"
+#include "netlink.h"
 #include "originator.h"
 #include "packet.h"
 
+struct sk_buff;
+
 static void batadv_v_iface_activate(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
@@ -203,6 +212,107 @@ static void batadv_v_neigh_print(struct batadv_priv *bat_priv,
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
+static int
+batadv_v_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
+			  struct batadv_hardif_neigh_node *hardif_neigh)
+{
+	void *hdr;
+	unsigned int last_seen_msecs;
+	u32 throughput;
+
+	last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
+	throughput = ewma_throughput_read(&hardif_neigh->bat_v.throughput);
+	throughput = throughput * 100;
+
+	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family, NLM_F_MULTI,
+			  BATADV_CMD_GET_NEIGHBORS);
+	if (!hdr)
+		return -ENOBUFS;
+
+	if (nla_put(msg, BATADV_ATTR_NEIGH_ADDRESS, ETH_ALEN,
+		    hardif_neigh->addr) ||
+	    nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX,
+			hardif_neigh->if_incoming->net_dev->ifindex) ||
+	    nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS,
+			last_seen_msecs) ||
+	    nla_put_u32(msg, BATADV_ATTR_THROUGHPUT, throughput))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+	return 0;
+
+ nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+static int
+batadv_v_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
+			   struct batadv_priv *bat_priv,
+			   struct batadv_hard_iface *hard_iface,
+			   int *idx_s)
+{
+	struct batadv_hardif_neigh_node *hardif_neigh;
+	int idx = 0;
+
+	hlist_for_each_entry_rcu(hardif_neigh,
+				 &hard_iface->neigh_list, list) {
+		if (idx++ < *idx_s)
+			continue;
+
+		if (batadv_v_neigh_dump_neigh(msg, portid, seq, hardif_neigh)) {
+			*idx_s = idx - 1;
+			return -EMSGSIZE;
+		}
+	}
+
+	*idx_s = 0;
+	return 0;
+}
+
+static void
+batadv_v_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
+		    struct batadv_priv *bat_priv,
+		    struct batadv_hard_iface *single_hardif)
+{
+	struct batadv_hard_iface *hard_iface;
+	int i_hardif = 0;
+	int i_hardif_s = cb->args[0];
+	int idx = cb->args[1];
+	int portid = NETLINK_CB(cb->skb).portid;
+
+	rcu_read_lock();
+	if (single_hardif) {
+		if (i_hardif_s == 0) {
+			if (batadv_v_neigh_dump_hardif(msg, portid,
+						       cb->nlh->nlmsg_seq,
+						       bat_priv, single_hardif,
+						       &idx) == 0)
+				i_hardif++;
+		}
+	} else {
+		list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+			if (hard_iface->soft_iface != bat_priv->soft_iface)
+				continue;
+
+			if (i_hardif++ < i_hardif_s)
+				continue;
+
+			if (batadv_v_neigh_dump_hardif(msg, portid,
+						       cb->nlh->nlmsg_seq,
+						       bat_priv, hard_iface,
+						       &idx)) {
+				i_hardif--;
+				break;
+			}
+		}
+	}
+	rcu_read_unlock();
+
+	cb->args[0] = i_hardif;
+	cb->args[1] = idx;
+}
+
 /**
  * batadv_v_orig_print - print the originator table
  * @bat_priv: the bat priv with all the soft interface information
@@ -270,6 +380,156 @@ next:
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
+static int
+batadv_v_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
+			    struct batadv_priv *bat_priv,
+			    struct batadv_hard_iface *if_outgoing,
+			    struct batadv_orig_node *orig_node,
+			    struct batadv_neigh_node *neigh_node,
+			    bool best)
+{
+	struct batadv_neigh_ifinfo *n_ifinfo;
+	unsigned int last_seen_msecs;
+	u32 throughput;
+	void *hdr;
+
+	n_ifinfo = batadv_neigh_ifinfo_get(neigh_node, if_outgoing);
+	if (!n_ifinfo)
+		return 0;
+
+	throughput = n_ifinfo->bat_v.throughput * 100;
+
+	batadv_neigh_ifinfo_put(n_ifinfo);
+
+	last_seen_msecs = jiffies_to_msecs(jiffies - orig_node->last_seen);
+
+	if (if_outgoing != BATADV_IF_DEFAULT &&
+	    if_outgoing != neigh_node->if_incoming)
+		return 0;
+
+
+	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family, NLM_F_MULTI,
+			  BATADV_CMD_GET_ORIGINATORS);
+	if (!hdr)
+		return -ENOBUFS;
+
+	if (nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN, orig_node->orig) ||
+	    nla_put(msg, BATADV_ATTR_NEIGH_ADDRESS, ETH_ALEN,
+		    neigh_node->addr) ||
+	    nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX,
+			neigh_node->if_incoming->net_dev->ifindex) ||
+	    nla_put_u32(msg, BATADV_ATTR_THROUGHPUT, throughput) ||
+	    nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS,
+			last_seen_msecs))
+		goto nla_put_failure;
+
+	if (best && nla_put_flag(msg, BATADV_ATTR_FLAG_BEST))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+	return 0;
+
+ nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+static int
+batadv_v_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+			 struct batadv_priv *bat_priv,
+			 struct batadv_hard_iface *if_outgoing,
+			 struct batadv_orig_node *orig_node, int *sub_s)
+{
+	struct batadv_neigh_node *neigh_node_best;
+	struct batadv_neigh_node *neigh_node;
+	int sub = 0;
+	bool best;
+
+	neigh_node_best = batadv_orig_router_get(orig_node, if_outgoing);
+	if (!neigh_node_best)
+		goto out;
+
+	hlist_for_each_entry_rcu(neigh_node, &orig_node->neigh_list, list) {
+		if (sub++ < *sub_s)
+			continue;
+
+		best = (neigh_node == neigh_node_best);
+
+		if (batadv_v_orig_dump_subentry(msg, portid, seq, bat_priv,
+						if_outgoing, orig_node,
+						neigh_node, best)) {
+			batadv_neigh_node_put(neigh_node_best);
+
+			*sub_s = sub - 1;
+			return -EMSGSIZE;
+		}
+	}
+
+ out:
+	if (neigh_node_best)
+		batadv_neigh_node_put(neigh_node_best);
+
+	*sub_s = 0;
+	return 0;
+}
+
+static int
+batadv_v_orig_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
+			  struct batadv_priv *bat_priv,
+			  struct batadv_hard_iface *if_outgoing,
+			  struct hlist_head *head, int *idx_s, int *sub)
+{
+	struct batadv_orig_node *orig_node;
+	int idx = 0;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
+		if (idx++ < *idx_s)
+			continue;
+
+		if (batadv_v_orig_dump_entry(msg, portid, seq, bat_priv,
+					     if_outgoing, orig_node, sub)) {
+			rcu_read_unlock();
+			*idx_s = idx - 1;
+			return -EMSGSIZE;
+		}
+	}
+	rcu_read_unlock();
+
+	*idx_s = 0;
+	*sub = 0;
+	return 0;
+}
+
+static void
+batadv_v_orig_dump(struct sk_buff *msg, struct netlink_callback *cb,
+		   struct batadv_priv *bat_priv,
+		   struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_hashtable *hash = bat_priv->orig_hash;
+	struct hlist_head *head;
+	int bucket = cb->args[0];
+	int idx = cb->args[1];
+	int sub = cb->args[2];
+	int portid = NETLINK_CB(cb->skb).portid;
+
+	while (bucket < hash->size) {
+		head = &hash->table[bucket];
+
+		if (batadv_v_orig_dump_bucket(msg, portid,
+					      cb->nlh->nlmsg_seq,
+					      bat_priv, if_outgoing, head, &idx,
+					      &sub))
+			break;
+
+		bucket++;
+	}
+
+	cb->args[0] = bucket;
+	cb->args[1] = idx;
+	cb->args[2] = sub;
+}
+
 static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
 			      struct batadv_hard_iface *if_outgoing1,
 			      struct batadv_neigh_node *neigh2,
@@ -333,9 +593,11 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.bat_primary_iface_set = batadv_v_primary_iface_set,
 	.bat_hardif_neigh_init = batadv_v_hardif_neigh_init,
 	.bat_orig_print = batadv_v_orig_print,
+	.bat_orig_dump = batadv_v_orig_dump,
 	.bat_neigh_cmp = batadv_v_neigh_cmp,
 	.bat_neigh_is_similar_or_better = batadv_v_neigh_is_sob,
 	.bat_neigh_print = batadv_v_neigh_print,
+	.bat_neigh_dump = batadv_v_neigh_dump,
 };
 
 /**
-- 
2.8.0.rc3

