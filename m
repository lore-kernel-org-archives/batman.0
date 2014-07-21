Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 21 Jul 2014 09:53:29 +0200
Message-Id: <1405929211-30187-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] pull request [net]: batman-adv 20140721
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

here you have two fixes that we have been testing for quite some time
(this is why they arrived a bit late in the rc cycle).

Patch 1) ensures that BLA packets get dropped and not forwarded to the
mesh even if they reach batman-adv within QinQ frames. Forwarding them
into the mesh means messing up with the TT database of other nodes which
can generate all kind of unexpected behaviours during route computation.

Patch 2) avoids a couple of race conditions triggered upon fast VLAN
deletion-addition. Such race conditions are pretty dangerous because
they not only create inconsistencies in the TT database of the nodes
in the network, but such scenario is also unrecoverable (unless
nodes are rebooted).


Please pull or let me know of any problem!


Thanks a lot,
	Antonio



The following changes since commit 640d7efe4c08f06c4ae5d31b79bd8740e7f6790a:

  dns_resolver: Null-terminate the right string (2014-07-20 22:33:32 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to 35df3b298fc8779f7edf4b0228c683f7e98edcd5:

  batman-adv: fix TT VLAN inconsistency on VLAN re-add (2014-07-21 09:49:30 +0200)

----------------------------------------------------------------
Included fixes:
- recognise and drop Bridge Loop Avoidance packets even if
  they are encapsulated in the 802.1q header multiple times.
  Forwarding them into the mesh creates issues on other
  nodes.
- properly handle VLAN private objects in order to avoid race
  conditions upon fast VLAN deletion-addition. Such conditions
  create an unrecoverable inconsistency in the TT database of
  the nodes.

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: fix TT VLAN inconsistency on VLAN re-add

Simon Wunderlich (1):
      batman-adv: drop QinQ claim frames in bridge loop avoidance

 net/batman-adv/bridge_loop_avoidance.c | 44 +++++++++++++++++++------
 net/batman-adv/soft-interface.c        | 60 ++++++++++++++++++++++++++--------
 net/batman-adv/translation-table.c     | 26 +++++++++++++++
 net/batman-adv/types.h                 |  2 ++
 4 files changed, 108 insertions(+), 24 deletions(-)
