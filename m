Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  2 Dec 2017 19:51:45 +0100
Message-Id: <20171202185153.552-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/8] batman-adv: kernel-doc enhancements
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

more and more functions/struct/enums/... in batman-adv have at least some
brief documentation. But there were still some externally visible (as
"visible" in other source files) elements which completely missed any kind
of kernel-doc. Accoring to the kernel-doc dicumentation [1], having these
documented "properly" is currently a goal.

This patchset now tries to unify the formatting slightly and then add
more (brief) documentation to these elements.

Kind regards,
	Sven

[1] https://www.kernel.org/doc/html/v4.14/doc-guide/kernel-doc.html#recommendations

Sven Eckelmann (8):
  batman-adv: Add missing kernel-doc to packet.h
  batman-adv: Use parentheses in function kernel-doc
  batman-adv: Use inline kernel-doc for enum/struct
  batman-adv: Fix kernel-doc references to struct members
  batman-adv: Add kernel-doc to structs in headers
  batman-adv: Add kernel-doc to enums in headers
  batman-adv: Add kernel-doc to functions in headers
  batman-adv: Add kernel-doc to externally visible functions

 net/batman-adv/bat_algo.c              |   34 +-
 net/batman-adv/bat_iv_ogm.c            |  102 +-
 net/batman-adv/bat_v.c                 |   48 +-
 net/batman-adv/bat_v_elp.c             |   24 +-
 net/batman-adv/bat_v_ogm.c             |   34 +-
 net/batman-adv/bitarray.c              |    2 +-
 net/batman-adv/bitarray.h              |    9 +-
 net/batman-adv/bridge_loop_avoidance.c |  109 +-
 net/batman-adv/bridge_loop_avoidance.h |    4 +-
 net/batman-adv/debugfs.c               |   28 +-
 net/batman-adv/distributed-arp-table.c |   77 +-
 net/batman-adv/distributed-arp-table.h |    6 +-
 net/batman-adv/fragmentation.c         |   20 +-
 net/batman-adv/fragmentation.h         |    2 +-
 net/batman-adv/gateway_client.c        |   62 +-
 net/batman-adv/gateway_common.c        |   27 +-
 net/batman-adv/gateway_common.h        |    5 +-
 net/batman-adv/hard-interface.c        |   62 +-
 net/batman-adv/hard-interface.h        |   58 +-
 net/batman-adv/hash.c                  |   17 +-
 net/batman-adv/hash.h                  |   27 +-
 net/batman-adv/icmp_socket.c           |   13 +-
 net/batman-adv/log.c                   |   17 +
 net/batman-adv/log.h                   |   61 +-
 net/batman-adv/main.c                  |   47 +-
 net/batman-adv/main.h                  |  120 +-
 net/batman-adv/multicast.c             |   78 +-
 net/batman-adv/multicast.h             |   16 +-
 net/batman-adv/netlink.c               |   22 +-
 net/batman-adv/network-coding.c        |  120 +-
 net/batman-adv/originator.c            |  119 +-
 net/batman-adv/originator.h            |    9 +-
 net/batman-adv/packet.h                |   25 +-
 net/batman-adv/routing.c               |   53 +-
 net/batman-adv/send.c                  |   63 +-
 net/batman-adv/send.h                  |    4 +-
 net/batman-adv/soft-interface.c        |   61 +-
 net/batman-adv/sysfs.c                 |   52 +-
 net/batman-adv/sysfs.h                 |   13 +
 net/batman-adv/tp_meter.c              |   70 +-
 net/batman-adv/translation-table.c     |  226 ++--
 net/batman-adv/tvlv.c                  |   38 +-
 net/batman-adv/types.h                 | 1992 ++++++++++++++++++++++----------
 43 files changed, 2694 insertions(+), 1282 deletions(-)

-- 
2.11.0

