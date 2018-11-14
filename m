Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Nov 2018 15:07:48 +0100
Message-Id: <20181114140804.18381-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 00/16] pull request for net-next: batman-adv
 2018-11-14
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

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-20181114

for you to fetch changes up to 016fd285682952b943641c074d1cc0d02b3e6889:

  batman-adv: enable MCAST by default at compile time (2018-11-12 10:41:51 +0100)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - Bump version strings, by Simon Wunderlich

 - Fixup includes, by Sven Eckelmann (3 patches)

 - Separate BATMAN_ADV_DEBUG from DEBUGFS, by Sven Eckelmann

 - Fixup tracing log documentation, by Sven Eckelmann

 - Use exclusive locks to secure netlink information dump transfers,
   by Sven Eckelmann (8 patches)

 - Move CRC16 dependency, by Sven Eckelmann

 - Enable MCAST by default, by Linus Luessing

----------------------------------------------------------------
Linus Lüssing (1):
      batman-adv: enable MCAST by default at compile time

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (14):
      batman-adv: Drop unused lockdep include
      batman-adv: Add includes for deprecation warning
      batman-adv: Improve includes for trace functionality
      batman-adv: Allow to use BATMAN_ADV_DEBUG without BATMAN_ADV_DEBUGFS
      batman-adv: Fix description for BATMAN_ADV_DEBUG
      batman-adv: Add inconsistent gateway netlink dump detection
      batman-adv: Add inconsistent hardif netlink dump detection
      batman-adv: Store modification counter via hash helpers
      batman-adv: Add inconsistent backbone netlink dump detection
      batman-adv: Add inconsistent claim netlink dump detection
      batman-adv: Add inconsistent dat netlink dump detection
      batman-adv: Add inconsistent local TT netlink dump detection
      batman-adv: Add inconsistent multicast netlink dump detection
      batman-adv: Move CRC16 dependency to BATMAN_ADV_BLA

 net/batman-adv/Kconfig                 | 10 +++--
 net/batman-adv/bat_iv_ogm.c            | 25 ++++++-----
 net/batman-adv/bat_v.c                 | 26 +++++++----
 net/batman-adv/bridge_loop_avoidance.c | 82 +++++++++++++++++++---------------
 net/batman-adv/debugfs.c               |  2 +
 net/batman-adv/distributed-arp-table.c | 42 +++++++++--------
 net/batman-adv/gateway_client.c        |  3 ++
 net/batman-adv/hard-interface.c        |  3 ++
 net/batman-adv/hash.c                  |  2 +
 net/batman-adv/hash.h                  |  6 +++
 net/batman-adv/log.c                   | 60 ++++++++++++++-----------
 net/batman-adv/main.c                  |  3 ++
 net/batman-adv/main.h                  |  3 +-
 net/batman-adv/multicast.c             | 51 +++++++++++----------
 net/batman-adv/netlink.c               | 24 +++++-----
 net/batman-adv/trace.c                 |  2 -
 net/batman-adv/trace.h                 |  6 +++
 net/batman-adv/translation-table.c     | 41 +++++++++--------
 net/batman-adv/types.h                 |  5 ++-
 19 files changed, 236 insertions(+), 160 deletions(-)
