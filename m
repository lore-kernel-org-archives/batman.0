Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 28 Mar 2019 16:31:22 +0100
Message-Id: <20190328153127.19931-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/5] pull request for net: batman-adv
 2019-03-28
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

here are some bugfixes which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit ffa91253739ca89fc997195d8bbd1f7ba3e29fbe:

  Documentation: networking: Update netdev-FAQ regarding patches (2019-03-18 20:09:58 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20190328

for you to fetch changes up to 438b3d3fae4346a49fe12fa7cc1dc9327f006a91:

  batman-adv: Fix genl notification for throughput_override (2019-03-25 09:31:19 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - Fix refcount underflows in bridge loop avoidance code,
   by Sven Eckelmann (3 patches)

 - Fix warning when CFG80211 isn't enabled, by Anders Roxell

 - Fix genl notification for throughput override, by Sven Eckelmann

----------------------------------------------------------------
Anders Roxell (1):
      batman-adv: fix warning in function batadv_v_elp_get_throughput

Sven Eckelmann (4):
      batman-adv: Reduce claim hash refcnt only for removed entry
      batman-adv: Reduce tt_local hash refcnt only for removed entry
      batman-adv: Reduce tt_global hash refcnt only for removed entry
      batman-adv: Fix genl notification for throughput_override

 net/batman-adv/bat_v_elp.c             |  6 ++++--
 net/batman-adv/bridge_loop_avoidance.c | 16 +++++++++++++---
 net/batman-adv/sysfs.c                 |  7 +++++--
 net/batman-adv/translation-table.c     | 32 ++++++++++++++++++++++++--------
 4 files changed, 46 insertions(+), 15 deletions(-)
