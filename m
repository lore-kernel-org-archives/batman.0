Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 13 Nov 2012 10:15:28 +0100
Message-Id: <1352798139-19458-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2012-11-13
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hello David,

this is another set of changes intended for net-next/linux-3.8.
In this patchset you have patch 10/11 which is a roaming handling procedure
re-arrangement and patches 4,5,6/11 by Simon Wunderlich which improve the Bridge
Loop Avoidance set-up phase. The rest is mostly clean-up work.

Let me know if there is any problem!

Thanks a lot,
	Antonio


The following changes since commit 9fafd65ad407d4e0c96919a325f568dd95d032af:

  ipv6 ndisc: Use pre-defined in6addr_linklocal_allnodes. (2012-11-12 15:23:21 -0500)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to 153f5177b998c04c8459bc591cd4e5204fe66a1c:

  batman-adv: Remove instant overwritten variable initialization (2012-11-13 10:06:08 +0100)

----------------------------------------------------------------
Included changes:
- hash computation improvements
- Bridge Loop Avoidance set-up phase optimisations
- Roaming handling code redesign
- some code cleanups

----------------------------------------------------------------
Antonio Quartulli (6):
      batman-adv: fix wrong spinlock inline comment
      batman-adv: prevent using any virtual device created on batman-adv as hard-interface
      batman-adv: substitute tt_poss_change with a per-tt_entry flag
      batman-adv: refactor code to simplify long lines
      batman-adv: refactor tt_global_del_struct()
      batman-adv: roaming handling mechanism redesign

Simon Wunderlich (4):
      batman-adv: don't rely on positions in struct for hashing
      batman-adv: send announcement when backbone gw is registered
      batman-adv: allow bla traffic only after first worker period
      batman-adv: wait multiple periods before activating bla

Sven Eckelmann (1):
      batman-adv: Remove instant overwritten variable initialization

 net/batman-adv/bridge_loop_avoidance.c |  71 ++++++---
 net/batman-adv/hard-interface.c        |  41 ++++-
 net/batman-adv/main.h                  |   1 +
 net/batman-adv/originator.c            |   1 -
 net/batman-adv/routing.c               | 173 +++++++++++++++------
 net/batman-adv/soft-interface.c        |   1 -
 net/batman-adv/sysfs.c                 |   2 +-
 net/batman-adv/translation-table.c     | 276 ++++++++++++++++++++++-----------
 net/batman-adv/translation-table.h     |   2 +
 net/batman-adv/types.h                 |  11 +-
 10 files changed, 406 insertions(+), 173 deletions(-)
