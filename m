Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 26 Nov 2011 22:26:42 +0800
Message-Id: <1322317612-7770-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2011-11-26
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

Hi David,

the following 10 patches constitute the first batch I'd like to get the pulled
into net-next-2.6/3.3. They're mostly uncritical fixes around the recently
introduced tt code, some code refactoring, the kstrto update and the range
check fix reported by Thomas Jarosch. 

Thanks,
Marek

The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://git.open-mesh.org/linux-merge.git for_david

Antonio Quartulli (5):
      batman-adv: tt_global_del_orig() has to print the correct message
      batman-adv: use orig_hash_find() instead of get_orig_node() in TT code
      batman-adv: fixed hash functions type to uint32_t instead of int
      batman-adv: linearise the tt_response skb only if needed
      batman-adv: check for tt_reponse packet real length

Marek Lindner (1):
      batman-adv: refactoring gateway handling code

Simon Wunderlich (2):
      batman-adv: directly write tt entries without buffering
      batman-adv: Fix range check for expected packets

Sven Eckelmann (2):
      batman-adv: update internal version number
      batman-adv: Replace obsolete strict_strto<foo> with kstrto<foo>

 net/batman-adv/bat_sysfs.c         |    4 +-
 net/batman-adv/bitarray.c          |    2 +-
 net/batman-adv/gateway_client.c    |  153 ++++++++++++++++++++++--------------
 net/batman-adv/gateway_client.h    |    5 +-
 net/batman-adv/gateway_common.c    |    4 +-
 net/batman-adv/hash.c              |    4 +-
 net/batman-adv/hash.h              |   13 ++--
 net/batman-adv/main.h              |    2 +-
 net/batman-adv/originator.c        |   13 ++-
 net/batman-adv/originator.h        |    2 +-
 net/batman-adv/routing.c           |   22 ++++--
 net/batman-adv/soft-interface.c    |   43 +++++++---
 net/batman-adv/translation-table.c |  100 ++++++-----------------
 net/batman-adv/vis.c               |   17 +++--
 14 files changed, 202 insertions(+), 182 deletions(-)


