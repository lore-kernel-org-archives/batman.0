Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 17 Jul 2018 17:26:42 +0200
Message-Id: <20180717152649.32282-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 0/7] pull request for net-next: batman-adv
 2018-07-17
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

here is a little cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-20180717

for you to fetch changes up to 993a4a5f7cd3aef53be3953d11f86b2d3630ebb8:

  batman-adv: Convert batadv_dat_addr_t to proper type (2018-07-08 12:56:38 +0200)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - Don't call BATMAN_V experimental in Kconfig anymore, by Sven Eckelmann

 - Enable DAT by default at compile time, by Antonio Quartulli

 - Remove obsolete default n in Kconfig, by Sven Eckelmann

 - Fix checkpatch spelling errors, by Sven Eckelmann

 - Unify header guards style, by Sven Eckelmann

 - Consolidate batadv_purge_orig functions, by Sven Eckelmann

 - Replace type define with proper typedef, by Sven Eckelmann

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: enable DAT by default at compile time

Sven Eckelmann (6):
      batman-adv: Drop "experimental" from BATMAN_V Kconfig
      batman-adv: Remove "default n" in Kconfig
      batman-adv: fix checkpatch warning about misspelled "cache"
      batman-adv: Unify include guards style
      batman-adv: Join batadv_purge_orig_ref and _batadv_purge_orig
      batman-adv: Convert batadv_dat_addr_t to proper type

 net/batman-adv/Kconfig      |  8 ++------
 net/batman-adv/bat_iv_ogm.h |  6 +++---
 net/batman-adv/bat_v_ogm.h  |  6 +++---
 net/batman-adv/debugfs.c    |  2 +-
 net/batman-adv/originator.c | 17 ++++++-----------
 net/batman-adv/types.h      |  7 ++++---
 6 files changed, 19 insertions(+), 27 deletions(-)
