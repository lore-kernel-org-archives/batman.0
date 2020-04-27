Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/5] pull request for net-next: batman-adv 2020-04-27
Date: Mon, 27 Apr 2020 17:06:02 +0200
Message-Id: <20200427150607.31401-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi David,

here is a small cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f31=
36:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-2020=
0427

for you to fetch changes up to e73f94d1b6f05f6f22434c63de255a9dec6fd23d:

  batman-adv: remove unused inline function batadv_arp_change_timeout (20=
20-04-24 15:22:41 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - fix spelling error, by Sven Eckelmann

 - drop unneeded types.h include, by Sven Eckelmann

 - change random number generation to prandom_u32_max(),
   by Sven Eckelmann

 - remove unused function batadv_arp_change_timeout(), by Yue Haibing

----------------------------------------------------------------
Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (3):
      batman-adv: Fix spelling error in term buffer
      batman-adv: trace: Drop unneeded types.h include
      batman-adv: Utilize prandom_u32_max for random [0, max) values

YueHaibing (1):
      batman-adv: remove unused inline function batadv_arp_change_timeout

 net/batman-adv/bat_iv_ogm.c            | 4 ++--
 net/batman-adv/bat_v_elp.c             | 2 +-
 net/batman-adv/bat_v_ogm.c             | 4 ++--
 net/batman-adv/distributed-arp-table.h | 5 -----
 net/batman-adv/main.h                  | 2 +-
 net/batman-adv/trace.h                 | 1 -
 net/batman-adv/types.h                 | 2 +-
 7 files changed, 7 insertions(+), 13 deletions(-)
