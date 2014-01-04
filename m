Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat,  4 Jan 2014 18:04:25 +0100
Message-Id: <1388855065-8966-2-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1388855065-8966-1-git-send-email-sw@simonwunderlich.de>
References: <1388855065-8966-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] =?utf-8?q?=5BPATCH-next_2/2=5D_batman-adv=3A_updat?=
	=?utf-8?q?e_copyright_years_for_2014?=
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
To: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 Makefile                |    2 +-
 Makefile.kbuild         |    2 +-
 bat_algo.h              |    2 +-
 bat_iv_ogm.c            |    2 +-
 bitarray.c              |    2 +-
 bitarray.h              |    2 +-
 bridge_loop_avoidance.c |    2 +-
 bridge_loop_avoidance.h |    2 +-
 compat.c                |    2 +-
 compat.h                |    2 +-
 debugfs.c               |    2 +-
 debugfs.h               |    2 +-
 distributed-arp-table.c |    2 +-
 distributed-arp-table.h |    2 +-
 fragmentation.c         |    2 +-
 fragmentation.h         |    2 +-
 gateway_client.c        |    2 +-
 gateway_client.h        |    2 +-
 gateway_common.c        |    2 +-
 gateway_common.h        |    2 +-
 hard-interface.c        |    2 +-
 hard-interface.h        |    2 +-
 hash.c                  |    2 +-
 hash.h                  |    2 +-
 icmp_socket.c           |    2 +-
 icmp_socket.h           |    2 +-
 main.c                  |    2 +-
 main.h                  |    2 +-
 network-coding.c        |    2 +-
 network-coding.h        |    2 +-
 originator.c            |    2 +-
 originator.h            |    2 +-
 packet.h                |    2 +-
 routing.c               |    2 +-
 routing.h               |    2 +-
 send.c                  |    2 +-
 send.h                  |    2 +-
 soft-interface.c        |    2 +-
 soft-interface.h        |    2 +-
 sysfs.c                 |    2 +-
 sysfs.h                 |    2 +-
 translation-table.c     |    2 +-
 translation-table.h     |    2 +-
 types.h                 |    2 +-
 44 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/Makefile b/Makefile
index 407cdc4..f4707ce 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/Makefile.kbuild b/Makefile.kbuild
index 4f4aabb..f35a536 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/bat_algo.h b/bat_algo.h
index a4808c2..d31de5f 100644
--- a/bat_algo.h
+++ b/bat_algo.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index b9c8a6e..6f4fcdc 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/bitarray.c b/bitarray.c
index 9739824..8a16601 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/bitarray.h b/bitarray.h
index a81b932..d775d57 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 28eb5e6..60de19a 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2014 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index da173e7..9085748 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2014 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/compat.c b/compat.c
index 68c2258..eda1c07 100644
--- a/compat.c
+++ b/compat.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat.h b/compat.h
index 997b817..a4ab202 100644
--- a/compat.h
+++ b/compat.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/debugfs.c b/debugfs.c
index 049a7a2..908048f 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/debugfs.h b/debugfs.h
index f8c3849..2e74c3c 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index b316a4c..6da587a 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2014 B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 60d853b..5cb7d2a 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2014 B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/fragmentation.c b/fragmentation.c
index 6ddb614..adabcbe 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2014 B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  *
diff --git a/fragmentation.h b/fragmentation.h
index ca029e2..0cf9d73 100644
--- a/fragmentation.h
+++ b/fragmentation.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2014 B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  *
diff --git a/gateway_client.c b/gateway_client.c
index 2449afa..3bf3070 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/gateway_client.h b/gateway_client.h
index d95c2d2..8c4bc40 100644
--- a/gateway_client.h
+++ b/gateway_client.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/gateway_common.c b/gateway_common.c
index b211b0f..ab4e0f9 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/gateway_common.h b/gateway_common.h
index 56384a4..8473f2f 100644
--- a/gateway_common.h
+++ b/gateway_common.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/hard-interface.c b/hard-interface.c
index 57c2a19..6792e03 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/hard-interface.h b/hard-interface.h
index df4c8bd..438e575 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/hash.c b/hash.c
index 7198daf..c36665c 100644
--- a/hash.c
+++ b/hash.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hash.h b/hash.h
index 1b4da72..556243a 100644
--- a/hash.h
+++ b/hash.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/icmp_socket.c b/icmp_socket.c
index 130cc32..0cca6e0 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/icmp_socket.h b/icmp_socket.h
index 6665080..8df38ab 100644
--- a/icmp_socket.h
+++ b/icmp_socket.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/main.c b/main.c
index 1511f64..4547bf0 100644
--- a/main.c
+++ b/main.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/main.h b/main.h
index bca3fc1..87ca2f6 100644
--- a/main.h
+++ b/main.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/network-coding.c b/network-coding.c
index 511d7e1..650721d 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2012-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
  *
diff --git a/network-coding.h b/network-coding.h
index d4fd315..e562c07 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2012-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
  *
diff --git a/originator.c b/originator.c
index 8ab1434..1247f8a 100644
--- a/originator.c
+++ b/originator.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/originator.h b/originator.h
index 6f77d80..566abb1 100644
--- a/originator.h
+++ b/originator.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/packet.h b/packet.h
index 2dd8f24..0b8159c 100644
--- a/packet.h
+++ b/packet.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/routing.c b/routing.c
index 46278bf..f28920f 100644
--- a/routing.c
+++ b/routing.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/routing.h b/routing.h
index 19544dd..82677c4 100644
--- a/routing.h
+++ b/routing.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/send.c b/send.c
index fba4dcf..b0a3d76 100644
--- a/send.c
+++ b/send.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/send.h b/send.h
index aa2e253..6fe6d84 100644
--- a/send.h
+++ b/send.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/soft-interface.c b/soft-interface.c
index a8f99d1..6e8c0ed 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/soft-interface.h b/soft-interface.h
index 06fc91f..8a6a493 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/sysfs.c b/sysfs.c
index 6335433..901a84d 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/sysfs.h b/sysfs.h
index c7d725d..aa648d9 100644
--- a/sysfs.h
+++ b/sysfs.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/translation-table.c b/translation-table.c
index ff625fe..2412f50 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  *
diff --git a/translation-table.h b/translation-table.h
index 026b1ff..800d7ed 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  *
diff --git a/types.h b/types.h
index 91dd369..dc17b2d 100644
--- a/types.h
+++ b/types.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
-- 
1.7.10.4

