Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 30 Mar 2014 22:34:58 +0200
Message-Id: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFCv2 0/6] Export the expected throughput
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

The "Expected throughput" towards a generic wireless peer is
a value that can be used by other kernel components to
achieve different goals.
In particular we have 802.11s and batman-adv which will
iuse this estimation to compute their throughput based
metric. Therefore with this patchset I wanted to export
this result and make it available for future use.

Changes included in this patchset:
- add the new get_expected_throughput() RC API
- export the result of such API via cfg80211::get_station()
- implement the get_expected_throughput() RC API for minstrel(_ht)


For what concerns Minstrel_HT I decided to directly re-use the
throughput value computed by the algorithm itself with
minstrel_ht_calc_tp() for max_tp_rate.

For the legacy Minstrel instead I computed the expected
throughput as the product of the max_tp bitrate multplied
by its probability of success.


I am not entirely sure about passing sband as third parameter
to get_expected_throughput()..maybe somebody can suggest a
better solution.



Cheers,


Antonio Quartulli (6):
  cfg80211: export expected throughput through get_station()
  mac80211: add new RC API to retrieve expected throughput
  mac80211: export expected throughput in set_sta_info()
  mac80211: minstrel - implement get_expected_throughput() API
  mac80211: minstrel_ht - implement get_expected_throughput() API
  cfg80211: implement cfg80211_get_station cfg80211 API

 include/net/cfg80211.h             | 74 +++++++++++++++++++++++---------------
 include/net/mac80211.h             |  3 ++
 net/mac80211/cfg.c                 | 17 +++++++++
 net/mac80211/rc80211_minstrel.c    | 15 ++++++++
 net/mac80211/rc80211_minstrel_ht.c | 19 ++++++++++
 net/wireless/util.c                | 18 ++++++++++
 6 files changed, 118 insertions(+), 28 deletions(-)

-- 
1.8.3.2

