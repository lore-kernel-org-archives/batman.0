Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat, 15 Feb 2014 17:47:49 +0100
Message-Id: <1392482874-9024-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1392482874-9024-1-git-send-email-linus.luessing@web.de>
References: <1392482874-9024-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv14 1/6] batman-adv: Multicast Listener
	Announcements via Translation Table
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

With this patch a node which has no bridge interface on top of its soft
interface announces its local multicast listeners via the translation
table.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 Makefile               |    2 +
 Makefile.kbuild        |    1 +
 compat.h               |   37 ++++++++
 gen-compat-autoconf.sh |    1 +
 main.c                 |    6 ++
 main.h                 |    1 +
 multicast.c            |  242 ++++++++++++++++++++++++++++++++++++++++++++++++
 multicast.h            |   38 ++++++++
 translation-table.c    |   22 ++++-
 types.h                |   24 +++++
 10 files changed, 370 insertions(+), 4 deletions(-)
 create mode 100644 multicast.c
 create mode 100644 multicast.h

diff --git a/Makefile b/Makefile
index 9a7cbae..4f6c30a 100644
--- a/Makefile
+++ b/Makefile
@@ -25,6 +25,8 @@ export CONFIG_BATMAN_ADV_BLA=y
 export CONFIG_BATMAN_ADV_DAT=y
 # B.A.T.M.A.N network coding (catwoman):
 export CONFIG_BATMAN_ADV_NC=n
+# B.A.T.M.A.N. multicast optimizations:
+export CONFIG_BATMAN_ADV_MCAST=y
 
 PWD:=$(shell pwd)
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
diff --git a/Makefile.kbuild b/Makefile.kbuild
index 42df18f..eb7d8c0 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -36,3 +36,4 @@ batman-adv-y += send.o
 batman-adv-y += soft-interface.o
 batman-adv-y += sysfs.o
 batman-adv-y += translation-table.o
+batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast.o
diff --git a/compat.h b/compat.h
index 12bc8d8..7a3d235 100644
--- a/compat.h
+++ b/compat.h
@@ -103,6 +103,24 @@ static inline struct sk_buff *netdev_alloc_skb_ip_align(struct net_device *dev,
 
 #define pr_warn pr_warning
 
+#undef  netdev_for_each_mc_addr
+#define netdev_for_each_mc_addr(mclist, dev) \
+	for (mclist = (struct batadv_dev_addr_list *)dev->mc_list; mclist; \
+	     mclist = (struct batadv_dev_addr_list *)mclist->next)
+
+/* Note, that this breaks the usage of the normal 'struct netdev_hw_addr'
+ * for kernels < 2.6.35 in batman-adv!
+ */
+#define netdev_hw_addr batadv_dev_addr_list
+struct batadv_dev_addr_list {
+	struct dev_addr_list *next;
+	u8  addr[MAX_ADDR_LEN];
+	u8  da_addrlen;
+	u8  da_synced;
+	int da_users;
+	int da_gusers;
+};
+
 #endif /* < KERNEL_VERSION(2, 6, 35) */
 
 
@@ -143,6 +161,14 @@ static inline int batadv_param_set_copystring(const char *val,
 #define addr_assign_type ifindex
 #define NET_ADDR_RANDOM 0
 
+#define netdev_master_upper_dev_get_rcu(dev) \
+	NULL; \
+	if (dev->br_port ? 1 : 0) { \
+		rcu_read_unlock(); \
+		dev_hold(dev); \
+		return dev; \
+	}
+
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 37)
@@ -343,6 +369,17 @@ static int __batadv_interface_tx(struct sk_buff *skb, \
 	pos && ({ n = pos->member.next; 1; }); \
 	pos = hlist_entry_safe(n, typeof(*pos), member))
 
+#ifndef netdev_master_upper_dev_get_rcu
+#define netdev_master_upper_dev_get_rcu(dev) \
+	NULL; \
+	if (dev->priv_flags & IFF_BRIDGE_PORT) { \
+		rcu_read_unlock(); \
+		dev_hold(dev); \
+		return dev; \
+	}
+
+#endif /* netdev_master_upper_dev_get_rcu */
+
 #endif /* < KERNEL_VERSION(3, 9, 0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0)
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 78573e4..f625b6f 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -39,6 +39,7 @@ gen_config() {
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_MCAST' ${CONFIG_BATMAN_ADV_MCAST:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_NC' ${CONFIG_BATMAN_ADV_NC:="n"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
diff --git a/main.c b/main.c
index fbeaebd..58e98c8 100644
--- a/main.c
+++ b/main.c
@@ -34,6 +34,7 @@
 #include "gateway_client.h"
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
+#include "multicast.h"
 #include "gateway_common.h"
 #include "hash.h"
 #include "bat_algo.h"
@@ -120,6 +121,9 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	INIT_LIST_HEAD(&bat_priv->tt.changes_list);
 	INIT_LIST_HEAD(&bat_priv->tt.req_list);
 	INIT_LIST_HEAD(&bat_priv->tt.roam_list);
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	INIT_HLIST_HEAD(&bat_priv->mcast.mla_list);
+#endif
 	INIT_HLIST_HEAD(&bat_priv->tvlv.container_list);
 	INIT_HLIST_HEAD(&bat_priv->tvlv.handler_list);
 	INIT_HLIST_HEAD(&bat_priv->softif_vlan_list);
@@ -169,6 +173,8 @@ void batadv_mesh_free(struct net_device *soft_iface)
 	batadv_dat_free(bat_priv);
 	batadv_bla_free(bat_priv);
 
+	batadv_mcast_free(bat_priv);
+
 	/* Free the TT and the originator tables only after having terminated
 	 * all the other depending components which may use these structures for
 	 * their purposes.
diff --git a/main.h b/main.h
index 34e85a2..dc6b4a2 100644
--- a/main.h
+++ b/main.h
@@ -176,6 +176,7 @@ enum batadv_uev_type {
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <net/sock.h>		/* struct sock */
+#include <net/addrconf.h>	/* ipv6 address stuff */
 #include <net/rtnetlink.h>
 #include <linux/jiffies.h>
 #include <linux/seq_file.h>
diff --git a/multicast.c b/multicast.c
new file mode 100644
index 0000000..66e270c
--- /dev/null
+++ b/multicast.c
@@ -0,0 +1,242 @@
+/* Copyright (C) 2014 B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ */
+
+#include "main.h"
+#include "multicast.h"
+#include "originator.h"
+#include "hard-interface.h"
+#include "translation-table.h"
+
+/**
+ * batadv_mcast_mla_softif_get - get softif multicast listeners
+ * @dev: the device to collect multicast addresses from
+ * @mcast_list: a list to put found addresses into
+ *
+ * Collect multicast addresses of the local multicast listeners
+ * on the given soft interface, dev, in the given mcast_list.
+ *
+ * Return -ENOMEM on memory allocation error or the number of
+ * items added to the mcast_list otherwise.
+ */
+static int batadv_mcast_mla_softif_get(struct net_device *dev,
+				       struct hlist_head *mcast_list)
+{
+	struct netdev_hw_addr *mc_list_entry;
+	struct batadv_hw_addr *new;
+	int ret = 0;
+
+	netif_addr_lock_bh(dev);
+	netdev_for_each_mc_addr(mc_list_entry, dev) {
+		new = kmalloc(sizeof(*new), GFP_ATOMIC);
+		if (!new) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		memcpy(&new->addr, &mc_list_entry->addr, ETH_ALEN);
+		hlist_add_head(&new->list, mcast_list);
+		ret++;
+	}
+	netif_addr_unlock_bh(dev);
+
+	return ret;
+}
+
+/**
+ * batadv_mcast_mla_is_duplicate - check whether an address is in a list
+ * @mcast_addr: the multicast address to check
+ * @mcast_list: the list with multicast addresses to search in
+ *
+ * Return true if the given address is already in the given list.
+ * Otherwise returns false.
+ */
+static bool batadv_mcast_mla_is_duplicate(uint8_t *mcast_addr,
+					  struct hlist_head *mcast_list)
+{
+	struct batadv_hw_addr *mcast_entry;
+
+	hlist_for_each_entry(mcast_entry, mcast_list, list)
+		if (batadv_compare_eth(mcast_entry->addr, mcast_addr))
+			return true;
+
+	return false;
+}
+
+/**
+ * batadv_mcast_mla_list_free - free a list of multicast addresses
+ * @mcast_list: the list to free
+ *
+ * Remove and free all items in the given mcast_list.
+ */
+static void batadv_mcast_mla_list_free(struct hlist_head *mcast_list)
+{
+	struct batadv_hw_addr *mcast_entry;
+	struct hlist_node *tmp;
+
+	hlist_for_each_entry_safe(mcast_entry, tmp, mcast_list, list) {
+		hlist_del(&mcast_entry->list);
+		kfree(mcast_entry);
+	}
+}
+
+/**
+ * batadv_mcast_mla_tt_retract - clean up multicast listener announcements
+ * @bat_priv: the bat priv with all the soft interface information
+ * @mcast_list: a list of addresses which should _not_ be removed
+ *
+ * Retract the announcement of any multicast listener from the
+ * translation table except the ones listed in the given mcast_list.
+ *
+ * If mcast_list is NULL then all are retracted.
+ */
+static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
+					struct hlist_head *mcast_list)
+{
+	struct batadv_hw_addr *mcast_entry;
+	struct hlist_node *tmp;
+
+	hlist_for_each_entry_safe(mcast_entry, tmp, &bat_priv->mcast.mla_list,
+				  list) {
+		if (mcast_list &&
+		    batadv_mcast_mla_is_duplicate(mcast_entry->addr,
+						  mcast_list))
+			continue;
+
+		batadv_tt_local_remove(bat_priv, mcast_entry->addr,
+				       BATADV_NO_FLAGS,
+				       "mcast TT outdated", false);
+
+		hlist_del(&mcast_entry->list);
+		kfree(mcast_entry);
+	}
+}
+
+/**
+ * batadv_mcast_mla_tt_add - add multicast listener announcements
+ * @bat_priv: the bat priv with all the soft interface information
+ * @mcast_list: a list of addresses which are going to get added
+ *
+ * Add multicast listener announcements from the given mcast_list to the
+ * translation table if they have not been added yet.
+ */
+static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
+				    struct hlist_head *mcast_list)
+{
+	struct batadv_hw_addr *mcast_entry;
+	struct hlist_node *tmp;
+
+	if (!mcast_list)
+		return;
+
+	hlist_for_each_entry_safe(mcast_entry, tmp, mcast_list, list) {
+		if (batadv_mcast_mla_is_duplicate(mcast_entry->addr,
+						  &bat_priv->mcast.mla_list))
+			continue;
+
+		if (!batadv_tt_local_add(bat_priv->soft_iface,
+					 mcast_entry->addr, BATADV_NO_FLAGS,
+					 BATADV_NULL_IFINDEX, BATADV_NO_MARK))
+			continue;
+
+		hlist_del(&mcast_entry->list);
+		hlist_add_head(&mcast_entry->list, &bat_priv->mcast.mla_list);
+	}
+}
+
+/**
+ * batadv_mcast_get_bridge - get the bridge interface on our soft interface
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return the next bridge interface on top of our soft interface and increase
+ * its refcount. If no such bridge interface exists, then return NULL.
+ */
+static struct net_device *
+batadv_mcast_get_bridge(struct batadv_priv *bat_priv)
+{
+	struct net_device *upper = bat_priv->soft_iface;
+
+	rcu_read_lock();
+
+	do {
+		upper = netdev_master_upper_dev_get_rcu(upper);
+	} while (upper && !(upper->priv_flags & IFF_EBRIDGE));
+
+	if (upper)
+		dev_hold(upper);
+
+	rcu_read_unlock();
+
+	return upper;
+}
+
+/**
+ * batadv_mcast_has_bridge - check whether the soft-iface is bridged
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Check whether there is a bridge on top of our soft interface. Return
+ * true if so, false otherwise.
+ */
+static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
+{
+	struct net_device *bridge;
+
+	bridge = batadv_mcast_get_bridge(bat_priv);
+	if (!bridge)
+		goto out;
+
+	dev_put(bridge);
+	return true;
+out:
+	return false;
+}
+
+/**
+ * batadv_mcast_mla_update - update the own MLAs
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Update the own multicast listener announcements in the translation
+ * table.
+ */
+void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
+{
+	struct net_device *soft_iface = bat_priv->soft_iface;
+	struct hlist_head mcast_list = HLIST_HEAD_INIT;
+	int ret;
+
+	/* Avoid attaching MLAs, if there is a bridge on top of our soft
+	 * interface, we don't support that yet (TODO)
+	 */
+	if (batadv_mcast_has_bridge(bat_priv))
+		goto update;
+
+	ret = batadv_mcast_mla_softif_get(soft_iface, &mcast_list);
+	if (ret < 0)
+		goto out;
+
+update:
+	batadv_mcast_mla_tt_retract(bat_priv, &mcast_list);
+	batadv_mcast_mla_tt_add(bat_priv, &mcast_list);
+
+out:
+	batadv_mcast_mla_list_free(&mcast_list);
+}
+
+/**
+ * batadv_mcast_free - free the multicast optimizations structures
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+void batadv_mcast_free(struct batadv_priv *bat_priv)
+{
+	batadv_mcast_mla_tt_retract(bat_priv, NULL);
+}
diff --git a/multicast.h b/multicast.h
new file mode 100644
index 0000000..111aad7
--- /dev/null
+++ b/multicast.h
@@ -0,0 +1,38 @@
+/* Copyright (C) 2014 B.A.T.M.A.N. contributors:
+ *
+ * Linus Lüssing
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef _NET_BATMAN_ADV_MULTICAST_H_
+#define _NET_BATMAN_ADV_MULTICAST_H_
+
+#ifdef CONFIG_BATMAN_ADV_MCAST
+
+void batadv_mcast_mla_update(struct batadv_priv *bat_priv);
+
+void batadv_mcast_free(struct batadv_priv *bat_priv);
+
+#else
+
+static inline void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
+{
+	return;
+}
+
+static inline void batadv_mcast_free(struct batadv_priv *bat_priv)
+{
+	return;
+}
+
+#endif /* CONFIG_BATMAN_ADV_MCAST */
+
+#endif /* _NET_BATMAN_ADV_MULTICAST_H_ */
diff --git a/translation-table.c b/translation-table.c
index 6d0da58..4082d05 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -24,6 +24,7 @@
 #include "originator.h"
 #include "routing.h"
 #include "bridge_loop_avoidance.h"
+#include "multicast.h"
 
 #include <linux/crc32c.h>
 
@@ -484,7 +485,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_tt_local_entry *tt_local;
-	struct batadv_tt_global_entry *tt_global;
+	struct batadv_tt_global_entry *tt_global = NULL;
 	struct net_device *in_dev = NULL;
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry;
@@ -497,7 +498,9 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		in_dev = dev_get_by_index(&init_net, ifindex);
 
 	tt_local = batadv_tt_local_hash_find(bat_priv, addr, vid);
-	tt_global = batadv_tt_global_hash_find(bat_priv, addr, vid);
+
+	if (!is_multicast_ether_addr(addr))
+		tt_global = batadv_tt_global_hash_find(bat_priv, addr, vid);
 
 	if (tt_local) {
 		tt_local->last_seen = jiffies;
@@ -562,8 +565,11 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	tt_local->last_seen = jiffies;
 	tt_local->common.added_at = tt_local->last_seen;
 
-	/* the batman interface mac address should never be purged */
-	if (batadv_compare_eth(addr, soft_iface->dev_addr))
+	/* the batman interface mac and multicast addresses should never be
+	 * purged
+	 */
+	if (batadv_compare_eth(addr, soft_iface->dev_addr) ||
+	    is_multicast_ether_addr(addr))
 		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
 
 	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
@@ -1361,6 +1367,11 @@ add_orig_entry:
 	ret = true;
 
 out_remove:
+	/* Do not remove multicast addresses from the local hash on
+	 * global additions
+	 */
+	if (is_multicast_ether_addr(tt_addr))
+		goto out;
 
 	/* remove address from local hash if present */
 	local_flags = batadv_tt_local_remove(bat_priv, tt_addr, vid,
@@ -3120,6 +3131,9 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
  */
 static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 {
+	/* Update multicast addresses in local translation table */
+	batadv_mcast_mla_update(bat_priv);
+
 	if (atomic_read(&bat_priv->tt.local_changes) < 1) {
 		if (!batadv_atomic_dec_not_zero(&bat_priv->tt.ogm_append_cnt))
 			batadv_tt_tvlv_container_update(bat_priv);
diff --git a/types.h b/types.h
index 9f52517..d553264 100644
--- a/types.h
+++ b/types.h
@@ -607,6 +607,16 @@ struct batadv_priv_dat {
 };
 #endif
 
+#ifdef CONFIG_BATMAN_ADV_MCAST
+/**
+ * struct batadv_priv_mcast - per mesh interface mcast data
+ * @mla_list: list of multicast addresses we are currently announcing via TT
+ */
+struct batadv_priv_mcast {
+	struct hlist_head mla_list;
+};
+#endif
+
 /**
  * struct batadv_priv_nc - per mesh interface network coding private data
  * @work: work queue callback item for cleanup
@@ -702,6 +712,7 @@ struct batadv_softif_vlan {
  * @tt: translation table data
  * @tvlv: type-version-length-value data
  * @dat: distributed arp table data
+ * @mcast: multicast data
  * @network_coding: bool indicating whether network coding is enabled
  * @batadv_priv_nc: network coding data
  */
@@ -759,6 +770,9 @@ struct batadv_priv {
 #ifdef CONFIG_BATMAN_ADV_DAT
 	struct batadv_priv_dat dat;
 #endif
+#ifdef CONFIG_BATMAN_ADV_MCAST
+	struct batadv_priv_mcast mcast;
+#endif
 #ifdef CONFIG_BATMAN_ADV_NC
 	atomic_t network_coding;
 	struct batadv_priv_nc nc;
@@ -1116,6 +1130,16 @@ struct batadv_dat_entry {
 };
 
 /**
+ * struct batadv_hw_addr - a list entry for a MAC address
+ * @list: list node for the linking of entries
+ * @addr: the MAC address of this list entry
+ */
+struct batadv_hw_addr {
+	struct hlist_node list;
+	unsigned char addr[ETH_ALEN];
+};
+
+/**
  * struct batadv_dat_candidate - candidate destination for DAT operations
  * @type: the type of the selected candidate. It can one of the following:
  *	  - BATADV_DAT_CANDIDATE_NOT_FOUND
-- 
1.7.10.4

