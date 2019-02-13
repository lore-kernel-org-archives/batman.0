Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 13 Feb 2019 10:55:03 +0100
Message-Id: <20190213095524.10147-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 00/21] pull request for net-next: batman-adv
 2019-02-13
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>

Hi David,

here is another pull request for batman-adv to go into net-next. The main
patchset is Svens netlink restructure series, which was also discussed on netdev
for quite some time now and should be ready to be integrated.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 7a79d717e0817610932ce3b7b6033ea06ee1d577:

  batman-adv: Update copyright years for 2019 (2019-01-04 11:04:24 +0100)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-for-davem-20190213

for you to fetch changes up to 7e6f461efe2554e35b740f3faea2994fc9551947:

  batman-adv: Trigger genl notification on sysfs config change (2019-02-09 14:28:15 +0100)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - fix memory leak in in batadv_dat_put_dhcp, by Martin Weinelt

 - fix typo, by Sven Eckelmann

 - netlink restructuring patch series (part 2), by Sven Eckelmann
   (19 patches)

----------------------------------------------------------------
Martin Weinelt (1):
      batman-adv: fix memory leak in in batadv_dat_put_dhcp

Sven Eckelmann (20):
      batman-adv: Fix typo "reseved" -> "reserved"
      batman-adv: Move common genl doit code pre/post hooks
      batman-adv: Prepare framework for mesh genl config
      batman-adv: Prepare framework for hardif genl config
      batman-adv: Prepare framework for vlan genl config
      batman-adv: Add aggregated_ogms mesh genl configuration
      batman-adv: Add ap_isolation mesh/vlan genl configuration
      batman-adv: Add bonding mesh genl configuration
      batman-adv: Add bridge_loop_avoidance mesh genl configuration
      batman-adv: Add distributed_arp_table mesh genl configuration
      batman-adv: Add fragmentation mesh genl configuration
      batman-adv: Add gateway mesh genl configuration
      batman-adv: Add hop_penalty mesh genl configuration
      batman-adv: Add log_level mesh genl configuration
      batman-adv: Add multicast forceflood mesh genl configuration
      batman-adv: Add network_coding mesh genl configuration
      batman-adv: Add orig_interval mesh genl configuration
      batman-adv: Add elp_interval hardif genl configuration
      batman-adv: Add throughput_override hardif genl configuration
      batman-adv: Trigger genl notification on sysfs config change

 include/uapi/linux/batadv_packet.h     |    2 +-
 include/uapi/linux/batman_adv.h        |  190 +++++-
 net/batman-adv/distributed-arp-table.c |    2 +
 net/batman-adv/gateway_client.c        |    1 -
 net/batman-adv/gateway_common.c        |    1 +
 net/batman-adv/gateway_common.h        |    6 -
 net/batman-adv/netlink.c               | 1080 ++++++++++++++++++++++++++++----
 net/batman-adv/netlink.h               |    6 +
 net/batman-adv/soft-interface.c        |    2 +-
 net/batman-adv/sysfs.c                 |   64 +-
 10 files changed, 1206 insertions(+), 148 deletions(-)
