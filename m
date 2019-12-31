Return-Path: <sven@dvalin.narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/3] batctl: Update copyright years for 2020
Date: Wed,  1 Jan 2020 00:01:00 +0100
Message-Id: <20191231230101.32668-2-sven@narfation.org>
In-Reply-To: <20191231230101.32668-1-sven@narfation.org>
References: <20191231230101.32668-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
 nc_nodes.c              | 2 +-
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
 61 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/Makefile b/Makefile
index e3747a2..780c2c0 100755
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # -*- makefile -*-
 #
-# Copyright (C) 2006-2019  B.A.T.M.A.N. contributors
+# Copyright (C) 2006-2020  B.A.T.M.A.N. contributors
 #
 # License-Filename: LICENSES/preferred/GPL-2.0
 
diff --git a/aggregation.c b/aggregation.c
index b9edd94..11327d3 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/allocate.h b/allocate.h
index 69353a2..1164948 100644
--- a/allocate.h
+++ b/allocate.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/ap_isolation.c b/ap_isolation.c
index 66f8340..df19072 100644
--- a/ap_isolation.c
+++ b/ap_isolation.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli <a@unstable.cc>
  *
diff --git a/backbonetable.c b/backbonetable.c
index 2e22e34..4774edf 100644
--- a/backbonetable.c
+++ b/backbonetable.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich <sw@simonwunderlich.de>
  *
diff --git a/bat-hosts.c b/bat-hosts.c
index 1e9c21b..99d6151 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bat-hosts.h b/bat-hosts.h
index fff81f0..8c0c43b 100644
--- a/bat-hosts.h
+++ b/bat-hosts.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/batadv_packet.h b/batadv_packet.h
index 2a15f01..0ae34c8 100644
--- a/batadv_packet.h
+++ b/batadv_packet.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
-/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  */
diff --git a/batman_adv.h b/batman_adv.h
index 67f4636..617c180 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: MIT */
-/* Copyright (C) 2016-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2020  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  */
diff --git a/bisect_iv.c b/bisect_iv.c
index 7f03823..1932150 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bisect_iv.h b/bisect_iv.h
index cf20196..1a1a9ce 100644
--- a/bisect_iv.h
+++ b/bisect_iv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bonding.c b/bonding.c
index e41379c..db0782c 100644
--- a/bonding.c
+++ b/bonding.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 2994d2e..6572f6a 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich <sw@simonwunderlich.de>
  *
diff --git a/claimtable.c b/claimtable.c
index 2de7c79..c4664d4 100644
--- a/claimtable.c
+++ b/claimtable.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
  *
diff --git a/dat_cache.c b/dat_cache.c
index 4a8a082..a2fee2a 100644
--- a/dat_cache.c
+++ b/dat_cache.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/debug.c b/debug.c
index 597d59c..66ddc3b 100644
--- a/debug.c
+++ b/debug.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/debug.h b/debug.h
index bae33e5..9d0bb92 100644
--- a/debug.h
+++ b/debug.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/distributed_arp_table.c b/distributed_arp_table.c
index ad88d43..4e244ef 100644
--- a/distributed_arp_table.c
+++ b/distributed_arp_table.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli <a@unstable.cc>
  *
diff --git a/elp_interval.c b/elp_interval.c
index 0a5e989..f551b1f 100644
--- a/elp_interval.c
+++ b/elp_interval.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/event.c b/event.c
index c1eb435..cebb803 100644
--- a/event.c
+++ b/event.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Sven Eckelmann <sven@narfation.org>
  *
diff --git a/fragmentation.c b/fragmentation.c
index eea2a08..a8cb1e6 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/functions.c b/functions.c
index 69d063e..3223472 100644
--- a/functions.c
+++ b/functions.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/functions.h b/functions.h
index 31806d4..b2180e8 100644
--- a/functions.h
+++ b/functions.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/gateways.c b/gateways.c
index ccb2b44..2db4b17 100644
--- a/gateways.c
+++ b/gateways.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
  *
diff --git a/genl.h b/genl.h
index 25ee32a..7c2486b 100644
--- a/genl.h
+++ b/genl.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/gw_mode.c b/gw_mode.c
index 97ea65f..beaa83f 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/hash.c b/hash.c
index 4ff54bc..cbbeda1 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hash.h b/hash.h
index d000669..48c3adb 100644
--- a/hash.h
+++ b/hash.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hop_penalty.c b/hop_penalty.c
index 5cfb51a..1f8f1db 100644
--- a/hop_penalty.c
+++ b/hop_penalty.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/icmp_helper.c b/icmp_helper.c
index 26233c7..0ce2d17 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich
  *
