Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 29 May 2013 10:10:31 +0200
Message-Id: <1369815051-708-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1369815051-708-1-git-send-email-ordex@autistici.org>
References: <1369815051-708-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 01/21] batman-adv: split
	batadv_is_wifi_iface() into two functions
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <ordex@autistici.org>, Marek Lindner <lindner_marek@yahoo.de>

From: Matthias Schiffer <mschiffer@universe-factory.net>

Previously batadv_is_wifi_iface() did two things at once: looking up a
net_device from an interface index, and determining if it is a wifi device.

The second part is useful itself when the caller already has a net_device
reference.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/hard-interface.c | 84 +++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 32 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index b6504ea..d5ec67b 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -117,6 +117,58 @@ static int batadv_is_valid_iface(const struct net_device *net_dev)
 	return 1;
 }
 
+/**
+ * batadv_is_wifi_netdev - check if the given net_device struct is a wifi
+ *  interface
+ * @net_device: the device to check
+ *
+ * Returns true if the net device is a 802.11 wireless device, false otherwise.
+ */
+static bool batadv_is_wifi_netdev(struct net_device *net_device)
+{
+#ifdef CONFIG_WIRELESS_EXT
+	/* pre-cfg80211 drivers have to implement WEXT, so it is possible to
+	 * check for wireless_handlers != NULL
+	 */
+	if (net_device->wireless_handlers)
+		return true;
+#endif
+
+	/* cfg80211 drivers have to set ieee80211_ptr */
+	if (net_device->ieee80211_ptr)
+		return true;
+
+	return false;
+}
+
+/**
+ * batadv_is_wifi_iface - check if the given interface represented by ifindex
+ *  is a wifi interface
+ * @ifindex: interface index to check
+ *
+ * Returns true if the interface represented by ifindex is a 802.11 wireless
+ * device, false otherwise.
+ */
+bool batadv_is_wifi_iface(int ifindex)
+{
+	struct net_device *net_device = NULL;
+	bool ret = false;
+
+	if (ifindex == BATADV_NULL_IFINDEX)
+		goto out;
+
+	net_device = dev_get_by_index(&init_net, ifindex);
+	if (!net_device)
+		goto out;
+
+	ret = batadv_is_wifi_netdev(net_device);
+
+out:
+	if (net_device)
+		dev_put(net_device);
+	return ret;
+}
+
 static struct batadv_hard_iface *
 batadv_hardif_get_active(const struct net_device *soft_iface)
 {
@@ -657,38 +709,6 @@ out:
 	return NOTIFY_DONE;
 }
 
-/* This function returns true if the interface represented by ifindex is a
- * 802.11 wireless device
- */
-bool batadv_is_wifi_iface(int ifindex)
-{
-	struct net_device *net_device = NULL;
-	bool ret = false;
-
-	if (ifindex == BATADV_NULL_IFINDEX)
-		goto out;
-
-	net_device = dev_get_by_index(&init_net, ifindex);
-	if (!net_device)
-		goto out;
-
-#ifdef CONFIG_WIRELESS_EXT
-	/* pre-cfg80211 drivers have to implement WEXT, so it is possible to
-	 * check for wireless_handlers != NULL
-	 */
-	if (net_device->wireless_handlers)
-		ret = true;
-	else
-#endif
-		/* cfg80211 drivers have to set ieee80211_ptr */
-		if (net_device->ieee80211_ptr)
-			ret = true;
-out:
-	if (net_device)
-		dev_put(net_device);
-	return ret;
-}
-
 struct notifier_block batadv_hard_if_notifier = {
 	.notifier_call = batadv_hard_if_event,
 };
-- 
1.8.1.5

