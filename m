Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat,  7 Apr 2012 20:49:42 +0200
Message-Id: <1333824598-27771-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2012-04-07
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hello,

this is the updated and cleaned up version of our last pull request (sent on
2012-04-05).

In this patchset I fixed the two problems you told me about (comments ending
with */ not on a newline and usage of "func(...)" instead of static inline
ones).

In patch 14 I also changed the type of "stp_addr[ETH_ALEN]" from "uint8_t" to
"static const uint8_t" (as suggested by Bernd Petrovitsch).


Thank you,
	Antonio


The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to 369a2792da3265eae09cf10e09bcaf95ceb521e5:

  batman-adv: add bridge loop avoidance compile option (2012-04-07 12:54:52 +0200)

----------------------------------------------------------------
Included changes:
* add my name to the maintainers list of batman-adv
* some clean up fixes
* increases the default hop-penalty in order to encourage the routing protocol
  to choose shorter routes
* renew the bridge loop avoidance mechanism

The latter mechanism was already present in batman-adv but recently the concept
has been discussed again and here comes the new implementation. Moreover we
added a compile option in order to let expert people, which think that this
mechanism is not helpful at all, disable it and save some space.

----------------------------------------------------------------
Antonio Quartulli (3):
      MAINTAINERS: add additional maintainer for net/batman-adv
      batman-adv: clean up Kconfig
      batman-adv: use ETH_ALEN instead of hardcoded numeric constants

Marek Lindner (1):
      batman-adv: encourage batman to take shorter routes by changing the default hop penalty

Simon Wunderlich (10):
      batman-adv: remove old bridge loop avoidance code
      batman-adv: add basic bridge loop avoidance code
      batman-adv: make bridge loop avoidance switchable
      batman-adv: export claim tables through debugfs
      batman-adv: allow multiple entries in tt_global_entries
      batman-adv: don't let backbone gateways exchange tt entries
      batman-adv: add broadcast duplicate check
      batman-adv: drop STP over batman
      batman-adv: form groups in the bridge loop avoidance
      batman-adv: add bridge loop avoidance compile option

Sven Eckelmann (2):
      batman-adv: Replace bitarray operations with bitmap
      batman-adv: Remove declaration of only locally used functions

 Documentation/ABI/testing/sysfs-class-net-mesh |    9 +
 Documentation/networking/batman-adv.txt        |   19 +-
 MAINTAINERS                                    |    1 +
 net/batman-adv/Kconfig                         |   27 +-
 net/batman-adv/Makefile                        |    1 +
 net/batman-adv/bat_debugfs.c                   |   19 +-
 net/batman-adv/bat_iv_ogm.c                    |   15 +-
 net/batman-adv/bat_sysfs.c                     |    8 +-
 net/batman-adv/bitarray.c                      |  118 +-
 net/batman-adv/bitarray.h                      |   26 +-
 net/batman-adv/bridge_loop_avoidance.c         | 1583 ++++++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.h         |   98 ++
 net/batman-adv/hard-interface.c                |   18 +-
 net/batman-adv/main.c                          |    9 +-
 net/batman-adv/main.h                          |   11 +-
 net/batman-adv/originator.c                    |    3 +-
 net/batman-adv/packet.h                        |   43 +-
 net/batman-adv/routing.c                       |   29 +-
 net/batman-adv/routing.h                       |    1 -
 net/batman-adv/soft-interface.c                |  498 +-------
 net/batman-adv/soft-interface.h                |    2 -
 net/batman-adv/translation-table.c             |  435 +++++--
 net/batman-adv/translation-table.h             |    8 -
 net/batman-adv/types.h                         |   77 +-
 24 files changed, 2263 insertions(+), 795 deletions(-)
 create mode 100644 net/batman-adv/bridge_loop_avoidance.c
 create mode 100644 net/batman-adv/bridge_loop_avoidance.h

