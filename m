Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 May 2016 17:59:31 +0200
Message-Id: <1464019185-8381-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH v8 00/14] netns and netlink support
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

This patchset is based on Andrews v7 series as of May 7th, with the
following changes of Sven and myself:

 * rebase on current master
 * fix VID output in TT+claim table
 * fix kerneldoc for batadv_bla_claim_dump* functions
 * fix -ENODEV return in batadv_bla_claim_dump
 * added support for bla backbone table
 * add own TTVN to mesh_info (required for global translation table)
 * add own group id to mesh_info (required for bla claim/backbone table)
 * fix soft_iface reference leak when dumping the claim table
 * fix function parameter alignments
 * fix includes

it applies on master plus the following two patches applied:

 * batman-adv: fix returned error in batadv_netlink_tp_meter_cancel
 * batman-adv: remove unused vid local variable in tt seq print

We have tested the setup in our VMs and verified functionality of the
provided tables, including big TT tables and bridge loop avoidance.

Corresponding batctl patches will be sent separately.

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
 net/batman-adv/bat_iv_ogm.c            | 362 +++++++++++++++++++++++++++++++
 net/batman-adv/bat_v.c                 | 337 +++++++++++++++++++++++++++++
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
 21 files changed, 2222 insertions(+), 48 deletions(-)

-- 
2.8.1

