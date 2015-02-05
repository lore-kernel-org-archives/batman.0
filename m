Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu,  5 Feb 2015 16:45:23 +0100
Message-Id: <1423151124-16054-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Update copyright years for 2015
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
Cc: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile           | 2 +-
 alfred.h           | 2 +-
 batadv_query.c     | 2 +-
 batadv_query.h     | 2 +-
 client.c           | 2 +-
 gpsd/Makefile      | 2 +-
 gpsd/alfred-gpsd.c | 2 +-
 gpsd/alfred-gpsd.h | 2 +-
 hash.c             | 2 +-
 hash.h             | 2 +-
 main.c             | 2 +-
 netsock.c          | 2 +-
 packet.h           | 2 +-
 recv.c             | 2 +-
 send.c             | 2 +-
 server.c           | 2 +-
 unix_sock.c        | 2 +-
 util.c             | 2 +-
 vis/Makefile       | 2 +-
 vis/vis.c          | 2 +-
 vis/vis.h          | 2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index 531339a..8e944c9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 #!/usr/bin/make -f
 # -*- makefile -*-
 #
-# Copyright (C) 2012-2014 B.A.T.M.A.N. contributors
+# Copyright (C) 2012-2015  B.A.T.M.A.N. contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/alfred.h b/alfred.h
index f758fc9..ef00551 100644
--- a/alfred.h
+++ b/alfred.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/batadv_query.c b/batadv_query.c
index cf90554..473ab40 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/batadv_query.h b/batadv_query.h
index 463c8e1..6b938ea 100644
--- a/batadv_query.h
+++ b/batadv_query.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/client.c b/client.c
index cff5270..32fdd54 100644
--- a/client.c
+++ b/client.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/gpsd/Makefile b/gpsd/Makefile
index 7ac6288..5055987 100644
--- a/gpsd/Makefile
+++ b/gpsd/Makefile
@@ -1,7 +1,7 @@
 #!/usr/bin/make -f
 # -*- makefile -*-
 #
-# Copyright (C) 2013-2014 B.A.T.M.A.N. contributors
+# Copyright (C) 2013-2015  B.A.T.M.A.N. contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index d736ad1..86414cf 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2013-2015  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn, Simon Wunderlich
  *
diff --git a/gpsd/alfred-gpsd.h b/gpsd/alfred-gpsd.h
index e287110..297f4e4 100644
--- a/gpsd/alfred-gpsd.h
+++ b/gpsd/alfred-gpsd.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2013-2015  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn, Simon Wunderlich
  *
diff --git a/hash.c b/hash.c
index fd85a0f..87e8484 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hash.h b/hash.h
index c9c8fb1..aa27f25 100644
--- a/hash.h
+++ b/hash.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2006-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/main.c b/main.c
index 7eb8baa..d298d65 100644
--- a/main.c
+++ b/main.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/netsock.c b/netsock.c
index 45c03e9..cc2e9a5 100644
--- a/netsock.c
+++ b/netsock.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/packet.h b/packet.h
index 87ad263..27ee6e5 100644
--- a/packet.h
+++ b/packet.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Sven Eckelmann
  *
diff --git a/recv.c b/recv.c
index 870485f..34a16fc 100644
--- a/recv.c
+++ b/recv.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/send.c b/send.c
index 19cc867..f1843fe 100644
--- a/send.c
+++ b/send.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/server.c b/server.c
index 66809d9..1a3d876 100644
--- a/server.c
+++ b/server.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/unix_sock.c b/unix_sock.c
index 8a99327..d203c50 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/util.c b/util.c
index 9f357cd..84d4b2d 100644
--- a/util.c
+++ b/util.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/vis/Makefile b/vis/Makefile
index 9421ae2..32a578e 100644
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -1,7 +1,7 @@
 #!/usr/bin/make -f
 # -*- makefile -*-
 #
-# Copyright (C) 2013-2014 B.A.T.M.A.N. contributors
+# Copyright (C) 2013-2015  B.A.T.M.A.N. contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/vis/vis.c b/vis/vis.c
index 3dd5c8c..038d89d 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2013-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/vis/vis.h b/vis/vis.h
index ac2afb5..a23dc83 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013-2014 B.A.T.M.A.N. contributors:
+ * Copyright (C) 2013-2015  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
-- 
2.1.4

