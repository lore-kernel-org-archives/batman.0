Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jun 2018 20:31:31 +0200
Message-Id: <20180605183131.4989-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Initialize memory for
 station_info
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
Cc: Sven Eckelmann <sven@narfation.org>, Thomas Lauer <holminateur@gmail.com>, Marcel Schmidt <ff.z-casparistrasse@mailbox.org>

cfg80211_get_station is not initializing the memory given as parameter
sinfo. The caller has to handle it. Otherwise the filled parameter may be
set incorrectly and thus uninitialized memory is used to identify the
throughput to an neighbor.

Fixes: 5c3245172c01 ("batman-adv: ELP - compute the metric based on the estimated throughput")
Reported-by: Thomas Lauer <holminateur@gmail.com>
Reported-by: Marcel Schmidt <ff.z-casparistrasse@mailbox.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---

Cc: Thomas Lauer <holminateur@gmail.com>
Cc: Marcel Schmidt <ff.z-casparistrasse@mailbox.org>

 net/batman-adv/bat_v_elp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 71c20c1d..5f931475 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -102,6 +102,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 		if (!real_netdev)
 			goto default_throughput;
 
+		memset(&sinfo, 0, sizeof(sinfo));
 		ret = cfg80211_get_station(real_netdev, neigh->addr, &sinfo);
 
 		dev_put(real_netdev);
-- 
2.11.0

