Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/5] pull request for net-next: batman-adv 2020-08-24
Date: Mon, 24 Aug 2020 18:27:36 +0200
Message-Id: <20200824162741.880-1-sw@simonwunderlich.de>
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

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bb=
f5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-2020=
0824

for you to fetch changes up to 0093870aa891594d170e1dc9aa192a30d530d755:

  batman-adv: Migrate to linux/prandom.h (2020-08-18 19:39:54 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Drop unused function batadv_hardif_remove_interfaces(),
   by Sven Eckelmann

 - delete duplicated words, by Randy Dunlap

 - Drop (even more) repeated words in comments, by Sven Eckelmann

 - Migrate to linux/prandom.h, by Sven Eckelmann

----------------------------------------------------------------
Randy Dunlap (1):
      batman-adv: types.h: delete duplicated words

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (3):
      batman-adv: Drop unused function batadv_hardif_remove_interfaces()
      batman-adv: Drop repeated words in comments
      batman-adv: Migrate to linux/prandom.h

 net/batman-adv/bat_iv_ogm.c            |  1 +
 net/batman-adv/bat_v_elp.c             |  1 +
 net/batman-adv/bat_v_ogm.c             |  1 +
 net/batman-adv/bridge_loop_avoidance.c |  2 +-
 net/batman-adv/fragmentation.c         |  2 +-
 net/batman-adv/hard-interface.c        | 19 +------------------
 net/batman-adv/hard-interface.h        |  1 -
 net/batman-adv/main.c                  |  1 -
 net/batman-adv/main.h                  |  2 +-
 net/batman-adv/multicast.c             |  2 +-
 net/batman-adv/network-coding.c        |  4 ++--
 net/batman-adv/send.c                  |  2 +-
 net/batman-adv/soft-interface.c        |  4 ++--
 net/batman-adv/types.h                 |  4 ++--
 14 files changed, 15 insertions(+), 31 deletions(-)
