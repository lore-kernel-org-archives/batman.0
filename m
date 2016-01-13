Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Thu, 14 Jan 2016 01:51:52 +0800
Message-Id: <1452707514-5091-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] pull request [net]: batman-adv 20160114
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hello David,

these are two small fixes intended for your net tree.

Patch 1 prevents a lockdep splat from appearing along the
shutdown path due to a missing lock in mcast_free(), by Simon Wunderlich.

Patch 2 fixes a new feature introduced in 4.5 by ensuring that a
batadv_hardif_neigh_node object is free'd only when it is no
longer used in any context, by Sven Eckelmann.

Please pull or let me know of any issue.
Thanks a lot,
	Antonio

The following changes since commit f1640c3ddeec12804bc9a21feee85fc15aca95f6:

  bgmac: fix a missing check for build_skb (2016-01-13 00:24:14 -0500)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to bab7c6c3deac70966a3000402c0ea6d0c20edd15:

  batman-adv: Fix list removal of batadv_hardif_neigh_node (2016-01-13 19:28:27 +0800)

----------------------------------------------------------------
Included bugfixes:
- avoid freeing batadv_hardif_neigh_node when still in use in other contexts
- prevent lockdep splat in mcast_free during shutdown

----------------------------------------------------------------
Simon Wunderlich (1):
      batman-adv: fix lockdep splat when doing mcast_free

Sven Eckelmann (1):
      batman-adv: Fix list removal of batadv_hardif_neigh_node

 net/batman-adv/multicast.c  |  2 ++
 net/batman-adv/originator.c | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

