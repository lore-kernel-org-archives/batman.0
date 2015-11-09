Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon,  9 Nov 2015 16:20:51 +0100
Message-Id: <1447082453-13117-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 0/2] Bridge loop avoidance startup fixes
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

When changing configuration on top of batman-adv, for example in firmwares,
there are two cases which appeared to be problematic and causing
initial temporary loops when starting batman-adv.

 * when activating batman-adv with vlans and bridges, it may take
   longer than 30 seconds to start up the bridges. If the grace
   period is over by that time, the BLA grace period may already
   be over. Therefore increase the grace period to 60 seconds.
 * When changing the network configuration, e.g. adding or removing
   wired interface in a bridge, it may be useful to re-start the
   grace period. Therefore the bridge loop avoidance state is dropped
   when BLA is turned off, so turning off/on bla can be used
   to restart the grace period.

These two fixes addressed the problems we had in our setups.

The patches are based on top of the current master (since its technically
more a feature than a fix), plus the kerneldoc fix sent last week.

Cheers,
     Simon

Simon Wunderlich (2):
  batman-adv: purge bridge loop avoidance when its disabled
  batman-adv: increase BLA wait periods to 6

 net/batman-adv/bridge_loop_avoidance.c | 20 ++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.h |  1 +
 net/batman-adv/main.h                  |  2 +-
 net/batman-adv/sysfs.c                 |  4 +++-
 4 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.6.2

