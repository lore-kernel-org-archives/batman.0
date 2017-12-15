Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 15 Dec 2017 12:31:39 +0100
Message-Id: <20171215113143.12852-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 0/4] pull request for net: batman-adv
 2017-12-15
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>

Hi David,

here are a couple of fixes which we would like to see integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20171215

for you to fetch changes up to 5ba7dcfe77037b67016263ea597a8b431692ecab:

  batman-adv: Fix lock for ogm cnt access in batadv_iv_ogm_calc_tq (2017-12-04 11:47:33 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - Initialize the fragment headers, by Sven Eckelmann

 - Fix a NULL check in BATMAN V, by Sven Eckelmann

 - Fix kernel doc for the time_setup() change, by Sven Eckelmann

 - Use the right lock in BATMAN IV OGM Update, by Sven Eckelmann

----------------------------------------------------------------
Sven Eckelmann (4):
      batman-adv: Always initialize fragment header priority
      batman-adv: Fix check of retrieved orig_gw in batadv_v_gw_is_eligible
      batman-adv: Fix kernel-doc for timer functions
      batman-adv: Fix lock for ogm cnt access in batadv_iv_ogm_calc_tq

 net/batman-adv/bat_iv_ogm.c    | 4 ++--
 net/batman-adv/bat_v.c         | 2 +-
 net/batman-adv/fragmentation.c | 2 ++
 net/batman-adv/tp_meter.c      | 4 ++--
 4 files changed, 7 insertions(+), 5 deletions(-)
