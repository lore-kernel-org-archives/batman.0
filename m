Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri,  4 Jan 2013 03:05:31 +0100
Message-Id: <1357265131-30086-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: update copyright years
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

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_algo.h              | 2 +-
 bat_iv_ogm.c            | 2 +-
 bitarray.c              | 2 +-
 bitarray.h              | 2 +-
 bridge_loop_avoidance.c | 2 +-
 bridge_loop_avoidance.h | 2 +-
 compat.c                | 2 +-
 compat.h                | 2 +-
 debugfs.c               | 2 +-
 debugfs.h               | 2 +-
 distributed-arp-table.c | 2 +-
 distributed-arp-table.h | 2 +-
 gateway_client.c        | 2 +-
 gateway_client.h        | 2 +-
 gateway_common.c        | 2 +-
 gateway_common.h        | 2 +-
 hard-interface.c        | 2 +-
 hard-interface.h        | 2 +-
 hash.c                  | 2 +-
 hash.h                  | 2 +-
 icmp_socket.c           | 2 +-
 icmp_socket.h           | 2 +-
 main.c                  | 2 +-
 main.h                  | 2 +-
 originator.c            | 2 +-
 originator.h            | 2 +-
 packet.h                | 2 +-
 ring_buffer.c           | 2 +-
 ring_buffer.h           | 2 +-
 routing.c               | 2 +-
 routing.h               | 2 +-
 send.c                  | 2 +-
 send.h                  | 2 +-
 soft-interface.c        | 2 +-
 soft-interface.h        | 2 +-
 sysfs.c                 | 2 +-
 sysfs.h                 | 2 +-
 translation-table.c     | 2 +-
 translation-table.h     | 2 +-
 types.h                 | 2 +-
 unicast.c               | 2 +-
 unicast.h               | 2 +-
 vis.c                   | 2 +-
 vis.h                   | 2 +-
 44 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/bat_algo.h b/bat_algo.h
index a0ba3bf..a4808c2 100644
--- a/bat_algo.h
+++ b/bat_algo.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 36b9727..72fe1bb 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/bitarray.c b/bitarray.c
index 5453b17..9739824 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2013 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/bitarray.h b/bitarray.h
index cebaae7..a81b932 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2013 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 9971892..30f4652 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2013 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index 196d9a0..dea2fbc 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2013 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/compat.c b/compat.c
index a2a6f09..6c8fec8 100644
--- a/compat.c
+++ b/compat.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat.h b/compat.h
index dcf72ee..3d03a2f 100644
--- a/compat.h
+++ b/compat.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/debugfs.c b/debugfs.c
index e47555b..6ae8651 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/debugfs.h b/debugfs.h
index 3319e1f..f8c3849 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 8e1d89d..7485a78 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2013 B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index d060c03..125c8c6 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2013 B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/gateway_client.c b/gateway_client.c
index dd07c7e..074107f 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/gateway_client.h b/gateway_client.h
index f0d129e..039902d 100644
--- a/gateway_client.h
+++ b/gateway_client.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/gateway_common.c b/gateway_common.c
index 9001208..84bb2b1 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/gateway_common.h b/gateway_common.h
index 13697f6..509b2bf 100644
--- a/gateway_common.h
+++ b/gateway_common.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/hard-interface.c b/hard-interface.c
index f1d37cd..78cf350 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/hard-interface.h b/hard-interface.h
index 3732366..308437d 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/hash.c b/hash.c
index 15a849c..7198daf 100644
--- a/hash.c
+++ b/hash.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2013 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hash.h b/hash.h
index ea02148..1b4da72 100644
--- a/hash.h
+++ b/hash.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2013 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/icmp_socket.c b/icmp_socket.c
index 87ca809..0ba6c89 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/icmp_socket.h b/icmp_socket.h
index 29443a1..1fcca37 100644
--- a/icmp_socket.h
+++ b/icmp_socket.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/main.c b/main.c
index f65a222..21fe698 100644
--- a/main.c
+++ b/main.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/main.h b/main.h
index a1cd1b1..7cebbfd 100644
--- a/main.h
+++ b/main.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/originator.c b/originator.c
index 92a55fd..457ea44 100644
--- a/originator.c
+++ b/originator.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/originator.h b/originator.h
index 9778e65..286bf74 100644
--- a/originator.h
+++ b/originator.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/packet.h b/packet.h
index cb6405b..ed0aa89 100644
--- a/packet.h
+++ b/packet.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/ring_buffer.c b/ring_buffer.c
index c8f61e3..ccab0bb 100644
--- a/ring_buffer.c
+++ b/ring_buffer.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/ring_buffer.h b/ring_buffer.h
index fda8c17..3f92ae2 100644
--- a/ring_buffer.h
+++ b/ring_buffer.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/routing.c b/routing.c
index db89238..60ba03f 100644
--- a/routing.c
+++ b/routing.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/routing.h b/routing.h
index 9262279..99eeafa 100644
--- a/routing.h
+++ b/routing.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/send.c b/send.c
index 0b6f65b..80ca65f 100644
--- a/send.c
+++ b/send.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/send.h b/send.h
index 0078dec..38e662f 100644
--- a/send.h
+++ b/send.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/soft-interface.c b/soft-interface.c
index a8eb963..9927afa 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/soft-interface.h b/soft-interface.h
index 07a08fe..43182e5 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/sysfs.c b/sysfs.c
index 84a55cb..afbba31 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/sysfs.h b/sysfs.h
index 3fd1412..479acf4 100644
--- a/sysfs.h
+++ b/sysfs.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/translation-table.c b/translation-table.c
index 877acd1..fb15b4c 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  *
diff --git a/translation-table.h b/translation-table.h
index 46d4451..ab8e683 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  *
diff --git a/types.h b/types.h
index 03197f5..89ac1fb 100644
--- a/types.h
+++ b/types.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/unicast.c b/unicast.c
index f56bccf..50e079f 100644
--- a/unicast.c
+++ b/unicast.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2013 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer
  *
diff --git a/unicast.h b/unicast.h
index 61abba5..429cf8a 100644
--- a/unicast.h
+++ b/unicast.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2013 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer
  *
diff --git a/vis.c b/vis.c
index 2e70ec1..22d2785 100644
--- a/vis.c
+++ b/vis.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2008-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2008-2013 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/vis.h b/vis.h
index 873282f..ad92b0e 100644
--- a/vis.h
+++ b/vis.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2008-2012 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2008-2013 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
-- 
1.8.0.2

