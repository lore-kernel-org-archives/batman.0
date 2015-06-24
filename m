Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Wed, 24 Jun 2015 20:34:28 +0200
Message-Id: <2ce4491cf3eb01922d0fec97147a1533cca30c41.1435170868.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: add generic netlink query API to
	replace debugfs files
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

This is the first RFC for a new way to query originators and translation
tables, with the intention to make it a replacement for the current debugfs
files. I talked about this with Antonio in IRC 1~2 weeks ago.

debugfs is currently severely broken virtually everywhere in the kernel
where files are dynamically added and removed (see
http://lkml.iu.edu/hypermail/linux/kernel/1506.1/02196.html for some
details). In addition to that, there are general drawbacks to the current
approach:

* As batman-adv uses single_open, the whole content of the originators/
  transglobal files must fit into a single buffer; in large batman-adv
  networks this often fails (as an order-5 allocation or even more would be
  necessary)
* When originators or transglobal aren't just used for debugging, they are
  first converted to text, and then parsed again in userspace by tools like
  alfred/batadv-vis. Sending MAC address lists from the kernel to userspace
  as text makes the buffer size issue even worse.

For all commands that dump tables (originators, translocal, transglobal)
only NLM_F_DUMP queries are allowed, so arbitrary numbers of entries can be
dumped without ever needing a buffer larger than one page.

As the kernel can return to userspace any time during a query and only the
index of the entry to dump next is saved for the next call, this means that
the dump is not necessarily atomic, and it is even possible for entries
that haven't changed inbetween to be missing in the dump or be dumped
twice. This is a general limitation of all netlink APIs; it would be
possible though to add an atomic "revision" counter to each sent entry, so
userspace can at least detect this case and restart the query if atomicity
is desired.

TODOs:

* I plan to add more query types (list of supported algorithms; list of
  hardifs for a given softif)
* Add kernel doc comments (I guess some parts of the patch could generally
  need a few comments...)
* Add documentation
* Split into multiple patches?
* Add revision counter?
* The new file include/uapi/linux/batman_adv.h needs a MAINTAINERS entry
  when this submitted to the kernel

I'll also send a userspace tool which can be used to query the new netlink
interfaces. For translocal and transglobal, the output is identical to the
debugfs content, for originators the format is different as the netlink
API provides only one neighbor per record. When the kernel API is stable,
I'll convert it to a nice little library (libbatadv?) which can then be
used by applications like alfred and batctl to replace their debugfs usage.
---
 Makefile                           |   1 +
 include/uapi/linux/batman_adv.h    |  67 ++++++++
 net/batman-adv/Makefile            |   1 +
 net/batman-adv/bat_iv_ogm.c        | 168 +++++++++++++++++++
 net/batman-adv/main.c              |   3 +
 net/batman-adv/netlink.c           | 174 +++++++++++++++++++
 net/batman-adv/netlink.h           |  36 ++++
 net/batman-adv/originator.c        |  75 +++++++++
 net/batman-adv/originator.h        |   1 +
 net/batman-adv/translation-table.c | 332 +++++++++++++++++++++++++++++++++++++
 net/batman-adv/translation-table.h |   2 +
 net/batman-adv/types.h             |   4 +
 12 files changed, 864 insertions(+)
 create mode 100644 include/uapi/linux/batman_adv.h
 create mode 100644 net/batman-adv/netlink.c
 create mode 100644 net/batman-adv/netlink.h

diff --git a/Makefile b/Makefile
index ee3be1d..7154c96 100644
--- a/Makefile
+++ b/Makefile
@@ -43,6 +43,7 @@ REVISION= $(shell	if [ -d "$(PWD)/.git" ]; then \
 			fi)
 export NOSTDINC_FLAGS := \
 	-I$(PWD)/compat-include/ \
+	-I$(PWD)/include/ \
 	-include $(PWD)/compat.h \
 	$(CFLAGS)
 
diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
new file mode 100644
index 0000000..7714466
--- /dev/null
+++ b/include/uapi/linux/batman_adv.h
@@ -0,0 +1,67 @@
+/* Copyright (C) 2015 B.A.T.M.A.N. contributors:
+ *
+ * Matthias Schiffer
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _UAPI_LINUX_BATMAN_ADV_H_
+#define _UAPI_LINUX_BATMAN_ADV_H_
+
+#define BATADV_NL_NAME "batadv"
+
+enum {
+	BATADV_ATTR_UNSPEC,
+	BATADV_ATTR_VERSION,
+	BATADV_ATTR_ALGO_NAME,
+	BATADV_ATTR_MESH_IFINDEX,
+	BATADV_ATTR_MESH_IFNAME,
+	BATADV_ATTR_MESH_ADDRESS,
+	BATADV_ATTR_PRIMARY_IFINDEX,
+	BATADV_ATTR_PRIMARY_IFNAME,
+	BATADV_ATTR_PRIMARY_ADDRESS,
+	BATADV_ATTR_HARD_IFINDEX,
+	BATADV_ATTR_ORIG_ADDRESS,
+	BATADV_ATTR_NEIGH_ADDRESS,
+	BATADV_ATTR_TQ,
+	BATADV_ATTR_LAST_SEEN_MSECS,
+	BATADV_ATTR_TT_ADDRESS,
+	BATADV_ATTR_TT_TTVN,
+	BATADV_ATTR_TT_LAST_TTVN,
+	BATADV_ATTR_TT_CRC32,
+	BATADV_ATTR_TT_VID,
+	BATADV_ATTR_FLAG_BEST,
+	BATADV_ATTR_FLAG_ROAM,
+	BATADV_ATTR_FLAG_NOPURGE,
+	BATADV_ATTR_FLAG_NEW,
+	BATADV_ATTR_FLAG_PENDING,
+	BATADV_ATTR_FLAG_WIFI,
+	BATADV_ATTR_FLAG_ISOLA,
+	BATADV_ATTR_FLAG_TEMP,
+	__BATADV_ATTR_MAX,
+};
+
+#define BATADV_ATTR_MAX (__BATADV_ATTR_MAX - 1)
+
+enum {
+	BATADV_CMD_UNSPEC,
+	BATADV_CMD_GET_MESH_INFO,
+	BATADV_CMD_GET_TRANSTABLE_LOCAL,
+	BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+	BATADV_CMD_GET_ORIGINATORS,
+	__BATADV_CMD_MAX,
+};
+
+#define BATADV_CMD_MAX (__BATADV_CMD_MAX - 1)
+
+#endif /* _UAPI_LINUX_BATMAN_ADV_H_ */
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 21434ab..64e054e 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -30,6 +30,7 @@ batman-adv-y += hash.o
 batman-adv-y += icmp_socket.o
 batman-adv-y += main.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast.o
+batman-adv-y += netlink.o
 batman-adv-$(CONFIG_BATMAN_ADV_NC) += network-coding.o
 batman-adv-y += originator.o
 batman-adv-y += routing.o
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index df54118..390cfb5 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -45,10 +45,12 @@
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
@@ -1887,6 +1889,171 @@ next:
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
+	batadv_neigh_ifinfo_free_ref(n_ifinfo);
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
+		if (batadv_iv_ogm_orig_dump_subentry(msg, portid, seq, bat_priv,
+						     if_outgoing, orig_node,
+						     neigh_node, best)) {
+			batadv_neigh_node_free_ref(neigh_node_best);
+
+			*sub_s = sub - 1;
+			return -EMSGSIZE;
+		}
+	}
+
+ out:
+	if (neigh_node_best)
+		batadv_neigh_node_free_ref(neigh_node_best);
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
  * batadv_iv_ogm_neigh_cmp - compare the metrics of two neighbors
  * @neigh1: the first neighbor object of the comparison
@@ -1981,6 +2148,7 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.bat_neigh_cmp = batadv_iv_ogm_neigh_cmp,
 	.bat_neigh_is_equiv_or_better = batadv_iv_ogm_neigh_is_eob,
 	.bat_orig_print = batadv_iv_ogm_orig_print,
