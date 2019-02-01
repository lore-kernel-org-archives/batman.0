Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  1 Feb 2019 12:18:07 +0100
Message-Id: <20190201111810.14150-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/3] pull request for net-next: batman-adv
 2019-02-01
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

here is a small feature/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit b71acb0e372160167bf6d5500b88b30b52ccef6e:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2018-12-27 13:53:32 -0800)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-20190201

for you to fetch changes up to 7a79d717e0817610932ce3b7b6033ea06ee1d577:

  batman-adv: Update copyright years for 2019 (2019-01-04 11:04:24 +0100)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Add DHCPACKs for DAT snooping, by Linus Luessing

 - Update copyright years for 2019, by Sven Eckelmann

----------------------------------------------------------------
Linus Lüssing (1):
      batman-adv: Snoop DHCPACKs for DAT

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (1):
      batman-adv: Update copyright years for 2019

 include/uapi/linux/batadv_packet.h     |   2 +-
 include/uapi/linux/batman_adv.h        |   2 +-
 net/batman-adv/Kconfig                 |   2 +-
 net/batman-adv/Makefile                |   2 +-
 net/batman-adv/bat_algo.c              |   2 +-
 net/batman-adv/bat_algo.h              |   2 +-
 net/batman-adv/bat_iv_ogm.c            |   2 +-
 net/batman-adv/bat_iv_ogm.h            |   2 +-
 net/batman-adv/bat_v.c                 |   2 +-
 net/batman-adv/bat_v.h                 |   2 +-
 net/batman-adv/bat_v_elp.c             |   2 +-
 net/batman-adv/bat_v_elp.h             |   2 +-
 net/batman-adv/bat_v_ogm.c             |   2 +-
 net/batman-adv/bat_v_ogm.h             |   2 +-
 net/batman-adv/bitarray.c              |   2 +-
 net/batman-adv/bitarray.h              |   2 +-
 net/batman-adv/bridge_loop_avoidance.c |   2 +-
 net/batman-adv/bridge_loop_avoidance.h |   2 +-
 net/batman-adv/debugfs.c               |   2 +-
 net/batman-adv/debugfs.h               |   2 +-
 net/batman-adv/distributed-arp-table.c | 401 ++++++++++++++++++++++++++++++++-
 net/batman-adv/distributed-arp-table.h |  21 +-
 net/batman-adv/fragmentation.c         |   2 +-
 net/batman-adv/fragmentation.h         |   2 +-
 net/batman-adv/gateway_client.c        |   2 +-
 net/batman-adv/gateway_client.h        |   2 +-
 net/batman-adv/gateway_common.c        |   2 +-
 net/batman-adv/gateway_common.h        |   2 +-
 net/batman-adv/hard-interface.c        |   2 +-
 net/batman-adv/hard-interface.h        |   2 +-
 net/batman-adv/hash.c                  |   2 +-
 net/batman-adv/hash.h                  |   2 +-
 net/batman-adv/icmp_socket.c           |   2 +-
 net/batman-adv/icmp_socket.h           |   2 +-
 net/batman-adv/log.c                   |   2 +-
 net/batman-adv/log.h                   |   2 +-
 net/batman-adv/main.c                  |   2 +-
 net/batman-adv/main.h                  |   4 +-
 net/batman-adv/multicast.c             |   2 +-
 net/batman-adv/multicast.h             |   2 +-
 net/batman-adv/netlink.c               |   2 +-
 net/batman-adv/netlink.h               |   2 +-
 net/batman-adv/network-coding.c        |   2 +-
 net/batman-adv/network-coding.h        |   2 +-
 net/batman-adv/originator.c            |   2 +-
 net/batman-adv/originator.h            |   2 +-
 net/batman-adv/routing.c               |   6 +-
 net/batman-adv/routing.h               |   2 +-
 net/batman-adv/send.c                  |   2 +-
 net/batman-adv/send.h                  |   2 +-
 net/batman-adv/soft-interface.c        |  13 +-
 net/batman-adv/soft-interface.h        |   2 +-
 net/batman-adv/sysfs.c                 |   2 +-
 net/batman-adv/sysfs.h                 |   2 +-
 net/batman-adv/tp_meter.c              |   2 +-
 net/batman-adv/tp_meter.h              |   2 +-
 net/batman-adv/trace.c                 |   2 +-
 net/batman-adv/trace.h                 |   2 +-
 net/batman-adv/translation-table.c     |   2 +-
 net/batman-adv/translation-table.h     |   2 +-
 net/batman-adv/tvlv.c                  |   2 +-
 net/batman-adv/tvlv.h                  |   2 +-
 net/batman-adv/types.h                 |   2 +-
 63 files changed, 495 insertions(+), 66 deletions(-)
