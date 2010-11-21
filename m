Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:38 +0100
Message-Id: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] batman-adv for 2.6.38 (1)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi,

here are the feature patches which are targeted for 2.6.38.

Important features include:
 * Fragmentation of forward packets
 * reassemble of fragmented packets during transfer
 * softif bridge loop avoidance
 * gateway support for dhcp(v6) filtering
 * hash related optimizations

thanks,
	Sven

Andreas Langer (6):
      Staging: batman-adv: restructure fragmentation to handle batman unicast packets
      Staging: batman-adv: add frag_ prefix to all fragmentation related functions
      Staging: batman-adv: move skb reassembly of fragmented packets into dedicated function
      Staging: batman-adv: remove redundant is_my_mac() check in route_unicast_packet
      Staging: batman-adv: fragment forwarded packets
      Staging: batman-adv: reassemble fragmented skb if mtu allows it

Linus Lüssing (4):
      Staging: batman-adv: Unify sysfs file names with their bat_priv atomics
      Staging: batman-adv: Wrapper functions for sysfs storing
      Staging: batman-adv: Ommit storing struct device in sysfs functions
      Staging: batman-adv: Make hop_penalty configurable via sysfs

Marek Lindner (8):
      Staging: batman-adv: ensure that eth_type_trans gets linear memory
      Staging: batman-adv: convert batman_if custom refcounting to kref functions
      Staging: batman-adv: use rcu callbacks when freeing batman_if
      Staging: batman-adv: softif bridge loop avoidance
      Staging: batman-adv: send DHCP requests directly to the chosen gw
      Staging: batman-adv: best gw DHCP filter 802.1Q support
      Staging: batman-adv: add gateway IPv6 support by filtering DHCPv6 messages
      Staging: batman-adv: adding gateway functionality

Sven Eckelmann (11):
      Staging: batman-adv: Replace Andrew Lunn as Staging maintainer
      Staging: batman-adv: Add new sysfs files to README
      Staging: batman-adv: Don't remove interface with spinlock held
      Staging: batman-adv: Remove hashdata_compare_cb from hash
      Staging: batman-adv: Remove hashdata_choose_cb from hash
      Staging: batman-adv: Move hash callback related function to header
      Staging: batman-adv: Make hash_iterate inlineable
      Staging: batman-adv: Rewrite hash using hlist_*
      Staging: batman-adv: Limit spin_locks to spin_lock_bh
      Staging: batman-adv: Use kernel version min macro
      Staging: batman-adv: Use kernel functions to identify broadcasts

 drivers/staging/batman-adv/Makefile             |   19 +-
 drivers/staging/batman-adv/README               |    6 +-
 drivers/staging/batman-adv/TODO                 |    6 +-
 drivers/staging/batman-adv/aggregation.c        |   18 +-
 drivers/staging/batman-adv/bat_debugfs.c        |   33 ++-
 drivers/staging/batman-adv/bat_sysfs.c          |  425 +++++++++++---------
 drivers/staging/batman-adv/gateway_client.c     |  477 +++++++++++++++++++++++
 drivers/staging/batman-adv/gateway_client.h     |   36 ++
 drivers/staging/batman-adv/gateway_common.c     |  177 +++++++++
 drivers/staging/batman-adv/gateway_common.h     |   38 ++
 drivers/staging/batman-adv/hard-interface.c     |   71 ++--
 drivers/staging/batman-adv/hard-interface.h     |   13 +-
 drivers/staging/batman-adv/hash.c               |  237 +-----------
 drivers/staging/batman-adv/hash.h               |  219 +++++++++--
 drivers/staging/batman-adv/icmp_socket.c        |   26 +-
 drivers/staging/batman-adv/main.c               |   46 +--
 drivers/staging/batman-adv/main.h               |    9 +-
 drivers/staging/batman-adv/originator.c         |   75 ++--
 drivers/staging/batman-adv/originator.h         |   28 ++
 drivers/staging/batman-adv/packet.h             |    4 +-
 drivers/staging/batman-adv/routing.c            |  188 +++++-----
 drivers/staging/batman-adv/routing.h            |    2 +
 drivers/staging/batman-adv/send.c               |   48 ++-
 drivers/staging/batman-adv/soft-interface.c     |  333 +++++++++++++++-
 drivers/staging/batman-adv/soft-interface.h     |    5 +-
 drivers/staging/batman-adv/sysfs-class-net-mesh |   28 ++
 drivers/staging/batman-adv/translation-table.c  |  128 ++++---
 drivers/staging/batman-adv/types.h              |   46 ++-
 drivers/staging/batman-adv/unicast.c            |  158 ++++++--
 drivers/staging/batman-adv/unicast.h            |   12 +-
 drivers/staging/batman-adv/vis.c                |  143 ++++----
 31 files changed, 2131 insertions(+), 923 deletions(-)
