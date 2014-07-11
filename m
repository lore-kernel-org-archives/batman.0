Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri, 11 Jul 2014 03:54:19 +0200
Message-Id: <1405043659-9086-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Add multicast optimization
	support for bridged setups
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

So far, the recently added multicast optimizations did not support
a configuration where a bridge is on top of the soft-interface (e.g.
bat0).

Now the Linux bridge code is able to provide us with the missing bits:

Multicast Listeners: The bridge hands us a list of multicast listeners
it has detected behind the bridge which we will announce through the
mesh via the translation table, allowing other nodes to direct multicast
packets to these clients behind the bridge even with enabled multicast
optimizations.

Queriers: The bridge informs us whether there is a selected IGMP or
MLD querier behind the bridge or if there is no querier at all. In these
cases we need all according IPv4 or IPv6 multicast traffic directed to us.

These two parts together allow us to serve all multicast listeners with
IPv6 link-local multicast packets even when bridges are involved and
our multicast optimizations enabled.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
Changes in v3:
* Removed "RFC" tag in title again: The stubs and new export are upstream
  in net-next and therefore going to be included in 3.17
* Added some debug output:
  * Two warning messages:
    -> Old kernel version or no bridge IGMP/MLD snooping compiled
  * New batman-adv log-level "mcast":
    -> Logging mcast flag changes
  (a third debugging facility, a new table for debugfs for a global
   mcast flag overview will be added in a separate patch later
   as discussed with Simon)

Changes in v2:
* fetching local (= on this same kernel) multicast listeners from
  the bridge instead of the bat0 interface if a bridge is present
  - just like ip addresses and routes should be used from br0, the
  same goes for multicast listeners
* beautification of batadv_mcast_mla_br_addr_cpy(), now using already
  present functions from the kernel instead of own, hackish approach
* changed names of some goto-labels (not using "skip" anymore)
* using new, third bridge multicast export (because this export is
  not upstream yet, I've added the "RFC" in the title):
  br_multicast_has_querier_anywhere()
* adding compat stubs for two bridge multicast exports, to make
  batman-adv compile- and usable even if a 3.16 kernel was compiled
  without bridge code - the stubs are supposed to be upstream in the
  bridge code in 3.17 (therefore just 'compat')
* updated kerneldocs for batadv_mcast_mla_bridge_get() and
  batadv_mcast_mla_softif_get()
* The two sentences in the commit message starting with "Queriers: ..." 
  were slightly modified to include the third bridge multicast export

 compat.c    |   39 ++++++++++++
 compat.h    |   32 ++++++++++
 main.h      |    6 +-
 multicast.c |  193 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 251 insertions(+), 19 deletions(-)

diff --git a/compat.c b/compat.c
index 3dbf9d2..31546f5 100644
--- a/compat.c
+++ b/compat.c
@@ -109,3 +109,42 @@ void batadv_free_rcu_tvlv_handler(struct rcu_head *rcu)
 }
 
 #endif /* < KERNEL_VERSION(3, 0, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
+
+int br_multicast_list_adjacent(struct net_device *dev,
+			       struct list_head *br_ip_list)
+{
+	return 0;
+}
+
+bool br_multicast_has_querier_adjacent(struct net_device *dev, int proto)
+{
+	return false;
+}
+
+#endif /* < KERNEL_VERSION(3, 16, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
+
+bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto)
+{
+	pr_warn_once("Old kernel detected (< 3.17) - multicast optimizations disabled\n");
+
+	return false;
+}
+
+#if !(IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING))
+int br_multicast_list_adjacent(struct net_device *dev,
+			       struct list_head *br_ip_list)
+{
+	return 0;
+}
+
+bool br_multicast_has_querier_adjacent(struct net_device *dev, int proto)
+{
+	return false;
+}
+#endif
+
+#endif /* < KERNEL_VERSION(3, 17, 0) */
diff --git a/compat.h b/compat.h
index ed5b815..14de948 100644
--- a/compat.h
+++ b/compat.h
@@ -240,6 +240,12 @@ static inline void skb_reset_mac_len(struct sk_buff *skb)
 
 #endif /* < KERNEL_VERSION(3, 0, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 1, 0)
