Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 17 May 2014 18:41:46 +0200
Message-Id: <1400344906-27984-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1400344906-27984-1-git-send-email-antonio@meshcoding.com>
References: <1400344906-27984-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv3 4/4] cfg80211: implement
	cfg80211_get_station cfg80211 API
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: devel@lists.open80211s.org, b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Implement and export the new cfg80211_get_station() API.
This utility can be used by other kernel modules to obtain
detailed information about a given wireless station.

It will be in particular useful to batman-adv which will
implement a wireless rate based metric.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 include/net/cfg80211.h | 13 +++++++++++++
 net/wireless/util.c    | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 394189e..5917919 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1075,6 +1075,19 @@ struct station_info {
 };
 
 /**
+ * cfg80211_get_station - retrieve information about a given station
+ * @dev: the device where the station is supposed to be connected to
+ * @mac_addr: the mac address of the station of interest
+ * @sinfo: pointer to the structure to fill with the information
+ *
+ * Returns 0 on success and sinfo is filled with the available information
+ * otherwise returns a negative error code and the content of sinfo has to be
+ * considered undefined.
+ */
+int cfg80211_get_station(struct net_device *dev, u8 *mac_addr,
+			 struct station_info *sinfo);
+
+/**
  * enum monitor_flags - monitor flags
  *
  * Monitor interface configuration flags. Note that these must be the bits
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 8c61d5c..6380e55 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1545,6 +1545,24 @@ unsigned int ieee80211_get_num_supported_channels(struct wiphy *wiphy)
 }
 EXPORT_SYMBOL(ieee80211_get_num_supported_channels);
 
+int cfg80211_get_station(struct net_device *dev, u8 *mac_addr,
+			 struct station_info *sinfo)
+{
+	struct cfg80211_registered_device *rdev;
+	struct wireless_dev *wdev;
+
+	wdev = dev->ieee80211_ptr;
+	if (!wdev)
+		return -EOPNOTSUPP;
+
+	rdev = wiphy_to_rdev(wdev->wiphy);
+	if (!rdev->ops->get_station)
+		return -EOPNOTSUPP;
+
+	return rdev_get_station(rdev, dev, mac_addr, sinfo);
+}
+EXPORT_SYMBOL(cfg80211_get_station);
+
 /* See IEEE 802.1H for LLC/SNAP encapsulation/decapsulation */
 /* Ethernet-II snap header (RFC1042 for most EtherTypes) */
 const unsigned char rfc1042_header[] __aligned(2) =
-- 
1.8.5.5

