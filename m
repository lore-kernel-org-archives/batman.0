Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed,  3 Jun 2015 16:13:56 +0200
Message-Id: <1433340848-1682-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 20150603
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

here you have our second batch of patches intended for net-next.

In this patchset you won't find any new features, but quite some code
cleanup work, a bunch of code style fixes and also comments corrections
by Markus Pargmann.

Moreover you have a patch from Sven Eckelmann removing an unnecessary
NULL check in batadv_iv_ogm_update_seqnos().

Please pull or let me know of any problem!

Thanks a lot,
	Antonio

The following changes since commit df905ceae3883f024282d00824ce33040097ac86:

  Merge branch 'sfc-next' (2015-06-02 12:57:39 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to f372d09059a67f57b3d2b5eab8c05b0ddb8ca92f:

  batman-adv: Remove unnecessary ret variable in algo_register (2015-06-03 15:57:25 +0200)

----------------------------------------------------------------
Included changes:
- code re-arrangement for better reading and understanding
- code style fixups
- comments corrections
- remove unnecessary NULL check in batadv_iv_ogm_update_seqnos()
- make boolean functions explicitly return a bool result
- remove unnecessary variables in algo_register() and algo_select()

----------------------------------------------------------------
Markus Pargmann (11):
      batman-adv: iv_ogm_aggregate_new, simplify error handling
      batman-adv: iv_ogm_queue_add, Simplify expressions
      batman-adv: iv_ogm_orig_update, style, add missing brackets
      batman-adv: iv_ogm, Fix dup_status comment
      batman-adv: iv_ogm, fix coding style
      batman-adv: iv_ogm, fix comment function name
      batman-adv: types, Fix comment on bcast_own
      batman-adv: main, Convert is_my_mac() to bool
      batman-adv: main, batadv_compare_eth return bool
      batman-adv: Remove unnecessary ret variable
      batman-adv: Remove unnecessary ret variable in algo_register

Sven Eckelmann (1):
      batman-adv: Remove unnecessary check for orig_ifinfo not NULL

 net/batman-adv/bat_iv_ogm.c | 46 ++++++++++++++++++++++-----------------------
 net/batman-adv/main.c       | 29 ++++++++++++----------------
 net/batman-adv/main.h       |  4 ++--
 net/batman-adv/types.h      |  7 ++++---
 4 files changed, 41 insertions(+), 45 deletions(-)

