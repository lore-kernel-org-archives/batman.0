Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 Apr 2012 11:59:57 +0200
Message-Id: <1334743210-12338-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2012-04-18
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hello David,

this is the fixed version of my previous pull request (issued on 2012-04-17).
In this patchset the issues you reported have been fixed; moreover I'm
also including two new patches (1/13 and 2/13) which are respectively:

1/13) a fix for Al Viro's report about the missing htons()
2/13) a fix for a wrongly duplicated line in a comment

The following changes since commit ecffe75f934b4e3c5301fe5db278068e0efb0d6b:

  hippi: fix printk format in rrunner.c (2012-04-16 23:48:38 -0400)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to 1e5cc266dbc401d11aefb966ad35e651c2f67414:

  batman-adv: skip the window protection test when the originator has no neighbours (2012-04-18 09:54:02 +0200)

----------------------------------------------------------------
Included changes:
* remove duplicated line in comment
* add htons() invocation for tt_crc as suggested by Al Viro
* OriGinator Message seqno initial value is now random
* some cleanups and fixes

----------------------------------------------------------------
Antonio Quartulli (5):
      batman-adv: convert the tt_crc to network order
      batman-adv: remove duplicated line in comment
      batman-adv: use ETH_HLEN instead of sizeof(struct ethhdr)
      batman-adv: print OGM seq numbers as unsigned int
      batman-adv: skip the window protection test when the originator has no neighbours

Marek Lindner (8):
      batman-adv: move ogm initialization into the proper function
      batman-adv: refactoring API: find generalized name for bat_ogm_init callback
      batman-adv: randomize initial seqno to avoid collision
      batman-adv: add iface_disable() callback to routing API
      batman-adv: handle routing code initialization properly
      batman-adv: refactoring API: find generalized name for bat_ogm_init_primary callback
      batman-adv: rename BATMAN_OGM_LEN to BATMAN_OGM_HLEN
      batman-adv: mark existing ogm variables as batman iv

 net/batman-adv/bat_iv_ogm.c            |   63 +++++++++++++++++++++-----------
 net/batman-adv/bridge_loop_avoidance.c |   11 ++----
 net/batman-adv/hard-interface.c        |   33 +++++++++--------
 net/batman-adv/icmp_socket.c           |    4 +-
 net/batman-adv/main.c                  |    5 ++-
 net/batman-adv/packet.h                |    6 +--
 net/batman-adv/routing.c               |   10 ++---
 net/batman-adv/send.c                  |   14 +++----
 net/batman-adv/soft-interface.c        |    2 +-
 net/batman-adv/translation-table.c     |    2 +-
 net/batman-adv/types.h                 |   12 +++---
 net/batman-adv/vis.c                   |    8 ++--
 12 files changed, 96 insertions(+), 74 deletions(-)
