Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 31 Dec 2018 23:59:59 +0100
Message-Id: <20181231230001.17417-2-sven@narfation.org>
In-Reply-To: <20181231230001.17417-1-sven@narfation.org>
References: <20181231230001.17417-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Update copyright years for
 2019
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile                               | 2 +-
 compat-include/linux/average.h         | 2 +-
 compat-include/linux/build_bug.h       | 2 +-
 compat-include/linux/cache.h           | 2 +-
 compat-include/linux/compiler.h        | 3 ++-
 compat-include/linux/ethtool.h         | 2 +-
 compat-include/linux/eventpoll.h       | 2 +-
 compat-include/linux/fs.h              | 2 +-
 compat-include/linux/if_bridge.h       | 2 +-
 compat-include/linux/igmp.h            | 2 +-
 compat-include/linux/list.h            | 2 +-
 compat-include/linux/netdevice.h       | 2 +-
 compat-include/linux/netlink.h         | 2 +-
 compat-include/linux/nl80211.h         | 2 +-
 compat-include/linux/seq_file.h        | 2 +-
 compat-include/linux/skbuff.h          | 2 +-
 compat-include/linux/timer.h           | 2 +-
 compat-include/linux/types.h           | 2 +-
 compat-include/net/addrconf.h          | 2 +-
 compat-include/net/cfg80211.h          | 2 +-
 compat-include/net/genetlink.h         | 2 +-
 compat-include/net/ip6_checksum.h      | 2 +-
 compat-include/net/netlink.h           | 2 +-
 compat-include/uapi/linux/eventpoll.h  | 2 +-
 compat-include/uapi/linux/nl80211.h    | 2 +-
 compat-sources/Makefile                | 2 +-
 compat.h                               | 2 +-
 gen-compat-autoconf.sh                 | 2 +-
 include/uapi/linux/batadv_packet.h     | 2 +-
 include/uapi/linux/batman_adv.h        | 2 +-
 net/batman-adv/Kconfig                 | 2 +-
 net/batman-adv/Makefile                | 2 +-
 net/batman-adv/bat_algo.c              | 2 +-
 net/batman-adv/bat_algo.h              | 2 +-
 net/batman-adv/bat_iv_ogm.c            | 2 +-
 net/batman-adv/bat_iv_ogm.h            | 2 +-
 net/batman-adv/bat_v.c                 | 2 +-
 net/batman-adv/bat_v.h                 | 2 +-
 net/batman-adv/bat_v_elp.c             | 2 +-
 net/batman-adv/bat_v_elp.h             | 2 +-
 net/batman-adv/bat_v_ogm.c             | 2 +-
 net/batman-adv/bat_v_ogm.h             | 2 +-
 net/batman-adv/bitarray.c              | 2 +-
 net/batman-adv/bitarray.h              | 2 +-
 net/batman-adv/bridge_loop_avoidance.c | 2 +-
 net/batman-adv/bridge_loop_avoidance.h | 2 +-
 net/batman-adv/debugfs.c               | 2 +-
 net/batman-adv/debugfs.h               | 2 +-
 net/batman-adv/distributed-arp-table.c | 2 +-
 net/batman-adv/distributed-arp-table.h | 2 +-
 net/batman-adv/fragmentation.c         | 2 +-
 net/batman-adv/fragmentation.h         | 2 +-
 net/batman-adv/gateway_client.c        | 2 +-
 net/batman-adv/gateway_client.h        | 2 +-
 net/batman-adv/gateway_common.c        | 2 +-
 net/batman-adv/gateway_common.h        | 2 +-
 net/batman-adv/hard-interface.c        | 2 +-
 net/batman-adv/hard-interface.h        | 2 +-
 net/batman-adv/hash.c                  | 2 +-
 net/batman-adv/hash.h                  | 2 +-
 net/batman-adv/icmp_socket.c           | 2 +-
 net/batman-adv/icmp_socket.h           | 2 +-
 net/batman-adv/log.c                   | 2 +-
 net/batman-adv/log.h                   | 2 +-
 net/batman-adv/main.c                  | 2 +-
 net/batman-adv/main.h                  | 2 +-
 net/batman-adv/multicast.c             | 2 +-
 net/batman-adv/multicast.h             | 2 +-
 net/batman-adv/netlink.c               | 2 +-
 net/batman-adv/netlink.h               | 2 +-
 net/batman-adv/network-coding.c        | 2 +-
 net/batman-adv/network-coding.h        | 2 +-
 net/batman-adv/originator.c            | 2 +-
 net/batman-adv/originator.h            | 2 +-
 net/batman-adv/routing.c               | 2 +-
 net/batman-adv/routing.h               | 2 +-
 net/batman-adv/send.c                  | 2 +-
 net/batman-adv/send.h                  | 2 +-
 net/batman-adv/soft-interface.c        | 2 +-
 net/batman-adv/soft-interface.h        | 2 +-
 net/batman-adv/sysfs.c                 | 2 +-
 net/batman-adv/sysfs.h                 | 2 +-
 net/batman-adv/tp_meter.c              | 2 +-
 net/batman-adv/tp_meter.h              | 2 +-
 net/batman-adv/trace.c                 | 2 +-
 net/batman-adv/trace.h                 | 2 +-
 net/batman-adv/translation-table.c     | 2 +-
 net/batman-adv/translation-table.h     | 2 +-
 net/batman-adv/tvlv.c                  | 2 +-
 net/batman-adv/tvlv.h                  | 2 +-
 net/batman-adv/types.h                 | 2 +-
 91 files changed, 92 insertions(+), 91 deletions(-)

