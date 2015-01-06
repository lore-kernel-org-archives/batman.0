Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue,  6 Jan 2015 12:09:59 +0100
Message-Id: <1420542605-28865-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request [net]: batman-adv 20150106
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

here you have some small fixes for your 'net' tree.


Patch 1 fixes a regression in the "bonding" code introduced while
implementing the multi-interface optimization feature, by Simon
Wunderlich.

Patch 2 ensures that the "last-seen" timestamp for a newly created
originator object is properly initialised in order to avoid a non-critical
race condition, by Linus Lüssing.

Patch 3 avoids false positive splats when lockdep is enabled by assigning
the proper lock class to locks used by the network coding feature, by
Martin Hundebøll.

Patches 4 and 5 fix the code counting the amount of multicast-disabled
nodes in the network (used to avoid to enable the multicast optimisation
when not possible), by Linus Lüssing.

Patch 6 fixes a memory leak in the Translation Table code that can be
triggered by doubling the current originator interval, by Linus Lüssing.



Please pull or let me know of any problem!

Thanks a lot,
	Antonio



The following changes since commit 7ce67a38f799d1fb332f672b117efbadedaa5352:

  net: ethernet: cpsw: fix hangs with interrupts (2015-01-04 22:18:34 -0500)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to 9d31b3ce81683ce3c9fd10afa70892e373b21067:

  batman-adv: fix potential TT client + orig-node memory leak (2015-01-06 11:07:01 +0100)

----------------------------------------------------------------
Included changes:
- ensure bonding is used (if enabled) for packets coming in the soft
  interface
- fix race condition to avoid orig_nodes to be deleted right after
  being added
- avoid false positive lockdep splats by assigning lockclass to
  the proper hashtable lock objects
- avoid miscounting of multicast 'disabled' nodes in the network
- fix memory leak in the Global Translation Table in case of
  originator interval change

----------------------------------------------------------------
Linus Lüssing (4):
      batman-adv: fix delayed foreign originator recognition
      batman-adv: fix counter for multicast supporting nodes
      batman-adv: fix multicast counter when purging originators
      batman-adv: fix potential TT client + orig-node memory leak

Martin Hundebøll (1):
      batman-adv: fix lock class for decoding hash in network-coding.c

Simon Wunderlich (1):
      batman-adv: fix and simplify condition when bonding should be used

 net/batman-adv/multicast.c      | 11 +++++++----
 net/batman-adv/network-coding.c |  2 +-
 net/batman-adv/originator.c     |  7 ++++---
 net/batman-adv/routing.c        |  6 ++++--
 4 files changed, 16 insertions(+), 10 deletions(-)

