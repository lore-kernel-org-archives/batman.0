Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 16 Dec 2015 15:49:21 +0800
Message-Id: <1450252173-20949-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 20151216
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hello David,

here you have our batch of patches intended for net-next.

Marek Lindner is introducing a list of direct neighbours per interface
and is exporting it via debugfs. This comes very handy in case of
network debugging or simple topology analysis.

Add lock protection for CRC computation in the Bridge Loop Avoidance
code to prevent racy updates, by Simon Wunderlich.

Update my email address in the relevant files.

Other than those changes you also have some code restyling, cleanups
and minor fixes..


Please pull or let me know of any problem!

Thanks a lot,
	Antonio


The following changes since commit 5833e0526820c3216de8ae60661fb307c89c8710:

  net/macb: add support for resetting PHY using GPIO (2015-12-14 22:04:12 -0500)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to 5a1dd8a4773d4c24e925cc6154826d555a85c370:

  batman-adv: lock crc access in bridge loop avoidance (2015-12-16 15:17:09 +0800)

----------------------------------------------------------------
Included changes:
- change my email in MAINTAINERS and Doc files
- create and export list of single hop neighs per interface
- protect CRC in the BLA code by means of its own lock
- minor fixes and code cleanups

----------------------------------------------------------------
Antonio Quartulli (2):
      MAINTAINERS: update email address
      Doc: update email address

Marek Lindner (4):
      batman-adv: add list of unique single hop neighbors per hard-interface
      batman-adv: add bat_hardif_neigh_init algo ops call
      batman-adv: export single hop neighbor list via debugfs
      batman-adv: update last seen field of single hop originators

Simon Wunderlich (4):
      batman-adv: rename equiv/equal or better to similar or better
      batman-adv: detect local excess vlans in TT request
      batman-adv: unify flags access style in tt global add
      batman-adv: lock crc access in bridge loop avoidance

Sven Eckelmann (2):
      batman-adv: Use chain pointer when purging fragments
      batman-adv: Fix typo 'wether' -> 'whether'

 Documentation/ABI/testing/sysfs-class-net-mesh |   4 +-
 MAINTAINERS                                    |   2 +-
 net/batman-adv/bat_iv_ogm.c                    |  71 ++++++++-
 net/batman-adv/bridge_loop_avoidance.c         |  35 ++++-
 net/batman-adv/debugfs.c                       |   9 ++
 net/batman-adv/fragmentation.c                 |   8 +-
 net/batman-adv/hard-interface.c                |   4 +
 net/batman-adv/main.c                          |   6 +-
 net/batman-adv/originator.c                    | 195 +++++++++++++++++++++++++
 net/batman-adv/originator.h                    |   7 +
 net/batman-adv/routing.c                       |   6 +-
 net/batman-adv/translation-table.c             |  16 +-
 net/batman-adv/types.h                         |  34 ++++-
 13 files changed, 370 insertions(+), 27 deletions(-)

