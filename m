Return-Path: <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.539889814@decadent.org.uk>
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
Subject: [B.A.T.M.A.N.] [PATCH 3.16 142/366] cfg80211: initialize sinfo in
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
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: akpm@linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Marcel Schmidt <ff.z-casparistrasse@mailbox.org>, Johannes Berg <johannes@sipsolutions.net>, Thomas Lauer <holminateur@gmail.com>

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 3c12d0486856b9eb89c2a9ac336713cba90813e3 upstream.

Most of the implementations behind cfg80211_get_station will not initialize
sinfo to zero before manipulating it. For example, the member "filled",
which indicates the filled in parts of this struct, is often only modified
by enabling certain bits in the bitfield while keeping the remaining bits
in their original state. A caller without a preinitialized sinfo.filled can
then no longer decide which parts of sinfo were filled in by
cfg80211_get_station (or actually the underlying implementations).

cfg80211_get_station must therefore take care that sinfo is initialized to
zero. Otherwise, the caller may tries to read information which was not
filled in and which must therefore also be considered uninitialized. In
batadv_v_elp_get_throughput's case, an invalid "random" expected throughput
may be stored for this neighbor and thus the B.A.T.M.A.N V algorithm may
switch to non-optimal neighbors for certain destinations.

Fixes: 7406353d43c8 ("cfg80211: implement cfg80211_get_station cfg80211 API")
Reported-by: Thomas Lauer <holminateur@gmail.com>
Reported-by: Marcel Schmidt <ff.z-casparistrasse@mailbox.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/wireless/util.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1566,6 +1566,8 @@ int cfg80211_get_station(struct net_devi
 	if (!rdev->ops->get_station)
 		return -EOPNOTSUPP;
 
+	memset(sinfo, 0, sizeof(*sinfo));
+
 	return rdev_get_station(rdev, dev, mac_addr, sinfo);
 }
 EXPORT_SYMBOL(cfg80211_get_station);

