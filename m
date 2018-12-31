Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  1 Jan 2019 00:00:01 +0100
Message-Id: <20181231230001.17417-4-sven@narfation.org>
In-Reply-To: <20181231230001.17417-1-sven@narfation.org>
References: <20181231230001.17417-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batctl: Update copyright years for 2019
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
 event.c                 | 2 +-
 fragmentation.c         | 2 +-
 functions.c             | 2 +-
 functions.h             | 2 +-
 gateways.c              | 2 +-
 genl.h                  | 2 +-
 gw_mode.c               | 2 +-
 hash.c                  | 2 +-
 hash.h                  | 2 +-
 icmp_helper.c           | 2 +-
 icmp_helper.h           | 2 +-
 interface.c             | 2 +-
 isolation_mark.c        | 2 +-
 list.h                  | 2 +-
 log.c                   | 2 +-
 loglevel.c              | 2 +-
 main.c                  | 2 +-
 main.h                  | 2 +-
 mcast_flags.c           | 2 +-
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
 throughputmeter.c       | 2 +-
 traceroute.c            | 2 +-
 transglobal.c           | 2 +-
 translate.c             | 2 +-
 translocal.c            | 2 +-
 57 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/Makefile b/Makefile
index e6b2412..4d8b709 100755
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # -*- makefile -*-
 #
-# Copyright (C) 2006-2018  B.A.T.M.A.N. contributors
+# Copyright (C) 2006-2019  B.A.T.M.A.N. contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/aggregation.c b/aggregation.c
index 57c1dbb..40d1985 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/allocate.h b/allocate.h
index cc4c283..6c14609 100644
--- a/allocate.h
+++ b/allocate.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/ap_isolation.c b/ap_isolation.c
index 2d16c68..9cca943 100644
--- a/ap_isolation.c
+++ b/ap_isolation.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli <a@unstable.cc>
  *
diff --git a/backbonetable.c b/backbonetable.c
index b82fbe7..878edc0 100644
--- a/backbonetable.c
+++ b/backbonetable.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich <sw@simonwunderlich.de>
  *
