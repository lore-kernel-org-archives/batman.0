Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  1 Jan 2016 00:01:02 +0100
Message-Id: <1451602862-23319-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: update copyright years for 2016
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
 Makefile      | 2 +-
 allocate.h    | 2 +-
 bat-hosts.c   | 2 +-
 bat-hosts.h   | 2 +-
 bisect_iv.c   | 2 +-
 bisect_iv.h   | 2 +-
 debug.c       | 2 +-
 debug.h       | 2 +-
 functions.c   | 2 +-
 functions.h   | 2 +-
 hash.c        | 2 +-
 hash.h        | 2 +-
 ioctl.c       | 2 +-
 ioctl.h       | 2 +-
 list-batman.c | 2 +-
 list-batman.h | 2 +-
 main.c        | 2 +-
 main.h        | 2 +-
 packet.h      | 2 +-
 ping.c        | 2 +-
 ping.h        | 2 +-
 sys.c         | 2 +-
 sys.h         | 2 +-
 tcpdump.c     | 2 +-
 tcpdump.h     | 2 +-
 traceroute.c  | 2 +-
 traceroute.h  | 2 +-
 translate.c   | 2 +-
 translate.h   | 2 +-
 29 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/Makefile b/Makefile
index d83d2e8..b82c0c6 100755
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 #!/usr/bin/make -f
 # -*- makefile -*-
 #
-# Copyright (C) 2006-2015  B.A.T.M.A.N. contributors
+# Copyright (C) 2006-2016  B.A.T.M.A.N. contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/allocate.h b/allocate.h
index 02edf5c..a20f891 100644
--- a/allocate.h
+++ b/allocate.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bat-hosts.c b/bat-hosts.c
index 72bec80..a4add34 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bat-hosts.h b/bat-hosts.h
index f402455..78c7b2b 100644
--- a/bat-hosts.h
+++ b/bat-hosts.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bisect_iv.c b/bisect_iv.c
index 5b9c041..0f2c0cb 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/bisect_iv.h b/bisect_iv.h
index ec575d2..ace76c7 100644
--- a/bisect_iv.h
+++ b/bisect_iv.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/debug.c b/debug.c
index bcdeef7..3db3ed9 100644
--- a/debug.c
+++ b/debug.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/debug.h b/debug.h
index 6cbfcd8..df65f50 100644
--- a/debug.h
+++ b/debug.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/functions.c b/functions.c
index 3fcd2ad..be8f8b0 100644
--- a/functions.c
+++ b/functions.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/functions.h b/functions.h
index 02ed5ea..d0b05b9 100644
--- a/functions.h
+++ b/functions.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/hash.c b/hash.c
index 069a424..08d47b5 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hash.h b/hash.h
index aa27f25..b090888 100644
--- a/hash.h
+++ b/hash.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/ioctl.c b/ioctl.c
index 068f894..ca02414 100644
--- a/ioctl.c
+++ b/ioctl.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/ioctl.h b/ioctl.h
index 55c9aab..a6f8a08 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/list-batman.c b/list-batman.c
index 1beafaf..affedb6 100644
--- a/list-batman.c
+++ b/list-batman.c
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/list-batman.h b/list-batman.h
index c7372c8..53b8413 100644
--- a/list-batman.h
+++ b/list-batman.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/main.c b/main.c
index 96aea4d..a2cda5b 100644
--- a/main.c
+++ b/main.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/main.h b/main.h
index 437721d..58fe794 100644
--- a/main.h
+++ b/main.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/packet.h b/packet.h
index fdb0163..e7f9151 100644
--- a/packet.h
+++ b/packet.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/ping.c b/ping.c
index a38b31a..05d6e97 100644
--- a/ping.c
+++ b/ping.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/ping.h b/ping.h
index a6c1e36..58d6bf9 100644
--- a/ping.h
+++ b/ping.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/sys.c b/sys.c
index 838fcd8..afa8533 100644
--- a/sys.c
+++ b/sys.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/sys.h b/sys.h
index 13c164e..da2769d 100644
--- a/sys.h
+++ b/sys.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/tcpdump.c b/tcpdump.c
index 0bbfefc..db28414 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>
  *
diff --git a/tcpdump.h b/tcpdump.h
index 37ab241..dc9e5a6 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/traceroute.c b/traceroute.c
index 62cf000..2cd29d9 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/traceroute.h b/traceroute.h
index 2f1512d..6dc5603 100644
--- a/traceroute.h
+++ b/traceroute.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/translate.c b/translate.c
index cefa9da..62c696a 100644
--- a/translate.c
+++ b/translate.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
  *
diff --git a/translate.h b/translate.h
index e349a70..f652091 100644
--- a/translate.h
+++ b/translate.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
  *
-- 
2.6.4

