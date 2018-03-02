Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  2 Mar 2018 18:57:40 +0100
Message-Id: <20180302175745.12551-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 0/5] pull request for net-next: batman-adv
 2018-03-02
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

here is a little cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-20180302

for you to fetch changes up to a163dc22d515d17844435c8217ff66193d35b3fa:

  batman-adv: always assume 2-byte packet alignment (2018-02-27 13:02:54 +0100)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - bump copyright years, by Sven Eckelmann

 - fix macro indendation for checkpatch, by Sven Eckelmann

 - fix comparison operator for bool returning functions,
   by Sven Eckelmann

 - assume 2-byte packet alignments for all packet types,
   by Matthias Schiffer

----------------------------------------------------------------
Matthias Schiffer (1):
      batman-adv: always assume 2-byte packet alignment

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (3):
      batman-adv: Update copyright years for 2018
      batman-adv: Fix indentation of batadv_seq_before
      batman-adv: Avoid relation operator comparison with bool

 include/uapi/linux/batadv_packet.h     | 15 +++------------
 include/uapi/linux/batman_adv.h        |  2 +-
 net/batman-adv/Kconfig                 |  2 +-
 net/batman-adv/Makefile                |  2 +-
 net/batman-adv/bat_algo.c              |  2 +-
 net/batman-adv/bat_algo.h              |  2 +-
 net/batman-adv/bat_iv_ogm.c            |  2 +-
 net/batman-adv/bat_iv_ogm.h            |  2 +-
 net/batman-adv/bat_v.c                 |  2 +-
 net/batman-adv/bat_v.h                 |  2 +-
 net/batman-adv/bat_v_elp.c             |  2 +-
 net/batman-adv/bat_v_elp.h             |  2 +-
 net/batman-adv/bat_v_ogm.c             |  2 +-
 net/batman-adv/bat_v_ogm.h             |  2 +-
 net/batman-adv/bitarray.c              |  2 +-
 net/batman-adv/bitarray.h              |  2 +-
 net/batman-adv/bridge_loop_avoidance.c |  2 +-
 net/batman-adv/bridge_loop_avoidance.h |  2 +-
 net/batman-adv/debugfs.c               |  2 +-
 net/batman-adv/debugfs.h               |  2 +-
 net/batman-adv/distributed-arp-table.c |  4 ++--
 net/batman-adv/distributed-arp-table.h |  2 +-
 net/batman-adv/fragmentation.c         |  2 +-
 net/batman-adv/fragmentation.h         |  2 +-
 net/batman-adv/gateway_client.c        |  2 +-
 net/batman-adv/gateway_client.h        |  2 +-
 net/batman-adv/gateway_common.c        |  2 +-
 net/batman-adv/gateway_common.h        |  2 +-
 net/batman-adv/hard-interface.c        |  2 +-
 net/batman-adv/hard-interface.h        |  2 +-
 net/batman-adv/hash.c                  |  2 +-
 net/batman-adv/hash.h                  |  2 +-
 net/batman-adv/icmp_socket.c           |  2 +-
 net/batman-adv/icmp_socket.h           |  2 +-
 net/batman-adv/log.c                   |  2 +-
 net/batman-adv/log.h                   |  2 +-
 net/batman-adv/main.c                  |  2 +-
 net/batman-adv/main.h                  | 16 +++++++++-------
 net/batman-adv/multicast.c             |  2 +-
 net/batman-adv/multicast.h             |  2 +-
 net/batman-adv/netlink.c               |  2 +-
 net/batman-adv/netlink.h               |  2 +-
 net/batman-adv/network-coding.c        |  2 +-
 net/batman-adv/network-coding.h        |  2 +-
 net/batman-adv/originator.c            |  2 +-
 net/batman-adv/originator.h            |  2 +-
 net/batman-adv/routing.c               |  2 +-
 net/batman-adv/routing.h               |  2 +-
 net/batman-adv/send.c                  |  2 +-
 net/batman-adv/send.h                  |  2 +-
 net/batman-adv/soft-interface.c        |  2 +-
 net/batman-adv/soft-interface.h        |  2 +-
 net/batman-adv/sysfs.c                 |  2 +-
 net/batman-adv/sysfs.h                 |  2 +-
 net/batman-adv/tp_meter.c              |  2 +-
 net/batman-adv/tp_meter.h              |  2 +-
 net/batman-adv/translation-table.c     |  2 +-
 net/batman-adv/translation-table.h     |  2 +-
 net/batman-adv/tvlv.c                  |  2 +-
 net/batman-adv/tvlv.h                  |  2 +-
 net/batman-adv/types.h                 |  2 +-
 61 files changed, 72 insertions(+), 79 deletions(-)