diff --git a/icmp_helper.h b/icmp_helper.h
index a2aefcd..897a3a8 100644
--- a/icmp_helper.h
+++ b/icmp_helper.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/interface.c b/interface.c
index c2bfc74..1cd6ede 100644
--- a/interface.c
+++ b/interface.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/isolation_mark.c b/isolation_mark.c
index 340f33d..0865de3 100644
--- a/isolation_mark.c
+++ b/isolation_mark.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli <a@unstable.cc>
  *
diff --git a/list.h b/list.h
index 33445c3..20558d3 100644
--- a/list.h
+++ b/list.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: MIT */
 /* Minimal Linux-like double-linked list helper functions
  *
- * Copyright (c) 2012-2019, Sven Eckelmann <sven@narfation.org>
+ * Copyright (c) 2012-2020, Sven Eckelmann <sven@narfation.org>
  *
  * License-Filename: LICENSES/preferred/MIT
  */
diff --git a/loglevel.c b/loglevel.c
index 2e07edc..69f1855 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/main.c b/main.c
index 9e0a943..f6337d6 100644
--- a/main.c
+++ b/main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/main.h b/main.h
index 99f3e33..5014e78 100644
--- a/main.h
+++ b/main.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/mcast_flags.c b/mcast_flags.c
index 6af544b..363b6e8 100644
--- a/mcast_flags.c
+++ b/mcast_flags.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/multicast_fanout.c b/multicast_fanout.c
index bea83c5..dcc4fc6 100644
--- a/multicast_fanout.c
+++ b/multicast_fanout.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
  *
diff --git a/multicast_forceflood.c b/multicast_forceflood.c
index f15cc12..a33149f 100644
--- a/multicast_forceflood.c
+++ b/multicast_forceflood.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
  *
diff --git a/multicast_mode.c b/multicast_mode.c
index e11d3af..a46cfc9 100644
--- a/multicast_mode.c
+++ b/multicast_mode.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
  *
diff --git a/nc_nodes.c b/nc_nodes.c
index baf4565..be4e804 100644
--- a/nc_nodes.c
+++ b/nc_nodes.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/neighbors.c b/neighbors.c
index 1a41d62..dc6913a 100644
--- a/neighbors.c
+++ b/neighbors.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/netlink.c b/netlink.c
index 792249f..8a46f36 100644
--- a/netlink.c
+++ b/netlink.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/netlink.h b/netlink.h
index 38868b7..34622ad 100644
--- a/netlink.h
+++ b/netlink.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/network_coding.c b/network_coding.c
index 0fdcc78..a733c6b 100644
--- a/network_coding.c
+++ b/network_coding.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  *
diff --git a/orig_interval.c b/orig_interval.c
index f0e75c9..25e67e5 100644
--- a/orig_interval.c
+++ b/orig_interval.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/originators.c b/originators.c
index 32c1300..f9bf21d 100644
--- a/originators.c
+++ b/originators.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
  * Sven Eckelmann <sven@narfation.org>
diff --git a/ping.c b/ping.c
index cc0ac0f..17cdf87 100644
--- a/ping.c
+++ b/ping.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/routing_algo.c b/routing_algo.c
index d4e205d..7171c52 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/statistics.c b/statistics.c
index c019d87..e88ab30 100644
--- a/statistics.c
+++ b/statistics.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/sys.c b/sys.c
index fe388fe..c76ad15 100644
--- a/sys.c
+++ b/sys.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/sys.h b/sys.h
index b6f0f90..b4e4bca 100644
--- a/sys.h
+++ b/sys.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/tcpdump.c b/tcpdump.c
index 0e2ae8e..4b9e4f6 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>
  *
diff --git a/tcpdump.h b/tcpdump.h
index 470b96a..9ce8f88 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/throughput_override.c b/throughput_override.c
index 28a6588..e9f0346 100644
--- a/throughput_override.c
+++ b/throughput_override.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/throughputmeter.c b/throughputmeter.c
index a46347d..27f1346 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2020  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli <a@unstable.cc>
  *
diff --git a/traceroute.c b/traceroute.c
index 07ba37f..8a6414b 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/transglobal.c b/transglobal.c
index 4de441c..3b23792 100644
--- a/transglobal.c
+++ b/transglobal.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
  * Sven Eckelmann <sven@narfation.org>
diff --git a/translate.c b/translate.c
index 27d53e5..b910a97 100644
--- a/translate.c
+++ b/translate.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2020  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/translocal.c b/translocal.c
index f309af5..59c00c2 100644
--- a/translocal.c
+++ b/translocal.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
  * Sven Eckelmann <sven@narfation.org>
-- 
2.20.1

