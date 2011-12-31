Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  1 Jan 2012 00:41:37 +0100
Message-Id: <1325374901-1620-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Update copyright years
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
 Makefile      |    2 +-
 allocate.h    |    2 +-
 bat-hosts.c   |    2 +-
 bat-hosts.h   |    2 +-
 bisect.c      |    2 +-
 bisect.h      |    2 +-
 debug.c       |    2 +-
 debug.h       |    2 +-
 functions.c   |    2 +-
 functions.h   |    2 +-
 hash.c        |    2 +-
 hash.h        |    2 +-
 list-batman.c |    2 +-
 list-batman.h |    2 +-
 main.c        |    2 +-
 main.h        |    2 +-
 packet.h      |    2 +-
 ping.c        |    2 +-
 ping.h        |    2 +-
 sys.c         |    2 +-
 sys.h         |    2 +-
 tcpdump.c     |    2 +-
 tcpdump.h     |    2 +-
 traceroute.c  |    2 +-
 traceroute.h  |    2 +-
 vis.c         |    2 +-
 vis.h         |    2 +-
 27 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Makefile b/Makefile
index 85efc30..c85dbaa 100755
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 #!/usr/bin/make -f
 # -*- makefile -*-
 #
-# Copyright (C) 2006-2011 B.A.T.M.A.N. contributors
+# Copyright (C) 2006-2012 B.A.T.M.A.N. contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/allocate.h b/allocate.h
index 1fe6730..751380f 100644
--- a/allocate.h
+++ b/allocate.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/bat-hosts.c b/bat-hosts.c
index 179e733..ad49618 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/bat-hosts.h b/bat-hosts.h
index ba265bb..519862f 100644
--- a/bat-hosts.h
+++ b/bat-hosts.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/bisect.c b/bisect.c
index d3789aa..b505b1a 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/bisect.h b/bisect.h
index 4423608..7c43708 100644
--- a/bisect.h
+++ b/bisect.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/debug.c b/debug.c
index 480e4a5..6a553ff 100644
--- a/debug.c
+++ b/debug.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/debug.h b/debug.h
index b1648f3..939f281 100644
--- a/debug.h
+++ b/debug.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/functions.c b/functions.c
index c2c0529..0729f15 100644
--- a/functions.c
+++ b/functions.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/functions.h b/functions.h
index 7e9f68c..ea953dd 100644
--- a/functions.h
+++ b/functions.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/hash.c b/hash.c
index e8c822f..2a9f557 100644
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
index 443ef28..91ee7d8 100644
--- a/hash.h
+++ b/hash.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/list-batman.c b/list-batman.c
index 356c1eb..a0c2ad8 100644
--- a/list-batman.c
+++ b/list-batman.c
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/list-batman.h b/list-batman.h
index 72d2ac4..ebff97c 100644
--- a/list-batman.h
+++ b/list-batman.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/main.c b/main.c
index 7f6d1a3..0dfdb8e 100644
--- a/main.c
+++ b/main.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/main.h b/main.h
index e5a3e01..2b231cb 100644
--- a/main.h
+++ b/main.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
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
diff --git a/ping.c b/ping.c
index 91b733a..d04672e 100644
--- a/ping.c
+++ b/ping.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/ping.h b/ping.h
index ccc717a..e3f47fc 100644
--- a/ping.h
+++ b/ping.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/sys.c b/sys.c
index 105bb51..9cdccba 100644
--- a/sys.c
+++ b/sys.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/sys.h b/sys.h
index 2df846c..5dafe85 100644
--- a/sys.h
+++ b/sys.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/tcpdump.c b/tcpdump.c
index 7dd289e..5e8574c 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>
  *
diff --git a/tcpdump.h b/tcpdump.h
index 925b116..2a2cc0a 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/traceroute.c b/traceroute.c
index d120311..02f0ecd 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2012 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/traceroute.h b/traceroute.h
index 31edb7e..e78609f 100644
--- a/traceroute.h
+++ b/traceroute.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <lindner_marek@yahoo.de>
  *
diff --git a/vis.c b/vis.c
index 1a8d181..b040497 100644
--- a/vis.c
+++ b/vis.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/vis.h b/vis.h
index 8d6cfcd..77c6669 100644
--- a/vis.h
+++ b/vis.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2011 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2012 B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn <andrew@lunn.ch>
  *
-- 
1.7.7.3

