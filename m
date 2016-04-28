Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 28 Apr 2016 22:37:18 +0200
Message-Id: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 00/10] netns and netlink support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

This patchset completes netns support, by disabling debugfs entries
when not in the default name space, and correctly handling interface
stack loops when the parent is in a different name space.

It additionally adds netlink support for most of the information found
in debugfs, and is netns awaire.

Note: BLA is untested, so best assume it is broken...

batctl patches to follow.

Andrew Lunn (5):
  batman-adv: Handle parent interfaces in a different netns
  batman-adv: Suppress debugfs entries for netns's
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
 include/uapi/linux/batman_adv.h        | 111 ++++++++++++
 net/batman-adv/Makefile                |   1 +
 net/batman-adv/bat_iv_ogm.c            | 268 +++++++++++++++++++++++++++++
 net/batman-adv/bat_v.c                 | 250 +++++++++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.c | 162 +++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.h |   9 +-
 net/batman-adv/debugfs.c               |  19 +-
 net/batman-adv/gateway_client.c        | 126 ++++++++++++++
 net/batman-adv/gateway_client.h        |   1 +
 net/batman-adv/hard-interface.c        |  31 +++-
 net/batman-adv/main.c                  |  48 ++++++
 net/batman-adv/main.h                  |   1 +
 net/batman-adv/netlink.c               | 291 +++++++++++++++++++++++++++++++
 net/batman-adv/netlink.h               |  36 ++++
 net/batman-adv/originator.c            | 142 +++++++++++++++
 net/batman-adv/originator.h            |   2 +
 net/batman-adv/packet.h                |  36 ----
 net/batman-adv/translation-table.c     | 305 +++++++++++++++++++++++++++++++++
 net/batman-adv/translation-table.h     |   2 +
 net/batman-adv/types.h                 |   7 +
 21 files changed, 1804 insertions(+), 45 deletions(-)
 create mode 100644 include/uapi/linux/batman_adv.h
 create mode 100644 net/batman-adv/netlink.c
 create mode 100644 net/batman-adv/netlink.h

-- 
2.8.0.rc3

