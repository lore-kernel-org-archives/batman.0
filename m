Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 Oct 2017 17:37:01 +0200
Message-Id: <20171023153704.32120-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 0/3] pull request for net-next: batman-adv
 2017-10-23
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

here is another small documentation/cleanup pull request of batman-adv to go
into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 4bc4e64c2cfdafa6b8ecdcc5edf10cc1a147587f:

  Merge tag 'batadv-next-for-davem-20171006' of git://git.open-mesh.org/linux-merge (2017-10-06 10:12:52 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-20171023

for you to fetch changes up to 40b16b9be5773a314948656c96adf7bf7cfdbd0b:

  batman-adv: use inline kernel-doc for uapi constants (2017-10-23 14:22:25 +0200)

----------------------------------------------------------------
This documentation/cleanup patchset includes the following patches:

 - Fix parameter kerneldoc which caused kerneldoc warnings, by Sven Eckelmann

 - Remove spurious warnings in B.A.T.M.A.N. V neighbor comparison,
   by Sven Eckelmann

 - Use inline kernel-doc style for UAPI constants, by Sven Eckelmann

----------------------------------------------------------------
Sven Eckelmann (3):
      batman-adv: Add missing kerneldoc for extack
      batman-adv: Avoid spurious warnings from bat_v neigh_cmp implementation
      batman-adv: use inline kernel-doc for uapi constants

 include/uapi/linux/batman_adv.h | 369 +++++++++++++++++++++++++++++++---------
 net/batman-adv/bat_v.c          |   9 +-
 net/batman-adv/soft-interface.c |   1 +
 3 files changed, 295 insertions(+), 84 deletions(-)
