Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 13 Mar 2013 23:56:30 +0100
Message-Id: <1363215399-18875-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2013-03-13
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

here you have our first patchset intended for net-next/linux-3.10.

These patches include a new big component implementing a first version of
Network Coding for mesh networks. This code is the result of Martin Hundebøll
and Jeppe Ledet-Pedersen's Master Thesis[1]. The target of Network Coding is to
increase throughput by fusing multiple packets in one wifi transmission (thus
saving airtime).
This new component also introduced a new Kbuild option which can be used to
decide whether to include this feature or not. However, a switch to dynamically
turn off the behaviour at runtime has been provided too. DebugFS has also been
extended with some knobs to be used in case of debugging only.

The rest is clean up work.

Please pull or let me know if there is any problem!

Thank you,
	Antonio


[1] http://downloads.open-mesh.org/batman/papers/batman-adv_network_coding.pdf

The following changes since commit 7f02d1601cf05ce79fde78cb9b9bc2e375f87126:

  qlcnic: Bump up the version to 5.1.37 (2013-03-13 05:35:05 -0400)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to 2df5278b0267c799f3e877e8eeddbb6e93cda0bb:

  batman-adv: network coding - receive coded packets and decode them (2013-03-13 22:53:51 +0100)

----------------------------------------------------------------
Included changes:
- introduction of the new Network Coding component. This new mechanism aims to
  increase throughput by fusing multiple packets in one transmission.
- minor cleanups

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: don't use !! in bool conversion

Marek Lindner (1):
      batman-adv: replace redundant primary_if_get calls

Martin Hundebøll (7):
      batman-adv: Return reason for failure in batadv_check_unicast_packet()
      batman-adv: network coding - add the initial infrastructure code
      batman-adv: network coding - detect coding nodes and remove these after timeout
      batman-adv: network coding - buffer unicast packets before forward
      batman-adv: network coding - code and transmit packets if possible
      batman-adv: network coding - save overheard and tx packets for decoding
      batman-adv: network coding - receive coded packets and decode them

 Documentation/ABI/testing/sysfs-class-net-mesh |    8 +
 net/batman-adv/Kconfig                         |   14 +
 net/batman-adv/Makefile                        |    1 +
 net/batman-adv/bat_iv_ogm.c                    |    5 +
 net/batman-adv/debugfs.c                       |   18 +
 net/batman-adv/distributed-arp-table.c         |   22 +-
 net/batman-adv/main.c                          |    6 +
 net/batman-adv/main.h                          |   12 +-
 net/batman-adv/network-coding.c                | 1821 ++++++++++++++++++++++++
 net/batman-adv/network-coding.h                |  123 ++
 net/batman-adv/originator.c                    |    6 +
 net/batman-adv/packet.h                        |   33 +
 net/batman-adv/routing.c                       |   49 +-
 net/batman-adv/send.c                          |    5 +
 net/batman-adv/soft-interface.c                |   14 +
 net/batman-adv/sysfs.c                         |   16 +-
 net/batman-adv/translation-table.c             |   29 +-
 net/batman-adv/types.h                         |  136 ++
 net/batman-adv/unicast.c                       |    6 +-
 19 files changed, 2259 insertions(+), 65 deletions(-)
 create mode 100644 net/batman-adv/network-coding.c
 create mode 100644 net/batman-adv/network-coding.h

