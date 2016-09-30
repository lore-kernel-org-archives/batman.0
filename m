Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Fri, 30 Sep 2016 15:21:05 +0200
Message-Id: <20160930132106.5798-6-sven.eckelmann@open-mesh.com>
In-Reply-To: <2666783.nl87Kib46y@bentobox>
References: <2666783.nl87Kib46y@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v2 6/7] batman-adv: retrieve B.A.T.M.A.N. V
	WiFi neighbor stats from real interface
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

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
[sven.eckelmann@open-mesh.com: re-add batadv_get_real_netdev to take rtnl
 semaphore for batadv_get_real_netdevice]
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
v2:
 - reintroduce batadv_get_real_netdev for situations were the rtnl_lock
   has to be taken
---
 net/batman-adv/bat_v_elp.c      | 10 ++++++++--
 net/batman-adv/hard-interface.c | 22 ++++++++++++++++++++++
 net/batman-adv/hard-interface.h |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index cdcaf6b..89488dc 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -75,6 +75,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
 	struct ethtool_link_ksettings link_settings;
+	struct net_device *real_netdev;
 	struct station_info sinfo;
 	u32 throughput;
 	int ret;
@@ -94,8 +95,13 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			/* unsupported WiFi driver version */
 			goto default_throughput;
 
-		ret = cfg80211_get_station(hard_iface->net_dev,
-					   neigh->addr, &sinfo);
+		real_netdev = batadv_get_real_netdev(hard_iface->net_dev);
+		if (!real_netdev)
+			goto default_throughput;
+
+		ret = cfg80211_get_station(real_netdev, neigh->addr, &sinfo);
+
+		dev_put(real_netdev);
 		if (ret == -ENOENT) {
 			/* Node is not associated anymore! It would be
 			 * possible to delete this neighbor. For now set
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index ba587fb..7d336e1 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -206,6 +206,9 @@ static bool batadv_is_valid_iface(const struct net_device *net_dev)
  *  interface on top of another 'real' interface
  * @netdev: the device to check
  *
+ * Callers must hold the rtnl semaphore. You may want batadv_get_real_netdev()
+ * instead of this.
+ *
  * Return: the 'real' net device or the original net device and NULL in case
  *  of an error.
  */
@@ -243,6 +246,25 @@ out:
 }
 
 /**
+ * batadv_get_real_netdev - check if the given net_device struct is a virtual
+ *  interface on top of another 'real' interface
+ * @net_device: the device to check
+ *
+ * Return: the 'real' net device or the original net device and NULL in case
+ *  of an error.
+ */
+struct net_device *batadv_get_real_netdev(struct net_device *net_device)
+{
+	struct net_device *real_netdev = NULL;
+
+	rtnl_lock();
+	real_netdev = batadv_get_real_netdevice(net_device);
+	rtnl_unlock();
+
+	return real_netdev;
+}
+
+/**
  * batadv_is_wext_netdev - check if the given net_device struct is a
  *  wext wifi interface
  * @net_device: the device to check
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 957fd8f..0c7ff14 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -51,6 +51,7 @@ enum batadv_hard_if_cleanup {
 
 extern struct notifier_block batadv_hard_if_notifier;
 
+struct net_device *batadv_get_real_netdev(struct net_device *net_device);
 bool batadv_is_cfg80211_hardif(struct batadv_hard_iface *hard_iface);
 bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface);
 struct batadv_hard_iface*
-- 
2.9.3

