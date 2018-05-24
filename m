Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 24 May 2018 14:02:52 +0200
Message-Id: <20180524120300.15829-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/8] pull request for net-next: batman-adv
 2017-05-24
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

here is a our feature/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-20180524

for you to fetch changes up to 18cfb44cf1845d11d50f4733e039acb8b377c8eb:

  batman-adv: enable B.A.T.M.A.N. V compilation by default (2018-05-14 09:31:17 +0200)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Disable batman-adv debugfs by default, by Sven Eckelmann

 - Improve handling mesh nodes with multicast optimizations disabled,
   by Linus Luessing

 - Avoid bool in structs, by Sven Eckelmann

 - Allocate less memory when debugfs is disabled, by Sven Eckelmann

 - Fix batadv_interface_tx return data type, by Luc Van Oostenryck

 - improve link speed handling for virtual interfaces, by Marek Lindner

 - Enable BATMAN V algorithm by default, by Marek Lindner

----------------------------------------------------------------
Linus Lüssing (1):
      batman-adv: Avoid old nodes disabling multicast optimizations completely

Luc Van Oostenryck (1):
      batman-adv: fix batadv_interface_tx()'s return type

Marek Lindner (2):
      batman-adv: disable ethtool link speed detection when auto negotiation off
      batman-adv: enable B.A.T.M.A.N. V compilation by default

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (3):
      batman-adv: Disable CONFIG_BATMAN_ADV_DEBUGFS by default
      batman-adv: Avoid bool in structures
      batman-adv: Remove unused dentry without DEBUGFS

 net/batman-adv/Kconfig          |  6 +++---
 net/batman-adv/bat_v_elp.c      | 15 ++++++++++++++-
 net/batman-adv/main.h           |  2 +-
 net/batman-adv/multicast.c      | 29 ++++++-----------------------
 net/batman-adv/soft-interface.c |  5 ++---
 net/batman-adv/types.h          | 23 +++++++++++++----------
 6 files changed, 39 insertions(+), 41 deletions(-)
