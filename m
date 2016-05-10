Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 10 May 2016 18:41:25 +0200
Message-Id: <1462898487-9696-3-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1462898487-9696-1-git-send-email-linus.luessing@c0d3.blue>
References: <1462898487-9696-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv15 2/4] batman-adv: Add multicast
	optimization support for bridged setups
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

With this patch we are finally able to support multicast optimizations
in bridged setups, too. So far, if a bridge was added on top of a
soft-interface (e.g. bat0) the batman-adv multicast optimizations
needed to be disabled to avoid packetloss.

Current Linux bridge implementations and API can now provide us
with the so far missing information about interested but "remote"
multicast receivers behind bridge ports.

The Linux bridge performs the detection of remote participants
interested in multicast packets with its own and mature so
called IGMP and MLD snooping code and stores that in its
database. With the new API provided by the bridge batman-adv can
now simply hook into this database.

We then reliably announce the gathered multicast listeners to
other nodes through the batman-adv translation table.

Additionally, the Linux bridge provides us with the information about
whether an IGMP/MLD querier exists. If there is none then we need to
disable multicast optimizations as we cannot learn about multicast
listeners on external, bridged-in host then.

Tested-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 compat-include/linux/etherdevice.h |    9 ++
 compat-include/linux/if_bridge.h   |   68 ++++++++++++++
 net/batman-adv/multicast.c         |  181 ++++++++++++++++++++++++++++++++----
 net/batman-adv/types.h             |   13 +++
 4 files changed, 253 insertions(+), 18 deletions(-)
 create mode 100644 compat-include/linux/if_bridge.h

diff --git a/compat-include/linux/etherdevice.h b/compat-include/linux/etherdevice.h
index f120202..721945c 100644
--- a/compat-include/linux/etherdevice.h
+++ b/compat-include/linux/etherdevice.h
@@ -35,6 +35,15 @@ static inline void batadv_eth_hw_addr_random(struct net_device *dev)
 
 #endif /* < KERNEL_VERSION(3, 4, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
+
+static inline void eth_zero_addr(u8 *addr)
+{
+	memset(addr, 0x00, ETH_ALEN);
+}
+
+#endif /* < KERNEL_VERSION(3, 7, 0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 14, 0)
 
 #define ether_addr_equal_unaligned(_a, _b) (memcmp(_a, _b, ETH_ALEN) == 0)