+	.bat_orig_dump = batadv_iv_ogm_orig_dump,
 	.bat_orig_free = batadv_iv_ogm_orig_free,
 	.bat_orig_add_if = batadv_iv_ogm_orig_add_if,
 	.bat_orig_del_if = batadv_iv_ogm_orig_del_if,
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 40750cb..11a387b 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -55,6 +55,7 @@
 #include "hard-interface.h"
 #include "icmp_socket.h"
 #include "multicast.h"
+#include "netlink.h"
 #include "network-coding.h"
 #include "originator.h"
 #include "packet.h"
@@ -98,6 +99,7 @@ static int __init batadv_init(void)
 
 	register_netdevice_notifier(&batadv_hard_if_notifier);
 	rtnl_link_register(&batadv_link_ops);
+	batadv_netlink_register();
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
 		BATADV_SOURCE_VERSION, BATADV_COMPAT_VERSION);
@@ -108,6 +110,7 @@ static int __init batadv_init(void)
 static void __exit batadv_exit(void)
 {
 	batadv_debugfs_destroy();
+	batadv_netlink_unregister();
 	rtnl_link_unregister(&batadv_link_ops);
 	unregister_netdevice_notifier(&batadv_hard_if_notifier);
 	batadv_hardif_remove_interfaces();
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
new file mode 100644
index 0000000..9189872
--- /dev/null
+++ b/net/batman-adv/netlink.c
@@ -0,0 +1,174 @@
+/* Copyright (C) 2015 B.A.T.M.A.N. contributors:
+ *
+ * Matthias Schiffer
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "main.h"
+#include "netlink.h"
+
+#include <linux/netdevice.h>
+#include <uapi/linux/batman_adv.h>
+
+#include "hard-interface.h"
+#include "originator.h"
+#include "soft-interface.h"
+#include "translation-table.h"
+
+struct genl_family batadv_netlink_family = {
+	.id = GENL_ID_GENERATE,
+	.hdrsize = 0,
+	.name = BATADV_NL_NAME,
+	.version = 1,
+	.maxattr = BATADV_ATTR_MAX,
+};
+
+static int
+batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
+{
+	int ret = -ENOBUFS;
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	struct batadv_hard_iface *primary_if = NULL;
+	struct net_device *hard_iface;
+
+	if (nla_put_string(msg, BATADV_ATTR_VERSION, BATADV_SOURCE_VERSION) ||
+	    nla_put_string(msg, BATADV_ATTR_ALGO_NAME,
+			   bat_priv->bat_algo_ops->name) ||
+	    nla_put_u32(msg, BATADV_ATTR_MESH_IFINDEX, soft_iface->ifindex) ||
+	    nla_put_string(msg, BATADV_ATTR_MESH_IFNAME, soft_iface->name) ||
+	    nla_put(msg, BATADV_ATTR_MESH_ADDRESS, ETH_ALEN,
+		    soft_iface->dev_addr))
+		goto out;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (primary_if && primary_if->if_status == BATADV_IF_ACTIVE) {
+		hard_iface = primary_if->net_dev;
+
+		if (nla_put_u32(msg, BATADV_ATTR_PRIMARY_IFINDEX,
+				hard_iface->ifindex) ||
+		    nla_put_string(msg, BATADV_ATTR_PRIMARY_IFNAME,
+				   hard_iface->name) ||
+		    nla_put(msg, BATADV_ATTR_PRIMARY_ADDRESS, ETH_ALEN,
+			    hard_iface->dev_addr))
+			goto out;
+	}
+
+	ret = 0;
+
+ out:
+	if (primary_if)
+		batadv_hardif_free_ref(primary_if);
+
+	return ret;
+}
+
+static int
+batadv_netlink_get_mesh_info(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	int ret;
+	struct sk_buff *msg = NULL;
+	void *msg_head;
+	int ifindex;
+	struct net_device *soft_iface = NULL;
+
+	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
+		return -EINVAL;
+
+	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
+	if (!ifindex)
+		return -EINVAL;
+
+	soft_iface = dev_get_by_index(net, ifindex);
+	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	msg_head = genlmsg_put(msg, info->snd_portid, info->snd_seq,
+			       &batadv_netlink_family, 0,
+			       BATADV_CMD_GET_MESH_INFO);
+	if (!msg_head) {
+		ret = -ENOBUFS;
+		goto out;
+	}
+
+	ret = batadv_netlink_mesh_info_put(msg, soft_iface);
+
+ out:
+	if (soft_iface)
+		dev_put(soft_iface);
+
+	if (ret) {
+		if (msg)
+			nlmsg_free(msg);
+		return ret;
+	}
+
+	genlmsg_end(msg, msg_head);
+	return genlmsg_reply(msg, info);
+}
+
+static struct nla_policy batadv_netlink_policy[BATADV_ATTR_MAX + 1] = {
+	[BATADV_ATTR_MESH_IFINDEX]		= { .type = NLA_U32 },
+	[BATADV_ATTR_HARD_IFINDEX]		= { .type = NLA_U32 },
+};
+
+static struct genl_ops batadv_netlink_ops[] = {
+	{
+		.cmd = BATADV_CMD_GET_MESH_INFO,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.doit = batadv_netlink_get_mesh_info,
+	},
+	{
+		.cmd = BATADV_CMD_GET_TRANSTABLE_LOCAL,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.dumpit = batadv_tt_local_dump,
+	},
+	{
+		.cmd = BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.dumpit = batadv_tt_global_dump,
+	},
+	{
+		.cmd = BATADV_CMD_GET_ORIGINATORS,
+		.flags = GENL_ADMIN_PERM,
+		.policy = batadv_netlink_policy,
+		.dumpit = batadv_orig_dump,
+	},
+};
+
+void __init batadv_netlink_register(void)
+{
+	int ret;
+
+	ret = genl_register_family_with_ops(&batadv_netlink_family,
+					    batadv_netlink_ops);
+	if (ret)
+		pr_warn("unable to register netlink family");
+}
+
+void batadv_netlink_unregister(void)
+{
+	genl_unregister_family(&batadv_netlink_family);
+}
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
new file mode 100644
index 0000000..a571300
--- /dev/null
+++ b/net/batman-adv/netlink.h
@@ -0,0 +1,36 @@
+/* Copyright (C) 2015 B.A.T.M.A.N. contributors:
+ *
+ * Matthias Schiffer
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _NET_BATMAN_ADV_NETLINK_H_
+#define _NET_BATMAN_ADV_NETLINK_H_
+
+#include <net/genetlink.h>
+
+void batadv_netlink_register(void);
+void batadv_netlink_unregister(void);
+
+static inline int
+batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype)
+{
+	struct nlattr *attr = nlmsg_find_attr(nlh, GENL_HDRLEN, attrtype);
+
+	return attr ? nla_get_u32(attr) : 0;
+}
+
+extern struct genl_family batadv_netlink_family;
+
+#endif /* _NET_BATMAN_ADV_NETLINK_H_ */
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 4500e3a..4229fe2 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -30,6 +30,8 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <net/sock.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "distributed-arp-table.h"
 #include "fragmentation.h"
@@ -37,8 +39,10 @@
 #include "hard-interface.h"
 #include "hash.h"
 #include "multicast.h"
+#include "netlink.h"
 #include "network-coding.h"
 #include "routing.h"
+#include "soft-interface.h"
 #include "translation-table.h"
 
 /* hash class keys */
@@ -1106,6 +1110,77 @@ out:
 	return 0;
 }
 
