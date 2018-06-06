Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  6 Jun 2018 10:47:02 +0200
Message-Id: <20180606084702.19825-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] cfg80211: initialize sinfo.filled in
 cfg80211_get_station
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
Cc: linux-wireless@vger.kernel.org, Matthias Fritzsche <txt.file@txtfile.eu>, Thomas Lauer <holminateur@gmail.com>, Marcel Schmidt <ff.z-casparistrasse@mailbox.org>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

Most of the implementations behind cfg80211_get_station will not initialize
sinfo to zero before manipulating it. The member "filled", which indicates
the filled in parts of this struct, is often only modified by enabling
certain bits in the bitfield while keeping the remaining bits in their
original state. A caller without a preinitialized sinfo.filled can then no
longer decide which parts of sinfo were filled in by cfg80211_get_station
(or actually the underlying implementations).

cfg80211_get_station must therefore take care that sinfo.filled is
initialized to zero. Otherwise, the caller may tries to read information
which was not filled in and which must therefore also be considered
uninitialized. In batadv_v_elp_get_throughput's case, an invalid "random"
expected throughput may be stored for this neighbor and thus the
B.A.T.M.A.N V algorithm may switch to non-optimal neighbors for certain
destinations.

Fixes: 7406353d43c8 ("cfg80211: implement cfg80211_get_station cfg80211 API")
Reported-by: Thomas Lauer <holminateur@gmail.com>
Reported-by: Marcel Schmidt <ff.z-casparistrasse@mailbox.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Matthias, you may want to take care that this is integrated in your
firmware.
---
 net/wireless/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index b5bb1c309914..cd6a695d1230 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1746,6 +1746,8 @@ int cfg80211_get_station(struct net_device *dev, const u8 *mac_addr,
 	if (!rdev->ops->get_station)
 		return -EOPNOTSUPP;
 
+	sinfo->filled = 0;
+
 	return rdev_get_station(rdev, dev, mac_addr, sinfo);
 }
 EXPORT_SYMBOL(cfg80211_get_station);
-- 
2.11.0

