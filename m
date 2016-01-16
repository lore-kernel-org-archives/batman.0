Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 16:40:10 +0800
Message-Id: <1452933619-6712-3-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <8047297.0qIFjkW2bL@voltaire>
References: <8047297.0qIFjkW2bL@voltaire>
Subject: [B.A.T.M.A.N.] [PATCH v2 03/12] batman-adv: ELP - creating neighbor
	structures
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@open-mesh.com>

From: Linus Luessing <linus.luessing@web.de>

Initially developed by Linus during a 6 months trainee study
period in Ascom (Switzerland) AG.

Signed-off-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 compat-include/linux/average.h |  74 ++++++++++++++++++++
 net/batman-adv/bat_v.c         |  23 ++++++-
 net/batman-adv/bat_v_elp.c     | 152 +++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/bat_v_elp.h     |   4 ++
 net/batman-adv/main.h          |   3 +
 net/batman-adv/types.h         |  33 +++++++++
 6 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 compat-include/linux/average.h

diff --git a/compat-include/linux/average.h b/compat-include/linux/average.h
new file mode 100644
index 0000000..e5a2bf5
--- /dev/null
+++ b/compat-include/linux/average.h
@@ -0,0 +1,74 @@
+/* Copyright (C) 2007-2016 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
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
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_AVERAGE_H
+#define _NET_BATMAN_ADV_COMPAT_LINUX_AVERAGE_H
+
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 38)
+#include_next <linux/average.h>
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 3, 0)
+
+/* Exponentially weighted moving average (EWMA) */
+
+#define DECLARE_EWMA(name, _factor, _weight)				\
+	struct ewma_##name {						\
+		unsigned long internal;					\
+	};								\
+	static inline void ewma_##name##_init(struct ewma_##name *e)	\
+	{								\
+		BUILD_BUG_ON(!__builtin_constant_p(_factor));		\
+		BUILD_BUG_ON(!__builtin_constant_p(_weight));		\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_factor);			\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_weight);			\
+		e->internal = 0;					\
+	}								\
+	static inline unsigned long					\
+	ewma_##name##_read(struct ewma_##name *e)			\
+	{								\
+		BUILD_BUG_ON(!__builtin_constant_p(_factor));		\
+		BUILD_BUG_ON(!__builtin_constant_p(_weight));		\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_factor);			\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_weight);			\
+		return e->internal >> ilog2(_factor);			\
+	}								\
+	static inline void ewma_##name##_add(struct ewma_##name *e,	\
+					     unsigned long val)		\
+	{								\
+		unsigned long internal = ACCESS_ONCE(e->internal);	\
+		unsigned long weight = ilog2(_weight);			\
+		unsigned long factor = ilog2(_factor);			\
+									\
+		BUILD_BUG_ON(!__builtin_constant_p(_factor));		\
+		BUILD_BUG_ON(!__builtin_constant_p(_weight));		\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_factor);			\
+		BUILD_BUG_ON_NOT_POWER_OF_2(_weight);			\
+									\
+		ACCESS_ONCE(e->internal) = internal ?			\
+			(((internal << weight) - internal) +		\
+				(val << factor)) >> weight :		\
+			(val << factor);				\
+	}
+
+#endif /* < KERNEL_VERSION(4, 3, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_AVERAGE_H */
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 01327f6..0fea894 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 
 #include "bat_v_elp.h"
+#include "packet.h"
 
 static int batadv_v_iface_enable(struct batadv_hard_iface *hard_iface)
 {
@@ -42,6 +43,12 @@ static void batadv_v_primary_iface_set(struct batadv_hard_iface *hard_iface)
 	batadv_v_elp_primary_iface_set(hard_iface);
 }
 
+static void
+batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
+{
+	ewma_throughput_init(&hardif_neigh->bat_v.throughput);
+}
+
 static void batadv_v_ogm_schedule(struct batadv_hard_iface *hard_iface)
 {
 }
@@ -56,6 +63,7 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
 	.bat_iface_disable = batadv_v_iface_disable,
 	.bat_iface_update_mac = batadv_v_iface_update_mac,
 	.bat_primary_iface_set = batadv_v_primary_iface_set,
+	.bat_hardif_neigh_init = batadv_v_hardif_neigh_init,
 	.bat_ogm_emit = batadv_v_ogm_emit,
 	.bat_ogm_schedule = batadv_v_ogm_schedule,
 };
@@ -70,5 +78,18 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
  */
 int __init batadv_v_init(void)
 {
-	return batadv_algo_register(&batadv_batman_v);
+	int ret;
+
+	/* B.A.T.M.A.N. V echo location protocol packet  */
+	ret = batadv_recv_handler_register(BATADV_ELP,
+					   batadv_v_elp_packet_recv);
+	if (ret < 0)
+		return ret;
+
+	ret = batadv_algo_register(&batadv_batman_v);
+
+	if (ret < 0)
+		batadv_recv_handler_unregister(BATADV_ELP);
+
+	return ret;
 }
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index bc6e046..dac88fa 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -38,7 +38,10 @@
 
 #include "bat_algo.h"
 #include "hard-interface.h"
