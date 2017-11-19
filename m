Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 15:05:51 +0100
Message-Id: <20171119140553.24435-5-sven@narfation.org>
In-Reply-To: <20171119140553.24435-1-sven@narfation.org>
References: <20171119140553.24435-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/6] batctl: Add SPDX license identifier
 above copyright header
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

The "Linux kernel licensing rules" require that each file has a SPDX
license identifier as first line (and sometimes as second line). Since
batctl shares source files with the Linux kernel, it is appropriate to use
the same identifier.

The FSFE REUSE practices [1] would also require the same tags but have no
restrictions on the placement in the source file. Using the "Linux kernel
licensing rules" is therefore also fulfilling the FSFE REUSE practices
requirements at the same time.

[1] https://reuse.software/practices/

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile      | 1 +
 allocate.h    | 4 ++--
 bat-hosts.c   | 4 ++--
 bat-hosts.h   | 4 ++--
 batman_adv.h  | 1 +
 bisect_iv.c   | 4 ++--
 bisect_iv.h   | 4 ++--
 debug.c       | 4 ++--
 debug.h       | 4 ++--
 debugfs.c     | 4 ++--
 debugfs.h     | 4 ++--
 functions.c   | 4 ++--
 functions.h   | 4 ++--
 genl.c        | 1 +
 genl.h        | 4 ++--
 hash.c        | 4 ++--
 hash.h        | 4 ++--
 icmp_helper.c | 4 ++--
 icmp_helper.h | 4 ++--
 interface.c   | 4 ++--
 interface.h   | 4 ++--
 ioctl.c       | 4 ++--
 ioctl.h       | 4 ++--
 list.h        | 1 +
 main.c        | 4 ++--
 main.h        | 4 ++--
 netlink.c     | 4 ++--
 netlink.h     | 4 ++--
 packet.h      | 1 +
 ping.c        | 4 ++--
 ping.h        | 4 ++--
 sys.c         | 4 ++--
 sys.h         | 4 ++--
 tcpdump.c     | 4 ++--
 tcpdump.h     | 4 ++--
 tp_meter.c    | 4 ++--
 tp_meter.h    | 4 ++--
 traceroute.c  | 4 ++--
 traceroute.h  | 4 ++--
 translate.c   | 4 ++--
 translate.h   | 4 ++--
 41 files changed, 77 insertions(+), 72 deletions(-)

diff --git a/Makefile b/Makefile
index 78bd200..a77517f 100755
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,5 @@
 #!/usr/bin/make -f
+# SPDX-License-Identifier: GPL-2.0
 # -*- makefile -*-
 #
 # Copyright (C) 2006-2017  B.A.T.M.A.N. contributors
