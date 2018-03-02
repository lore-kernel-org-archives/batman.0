Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  2 Mar 2018 18:51:35 +0100
Message-Id: <20180302175142.11838-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/7] pull request for net: batman-adv
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

here are some bugfixes which we would like to see integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20180302

for you to fetch changes up to f22e08932c2960f29b5e828e745c9f3fb7c1bb86:

  batman-adv: Fix internal interface indices types (2018-02-25 20:19:34 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - fix skb checksum issues, by Matthias Schiffer (2 patches)

 - fix exception handling when dumping data objects through netlink,
   by Sven Eckelmann (4 patches)

 - fix handling of interface indices, by Sven Eckelmann

----------------------------------------------------------------
Matthias Schiffer (2):
      batman-adv: fix packet checksum in receive path
      batman-adv: invalidate checksum on fragment reassembly

Sven Eckelmann (5):
      batman-adv: Ignore invalid batadv_iv_gw during netlink send
      batman-adv: Ignore invalid batadv_v_gw during netlink send
      batman-adv: Fix netlink dumping of BLA claims
      batman-adv: Fix netlink dumping of BLA backbones
      batman-adv: Fix internal interface indices types

 net/batman-adv/bat_iv_ogm.c            | 26 +++++++++++++++-----------
 net/batman-adv/bat_v.c                 |  2 +-
 net/batman-adv/bridge_loop_avoidance.c | 22 ++++++++++++++--------
 net/batman-adv/fragmentation.c         |  3 ++-
 net/batman-adv/hard-interface.c        |  9 +++++++--
 net/batman-adv/originator.c            |  4 ++--
 net/batman-adv/originator.h            |  4 ++--
 net/batman-adv/soft-interface.c        |  8 +-------
 net/batman-adv/types.h                 | 11 ++++++-----
 9 files changed, 50 insertions(+), 39 deletions(-)
