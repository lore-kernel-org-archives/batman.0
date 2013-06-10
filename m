Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 10 Jun 2013 08:28:19 +0200
Message-Id: <1370845701-18481-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1370845701-18481-1-git-send-email-linus.luessing@web.de>
References: <1370845701-18481-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Multicast Listener
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
 compat.h               |   20 ++++-
 gen-compat-autoconf.sh |    1 +
 main.c                 |    6 ++
 main.h                 |    1 +
 multicast.c            |  209 ++++++++++++++++++++++++++++++++++++++++++++++++
 multicast.h            |   43 ++++++++++
 soft-interface.c       |    3 +
 sysfs.c                |    6 ++
 translation-table.c    |   22 ++++-
 types.h                |   12 +++
 12 files changed, 321 insertions(+), 5 deletions(-)
 create mode 100644 multicast.c
 create mode 100644 multicast.h

diff --git a/Makefile b/Makefile
index 407cdc4..d7c6fa6 100644
--- a/Makefile
+++ b/Makefile
@@ -27,6 +27,8 @@ export CONFIG_BATMAN_ADV_BLA=y
 export CONFIG_BATMAN_ADV_DAT=y
 # B.A.T.M.A.N network coding (catwoman):
 export CONFIG_BATMAN_ADV_NC=n
+# B.A.T.M.A.N. multicast optimizations:
+export CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS=y
 
 PWD:=$(shell pwd)
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
diff --git a/Makefile.kbuild b/Makefile.kbuild
index 4f4aabb..f154c5b 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -38,3 +38,4 @@ batman-adv-y += send.o
 batman-adv-y += soft-interface.o
 batman-adv-y += sysfs.o
 batman-adv-y += translation-table.o