+#include "hash.h"
+#include "originator.h"
 #include "packet.h"
+#include "routing.h"
 #include "send.h"
 
 /**
@@ -191,3 +194,152 @@ void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface)
 	}
 	rcu_read_unlock();
 }
+
+/**
+ * batadv_v_ogm_orig_get - retrieve and possibly create an originator node
+ * @bat_priv: the bat priv with all the soft interface information
+ * @addr: the address of the originator
+ *
+ * Return: the orig_node corresponding to the specified address. If such object
+ * does not exist it is allocated here. In case of allocation failure returns
+ * NULL.
+ */
+static struct batadv_orig_node *
+batadv_v_ogm_orig_get(struct batadv_priv *bat_priv,
+		      const u8 *addr)
+{
+	struct batadv_orig_node *orig_node;
+	int hash_added;
+
+	orig_node = batadv_orig_hash_find(bat_priv, addr);
+	if (orig_node)
+		return orig_node;
+
+	orig_node = batadv_orig_node_new(bat_priv, addr);
+	if (!orig_node)
+		return NULL;
+
+	hash_added = batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
+				     batadv_choose_orig, orig_node,
+				     &orig_node->hash_entry);
+	if (hash_added != 0) {
+		/* orig_node->refcounter is initialised to 2 by
+		 * batadv_orig_node_new()
+		 */
+		batadv_orig_node_put(orig_node);
+		batadv_orig_node_put(orig_node);
+		orig_node = NULL;
+	}
+
+	return orig_node;
+}
+
+/**
+ * batadv_v_elp_neigh_update - update an ELP neighbour node
+ * @bat_priv: the bat priv with all the soft interface information
+ * @neigh_addr: the neighbour interface address
+ * @if_incoming: the interface the packet was received through
+ * @elp_packet: the received ELP packet
+ *
+ * Updates the ELP neighbour node state with the data received within the new
+ * ELP packet.
+ */
+static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
+				      u8 *neigh_addr,
+				      struct batadv_hard_iface *if_incoming,
+				      struct batadv_elp_packet *elp_packet)
+
+{
+	struct batadv_neigh_node *neigh;
+	struct batadv_orig_node *orig_neigh;
+	struct batadv_hardif_neigh_node *hardif_neigh;
+	s32 seqno_diff;
+	s32 elp_latest_seqno;
+
+	orig_neigh = batadv_v_ogm_orig_get(bat_priv, elp_packet->orig);
+	if (!orig_neigh)
+		return;
+
+	neigh = batadv_neigh_node_new(orig_neigh, if_incoming, neigh_addr);
+	if (!neigh)
+		goto orig_free;
+
+	hardif_neigh = batadv_hardif_neigh_get(if_incoming, neigh_addr);
+	if (!hardif_neigh)
+		goto neigh_free;
+
+	elp_latest_seqno = hardif_neigh->bat_v.elp_latest_seqno;
+	seqno_diff = ntohl(elp_packet->seqno) - elp_latest_seqno;
+
+	/* known or older sequence numbers are ignored. However always adopt
+	 * if the router seems to have been restarted.
+	 */
+	if (seqno_diff < 1 && seqno_diff > -BATADV_ELP_MAX_AGE)
+		goto hardif_free;
+
+	neigh->last_seen = jiffies;
+	hardif_neigh->last_seen = jiffies;
+	hardif_neigh->bat_v.elp_latest_seqno = ntohl(elp_packet->seqno);
+	hardif_neigh->bat_v.elp_interval = ntohl(elp_packet->elp_interval);
+
+hardif_free:
+	if (hardif_neigh)
+		batadv_hardif_neigh_put(hardif_neigh);
+neigh_free:
+	if (neigh)
+		batadv_neigh_node_put(neigh);
+orig_free:
+	if (orig_neigh)
+		batadv_orig_node_put(orig_neigh);
+}
+
+/**
+ * batadv_v_elp_packet_recv - main ELP packet handler
+ * @skb: the received packet
+ * @if_incoming: the interface this packet was received through
+ *
+ * Return: NET_RX_SUCCESS and consumes the skb if the packet was peoperly
+ * processed or NET_RX_DROP in case of failure.
+ */
+int batadv_v_elp_packet_recv(struct sk_buff *skb,
+			     struct batadv_hard_iface *if_incoming)
+{
+	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
+	struct batadv_elp_packet *elp_packet;
+	struct batadv_hard_iface *primary_if;
+	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	bool ret;
+
+	ret = batadv_check_management_packet(skb, if_incoming, BATADV_ELP_HLEN);
+	if (!ret)
+		return NET_RX_DROP;
+
+	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
+		return NET_RX_DROP;
+
+	/* did we receive a B.A.T.M.A.N. V ELP packet on an interface
+	 * that does not have B.A.T.M.A.N. V ELP enabled ?
+	 */
+	if (strcmp(bat_priv->bat_algo_ops->name, "BATMAN_V") != 0)
+		return NET_RX_DROP;
+
+	elp_packet = (struct batadv_elp_packet *)skb->data;
+
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "Received ELP packet from %pM seqno %u ORIG: %pM\n",
+		   ethhdr->h_source, ntohl(elp_packet->seqno),
+		   elp_packet->orig);
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		goto out;
+
+	batadv_v_elp_neigh_update(bat_priv, ethhdr->h_source, if_incoming,
+				  elp_packet);
+
+out:
+	if (primary_if)
+		batadv_hardif_put(primary_if);
+	consume_skb(skb);
+	return NET_RX_SUCCESS;
+}
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index 7a584d1..5a7bc39 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -20,8 +20,12 @@
 #ifndef _NET_BATMAN_ADV_BAT_V_ELP_H_
 #define _NET_BATMAN_ADV_BAT_V_ELP_H_
 