+int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct net *net = sock_net(cb->skb->sk);
+	struct net_device *soft_iface = NULL;
+	struct net_device *outgoing_iface = NULL;
+	struct batadv_hard_iface *outgoing_hardif = BATADV_IF_DEFAULT;
+	struct batadv_priv *bat_priv;
+	struct batadv_hard_iface *primary_if = NULL;
+	int ret;
+	int ifindex, ifindex_outgoing;
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
+	ifindex_outgoing = batadv_netlink_get_ifindex(cb->nlh,
+						      BATADV_ATTR_HARD_IFINDEX);
+	if (ifindex_outgoing) {
+		outgoing_iface = dev_get_by_index(net, ifindex_outgoing);
+		if (outgoing_iface)
+			outgoing_hardif =
+				batadv_hardif_get_by_netdev(outgoing_iface);
+
+		if (!outgoing_hardif) {
+			ret = -ENODEV;
+			goto out;
+		}
+
+		if (outgoing_hardif->soft_iface != soft_iface) {
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
+	bat_priv->bat_algo_ops->bat_orig_dump(msg, cb, bat_priv,
+					      outgoing_hardif);
+
+	ret = msg->len;
+
+ out:
+	if (outgoing_hardif)
+		batadv_hardif_free_ref(outgoing_hardif);
+	if (outgoing_iface)
+		dev_put(outgoing_iface);
+	if (primary_if)
+		batadv_hardif_free_ref(primary_if);
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
index 3fc76f6..9e66e0d 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -69,6 +69,7 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 void batadv_orig_ifinfo_free_ref(struct batadv_orig_ifinfo *orig_ifinfo);
 
 int batadv_orig_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb);
 int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num);
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 03d739b..4b080e2 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -43,11 +43,14 @@
 #include <linux/string.h>
 #include <linux/workqueue.h>
 #include <net/net_namespace.h>