diff --git a/Makefile b/Makefile
index 08ac8f65..bccea1b3 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/compat-include/linux/average.h b/compat-include/linux/average.h
index c8b58ec3..b768fba7 100644
--- a/compat-include/linux/average.h
+++ b/compat-include/linux/average.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/build_bug.h b/compat-include/linux/build_bug.h
index 5d6657bc..e071e580 100644
--- a/compat-include/linux/build_bug.h
+++ b/compat-include/linux/build_bug.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/cache.h b/compat-include/linux/cache.h
index 0fc5478d..c8f4f394 100644
--- a/compat-include/linux/cache.h
+++ b/compat-include/linux/cache.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/compiler.h b/compat-include/linux/compiler.h
index 45cd49fa..f4a84b11 100644
--- a/compat-include/linux/compiler.h
+++ b/compat-include/linux/compiler.h
@@ -1,4 +1,5 @@
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/ethtool.h b/compat-include/linux/ethtool.h
index caa70071..20071656 100644
--- a/compat-include/linux/ethtool.h
+++ b/compat-include/linux/ethtool.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2016-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2019  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/compat-include/linux/eventpoll.h b/compat-include/linux/eventpoll.h
index 40a7203b..eb38199b 100644
--- a/compat-include/linux/eventpoll.h
+++ b/compat-include/linux/eventpoll.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/fs.h b/compat-include/linux/fs.h
index e0d6f7c7..30c97dc3 100644
--- a/compat-include/linux/fs.h
+++ b/compat-include/linux/fs.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/if_bridge.h b/compat-include/linux/if_bridge.h
index ff1ff3ae..63e727d2 100644
--- a/compat-include/linux/if_bridge.h
+++ b/compat-include/linux/if_bridge.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/igmp.h b/compat-include/linux/igmp.h
index 7452b221..59f55522 100644
--- a/compat-include/linux/igmp.h
+++ b/compat-include/linux/igmp.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/list.h b/compat-include/linux/list.h
index c542236e..0aa887d8 100644
--- a/compat-include/linux/list.h
+++ b/compat-include/linux/list.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 8f099cf4..19acd7c2 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/netlink.h b/compat-include/linux/netlink.h
index eb42b2b6..4497d667 100644
--- a/compat-include/linux/netlink.h
+++ b/compat-include/linux/netlink.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/nl80211.h b/compat-include/linux/nl80211.h
index 9871910a..71126a1d 100644
--- a/compat-include/linux/nl80211.h
+++ b/compat-include/linux/nl80211.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/seq_file.h b/compat-include/linux/seq_file.h
index e810f225..1077cfc0 100644
--- a/compat-include/linux/seq_file.h
+++ b/compat-include/linux/seq_file.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index fbfd0e02..edda41d9 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/timer.h b/compat-include/linux/timer.h
index 262c3861..83b4bc92 100644
--- a/compat-include/linux/timer.h
+++ b/compat-include/linux/timer.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/types.h b/compat-include/linux/types.h
index f33f2bb2..c1571e9a 100644
--- a/compat-include/linux/types.h
+++ b/compat-include/linux/types.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/net/addrconf.h b/compat-include/net/addrconf.h
index 9d8cd2ae..ca9d6935 100644
--- a/compat-include/net/addrconf.h
+++ b/compat-include/net/addrconf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/net/cfg80211.h b/compat-include/net/cfg80211.h
index 79c028af..d4153b96 100644
--- a/compat-include/net/cfg80211.h
+++ b/compat-include/net/cfg80211.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
index 026500c3..8e8f1e3c 100644
--- a/compat-include/net/genetlink.h
+++ b/compat-include/net/genetlink.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/net/ip6_checksum.h b/compat-include/net/ip6_checksum.h
index 521345dd..5382e886 100644
--- a/compat-include/net/ip6_checksum.h
+++ b/compat-include/net/ip6_checksum.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/net/netlink.h b/compat-include/net/netlink.h
index c395dafb..ce57a19e 100644
--- a/compat-include/net/netlink.h
+++ b/compat-include/net/netlink.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/uapi/linux/eventpoll.h b/compat-include/uapi/linux/eventpoll.h
index 3cf71a19..d4a26d60 100644
--- a/compat-include/uapi/linux/eventpoll.h
+++ b/compat-include/uapi/linux/eventpoll.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/uapi/linux/nl80211.h b/compat-include/uapi/linux/nl80211.h
index 3e743249..8fda321f 100644
--- a/compat-include/uapi/linux/nl80211.h
+++ b/compat-include/uapi/linux/nl80211.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-sources/Makefile b/compat-sources/Makefile
index 7aabaac6..fd4e6db1 100644
--- a/compat-sources/Makefile
+++ b/compat-sources/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/compat.h b/compat.h
index 559df2f3..b3327fa1 100644
--- a/compat.h
+++ b/compat.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index a4eb1136..7a8c8eef 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -1,6 +1,6 @@
 #! /bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 894d8d2f..7eb2936a 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 324a0e11..a28e76a7 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: MIT */
