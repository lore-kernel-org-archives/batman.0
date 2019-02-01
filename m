Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  1 Feb 2019 12:14:12 +0100
Message-Id: <20190201111412.13807-4-sw@simonwunderlich.de>
In-Reply-To: <20190201111412.13807-1-sw@simonwunderlich.de>
References: <20190201111412.13807-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: release station info tidstats
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Felix Fietkau <nbd@nbd.name>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

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
[sven@narfation.org: add commit message]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index e8090f099eb8..ef0dec20c7d8 100644
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