+#include <net/sock.h>
+#include <uapi/linux/batman_adv.h>
 
 #include "bridge_loop_avoidance.h"
 #include "hard-interface.h"
 #include "hash.h"
 #include "multicast.h"
+#include "netlink.h"
 #include "originator.h"
 #include "packet.h"
 #include "soft-interface.h"
@@ -1010,6 +1013,155 @@ out:
 	return 0;
 }
 
+static int
+batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+			   struct batadv_priv *bat_priv,
+			   struct batadv_tt_common_entry *common)
+{
+	void *hdr;
+	struct batadv_softif_vlan *vlan;
+	struct batadv_tt_local_entry *local;
+	u16 flags = common->flags;
+	unsigned int last_seen_msecs;
+	u32 crc;
+
+	local = container_of(common, struct batadv_tt_local_entry, common);
+	last_seen_msecs = jiffies_to_msecs(jiffies - local->last_seen);
+
+	vlan = batadv_softif_vlan_get(bat_priv, common->vid);
+	if (!vlan)
+		return 0;
+
+	crc = vlan->tt.crc;
+
+	batadv_softif_vlan_free_ref(vlan);
+
+	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family, NLM_F_MULTI,
+			  BATADV_CMD_GET_TRANSTABLE_LOCAL);
+	if (!hdr)
+		return -ENOBUFS;
+
+	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->addr) ||
+	    nla_put_u32(msg, BATADV_ATTR_TT_CRC32, crc) ||
+	    nla_put_u16(msg, BATADV_ATTR_TT_VID, BATADV_PRINT_VID(common->vid)))
+		goto nla_put_failure;
+
+	if ((flags & BATADV_TT_CLIENT_ROAM) &&
+	    nla_put_flag(msg, BATADV_ATTR_FLAG_ROAM))
+		goto nla_put_failure;
+	if ((flags & BATADV_TT_CLIENT_NOPURGE) &&
+	    nla_put_flag(msg, BATADV_ATTR_FLAG_NOPURGE))
+		goto nla_put_failure;
+	if ((flags & BATADV_TT_CLIENT_NEW) &&
+	    nla_put_flag(msg, BATADV_ATTR_FLAG_NEW))
+		goto nla_put_failure;
+	if ((flags & BATADV_TT_CLIENT_PENDING) &&
+	    nla_put_flag(msg, BATADV_ATTR_FLAG_PENDING))
+		goto nla_put_failure;
+	if ((flags & BATADV_TT_CLIENT_WIFI) &&
+	    nla_put_flag(msg, BATADV_ATTR_FLAG_WIFI))
+		goto nla_put_failure;
+	if ((flags & BATADV_TT_CLIENT_ISOLA) &&
+	    nla_put_flag(msg, BATADV_ATTR_FLAG_ISOLA))
+		goto nla_put_failure;
+
+	if (!(flags & BATADV_TT_CLIENT_NOPURGE) &&
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
+batadv_tt_local_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
+			    struct batadv_priv *bat_priv,
+			    struct hlist_head *head, int *idx_s)
+{
+	struct batadv_tt_common_entry *common;
+	int idx = 0;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(common, head, hash_entry) {
+		if (idx++ < *idx_s)
+			continue;
+
+		if (batadv_tt_local_dump_entry(msg, portid, seq, bat_priv,
+					       common)) {
+			rcu_read_unlock();
+			*idx_s = idx - 1;
+			return -EMSGSIZE;
+		}
+	}
+	rcu_read_unlock();
+
+	*idx_s = 0;
+	return 0;
+}
+
+int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct net *net = sock_net(cb->skb->sk);
+	struct net_device *soft_iface = NULL;
+	struct batadv_priv *bat_priv;
+	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_hashtable *hash;
+	struct hlist_head *head;
+	int ret;
+	int ifindex;
+	int bucket = cb->args[0];
+	int idx = cb->args[1];
+	int portid = NETLINK_CB(cb->skb).portid;
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
+	hash = bat_priv->tt.local_hash;
+
+	while (bucket < hash->size) {
+		head = &hash->table[bucket];
+
+		if (batadv_tt_local_dump_bucket(msg, portid, cb->nlh->nlmsg_seq,
+						bat_priv, head, &idx))
+			break;
+
+		bucket++;
+	}
+
+	ret = msg->len;
+
+ out:
+	if (primary_if)
+		batadv_hardif_free_ref(primary_if);
+	if (soft_iface)
+		dev_put(soft_iface);
+
+	cb->args[0] = bucket;
+	cb->args[1] = idx;
+
+	return ret;
+}
+
 static void
 batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 			    struct batadv_tt_local_entry *tt_local_entry,
