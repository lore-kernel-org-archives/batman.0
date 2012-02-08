Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Wed,  8 Feb 2012 20:05:58 +0100
Message-Id: <1328727958-16119-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: Add filtering of OGM messages
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

For testing purposes, forcing specific paths in a network where all
nodes are within reach, can be useful. This patch allows the use to
enter addresses from which direct OGMs should be ignored.

An address is added by echoing it into
/sys/class/net/bat0/filter_add_addr and removed again by echoing the
same address into /sys/class/net/bat0/filter_del_addr. The list of
currently blocked direct OGM sources is available in
/sys/kernel/debug/batman-adv/bat0/filter_table.

The filtering is performed by checking the value of member
"orig_node->filter", where the orig_node struct is found using the
Ethernet source of the OGM message in question. If "orig_node->filter is
true (1), the OGM is simply dropped.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 Makefile               |    2 +
 Makefile.kbuild        |    1 +
 bat_debugfs.c          |   15 ++++++
 bat_sysfs.c            |   43 ++++++++++++++++++
 filter.c               |  116 ++++++++++++++++++++++++++++++++++++++++++++++++
 filter.h               |   53 ++++++++++++++++++++++
 gen-compat-autoconf.sh |    1 +
 originator.c           |    2 +
 routing.c              |    5 ++
 types.h                |    1 +
 10 files changed, 239 insertions(+), 0 deletions(-)
 create mode 100644 filter.c
 create mode 100644 filter.h

diff --git a/Makefile b/Makefile
index 08f8c39..42895f6 100644
--- a/Makefile
+++ b/Makefile
@@ -23,6 +23,8 @@
 export CONFIG_BATMAN_ADV_DEBUG=n
 # B.A.T.M.A.N. bridge loop avoidance:
 export CONFIG_BATMAN_ADV_BLA=y
+# B.A.T.M.A.N. OGM packet filtering:
+export CONFIG_BATMAN_ADV_FILTER=y
 
 PWD:=$(shell pwd)
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
diff --git a/Makefile.kbuild b/Makefile.kbuild
index 6d5c194..8bf515c 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -24,6 +24,7 @@ batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bat_sysfs.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
+batman-adv-$(CONFIG_BATMAN_ADV_FILTER) += filter.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
diff --git a/bat_debugfs.c b/bat_debugfs.c
index 916380c..3f8ef4f 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -33,6 +33,7 @@
 #include "vis.h"
 #include "icmp_socket.h"
 #include "bridge_loop_avoidance.h"
+#include "filter.h"
 
 static struct dentry *bat_debugfs;
 
@@ -253,6 +254,14 @@ static int bla_claim_table_open(struct inode *inode, struct file *file)
 }
 #endif
 
+#ifdef CONFIG_BATMAN_ADV_FILTER
+static int filter_show_table_open(struct inode *inode, struct file *file)
+{
+	struct net_device *net_dev = (struct net_device *)inode->i_private;
+	return single_open(file, filter_show_table_seq_print_text, net_dev);
+}
+#endif
+
 static int transtable_local_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
@@ -289,6 +298,9 @@ static BAT_DEBUGINFO(transtable_global, S_IRUGO, transtable_global_open);
 #ifdef CONFIG_BATMAN_ADV_BLA
 static BAT_DEBUGINFO(bla_claim_table, S_IRUGO, bla_claim_table_open);
 #endif
+#ifdef CONFIG_BATMAN_ADV_FILTER
+static BAT_DEBUGINFO(filter_table, S_IRUGO, filter_show_table_open);
+#endif
 static BAT_DEBUGINFO(transtable_local, S_IRUGO, transtable_local_open);
 static BAT_DEBUGINFO(vis_data, S_IRUGO, vis_data_open);
 
