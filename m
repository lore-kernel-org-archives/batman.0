Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 28 Mar 2019 16:41:40 +0100
Message-Id: <20190328154152.20552-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 00/12] pull request for net-next: batman-adv
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

here is our latest cleanup/feature pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit ffa91253739ca89fc997195d8bbd1f7ba3e29fbe:

  Documentation: networking: Update netdev-FAQ regarding patches (2019-03-18 20:09:58 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-20190328

for you to fetch changes up to 32e727449c792b689c2a06a8b4cc9fef6270c5a7:

  batman-adv: Add multicast-to-unicast support for multiple targets (2019-03-25 10:01:13 +0100)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - Drop license boilerplate (obsoleted by SPDX license IDs),
   by Sven Eckelmann

 - Drop documentation for sysfs and debugfs Documentation,
   by Sven Eckelmann (2 patches)

 - Mark sysfs as optional and deprecated, by Sven Eckelmann (3 patches)

 - Update MAINTAINERS Tree, Chat and Bugtracker,
   by Sven Eckelmann (3 patches)

 - Rename batadv_dat_send_data, by Sven Eckelmann

 - update DAT entries with incoming ARP replies, by Linus Luessing

 - add multicast-to-unicast support for limited destinations,
   by Linus Luessing

----------------------------------------------------------------
Linus Lüssing (2):
      batman-adv: allow updating DAT entry timeouts on incoming ARP Replies
      batman-adv: Add multicast-to-unicast support for multiple targets

Sven Eckelmann (10):
      batman-adv: Drop license boilerplate
      batman-adv: Drop documentation about debugfs files
      batman-adv: Drop documentation about sysfs files
      batman-adv: Make sysfs support optional
      batman-adv: ABI: Mark sysfs files as deprecated
      batman-adv: Warn about sysfs file access
      MAINTAINERS: Add B(ugtracker) field for batman-adv
      MAINTAINERS: Add C(hat) field for batman-adv
      MAINTAINERS: Add T(ree) field for batman-adv
      batman-adv: Adjust name for batadv_dat_send_data

 .../sysfs-class-net-batman-adv                     |   2 +
 .../ABI/{testing => obsolete}/sysfs-class-net-mesh |   2 +
 Documentation/networking/batman-adv.rst            | 110 +++--------
 MAINTAINERS                                        |   7 +-
 include/uapi/linux/batadv_packet.h                 |  12 --
 include/uapi/linux/batman_adv.h                    |  25 +--
 net/batman-adv/Kconfig                             |  24 +--
 net/batman-adv/Makefile                            |  15 +-
 net/batman-adv/bat_algo.c                          |  12 --
 net/batman-adv/bat_algo.h                          |  12 --
 net/batman-adv/bat_iv_ogm.c                        |  12 --
 net/batman-adv/bat_iv_ogm.h                        |  12 --
 net/batman-adv/bat_v.c                             |  12 --
 net/batman-adv/bat_v.h                             |  12 --
 net/batman-adv/bat_v_elp.c                         |  12 --
 net/batman-adv/bat_v_elp.h                         |  12 --
 net/batman-adv/bat_v_ogm.c                         |  12 --
 net/batman-adv/bat_v_ogm.h                         |  12 --
 net/batman-adv/bitarray.c                          |  12 --
 net/batman-adv/bitarray.h                          |  12 --
 net/batman-adv/bridge_loop_avoidance.c             |  13 --
 net/batman-adv/bridge_loop_avoidance.h             |  12 --
 net/batman-adv/debugfs.c                           |  12 --
 net/batman-adv/debugfs.h                           |  12 --
 net/batman-adv/distributed-arp-table.c             |  40 ++--
 net/batman-adv/distributed-arp-table.h             |  12 --
 net/batman-adv/fragmentation.c                     |  12 --
 net/batman-adv/fragmentation.h                     |  12 --
 net/batman-adv/gateway_client.c                    |  13 --
 net/batman-adv/gateway_client.h                    |  12 --
 net/batman-adv/gateway_common.c                    |  12 --
 net/batman-adv/gateway_common.h                    |  12 --
 net/batman-adv/hard-interface.c                    |  12 --
 net/batman-adv/hard-interface.h                    |  12 --
 net/batman-adv/hash.c                              |  12 --
 net/batman-adv/hash.h                              |  12 --
 net/batman-adv/icmp_socket.c                       |  12 --
 net/batman-adv/icmp_socket.h                       |  12 --
 net/batman-adv/log.c                               |  12 --
 net/batman-adv/log.h                               |  12 --
 net/batman-adv/main.c                              |  85 +++++++--
 net/batman-adv/main.h                              |  14 +-
 net/batman-adv/multicast.c                         | 211 +++++++++++++++++++--
 net/batman-adv/multicast.h                         |  30 +--
 net/batman-adv/netlink.c                           |  23 ++-
 net/batman-adv/netlink.h                           |  12 --
 net/batman-adv/network-coding.c                    |  12 --
 net/batman-adv/network-coding.h                    |  12 --
 net/batman-adv/originator.c                        |  12 --
 net/batman-adv/originator.h                        |  12 --
 net/batman-adv/routing.c                           |  12 --
 net/batman-adv/routing.h                           |  12 --
 net/batman-adv/send.c                              |  12 --
 net/batman-adv/send.h                              |  12 --
 net/batman-adv/soft-interface.c                    |  20 +-
 net/batman-adv/soft-interface.h                    |  12 --
 net/batman-adv/sysfs.c                             | 128 +++++--------
 net/batman-adv/sysfs.h                             |  50 +++--
 net/batman-adv/tp_meter.c                          |  12 --
 net/batman-adv/tp_meter.h                          |  12 --
 net/batman-adv/trace.c                             |  12 --
 net/batman-adv/trace.h                             |  12 --
 net/batman-adv/translation-table.c                 |  17 +-
 net/batman-adv/translation-table.h                 |  16 +-
 net/batman-adv/tvlv.c                              |  12 --
 net/batman-adv/tvlv.h                              |  12 --
 net/batman-adv/types.h                             |  18 +-
 67 files changed, 476 insertions(+), 939 deletions(-)
 rename Documentation/ABI/{testing => obsolete}/sysfs-class-net-batman-adv (92%)
 rename Documentation/ABI/{testing => obsolete}/sysfs-class-net-mesh (97%)
