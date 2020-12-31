Return-Path: <sven@dvalin.narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/3] batctl: Update copyright years for 2021
Date: Fri,  1 Jan 2021 00:01:01 +0100
Message-Id: <20201231230102.10127-2-sven@narfation.org>
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
 Makefile                | 2 +-
 aggregation.c           | 2 +-
 allocate.h              | 2 +-
 ap_isolation.c          | 2 +-
 backbonetable.c         | 2 +-
 bat-hosts.c             | 2 +-
 bat-hosts.h             | 2 +-
 batadv_packet.h         | 2 +-
 batman_adv.h            | 2 +-
 bisect_iv.c             | 2 +-
 bisect_iv.h             | 2 +-
 bonding.c               | 2 +-
 bridge_loop_avoidance.c | 2 +-
 claimtable.c            | 2 +-
 dat_cache.c             | 2 +-
 debug.c                 | 2 +-
 debug.h                 | 2 +-
 distributed_arp_table.c | 2 +-
 elp_interval.c          | 2 +-
 event.c                 | 2 +-
 fragmentation.c         | 2 +-
 functions.c             | 2 +-
 functions.h             | 2 +-
 gateways.c              | 2 +-
 genl.h                  | 2 +-
 gw_mode.c               | 2 +-
 hash.c                  | 2 +-
 hash.h                  | 2 +-
 hop_penalty.c           | 2 +-
 icmp_helper.c           | 2 +-
 icmp_helper.h           | 2 +-
 interface.c             | 2 +-
 isolation_mark.c        | 2 +-
 list.h                  | 2 +-
 loglevel.c              | 2 +-
 main.c                  | 2 +-
 main.h                  | 2 +-
 mcast_flags.c           | 2 +-
 multicast_fanout.c      | 2 +-
 multicast_forceflood.c  | 2 +-
 multicast_mode.c        | 2 +-
 neighbors.c             | 2 +-
 netlink.c               | 2 +-
 netlink.h               | 2 +-
 network_coding.c        | 2 +-
 orig_interval.c         | 2 +-
 originators.c           | 2 +-
 ping.c                  | 2 +-
 routing_algo.c          | 2 +-
 statistics.c            | 2 +-
 sys.c                   | 2 +-
 sys.h                   | 2 +-
 tcpdump.c               | 2 +-
 tcpdump.h               | 2 +-
 throughput_override.c   | 2 +-
 throughputmeter.c       | 2 +-
 traceroute.c            | 2 +-
 transglobal.c           | 2 +-
 translate.c             | 2 +-
 translocal.c            | 2 +-
 60 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/Makefile b/Makefile
index 71fdf88..68d8dc8 100755
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # -*- makefile -*-
 #
-# Copyright (C) 2006-2020  B.A.T.M.A.N. contributors
+# Copyright (C) 2006-2021  B.A.T.M.A.N. contributors
 #
 # License-Filename: LICENSES/preferred/GPL-2.0
 
diff --git a/aggregation.c b/aggregation.c
index 5d06471..e09b4c7 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/allocate.h b/allocate.h
index 1164948..bf30c50 100644
--- a/allocate.h
+++ b/allocate.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/ap_isolation.c b/ap_isolation.c
index 2f18015..dcbefe7 100644
--- a/ap_isolation.c
+++ b/ap_isolation.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli <a@unstable.cc>
  *
diff --git a/backbonetable.c b/backbonetable.c
index 84667c4..0f44323 100644
--- a/backbonetable.c
+++ b/backbonetable.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich <sw@simonwunderlich.de>
  *
diff --git a/bat-hosts.c b/bat-hosts.c
index 99d6151..3ac4288 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bat-hosts.h b/bat-hosts.h
index 8c0c43b..415cd3f 100644
--- a/bat-hosts.h
+++ b/bat-hosts.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/batadv_packet.h b/batadv_packet.h
index 9c8604c..67b773e 100644
--- a/batadv_packet.h
+++ b/batadv_packet.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/batman_adv.h b/batman_adv.h
index bdb317f..27d35e7 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: MIT */
-/* Copyright (C) 2016-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2021  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  */
diff --git a/bisect_iv.c b/bisect_iv.c
index 1932150..cecdfd5 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bisect_iv.h b/bisect_iv.h
index 1a1a9ce..11cac66 100644
--- a/bisect_iv.h
+++ b/bisect_iv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bonding.c b/bonding.c
index ee4d314..d597f57 100644
--- a/bonding.c
+++ b/bonding.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 3525a3e..5fea1c1 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich <sw@simonwunderlich.de>
  *
diff --git a/claimtable.c b/claimtable.c
index c41d9c3..d1df97e 100644
--- a/claimtable.c
+++ b/claimtable.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
  *
diff --git a/dat_cache.c b/dat_cache.c
index 1549c3d..2c959ff 100644
--- a/dat_cache.c
+++ b/dat_cache.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/debug.c b/debug.c
index 55520cb..5619eb0 100644
--- a/debug.c
+++ b/debug.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/debug.h b/debug.h
index f849d19..c6b4714 100644
--- a/debug.h
+++ b/debug.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/distributed_arp_table.c b/distributed_arp_table.c
index 1bccba1..f90955a 100644
--- a/distributed_arp_table.c
+++ b/distributed_arp_table.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli <a@unstable.cc>
  *
diff --git a/elp_interval.c b/elp_interval.c
index f4312e7..a234c75 100644
--- a/elp_interval.c
+++ b/elp_interval.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/event.c b/event.c
index 3fbc6cc..a902943 100644
--- a/event.c
+++ b/event.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Sven Eckelmann <sven@narfation.org>
  *
