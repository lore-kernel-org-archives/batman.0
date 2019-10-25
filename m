Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/2] pull request for net: batman-adv 2019-10-25
Date: Fri, 25 Oct 2019 11:22:14 +0200
Message-Id: <20191025092216.12791-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

here are two bugfixes which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20191025

for you to fetch changes up to 40e220b4218bb3d278e5e8cc04ccdfd1c7ff8307:

  batman-adv: Avoid free/alloc race when handling OGM buffer (2019-10-13 21:00:07 +0200)

----------------------------------------------------------------
Here are two batman-adv bugfixes:

 * Fix free/alloc race for OGM and OGMv2, by Sven Eckelmann (2 patches)

----------------------------------------------------------------
Sven Eckelmann (2):
      batman-adv: Avoid free/alloc race when handling OGM2 buffer
      batman-adv: Avoid free/alloc race when handling OGM buffer

 net/batman-adv/bat_iv_ogm.c     | 61 +++++++++++++++++++++++++++++++++++------
 net/batman-adv/bat_v_ogm.c      | 41 +++++++++++++++++++++------
 net/batman-adv/hard-interface.c |  2 ++
 net/batman-adv/types.h          |  7 +++++
 4 files changed, 94 insertions(+), 17 deletions(-)
