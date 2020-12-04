Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/8] pull request for net-next: batman-adv 2020-12-04
Date: Fri,  4 Dec 2020 16:46:23 +0100
Message-Id: <20201204154631.21063-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi David, hi Jakub,

here is a late cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 992b03b88e36254e26e9a4977ab948683e21bd=
9f:

  batman-adv: Don't always reallocate the fragmentation skb head (2020-11=
-27 08:02:55 +0100)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20=
201204

for you to fetch changes up to 34a14c2e6310a348a3f23af6e95bf9ea040f3ec8:

  batman-adv: Drop unused soft-interface.h include in fragmentation.c (20=
20-12-04 08:41:16 +0100)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - update include for min/max helpers, by Sven Eckelmann

 - add infrastructure and netlink functions for routing algo selection,
   by Sven Eckelmann (2 patches)

 - drop deprecated debugfs and sysfs support and obsoleted
   functionality, by Sven Eckelmann (3 patches)

 - drop unused include in fragmentation.c, by Simon Wunderlich

----------------------------------------------------------------
Simon Wunderlich (2):
      batman-adv: Start new development cycle
      batman-adv: Drop unused soft-interface.h include in fragmentation.c

Sven Eckelmann (6):
      batman-adv: Add new include for min/max helpers
      batman-adv: Prepare infrastructure for newlink settings
      batman-adv: Allow selection of routing algorithm over rtnetlink
      batman-adv: Drop deprecated sysfs support
      batman-adv: Drop deprecated debugfs support
      batman-adv: Drop legacy code for auto deleting mesh interfaces

 .../ABI/obsolete/sysfs-class-net-batman-adv        |   32 -
 Documentation/ABI/obsolete/sysfs-class-net-mesh    |  110 --
 MAINTAINERS                                        |    2 -
 include/uapi/linux/batman_adv.h                    |   26 +
 net/batman-adv/Kconfig                             |   27 +-
 net/batman-adv/Makefile                            |    3 -
 net/batman-adv/bat_algo.c                          |   34 +-
 net/batman-adv/bat_algo.h                          |    5 +-
 net/batman-adv/bat_iv_ogm.c                        |  229 ----
 net/batman-adv/bat_v.c                             |  247 +---
 net/batman-adv/bat_v_elp.c                         |    1 +
 net/batman-adv/bat_v_ogm.c                         |    1 +
 net/batman-adv/bridge_loop_avoidance.c             |  130 --
 net/batman-adv/bridge_loop_avoidance.h             |   16 -
 net/batman-adv/debugfs.c                           |  442 -------
 net/batman-adv/debugfs.h                           |   73 --
 net/batman-adv/distributed-arp-table.c             |   55 -
 net/batman-adv/distributed-arp-table.h             |    2 -
 net/batman-adv/fragmentation.c                     |    3 +-
 net/batman-adv/gateway_client.c                    |   39 -
 net/batman-adv/gateway_client.h                    |    2 -
 net/batman-adv/hard-interface.c                    |   35 +-
 net/batman-adv/hard-interface.h                    |   25 +-
 net/batman-adv/icmp_socket.c                       |  392 ------
 net/batman-adv/icmp_socket.h                       |   38 -
 net/batman-adv/log.c                               |  209 ----
 net/batman-adv/main.c                              |   46 +-
 net/batman-adv/main.h                              |    5 +-
 net/batman-adv/multicast.c                         |  111 --
 net/batman-adv/multicast.h                         |    3 -
 net/batman-adv/netlink.c                           |    1 +
 net/batman-adv/network-coding.c                    |   87 --
 net/batman-adv/network-coding.h                    |   13 -
 net/batman-adv/originator.c                        |  121 --
 net/batman-adv/originator.h                        |    4 -
 net/batman-adv/routing.c                           |   10 -
 net/batman-adv/soft-interface.c                    |  137 +--
 net/batman-adv/soft-interface.h                    |    1 -
 net/batman-adv/sysfs.c                             | 1272 --------------=
------
 net/batman-adv/sysfs.h                             |   93 --
 net/batman-adv/tp_meter.c                          |    1 +
 net/batman-adv/translation-table.c                 |  212 ----
 net/batman-adv/translation-table.h                 |    3 -
 net/batman-adv/types.h                             |   66 -
 44 files changed, 121 insertions(+), 4243 deletions(-)
 delete mode 100644 Documentation/ABI/obsolete/sysfs-class-net-batman-adv
 delete mode 100644 Documentation/ABI/obsolete/sysfs-class-net-mesh
 delete mode 100644 net/batman-adv/debugfs.c
 delete mode 100644 net/batman-adv/debugfs.h
 delete mode 100644 net/batman-adv/icmp_socket.c
 delete mode 100644 net/batman-adv/icmp_socket.h
 delete mode 100644 net/batman-adv/sysfs.c
 delete mode 100644 net/batman-adv/sysfs.h
