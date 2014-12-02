Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:18 +0100
Message-Id: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 00/31] batman-adv: Cleanups
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi,

this series contains some major cleanup patches (at the beginning of the
series) and some minor cleanups at the end of the series. The behavior of
batman should not be influenced by this series as these patches are only
transformations to make the code more readable and maintainable. If it does
influence behavior something is wrong with this series. The series was tested
on ARM SoC with mwifiex driver.

Major changes (Patch 1-12):
 - Compiling debugfs.c only when CONFIG_DEBUG_FS is selected. This reduces the
   amount of unnecessary code that is executed. At the moment all calls to
   debugfs functions will result in NOOPs. However there is some more code that
   we simply don't need without DEBUG_FS.
 - tvlv is separated from the large main.c file into its own tvlv.c. I don't
   see a reason to have this set of functions for tvlv inside the main.c file.
 - The hashtable implementation now has accessor functions to avoid direct
   access on the private hashtable structure. This should improve the hashtable
   interface and create proper encapsulation.

Minor changes (Patch 13-31):
 - Removing unnecessary return value variables
 - Fixing some comments
 - Reordering functions to increase readability
 - Coding style fixes
 - Declare boolean return types as bool
 - Add missing includes

Best Regards,

Markus


Markus Pargmann (31):
  batman-adv: debugfs, avoid compiling for !DEBUG_FS
  batman-adv: Separate logging header
  batman-adv: iv_ogm, Reduce code duplication
  batman-adv: iv_ogm, divide and round for ring buffer avg
  batman-adv: init, Add some error handling
  batman-adv: tvlv realloc, move error handling into if block
  batman-adv: split tvlv into a seperate file
  batman-adv: hash, remove function implementations from header
  batman-adv: hash, Add helper functions
  batman-adv: hash, replace direct hash structure accesses
  batman-adv: hash, make struct hashtable private
  batman-adv: hash, add used linux headers
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
 bat_iv_ogm.c            | 247 +++++++++----------
 bitarray.c              |   1 +
 bridge_loop_avoidance.c |  58 +++--
 debugfs.c               |   9 +-
 debugfs.h               |  39 +++
 distributed-arp-table.c |  28 ++-
 gateway_client.c        |   1 +
 gateway_common.c        |   2 +
 hard-interface.c        |   1 +
 hash.c                  | 163 +++++++++++++
 hash.h                  | 164 ++-----------
 icmp_socket.c           |   1 +
 log.h                   |  82 +++++++
 main.c                  | 626 +++---------------------------------------------
 main.h                  | 101 +-------
 multicast.c             |   1 +
 network-coding.c        |  38 +--
 originator.c            |  29 +--
 originator.h            |   4 +-
 packet.h                |   3 +
 routing.c               |   2 +
 send.c                  |   1 +
 sysfs.c                 |   1 +
 translation-table.c     |  90 ++++---
 tvlv.c                  | 592 +++++++++++++++++++++++++++++++++++++++++++++
 tvlv.h                  |  62 +++++
 types.h                 |   8 +-
 28 files changed, 1266 insertions(+), 1093 deletions(-)
 create mode 100644 log.h
 create mode 100644 tvlv.c
 create mode 100644 tvlv.h

-- 
2.1.3

