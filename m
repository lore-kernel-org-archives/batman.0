Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Fri, 30 Sep 2016 15:21:02 +0200
Message-Id: <20160930132106.5798-3-sven.eckelmann@open-mesh.com>
In-Reply-To: <2666783.nl87Kib46y@bentobox>
References: <2666783.nl87Kib46y@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v2 3/7] batman-adv: refactor wifi interface
	detection
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

The ELP protocol requires cfg80211 to auto-detect the WiFi througput
to a given neighbor. Use batadv_is_cfg80211_netdev() to determine
whether or not an interface is eligible.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
v2:
 - rebased on top of current master
---
 net/batman-adv/bat_v_elp.c      | 29 ++++++++++++++---------------
 net/batman-adv/hard-interface.c | 26 +++++++++++++++++++++-----
 net/batman-adv/hard-interface.h |  1 +
 3 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index ee08540..b61ec79 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -90,22 +90,21 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	 * cfg80211 API
 	 */
 	if (batadv_is_wifi_netdev(hard_iface->net_dev)) {
-		if (hard_iface->net_dev->ieee80211_ptr) {
-			ret = cfg80211_get_station(hard_iface->net_dev,
-						   neigh->addr, &sinfo);
-			if (ret == -ENOENT) {
-				/* Node is not associated anymore! It would be
-				 * possible to delete this neighbor. For now set
-				 * the throughput metric to 0.
-				 */
-				return 0;
-			}
-			if (!ret)
-				return sinfo.expected_throughput / 100;
+		if (!batadv_is_cfg80211_netdev(hard_iface->net_dev))
+			/* unsupported WiFi driver version */
+			goto default_throughput;
+
+		ret = cfg80211_get_station(hard_iface->net_dev,
+					   neigh->addr, &sinfo);
+		if (ret == -ENOENT) {
+			/* Node is not associated anymore! It would be
+			 * possible to delete this neighbor. For now set
+			 * the throughput metric to 0.
+			 */
+			return 0;
 		}
-
-		/* unsupported WiFi driver version */
-		goto default_throughput;
+		if (!ret)
+			return sinfo.expected_throughput / 100;
 	}
 
 	/* if not a wifi interface, check if this device provides data via
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index a0b01cb..b09fec2 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -202,6 +202,26 @@ static bool batadv_is_valid_iface(const struct net_device *net_dev)
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
+	if (!net_device)
+		return false;
+
+	/* cfg80211 drivers have to set ieee80211_ptr */
+	if (net_device->ieee80211_ptr)
+		return true;
+
+	return false;
+}
+
+/**
  * batadv_is_wifi_netdev - check if the given net_device struct is a wifi
  *  interface
  * @net_device: the device to check
@@ -221,11 +241,7 @@ bool batadv_is_wifi_netdev(struct net_device *net_device)
 		return true;
 #endif
 
-	/* cfg80211 drivers have to set ieee80211_ptr */
-	if (net_device->ieee80211_ptr)
-		return true;
-
-	return false;
+	return batadv_is_cfg80211_netdev(net_device);
 }
 
 static struct batadv_hard_iface *
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index a76724d..e0893de 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -51,6 +51,7 @@ enum batadv_hard_if_cleanup {
 
 extern struct notifier_block batadv_hard_if_notifier;
 
+bool batadv_is_cfg80211_netdev(struct net_device *net_device);
 bool batadv_is_wifi_netdev(struct net_device *net_device);
 bool batadv_is_wifi_iface(int ifindex);
 struct batadv_hard_iface*
-- 
2.9.3

