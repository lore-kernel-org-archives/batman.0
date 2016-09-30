Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Fri, 30 Sep 2016 15:21:04 +0200
Message-Id: <20160930132106.5798-5-sven.eckelmann@open-mesh.com>
In-Reply-To: <2666783.nl87Kib46y@bentobox>
References: <2666783.nl87Kib46y@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v2 5/7] batman-adv: additional checks for
	virtual interfaces on top of WiFi
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>, Marek Lindner <mareklindner@neomailbox.ch>

From: Marek Lindner <mareklindner@neomailbox.ch>

In a few situations batman-adv tries to determine whether a given interface
is a WiFi interface to enable specific WiFi optimizations. If the interface
batman-adv has been configured with is a virtual interface (e.g. VLAN) it
would not be properly detected as WiFi interface and thus not benefit from
the special WiFi treatment.
This patch changes that by peeking under the hood whenever a virtual
interface is in play.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
[sven.eckelmann@open-mesh.com: integrate in wifi_flags caching, retrieve
 namespace of link interface]
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
v2:
 - introduced batadv_get_real_netdevice which can be used inside rtnl
   locked contexts
 - replace check functions with ones that use the wifi_flags cache
 - use batadv_getlink_net to get the iflink net_namespace
---
 net/batman-adv/hard-interface.c | 58 +++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/types.h          |  4 +++
 2 files changed, 62 insertions(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 341fbb5..ba587fb 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -202,6 +202,47 @@ static bool batadv_is_valid_iface(const struct net_device *net_dev)
 }
 
 /**
+ * batadv_get_real_netdevice - check if the given netdev struct is a virtual
+ *  interface on top of another 'real' interface
+ * @netdev: the device to check
+ *
+ * Return: the 'real' net device or the original net device and NULL in case
+ *  of an error.
+ */
+static struct net_device *batadv_get_real_netdevice(struct net_device *netdev)
+{
+	struct batadv_hard_iface *hard_iface = NULL;
+	struct net_device *real_netdev = NULL;
+	struct net *real_net;
+	struct net *net;
+	int ifindex;
+
+	ASSERT_RTNL();
+
+	if (!netdev)
+		return NULL;
+
+	if (netdev->ifindex == dev_get_iflink(netdev)) {
+		dev_hold(netdev);
+		return netdev;
+	}
+
+	hard_iface = batadv_hardif_get_by_netdev(netdev);
+	if (!hard_iface || !hard_iface->soft_iface)
+		goto out;
+
+	net = dev_net(hard_iface->soft_iface);
+	ifindex = dev_get_iflink(netdev);
+	real_net = batadv_getlink_net(netdev, net);
+	real_netdev = dev_get_by_index(real_net, ifindex);
+
+out:
+	if (hard_iface)
+		batadv_hardif_put(hard_iface);
+	return real_netdev;
+}
+
+/**
  * batadv_is_wext_netdev - check if the given net_device struct is a
  *  wext wifi interface
  * @net_device: the device to check
@@ -254,6 +295,7 @@ static bool batadv_is_cfg80211_netdev(struct net_device *net_device)
 static u32 batadv_wifi_flags_evaluate(struct net_device *net_device)
 {
 	u32 wifi_flags = 0;
+	struct net_device *real_netdev;
 
 	if (batadv_is_wext_netdev(net_device))
 		wifi_flags |= BATADV_HARDIF_WIFI_WEXT_DIRECT;
@@ -261,6 +303,21 @@ static u32 batadv_wifi_flags_evaluate(struct net_device *net_device)
 	if (batadv_is_cfg80211_netdev(net_device))
 		wifi_flags |= BATADV_HARDIF_WIFI_CFG80211_DIRECT;
 
+	real_netdev = batadv_get_real_netdevice(net_device);
+	if (!real_netdev)
+		return wifi_flags;
+
+	if (real_netdev == net_device)
+		goto out;
+
+	if (batadv_is_wext_netdev(real_netdev))
+		wifi_flags |= BATADV_HARDIF_WIFI_WEXT_INDIRECT;
+
+	if (batadv_is_cfg80211_netdev(real_netdev))
+		wifi_flags |= BATADV_HARDIF_WIFI_CFG80211_INDIRECT;
+
+out:
+	dev_put(real_netdev);
 	return wifi_flags;
 }
 
@@ -277,6 +334,7 @@ bool batadv_is_cfg80211_hardif(struct batadv_hard_iface *hard_iface)
 	u32 allowed_flags = 0;
 
 	allowed_flags |= BATADV_HARDIF_WIFI_CFG80211_DIRECT;
+	allowed_flags |= BATADV_HARDIF_WIFI_CFG80211_INDIRECT;
 
 	return !!(hard_iface->wifi_flags & allowed_flags);
 }
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fe64669..a6d8c98 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -123,10 +123,14 @@ struct batadv_hard_iface_bat_v {
  *  of a batadv_hard_iface
  * @BATADV_HARDIF_WIFI_WEXT_DIRECT: it is a wext wifi device
  * @BATADV_HARDIF_WIFI_CFG80211_DIRECT: it is a cfg80211 wifi device
+ * @BATADV_HARDIF_WIFI_WEXT_INDIRECT: link device is a wext wifi device
+ * @BATADV_HARDIF_WIFI_CFG80211_INDIRECT: link device is a cfg80211 wifi device
  */
 enum batadv_hard_iface_wifi_flags {
 	BATADV_HARDIF_WIFI_WEXT_DIRECT = BIT(0),
 	BATADV_HARDIF_WIFI_CFG80211_DIRECT = BIT(1),
+	BATADV_HARDIF_WIFI_WEXT_INDIRECT = BIT(2),
+	BATADV_HARDIF_WIFI_CFG80211_INDIRECT = BIT(3),
 };
 
 /**
-- 
2.9.3

