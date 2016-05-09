Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon,  9 May 2016 20:07:07 +0200
Message-Id: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCHv4 00/12] netns and netlink support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

This patchset completes netns support, by disabling debugfs entries
when not in the default name space, and correctly handling interface
stack loops when the parent is in a different name space.

It additionally adds netlink support for most of the information found
in debugfs, and is netns awaire.

Note: BLA is still untested, so best assume it is broken...

v4:

* Fix the batctl o -i <ifname> use case by actually performing the
  filtering on the outgoing interface

v3:

* Fix the compat with older kernels. It now at least compiles with
  3.18.32. I've not booted it though.
  * Add missing kerneldoc

v2:

All changes requested by Sven:

* Added lots of missing includes and structure forward declarations
* Add two kernel doc comments
* Fixed an obvious bug in BLA, but it is probably still broken...
* Merged in the compat code Sven suggested. Only compile tested with 4.5.0

Andrew Lunn (7):
  batman-adv: Handle parent interfaces in a different netns
  batman-adv: compat.h: Add workaround for get_link_net()
  batman-adv: Suppress debugfs entries for netns's
  batman-adv: compat: Workarounds for previous patch
  batman-adv: Indicate netlink socket can be used with netns.
  batman-adv: add B.A.T.M.A.N. Dump gateways via netlink
  batman-adv: add B.A.T.M.A.N. Dump BLA claims via netlink

Matthias Schiffer (5):
  batman-adv: add generic netlink query API to replace debugfs files
  batman-adv: netlink: add translation table query
  batman-adv: netlink: add originator and neighbor table queries
  batman-adv: add B.A.T.M.A.N. IV bat_{orig, neigh}_dump implementations
  batman-adv: add B.A.T.M.A.N. V bat_{orig, neigh}_dump implementations

 Makefile                               |   1 +
 compat-include/linux/netlink.h         |  45 +++++
 compat-include/net/genetlink.h         |  34 ++++
 compat.h                               |  13 ++
 include/uapi/linux/batman_adv.h        | 111 ++++++++++++
 net/batman-adv/Makefile                |   1 +
 net/batman-adv/bat_iv_ogm.c            | 277 +++++++++++++++++++++++++++++
 net/batman-adv/bat_v.c                 | 262 ++++++++++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.c | 166 ++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.h |  10 +-
 net/batman-adv/debugfs.c               |  18 ++
 net/batman-adv/gateway_client.c        | 131 ++++++++++++++
 net/batman-adv/gateway_client.h        |   2 +
 net/batman-adv/hard-interface.c        |  50 +++++-
 net/batman-adv/main.c                  |  51 ++++++
 net/batman-adv/main.h                  |   2 +
 net/batman-adv/netlink.c               | 302 ++++++++++++++++++++++++++++++++
 net/batman-adv/netlink.h               |  41 +++++
 net/batman-adv/originator.c            | 161 +++++++++++++++++
 net/batman-adv/originator.h            |   4 +
 net/batman-adv/packet.h                |  36 ----
 net/batman-adv/translation-table.c     | 308 +++++++++++++++++++++++++++++++++
 net/batman-adv/translation-table.h     |   4 +
 net/batman-adv/types.h                 |   9 +
 24 files changed, 1995 insertions(+), 44 deletions(-)
 create mode 100644 compat-include/linux/netlink.h
 create mode 100644 compat-include/net/genetlink.h
 create mode 100644 include/uapi/linux/batman_adv.h
 create mode 100644 net/batman-adv/netlink.c
 create mode 100644 net/batman-adv/netlink.h

-- 
2.8.0.rc3