@@ -1654,6 +1806,186 @@ out:
 	return 0;
 }
 
+static int
+batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
+			       struct batadv_tt_common_entry *common,
+			       struct batadv_tt_orig_list_entry *orig,
+			       bool best)
+{
+	void *hdr;
+	struct batadv_orig_node_vlan *vlan;
+	u16 flags = common->flags;
+	u8 last_ttvn;
+	u32 crc;
+
+	vlan = batadv_orig_node_vlan_get(orig->orig_node,
+					 common->vid);
+	if (!vlan)
+		return 0;
+
+	crc = vlan->tt.crc;
+
+	batadv_orig_node_vlan_free_ref(vlan);
+
+	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family, NLM_F_MULTI,
+			  BATADV_CMD_GET_TRANSTABLE_GLOBAL);
+	if (!hdr)
+		return -ENOBUFS;
+
+	last_ttvn = atomic_read(&orig->orig_node->last_ttvn);
+
+	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->addr) ||
+	    nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN,
+		    orig->orig_node->orig) ||
+	    nla_put_u8(msg, BATADV_ATTR_TT_TTVN, orig->ttvn) ||
+	    nla_put_u8(msg, BATADV_ATTR_TT_LAST_TTVN, last_ttvn) ||
+	    nla_put_u32(msg, BATADV_ATTR_TT_CRC32, crc) ||
+	    nla_put_u16(msg, BATADV_ATTR_TT_VID, BATADV_PRINT_VID(common->vid)))
+		goto nla_put_failure;
+
+	if (best && nla_put_flag(msg, BATADV_ATTR_FLAG_BEST))
+		goto nla_put_failure;
+	if ((flags & BATADV_TT_CLIENT_ROAM) &&
+	    nla_put_flag(msg, BATADV_ATTR_FLAG_ROAM))
+		goto nla_put_failure;
+	if ((flags & BATADV_TT_CLIENT_WIFI) &&
+	    nla_put_flag(msg, BATADV_ATTR_FLAG_WIFI))
+		goto nla_put_failure;
+	if ((flags & BATADV_TT_CLIENT_ISOLA) &&
+	    nla_put_flag(msg, BATADV_ATTR_FLAG_ISOLA))
+		goto nla_put_failure;
+	if ((flags & BATADV_TT_CLIENT_TEMP) &&
+	    nla_put_flag(msg, BATADV_ATTR_FLAG_TEMP))
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
+batadv_tt_global_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+			    struct batadv_priv *bat_priv,
+			    struct batadv_tt_common_entry *common, int *sub_s)
+{
+	struct batadv_tt_orig_list_entry *orig_entry, *best_entry;
+	struct batadv_tt_global_entry *global;
+	struct hlist_head *head;
+	int sub = 0;
+	bool best;
+
+	global = container_of(common, struct batadv_tt_global_entry, common);
+	best_entry = batadv_transtable_best_orig(bat_priv, global);
+	head = &global->orig_list;
+
+	hlist_for_each_entry_rcu(orig_entry, head, list) {
+		if (sub++ < *sub_s)
+			continue;
+
+		best = (orig_entry == best_entry);
+
+		if (batadv_tt_global_dump_subentry(msg, portid, seq, common,
+						   orig_entry, best)) {
+			*sub_s = sub - 1;
+			return -EMSGSIZE;
+		}
+	}
+
+	*sub_s = 0;
+	return 0;
+}
+
+static int
+batadv_tt_global_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
+			     struct batadv_priv *bat_priv,
+			     struct hlist_head *head, int *idx_s, int *sub)
+{
+	struct batadv_tt_common_entry *common;
+	int idx = 0;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(common, head, hash_entry) {
+		if (idx++ < *idx_s)
+			continue;
+
+		if (batadv_tt_global_dump_entry(msg, portid, seq, bat_priv,
+						common, sub)) {
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
+int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct net *net = sock_net(cb->skb->sk);
+	struct net_device *soft_iface = NULL;
+	struct batadv_priv *bat_priv;
+	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_hashtable *hash;
+	struct hlist_head *head;
+	int ret;
+	int ifindex;
+	int bucket = cb->args[0];
+	int idx = cb->args[1];
+	int sub = cb->args[2];
+	int portid = NETLINK_CB(cb->skb).portid;
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
+	hash = bat_priv->tt.global_hash;
+
+	while (bucket < hash->size) {
+		head = &hash->table[bucket];
+
+		if (batadv_tt_global_dump_bucket(msg, portid,
+						 cb->nlh->nlmsg_seq, bat_priv,
+						 head, &idx, &sub))
+			break;
+
+		bucket++;
+	}
+
+	ret = msg->len;
+
+ out:
+	if (primary_if)
+		batadv_hardif_free_ref(primary_if);
+	if (soft_iface)
+		dev_put(soft_iface);
+
+	cb->args[0] = bucket;
+	cb->args[1] = idx;
+	cb->args[2] = sub;
+
+	return ret;
+}
+
 /**
  * _batadv_tt_global_del_orig_entry - remove and free an orig_entry
  * @tt_global_entry: the global entry to remove the orig_entry from
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index abd8e11..32b830c 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -33,6 +33,8 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv,
 			   const char *message, bool roaming);
 int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset);
+int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb);
+int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb);
 void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
 			       s32 match_vid, const char *message);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index da4c738..9ac0ddf 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -26,6 +26,7 @@
 #include <linux/compiler.h>
 #include <linux/if_ether.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/sched.h> /* for linux/wait.h */
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -1171,6 +1172,9 @@ struct batadv_algo_ops {
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
2.4.4

