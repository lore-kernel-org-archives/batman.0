Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu,  9 Jun 2016 16:54:32 +0200
Message-Id: <1465484086-7974-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH v9 00/14] netns and netlink support
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

This patchset completes netns support, by disabling debugfs entries
when not in the default name space, and correctly handling interface
stack loops when the parent is in a different name space.

It additionally adds netlink support for most of the information found
in debugfs, and is netns aware.

This patchset is based on Andrews v7 series and contains an update/rebase
of the v8 sent by myself on May 23rd, with the following changes:

 * removed useless initialization "struct net_device *soft_iface = NULL;" in:
   - batadv_tt_global_dump
   - batadv_hardif_neigh_dump
   - batadv_orig_dump
   - batadv_gw_dump
   - batadv_bla_claim_dump
   - batadv_bla_backbone_dump
 * add kerneldoc about rcu_read_lock requirement to:
   - batadv_tt_global_dump_entry
   - batadv_iv_ogm_neigh_dump_hardif
   - batadv_iv_ogm_orig_dump_entry
   - batadv_v_neigh_dump_hardif
   - batadv_v_orig_dump_entry
 * simplify code to add BATADV_ATTR_LAST_SEEN_MSECS in batadv_tt_local_dump_entry
 * rebased on top of current master and fix conflicts with batadv_algo_ops restructuring

It should apply clean on todays master.

The batctl patches will be sent separately.

Cheers,
    Simon

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

Simon Wunderlich (1):
  batman-adv: add backbone table netlink support

Sven Eckelmann (2):
  batman-adv: Provide TTVN in the mesh_info netlink msg
  batman-adv: Provide bla group in the mesh_info netlink msg

 compat-include/linux/netlink.h         |  18 ++
 compat.h                               |   7 +
 include/uapi/linux/batman_adv.h        |  94 ++++++++
 net/batman-adv/bat_algo.c              |  68 ++++++
 net/batman-adv/bat_algo.h              |   3 +
 net/batman-adv/bat_iv_ogm.c            | 366 ++++++++++++++++++++++++++++++++
 net/batman-adv/bat_v.c                 | 341 +++++++++++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.c | 333 +++++++++++++++++++++++++++++
 net/batman-adv/bridge_loop_avoidance.h |  17 +-
 net/batman-adv/debugfs.c               |  18 ++
 net/batman-adv/gateway_client.c        | 148 +++++++++++++
 net/batman-adv/gateway_client.h        |   2 +
 net/batman-adv/hard-interface.c        |  50 ++++-
 net/batman-adv/netlink.c               | 217 ++++++++++++++++++-
 net/batman-adv/netlink.h               |   6 +
 net/batman-adv/originator.c            | 160 ++++++++++++++
 net/batman-adv/originator.h            |   4 +
 net/batman-adv/packet.h                |  36 ----
 net/batman-adv/translation-table.c     | 377 +++++++++++++++++++++++++++++++++
 net/batman-adv/translation-table.h     |   4 +
 net/batman-adv/types.h                 |   9 +
 21 files changed, 2230 insertions(+), 48 deletions(-)

-- 
2.8.1

