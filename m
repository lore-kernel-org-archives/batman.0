Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Thu, 21 Dec 2017 10:17:37 +0100
Message-Id: <20171221091742.8020-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [PATCH v4 0/5] flow_dissector: Provide basic
 batman-adv unicast handling
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
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Tom Herbert <tom@herbertland.com>, Jiri Pirko <jiri@mellanox.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Sven Eckelmann <sven.eckelmann@openmesh.com>

Hi,

we are currently starting to use batman-adv as mesh protocol on multicore
embedded devices. These usually don't have a lot of CPU power per core but
are reasonable fast when using multiple cores.

It was noticed that sending was working very well but receiving was
basically only using on CPU core per neighbor. The reason for that is
format of the (normal) incoming packet:

  +--------------------+
  | ip(v6)hdr          |
  +--------------------+
  | inner ethhdr       |
  +--------------------+
  | batadv unicast hdr |
  +--------------------+
  | outer ethhdr       |
  +--------------------+

The flow dissector will therefore stop after parsing the outer ethernet
header and will not parse the actual ipv(4|6)/... header of the packet. Our
assumption was now that it would help us to add minimal support to the flow
dissector to jump over the batman-adv unicast and inner ethernet header
(like in gre ETH_P_TEB). The patch was implemented in a slightly hacky
way [1] and the results looked quite promising.

I didn't get any feedback how the files should actually be named. So I am
now just using the names from RFC v3

The discussion of the RFC v3 can be found in the related patches of
https://patchwork.ozlabs.org/cover/849345/

The discussion of the RFC v2 can be found in the related patches of
https://patchwork.ozlabs.org/cover/844783/


Changes in v4:
==============

* added  patch to change the u8/u16 to __u8/__u16 in
  include/uapi/linux/batadv_packet.h
  - requested by Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Changes in v3:
==============

* removed change of uapi/linux/batman_adv.h to uapi/linux/batadv_genl.h
  - requested by Willem de Bruijn <willemdebruijn.kernel@gmail.com>
* removed naming fixes for enums/defines in uapi/linux/batadv_genl.h
  - requested by Willem de Bruijn <willemdebruijn.kernel@gmail.com>
* renamed uapi/linux/batadv.h to uapi/linux/batadv_packet.h
* moved batadv dissector functionality in own function
  - requested by Tom Herbert <tom@herbertland.com>
* added support for flags FLOW_DISSECTOR_F_STOP_AT_ENCAP and
  FLOW_DIS_ENCAPSULATION
  - requested by Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Changes in v2:
==============

* removed the batman-adv unicast packet header definition from flow_dissector.c
* moved the batman-adv packet.h/uapi headers around to provide the correct
  definitions to flow_dissector.c

Kind regards,
        Sven

Sven Eckelmann (5):
  batman-adv: Let packet.h include its headers directly
  batman-adv: Remove usage of BIT(x) in packet.h
  batman-adv: Remove kernel fixed width types in packet.h
  batman-adv: Convert packet.h to uapi header
  flow_dissector: Parse batman-adv unicast headers

 MAINTAINERS                                        |   1 +
 .../packet.h => include/uapi/linux/batadv_packet.h | 245 +++++++++++----------
 net/batman-adv/bat_iv_ogm.c                        |   2 +-
 net/batman-adv/bat_v.c                             |   2 +-
 net/batman-adv/bat_v_elp.c                         |   2 +-
 net/batman-adv/bat_v_ogm.c                         |   2 +-
 net/batman-adv/bridge_loop_avoidance.c             |   2 +-
 net/batman-adv/distributed-arp-table.h             |   2 +-
 net/batman-adv/fragmentation.c                     |   2 +-
 net/batman-adv/gateway_client.c                    |   2 +-
 net/batman-adv/gateway_common.c                    |   2 +-
 net/batman-adv/hard-interface.c                    |   2 +-
 net/batman-adv/icmp_socket.c                       |   2 +-
 net/batman-adv/main.c                              |   2 +-
 net/batman-adv/main.h                              |   4 +-
 net/batman-adv/multicast.c                         |   2 +-
 net/batman-adv/netlink.c                           |   2 +-
 net/batman-adv/network-coding.c                    |   2 +-
 net/batman-adv/routing.c                           |   2 +-
 net/batman-adv/send.h                              |   3 +-
 net/batman-adv/soft-interface.c                    |   2 +-
 net/batman-adv/sysfs.c                             |   2 +-
 net/batman-adv/tp_meter.c                          |   2 +-
 net/batman-adv/translation-table.c                 |   2 +-
 net/batman-adv/tvlv.c                              |   2 +-
 net/batman-adv/types.h                             |   3 +-
 net/core/flow_dissector.c                          |  57 +++++
 27 files changed, 205 insertions(+), 150 deletions(-)
 rename net/batman-adv/packet.h => include/uapi/linux/batadv_packet.h (85%)

-- 
2.11.0

