Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Fri, 26 Dec 2014 12:41:17 +0100
Message-Id: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH v2 00/26] batman-adv: Cleanups
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

Hi,

this is v2 of this series. I removed the hashtable patches for the moment. The
types.h patch is fixed to include linux headers only when compiling for the
kernel so that it can still be used in batctl.

Major changes (Patch 1-7):
 - Compiling debugfs.c only when CONFIG_DEBUG_FS is selected. This reduces the
   amount of unnecessary code that is executed. At the moment all calls to
   debugfs functions will result in NOOPs. However there is some more code that
   we simply don't need without DEBUG_FS.
 - tvlv is separated from the large main.c file into its own tvlv.c. I don't
   see a reason to have this set of functions for tvlv inside the main.c file.

Minor changes (Patch 8-26):
 - Removing unnecessary return value variables
 - Fixing some comments
 - Reordering functions to increase readability
 - Coding style fixes
 - Declare boolean return types as bool
 - Add missing includes

Best regards,

Markus


Markus Pargmann (26):
  batman-adv: debugfs, avoid compiling for !DEBUG_FS
  batman-adv: Separate logging header
  batman-adv: iv_ogm, Reduce code duplication
  batman-adv: iv_ogm, divide and round for ring buffer avg
  batman-adv: init, Add some error handling
  batman-adv: tvlv realloc, move error handling into if block
  batman-adv: split tvlv into a seperate file
  batman-adv: Makefile, Sort alphabetically
  batman-adv: iv_ogm_iface_enable, direct return values
  batman-adv: iv_ogm_aggr_packet, bool return value
  batman-adv: iv_ogm_send_to_if, declare char* as const
  batman-adv: iv_ogm_can_aggregate, code readability
  batman-adv: iv_ogm_orig_update, remove unnecessary brackets
  batman-adv: iv_ogm_aggregate_new, simplify error handling
  batman-adv: iv_ogm_queue_add, Simplify expressions
  batman-adv: iv_ogm_orig_update, style, add missin brackets
  batman-adv: iv_ogm, Fix dup_status comment
  batman-adv: iv_ogm, fix coding style
  batman-adv: iv_ogm, fix comment function name
  batman-adv: types, Fix comment on bcast_own
  batman-adv: main, Convert is_my_mac() to bool
  batman-adv: main, batadv_compare_eth return bool
  batman-adv: Remove unnecessary ret variable
  batman-adv: Remove unnecessary ret variable in algo_register
  batman-adv: packet.h, add some missing includes
  batman-adv: types.h, add missing include

 Makefile.kbuild         |   5 +-
 bat_iv_ogm.c            | 239 +++++++++---------
 bitarray.c              |   1 +
 bridge_loop_avoidance.c |   1 +
 debugfs.c               |   9 +-
 debugfs.h               |  39 +++
 distributed-arp-table.c |   2 +
 gateway_client.c        |   1 +
 gateway_common.c        |   2 +
 hard-interface.c        |   1 +
 icmp_socket.c           |   1 +
 log.h                   |  82 +++++++
 main.c                  | 626 +++---------------------------------------------
 main.h                  | 101 +-------
 multicast.c             |   1 +
 network-coding.c        |   2 +
 originator.c            |   1 +
 packet.h                |   5 +
 routing.c               |   2 +
 send.c                  |   1 +
 sysfs.c                 |   1 +
 translation-table.c     |   2 +
 tvlv.c                  | 592 +++++++++++++++++++++++++++++++++++++++++++++
 tvlv.h                  |  62 +++++
 types.h                 |   8 +-
 25 files changed, 967 insertions(+), 820 deletions(-)
 create mode 100644 log.h
 create mode 100644 tvlv.c
 create mode 100644 tvlv.h

-- 
2.1.3

