Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Sat,  9 Mar 2013 23:14:22 +0100
Message-Id: <b6b8ee26c56ef0c28d1efe1c54218c4d7090bd98.1362867238.git.mschiffer@universe-factory.net>
In-Reply-To: <b6b8ee26c56ef0c28d1efe1c54218c4d7090bd98.1362863832.git.mschiffer@universe-factory.net>
References: <b6b8ee26c56ef0c28d1efe1c54218c4d7090bd98.1362863832.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCHv5 1/2] batman-adv: split
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
To: b.a.t.m.a.n@lists.open-mesh.org

Previously batadv_is_wifi_iface() did two things at once: looking up a
net_device from an interface index, and determining if it is a wifi device.

The second part is useful itself when the caller already has a net_device
reference.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 hard-interface.c | 73 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index fd99e42..333a504 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -117,6 +117,47 @@ static int batadv_is_valid_iface(const struct net_device *net_dev)
 	return 1;
 }
 
+/* This function returns true if the net device is a 802.11 wireless device */
+static bool batadv_is_wifi_net_device(struct net_device *net_device)
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
+/* This function returns true if the interface represented by ifindex is a
+ * 802.11 wireless device
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
+	ret = batadv_is_wifi_net_device(net_device);
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
@@ -631,38 +672,6 @@ out:
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