diff --git a/bat-hosts.c b/bat-hosts.c
index 02c4d81..8be8c75 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bat-hosts.h b/bat-hosts.h
index 20ac32d..85e75b7 100644
--- a/bat-hosts.h
+++ b/bat-hosts.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/batadv_packet.h b/batadv_packet.h
index 894d8d2..7eb2936 100644
--- a/batadv_packet.h
+++ b/batadv_packet.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/batman_adv.h b/batman_adv.h
index 324a0e1..a28e76a 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: MIT */
-/* Copyright (C) 2016-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2019  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  *
diff --git a/bisect_iv.c b/bisect_iv.c
index 420317e..019a35a 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bisect_iv.h b/bisect_iv.h
index 5f5200c..5ac6b9a 100644
--- a/bisect_iv.h
+++ b/bisect_iv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bonding.c b/bonding.c
index f7105c9..3deba19 100644
--- a/bonding.c
+++ b/bonding.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 04b41e0..d53c278 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich <sw@simonwunderlich.de>
  *
diff --git a/claimtable.c b/claimtable.c
index 5410392..fd083c9 100644
--- a/claimtable.c
+++ b/claimtable.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
  *
diff --git a/dat_cache.c b/dat_cache.c
index edf8c72..21e96d9 100644
--- a/dat_cache.c
+++ b/dat_cache.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/debug.c b/debug.c
index 182877a..83130bf 100644
--- a/debug.c
+++ b/debug.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/debug.h b/debug.h
index f1a3fd4..11a805c 100644
--- a/debug.h
+++ b/debug.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/distributed_arp_table.c b/distributed_arp_table.c
index c3595fc..38e4a05 100644
--- a/distributed_arp_table.c
+++ b/distributed_arp_table.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli <a@unstable.cc>
  *
diff --git a/event.c b/event.c
index 8eda269..f5d81c2 100644
--- a/event.c
+++ b/event.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Sven Eckelmann <sven@narfation.org>
  *
diff --git a/fragmentation.c b/fragmentation.c
index e159bdd..6c3ece5 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/functions.c b/functions.c
index 9d64c62..98dea77 100644
--- a/functions.c
+++ b/functions.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/functions.h b/functions.h
index c16ba2e..a7ae1eb 100644
--- a/functions.h
+++ b/functions.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/gateways.c b/gateways.c
index ff7693f..46d41b3 100644
--- a/gateways.c
+++ b/gateways.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
  *
diff --git a/genl.h b/genl.h
index a0f05ba..8f6be80 100644
--- a/genl.h
+++ b/genl.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/gw_mode.c b/gw_mode.c
index 4093f89..b949970 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/hash.c b/hash.c
index e604634..5f93367 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2006-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hash.h b/hash.h
index ceb1857..75577f8 100644
--- a/hash.h
+++ b/hash.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2006-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/icmp_helper.c b/icmp_helper.c
index 00c5229..69c8505 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich
  *
diff --git a/icmp_helper.h b/icmp_helper.h
index 8075655..f377303 100644
--- a/icmp_helper.h
+++ b/icmp_helper.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/interface.c b/interface.c
index 3c176a8..25b4af9 100644
--- a/interface.c
+++ b/interface.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/isolation_mark.c b/isolation_mark.c
index 13ba869..c9d296e 100644
--- a/isolation_mark.c
+++ b/isolation_mark.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli <a@unstable.cc>
  *
diff --git a/list.h b/list.h
index 4e8f28f..e7d72c2 100644
--- a/list.h
+++ b/list.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: MIT */
 /* Minimal Linux-like double-linked list helper functions
  *
- * Copyright (c) 2012-2018, Sven Eckelmann <sven@narfation.org>
+ * Copyright (c) 2012-2019, Sven Eckelmann <sven@narfation.org>
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
diff --git a/log.c b/log.c
index cd69676..b5f65f7 100644
--- a/log.c
+++ b/log.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/loglevel.c b/loglevel.c
index b5bbd0d..de1f351 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/main.c b/main.c
index ab7da45..cf62b15 100644
--- a/main.c
+++ b/main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/main.h b/main.h
index 276a018..029319c 100644
--- a/main.h
+++ b/main.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/mcast_flags.c b/mcast_flags.c
index 0dc4227..ef4b440 100644
--- a/mcast_flags.c
+++ b/mcast_flags.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/multicast_mode.c b/multicast_mode.c
index b65732d..1c56faa 100644
--- a/multicast_mode.c
+++ b/multicast_mode.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
  *
diff --git a/nc_nodes.c b/nc_nodes.c
index 9cf437d..7c75a91 100644
--- a/nc_nodes.c
+++ b/nc_nodes.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/neighbors.c b/neighbors.c
index 76b45ea..f725674 100644
--- a/neighbors.c
+++ b/neighbors.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/netlink.c b/netlink.c
index 5285759..4d1a3bf 100644
--- a/netlink.c
+++ b/netlink.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/netlink.h b/netlink.h
index b91ca10..6aec1a8 100644
--- a/netlink.h
+++ b/netlink.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/network_coding.c b/network_coding.c
index 076f4cf..f4f184b 100644
--- a/network_coding.c
+++ b/network_coding.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  *
diff --git a/orig_interval.c b/orig_interval.c
index d308ea2..2afed61 100644
--- a/orig_interval.c
+++ b/orig_interval.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/originators.c b/originators.c
index 7dc9b4c..57476c0 100644
--- a/originators.c
+++ b/originators.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
  * Sven Eckelmann <sven@narfation.org>
diff --git a/ping.c b/ping.c
index 5c13d81..14fea21 100644
--- a/ping.c
+++ b/ping.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/routing_algo.c b/routing_algo.c
index 18d9ef7..79116ef 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/statistics.c b/statistics.c
index d684fa5..f8cb6a1 100644
--- a/statistics.c
+++ b/statistics.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/sys.c b/sys.c
index 6b98ac4..27da5b9 100644
--- a/sys.c
+++ b/sys.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/sys.h b/sys.h
index b493219..baa5996 100644
--- a/sys.h
+++ b/sys.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/tcpdump.c b/tcpdump.c
index 42713d3..1a6df10 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>
  *
diff --git a/tcpdump.h b/tcpdump.h
index db92fce..76a41f1 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/throughputmeter.c b/throughputmeter.c
index de20b66..5f68a8a 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli <a@unstable.cc>
  *
diff --git a/traceroute.c b/traceroute.c
index 6e325c4..53fa1ae 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/transglobal.c b/transglobal.c
index fbbce25..ba25be4 100644
--- a/transglobal.c
+++ b/transglobal.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
  * Sven Eckelmann <sven@narfation.org>
diff --git a/translate.c b/translate.c
index ad51ddf..176acc4 100644
--- a/translate.c
+++ b/translate.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/translocal.c b/translocal.c
index 1057abd..838b90b 100644
--- a/translocal.c
+++ b/translocal.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
  * Sven Eckelmann <sven@narfation.org>
-- 
2.19.2

