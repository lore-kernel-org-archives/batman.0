Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/2] pull request for net: batman-adv 2019-08-08
Date: Thu,  8 Aug 2019 15:02:06 +0200
Message-Id: <20190808130208.2124-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

here are some bugfixes which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20190808

for you to fetch changes up to f7af86ccf1882084293b11077deec049fd01da63:

  batman-adv: Fix deletion of RTR(4|6) mcast list entries (2019-07-22 21:34:58 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - Fix netlink dumping of all mcast_flags buckets, by Sven Eckelmann

 - Fix deletion of RTR(4|6) mcast list entries, by Sven Eckelmann

----------------------------------------------------------------
Sven Eckelmann (2):
      batman-adv: Fix netlink dumping of all mcast_flags buckets
      batman-adv: Fix deletion of RTR(4|6) mcast list entries

 net/batman-adv/multicast.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
