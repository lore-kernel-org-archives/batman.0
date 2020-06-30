Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/4] pull request for net-next: batman-adv 2020-06-26
Date: Tue, 30 Jun 2020 10:27:27 +0200
Message-Id: <20200630082731.2397-1-sw@simonwunderlich.de>
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi David,

here is a little feature/cleanup pull request of batman-adv to go into ne=
t-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c74=
07:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-2020=
0630

for you to fetch changes up to 3bda14d09dc5789a895ab02b7dcfcec19b0a65b3:

  batman-adv: Introduce a configurable per interface hop penalty (2020-06=
-26 10:37:11 +0200)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - update mailing list URL, by Sven Eckelmann

 - fix typos and grammar in documentation, by Sven Eckelmann

 - introduce a configurable per interface hop penalty,
   by Linus Luessing

----------------------------------------------------------------
Linus L=C3=BCssing (1):
      batman-adv: Introduce a configurable per interface hop penalty

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (2):
      batman-adv: Switch mailing list subscription page
      batman-adv: Fix typos and grammar in documentation

 Documentation/networking/batman-adv.rst |  8 +++---
 include/uapi/linux/batadv_packet.h      | 50 ++++++++++++++++-----------=
------
 include/uapi/linux/batman_adv.h         |  7 +++--
 net/batman-adv/bat_iv_ogm.c             | 25 +++++++++--------
 net/batman-adv/bat_v_elp.c              | 10 +++----
 net/batman-adv/bat_v_ogm.c              | 27 +++++++++++-------
 net/batman-adv/bridge_loop_avoidance.c  |  6 ++--
 net/batman-adv/distributed-arp-table.c  |  2 +-
 net/batman-adv/fragmentation.c          |  6 ++--
 net/batman-adv/hard-interface.c         | 16 ++++++-----
 net/batman-adv/log.h                    |  6 ++--
 net/batman-adv/main.c                   |  2 +-
 net/batman-adv/main.h                   |  8 +++---
 net/batman-adv/multicast.c              | 21 +++++++-------
 net/batman-adv/netlink.c                | 14 +++++++--
 net/batman-adv/network-coding.c         | 14 ++++-----
 net/batman-adv/originator.c             |  8 +++---
 net/batman-adv/routing.c                |  4 +--
 net/batman-adv/send.c                   |  4 +--
 net/batman-adv/soft-interface.c         |  2 +-
 net/batman-adv/tp_meter.c               | 12 ++++----
 net/batman-adv/translation-table.c      | 10 +++----
 net/batman-adv/tvlv.c                   |  4 +--
 net/batman-adv/types.h                  | 18 ++++++++----
 24 files changed, 156 insertions(+), 128 deletions(-)
