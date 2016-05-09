Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon,  9 May 2016 20:07:15 +0200
Message-Id: <1462817239-18104-9-git-send-email-andrew@lunn.ch>
In-Reply-To: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
References: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCHv4 08/12] batman-adv: add B.A.T.M.A.N. IV
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
---
 include/uapi/linux/batman_adv.h |   2 +
 net/batman-adv/bat_iv_ogm.c     | 274 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 276 insertions(+)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 35d8e8c..baf4ac8 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -76,6 +76,8 @@ enum {
 	BATADV_ATTR_TT_FLAGS,
 	BATADV_ATTR_FLAG_BEST,
 	BATADV_ATTR_LAST_SEEN_MSECS,
+	BATADV_ATTR_NEIGH_ADDRESS,
+	BATADV_ATTR_TQ,
 	__BATADV_ATTR_MAX,
 };
 
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 4815db9..632e60a 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -48,10 +48,12 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "bitarray.h"
 #include "hard-interface.h"
 #include "hash.h"
+#include "netlink.h"
 #include "network-coding.h"
 #include "originator.h"
 #include "packet.h"
@@ -1975,6 +1977,177 @@ next:
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
+static bool
+batadv_iv_ogm_neigh_get_tq_avg(struct batadv_neigh_node *neigh_node,
+			       struct batadv_hard_iface *if_outgoing,
+			       u8 *tq_avg)
+{
+	struct batadv_neigh_ifinfo *n_ifinfo;
+
+	n_ifinfo = batadv_neigh_ifinfo_get(neigh_node, if_outgoing);
+	if (!n_ifinfo)
+		return false;
+
+	*tq_avg = n_ifinfo->bat_iv.tq_avg;
+	batadv_neigh_ifinfo_put(n_ifinfo);
+
+	return true;
+}
+
+static int
+batadv_iv_ogm_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
+				 struct batadv_priv *bat_priv,
+				 struct batadv_hard_iface *if_outgoing,
+				 struct batadv_orig_node *orig_node,
+				 struct batadv_neigh_node *neigh_node,
+				 bool best)
+{
+	void *hdr;
+	u8 tq_avg;
+	unsigned int last_seen_msecs;
+
+	last_seen_msecs = jiffies_to_msecs(jiffies - orig_node->last_seen);
+
+	if (!batadv_iv_ogm_neigh_get_tq_avg(neigh_node, if_outgoing, &tq_avg))
+		return 0;
+
+	if (if_outgoing != BATADV_IF_DEFAULT &&
+	    if_outgoing != neigh_node->if_incoming)
+		return 0;
+
+	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
+			  NLM_F_MULTI, BATADV_CMD_GET_ORIGINATORS);
+	if (!hdr)
+		return -ENOBUFS;
+
+	if (nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN,
+		    orig_node->orig) ||
+	    nla_put(msg, BATADV_ATTR_NEIGH_ADDRESS, ETH_ALEN,
+		    neigh_node->addr) ||
+	    nla_put_u32(msg, BATADV_ATTR_HARD_IFINDEX,
+			neigh_node->if_incoming->net_dev->ifindex) ||
+	    nla_put_u8(msg, BATADV_ATTR_TQ, tq_avg) ||
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
+batadv_iv_ogm_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+			      struct batadv_priv *bat_priv,
+			      struct batadv_hard_iface *if_outgoing,
+			      struct batadv_orig_node *orig_node, int *sub_s)
+{
+	struct batadv_neigh_node *neigh_node_best;
+	struct batadv_neigh_node *neigh_node;
+	int sub = 0;
+	bool best;
+	u8 tq_avg_best;
+
+	neigh_node_best = batadv_orig_router_get(orig_node, if_outgoing);
+	if (!neigh_node_best)
+		goto out;
+
+	if (!batadv_iv_ogm_neigh_get_tq_avg(neigh_node_best, if_outgoing,
+					    &tq_avg_best))
+		goto out;
+
+	if (tq_avg_best == 0)
+		goto out;
+
+	hlist_for_each_entry_rcu(neigh_node, &orig_node->neigh_list, list) {
+		if (sub++ < *sub_s)
+			continue;
+
+		best = (neigh_node == neigh_node_best);
+
+		if (batadv_iv_ogm_orig_dump_subentry(msg, portid, seq,
+						     bat_priv, if_outgoing,
+						     orig_node, neigh_node,
+						     best)) {
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
+batadv_iv_ogm_orig_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
+			       struct batadv_priv *bat_priv,
+			       struct batadv_hard_iface *if_outgoing,
+			       struct hlist_head *head, int *idx_s, int *sub)
+{
+	struct batadv_orig_node *orig_node;
+	int idx = 0;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
+		if (idx++ < *idx_s)
+			continue;
+
+		if (batadv_iv_ogm_orig_dump_entry(msg, portid, seq, bat_priv,
+						  if_outgoing, orig_node,
+						  sub)) {
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
+batadv_iv_ogm_orig_dump(struct sk_buff *msg, struct netlink_callback *cb,
+			struct batadv_priv *bat_priv,
+			struct batadv_hard_iface *if_outgoing)
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
+		if (batadv_iv_ogm_orig_dump_bucket(msg, portid,
+						   cb->nlh->nlmsg_seq,
+						   bat_priv, if_outgoing, head,
+						   &idx, &sub))
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
 /**
  * batadv_iv_hardif_neigh_print - print a single hop neighbour node
  * @seq: neighbour table seq_file struct
@@ -2026,6 +2199,105 @@ static void batadv_iv_neigh_print(struct batadv_priv *bat_priv,
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
+static int
+batadv_iv_ogm_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
+			       struct batadv_hardif_neigh_node *hardif_neigh)
+{
+	void *hdr;
+	unsigned int last_seen_msecs;
+
+	last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
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
+			last_seen_msecs))
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
+batadv_iv_ogm_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
+				struct batadv_priv *bat_priv,
+				struct batadv_hard_iface *hard_iface,
+				int *idx_s)
+{
+	struct batadv_hardif_neigh_node *hardif_neigh;
+	int idx = 0;
+
+	hlist_for_each_entry_rcu(hardif_neigh,
+				 &hard_iface->neigh_list, list) {
+		if (idx++ < *idx_s)
+			continue;
+
+		if (batadv_iv_ogm_neigh_dump_neigh(msg, portid, seq,
+						   hardif_neigh)) {
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
+batadv_iv_ogm_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
+			 struct batadv_priv *bat_priv,
+			 struct batadv_hard_iface *single_hardif)
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
+			if (batadv_iv_ogm_neigh_dump_hardif(msg, portid,
+							    cb->nlh->nlmsg_seq,
+							    bat_priv,
+							    single_hardif,
+							    &idx) == 0)
+				i_hardif++;
+		}
+	} else {
+		list_for_each_entry_rcu(hard_iface, &batadv_hardif_list,
+					list) {
+			if (hard_iface->soft_iface != bat_priv->soft_iface)
+				continue;
+
+			if (i_hardif++ < i_hardif_s)
+				continue;
+
+			if (batadv_iv_ogm_neigh_dump_hardif(
+				    msg, portid, cb->nlh->nlmsg_seq,
+				    bat_priv, hard_iface, &idx)) {
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
  * batadv_iv_ogm_neigh_cmp - compare the metrics of two neighbors
  * @neigh1: the first neighbor object of the comparison
@@ -2125,7 +2397,9 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.bat_neigh_cmp = batadv_iv_ogm_neigh_cmp,
 	.bat_neigh_is_similar_or_better = batadv_iv_ogm_neigh_is_sob,
 	.bat_neigh_print = batadv_iv_neigh_print,
+	.bat_neigh_dump = batadv_iv_ogm_neigh_dump,
 	.bat_orig_print = batadv_iv_ogm_orig_print,
+	.bat_orig_dump = batadv_iv_ogm_orig_dump,
 	.bat_orig_free = batadv_iv_ogm_orig_free,
 	.bat_orig_add_if = batadv_iv_ogm_orig_add_if,
 	.bat_orig_del_if = batadv_iv_ogm_orig_del_if,
-- 
2.8.0.rc3

