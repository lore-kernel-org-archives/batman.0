Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jul 2016 13:31:32 +0200
Message-Id: <1467545508-7333-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v10 00/16] batman-adv: netns and netlink
	support
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

This patchset completes netns support, by disabling debugfs entries
when not in the default name space, and correctly handling interface
stack loops when the parent is in a different name space.

It additionally adds netlink support for most of the information found
in debugfs, and is netns aware.

This patchset is based on Andrews v7 series and contains an update/rebase
of the v9 sent by Simon on June 6th, with the following changes:

 * add batadv_algo ops support to dump gateways dump via netlink
 * integrate B.A.T.M.A.N. IV gateways dump code in batadv_algo
 * add support for B.A.T.M.A.N. V gateways
 * rebased on top of current master + gateway patches v6

It should apply clean on todays master + the gateway patches v6.

The batctl patches will be sent separately.

Kind regards,
	Sven

Andrew Lunn (5):
  batman-adv: Handle parent interfaces in a different netns
  batman-adv: Suppress debugfs entries for netns's
  batman-adv: add B.A.T.M.A.N. IV bat_gw_dump implementations
  batman-adv: add B.A.T.M.A.N. Dump BLA claims via netlink
  batman-adv: Indicate netlink socket can be used with netns.

Matthias Schiffer (6):
  batman-adv: netlink: add routing_algo query
  batman-adv: netlink: hardif query
  batman-adv: netlink: add translation table query
  batman-adv: netlink: add originator and neighbor table queries
  batman-adv: add B.A.T.M.A.N. IV bat_{orig, neigh}_dump implementations
  batman-adv: add B.A.T.M.A.N. V bat_{orig, neigh}_dump implementations

Simon Wunderlich (1):
  batman-adv: add backbone table netlink support

Sven Eckelmann (4):
  batman-adv: Provide TTVN in the mesh_info netlink msg
  batman-adv: netlink: add gateway table queries
  batman-adv: add B.A.T.M.A.N. V bat_gw_dump implementations
  batman-adv: Provide bla group in the mesh_info netlink msg

 compat-include/linux/netlink.h         |  18 ++
 compat.h                               |   7 +
 include/uapi/linux/batman_adv.h        |  94 +++++++
 net/batman-adv/bat_algo.c              |  68 +++++
 net/batman-adv/bat_algo.h              |   3 +
 net/batman-adv/bat_iv_ogm.c            | 471 +++++++++++++++++++++++++++++++++
 net/batman-adv/bat_v.c                 | 465 ++++++++++++++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.c | 333 +++++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.h |  17 +-
 net/batman-adv/debugfs.c               |  18 ++
 net/batman-adv/gateway_client.c        |  59 +++++
 net/batman-adv/gateway_client.h        |   2 +
 net/batman-adv/hard-interface.c        |  50 +++-
 net/batman-adv/netlink.c               | 217 ++++++++++++++-
 net/batman-adv/netlink.h               |   6 +
 net/batman-adv/originator.c            | 160 +++++++++++
 net/batman-adv/originator.h            |   4 +
 net/batman-adv/packet.h                |  36 ---
 net/batman-adv/translation-table.c     | 377 ++++++++++++++++++++++++++
 net/batman-adv/translation-table.h     |   4 +
 net/batman-adv/types.h                 |  12 +
 21 files changed, 2373 insertions(+), 48 deletions(-)

-- 
2.8.1

