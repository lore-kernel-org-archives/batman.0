Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 25 Aug 2015 13:02:24 +0200
Message-Id: <1440500559-28368-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 20150825
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hello David,

here you have another batch intended for net-next/linux-4.3.

Most of the patches are about code restyling and beautification,
but we also a couple of non critical fixes which didn't make their
way through net.


Please pull or let me know of any problem!

Thanks a lot,
	Antonio

The following changes since commit 56fff0a01fa056502a28d67cb5a2714d64780415:

  Merge branch 'fjes' (2015-08-24 14:06:37 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to 854d2a63de86a769db4dbed75b660f544b3c0c7a:

  batman-adv: beautify supported routing algorithm list (2015-08-25 00:12:24 +0200)

----------------------------------------------------------------
Included changes:
- code restyling and beautification
- use int kernel types instead of C99
- update kereldoc
- prevent potential hlist double deletion of VLAN objects
- fix gw bandwidth calculation
- convert list to hlist when needed
- add lockdep_asserts calls in function with lock requirements
  described in kerneldoc

----------------------------------------------------------------
Marek Lindner (6):
      batman-adv: update kernel doc of batadv_tt_global_del_orig_entry()
      batman-adv: rename batadv_new_tt_req_node to batadv_tt_req_node_new
      batman-adv: convert orig_node->vlan_list to hlist
      batman-adv: prevent potential hlist double deletion
      batman-adv: convert bat_priv->tt.req_list to hlist
      batman-adv: beautify supported routing algorithm list

Sven Eckelmann (9):
      batman-adv: Replace C99 int types with kernel type
      batman-adv: Fix kerneldoc over 80 column lines
      batman-adv: Remove multiple assignment per line
      batman-adv: Remove batadv_ types forward declarations
      batman-adv: Return EINVAL on invalid gw_bandwidth change
      batman-adv: Fix gw_bandwidth calculation on 32 bit systems
      batman-adv: Annotate deleting functions with external lock via lockdep
      batman-adv: Add lockdep_asserts for documented external locks
      batman-adv: Fix conditional statements indentation

 net/batman-adv/bat_iv_ogm.c            | 102 +++++------
 net/batman-adv/bitarray.c              |   6 +-
 net/batman-adv/bitarray.h              |  10 +-
 net/batman-adv/bridge_loop_avoidance.c |  78 ++++-----
 net/batman-adv/bridge_loop_avoidance.h |   8 +-
 net/batman-adv/debugfs.h               |   1 -
 net/batman-adv/distributed-arp-table.c |  62 +++----
 net/batman-adv/distributed-arp-table.h |   8 +-
 net/batman-adv/fragmentation.c         |  13 +-
 net/batman-adv/gateway_client.c        |  27 +--
 net/batman-adv/gateway_client.h        |   2 +-
 net/batman-adv/gateway_common.c        |  67 +++++--
 net/batman-adv/gateway_common.h        |   1 -
 net/batman-adv/hash.c                  |   6 +-
 net/batman-adv/hash.h                  |  12 +-
 net/batman-adv/icmp_socket.c           |   6 +-
 net/batman-adv/icmp_socket.h           |   1 -
 net/batman-adv/main.c                  |  84 ++++-----
 net/batman-adv/main.h                  |  48 +++--
 net/batman-adv/multicast.c             |  35 ++--
 net/batman-adv/multicast.h             |   2 -
 net/batman-adv/network-coding.c        |  55 +++---
 net/batman-adv/network-coding.h        |   4 -
 net/batman-adv/originator.c            |  22 +--
 net/batman-adv/originator.h            |  11 +-
 net/batman-adv/packet.h                | 204 +++++++++++-----------
 net/batman-adv/routing.c               |  24 +--
 net/batman-adv/routing.h               |   6 +-
 net/batman-adv/send.c                  |   8 +-
 net/batman-adv/send.h                  |  11 +-
 net/batman-adv/soft-interface.c        |  26 ++-
 net/batman-adv/soft-interface.h        |   4 -
 net/batman-adv/sysfs.c                 |   4 +-
 net/batman-adv/sysfs.h                 |   2 -
 net/batman-adv/translation-table.c     | 308 ++++++++++++++++++---------------
 net/batman-adv/translation-table.h     |  31 ++--
 net/batman-adv/types.h                 | 113 ++++++------
 37 files changed, 733 insertions(+), 679 deletions(-)
