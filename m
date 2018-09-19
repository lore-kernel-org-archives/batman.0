Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 19 Sep 2018 14:32:33 +0200
Message-Id: <20180919123238.23742-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 0/5] pull request for net-next: batman-adv
 2018-09-19
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

here is a little feature and cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-20180919

for you to fetch changes up to a7ea49afcc888dd5aac76774767bfb90be937aad:

  batman-adv: Enable LockLess TX for softif (2018-09-15 09:51:10 +0200)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Inform users about debugfs interface deprecation, by Sven Eckelmann

 - Implement tracing, planned to replace debugfs log messages,
   by Sven Eckelmann

 - Move OGM rebroadcasts to per interface struct, by Sven Eckelmann

 - Enable LockLess TX to increase throughput, by Sven Eckelmann

----------------------------------------------------------------
Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (4):
      batman-adv: Mark debugfs functionality as deprecated
      batman-adv: Provide debug messages as trace events
      batman-adv: Move OGM rebroadcast stats to orig_ifinfo
      batman-adv: Enable LockLess TX for softif

 net/batman-adv/Kconfig          |  11 ++
 net/batman-adv/Makefile         |   3 +
 net/batman-adv/bat_iv_ogm.c     | 330 ++++++++++++----------------------------
 net/batman-adv/debugfs.c        |  37 +++++
 net/batman-adv/debugfs.h        |   6 +
 net/batman-adv/hard-interface.c |  47 +++---
 net/batman-adv/icmp_socket.c    |   3 +
 net/batman-adv/log.c            |  20 ++-
 net/batman-adv/main.h           |   2 +-
 net/batman-adv/originator.c     | 107 -------------
 net/batman-adv/originator.h     |   4 -
 net/batman-adv/soft-interface.c |   2 +-
 net/batman-adv/trace.c          |  22 +++
 net/batman-adv/trace.h          |  78 ++++++++++
 net/batman-adv/types.h          |  62 +++-----
 15 files changed, 323 insertions(+), 411 deletions(-)
 create mode 100644 net/batman-adv/trace.c
 create mode 100644 net/batman-adv/trace.h
