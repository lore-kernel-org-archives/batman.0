Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 23 Apr 2015 13:16:35 +0200
Message-Id: <1429787796-11341-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: update copyright years for
	2015
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile.kbuild         | 2 +-
 bat_algo.h              | 2 +-
 bat_iv_ogm.c            | 2 +-
 bitarray.c              | 2 +-
 bitarray.h              | 2 +-
 bridge_loop_avoidance.c | 2 +-
 bridge_loop_avoidance.h | 2 +-
 debugfs.c               | 2 +-
 debugfs.h               | 2 +-
 distributed-arp-table.c | 2 +-
 distributed-arp-table.h | 2 +-
 fragmentation.c         | 2 +-
 fragmentation.h         | 2 +-
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
 multicast.c             | 2 +-
 multicast.h             | 2 +-
 network-coding.c        | 2 +-
 network-coding.h        | 2 +-
 originator.c            | 2 +-
 originator.h            | 2 +-
 packet.h                | 2 +-
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
 43 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 6903703..21434ab 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/bat_algo.h b/bat_algo.h
index 4e49666..4e59cf3 100644
--- a/bat_algo.h
+++ b/bat_algo.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index f3214ed..9adbc61 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/bitarray.c b/bitarray.c
index ea483f5..cf68c32 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2015 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/bitarray.h b/bitarray.h
index 0240fc2..0c24562 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2015 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 1882b91..ba06092 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2015 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index 1318805..0282690 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2015 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/debugfs.c b/debugfs.c
index e7d6f1a..c4c1e80 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/debugfs.h b/debugfs.h
index ce085b8..187acdc 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 0b3d13d..fb54e6a 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2015 B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 7fe6cd9..3181507 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2015 B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/fragmentation.c b/fragmentation.c
index 124356a..c0f0d01 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2013-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2015 B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  *
diff --git a/fragmentation.h b/fragmentation.h
index 7436a57..8b9877e 100644
--- a/fragmentation.h
+++ b/fragmentation.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2013-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2015 B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  *
diff --git a/gateway_client.c b/gateway_client.c
index 9b2ef82..14f0a22 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/gateway_client.h b/gateway_client.h
index 60a52d5..89565b4 100644
--- a/gateway_client.h
+++ b/gateway_client.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/gateway_common.c b/gateway_common.c
index f5d6734..39cf44c 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/gateway_common.h b/gateway_common.h
index 2020c0f..bd5c812 100644
--- a/gateway_common.h
+++ b/gateway_common.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/hard-interface.c b/hard-interface.c
index a05cf66..f4a15d2 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/hard-interface.h b/hard-interface.h
index 1012a5b..5a31420 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/hash.c b/hash.c
index 0532dc9..e89f314 100644
--- a/hash.c
+++ b/hash.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2015 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hash.h b/hash.h
index b7cc418..5065f50 100644
--- a/hash.h
+++ b/hash.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2015 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/icmp_socket.c b/icmp_socket.c
index c09342c..07061bc 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/icmp_socket.h b/icmp_socket.h
index 0189910..7de7fce 100644
--- a/icmp_socket.h
+++ b/icmp_socket.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/main.c b/main.c
index 0cbbd6f..8457097 100644
--- a/main.c
+++ b/main.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/main.h b/main.h
index dee8072..4cb77ed 100644
--- a/main.h
+++ b/main.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/multicast.c b/multicast.c
index 70ce652..7aa480b 100644
--- a/multicast.c
+++ b/multicast.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2014-2015 B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
  *
diff --git a/multicast.h b/multicast.h
index ae04f1e..beb6e56 100644
--- a/multicast.h
+++ b/multicast.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2014-2015 B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
  *
diff --git a/network-coding.c b/network-coding.c
index b3b3c4e..f0a50f3 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2015 B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
  *
diff --git a/network-coding.h b/network-coding.h
index 4008ec2..5b79aa8 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2015 B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
  *
diff --git a/originator.c b/originator.c
index 684536e..018b749 100644
--- a/originator.c
+++ b/originator.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/originator.h b/originator.h
index 39085cc..79734d3 100644
--- a/originator.h
+++ b/originator.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/packet.h b/packet.h
index 7a9cb7a..9e747c0 100644
--- a/packet.h
+++ b/packet.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/routing.c b/routing.c
index db68ae4..c360c0c 100644
--- a/routing.c
+++ b/routing.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/routing.h b/routing.h
index f8a9e14..6bc29d3 100644
--- a/routing.h
+++ b/routing.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/send.c b/send.c
index 879ccad..0a01992 100644
--- a/send.c
+++ b/send.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/send.h b/send.h
index de85f2f..0536835 100644
--- a/send.h
+++ b/send.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/soft-interface.c b/soft-interface.c
index 310031f..c002961 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/soft-interface.h b/soft-interface.h
index e1e8bb9..578e8a6 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/sysfs.c b/sysfs.c
index ddfa989..d6a312a 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/sysfs.h b/sysfs.h
index bc1f6df..2294583 100644
--- a/sysfs.h
+++ b/sysfs.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/translation-table.c b/translation-table.c
index 5551ecc..0611c58 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  *
diff --git a/translation-table.h b/translation-table.h
index 3c2b868..6acc25d 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  *
diff --git a/types.h b/types.h
index 1d4781e..67d6348 100644
--- a/types.h
+++ b/types.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
-- 
2.1.4

