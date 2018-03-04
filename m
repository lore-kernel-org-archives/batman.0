Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun,  4 Mar 2018 15:04:08 +0100
Message-Id: <20180304140408.7015-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Avoid redundant multicast TT
 entries
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

If a node signals that it wants all traffic for a specific protocol
family then there is no need to announce individual multicast addresses
via TT.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
v2:
- for consistency use "const u8 *addr" instead of "unsigned char *addr"
  in function header
- for consistency remove some spaces in arrays
- use more explicit "memcmp(...) == 0" instead of "!memcmp(...)"
---
 net/batman-adv/multicast.c | 56 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 6eaffe50..7253fae2 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -102,7 +102,36 @@ static struct net_device *batadv_mcast_get_bridge(struct net_device *soft_iface)
 }
 
 /**
+ * batadv_mcast_addr_is_ipv4() - check if multicast MAC is IPv4
+ * @addr: the MAC address to check
+ *
+ * Return: True, if MAC address is one reserved for IPv4 multicast, false
+ * otherwise.
+ */
+static bool batadv_mcast_addr_is_ipv4(const u8 *addr)
+{
+	const unsigned char prefix[] = {0x01, 0x00, 0x5E};
+
+	return memcmp(prefix, addr, sizeof(prefix)) == 0;
+}
+
+/**
+ * batadv_mcast_addr_is_ipv6() - check if multicast MAC is IPv6
+ * @addr: the MAC address to check
+ *
+ * Return: True, if MAC address is one reserved for IPv6 multicast, false
+ * otherwise.
+ */
+static bool batadv_mcast_addr_is_ipv6(const u8 *addr)
+{
+	const unsigned char prefix[] = {0x33, 0x33};
+
+	return memcmp(prefix, addr, sizeof(prefix)) == 0;
+}
+
+/**
  * batadv_mcast_mla_softif_get() - get softif multicast listeners
+ * @bat_priv: the bat priv with all the soft interface information
  * @dev: the device to collect multicast addresses from
  * @mcast_list: a list to put found addresses into
  *
@@ -119,9 +148,12 @@ static struct net_device *batadv_mcast_get_bridge(struct net_device *soft_iface)
  * Return: -ENOMEM on memory allocation error or the number of
  * items added to the mcast_list otherwise.
  */
-static int batadv_mcast_mla_softif_get(struct net_device *dev,
+static int batadv_mcast_mla_softif_get(struct batadv_priv *bat_priv,
+				       struct net_device *dev,
 				       struct hlist_head *mcast_list)
 {
+	bool all_ipv4 = bat_priv->mcast.flags & BATADV_MCAST_WANT_ALL_IPV4;
+	bool all_ipv6 = bat_priv->mcast.flags & BATADV_MCAST_WANT_ALL_IPV6;
 	struct net_device *bridge = batadv_mcast_get_bridge(dev);
 	struct netdev_hw_addr *mc_list_entry;
 	struct batadv_hw_addr *new;
@@ -129,6 +161,12 @@ static int batadv_mcast_mla_softif_get(struct net_device *dev,
 
 	netif_addr_lock_bh(bridge ? bridge : dev);
 	netdev_for_each_mc_addr(mc_list_entry, bridge ? bridge : dev) {
+		if (all_ipv4 && batadv_mcast_addr_is_ipv4(mc_list_entry->addr))
+			continue;
+
+		if (all_ipv6 && batadv_mcast_addr_is_ipv6(mc_list_entry->addr))
+			continue;
+
 		new = kmalloc(sizeof(*new), GFP_ATOMIC);
 		if (!new) {
 			ret = -ENOMEM;
@@ -193,6 +231,7 @@ static void batadv_mcast_mla_br_addr_cpy(char *dst, const struct br_ip *src)
 
 /**
  * batadv_mcast_mla_bridge_get() - get bridged-in multicast listeners
+ * @bat_priv: the bat priv with all the soft interface information
  * @dev: a bridge slave whose bridge to collect multicast addresses from
  * @mcast_list: a list to put found addresses into
  *
@@ -204,10 +243,13 @@ static void batadv_mcast_mla_br_addr_cpy(char *dst, const struct br_ip *src)
  * Return: -ENOMEM on memory allocation error or the number of
  * items added to the mcast_list otherwise.
  */
-static int batadv_mcast_mla_bridge_get(struct net_device *dev,
+static int batadv_mcast_mla_bridge_get(struct batadv_priv *bat_priv,
+				       struct net_device *dev,
 				       struct hlist_head *mcast_list)
 {
 	struct list_head bridge_mcast_list = LIST_HEAD_INIT(bridge_mcast_list);
+	bool all_ipv4 = bat_priv->mcast.flags & BATADV_MCAST_WANT_ALL_IPV4;
+	bool all_ipv6 = bat_priv->mcast.flags & BATADV_MCAST_WANT_ALL_IPV6;
 	struct br_ip_list *br_ip_entry, *tmp;
 	struct batadv_hw_addr *new;
 	u8 mcast_addr[ETH_ALEN];
@@ -221,6 +263,12 @@ static int batadv_mcast_mla_bridge_get(struct net_device *dev,
 		goto out;
 
 	list_for_each_entry(br_ip_entry, &bridge_mcast_list, list) {
+		if (all_ipv4 && br_ip_entry->addr.proto == htons(ETH_P_IP))
+			continue;
+
+		if (all_ipv6 && br_ip_entry->addr.proto == htons(ETH_P_IPV6))
+			continue;
+
 		batadv_mcast_mla_br_addr_cpy(mcast_addr, &br_ip_entry->addr);
 		if (batadv_mcast_mla_is_duplicate(mcast_addr, mcast_list))
 			continue;
@@ -568,11 +616,11 @@ static void __batadv_mcast_mla_update(struct batadv_priv *bat_priv)
 	if (!batadv_mcast_mla_tvlv_update(bat_priv))
 		goto update;
 
-	ret = batadv_mcast_mla_softif_get(soft_iface, &mcast_list);
+	ret = batadv_mcast_mla_softif_get(bat_priv, soft_iface, &mcast_list);
 	if (ret < 0)
 		goto out;
 
-	ret = batadv_mcast_mla_bridge_get(soft_iface, &mcast_list);
+	ret = batadv_mcast_mla_bridge_get(bat_priv, soft_iface, &mcast_list);
 	if (ret < 0)
 		goto out;
 
-- 
2.11.0

