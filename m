Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  6 Jun 2018 07:39:51 +0200
Message-Id: <20180606053951.5314-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: Initialize memory for
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

batadv_v_elp_get_throughput is calling cfg80211_get_station with a pointer
(sinfo) to some uninitialized memory on the stack. But most of the
implementations behind cfg80211_get_station will not initialize sinfo to
zero before manipulating it. For example, the member
&struct station_info.filled is often only modified by using a read (of
possibly uninitialized/random memory), an OR operation and then a write of
the new value back to the original memory address. A caller without a
preinitialized &struct station_info.filled can then no longer decide which
parts of sinfo were filled in by cfg80211_get_station.

The caller of cfg80211_get_station must therefore take care that sinfo (or
at least sinfo.filled) is initialized to zero. Otherwise, the caller may
tries to read information which was not filled in and is therefore also
uninitialized. In batadv_v_elp_get_throughput's case, an invalid "random"
expected throughput may be saved for this neighbor and thus the B.A.T.M.A.N
V algorithm may switch to non-optimal neighbors for certain destinations.

Fixes: 5c3245172c01 ("batman-adv: ELP - compute the metric based on the estimated throughput")
Reported-by: Thomas Lauer <holminateur@gmail.com>
Reported-by: Marcel Schmidt <ff.z-casparistrasse@mailbox.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
v2:

* rewrite commit message

 net/batman-adv/bat_v_elp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 28687493..846316ea 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -102,6 +102,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 		if (!real_netdev)
 			goto default_throughput;
 
+		memset(&sinfo, 0, sizeof(sinfo));
 		ret = cfg80211_get_station(real_netdev, neigh->addr, &sinfo);
 
 		dev_put(real_netdev);
-- 
2.17.1

