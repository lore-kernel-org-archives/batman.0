Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  1 Jan 2012 00:41:38 +0100
Message-Id: <1325374901-1620-2-git-send-email-sven@narfation.org>
In-Reply-To: <1325374901-1620-1-git-send-email-sven@narfation.org>
References: <1325374901-1620-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Update copyright years
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile            |    2 +-
 Makefile.kbuild     |    2 +-
 bat_debugfs.c       |    2 +-
 bat_debugfs.h       |    2 +-
 bat_iv_ogm.c        |    2 +-
 bat_ogm.h           |    2 +-
 bat_sysfs.c         |    2 +-
 bat_sysfs.h         |    2 +-
 bitarray.c          |    2 +-
 bitarray.h          |    2 +-
 compat.c            |   24 ++++++++++++++++++++++++
 compat.h            |    2 +-
 gateway_client.c    |    2 +-
 gateway_client.h    |    2 +-
 gateway_common.c    |    2 +-
 gateway_common.h    |    2 +-
 hard-interface.c    |    2 +-
 hard-interface.h    |    2 +-
 hash.c              |    2 +-
 hash.h              |    2 +-
 icmp_socket.c       |    2 +-
 icmp_socket.h       |    2 +-
 main.c              |    2 +-
 main.h              |    2 +-
 originator.c        |    2 +-
 originator.h        |    2 +-
 packet.h            |    2 +-
 ring_buffer.c       |    2 +-
 ring_buffer.h       |    2 +-
 routing.c           |    2 +-
 routing.h           |    2 +-
 send.c              |    2 +-
 send.h              |    2 +-
 soft-interface.c    |    2 +-
 soft-interface.h    |    2 +-
 translation-table.c |    2 +-
 translation-table.h |    2 +-
 types.h             |    2 +-
 unicast.c           |    2 +-
 unicast.h           |    2 +-
 vis.c               |    2 +-
 vis.h               |    2 +-
 42 files changed, 65 insertions(+), 41 deletions(-)

diff --git a/Makefile b/Makefile
index 5762721..4b4b95b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/Makefile.kbuild b/Makefile.kbuild
index bd7e93c..ec70651 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/bat_debugfs.c b/bat_debugfs.c
index d0af9bf..a5b3e51 100644
--- a/bat_debugfs.c
+++ b/bat_debugfs.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2010-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/bat_debugfs.h b/bat_debugfs.h
index bc9cda3..d605c67 100644
--- a/bat_debugfs.h
+++ b/bat_debugfs.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2010-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 3512e25..cdae27f 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/bat_ogm.h b/bat_ogm.h
index 69329c1..7a1c28e 100644
--- a/bat_ogm.h
+++ b/bat_ogm.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/bat_sysfs.c b/bat_sysfs.c
index c25492f..25f37fb 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2010-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/bat_sysfs.h b/bat_sysfs.h
index a3f75a7..fece77a 100644
--- a/bat_sysfs.h
+++ b/bat_sysfs.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2010-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/bitarray.c b/bitarray.c
index 9bc63b2..e63069d 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/bitarray.h b/bitarray.h
index 9c04422..c613572 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/compat.c b/compat.c
index 855360e..c3dc59b 100644
--- a/compat.c
+++ b/compat.c
@@ -1,3 +1,27 @@
+/*
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
 #include <linux/in.h>
 #include <linux/version.h>
 #include "main.h"
diff --git a/compat.h b/compat.h
index 964c066..6a1168e 100644
--- a/compat.h
+++ b/compat.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/gateway_client.c b/gateway_client.c
index 24403a7..ee23fbb 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/gateway_client.h b/gateway_client.h
index e1edba0..bf56a5a 100644
--- a/gateway_client.h
+++ b/gateway_client.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/gateway_common.c b/gateway_common.c
index c4ac7b0..7f79e15 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/gateway_common.h b/gateway_common.h
index 55e527a..b8fb11c 100644
--- a/gateway_common.h
+++ b/gateway_common.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/hard-interface.c b/hard-interface.c
index 7704df4..ba1c714 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/hard-interface.h b/hard-interface.h
index 67f78d1..e68c565 100644
--- a/hard-interface.h
+++ b/hard-interface.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/hash.c b/hash.c
index d1da29d..117687b 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hash.h b/hash.h
index 4768717..d4bd786 100644
--- a/hash.h
+++ b/hash.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/icmp_socket.c b/icmp_socket.c
index d9c1e7b..2a1776b 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/icmp_socket.h b/icmp_socket.h
index 462b190..380ed4c 100644
--- a/icmp_socket.h
+++ b/icmp_socket.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/main.c b/main.c
index fb87bdc..6650771 100644
--- a/main.c
+++ b/main.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/main.h b/main.h
index 464439f..157c0b5 100644
--- a/main.h
+++ b/main.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/originator.c b/originator.c
index 0bc2045..4109fab 100644
--- a/originator.c
+++ b/originator.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/originator.h b/originator.h
index 67765ff..3fe2eda 100644
--- a/originator.h
+++ b/originator.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/packet.h b/packet.h
index 4d9e54c..bac156a 100644
--- a/packet.h
+++ b/packet.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/ring_buffer.c b/ring_buffer.c
index f1ccfa7..fd63951 100644
--- a/ring_buffer.c
+++ b/ring_buffer.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/ring_buffer.h b/ring_buffer.h
index 7cdfe62..8b58bd8 100644
--- a/ring_buffer.h
+++ b/ring_buffer.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/routing.c b/routing.c
index 773e606..83fea7d 100644
--- a/routing.c
+++ b/routing.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/routing.h b/routing.h
index 7aaee0f..92ac100 100644
--- a/routing.h
+++ b/routing.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/send.c b/send.c
index 8a684eb..b99529e 100644
--- a/send.c
+++ b/send.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/send.h b/send.h
index c8ca3ef..824ef06 100644
--- a/send.h
+++ b/send.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/soft-interface.c b/soft-interface.c
index 987c75a..c4dc739 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/soft-interface.h b/soft-interface.h
index 001546f..756eab5 100644
--- a/soft-interface.h
+++ b/soft-interface.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/translation-table.c b/translation-table.c
index 58361ed..560a8e7 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/translation-table.h b/translation-table.h
index 30efd49..c753633 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/types.h b/types.h
index e9eb043..f50fb59 100644
--- a/types.h
+++ b/types.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/unicast.c b/unicast.c
index 07d1c1d..1bdf391 100644
--- a/unicast.c
+++ b/unicast.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2010-2012 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer
  *
diff --git a/unicast.h b/unicast.h
index 8fd5535..a9faf6b 100644
--- a/unicast.h
+++ b/unicast.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2010-2012 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer
  *
diff --git a/vis.c b/vis.c
index cc3b9f2..eb9ce57 100644
--- a/vis.c
+++ b/vis.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2008-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/vis.h b/vis.h
index 31b820d..543772d 100644
--- a/vis.h
+++ b/vis.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2008-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
-- 
1.7.7.3

