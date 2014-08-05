Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue,  5 Aug 2014 09:36:24 +0200
Message-Id: <1407224188-28626-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2014-08-05
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

this is a pull request intended for net-next/linux-3.17 (yeah..it's really
late).

Patches 1, 2 and 4 are really minor changes:
- kmalloc_array is substituted to kmalloc when possible (as suggested by
  checkpatch);
- net_ratelimited() is now used properly and the "suppressed" message is not
  printed anymore if not needed;
- the internal version number has been increased to reflect our current version.

Patch 3 instead is introducing a change in the metric computation function
by changing the penalty applied at each mesh hop from 15/255 (~6%) to
30/255 (~11%). This change is introduced by Simon Wunderlich after having
observed a performance improvement in several networks when using the new value.


Please pull or let me know of any problem!

Thanks a lot,
	Antonio



The following changes since commit e6b92c25d20c64c271ef429bba8febeefb848b5b:

  cxgb4i : remove spurious use of rcu (2014-08-02 20:34:33 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to 0028c72ec4300997f2d0b73594f391983090463b:

  batman-adv: Start new development cycle (2014-08-04 16:03:13 +0200)

----------------------------------------------------------------
Included changes:
- kmalloc_array instead of kmalloc when possible
- avoid log spam due to useless net_ratelimit() invocations
- increase default metric hop penalty from 15 to 30
- update internal version number

----------------------------------------------------------------
André Gaul (1):
      batman-adv: remove unnecessary logspam

Antonio Quartulli (1):
      batman-adv: prefer kmalloc_array to kmalloc when possible

Simon Wunderlich (2):
      batman-adv: increase default hop penalty
      batman-adv: Start new development cycle

 net/batman-adv/bat_iv_ogm.c            | 13 +++++++------
 net/batman-adv/distributed-arp-table.c |  3 ++-
 net/batman-adv/hash.c                  |  6 +++---
 net/batman-adv/main.h                  | 22 +++++++++++++++-------
 net/batman-adv/routing.c               | 18 +++++++++---------
 net/batman-adv/soft-interface.c        |  2 +-
 6 files changed, 37 insertions(+), 27 deletions(-)

