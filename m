Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 30 Oct 2011 23:51:01 +0100
Message-Id: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFC 00/11] bridge loop avoidance II
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

This series of patches is a request for comments on the redesigned
bridge loop avoidance. The general concept is described in the wiki
[1]. I've already performed a few testcases [2] which worked fine in
my kvm environment. No crashes while running or unloading the 
extension either.

The last patch in the series uses the cached address of the primary
interface (the originator address known through the mesh) to save some
code at various positions, there may be side effects I don't see
however (e.g. implicit checking whether the module was configured
correctly was removed).

Marek already pointed quite a few issues out, these changes are
reflected in the respective commit logs. These commit comments will
be removed in the final version.

Any comments and suggestions are appreciated. 

Thanks
    Simon

[1] http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance-II
[2] http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance-Testcases

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
  [RFC] batman-adv: get primaries address through bat_priv->own_orig

 Makefile.kbuild         |    1 +
 README                  |   28 +-
 bat_debugfs.c           |   18 +-
 bat_sysfs.c             |    4 +-
 bridge_loop_avoidance.c | 1509 +++++++++++++++++++++++++++++++++++++++++++++++
 bridge_loop_avoidance.h |   34 ++
 compat.c                |   16 +-
 compat.h                |    3 +-
 hard-interface.c        |    8 +-
 icmp_socket.c           |   12 +-
 main.c                  |    9 +-
 main.h                  |    9 +-
 originator.c            |    3 +-
 packet.h                |   16 +
 routing.c               |   41 +-
 soft-interface.c        |  490 +---------------
 soft-interface.h        |    2 -
 sysfs-class-net-mesh    |    9 +
 translation-table.c     |  366 ++++++++----
 types.h                 |   70 ++-
 unicast.c               |    9 +-
 vis.c                   |   20 +-
 22 files changed, 1965 insertions(+), 712 deletions(-)
 create mode 100644 bridge_loop_avoidance.c
 create mode 100644 bridge_loop_avoidance.h

-- 
1.7.7.1

