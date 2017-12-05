Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Tue,  5 Dec 2017 15:35:08 +0100
Message-Id: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
Subject: [B.A.T.M.A.N.] [RFC v2 0/6] flow_dissector: Provide basic
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
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jiri Pirko <jiri@mellanox.com>, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven.eckelmann@openmesh.com>

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

Now we comes the actual "problematic" part. The packet format is currently
only available in net/batman-adv/packet.h. I've guessed that it should be
moved somewhere under include/ to make it accessible to the flow dissector
in a "standard way".

First we have to find the correct place for it. I am not aware of any
standard for that - so I've grepped for some packet headers which are used
by the dissector and found following files (most likely not a complete
list):

* linux/if_vlan.h
* net/gre.h
* net/tipc.h
* uapi/linux/if_arp.h
* uapi/linux/if_ether.h
* uapi/linux/if_pppox.h
* uapi/linux/ip.h
* uapi/linux/ipv6.h
* uapi/linux/mpls.h
* uapi/linux/tcp.h


So I would say that uapi/linux is the "winner" here. This would actually
also helpful for userspace tools which either inject packets or monitor
interfaces + dissect packets (for example batctl). Now to the actual
filename. batman_adv.h is already used in the moment for the netlink
definition and I would like to avoid that these two things are placed in
the same file. 

A quick grep for "NL_NAME" showed me following names:

* linux/nl802154.h
* net/nl802154.h
* uapi/linux/batman_adv.h
* uapi/linux/devlink.h
* uapi/linux/dlm_netlink.h
* uapi/linux/fou.h
* uapi/linux/if_macsec.h
* uapi/linux/if_team.h
* uapi/linux/ila.h
* uapi/linux/ip_vs.h
* uapi/linux/irda.h
* uapi/linux/l2tp.h
* uapi/linux/nfc.h
* uapi/linux/nl80211.h
* uapi/linux/psample.h
* uapi/linux/seg6_genl.h
* uapi/linux/taskstats.h
* uapi/linux/tcp_metrics.h
* uapi/linux/tipc_config.h
* uapi/linux/tipc_netlink.h

There doesn't seem to be any common way to do it - so I have to guess what
the best names could be. I've decided (but please provide better
alternatives) to use batadv_genl.h (for generic netlink stuff) and batadv.h
(for the packet format).


I would really appreciate it when you would provide feedback to the
naming/placement of the files. Btw. the patches are currently based on the
top of batadv/net-next [2] and this repository contains changes which still
have to be submitted to net-next.

Changes in v2:
=============

* removed the batman-adv unicast packet header definition from flow_dissector.c
* moved the batman-adv packet.h/uapi headers around to provide the correct
  definitions to flow_dissector.c

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/17162/
[2] https://git.open-mesh.org/linux-merge.git/shortlog/refs/heads/batadv/net-next

Sven Eckelmann (6):
  batman-adv: Change nl references to genl
  batman-adv: Rename batman-adv.h to batadv_genl.h
  batman-adv: Let packet.h include its headers directly
  batman-adv: Remove usage of BIT(x) in packet.h
  batman-adv: Convert packet.h to uapi header
  flow_dissector: Parse batman-adv unicast headers

 MAINTAINERS                                        |  3 +-
 .../packet.h => include/uapi/linux/batadv.h        | 32 ++++++++++++----------
 include/uapi/linux/{batman_adv.h => batadv_genl.h} | 20 +++++++-------
 net/batman-adv/bat_algo.c                          |  2 +-
 net/batman-adv/bat_iv_ogm.c                        |  4 +--
 net/batman-adv/bat_v.c                             |  4 +--
 net/batman-adv/bat_v_elp.c                         |  2 +-
 net/batman-adv/bat_v_ogm.c                         |  2 +-
 net/batman-adv/bridge_loop_avoidance.c             |  4 +--
 net/batman-adv/distributed-arp-table.h             |  2 +-
 net/batman-adv/fragmentation.c                     |  2 +-
 net/batman-adv/gateway_client.c                    |  4 +--
 net/batman-adv/gateway_common.c                    |  2 +-
 net/batman-adv/hard-interface.c                    |  2 +-
 net/batman-adv/icmp_socket.c                       |  2 +-
 net/batman-adv/main.c                              |  6 ++--
 net/batman-adv/main.h                              |  4 +--
 net/batman-adv/multicast.c                         |  2 +-
 net/batman-adv/netlink.c                           | 14 ++++++----
 net/batman-adv/network-coding.c                    |  2 +-
 net/batman-adv/originator.c                        |  2 +-
 net/batman-adv/routing.c                           |  2 +-
 net/batman-adv/send.h                              |  3 +-
 net/batman-adv/soft-interface.c                    |  2 +-
 net/batman-adv/sysfs.c                             |  2 +-
 net/batman-adv/tp_meter.c                          |  4 +--
 net/batman-adv/translation-table.c                 |  4 +--
 net/batman-adv/tvlv.c                              |  2 +-
 net/batman-adv/types.h                             |  5 ++--
 net/core/flow_dissector.c                          | 30 ++++++++++++++++++++
 30 files changed, 101 insertions(+), 70 deletions(-)
 rename net/batman-adv/packet.h => include/uapi/linux/batadv.h (96%)
 rename include/uapi/linux/{batman_adv.h => batadv_genl.h} (95%)

-- 
2.11.0