+batman-adv-$(CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS) += multicast.o
diff --git a/compat.h b/compat.h
index dbf1926..ddc1b29 100644
--- a/compat.h
+++ b/compat.h
@@ -103,13 +103,31 @@ static inline struct sk_buff *netdev_alloc_skb_ip_align(struct net_device *dev,
 
 #define pr_warn pr_warning
 
+#undef  netdev_for_each_mc_addr
+#define netdev_for_each_mc_addr(mclist, dev) \
+	for (mclist = (struct bat_dev_addr_list *)dev->mc_list; mclist; \
+	     mclist = (struct bat_dev_addr_list *)mclist->next)
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
 
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
 
 #define __rcu
-#define IFF_BRIDGE_PORT  0 || (hard_iface->net_dev->br_port ? 1 : 0)
+#define IFF_BRIDGE_PORT  0 || (soft_iface->br_port ? 1 : 0)
 
 struct kernel_param_ops {
 	/* Returns 0, or -errno.  arg is in kp->arg. */
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 78573e4..b56ac29 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -39,6 +39,7 @@ gen_config() {
 gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_BLA' ${CONFIG_BATMAN_ADV_BLA:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_DAT' ${CONFIG_BATMAN_ADV_DAT:="y"} >> "${TMP}"
+gen_config 'CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS' ${CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS:="y"} >> "${TMP}"
 gen_config 'CONFIG_BATMAN_ADV_NC' ${CONFIG_BATMAN_ADV_NC:="n"} >> "${TMP}"
 
 # only regenerate compat-autoconf.h when config was changed
diff --git a/main.c b/main.c
index 5d30fe0..fc5789c 100644
--- a/main.c
+++ b/main.c
@@ -32,6 +32,7 @@
 #include "gateway_client.h"
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
+#include "multicast.h"
 #include "gateway_common.h"
 #include "hash.h"
 #include "bat_algo.h"
@@ -115,6 +116,9 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	INIT_LIST_HEAD(&bat_priv->tt.changes_list);
 	INIT_LIST_HEAD(&bat_priv->tt.req_list);
 	INIT_LIST_HEAD(&bat_priv->tt.roam_list);
+#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
+	INIT_LIST_HEAD(&bat_priv->mcast.mla_list);
+#endif
 	INIT_HLIST_HEAD(&bat_priv->tvlv.container_list);
 	INIT_HLIST_HEAD(&bat_priv->tvlv.handler_list);
 
@@ -168,6 +172,8 @@ void batadv_mesh_free(struct net_device *soft_iface)
 	batadv_dat_free(bat_priv);
 	batadv_bla_free(bat_priv);
 
+	batadv_mcast_free(bat_priv);
+
 	/* Free the TT and the originator tables only after having terminated
 	 * all the other depending components which may use these structures for
 	 * their purposes.
diff --git a/main.h b/main.h
index 1f0b135..87db514 100644
--- a/main.h
+++ b/main.h
@@ -164,6 +164,7 @@ enum batadv_uev_type {
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <net/sock.h>		/* struct sock */
+#include <net/addrconf.h>	/* ipv6 address stuff */
 #include <net/rtnetlink.h>
 #include <linux/jiffies.h>
 #include <linux/seq_file.h>
diff --git a/multicast.c b/multicast.c
new file mode 100644
index 0000000..d6d8b62
--- /dev/null
+++ b/multicast.c
@@ -0,0 +1,209 @@
+/* Copyright (C) 2013 B.A.T.M.A.N. contributors:
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ */
+
+#include "main.h"
+#include "originator.h"
+#include "hard-interface.h"
+#include "translation-table.h"
+
+struct batadv_hw_addr {
+	struct list_head	list;
+	unsigned char addr[ETH_ALEN];
+};
+
+/**
+ * batadv_mcast_mla_local_collect - collect local multicast listeners
+ * @dev: the device to collect multicast addresses from
+ * @mcast_list: a list to put found addresses into
+ *
+ * Collect multicast addresses of the local multicast listeners
+ * on the given interface, dev, in the given mcast_list.
+ *
+ * Return -ENOMEM on memory allocation error or the number of
+ * items added to the mcast_list otherwise.
+ */
+static int batadv_mcast_mla_local_collect(struct net_device *dev,
+					  struct list_head *mcast_list)
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
+		list_add(&new->list, mcast_list);
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
+					  struct list_head *mcast_list)
+{
+	struct batadv_hw_addr *mcast_entry;
+
+	list_for_each_entry(mcast_entry, mcast_list, list)
+		if (batadv_compare_eth(mcast_entry->addr, mcast_addr))
+			return true;
+
+	return false;
+}
+
+/**
+ * batadv_mcast_mla_collect_free - free a list of multicast addresses
+ * @mcast_list: the list to free
+ *
+ * Remove and free all items in the given mcast_list.
+ */
+void batadv_mcast_mla_collect_free(struct list_head *mcast_list)
+{
+	struct batadv_hw_addr *mcast_entry, *tmp;
+
+	list_for_each_entry_safe(mcast_entry, tmp, mcast_list, list) {
+		list_del(&mcast_entry->list);
+		kfree(mcast_entry);
+	}
+}
+
+/**
+ * batadv_mcast_mla_tt_clean - clean up multicast listener announcements
+ * @bat_priv: the bat priv with all the soft interface information
+ * @mcast_list: a list of addresses which should _not_ be removed
+ *
+ * Retract the announcement of any multicast listener from the
+ * translation table except the ones listed in the given mcast_list.
+ *
+ * If mcast_list is NULL then all are retracted.
+ */
+static void batadv_mcast_mla_tt_clean(struct batadv_priv *bat_priv,
+				      struct list_head *mcast_list)
+{
+	struct batadv_hw_addr *mcast_entry, *tmp;
+
+	list_for_each_entry_safe(mcast_entry, tmp, &bat_priv->mcast.mla_list,
+				 list) {
+		if (mcast_list &&
+		    batadv_mcast_mla_is_duplicate(mcast_entry->addr,
+						  mcast_list))
+			continue;
+
+		batadv_tt_local_remove(bat_priv, mcast_entry->addr,
+				       "mcast TT outdated", false);
+
+		list_del(&mcast_entry->list);
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
+				    struct list_head *mcast_list)
+{
+	struct batadv_hw_addr *mcast_entry, *tmp;
+
+	if (!mcast_list)
+		return;
+
+	list_for_each_entry_safe(mcast_entry, tmp, mcast_list, list) {
+		if (batadv_mcast_mla_is_duplicate(mcast_entry->addr,
+						  &bat_priv->mcast.mla_list))
+			continue;
+
+		batadv_tt_local_add(bat_priv->soft_iface, mcast_entry->addr,
+				    BATADV_NULL_IFINDEX);
+		list_move_tail(&mcast_entry->list, &bat_priv->mcast.mla_list);
+	}
+}
+
+/**
+ * batadv_mcast_mla_tt_update - update the own MLAs
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Update the own multicast listener announcements in the translation
+ * table. Also take care of registering or unregistering the multicast
+ * tvlv depending on whether the user activated or deactivated
+ * multicast optimizations.
+ */
+void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
+{
+	struct net_device *soft_iface = bat_priv->soft_iface;
+	struct list_head mcast_list;
+	int ret;
+	static bool enabled;
+
+	INIT_LIST_HEAD(&mcast_list);
+
+	/* Avoid attaching MLAs, if multicast optimization is disabled
+	 * or there is a bridge on top of our soft interface (TODO)
+	 */
+	if (!atomic_read(&bat_priv->mcast_group_awareness) ||
+	    bat_priv->soft_iface->priv_flags & IFF_BRIDGE_PORT) {
+		if (enabled)
+			enabled = false;
+
+		goto update;
+	}
+
+	if (!enabled)
+		enabled = true;
+
+	ret = batadv_mcast_mla_local_collect(soft_iface, &mcast_list);
+	if (ret < 0)
+		goto out;
+
+update:
+	batadv_mcast_mla_tt_clean(bat_priv, &mcast_list);
+	batadv_mcast_mla_tt_add(bat_priv, &mcast_list);
+
+out:
+	batadv_mcast_mla_collect_free(&mcast_list);
+}
+
+/**
+ * batadv_mcast_free - free the multicast optimizations structures
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+void batadv_mcast_free(struct batadv_priv *bat_priv)
+{
+	batadv_mcast_mla_tt_clean(bat_priv, NULL);
+}
diff --git a/multicast.h b/multicast.h
new file mode 100644
index 0000000..3b68e3b
--- /dev/null
+++ b/multicast.h
@@ -0,0 +1,43 @@
+/* Copyright (C) 2013 B.A.T.M.A.N. contributors:
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ */
+
+#ifndef _NET_BATMAN_ADV_MULTICAST_H_
+#define _NET_BATMAN_ADV_MULTICAST_H_
+
+#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
+
+void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv);
+
+void batadv_mcast_free(struct batadv_priv *bat_priv);
+
+#else
+
+static inline void batadv_mcast_mla_tt_update(struct batadv_priv *bat_priv)
+{
+	return;
+}
+
+static inline void batadv_mcast_free(struct batadv_priv *bat_priv)
+{
+	return;
+}
+
+#endif /* CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS */
+
+#endif /* _NET_BATMAN_ADV_MULTICAST_H_ */
diff --git a/soft-interface.c b/soft-interface.c
index d4fdc61..52244b0 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -456,6 +456,9 @@ static int batadv_softif_init_late(struct net_device *dev)
 #ifdef CONFIG_BATMAN_ADV_DAT
 	atomic_set(&bat_priv->distributed_arp_table, 1);
 #endif
+#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
+	atomic_set(&bat_priv->mcast_group_awareness, 1);
+#endif
 	atomic_set(&bat_priv->ap_isolation, 0);
 	atomic_set(&bat_priv->gw_mode, BATADV_GW_MODE_OFF);
 	atomic_set(&bat_priv->gw_sel_class, 20);
diff --git a/sysfs.c b/sysfs.c
index b70ae52..cc4e7e5 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -369,6 +369,9 @@ BATADV_ATTR_SIF_UINT(gw_sel_class, S_IRUGO | S_IWUSR, 1, BATADV_TQ_MAX_VALUE,
 		     batadv_post_gw_deselect);
 static BATADV_ATTR(gw_bandwidth, S_IRUGO | S_IWUSR, batadv_show_gw_bwidth,
 		   batadv_store_gw_bwidth);
+#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
+BATADV_ATTR_SIF_BOOL(mcast_group_awareness, S_IRUGO | S_IWUSR, NULL);
+#endif
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 BATADV_ATTR_SIF_UINT(log_level, S_IRUGO | S_IWUSR, 0, BATADV_DBG_ALL, NULL);
 #endif
@@ -386,6 +389,9 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 #ifdef CONFIG_BATMAN_ADV_DAT
 	&batadv_attr_distributed_arp_table,
 #endif
+#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
+	&batadv_attr_mcast_group_awareness,
+#endif
 	&batadv_attr_fragmentation,
 	&batadv_attr_ap_isolation,
 	&batadv_attr_routing_algo,
diff --git a/translation-table.c b/translation-table.c
index 7580ee5..0be7b15 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -26,6 +26,7 @@
 #include "originator.h"
 #include "routing.h"
 #include "bridge_loop_avoidance.h"
+#include "multicast.h"
 
 #include <linux/crc32c.h>
 
@@ -277,14 +278,16 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_tt_local_entry *tt_local;
-	struct batadv_tt_global_entry *tt_global;
+	struct batadv_tt_global_entry *tt_global = NULL;
 	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry;
 	int hash_added;
 	bool roamed_back = false;
 
 	tt_local = batadv_tt_local_hash_find(bat_priv, addr);
-	tt_global = batadv_tt_global_hash_find(bat_priv, addr);
+
+	if (!is_multicast_ether_addr(addr))
+		tt_global = batadv_tt_global_hash_find(bat_priv, addr);
 
 	if (tt_local) {
 		tt_local->last_seen = jiffies;
@@ -335,8 +338,11 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
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
@@ -922,6 +928,11 @@ add_orig_entry:
 	ret = true;
 
 out_remove:
+	/* Do not remove multicast addresses from the local hash on
+	 * global additions
+	 */
+	if (is_multicast_ether_addr(tt_addr))
+		goto out;
 
 	/* remove address from local hash if present */
 	local_flags = batadv_tt_local_remove(bat_priv, tt_addr,
@@ -2348,6 +2359,9 @@ void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv)
 {
 	uint16_t changed_num = 0;
 
+	/* Update multicast addresses in local translation table */
+	batadv_mcast_mla_tt_update(bat_priv);
+
 	if (atomic_read(&bat_priv->tt.local_changes) < 1) {
 		if (!batadv_atomic_dec_not_zero(&bat_priv->tt.ogm_append_cnt))
 			batadv_tt_tvlv_container_update(bat_priv);
diff --git a/types.h b/types.h
index 304f3d0..8175424 100644
--- a/types.h
+++ b/types.h
@@ -501,6 +501,12 @@ struct batadv_priv_dat {
 };
 #endif
 
+#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
+struct batadv_priv_mcast {
+	struct list_head mla_list;
+};
+#endif
+
 /**
  * struct batadv_priv_nc - per mesh interface network coding private data
  * @work: work queue callback item for cleanup
@@ -591,6 +597,9 @@ struct batadv_priv {
 #ifdef CONFIG_BATMAN_ADV_DAT
 	atomic_t distributed_arp_table;
 #endif
+#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
+	atomic_t mcast_group_awareness;
+#endif
 	atomic_t gw_mode;
 	atomic_t gw_sel_class;
 	atomic_t orig_interval;
@@ -625,6 +634,9 @@ struct batadv_priv {
 #ifdef CONFIG_BATMAN_ADV_DAT
 	struct batadv_priv_dat dat;
 #endif
+#ifdef CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS
+	struct batadv_priv_mcast mcast;
+#endif
 #ifdef CONFIG_BATMAN_ADV_NC
 	atomic_t network_coding;
 	struct batadv_priv_nc nc;
-- 
1.7.10.4

