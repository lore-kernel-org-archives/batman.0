Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 19 Sep 2018 14:22:02 +0200
Message-Id: <20180919122213.23108-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 00/11] pull request for net: batman-adv
 2018-09-19
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

here are some bugfixes which we would like to see integrated into net.

We forgot to bump the version number in the last round for net-next, so
the belated patch to do that is included - we hope you can adopt it.
This will most likely create a merge conflict later when merging into
net-next with this rounds net-next patchset, but net-next should keep
the 2018.4 version[1].

Please pull or let me know of any problem!

Thank you,
      Simon

[1] resolution:

--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -25,11 +25,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-<<<<<<<
-#define BATADV_SOURCE_VERSION "2018.3"
-=======
 #define BATADV_SOURCE_VERSION "2018.4"
->>>>>>>
 #endif
 
 /* B.A.T.M.A.N. parameters */

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20180919

for you to fetch changes up to dabeb13eee81329338b1f8f330dfcc37a86714d7:

  batman-adv: Increase version number to 2018.3 (2018-09-14 17:59:20 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - Avoid ELP information leak, by Sven Eckelmann

 - Fix sysfs segfault issues, by Sven Eckelmann (2 patches)

 - Fix locking when adding entries in various lists,
   by Sven Eckelmann (5 patches)

 - Fix refcount if queue_work() fails, by Marek Lindner (2 patches)

 - Fixup forgotten version bump, by Sven Eckelmann

----------------------------------------------------------------
Marek Lindner (2):
      batman-adv: fix backbone_gw refcount on queue_work() failure
      batman-adv: fix hardif_neigh refcount on queue_work() failure

Sven Eckelmann (9):
      batman-adv: Avoid probe ELP information leak
      batman-adv: Fix segfault when writing to throughput_override
      batman-adv: Fix segfault when writing to sysfs elp_interval
      batman-adv: Prevent duplicated gateway_node entry
      batman-adv: Prevent duplicated nc_node entry
      batman-adv: Prevent duplicated softif_vlan entry
      batman-adv: Prevent duplicated global TT entry
      batman-adv: Prevent duplicated tvlv handler
      batman-adv: Increase version number to 2018.3

 net/batman-adv/bat_v_elp.c             | 10 +++++++---
 net/batman-adv/bridge_loop_avoidance.c | 10 ++++++++--
 net/batman-adv/gateway_client.c        | 11 +++++++++--
 net/batman-adv/main.h                  |  2 +-
 net/batman-adv/network-coding.c        | 27 +++++++++++++++------------
 net/batman-adv/soft-interface.c        | 25 ++++++++++++++++++-------
 net/batman-adv/sysfs.c                 | 30 ++++++++++++++++++++----------
 net/batman-adv/translation-table.c     |  6 ++++--
 net/batman-adv/tvlv.c                  |  8 ++++++--
 9 files changed, 88 insertions(+), 41 deletions(-)
