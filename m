Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 13 Jun 2017 13:15:29 +0200
Message-Id: <20170613111531.29082-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 0/2] pull request for net: batman-adv
 2017-06-13
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

here are two batman-adv bugfixes for net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20170613

for you to fetch changes up to a1a745ef980a1b48299ead4ea7990e62c0516f6e:

  batman-adv: fix memory leak when dropping packet from other gateway (2017-05-19 12:20:28 +0200)

----------------------------------------------------------------
Here are two batman-adv bugfixes:

 - fix rx packet counters for local ARP replies, by Sven Eckelmann

 - fix memory leaks for unicast packetes received from another gateway
   in bridge loop avoidance, by Andreas Pape

----------------------------------------------------------------
Andreas Pape (1):
      batman-adv: fix memory leak when dropping packet from other gateway

Sven Eckelmann (1):
      batman-adv: Fix rx packet/bytes stats on local ARP reply

 net/batman-adv/distributed-arp-table.c | 5 +++--
 net/batman-adv/routing.c               | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)
