Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 19 May 2014 21:53:18 +0200
Message-Id: <1400529201-31500-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv4 0/3] Export the expected throughput towards
	a peer
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
Cc: devel@lists.open80211s.org, b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org, Antonio Quartulli <antonio@meshcoding.com>

Changes since v3:
- squash patch 1 and 2
- in 3/3 change mac_addr from u8 * to const u8 * (both in the new
  cfg80211_get_station and in the already existing rdev_get_station)
- add type and unit for NL80211_STA_EXPECTED_THROUGHPUT

Changes since v2:
- fix throughput computation in minstrel
- squash minstrel patches

Changes since v1:
- add expected throughput nl80211 attribute to the GET_STATION reply
  message
- the unit of the exported value has been changed to kbps
- the way the exported value was computed in minstrel and minstrel_ht has been
  changed after having really understood what minstrel is doing (thanks
  Johannes!)
- the number of arguments of the RC api have been reduced
- allow the API result to be 0 if the underlying layer does not know what to
  report
- squash ex patch 2/3/4
- use wiphy_to_rdev() where needed


Antonio Quartulli (3):
  cfg80211: export expected throughput through get_station()
  mac80211: export the expected throughput
  cfg80211: implement cfg80211_get_station cfg80211 API

 include/net/cfg80211.h             | 75 ++++++++++++++++++++++++--------------
 include/net/mac80211.h             |  7 ++++
 include/uapi/linux/nl80211.h       |  3 ++
 net/mac80211/cfg.c                 | 19 ++++++++++
 net/mac80211/driver-ops.h          | 13 +++++++
 net/mac80211/rc80211_minstrel.c    | 12 ++++++
 net/mac80211/rc80211_minstrel_ht.c | 17 +++++++++
 net/mac80211/trace.h               | 32 ++++++++++++++++
 net/wireless/nl80211.c             |  4 ++
 net/wireless/rdev-ops.h            |  2 +-
 net/wireless/util.c                | 18 +++++++++
 11 files changed, 173 insertions(+), 29 deletions(-)

-- 
1.8.5.5

