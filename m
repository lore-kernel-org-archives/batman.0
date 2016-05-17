Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 17 May 2016 16:13:08 +0200
Message-Id: <1463494399-26405-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH v7 00/11] netns and netlink support
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

Note: BLA is untested, so best assume it is broken...

v7:

  Fix compat.h get_link_net() - Thanks Sven
  Move originator.h in netlink.c to the correct place.

Andrew Lunn (5):
  batman-adv: Handle parent interfaces in a different netns
  batman-adv: Suppress debugfs entries for netns's
  batman-adv: add B.A.T.M.A.N. Dump gateways via netlink
  batman-adv: add B.A.T.M.A.N. Dump BLA claims via netlink
  batman-adv: Indicate netlink socket can be used with netns.

Matthias Schiffer (6):
  batman-adv: netlink: add routing_algo query
  batman-adv: netlink: hardif query
  batman-adv: netlink: add translation table query
  batman-adv: netlink: add originator and neighbor table queries
  batman-adv: add B.A.T.M.A.N. IV bat_{orig, neigh}_dump implementations
  batman-adv: add B.A.T.M.A.N. V bat_{orig, neigh}_dump implementations

 compat-include/linux/netlink.h         |  45 ++++
 compat.h                               |   7 +
 include/uapi/linux/batman_adv.h        |  94 ++++++++
 net/batman-adv/bat_iv_ogm.c            | 359 +++++++++++++++++++++++++++++++
 net/batman-adv/bat_v.c                 | 337 +++++++++++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.c | 166 +++++++++++++++
 net/batman-adv/bridge_loop_avoidance.h |  10 +-
 net/batman-adv/debugfs.c               |  18 ++
 net/batman-adv/gateway_client.c        | 148 +++++++++++++
 net/batman-adv/gateway_client.h        |   2 +
 net/batman-adv/hard-interface.c        |  50 ++++-
 net/batman-adv/main.c                  |  66 ++++++
 net/batman-adv/main.h                  |   2 +
 net/batman-adv/netlink.c               | 201 ++++++++++++++++-
 net/batman-adv/netlink.h               |  10 +
 net/batman-adv/originator.c            | 160 ++++++++++++++
 net/batman-adv/originator.h            |   4 +
 net/batman-adv/packet.h                |  36 ----
 net/batman-adv/translation-table.c     | 379 +++++++++++++++++++++++++++++++++
 net/batman-adv/translation-table.h     |   4 +
 net/batman-adv/types.h                 |   9 +
 21 files changed, 2059 insertions(+), 48 deletions(-)
 create mode 100644 compat-include/linux/netlink.h

-- 
2.8.0.rc3

