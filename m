Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 19 Aug 2016 22:02:48 +0200
Message-Id: <20160819200248.8202-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] cfg80211: Add stub for cfg80211_get_station()
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>

This allows modules using this function (currently: batman-adv) to
compile even if cfg80211 is not built at all, thus relaxing
dependencies.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/net/cfg80211.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9c23f4d3..beb7610 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1102,6 +1102,7 @@ struct station_info {
 	struct cfg80211_tid_stats pertid[IEEE80211_NUM_TIDS + 1];
 };
 
+#if IS_ENABLED(CONFIG_CFG80211)
 /**
  * cfg80211_get_station - retrieve information about a given station
  * @dev: the device where the station is supposed to be connected to
@@ -1114,6 +1115,14 @@ struct station_info {
  */
 int cfg80211_get_station(struct net_device *dev, const u8 *mac_addr,
 			 struct station_info *sinfo);
+#else
+static inline int cfg80211_get_station(struct net_device *dev,
+				       const u8 *mac_addr,
+				       struct station_info *sinfo)
+{
+	return -ENOENT;
+}
+#endif
 
 /**
  * enum monitor_flags - monitor flags
-- 
2.1.4

