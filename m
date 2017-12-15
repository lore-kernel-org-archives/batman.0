Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 15 Dec 2017 12:43:00 +0100
Message-Id: <20171215114320.13645-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 00/20] pull request for net-next: batman-adv
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

here is a feature/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-20171215

for you to fetch changes up to 74027aab7f808eca71521b61d55fc06e040ec89e:

  batman-adv: Add kernel-doc to externally visible functions (2017-12-04 13:22:25 +0100)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - de-inline hash functions to save memory footprint, by Denys Vlasenko

 - Add License information to various files, by Sven Eckelmann (4 patches)

 - Change batman_adv.h from ISC to MIT, by Sven Eckelmann

 - Improve various includes, by Sven Eckelmann (5 patches)

 - Lots of kernel-doc work by Sven Eckelmann (8 patches)

----------------------------------------------------------------
Denys Vlasenko (1):
      batman-adv: Deinline batadv_orig_hash_find, save 7339 bytes

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (18):
      batman-adv: Add License-Filename to GPL-2.0 files
      batman-adv: Add SPDX license identifier above copyright header
      batman-adv: Add SPDX license identifier to batman-adv.rst
      batman-adv: Add license header to Kconfig
      batman-adv: Change batman_adv.h license to MIT
      batman-adv: include gfp.h for GFP_* defines
      batman-adv: include build_bug.h for BUILD_BUG_ON define
      batman-adv: Include net.h for net_ratelimited_function
      batman-adv: include kobject.h for kobject_* functions
      batman-adv: Remove unused sched.h include
      batman-adv: Add missing kernel-doc to packet.h
      batman-adv: Use parentheses in function kernel-doc
      batman-adv: Use inline kernel-doc for enum/struct
      batman-adv: Fix kernel-doc references to struct members
      batman-adv: Add kernel-doc to structs in headers
      batman-adv: Add kernel-doc to enums in headers
      batman-adv: Add kernel-doc to functions in headers
      batman-adv: Add kernel-doc to externally visible functions

 Documentation/networking/batman-adv.rst |    2 +
 compat-include/linux/build_bug.h        |   34 +
 include/uapi/linux/batman_adv.h         |   27 +-
 net/batman-adv/Kconfig                  |   19 +
 net/batman-adv/Makefile                 |    3 +-
 net/batman-adv/bat_algo.c               |   37 +-
 net/batman-adv/bat_algo.h               |    3 +
 net/batman-adv/bat_iv_ogm.c             |  107 +-
 net/batman-adv/bat_iv_ogm.h             |    3 +
 net/batman-adv/bat_v.c                  |   51 +-
 net/batman-adv/bat_v.h                  |    3 +
 net/batman-adv/bat_v_elp.c              |   29 +-
 net/batman-adv/bat_v_elp.h              |    3 +
 net/batman-adv/bat_v_ogm.c              |   39 +-
 net/batman-adv/bat_v_ogm.h              |    3 +
 net/batman-adv/bitarray.c               |    5 +-
 net/batman-adv/bitarray.h               |   12 +-
 net/batman-adv/bridge_loop_avoidance.c  |  114 +-
 net/batman-adv/bridge_loop_avoidance.h  |    7 +-
 net/batman-adv/debugfs.c                |   32 +-
 net/batman-adv/debugfs.h                |    3 +
 net/batman-adv/distributed-arp-table.c  |   82 +-
 net/batman-adv/distributed-arp-table.h  |    9 +-
 net/batman-adv/fragmentation.c          |   25 +-
 net/batman-adv/fragmentation.h          |    5 +-
 net/batman-adv/gateway_client.c         |   67 +-
 net/batman-adv/gateway_client.h         |    3 +
 net/batman-adv/gateway_common.c         |   30 +-
 net/batman-adv/gateway_common.h         |    8 +-
 net/batman-adv/hard-interface.c         |   67 +-
 net/batman-adv/hard-interface.h         |   61 +-
 net/batman-adv/hash.c                   |   22 +-
 net/batman-adv/hash.h                   |   30 +-
 net/batman-adv/icmp_socket.c            |   17 +-
 net/batman-adv/icmp_socket.h            |    3 +
 net/batman-adv/log.c                    |   21 +
 net/batman-adv/log.h                    |   64 +-
 net/batman-adv/main.c                   |   54 +-
 net/batman-adv/main.h                   |  125 +-
 net/batman-adv/multicast.c              |   83 +-
 net/batman-adv/multicast.h              |   19 +-
 net/batman-adv/netlink.c                |   27 +-
 net/batman-adv/netlink.h                |    3 +
 net/batman-adv/network-coding.c         |  126 +-
 net/batman-adv/network-coding.h         |    3 +
 net/batman-adv/originator.c             |  156 ++-
 net/batman-adv/originator.h             |   49 +-
 net/batman-adv/packet.h                 |   28 +-
 net/batman-adv/routing.c                |   56 +-
 net/batman-adv/routing.h                |    3 +
 net/batman-adv/send.c                   |   68 +-
 net/batman-adv/send.h                   |    7 +-
 net/batman-adv/soft-interface.c         |   66 +-
 net/batman-adv/soft-interface.h         |    3 +
 net/batman-adv/sysfs.c                  |   58 +-
 net/batman-adv/sysfs.h                  |   16 +
 net/batman-adv/tp_meter.c               |   77 +-
 net/batman-adv/tp_meter.h               |    3 +
 net/batman-adv/translation-table.c      |  234 ++--
 net/batman-adv/translation-table.h      |    3 +
 net/batman-adv/tvlv.c                   |   43 +-
 net/batman-adv/tvlv.h                   |    3 +
 net/batman-adv/types.h                  | 1995 +++++++++++++++++++++----------
 63 files changed, 3005 insertions(+), 1353 deletions(-)
 create mode 100644 compat-include/linux/build_bug.h
