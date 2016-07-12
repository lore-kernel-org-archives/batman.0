Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 12 Jul 2016 17:08:05 +0800
Message-Id: <1468314486-29592-2-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1468314486-29592-1-git-send-email-mareklindner@neomailbox.ch>
References: <1468314486-29592-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: additional checks for
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

In a few situations batman-adv tries to determine whether a given interface
is a WiFi interface to enable specific WiFi optimizations. If the interface
batman-adv has been configured with is a virtual interface (e.g. VLAN) it
would not be properly detected as WiFi interface and thus not benefit from
the special WiFi treatment.
This patch changes that by peeking under the hood whenever a virtual
interface is in play.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/hard-interface.c | 85 ++++++++++++++++++++++++++++++++++++++---
 net/batman-adv/hard-interface.h |  1 +
 2 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 478977b..6324474 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -166,14 +166,51 @@ static bool batadv_is_valid_iface(const struct net_device *net_dev)
 }
 
 /**
- * batadv_is_cfg80211_netdev - check if the given net_device struct is a
- *  cfg80211 wifi interface
+ * batadv_get_real_netdev - check if the given net_device struct is a virtual
+ *  interface on top of another 'real' interface
+ * @net_device: the device to check
+ *
+ * Return: the 'real' net device or the original net device and NULL in case
+ *  of an error.
+ */
+struct net_device *batadv_get_real_netdev(struct net_device *net_device)
+{
+	struct batadv_hard_iface *hard_iface = NULL;
+	struct net_device *real_netdev = NULL;
+	struct net *net;
+	int ifindex;
+
+	if (!net_device)
+		return NULL;
+
+	if (net_device->ifindex == dev_get_iflink(net_device)) {
+		dev_hold(net_device);
+		return net_device;
+	}
+
+	hard_iface = batadv_hardif_get_by_netdev(net_device);
+	if (!hard_iface || !hard_iface->soft_iface)
+		goto out;
+
+	net = dev_net(hard_iface->soft_iface);
+	ifindex = dev_get_iflink(net_device);
+	real_netdev = dev_get_by_index(net, ifindex);
+
+out:
+	if (hard_iface)
+		batadv_hardif_put(hard_iface);
+	return real_netdev;
+}
+
+/**
+ * _batadv_is_cfg80211_netdev - check if the given net_device struct is a
+ *  cfg80211 wifi interface (without real netdev check)
  * @net_device: the device to check
  *
  * Return: true if the net device is a cfg80211 wireless device, false
  *  otherwise.
  */
-bool batadv_is_cfg80211_netdev(struct net_device *net_device)
+static bool _batadv_is_cfg80211_netdev(struct net_device *net_device)
 {
 	if (!net_device)
 		return false;
@@ -186,6 +223,32 @@ bool batadv_is_cfg80211_netdev(struct net_device *net_device)
 }
 
 /**
+ * batadv_is_cfg80211_netdev - check if the given net_device struct is a
+ *  cfg80211 wifi interface
+ * @net_device: the device to check
+ *
+ * Return: true if the net device is a cfg80211 wireless device, false
+ *  otherwise.
+ */
+bool batadv_is_cfg80211_netdev(struct net_device *net_device)
+{
+	struct net_device *real_netdev;
+	bool ret;
+
+	if (!net_device)
+		return false;
+
+	real_netdev = batadv_get_real_netdev(net_device);
+	if (!real_netdev)
+		return false;
+
+	ret = _batadv_is_cfg80211_netdev(real_netdev);
+
+	dev_put(real_netdev);
+	return ret;
+}
+
+/**
  * batadv_is_wifi_netdev - check if the given net_device struct is a wifi
  *  interface
  * @net_device: the device to check
@@ -194,18 +257,30 @@ bool batadv_is_cfg80211_netdev(struct net_device *net_device)
  */
 bool batadv_is_wifi_netdev(struct net_device *net_device)
 {
+	struct net_device *real_netdev;
+	bool ret;
+
 	if (!net_device)
 		return false;
 
+	real_netdev = batadv_get_real_netdev(net_device);
+	if (!real_netdev)
+		return false;
+
 #ifdef CONFIG_WIRELESS_EXT
 	/* pre-cfg80211 drivers have to implement WEXT, so it is possible to
 	 * check for wireless_handlers != NULL
 	 */
-	if (net_device->wireless_handlers)
+	if (real_netdev->wireless_handlers) {
+		dev_put(real_netdev);
 		return true;
+	}
 #endif
 
-	return batadv_is_cfg80211_netdev(net_device);
+	ret = _batadv_is_cfg80211_netdev(real_netdev);
+
+	dev_put(real_netdev);
+	return ret;
 }
 
 static struct batadv_hard_iface *
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index e0893de..a14316d 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -51,6 +51,7 @@ enum batadv_hard_if_cleanup {
 
 extern struct notifier_block batadv_hard_if_notifier;
 
+struct net_device *batadv_get_real_netdev(struct net_device *net_device);
 bool batadv_is_cfg80211_netdev(struct net_device *net_device);
 bool batadv_is_wifi_netdev(struct net_device *net_device);
 bool batadv_is_wifi_iface(int ifindex);
-- 
2.8.0.rc3

