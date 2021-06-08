Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 00/11] pull request for net-next: batman-adv 2021-06-08
Date: Tue,  8 Jun 2021 17:26:49 +0200
Message-Id: <20210608152700.30315-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi Jakub, hi David,

here is a feature/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 30515832e987597eae354f6ffcdb3374bdfde1=
6d:

  net: bridge: fix build when IPv6 is disabled (2021-05-14 10:38:59 -0700=
)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20=
210608

for you to fetch changes up to 020577f879be736bc87e1f48dfad7220923401c0:

  batman-adv: Drop reduntant batadv interface check (2021-06-02 22:25:45 =
+0200)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - consistently send iface index/name in genlmsg, by Sven Eckelmann

 - improve broadcast queueing, by Linus L=C3=BCssing (2 patches)

 - add support for routable IPv4 multicast with bridged setups,
   by Linus L=C3=BCssing

 - remove repeated declarations, by Shaokun Zhang

 - fix spelling mistakes, by Zheng Yongjun

 - clean up hard interface handling after dropping sysfs support,
   by Sven Eckelmann (4 patches)

----------------------------------------------------------------
Linus L=C3=BCssing (3):
      batman-adv: bcast: queue per interface, if needed
      batman-adv: bcast: avoid skb-copy for (re)queued broadcasts
      batman-adv: mcast: add MRD + routable IPv4 multicast with bridges s=
upport

Shaokun Zhang (1):
      batman-adv: Remove the repeated declaration

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (5):
      batman-adv: Always send iface index+name in genlmsg
      batman-adv: Drop implicit creation of batadv net_devices
      batman-adv: Avoid name based attaching of hard interfaces
      batman-adv: Don't manually reattach hard-interface
      batman-adv: Drop reduntant batadv interface check

Zheng Yongjun (1):
      batman-adv: Fix spelling mistakes

 net/batman-adv/bat_iv_ogm.c            |   6 +
 net/batman-adv/bat_v.c                 |  10 +
 net/batman-adv/bridge_loop_avoidance.c |   4 +-
 net/batman-adv/bridge_loop_avoidance.h |   1 -
 net/batman-adv/hard-interface.c        |  65 +-----
 net/batman-adv/hard-interface.h        |   3 +-
 net/batman-adv/hash.h                  |   2 +-
 net/batman-adv/main.h                  |   3 +-
 net/batman-adv/multicast.c             |  41 +---
 net/batman-adv/netlink.c               |   8 +
 net/batman-adv/routing.c               |   9 +-
 net/batman-adv/send.c                  | 374 ++++++++++++++++++++++-----=
------
 net/batman-adv/send.h                  |  12 +-
 net/batman-adv/soft-interface.c        |  49 +----
 net/batman-adv/soft-interface.h        |   2 -
 15 files changed, 310 insertions(+), 279 deletions(-)
