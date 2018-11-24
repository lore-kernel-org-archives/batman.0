Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Nov 2018 21:57:14 +0100
Message-Id: <20181124205718.20148-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v3 0/4] batctl: netlink restructuring, part 3
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

As mentioned earlier, the netlink config restructuring in batctl will be
splitted in multiple steps. The first step was already merged and the
RFC changes for the netlink interface in batman-adv were just posted.

The batman-adv weren't directly rejected by Jiro and thus I've started
to convert all settings to netlink while still allowing sysfs as fallback.

v3:
* fix kernel-doc in batman_adv.h
* add three patches to use the netlink interface with the already existing
  setting commands
v2:
* drop of generic config command
* reimplementation of the event command

Sven Eckelmann (4):
  batctl: Add support for config mcast group in event monitor
  batctl: Don't allocate new buffer for vlan parent device
  batctl: Automatically translate vlan to mesh_iface
  batctl: Use netlink as new configuration interface

 aggregation.c           |  45 ++++-
 ap_isolation.c          |  67 ++++++-
 batman_adv.h            | 188 +++++++++++++++++-
 bonding.c               |  45 ++++-
 bridge_loop_avoidance.c |  46 ++++-
 distributed_arp_table.c |  46 ++++-
 event.c                 | 234 ++++++++++++++++++++++
 fragmentation.c         |  45 ++++-
 functions.c             | 160 +++++++++++++---
 functions.h             |  24 ++-
 gateways.c              |  10 +-
 gw_mode.c               | 415 +++++++++++++++++++++++++++++++---------
 isolation_mark.c        | 123 +++++++++++-
 loglevel.c              | 138 ++++++++++---
 main.c                  |  10 +-
 main.h                  |   6 +-
 mcast_flags.c           |  10 +-
 multicast_mode.c        |  45 ++++-
 netlink.c               | 108 ++++++++++-
 netlink.h               |   2 +
 network_coding.c        |  45 ++++-
 orig_interval.c         |  84 +++++++-
 originators.c           |  10 +-
 routing_algo.c          |   1 -
 sys.c                   | 220 ++++++++++++++++-----
 sys.h                   |  26 ++-
 26 files changed, 1897 insertions(+), 256 deletions(-)

-- 
2.19.1