-/* Copyright (C) 2016-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2019  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  *
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index c386e698..a31db5e9 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 9b58160f..a887ecc3 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index ea309ad0..7b7e1564 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 534b790c..25e7bb51 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2011-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Linus Lüssing
  *
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index f97e566f..de61091a 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/bat_iv_ogm.h b/net/batman-adv/bat_iv_ogm.h
index 3dc6a7a4..785f6666 100644
--- a/net/batman-adv/bat_iv_ogm.h
+++ b/net/batman-adv/bat_iv_ogm.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 90e33f84..445594ed 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
  *
diff --git a/net/batman-adv/bat_v.h b/net/batman-adv/bat_v.h
index ec4a2a56..465a4fc2 100644
--- a/net/batman-adv/bat_v.h
+++ b/net/batman-adv/bat_v.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2011-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Linus Lüssing
  *
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index e8090f09..7b80f6f8 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2011-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2019  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
  *
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index e8c7b7fd..75f189ee 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
  *
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 2948b41b..c9698ad4 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
index e5be14c9..f67cf7ee 100644
--- a/net/batman-adv/bat_v_ogm.h
+++ b/net/batman-adv/bat_v_ogm.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index a296a4d8..63e134e7 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2006-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index 48f68328..f3a05ad9 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2006-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 5fdde294..ef39aabd 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2011-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 71f95a3e..31771c75 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2011-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index d4a7702e..3b9d1ad2 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/debugfs.h b/net/batman-adv/debugfs.h
index 8de018e5..c0b86940 100644
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index b9ffe182..7a4b75aa 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2011-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2019  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index a0459602..ea7fc7e0 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2011-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2019  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 5b71a289..b506d15b 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  *
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index 944512e0..abdac265 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  *
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 9d8e5eda..0a6b9b30 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index f0b86fcb..b5732c8b 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 936c107f..53d03adc 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index 80afb279..89bae100 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 508f4416..28c1fb8d 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index d1c0f618..48de28c8 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index 9194f4d8..56a08ce1 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2006-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 0e36fa1c..37507b6d 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2006-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index d70f363c..d34bb79e 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/icmp_socket.h b/net/batman-adv/icmp_socket.h
index 958be22b..5f892652 100644
--- a/net/batman-adv/icmp_socket.h
+++ b/net/batman-adv/icmp_socket.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index 02e55b78..f97849a8 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 35f4f397..660e9bcc 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index d1ed839f..75750870 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index b5720663..05cb9080 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 69244e45..5de6a375 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2014-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2014-2019  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
  *
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 3b04ab13..466013fe 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2014-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2014-2019  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
  *
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 2dc3304c..5fe833cc 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2016-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2019  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  *
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 571d9a5a..216484b8 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2016-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2019  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  *
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 34caf129..278762bd 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
  *
diff --git a/net/batman-adv/network-coding.h b/net/batman-adv/network-coding.h
index 65c34681..96ef0a51 100644
--- a/net/batman-adv/network-coding.h
+++ b/net/batman-adv/network-coding.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
  *
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 56a981af..e5cdf89e 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index a8b4c7b6..dca1e4a3 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index cc3ed93a..be31d340 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index db54c2d9..0102d69d 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 4a35f5c2..66a8b3e4 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 64cce07b..1f613292 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 5db5a0a4..587c50d5 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index daf87f07..538bb661 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 09427fc6..e1b81626 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/sysfs.h b/net/batman-adv/sysfs.h
index c1e3fb69..705ffbe7 100644
--- a/net/batman-adv/sysfs.h
+++ b/net/batman-adv/sysfs.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 11520de9..500109bb 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Edo Monticelli, Antonio Quartulli
  *
diff --git a/net/batman-adv/tp_meter.h b/net/batman-adv/tp_meter.h
index 68e60097..6b4d0f73 100644
--- a/net/batman-adv/tp_meter.h
+++ b/net/batman-adv/tp_meter.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Edo Monticelli, Antonio Quartulli
  *
diff --git a/net/batman-adv/trace.c b/net/batman-adv/trace.c
index 8e102421..f77c917e 100644
--- a/net/batman-adv/trace.c
+++ b/net/batman-adv/trace.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2019  B.A.T.M.A.N. contributors:
  *
  * Sven Eckelmann
  *
diff --git a/net/batman-adv/trace.h b/net/batman-adv/trace.h
index 104784be..5e557905 100644
--- a/net/batman-adv/trace.h
+++ b/net/batman-adv/trace.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2019  B.A.T.M.A.N. contributors:
  *
  * Sven Eckelmann
  *
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8dcd4968..f73d7913 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  *
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 01b6c8ea..61bca75e 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  *
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 40e69c93..7e947b01 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index ef5867f4..c0f033b1 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index cbe17da3..a21b34ed 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
-- 
2.19.2

