Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 25 Jan 2019 09:02:05 +0100
Message-Id: <20190125080205.10594-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: release station info
 tidstats
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
Cc: Felix Fietkau <nbd@nbd.name>, Sven Eckelmann <sven@narfation.org>, Johannes Berg <johannes.berg@intel.com>, Arend van Spriel <aspriel@gmail.com>

From: Felix Fietkau <nbd@nbd.name>

With the addition of TXQ stats in the per-tid statistics the struct
station_info grew significantly. This resulted in stack size warnings
due to the structure itself being above the limit for the warnings.

To work around this, the TID array was allocated dynamically. Also a
function to free this content was introduced with commit 7ea3e110f2f8
("cfg80211: release station info tidstats where needed") but the necessary
changes were not provided for batman-adv's B.A.T.M.A.N. V implementation.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Fixes: 8689c051a201 ("cfg80211: dynamically allocate per-tid stats for station info")
[sven@narfation.org: add commit message, add compat code]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Arend van Spriel <aspriel@gmail.com>

Felix Fietkau didn't really send this patch to us and thus also didn't
signed it off. This is just a proposal how we could integrate it - please
inform me how we want to deal with it.

Thanks to Martin Weinelt for discovering this change and forwarding it to
us.
---
 compat-include/net/cfg80211.h | 7 +++++++
 net/batman-adv/bat_v_elp.c    | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/compat-include/net/cfg80211.h b/compat-include/net/cfg80211.h
index 79c028af..6b6a0287 100644
--- a/compat-include/net/cfg80211.h
+++ b/compat-include/net/cfg80211.h
@@ -79,4 +79,11 @@ static inline int batadv_cfg80211_get_station(struct net_device *dev,
 
 #endif /* < KERNEL_VERSION(4, 18, 0) && IS_ENABLED(CONFIG_CFG80211) */
 
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 18, 0)
+
+#define cfg80211_sinfo_release_content(sinfo)
+
+#endif /* < KERNEL_VERSION(4, 18, 0) */
+
 #endif	/* _NET_BATMAN_ADV_COMPAT_NET_CFG80211_H_ */
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index e8090f09..ef0dec20 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -104,6 +104,9 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 
 		ret = cfg80211_get_station(real_netdev, neigh->addr, &sinfo);
 
+		/* free the TID stats immediately */
+		cfg80211_sinfo_release_content(&sinfo);
+
 		dev_put(real_netdev);
 		if (ret == -ENOENT) {
 			/* Node is not associated anymore! It would be
-- 
2.11.0