@@ -299,6 +311,9 @@ static struct bat_debuginfo *mesh_debuginfos[] = {
 #ifdef CONFIG_BATMAN_ADV_BLA
 	&bat_debuginfo_bla_claim_table,
 #endif
+#ifdef CONFIG_BATMAN_ADV_FILTER
+	&bat_debuginfo_filter_table,
+#endif
 	&bat_debuginfo_transtable_local,
 	&bat_debuginfo_vis_data,
 	NULL,
diff --git a/bat_sysfs.c b/bat_sysfs.c
index 3adb183..0fc5e3e 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -27,6 +27,7 @@
 #include "gateway_common.h"
 #include "gateway_client.h"
 #include "vis.h"
+#include "filter.h"
 
 static struct net_device *kobj_to_netdev(struct kobject *obj)
 {
@@ -384,11 +385,49 @@ static ssize_t store_gw_bwidth(struct kobject *kobj, struct attribute *attr,
 	return gw_bandwidth_set(net_dev, buff, count);
 }
 
+static ssize_t add_filter_addr(struct kobject *kobj, struct attribute *attr,
+			     char *buff, size_t count)
+{
+	struct net_device *net_dev = kobj_to_netdev(kobj);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	char mac[ETH_ALEN];
+	int res;
+
+	if ((res = filter_parse_addr_str(buff, count, mac)) < 0) {
+		bat_info(net_dev, "Address has invalid format: %s\n", buff);
+		return res;
+	}
+
+	filter_addr_add(bat_priv, mac);
+
+	return count;
+}
+
+static ssize_t del_filter_addr(struct kobject *kobj, struct attribute *attr,
+			       char *buff, size_t count)
+{
+	struct net_device *net_dev = kobj_to_netdev(kobj);
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	char mac[ETH_ALEN];
+	int res;
+
+	if ((res = filter_parse_addr_str(buff, count, mac)) < 0)
+		return res;
+
+	filter_addr_del(bat_priv, mac);
+
+	return count;
+}
+
 BAT_ATTR_BOOL(aggregated_ogms, S_IRUGO | S_IWUSR, NULL);
 BAT_ATTR_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 #ifdef CONFIG_BATMAN_ADV_BLA
 BAT_ATTR_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR, NULL);
 #endif
+#ifdef CONFIG_BATMAN_ADV_FILTER
+static BAT_ATTR(filter_add_addr, S_IRUGO | S_IWUSR, NULL, add_filter_addr);
+static BAT_ATTR(filter_del_addr, S_IRUGO | S_IWUSR, NULL, del_filter_addr);
+#endif
 BAT_ATTR_BOOL(fragmentation, S_IRUGO | S_IWUSR, update_min_mtu);
 BAT_ATTR_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 static BAT_ATTR(vis_mode, S_IRUGO | S_IWUSR, show_vis_mode, store_vis_mode);
@@ -410,6 +449,10 @@ static struct bat_attribute *mesh_attrs[] = {
 #ifdef CONFIG_BATMAN_ADV_BLA
 	&bat_attr_bridge_loop_avoidance,
 #endif
+#ifdef CONFIG_BATMAN_ADV_FILTER
+	&bat_attr_filter_add_addr,
+	&bat_attr_filter_del_addr,
+#endif
 	&bat_attr_fragmentation,
 	&bat_attr_ap_isolation,
 	&bat_attr_vis_mode,
diff --git a/filter.c b/filter.c
new file mode 100644
index 0000000..844e10e
--- /dev/null
+++ b/filter.c
@@ -0,0 +1,116 @@
+/*
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+ *
+ * Martin Hundebøll <martin@hundeboll.net>
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#include "main.h"
+#include "filter.h"
+#include "originator.h"
+
+bool filter_addr_drop(struct bat_priv *bat_priv, const uint8_t *addr)
+{
+	struct orig_node *orig_node = orig_hash_find(bat_priv, addr);
+
+	if (!orig_node)
+		return false;
+
+	if (atomic_read(&orig_node->filter))
+		return true;
+
+	orig_node_free_ref(orig_node);
+	return false;
+}
+
+void filter_addr_add(struct bat_priv *bat_priv, const uint8_t *addr)
+{
+	struct orig_node *orig_node = orig_hash_find(bat_priv, addr);
+
+	if (!orig_node)
+		return;
+
+	atomic_set(&orig_node->filter, FILTER_TRUE);
+	orig_node_free_ref(orig_node);
+}
+
+void filter_addr_del(struct bat_priv *bat_priv, const uint8_t *addr)
+{
+	struct orig_node *orig_node = orig_hash_find(bat_priv, addr);
+
+	if (!orig_node)
+		return;
+
+	atomic_set(&orig_node->filter, FILTER_FALSE);
+	orig_node_free_ref(orig_node);
+}
+
+int filter_parse_addr_str(char *buff, size_t count, char *addr)
+{
+	int i;
+
+	if (buff[count - 1] == '\n')
+		buff[count - 1] = '\0';
+
+	/* Validate if string has correct length */
+	if (count - 1 != PRETTY_MAC_ADDR_LEN)
+		return -EINVAL;
+
+	/* Validate if string has valid format */
+	for (i = 1; i <= ETH_ALEN - 1; i++)
+		if (buff[i*3-1] != ':')
+			return -EINVAL;
+
+	/* Convert string to bytes */
+	for (i = 0; i < ETH_ALEN; i++) {
+		unsigned long l;
+
+		l = simple_strtoul(&buff[i*3], (char **)NULL, 16);
+		addr[i] = (char)l;
+	}
+
+	return count;
+}
+
+int filter_show_table_seq_print_text(struct seq_file *seq, void *offset)
+{
+	struct net_device *net_dev = (struct net_device *)seq->private;
+	struct bat_priv *bat_priv = netdev_priv(net_dev);
+	struct hashtable_t *hash = bat_priv->orig_hash;
+
+	struct hlist_node *node;
+	struct hlist_head *head;
+	struct orig_node *orig_node;
+	int i;
+
+	if (!hash)
+		return 0;
+
+	/* Traverse list of originators */
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		/* For each orig_node in this bin */
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(orig_node, node, head, hash_entry)
+			if (atomic_read(&orig_node->filter))
+				seq_printf(seq, "%pM\n", orig_node->orig);
+		rcu_read_unlock();
+	}
+
+	return 0;
+}
diff --git a/filter.h b/filter.h
new file mode 100644
index 0000000..3b6cdf3
--- /dev/null
+++ b/filter.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+ *
+ * Martin Hundebøll <martin@hundeboll.net>
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#ifndef _NET_BATMAN_ADV_NETWORK_FILTER_H
+#define _NET_BATMAN_ADV_NETWORK_FILTER_H
+
+#define FILTER_TRUE	1
+#define FILTER_FALSE	0
+
+#define PRETTY_MAC_ADDR_LEN 17
+
+#ifdef CONFIG_BATMAN_ADV_FILTER
+
+int filter_parse_addr_str(char *buff, size_t count, char *addr);
+int filter_show_table_seq_print_text(struct seq_file *seq, void *offset);
+void filter_addr_add(struct bat_priv *bat_priv, const uint8_t *addr);
+void filter_addr_del(struct bat_priv *bat_priv, const uint8_t *addr);
+bool filter_addr_drop(struct bat_priv *bat_priv, const uint8_t *addr);
+
+#else /* ifdef CONFIG_BATMAN_ADV_FILTER */
+
+#define filter_show_table_seq_print_text(...) (0)
+#define filter_parse_addr_str(...) (0)
+#define filter_addr_add(...) {}
+#define filter_addr_del(...) {}
+
+static inline bool filter_addr_drop(struct bat_priv *bat_priv,
+				    const uint8_t *addr)
+{
+	return false
+}
+
+#endif /* ifdef CONFIG_BATMAN_ADV_FILTER */
+
+#endif /* _NET_BATMAN_ADV_NETWORK_FILTER_H */
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 7cf621b..f2e7eae 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -38,6 +38,7 @@ gen_config() {
 # write config variables
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_FILTER' ${CONFIG_BATMAN_ADV_FILTER:="y"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
 diff "${TMP}" "${TARGET}" > /dev/null 2>&1 || cp "${TMP}" "${TARGET}"
diff --git a/originator.c b/originator.c
index 2db4b53..a949856 100644
--- a/originator.c
+++ b/originator.c
@@ -29,6 +29,7 @@
 #include "unicast.h"
 #include "soft-interface.h"
 #include "bridge_loop_avoidance.h"
+#include "filter.h"
 
 static void purge_orig(struct work_struct *work);
 
@@ -236,6 +237,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, const uint8_t *addr)
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
 
 	atomic_set(&orig_node->bond_candidates, 0);
