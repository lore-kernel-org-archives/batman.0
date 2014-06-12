Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Thu, 12 Jun 2014 02:00:27 +0200
Message-Id: <1402531227-15447-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add multicast optimization
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
MLD querier behind the bridge. In that case we need to all according
IPv4 or IPv6 multicast traffic directed to us.

These two parts together allow us to serve all multicast listeners with
IPv6 link-local multicast packets even when bridges are involved and
our multicast optimizations enabled.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 compat.c    |   15 ++++++
 compat.h    |   30 ++++++++++++
 main.h      |    1 +
 multicast.c |  151 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 179 insertions(+), 18 deletions(-)

diff --git a/compat.c b/compat.c
index 3dbf9d2..7187a34 100644
--- a/compat.c
+++ b/compat.c
@@ -109,3 +109,18 @@ void batadv_free_rcu_tvlv_handler(struct rcu_head *rcu)
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
+	return true;
+}
+
+#endif /* < KERNEL_VERSION(3, 16, 0) */
diff --git a/compat.h b/compat.h
index 5eb5fe6..24a86cd 100644
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
@@ -438,4 +444,28 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 14, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0)
+
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
+#endif /* < KERNEL_VERSION(3, 16, 0) */
+
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/main.h b/main.h
index 87e7196..d34dc5d 100644
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
diff --git a/multicast.c b/multicast.c
index 96b66fd..e4a8acd 100644
--- a/multicast.c
+++ b/multicast.c
@@ -23,6 +23,29 @@
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
@@ -30,17 +53,21 @@
  * Collect multicast addresses of the local multicast listeners
  * on the given soft interface, dev, in the given mcast_list.
  *
+ * If there is a bridge interface on top of dev, collect from that one
+ * instead.
+ *
  * Returns -ENOMEM on memory allocation error or the number of
  * items added to the mcast_list otherwise.
  */
 static int batadv_mcast_mla_softif_get(struct net_device *dev,
 				       struct hlist_head *mcast_list)
 {
+	struct net_device *bridge = batadv_mcast_get_bridge(dev);
 	struct netdev_hw_addr *mc_list_entry;
 	struct batadv_hw_addr *new;
 	int ret = 0;
 
-	netif_addr_lock_bh(dev);
+	netif_addr_lock_bh(bridge ? bridge : dev);
 	netdev_for_each_mc_addr(mc_list_entry, dev) {
 		new = kmalloc(sizeof(*new), GFP_ATOMIC);
 		if (!new) {
@@ -52,7 +79,10 @@ static int batadv_mcast_mla_softif_get(struct net_device *dev,
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
@@ -78,6 +108,87 @@ static bool batadv_mcast_mla_is_duplicate(uint8_t *mcast_addr,
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
+	if (src->proto == htons(ETH_P_IP)) {
+		/* RFC 1112 */
+		memcpy(dst, "\x01\x00\x5e", 3);
+		memcpy(dst + 3, ((char *)&src->u.ip4) + 1, ETH_ALEN - 3);
+		dst[3] &= 0x7F;
+	}
+#if IS_ENABLED(CONFIG_IPV6)
+	else if (src->proto == htons(ETH_P_IPV6)) {
+		/* RFC 2464 */
+		memcpy(dst, "\x33\x33", 2);
+		memcpy(dst + 2, &src->u.ip6.s6_addr32[3],
+		       sizeof(src->u.ip6.s6_addr32[3]));
+	}
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
+ * Collects multicast addresses of the bridged-in multicast listeners
+ * from the bridge on top of the given soft interface, dev, in the
+ * given mcast_list.
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
@@ -185,8 +296,8 @@ static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
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
@@ -195,19 +306,18 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 	mcast_data.flags = BATADV_NO_FLAGS;
 	memset(mcast_data.reserved, 0, sizeof(mcast_data.reserved));
 
-	/* Avoid attaching MLAs, if there is a bridge on top of our soft
-	 * interface, we don't support that yet (TODO)
-	 */
-	if (batadv_mcast_has_bridge(bat_priv)) {
-		if (bat_priv->mcast.enabled) {
-			batadv_tvlv_container_unregister(bat_priv,
-							 BATADV_TVLV_MCAST, 1);
-			bat_priv->mcast.enabled = false;
-		}
+	if (!batadv_mcast_has_bridge(bat_priv))
+		goto skip;
 
-		return false;
-	}
+	mcast_data.flags |= BATADV_MCAST_WANT_ALL_UNSNOOPABLES;
+
+	if (br_multicast_has_querier_adjacent(bat_priv->soft_iface, ETH_P_IP))
+		mcast_data.flags |= BATADV_MCAST_WANT_ALL_IPV4;
 
+	if (br_multicast_has_querier_adjacent(bat_priv->soft_iface, ETH_P_IPV6))
+		mcast_data.flags |= BATADV_MCAST_WANT_ALL_IPV6;
+
+skip:
 	if (!bat_priv->mcast.enabled ||
 	    mcast_data.flags != bat_priv->mcast.flags) {
 		batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 1,
@@ -216,7 +326,8 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 		bat_priv->mcast.enabled = true;
 	}
 
-	return true;
+	return !(mcast_data.flags &
+		 (BATADV_MCAST_WANT_ALL_IPV4 + BATADV_MCAST_WANT_ALL_IPV6));
 }
 
 /**
@@ -233,13 +344,17 @@ void batadv_mcast_mla_update(struct batadv_priv *bat_priv)
 	int ret;
 
 	if (!batadv_mcast_mla_tvlv_update(bat_priv))
-		goto update;
+		goto skip;
 
 	ret = batadv_mcast_mla_softif_get(soft_iface, &mcast_list);
 	if (ret < 0)
 		goto out;
 
-update:
+	ret = batadv_mcast_mla_bridge_get(soft_iface, &mcast_list);
+	if (ret < 0)
+		goto out;
+
+skip:
 	batadv_mcast_mla_tt_retract(bat_priv, &mcast_list);
 	batadv_mcast_mla_tt_add(bat_priv, &mcast_list);
 
-- 
1.7.10.4

