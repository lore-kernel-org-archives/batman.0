Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sun, 15 May 2016 23:11:29 +0800
Message-Id: <1463325093-3927-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] pull request [net]: batman-adv 20160515
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

although we are extremely late in the release cycle we have 4 fixes
which would really be worth merging before releasing linux-4.6.

As you can read in the git tag below, each of them can lead to a
kernel crash or to an unstable system.

We came up with several fixes after having tested our new B.A.T.M.A.N. V
code at the Wireless Battle Mesh in Porto (PT) at the beginning of the month,
however, what I am sending here is the minimum subset that we though being
extremely important to avoid easy kernel crashes. The change footprint is
also rather small.


Please pull or let me know if you rather prefer to get this through net-next.

If you decide to pull, you will hit some conflicts when merging net into
net-next, but I can send you some instructions to ease the process.


Thanks a lot!
	Antonio


The following changes since commit b91506586206140154b0b44cccf88c8cc0a4dca5:

  Merge branch 'xgene-fixes' (2016-05-13 21:12:07 -0400)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to 6b892c1cb0805acee5d4ddd9e7878ed076c1b7c7:

  batman-adv: Fix refcnt leak in batadv_v_neigh_* (2016-05-14 15:51:39 +0800)

----------------------------------------------------------------
During the Wireless Battle Mesh v9 in Porto (PT) at the beginning of
May, we managed to uncover and fix some important bugs in our
new B.A.T.M.A.N. V algorithm. These are the most critical fixes we
came up with aimed to avoid easy kernel crashes:
- avoid potential crash due to NULL pointer dereference in
  B.A.T.M.A.N. V routine when a neigh_ifinfo object is not found, by
  Sven Eckelmann
- avoid crash due to double kref_put on neigh_node object in
  B.A.T.M.A.N. V routine leading to use-after-free, by Sven
  Eckelmann (this crash can be always replicated)
- avoid use-after-free of skb when counting outgoing bytes, by Florian
  Westphal
- fix neigh_ifinfo object reference counting imbalance when using
  B.A.T.M.A.N. V, by Sven Eckelmann. Such imbalance may lead to the
  impossibility of releasing the related netdev object on shutdown.

----------------------------------------------------------------
Florian Westphal (1):
      batman-adv: fix skb deref after free

Sven Eckelmann (3):
      batman-adv: Avoid nullptr derefence in batadv_v_neigh_is_sob
      batman-adv: Fix double neigh_node_put in batadv_v_ogm_route_update
      batman-adv: Fix refcnt leak in batadv_v_neigh_*

 net/batman-adv/bat_v.c     | 30 ++++++++++++++++++++++++++----
 net/batman-adv/bat_v_ogm.c |  4 +++-
 net/batman-adv/routing.c   |  4 +++-
 3 files changed, 32 insertions(+), 6 deletions(-)
