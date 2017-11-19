Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 15:06:00 +0100
Message-Id: <20171119140602.24504-5-sven@narfation.org>
In-Reply-To: <20171119140602.24504-1-sven@narfation.org>
References: <20171119140602.24504-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/6] alfred: Add SPDX license identifier
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
alfred shares source files with the Linux kernel, it is appropriate to use
the same identifier.

The FSFE REUSE practices [1] would also require the same tags but have no
restrictions on the placement in the source file. Using the "Linux kernel
licensing rules" is therefore also fulfilling the FSFE REUSE practices
requirements at the same time.

[1] https://reuse.software/practices/

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile           | 1 +
 alfred.h           | 4 ++--
 batadv_query.c     | 4 ++--
 batadv_query.h     | 4 ++--
 batadv_querynl.c   | 4 ++--
 batadv_querynl.h   | 4 ++--
 batman_adv.h       | 1 +
 bitops.h           | 1 +
 client.c           | 4 ++--
 debugfs.c          | 4 ++--
 debugfs.h          | 4 ++--
 gpsd/Makefile      | 1 +
 gpsd/alfred-gpsd.c | 4 ++--
 gpsd/alfred-gpsd.h | 4 ++--
 hash.c             | 4 ++--
 hash.h             | 4 ++--
 list.h             | 4 ++--
 main.c             | 4 ++--
 netlink.c          | 4 ++--
 netlink.h          | 4 ++--
 netsock.c          | 4 ++--
 packet.h           | 4 ++--
 recv.c             | 4 ++--
 send.c             | 4 ++--
 server.c           | 4 ++--
 unix_sock.c        | 4 ++--
 util.c             | 4 ++--
 vis/Makefile       | 1 +
 vis/vis.c          | 4 ++--
 vis/vis.h          | 4 ++--
 30 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/Makefile b/Makefile
index 1662412..c2bacc0 100755
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,5 @@
 #!/usr/bin/make -f
+# SPDX-License-Identifier: GPL-2.0
 # -*- makefile -*-
 #
 # Copyright (C) 2012-2017  B.A.T.M.A.N. contributors
diff --git a/alfred.h b/alfred.h
index df0bd9a..d12b47a 100644
--- a/alfred.h
+++ b/alfred.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/batadv_query.c b/batadv_query.c
index 387950a..ac29da1 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/batadv_query.h b/batadv_query.h
index 5633322..4bf30c2 100644
--- a/batadv_query.h
+++ b/batadv_query.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/batadv_querynl.c b/batadv_querynl.c
index c197d24..b58dac4 100644
--- a/batadv_querynl.c
+++ b/batadv_querynl.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/batadv_querynl.h b/batadv_querynl.h
index 90f6546..8d76ea9 100644
--- a/batadv_querynl.h
+++ b/batadv_querynl.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
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
diff --git a/bitops.h b/bitops.h
index 37ce7e8..459fafc 100644
--- a/bitops.h
+++ b/bitops.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */
 /* Minimal Linux-like bit manipulation helper functions
  * (reduced version for alfred)
  *
diff --git a/client.c b/client.c
index 27dbc4a..7c89f95 100644
--- a/client.c
+++ b/client.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
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
diff --git a/gpsd/Makefile b/gpsd/Makefile
index dae2b48..e3c824b 100755
--- a/gpsd/Makefile
+++ b/gpsd/Makefile
@@ -1,4 +1,5 @@
 #!/usr/bin/make -f
+# SPDX-License-Identifier: GPL-2.0
 # -*- makefile -*-
 #
 # Copyright (C) 2013-2017  B.A.T.M.A.N. contributors
diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 7147136..b2eee9b 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn, Simon Wunderlich
  *
diff --git a/gpsd/alfred-gpsd.h b/gpsd/alfred-gpsd.h
index 0a3a31f..ce765c2 100644
--- a/gpsd/alfred-gpsd.h
+++ b/gpsd/alfred-gpsd.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn, Simon Wunderlich
  *
diff --git a/hash.c b/hash.c
index ebdcb47..3ba5a5a 100644
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
index 3111b49..4ec5c57 100644
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
diff --git a/list.h b/list.h
index 5d4c25a..f6c0cae 100644
--- a/list.h
+++ b/list.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 1991-2013 linux kernel contributors
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 1991-2013 linux kernel contributors
  *
  * Linus Torvalds, ...
  *
diff --git a/main.c b/main.c
index be79fb9..59a24c9 100644
--- a/main.c
+++ b/main.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/netlink.c b/netlink.c
index 7678f99..e050de3 100644
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
index 446948c..81a8f8d 100644
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
diff --git a/netsock.c b/netsock.c
index ced8fbd..5de1bbb 100644
--- a/netsock.c
+++ b/netsock.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/packet.h b/packet.h
index a132326..a60c8ac 100644
--- a/packet.h
+++ b/packet.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Sven Eckelmann
  *
diff --git a/recv.c b/recv.c
index 0f8004e..b93af7c 100644
--- a/recv.c
+++ b/recv.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/send.c b/send.c
index 9c1e31b..f1be0ea 100644
--- a/send.c
+++ b/send.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/server.c b/server.c
index 199d38c..95e5f24 100644
--- a/server.c
+++ b/server.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/unix_sock.c b/unix_sock.c
index 7f5e99c..fd9465d 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/util.c b/util.c
index 87261a0..bf82d1e 100644
--- a/util.c
+++ b/util.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/vis/Makefile b/vis/Makefile
index 63500c9..18b8070 100755
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -1,4 +1,5 @@
 #!/usr/bin/make -f
+# SPDX-License-Identifier: GPL-2.0
 # -*- makefile -*-
 #
 # Copyright (C) 2013-2017  B.A.T.M.A.N. contributors
diff --git a/vis/vis.c b/vis/vis.c
index 148c581..5371f05 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/vis/vis.h b/vis/vis.h
index b99e745..03028f0 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -1,5 +1,5 @@
-/*
- * Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
-- 
2.11.0