+
+#define IS_ENABLED(x) defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+
+#endif /* < KERNEL_VERSION(3, 1, 0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
 
 #define batadv_interface_add_vid(x, y, z) \
@@ -444,6 +450,32 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #define pskb_copy_for_clone pskb_copy
 
+int br_multicast_list_adjacent(struct net_device *dev,
+			       struct list_head *br_ip_list);
+bool br_multicast_has_querier_adjacent(struct net_device *dev, int proto);
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
 #endif /* < KERNEL_VERSION(3, 16, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
+
+bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto);
+
+#endif /* < KERNEL_VERSION(3, 17, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/main.h b/main.h
index 4bb500b..1e1e000 100644
--- a/main.h
+++ b/main.h
@@ -169,6 +169,7 @@ enum batadv_uev_type {
 #include <linux/netdevice.h>	/* netdevice */
 #include <linux/etherdevice.h>  /* ethernet address classification */
 #include <linux/if_ether.h>	/* ethernet header */
+#include <linux/if_bridge.h>	/* bridge / multicast-snooping communication */
 #include <linux/poll.h>		/* poll_table */
 #include <linux/kthread.h>	/* kernel threads */
 #include <linux/pkt_sched.h>	/* schedule types */
@@ -177,6 +178,7 @@ enum batadv_uev_type {
 #include <linux/slab.h>
 #include <net/sock.h>		/* struct sock */
 #include <net/addrconf.h>	/* ipv6 address stuff */
+#include <net/ip.h>
 #include <linux/ip.h>
 #include <net/rtnetlink.h>
 #include <linux/jiffies.h>
@@ -223,6 +225,7 @@ __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr);
  * @BATADV_DBG_BLA: bridge loop avoidance messages
  * @BATADV_DBG_DAT: ARP snooping and DAT related messages
  * @BATADV_DBG_NC: network coding related messages
+ * @BATADV_DBG_MCAST: multicast related messages
  * @BATADV_DBG_ALL: the union of all the above log levels
  */
 enum batadv_dbg_level {
@@ -232,7 +235,8 @@ enum batadv_dbg_level {
 	BATADV_DBG_BLA    = BIT(3),
 	BATADV_DBG_DAT    = BIT(4),
 	BATADV_DBG_NC	  = BIT(5),
-	BATADV_DBG_ALL    = 63,
+	BATADV_DBG_MCAST  = BIT(6),
+	BATADV_DBG_ALL    = 127,
 };
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
diff --git a/multicast.c b/multicast.c
index 96b66fd..5e8a931 100644
--- a/multicast.c
+++ b/multicast.c
@@ -23,12 +23,42 @@
 #include "multicast.h"
 
 /**
+ * batadv_mcast_get_bridge - get the bridge on top of the softif if it exists
+ * @soft_iface: netdev struct of the mesh interface
+ *
+ * Returns either a bridge interface on top of our soft interface or
+ * NULL if no such bridge exists.
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
  * Returns -ENOMEM on memory allocation error or the number of
  * items added to the mcast_list otherwise.
@@ -36,12 +66,13 @@
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
@@ -52,7 +83,10 @@ static int batadv_mcast_mla_softif_get(struct net_device *dev,
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
@@ -78,6 +112,83 @@ static bool batadv_mcast_mla_is_duplicate(uint8_t *mcast_addr,
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
+		memset(dst, 0, ETH_ALEN);
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
+ * Returns -ENOMEM on memory allocation error or the number of
+ * items added to the mcast_list otherwise.
+ */
+static int batadv_mcast_mla_bridge_get(struct net_device *dev,
+				       struct hlist_head *mcast_list)
+{
+	struct list_head bridge_mcast_list = LIST_HEAD_INIT(bridge_mcast_list);
+	struct br_ip_list *br_ip_entry, *tmp;
+	struct batadv_hw_addr *new;
+	uint8_t mcast_addr[ETH_ALEN];
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
  * @mcast_list: the list to free
  *
@@ -185,38 +296,80 @@ static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
  * Updates the own multicast tvlv with our current multicast related settings,
  * capabilities and inabilities.
  *
- * Returns true if the tvlv container is registered afterwards. Otherwise
- * returns false.
+ * Returns false if we want all IPv4 && IPv6 multicast traffic and true
+ * otherwise.
  */
 static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 {
 	struct batadv_tvlv_mcast_data mcast_data;
+	struct net_device *soft_iface = bat_priv->soft_iface;
+	int str_flags_len = strlen("<undefined>") + 1;
+	char str_flags_old[str_flags_len], str_flags_new[str_flags_len];
 
 	mcast_data.flags = BATADV_NO_FLAGS;
 	memset(mcast_data.reserved, 0, sizeof(mcast_data.reserved));
 
-	/* Avoid attaching MLAs, if there is a bridge on top of our soft
-	 * interface, we don't support that yet (TODO)
+	if (!batadv_mcast_has_bridge(bat_priv))
+		goto update;
+
+#if !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING)
+	pr_warn_once("No bridge IGMP snooping compiled - multicast optimizations disabled\n");
+#endif
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
-							 BATADV_TVLV_MCAST, 1);
-			bat_priv->mcast.enabled = false;
-		}
+	if (!br_multicast_has_querier_anywhere(soft_iface, ETH_P_IP) ||
+	    br_multicast_has_querier_adjacent(soft_iface, ETH_P_IP))
+		mcast_data.flags |= BATADV_MCAST_WANT_ALL_IPV4;
 
-		return false;
-	}
+	if (!br_multicast_has_querier_anywhere(soft_iface, ETH_P_IPV6) ||
+	    br_multicast_has_querier_adjacent(soft_iface, ETH_P_IPV6))
+		mcast_data.flags |= BATADV_MCAST_WANT_ALL_IPV6;
 
+update:
 	if (!bat_priv->mcast.enabled ||
 	    mcast_data.flags != bat_priv->mcast.flags) {
+		if (!bat_priv->mcast.enabled)
+			sprintf(str_flags_old, "<undefined>");
+		else
+			sprintf(str_flags_old, "[%c%c%c]",
+				(bat_priv->mcast.flags &
+				 BATADV_MCAST_WANT_ALL_UNSNOOPABLES ?
+				 'U' : '.'),
+				(bat_priv->mcast.flags &
+				 BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.'),
+				(bat_priv->mcast.flags &
+				 BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.'));
+
+		sprintf(str_flags_new, "[%c%c%c]",
+			(mcast_data.flags &
+			 BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.'),
+			(mcast_data.flags &
+			 BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.'),
+			(mcast_data.flags &
+			 BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.'));
+
+		batadv_dbg(BATADV_DBG_MCAST, bat_priv,
+			   "Changing multicast flags from '%s' to '%s'\n",
+			   str_flags_old, str_flags_new);
+
 		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 1,
 					       &mcast_data, sizeof(mcast_data));
 		bat_priv->mcast.flags = mcast_data.flags;
 		bat_priv->mcast.enabled = true;
 	}
 
-	return true;
+	return !(mcast_data.flags &
+		 (BATADV_MCAST_WANT_ALL_IPV4 + BATADV_MCAST_WANT_ALL_IPV6));
 }
 
 /**
@@ -239,6 +392,10 @@ void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
 	if (ret < 0)
 		goto out;
 
+	ret = batadv_mcast_mla_bridge_get(soft_iface, &mcast_list);
+	if (ret < 0)
+		goto out;
+
 update:
 	batadv_mcast_mla_tt_retract(bat_priv, &mcast_list);
 	batadv_mcast_mla_tt_add(bat_priv, &mcast_list);
-- 
1.7.10.4

