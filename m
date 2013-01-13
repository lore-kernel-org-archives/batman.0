Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 14 Jan 2013 09:41:05 +1000
Message-Id: <1358120480-25960-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2013-01-14
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

this is our first changeset intended for net-next/linux-3.9.
In this batch you have mostly code refactoring, style adjustments and output
beautifications.
The only new 'behaviours' are:
- prevent the TT component from learning multicast mac addresses as they are not
  really handled (yet)
- initialise own lockdep class for each hash table in order to avoid false
  positive from lockdep


Please pull or let me know if there is any problem.
Thanks a lot,
	Antonio


The following changes since commit 00494be4546432a11d62ebfeca363256ff9822b5:

  networking/cs89x0.txt: delete stale information about hand patching (2013-01-11 16:52:26 -0800)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to 0c430d0d7b8bafa74959a84156ef0bda1417a3d4:

  batman-adv: unbloat batadv_priv if debug is not enabled (2013-01-12 20:58:23 +1000)

----------------------------------------------------------------
Included changes:
- use per_cpu_add when possible
- prevent the TT component to add multicast address as "mesh clients"
- some debug output improvements
- proper lockdeps class initializations
- new style fixes (space before/after brackets)
- other minor fixes and refactoring

----------------------------------------------------------------
Antonio Quartulli (11):
      batman-adv: reduce local TT entry timeout to 10 minutes
      batman-adv: improve local translation table output
      batman-adv: print the CRC together with the translation tables
      batman-adv: unify and properly print hex values
      batman-adv: remove useless assignment in tt_local_add()
      batman-adv: Initialize lockdep class keys for hashes
      batman-adv: remove useless blank lines before and after brackets
      batman-adv: remove useless NULL check
      batman-adv: don't compile the BLA switch if not requested
      batman-adv: use the const qualifier in hash functions
      batman-adv: fix typo in debug message

Linus Lüssing (1):
      batman-adv: Do not add multicast MAC addresses to translation table

Marek Lindner (2):
      batman-adv: remove unused variable from orig_node struct
      batman-adv: unbloat batadv_priv if debug is not enabled

Shan Wei (1):
      batman-adv: use per_cpu_add helper

 net/batman-adv/bat_iv_ogm.c            |  8 +---
 net/batman-adv/bridge_loop_avoidance.c | 24 +++++------
 net/batman-adv/debugfs.c               |  8 +---
 net/batman-adv/hash.h                  |  2 +-
 net/batman-adv/main.h                  |  6 +--
 net/batman-adv/originator.c            |  9 +++--
 net/batman-adv/routing.c               |  4 --
 net/batman-adv/send.c                  |  2 -
 net/batman-adv/soft-interface.c        |  7 +++-
 net/batman-adv/translation-table.c     | 73 ++++++++++++++++++++++------------
 net/batman-adv/types.h                 |  7 +++-
 net/batman-adv/unicast.c               |  2 -
 net/batman-adv/vis.c                   |  6 +++
 13 files changed, 88 insertions(+), 70 deletions(-)
