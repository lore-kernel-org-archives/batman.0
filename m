Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat,  5 Nov 2011 18:24:11 +0100
Message-Id: <1320513862-28360-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [PATCH 00/11] bridge loop avoidance II
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

This series of patches contains the changes for the redesigned
bridge loop avoidance. The general concept is described in the wiki
[1]. I've already performed a few testcases [2] which worked fine in
my kvm environment. No crashes while running or unloading the
extension either.

This is the second version of the patchset, rebased on the master and
including the changes according to reviews on the mailing list.

The git repositories can be found on git.open-mesh.org:
 * blaII_dirty branch [3] has all the patches in development order
 * blaII branch [4] contains the patches squashed as sent the ml
 * blaII branch in batctl [5] contains the batctl changes

Cheers,
	Simon

[1] http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance-II
[2] http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance-Testcases
[3] http://git.open-mesh.org/?p=simon/batman-adv.git;a=shortlog;h=refs/heads/blaII_dirty
[4] http://git.open-mesh.org/?p=simon/batman-adv.git;a=shortlog;h=refs/heads/blaII
[5] http://git.open-mesh.org/?p=simon/batctl.git;a=shortlog;h=refs/heads/blaII

---
The main changes to the previous version ([RFC]) are:
 * rebase on latest master
 * make bla sparse clean
 * check for hash_add()
 * check bla_get_backbone_gw()
 * shorten announce_mac[]
 * always use ETH_ALEN
 * fix debug message
 * don't change comment in batman_skb_recv()
 * split choose_claim/choose_backbone_gw
 * remove primary_if/own_orig address caching
 * fix forgotten backbone_gw_free_ref() and error checking
 * return 1 (handled) when there was an error in handle_claim()
 * unify bla_free() with the purge_* functions
 * call purge when (re)starting with a new primary interface
 * add compile option for bla


Simon Wunderlich (11):
  batman-adv: remove old bridge loop avoidance code
  batman-adv: add basic bridge loop avoidance code
  batman-adv: make bridge loop avoidance switchable
  batman-adv: export claim tables through debugfs
  batman-adv: allow multiple entries in tt_global_entries
  batman-adv: don't let backbone gateways exchange tt entries
  batman-adv: add broadcast duplicate check
  batman-adv: drop STP over batman
  batman-adv: form groups in the bridge loop avoidance
  batman-adv: Update README and sysfs description
  batman-adv: add bridge loop avoidance compile option

 Makefile.kbuild         |    2 +
 README                  |   28 +-
 bat_debugfs.c           |   23 +-
 bat_sysfs.c             |    8 +-
 bridge_loop_avoidance.c | 1592 +++++++++++++++++++++++++++++++++++++++++++++++
 bridge_loop_avoidance.h |   49 ++
 compat.c                |   16 +-
 compat.h                |    3 +-
 hard-interface.c        |   18 +-
 main.c                  |    9 +-
 main.h                  |    9 +-
 originator.c            |    3 +-
 packet.h                |   16 +
 routing.c               |   16 +
 soft-interface.c        |  490 +--------------
 soft-interface.h        |    2 -
 sysfs-class-net-mesh    |    9 +
 translation-table.c     |  354 ++++++++---
 types.h                 |   67 ++-
 19 files changed, 2071 insertions(+), 643 deletions(-)
 create mode 100644 bridge_loop_avoidance.c
 create mode 100644 bridge_loop_avoidance.h

-- 
1.7.7.1