diff --git a/compat-include/linux/if_bridge.h b/compat-include/linux/if_bridge.h
new file mode 100644
index 0000000..9aae018
--- /dev/null
+++ b/compat-include/linux/if_bridge.h
@@ -0,0 +1,68 @@
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_
+
+#include <linux/version.h>
+#include_next <linux/if_bridge.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
+
+struct br_ip {
+	union {
+		__be32  ip4;
+#if IS_ENABLED(CONFIG_IPV6)
+		struct in6_addr ip6;
+#endif
+	} u;
+	__be16          proto;
+	__u16           vid;
+};
+
+struct br_ip_list {
+	struct list_head list;
+	struct br_ip addr;
+};
+
+#endif /* < KERNEL_VERSION(3, 16, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0) || \
+    LINUX_VERSION_CODE == KERNEL_VERSION(3, 16, 0) && \
+	(!IS_ENABLED(CONFIG_BRIDGE) || \
+	!IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING))
+
+#define br_multicast_list_adjacent(dev, br_ip_list) \
+	batadv_br_multicast_list_adjacent(dev, br_ip_list)
+
+#define br_multicast_has_querier_adjacent(dev, proto) \
+	batadv_br_multicast_has_querier_adjacent(dev, proto)
+
+static inline int
+batadv_br_multicast_list_adjacent(struct net_device *dev,
+				  struct list_head *br_ip_list)
+{
+	return 0;
+}
+
+static inline bool
+batadv_br_multicast_has_querier_adjacent(struct net_device *dev, int proto)
+{
+	return false;
+}
+
+#endif /* < KERNEL_VERSION(3, 16, 0) ||
+	* == KERNEL_VERSION(3, 16, 0) &&
+	* (!IS_ENABLED(CONFIG_BRIDGE) ||
+	* !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
+
+static inline bool br_multicast_has_querier_anywhere(struct net_device *dev,
+						     int proto)
+{
+	pr_warn_once("Old kernel detected (< 3.17) - multicast optimizations disabled\n");
+
+	return false;
+}
+
+#endif /* < KERNEL_VERSION(3, 17, 0) */
+
+#endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_ */
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index b8662f1..a4e73f1 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -26,6 +26,7 @@
 #include <linux/etherdevice.h>
 #include <linux/fs.h>
 #include <linux/icmpv6.h>
+#include <linux/if_bridge.h>
 #include <linux/if_ether.h>
 #include <linux/igmp.h>
 #include <linux/in6.h>
@@ -36,6 +37,7 @@
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
+#include <linux/printk.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
@@ -45,18 +47,53 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <net/addrconf.h>
+#include <net/if_inet6.h>
+#include <net/ip.h>
 #include <net/ipv6.h>
 
 #include "packet.h"
 #include "translation-table.h"
 
 /**
+ * batadv_mcast_get_bridge - get the bridge on top of the softif if it exists
+ * @soft_iface: netdev struct of the mesh interface
+ *
+ * If the given soft interface has a bridge on top then the refcount
+ * of the according net device is increased.
+ *
+ * Return: NULL if no such bridge exists. Otherwise the net device of the
+ * bridge.
+ */
+static struct net_device *batadv_mcast_get_bridge(struct net_device *soft_iface)
+{
+	struct net_device *upper = soft_iface;
+
+	rcu_read_lock();
+	do {
+		upper = netdev_master_upper_dev_get_rcu(upper);
+	} while (upper && !(upper->priv_flags & IFF_EBRIDGE));
+
+	if (upper)
+		dev_hold(upper);
+	rcu_read_unlock();
+
+	return upper;
+}
+
+/**
  * batadv_mcast_mla_softif_get - get softif multicast listeners
  * @dev: the device to collect multicast addresses from
  * @mcast_list: a list to put found addresses into
  *
- * Collect multicast addresses of the local multicast listeners
- * on the given soft interface, dev, in the given mcast_list.
+ * Collects multicast addresses of multicast listeners residing
+ * on this kernel on the given soft interface, dev, in
+ * the given mcast_list. In general, multicast listeners provided by
+ * your multicast receiving applications run directly on this node.
+ *
+ * If there is a bridge interface on top of dev, collects from that one
+ * instead. Just like with IP addresses and routes, multicast listeners
+ * will(/should) register to the bridge interface instead of an
+ * enslaved bat0.
  *
  * Return: -ENOMEM on memory allocation error or the number of
  * items added to the mcast_list otherwise.
@@ -64,12 +101,13 @@
 static int batadv_mcast_mla_softif_get(struct net_device *dev,
 				       struct hlist_head *mcast_list)
 {
+	struct net_device *bridge = batadv_mcast_get_bridge(dev);
 	struct netdev_hw_addr *mc_list_entry;
 	struct batadv_hw_addr *new;
 	int ret = 0;
 
-	netif_addr_lock_bh(dev);
-	netdev_for_each_mc_addr(mc_list_entry, dev) {
+	netif_addr_lock_bh(bridge ? bridge : dev);
+	netdev_for_each_mc_addr(mc_list_entry, bridge ? bridge : dev) {
 		new = kmalloc(sizeof(*new), GFP_ATOMIC);
 		if (!new) {
 			ret = -ENOMEM;
@@ -80,7 +118,10 @@ static int batadv_mcast_mla_softif_get(struct net_device *dev,
 		hlist_add_head(&new->list, mcast_list);
 		ret++;
 	}
-	netif_addr_unlock_bh(dev);
+	netif_addr_unlock_bh(bridge ? bridge : dev);
+
+	if (bridge)
+		dev_put(bridge);
 
 	return ret;
 }
@@ -106,6 +147,83 @@ static bool batadv_mcast_mla_is_duplicate(u8 *mcast_addr,
 }
 
 /**
+ * batadv_mcast_mla_br_addr_cpy - copy a bridge multicast address
+ * @dst: destination to write to - a multicast MAC address
+ * @src: source to read from - a multicast IP address
+ *
+ * Converts a given multicast IPv4/IPv6 address from a bridge
+ * to its matching multicast MAC address and copies it into the given
+ * destination buffer.
+ *
+ * Caller needs to make sure the destination buffer can hold
+ * at least ETH_ALEN bytes.
+ */
+static void batadv_mcast_mla_br_addr_cpy(char *dst, const struct br_ip *src)
+{
+	if (src->proto == htons(ETH_P_IP))
+		ip_eth_mc_map(src->u.ip4, dst);
+#if IS_ENABLED(CONFIG_IPV6)
+	else if (src->proto == htons(ETH_P_IPV6))
+		ipv6_eth_mc_map(&src->u.ip6, dst);
+#endif
+	else
+		eth_zero_addr(dst);
+}
+
+/**
+ * batadv_mcast_mla_bridge_get - get bridged-in multicast listeners
+ * @dev: a bridge slave whose bridge to collect multicast addresses from
+ * @mcast_list: a list to put found addresses into
+ *
+ * Collects multicast addresses of multicast listeners residing
+ * on foreign, non-mesh devices which we gave access to our mesh via
+ * a bridge on top of the given soft interface, dev, in the given
+ * mcast_list.
+ *
+ * Return: -ENOMEM on memory allocation error or the number of
+ * items added to the mcast_list otherwise.
+ */
+static int batadv_mcast_mla_bridge_get(struct net_device *dev,
+				       struct hlist_head *mcast_list)
+{
+	struct list_head bridge_mcast_list = LIST_HEAD_INIT(bridge_mcast_list);
+	struct br_ip_list *br_ip_entry, *tmp;
+	struct batadv_hw_addr *new;
+	u8 mcast_addr[ETH_ALEN];
+	int ret;
+
+	/* we don't need to detect these devices/listeners, the IGMP/MLD
+	 * snooping code of the Linux bridge already does that for us
+	 */
+	ret = br_multicast_list_adjacent(dev, &bridge_mcast_list);
+	if (ret < 0)
+		goto out;
+
+	list_for_each_entry(br_ip_entry, &bridge_mcast_list, list) {
+		batadv_mcast_mla_br_addr_cpy(mcast_addr, &br_ip_entry->addr);
+		if (batadv_mcast_mla_is_duplicate(mcast_addr, mcast_list))
+			continue;
+
+		new = kmalloc(sizeof(*new), GFP_ATOMIC);
+		if (!new) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		ether_addr_copy(new->addr, mcast_addr);
+		hlist_add_head(&new->list, mcast_list);
+	}
+
+out:
+	list_for_each_entry_safe(br_ip_entry, tmp, &bridge_mcast_list, list) {
+		list_del(&br_ip_entry->list);
+		kfree(br_ip_entry);
+	}
+
+	return ret;
+}
+
+/**
  * batadv_mcast_mla_list_free - free a list of multicast addresses
  * @bat_priv: the bat priv with all the soft interface information
  * @mcast_list: the list to free
@@ -222,29 +340,51 @@ static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
  * Updates the own multicast tvlv with our current multicast related settings,
  * capabilities and inabilities.
  *
- * Return: true if the tvlv container is registered afterwards. Otherwise
- * returns false.
+ * Return: false if we want all IPv4 && IPv6 multicast traffic and true
+ * otherwise.
  */
 static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 {
 	struct batadv_tvlv_mcast_data mcast_data;
+	struct batadv_mcast_querier_state querier4 = {false, false};
+	struct batadv_mcast_querier_state querier6 = {false, false};
+	struct net_device *dev = bat_priv->soft_iface;
 
 	mcast_data.flags = BATADV_NO_FLAGS;
 	memset(mcast_data.reserved, 0, sizeof(mcast_data.reserved));
 
-	/* Avoid attaching MLAs, if there is a bridge on top of our soft
-	 * interface, we don't support that yet (TODO)
+	bat_priv->mcast.bridged = batadv_mcast_has_bridge(bat_priv);
+	if (!bat_priv->mcast.bridged)
+		goto update;
+
+#if !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)
+	pr_warn_once("No bridge IGMP snooping compiled - multicast optimizations disabled\n");
+#endif
+
+	querier4.exists = br_multicast_has_querier_anywhere(dev, ETH_P_IP);
+	querier4.shadowing = br_multicast_has_querier_adjacent(dev, ETH_P_IP);
+
+	querier6.exists = br_multicast_has_querier_anywhere(dev, ETH_P_IPV6);
+	querier6.shadowing = br_multicast_has_querier_adjacent(dev, ETH_P_IPV6);
+
+	mcast_data.flags |= BATADV_MCAST_WANT_ALL_UNSNOOPABLES;
+
+	/* 1) If no querier exists at all, then multicast listeners on
+	 *    our local TT clients behind the bridge will keep silent.
+	 * 2) If the selected querier is on one of our local TT clients,
+	 *    behind the bridge, then this querier might shadow multicast
+	 *    listeners on our local TT clients, behind this bridge.
+	 *
+	 * In both cases, we will signalize other batman nodes that
+	 * we need all multicast traffic of the according protocol.
 	 */
-	if (batadv_mcast_has_bridge(bat_priv)) {
-		if (bat_priv->mcast.enabled) {
-			batadv_tvlv_container_unregister(bat_priv,
-							 BATADV_TVLV_MCAST, 2);
-			bat_priv->mcast.enabled = false;
-		}
+	if (!querier4.exists || querier4.shadowing)
+		mcast_data.flags |= BATADV_MCAST_WANT_ALL_IPV4;
 
-		return false;
-	}
+	if (!querier6.exists || querier6.shadowing)
+		mcast_data.flags |= BATADV_MCAST_WANT_ALL_IPV6;
 
+update:
 	if (!bat_priv->mcast.enabled ||
 	    mcast_data.flags != bat_priv->mcast.flags) {
 		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 2,
@@ -253,7 +393,8 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 		bat_priv->mcast.enabled = true;
 	}
 
-	return true;
+	return !(mcast_data.flags &
+		 (BATADV_MCAST_WANT_ALL_IPV4 + BATADV_MCAST_WANT_ALL_IPV6));
 }
 
 /**
@@ -276,6 +417,10 @@ void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
 	if (ret < 0)
 		goto out;
 
+	ret = batadv_mcast_mla_bridge_get(soft_iface, &mcast_list);
+	if (ret < 0)
+		goto out;
+
 update:
 	batadv_mcast_mla_tt_retract(bat_priv, &mcast_list);
 	batadv_mcast_mla_tt_add(bat_priv, &mcast_list);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 32c6d0e..83303c2 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -755,6 +755,17 @@ struct batadv_priv_dat {
 
 #ifdef CONFIG_BATMAN_ADV_MCAST
 /**
+ * struct batadv_mcast_querier_state - IGMP/MLD querier state when bridged
+ * @exists: whether a querier exists in the mesh
+ * @shadowing: if a querier exists, whether it is potentially shadowing
+ *  multicast listeners (i.e. querier is behind our own bridge segment)
+ */
+struct batadv_mcast_querier_state {
+	bool exists;
+	bool shadowing;
+};
+
+/**
  * struct batadv_priv_mcast - per mesh interface mcast data
  * @mla_list: list of multicast addresses we are currently announcing via TT
  * @want_all_unsnoopables_list: a list of orig_nodes wanting all unsnoopable
@@ -763,6 +774,7 @@ struct batadv_priv_dat {
  * @want_all_ipv6_list: a list of orig_nodes wanting all IPv6 multicast traffic
  * @flags: the flags we have last sent in our mcast tvlv
  * @enabled: whether the multicast tvlv is currently enabled
+ * @bridged: whether the soft interface has a bridge on top
  * @num_disabled: number of nodes that have no mcast tvlv
  * @num_want_all_unsnoopables: number of nodes wanting unsnoopable IP traffic
  * @num_want_all_ipv4: counter for items in want_all_ipv4_list
@@ -777,6 +789,7 @@ struct batadv_priv_mcast {
 	struct hlist_head want_all_ipv6_list;
 	u8 flags;
 	bool enabled;
+	bool bridged;
 	atomic_t num_disabled;
 	atomic_t num_want_all_unsnoopables;
 	atomic_t num_want_all_ipv4;
-- 
1.7.10.4