+	atomic_set(&orig_node->filter, FILTER_FALSE);
 
 	size = bat_priv->num_ifaces * sizeof(unsigned long) * NUM_WORDS;
 
diff --git a/routing.c b/routing.c
index 7b7fcbe..81c57b7 100644
--- a/routing.c
+++ b/routing.c
@@ -30,6 +30,7 @@
 #include "vis.h"
 #include "unicast.h"
 #include "bridge_loop_avoidance.h"
+#include "filter.h"
 
 static int route_unicast_packet(struct sk_buff *skb,
 				struct hard_iface *recv_if);
@@ -259,6 +260,10 @@ int recv_bat_ogm_packet(struct sk_buff *skb, struct hard_iface *hard_iface)
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
+	/* Packet is filtered by user */
+	if (filter_addr_drop(bat_priv, ethhdr->h_source))
+		return NET_RX_DROP;
+
 	/* packet with broadcast indication but unicast recipient */
 	if (!is_broadcast_ether_addr(ethhdr->h_dest))
 		return NET_RX_DROP;
diff --git a/types.h b/types.h
index 7f7f610..29e632d 100644
--- a/types.h
+++ b/types.h
@@ -108,6 +108,7 @@ struct orig_node {
 	spinlock_t tt_list_lock; /* protects tt_list */
 	atomic_t bond_candidates;
 	struct list_head bond_list;
+	atomic_t filter; /* Boolean */
 };
 
 struct gw_node {
-- 
1.7.9