diff --git a/fragmentation.c b/fragmentation.c
index 65e4356..92624e6 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/functions.c b/functions.c
index 4df1815..7378569 100644
--- a/functions.c
+++ b/functions.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/functions.h b/functions.h
index 923e593..65f9bd6 100644
--- a/functions.h
+++ b/functions.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/gateways.c b/gateways.c
index 31979a2..506fa67 100644
--- a/gateways.c
+++ b/gateways.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
  *
diff --git a/genl.h b/genl.h
index 7c2486b..47ed233 100644
--- a/genl.h
+++ b/genl.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/gw_mode.c b/gw_mode.c
index e48b78d..e555e50 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/hash.c b/hash.c
index cbbeda1..f536327 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2006-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2021  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hash.h b/hash.h
index 48c3adb..bda40ac 100644
--- a/hash.h
+++ b/hash.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2006-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2021  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hop_penalty.c b/hop_penalty.c
index 7430381..c142ff2 100644
--- a/hop_penalty.c
+++ b/hop_penalty.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/icmp_helper.c b/icmp_helper.c
index a167e2a..1de5625 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich
  *
diff --git a/icmp_helper.h b/icmp_helper.h
index 897a3a8..17b478d 100644
--- a/icmp_helper.h
+++ b/icmp_helper.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/interface.c b/interface.c
index 77ca1a0..367cec4 100644
--- a/interface.c
+++ b/interface.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/isolation_mark.c b/isolation_mark.c
index b0048f3..f8cd1a7 100644
--- a/isolation_mark.c
+++ b/isolation_mark.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli <a@unstable.cc>
  *
diff --git a/list.h b/list.h
index 20558d3..ab9c0a3 100644
--- a/list.h
+++ b/list.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: MIT */
 /* Minimal Linux-like double-linked list helper functions
  *
- * Copyright (c) 2012-2020, Sven Eckelmann <sven@narfation.org>
+ * Copyright (c) 2012-2021, Sven Eckelmann <sven@narfation.org>
  *
  * License-Filename: LICENSES/preferred/MIT
  */
diff --git a/loglevel.c b/loglevel.c
index af7349d..203eeff 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/main.c b/main.c
index 54be6fb..77bbdfb 100644
--- a/main.c
+++ b/main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/main.h b/main.h
index a53acc8..5883973 100644
--- a/main.h
+++ b/main.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/mcast_flags.c b/mcast_flags.c
index 63a2c50..3a1e013 100644
--- a/mcast_flags.c
+++ b/mcast_flags.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/multicast_fanout.c b/multicast_fanout.c
index b43ff10..3e86c9c 100644
--- a/multicast_fanout.c
+++ b/multicast_fanout.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
  *
diff --git a/multicast_forceflood.c b/multicast_forceflood.c
index e02ab9d..f47e780 100644
--- a/multicast_forceflood.c
+++ b/multicast_forceflood.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
  *
diff --git a/multicast_mode.c b/multicast_mode.c
index f837998..9fc4a08 100644
--- a/multicast_mode.c
+++ b/multicast_mode.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
  *
diff --git a/neighbors.c b/neighbors.c
index afc65de..47daee6 100644
--- a/neighbors.c
+++ b/neighbors.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/netlink.c b/netlink.c
index 8a46f36..160dcbf 100644
--- a/netlink.c
+++ b/netlink.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/netlink.h b/netlink.h
index 34622ad..130478f 100644
--- a/netlink.h
+++ b/netlink.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/network_coding.c b/network_coding.c
index 9868e54..f053ee5 100644
--- a/network_coding.c
+++ b/network_coding.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  *
diff --git a/orig_interval.c b/orig_interval.c
index 2cdad1a..7b69e95 100644
--- a/orig_interval.c
+++ b/orig_interval.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/originators.c b/originators.c
index 793743a..e4d8cc3 100644
--- a/originators.c
+++ b/originators.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
  * Sven Eckelmann <sven@narfation.org>
diff --git a/ping.c b/ping.c
index 17cdf87..de5f340 100644
--- a/ping.c
+++ b/ping.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/routing_algo.c b/routing_algo.c
index 27458ff..a870364 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/statistics.c b/statistics.c
index e88ab30..0f48870 100644
--- a/statistics.c
+++ b/statistics.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/sys.c b/sys.c
index cde5002..ae3e5cd 100644
--- a/sys.c
+++ b/sys.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/sys.h b/sys.h
index ac7781f..76953c5 100644
--- a/sys.h
+++ b/sys.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/tcpdump.c b/tcpdump.c
index b9edc20..eacb28a 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>
  *
diff --git a/tcpdump.h b/tcpdump.h
index 9ce8f88..eea92e3 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/throughput_override.c b/throughput_override.c
index f42d9de..446614b 100644
--- a/throughput_override.c
+++ b/throughput_override.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/throughputmeter.c b/throughputmeter.c
index 4a233d5..05aac97 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2021  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli <a@unstable.cc>
  *
diff --git a/traceroute.c b/traceroute.c
index 8a6414b..dbda7a5 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/transglobal.c b/transglobal.c
index 5aede41..abc3b60 100644
--- a/transglobal.c
+++ b/transglobal.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
  * Sven Eckelmann <sven@narfation.org>
diff --git a/translate.c b/translate.c
index b910a97..7df973e 100644
--- a/translate.c
+++ b/translate.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2021  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/translocal.c b/translocal.c
index 45e884c..31f2f91 100644
--- a/translocal.c
+++ b/translocal.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2021  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
  * Sven Eckelmann <sven@narfation.org>
-- 
2.29.2

