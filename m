Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/1] pull request for net: batman-adv 2019-08-21
Date: Wed, 21 Aug 2019 15:30:14 +0200
Message-Id: <20190821133015.12778-1-sw@simonwunderlich.de>
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

here is a pull request with Erics bugfix from last week which we would
like to have integrated into net. We didn't get anything else, so it's
a short one this time. :)

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit f7af86ccf1882084293b11077deec049fd01da63:

  batman-adv: Fix deletion of RTR(4|6) mcast list entries (2019-07-22 21:34:58 +0200)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20190821

for you to fetch changes up to 3ee1bb7aae97324ec9078da1f00cb2176919563f:

  batman-adv: fix uninit-value in batadv_netlink_get_ifindex() (2019-08-14 19:27:07 +0200)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - fix uninit-value in batadv_netlink_get_ifindex(), by Eric Dumazet

----------------------------------------------------------------
Eric Dumazet (1):
      batman-adv: fix uninit-value in batadv_netlink_get_ifindex()

 net/batman-adv/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