diff --git a/allocate.h b/allocate.h
index 2cd6996..faa8abd 100644
--- a/allocate.h
+++ b/allocate.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bat-hosts.c b/bat-hosts.c
index 33e1dbd..9432b22 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bat-hosts.h b/bat-hosts.h
index 474706c..5b1c137 100644
--- a/bat-hosts.h
+++ b/bat-hosts.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/batman_adv.h b/batman_adv.h
index efd641c..fb45338 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ISC */
 /* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
diff --git a/bisect_iv.c b/bisect_iv.c
index c5616ad..cf1d0ee 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bisect_iv.h b/bisect_iv.h
index 558508f..aec9f15 100644
--- a/bisect_iv.h
+++ b/bisect_iv.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/debug.c b/debug.c
index 1fb9cd2..17c040e 100644
--- a/debug.c
+++ b/debug.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/debug.h b/debug.h
index b185bde..959193a 100644
--- a/debug.h
+++ b/debug.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/debugfs.c b/debugfs.c
index e90c3a8..1cea8ac 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009 Clark Williams <williams@redhat.com>
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009 Clark Williams <williams@redhat.com>
  * Copyright (C) 2009 Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>
  *
  * This program is free software; you can redistribute it and/or
diff --git a/debugfs.h b/debugfs.h
index 5404a45..6e49efa 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009 Clark Williams <williams@redhat.com>
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2009 Clark Williams <williams@redhat.com>
  * Copyright (C) 2009 Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>
  *
  * This program is free software; you can redistribute it and/or
diff --git a/functions.c b/functions.c
index 7d857e7..d3dbe8a 100644
--- a/functions.c
+++ b/functions.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/functions.h b/functions.h
index 24289b3..c53aa7a 100644
--- a/functions.h
+++ b/functions.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/genl.c b/genl.c
index 36fc27e..0a2bd92 100644
--- a/genl.c
+++ b/genl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2007, 2008	Johannes Berg
  * Copyright (c) 2007		Andy Lutomirski
diff --git a/genl.h b/genl.h
index f8a5a25..ed22104 100644
--- a/genl.h
+++ b/genl.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/hash.c b/hash.c
index 2df9d26..2134028 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hash.h b/hash.h
index 676e0ae..b6dfd95 100644
--- a/hash.h
+++ b/hash.h
@@ -1,5 +1,5 @@
-/* 
- * Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/icmp_helper.c b/icmp_helper.c
index 3eab78b..3dcbeed 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich
  *
diff --git a/icmp_helper.h b/icmp_helper.h
index 6f9c3ab..a6cf95e 100644
--- a/icmp_helper.h
+++ b/icmp_helper.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/interface.c b/interface.c
index 5cc036b..4a944de 100644
--- a/interface.c
+++ b/interface.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/interface.h b/interface.h
index 5c5d1a1..84cd7db 100644
--- a/interface.h
+++ b/interface.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/ioctl.c b/ioctl.c
index 92635ad..2872e0c 100644
--- a/ioctl.c
+++ b/ioctl.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/ioctl.h b/ioctl.h
index 8b270ad..b18e7af 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/list.h b/list.h
index 23df29e..a2f3f8f 100644
--- a/list.h
+++ b/list.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /* Minimal Linux-like double-linked list helper functions
  *
  * Copyright (c) 2012-2017, Sven Eckelmann <sven@narfation.org>
diff --git a/main.c b/main.c
index cea9257..3ea201f 100644
--- a/main.c
+++ b/main.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/main.h b/main.h
index b24b4d7..a417c36 100644
--- a/main.h
+++ b/main.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/netlink.c b/netlink.c
index 24541f8..fce93d7 100644
--- a/netlink.c
+++ b/netlink.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/netlink.h b/netlink.h
index 704ee1b..14a4e3d 100644
--- a/netlink.h
+++ b/netlink.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/packet.h b/packet.h
index f1fd031..d58288c 100644
--- a/packet.h
+++ b/packet.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/ping.c b/ping.c
index 8e7963d..5a3a16c 100644
--- a/ping.c
+++ b/ping.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/ping.h b/ping.h
index 4141bef..3e3acda 100644
--- a/ping.h
+++ b/ping.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/sys.c b/sys.c
index 90b0d58..9442553 100644
--- a/sys.c
+++ b/sys.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/sys.h b/sys.h
index 9fd32d2..4b8a2e0 100644
--- a/sys.h
+++ b/sys.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/tcpdump.c b/tcpdump.c
index e3041f2..a42d227 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>
  *
diff --git a/tcpdump.h b/tcpdump.h
index a625734..b8a19bf 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/tp_meter.c b/tp_meter.c
index 6c97ae5..12d80c0 100644
--- a/tp_meter.c
+++ b/tp_meter.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2013-2017 B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2013-2017 B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli <a@unstable.cc>
  *
diff --git a/tp_meter.h b/tp_meter.h
index b4100d8..bb08d63 100644
--- a/tp_meter.h
+++ b/tp_meter.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2013-2017 B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2013-2017 B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli <a@unstable.cc>
  *
diff --git a/traceroute.c b/traceroute.c
index db5304f..9ed1c82 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/traceroute.h b/traceroute.h
index d0b31a6..b30e8c0 100644
--- a/traceroute.h
+++ b/traceroute.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/translate.c b/translate.c
index 387049a..6e69caa 100644
--- a/translate.c
+++ b/translate.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/translate.h b/translate.h
index fe10b8a..2ea1dbc 100644
--- a/translate.h
+++ b/translate.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
-- 
2.11.0

