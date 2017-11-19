Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 15:05:08 +0100
Message-Id: <20171119140517.24329-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/9] batman-adv: License cleanup
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

the kernel community is currently trying to make the licensing status more
clear in each file. This is mostly done by adding SPDX license identifiers
and defining a set of rules how these license related information has to
be stored.

I've used this opportunity to go through all files (for example with FSFE's
`reuse lint`) and to annotate the files according to the "Linux licensing
rules" and FSFE's REUSE practices.

There are two things which could be seen as controversial:

* change of batman_adv.h to the Linux preferred license
  (I am waiting for Acks)
* explicitly mark remaining files as licensed under the GPL-2.0

Kind regards,
	Sven

Sven Eckelmann (9):
  batman-adv: Add GPL-2.0 as Linux's LICENSES/preferred/GPL-2.0
  batman-adv: Add License-Filename to GPL-2.0 files
  batman-adv: Add SPDX license identifier above copyright header
  batman-adv: Add SPDX license identifier to batman-adv.rst
  batman-adv: Add license header to Kconfig
  batman-adv: Add license headers to compat files
  batman-adv: Mark remaining files as GPL-2.0
  batman-adv: Change batman_adv.h license to MIT
  batman-adv: Import Linux's LICENSES/preferred/MIT

 .gitattributes                          |   3 +
 CHANGELOG.license                       |   2 +
 Documentation/networking/batman-adv.rst |   2 +
 LICENSES/preferred/GPL-2.0              | 352 ++++++++++++++++++++++++++++++++
 LICENSES/preferred/MIT                  |  30 +++
 MAINTAINERS.license                     |   2 +
 Makefile                                |   3 +-
 README.external.license                 |   2 +
 compat-include/linux/average.h          |   3 +
 compat-include/linux/cache.h            |   3 +
 compat-include/linux/etherdevice.h      |   3 +
 compat-include/linux/ethtool.h          |   3 +
 compat-include/linux/export.h           |   3 +
 compat-include/linux/genetlink.h        |   3 +
 compat-include/linux/if_bridge.h        |  23 +++
 compat-include/linux/if_ether.h         |   3 +
 compat-include/linux/if_vlan.h          |   3 +
 compat-include/linux/igmp.h             |  23 +++
 compat-include/linux/kernel.h           |   3 +
 compat-include/linux/kref.h             |   3 +
 compat-include/linux/list.h             |   3 +
 compat-include/linux/net.h              |   3 +
 compat-include/linux/netdev_features.h  |   3 +
 compat-include/linux/netdevice.h        |   3 +
 compat-include/linux/netlink.h          |   3 +
 compat-include/linux/nl80211.h          |  23 +++
 compat-include/linux/random.h           |   3 +
 compat-include/linux/rculist.h          |   3 +
 compat-include/linux/seq_file.h         |   3 +
 compat-include/linux/skbuff.h           |   3 +
 compat-include/linux/slab.h             |   3 +
 compat-include/net/addrconf.h           |  23 +++
 compat-include/net/cfg80211.h           |  23 +++
 compat-include/net/genetlink.h          |   3 +
 compat-include/net/ip6_checksum.h       |  23 +++
 compat-include/net/ipv6.h               |  23 +++
 compat-include/uapi/linux/nl80211.h     |  23 +++
 compat-patches/README                   |   2 +
 compat-patches/replacements.sh          |  18 ++
 compat-sources/Makefile                 |  19 ++
 compat-sources/net/core/skbuff.c        |   3 +
 compat-sources/net/ipv4/igmp.c          |   3 +
 compat-sources/net/ipv6/mcast_snoop.c   |   3 +
 compat.h                                |   3 +
 gen-compat-autoconf.sh                  |  18 ++
 include/uapi/linux/batman_adv.h         |  27 ++-
 net/batman-adv/Kconfig                  |  19 ++
 net/batman-adv/Makefile                 |   3 +-
 net/batman-adv/bat_algo.c               |   3 +
 net/batman-adv/bat_algo.h               |   3 +
 net/batman-adv/bat_iv_ogm.c             |   3 +
 net/batman-adv/bat_iv_ogm.h             |   3 +
 net/batman-adv/bat_v.c                  |   3 +
 net/batman-adv/bat_v.h                  |   3 +
 net/batman-adv/bat_v_elp.c              |   3 +
 net/batman-adv/bat_v_elp.h              |   3 +
 net/batman-adv/bat_v_ogm.c              |   3 +
 net/batman-adv/bat_v_ogm.h              |   3 +
 net/batman-adv/bitarray.c               |   3 +
 net/batman-adv/bitarray.h               |   3 +
 net/batman-adv/bridge_loop_avoidance.c  |   3 +
 net/batman-adv/bridge_loop_avoidance.h  |   3 +
 net/batman-adv/debugfs.c                |   3 +
 net/batman-adv/debugfs.h                |   3 +
 net/batman-adv/distributed-arp-table.c  |   3 +
 net/batman-adv/distributed-arp-table.h  |   3 +
 net/batman-adv/fragmentation.c          |   3 +
 net/batman-adv/fragmentation.h          |   3 +
 net/batman-adv/gateway_client.c         |   3 +
 net/batman-adv/gateway_client.h         |   3 +
 net/batman-adv/gateway_common.c         |   3 +
 net/batman-adv/gateway_common.h         |   3 +
 net/batman-adv/hard-interface.c         |   3 +
 net/batman-adv/hard-interface.h         |   3 +
 net/batman-adv/hash.c                   |   3 +
 net/batman-adv/hash.h                   |   3 +
 net/batman-adv/icmp_socket.c            |   3 +
 net/batman-adv/icmp_socket.h            |   3 +
 net/batman-adv/log.c                    |   3 +
 net/batman-adv/log.h                    |   3 +
 net/batman-adv/main.c                   |   3 +
 net/batman-adv/main.h                   |   3 +
 net/batman-adv/multicast.c              |   3 +
 net/batman-adv/multicast.h              |   3 +
 net/batman-adv/netlink.c                |   3 +
 net/batman-adv/netlink.h                |   3 +
 net/batman-adv/network-coding.c         |   3 +
 net/batman-adv/network-coding.h         |   3 +
 net/batman-adv/originator.c             |   3 +
 net/batman-adv/originator.h             |   3 +
 net/batman-adv/packet.h                 |   3 +
 net/batman-adv/routing.c                |   3 +
 net/batman-adv/routing.h                |   3 +
 net/batman-adv/send.c                   |   3 +
 net/batman-adv/send.h                   |   3 +
 net/batman-adv/soft-interface.c         |   3 +
 net/batman-adv/soft-interface.h         |   3 +
 net/batman-adv/sysfs.c                  |   3 +
 net/batman-adv/sysfs.h                  |   3 +
 net/batman-adv/tp_meter.c               |   3 +
 net/batman-adv/tp_meter.h               |   3 +
 net/batman-adv/translation-table.c      |   3 +
 net/batman-adv/translation-table.h      |   3 +
 net/batman-adv/tvlv.c                   |   3 +
 net/batman-adv/tvlv.h                   |   3 +
 net/batman-adv/types.h                  |   3 +
 106 files changed, 923 insertions(+), 12 deletions(-)
 create mode 100644 CHANGELOG.license
 create mode 100644 LICENSES/preferred/GPL-2.0
 create mode 100644 LICENSES/preferred/MIT
 create mode 100644 MAINTAINERS.license
 create mode 100644 README.external.license

-- 
2.11.0

