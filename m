Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 26 Mar 2014 15:46:20 +0100
Message-Id: <1395845184-15186-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-maintv3 0/4] fix multiif regressions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

There are some regressions introduced my network wide multi interface
optimization patchset which are adressed by this patchset. All of them
fix some kind of leaks caused reference counter imbalances, which may
lead to problems when an interface is removed which was previously used
by batman-adv.

The second series was only sent partially to the mailing list, and in
this third revision another bugfix was added and a sparse warning was
fixed.

Thanks Antonio for your help tracking that down!

Cheers,
        Simon

Simon Wunderlich (4):
  batman-adv: fix neigh_ifinfo imbalance
  batman-adv: fix neigh reference imbalance
  batman-adv: always run purge_orig_neighbors
  batman-adv: fix removing neigh_ifinfo

 bat_iv_ogm.c |    2 ++
 originator.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 4 deletions(-)

-- 
1.7.10.4

