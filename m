Return-Path: <sven@dvalin.narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 3/3] batman-adv: Update copyright years for 2021
Date: Fri,  1 Jan 2021 00:01:02 +0100
Message-Id: <20201231230102.10127-3-sven@narfation.org>
In-Reply-To: <20201231230102.10127-1-sven@narfation.org>
References: <20201231230102.10127-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile                               | 2 +-
 compat-include/linux/average.h         | 2 +-
 compat-include/linux/build_bug.h       | 2 +-
 compat-include/linux/cache.h           | 2 +-
 compat-include/linux/compiler.h        | 2 +-
 compat-include/linux/ethtool.h         | 2 +-
 compat-include/linux/if_bridge.h       | 2 +-
 compat-include/linux/igmp.h            | 2 +-
 compat-include/linux/minmax.h          | 2 +-
 compat-include/linux/netdevice.h       | 2 +-
 compat-include/linux/netlink.h         | 2 +-
 compat-include/linux/prandom.h         | 2 +-
 compat-include/linux/rcupdate.h        | 2 +-
 compat-include/linux/skbuff.h          | 2 +-
 compat-include/linux/stddef.h          | 2 +-
 compat-include/linux/timer.h           | 2 +-
 compat-include/linux/version.h         | 2 +-
 compat-include/net/addrconf.h          | 2 +-
 compat-include/net/cfg80211.h          | 2 +-
 compat-include/net/genetlink.h         | 2 +-
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
 net/batman-adv/tp_meter.c              | 2 +-
 net/batman-adv/tp_meter.h              | 2 +-
 net/batman-adv/trace.c                 | 2 +-
 net/batman-adv/trace.h                 | 2 +-
 net/batman-adv/translation-table.c     | 2 +-
 net/batman-adv/translation-table.h     | 2 +-
 net/batman-adv/tvlv.c                  | 2 +-
 net/batman-adv/tvlv.h                  | 2 +-
 net/batman-adv/types.h                 | 2 +-
 79 files changed, 79 insertions(+), 79 deletions(-)

diff --git a/Makefile b/Makefile
index a0bb112a..545053b5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 
diff --git a/compat-include/linux/average.h b/compat-include/linux/average.h
index 347fdeae..a9bd0561 100644
--- a/compat-include/linux/average.h
+++ b/compat-include/linux/average.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/build_bug.h b/compat-include/linux/build_bug.h
index 5996d9e7..9cf28f04 100644
--- a/compat-include/linux/build_bug.h
+++ b/compat-include/linux/build_bug.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/cache.h b/compat-include/linux/cache.h
index 82547e5c..ae0e62df 100644
--- a/compat-include/linux/cache.h
+++ b/compat-include/linux/cache.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/compiler.h b/compat-include/linux/compiler.h
index 43e12a78..4aa525a5 100644
--- a/compat-include/linux/compiler.h
+++ b/compat-include/linux/compiler.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/ethtool.h b/compat-include/linux/ethtool.h
index 6dd2a74c..e9324da1 100644
--- a/compat-include/linux/ethtool.h
+++ b/compat-include/linux/ethtool.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2016-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2021  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/compat-include/linux/if_bridge.h b/compat-include/linux/if_bridge.h
index 45585003..a0c53553 100644
--- a/compat-include/linux/if_bridge.h
+++ b/compat-include/linux/if_bridge.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/igmp.h b/compat-include/linux/igmp.h
index cea5bfe9..09dbac8b 100644
--- a/compat-include/linux/igmp.h
+++ b/compat-include/linux/igmp.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/minmax.h b/compat-include/linux/minmax.h
index 4b19479b..b8ea5e8a 100644
--- a/compat-include/linux/minmax.h
+++ b/compat-include/linux/minmax.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 5dd27341..41521705 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/netlink.h b/compat-include/linux/netlink.h
index 27dc6581..f1fbdd1e 100644
--- a/compat-include/linux/netlink.h
+++ b/compat-include/linux/netlink.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/prandom.h b/compat-include/linux/prandom.h
index 9d30d2d9..a6a448d3 100644
--- a/compat-include/linux/prandom.h
+++ b/compat-include/linux/prandom.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/rcupdate.h b/compat-include/linux/rcupdate.h
index d8647445..aa8c09f7 100644
--- a/compat-include/linux/rcupdate.h
+++ b/compat-include/linux/rcupdate.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2021  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index 0d3631d2..4a7f2b39 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/stddef.h b/compat-include/linux/stddef.h
index be4e31e9..e71fc78a 100644
--- a/compat-include/linux/stddef.h
+++ b/compat-include/linux/stddef.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/timer.h b/compat-include/linux/timer.h
index 8a4e714c..56b310f5 100644
--- a/compat-include/linux/timer.h
+++ b/compat-include/linux/timer.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/version.h b/compat-include/linux/version.h
index 5582e8cb..610fa05c 100644
--- a/compat-include/linux/version.h
+++ b/compat-include/linux/version.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/net/addrconf.h b/compat-include/net/addrconf.h
index 8914a66b..ad64a9a6 100644
--- a/compat-include/net/addrconf.h
+++ b/compat-include/net/addrconf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/net/cfg80211.h b/compat-include/net/cfg80211.h
index 288c1be1..ee8aee37 100644
--- a/compat-include/net/cfg80211.h
+++ b/compat-include/net/cfg80211.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
index f16355fe..3eab6a77 100644
--- a/compat-include/net/genetlink.h
+++ b/compat-include/net/genetlink.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat.h b/compat.h
index 9da9feb7..55cd93ec 100644
--- a/compat.h
+++ b/compat.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index c7b2bd93..35fbf0bd 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -1,6 +1,6 @@
 #! /bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 
diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 9c8604c5..67b773ea 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index bdb317fa..27d35e7f 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: MIT */
-/* Copyright (C) 2016-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2021  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  */
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 993afd5f..497ad1cf 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 8010c34b..c5071737 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 
diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index c5f404f6..8b66a57a 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 43b045ac..4073fa7e 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2011-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Linus Lüssing
  */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 168621c9..4c583eec 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/bat_iv_ogm.h b/net/batman-adv/bat_iv_ogm.h
index 0c57c100..b6e7f322 100644
--- a/net/batman-adv/bat_iv_ogm.h
+++ b/net/batman-adv/bat_iv_ogm.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index e4455bab..089b3e50 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2021  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
  */
diff --git a/net/batman-adv/bat_v.h b/net/batman-adv/bat_v.h
index 5e0be10b..bc07ae6a 100644
--- a/net/batman-adv/bat_v.h
+++ b/net/batman-adv/bat_v.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2011-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Linus Lüssing
  */
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 0512ea6c..3f01881b 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2011-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2021  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
  */
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index 4358d436..5c678079 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2013-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2021  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
  */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 798d6598..20d7928c 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2021  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  */
diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
index 0ae2575f..a509004f 100644
--- a/net/batman-adv/bat_v_ogm.h
+++ b/net/batman-adv/bat_v_ogm.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2013-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2021  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  */
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 4bc695cd..27be6cae 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2006-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2021  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  */
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index 533c6d44..704afafa 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2006-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2021  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  */
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index d2de12e5..d4184bfb 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2011-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2021  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  */
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 7dc6d357..73f01206 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2011-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2021  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  */
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index fd7ba6bb..443682a9 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2011-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2021  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  */
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index e980fb45..efa2a0d0 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2011-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2021  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  */
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index e522f1fc..89344632 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2021  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  */
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index 881ef328..86d6b856 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2013-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2021  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  */
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index cffe72f4..2ebfe62d 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  */
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 2fbc500f..5c8c0b92 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  */
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 16cd9450..7208b7ad 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  */
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index c3a0c5a7..9ccf195a 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  */
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 0f186ddc..6e3c7a6c 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index f4b8e9ef..bfaf4f88 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index 68638e04..1bcfdcf4 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2006-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2021  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  */
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 91ae9f32..276b3080 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2006-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2021  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  */
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index b7e9923b..7db20058 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2010-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  */
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 979864c0..1f50296d 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index ed9d87ce..e3eadd64 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 28820163..3e7fcc1d 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 854e5ff2..8db5d285 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2014-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2014-2021  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
  */
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index d61593d0..d13efd4b 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2014-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2014-2021  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
  */
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 97bcf149..8eef71a6 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2016-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2021  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  */
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 7ee48f91..48455ac2 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2016-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2021  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  */
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 0cec108b..24f76101 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2021  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
  */
diff --git a/net/batman-adv/network-coding.h b/net/batman-adv/network-coding.h
index 8fb2c01e..e7f87d32 100644
--- a/net/batman-adv/network-coding.h
+++ b/net/batman-adv/network-coding.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2021  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
  */
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 77431e59..88496f4e 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index e75d4c4d..620d02f7 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 49cbca4a..7cc6a549 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 2ed49db6..24238091 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 87017332..990e5854 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 0d36e155..27c45eec 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 97118efb..7395a545 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 74716d9c..34d4f583 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  */
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index d4e10005..e61925f1 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2021  B.A.T.M.A.N. contributors:
  *
  * Edo Monticelli, Antonio Quartulli
  */
diff --git a/net/batman-adv/tp_meter.h b/net/batman-adv/tp_meter.h
index 14010521..0b7904bd 100644
--- a/net/batman-adv/tp_meter.h
+++ b/net/batman-adv/tp_meter.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2021  B.A.T.M.A.N. contributors:
  *
  * Edo Monticelli, Antonio Quartulli
  */
diff --git a/net/batman-adv/trace.c b/net/batman-adv/trace.c
index 3444d9e4..b2452822 100644
--- a/net/batman-adv/trace.c
+++ b/net/batman-adv/trace.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2010-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2021  B.A.T.M.A.N. contributors:
  *
  * Sven Eckelmann
  */
diff --git a/net/batman-adv/trace.h b/net/batman-adv/trace.h
index a8754757..bd5e4525 100644
--- a/net/batman-adv/trace.h
+++ b/net/batman-adv/trace.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2010-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2021  B.A.T.M.A.N. contributors:
  *
  * Sven Eckelmann
  */
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index cd09916f..badf1439 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  */
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 57192c81..913c4455 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  */
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 6a23a566..7de7dd72 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index d509d00c..4c3265d3 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 2f96e96a..65985e26 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
-- 
2.29.2

