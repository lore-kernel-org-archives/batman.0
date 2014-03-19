Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 19 Mar 2014 11:33:02 +0100
Message-Id: <1395225186-18597-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-maint 0/3] fix multiif regressions
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

There are some regressions introduced my network wide multi interface
optimization patchset which are adressed by this patchset. All of them
fix some kind of leaks caused reference counter imbalances, which may
lead to problems when an interface is removed which was previously used
by batman-adv.

Thanks Antonio for your help tracking that down!

Cheers,
	Simon

Simon Wunderlich (3):
  batman-adv: fix neigh_ifinfo imbalance
  batman-adv: fix neigh reference imbalance
  batman-adv: always run purge_orig_neighbors

 bat_iv_ogm.c |    2 ++
 originator.c |    7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
1.7.10.4