+struct sk_buff;
+
 int batadv_v_elp_iface_enable(struct batadv_hard_iface *hard_iface);
 void batadv_v_elp_iface_disable(struct batadv_hard_iface *hard_iface);
 void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface);
+int batadv_v_elp_packet_recv(struct sk_buff *skb,
+			     struct batadv_hard_iface *if_incoming);
 
 #endif /* _NET_BATMAN_ADV_BAT_V_ELP_H_ */
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 32dfc9e..aebc62b 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -60,6 +60,9 @@
 #define BATADV_TQ_LOCAL_BIDRECT_RECV_MINIMUM 1
 #define BATADV_TQ_TOTAL_BIDRECT_LIMIT 1
 
+/* B.A.T.M.A.N. V */
+#define BATADV_ELP_MAX_AGE 64
+
 /* number of OGMs sent with the last tt diff */
 #define BATADV_TT_OGM_APPEND_MAX 3
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 992d5fd..7fc82a5 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -22,6 +22,7 @@
 #error only "main.h" can be included directly
 #endif
 
+#include <linux/average.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/if_ether.h>
@@ -364,12 +365,28 @@ struct batadv_gw_node {
 	struct rcu_head rcu;
 };
 
+DECLARE_EWMA(throughput, 1024, 8)
+
+/**
+ * struct batadv_hardif_neigh_node_bat_v - B.A.T.M.A.N. V private neighbor
+ *  information
+ * @throughput: ewma link throughput towards this neighbor
+ * @elp_interval: time interval between two ELP transmissions
+ * @elp_latest_seqno: latest and best known ELP sequence number
+ */
+struct batadv_hardif_neigh_node_bat_v {
+	struct ewma_throughput throughput;
+	u32 elp_interval;
+	u32 elp_latest_seqno;
+};
+
 /**
  * struct batadv_hardif_neigh_node - unique neighbor per hard-interface
  * @list: list node for batadv_hard_iface::neigh_list
  * @addr: the MAC address of the neighboring interface
  * @if_incoming: pointer to incoming hard-interface
  * @last_seen: when last packet via this neighbor was received
+ * @bat_v: B.A.T.M.A.N. V private data
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in a RCU-safe manner
  */
@@ -378,6 +395,9 @@ struct batadv_hardif_neigh_node {
 	u8 addr[ETH_ALEN];
 	struct batadv_hard_iface *if_incoming;
 	unsigned long last_seen;
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	struct batadv_hardif_neigh_node_bat_v bat_v;
+#endif
 	struct kref refcount;
 	struct rcu_head rcu;
 };
@@ -425,10 +445,20 @@ struct batadv_neigh_ifinfo_bat_iv {
 };
 
 /**
+ * struct batadv_neigh_ifinfo_bat_v - neighbor information per outgoing
+ *  interface for B.A.T.M.A.N. V
+ * @throughput: last throughput metric received from originator via this neigh
+ */
+struct batadv_neigh_ifinfo_bat_v {
+	u32 throughput;
+};
+
+/**
  * struct batadv_neigh_ifinfo - neighbor information per outgoing interface
  * @list: list node for batadv_neigh_node::ifinfo_list
  * @if_outgoing: pointer to outgoing hard-interface
  * @bat_iv: B.A.T.M.A.N. IV private structure
+ * @bat_v: B.A.T.M.A.N. V private data
  * @last_ttl: last received ttl from this neigh node
  * @refcount: number of contexts the object is used
  * @rcu: struct used for freeing in a RCU-safe manner
@@ -437,6 +467,9 @@ struct batadv_neigh_ifinfo {
 	struct hlist_node list;
 	struct batadv_hard_iface *if_outgoing;
 	struct batadv_neigh_ifinfo_bat_iv bat_iv;
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	struct batadv_neigh_ifinfo_bat_v bat_v;
+#endif
 	u8 last_ttl;
 	struct kref refcount;
 	struct rcu_head rcu;
-- 
2.7.0.rc3

