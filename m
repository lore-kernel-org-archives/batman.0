Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 17:12:01 +0100
Message-Id: <20171119161207.32588-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/6] batman-adv: Include cleanup
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

Hi,

I went through the build_test.git's testhelpers/kernel_mappings.iwyu and
cleaned that up a little bit. This requires that we have to adjust the
batman-adv sources slighty.

I have also found a build problem when you try to build B.A.T.M.A.N. V
against Linux < 3.7 and fixed it in the same patchset.

Kind regards,
	Sven

Sven Eckelmann (6):
  batman-adv: include gfp.h for GFP_* defines
  batman-adv: include build_bug.h for BUILD_BUG_ON define
  batman-adv: Include net.h for net_ratelimited_function
  batman-adv: include kobject.h for kobject_* functions
  batman-adv: Remove unused sched.h include
  batman-adv: compat: Map to linux/nl80211.h for Linux < 3.7

 compat-include/linux/build_bug.h       | 34 ++++++++++++++++++++++++++++++++++
 compat-include/uapi/linux/nl80211.h    |  4 ++++
 net/batman-adv/bat_iv_ogm.c            |  2 +-
 net/batman-adv/bat_v_elp.c             |  2 +-
 net/batman-adv/bat_v_ogm.c             |  2 +-
 net/batman-adv/bridge_loop_avoidance.c |  2 +-
 net/batman-adv/debugfs.c               |  1 -
 net/batman-adv/distributed-arp-table.c |  2 +-
 net/batman-adv/fragmentation.c         |  2 +-
 net/batman-adv/gateway_client.c        |  2 +-
 net/batman-adv/hard-interface.c        |  2 +-
 net/batman-adv/hash.c                  |  2 +-
 net/batman-adv/icmp_socket.c           |  1 +
 net/batman-adv/log.c                   |  1 +
 net/batman-adv/main.c                  |  4 ++--
 net/batman-adv/multicast.c             |  2 +-
 net/batman-adv/netlink.c               |  2 +-
 net/batman-adv/network-coding.c        |  3 ++-
 net/batman-adv/originator.c            |  2 +-
 net/batman-adv/send.c                  |  2 +-
 net/batman-adv/soft-interface.c        |  2 +-
 net/batman-adv/sysfs.c                 |  3 ++-
 net/batman-adv/tp_meter.c              |  4 ++--
 net/batman-adv/translation-table.c     |  5 +++--
 net/batman-adv/tvlv.c                  |  2 +-
 25 files changed, 66 insertions(+), 24 deletions(-)
 create mode 100644 compat-include/linux/build_bug.h

-- 
2.11.0

