Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/5] pull request for net-next: batman-adv 2019-11-05
Date: Tue,  5 Nov 2019 10:35:26 +0100
Message-Id: <20191105093531.11398-1-sw@simonwunderlich.de>
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

here is a little cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 1204c70d9dcba31164f78ad5d8c88c42335d51f8:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2019-11-01 17:48:11 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-20191105

for you to fetch changes up to 5759af0682b3395e64cf615e062d6ecad01428dc:

  batman-adv: Drop lockdep.h include for soft-interface.c (2019-11-03 08:30:58 +0100)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - Simplify batadv_v_ogm_aggr_list_free using skb_queue_purge,
   by Christophe Jaillet

 - Replace aggr_list_lock with lock free skb handlers,
   by Christophe Jaillet

 - explicitly mark fallthrough cases, by Sven Eckelmann

 - Drop lockdep.h include from soft-interface.c, by Sven Eckelmann

----------------------------------------------------------------
Christophe JAILLET (2):
      batman-adv: Simplify 'batadv_v_ogm_aggr_list_free()'
      batman-adv: Axe 'aggr_list_lock'

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sven Eckelmann (2):
      batman-adv: Use 'fallthrough' pseudo keyword
      batman-adv: Drop lockdep.h include for soft-interface.c

 net/batman-adv/bat_v.c          |  1 -
 net/batman-adv/bat_v_ogm.c      | 34 +++++++++++++++-------------------
 net/batman-adv/main.h           |  2 +-
 net/batman-adv/multicast.c      |  2 +-
 net/batman-adv/soft-interface.c |  5 ++---
 net/batman-adv/types.h          |  3 ---
 6 files changed, 19 insertions(+), 28 deletions(-)
