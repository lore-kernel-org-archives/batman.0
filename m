Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat,  4 Jan 2014 18:03:32 +0100
Message-Id: <1388855012-8849-2-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1388855012-8849-1-git-send-email-sw@simonwunderlich.de>
References: <1388855012-8849-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-next 2/2] batctl: update copyright years for
	2014
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
 Makefile      |    2 +-
 allocate.h    |    2 +-
 bat-hosts.c   |    2 +-
 bat-hosts.h   |    2 +-
 bisect_iv.c   |    2 +-
 bisect_iv.h   |    2 +-
 debug.c       |    2 +-
 debug.h       |    2 +-
 functions.c   |    2 +-
 functions.h   |    2 +-
 hash.c        |    2 +-
 hash.h        |    2 +-
 ioctl.c       |    2 +-
 ioctl.h       |    2 +-
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
 translate.c   |    2 +-
 translate.h   |    2 +-
 29 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index 90d3d79..fc0925d 100755
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 #!/usr/bin/make -f
 # -*- makefile -*-
 #
-# Copyright (C) 2006-2013 B.A.T.M.A.N. contributors
+# Copyright (C) 2006-2014 B.A.T.M.A.N. contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/allocate.h b/allocate.h
index 29bdda1..c2f7777 100644
--- a/allocate.h
+++ b/allocate.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bat-hosts.c b/bat-hosts.c
index e03353d..30ff848 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bat-hosts.h b/bat-hosts.h
index 88f93f9..327208b 100644
--- a/bat-hosts.h
+++ b/bat-hosts.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bisect_iv.c b/bisect_iv.c
index 8e9f01f..0c25664 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bisect_iv.h b/bisect_iv.h
index 5c306ed..a7ea706 100644
--- a/bisect_iv.h
+++ b/bisect_iv.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/debug.c b/debug.c
index 3e78638..d57324d 100644
--- a/debug.c
+++ b/debug.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/debug.h b/debug.h
index 28802c7..76d5e68 100644
--- a/debug.h
+++ b/debug.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/functions.c b/functions.c
index f2b23f2..13ba190 100644
--- a/functions.c
+++ b/functions.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/functions.h b/functions.h
index 5409b38..522c607 100644
--- a/functions.h
+++ b/functions.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/hash.c b/hash.c
index d4f3e09..11a97d5 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hash.h b/hash.h
index 9253b73..452f836 100644
--- a/hash.h
+++ b/hash.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2006-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/ioctl.c b/ioctl.c
index 0798060..eccac66 100644
--- a/ioctl.c
+++ b/ioctl.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/ioctl.h b/ioctl.h
index 2d4801f..d47ad08 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/list-batman.c b/list-batman.c
index 4fa71a3..b31a324 100644
--- a/list-batman.c
+++ b/list-batman.c
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2006-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/list-batman.h b/list-batman.h
index aea0f95..0ee1367 100644
--- a/list-batman.h
+++ b/list-batman.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/main.c b/main.c
index aaf3587..aab2e11 100644
--- a/main.c
+++ b/main.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/main.h b/main.h
index 0839771..f41adf0 100644
--- a/main.h
+++ b/main.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
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
diff --git a/ping.c b/ping.c
index bce8ea2..c52ad13 100644
--- a/ping.c
+++ b/ping.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/ping.h b/ping.h
index ce4553a..6258534 100644
--- a/ping.h
+++ b/ping.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/sys.c b/sys.c
index 5f1218e..2a508e2 100644
--- a/sys.c
+++ b/sys.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/sys.h b/sys.h
index 28a3638..8934978 100644
--- a/sys.h
+++ b/sys.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/tcpdump.c b/tcpdump.c
index 612fdaf..e9fac70 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>
  *
diff --git a/tcpdump.h b/tcpdump.h
index 2ac979a..cfb1c69 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/traceroute.c b/traceroute.c
index fccd80c..ce78c5d 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/traceroute.h b/traceroute.h
index fc7d319..396088a 100644
--- a/traceroute.h
+++ b/traceroute.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/translate.c b/translate.c
index 14fa04c..1cc83f9 100644
--- a/translate.c
+++ b/translate.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/translate.h b/translate.h
index 691d234..c6259d0 100644
--- a/translate.h
+++ b/translate.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2013 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
-- 
1.7.10.4

