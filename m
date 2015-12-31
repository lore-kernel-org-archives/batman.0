Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  1 Jan 2016 00:01:01 +0100
Message-Id: <1451602861-23280-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: update copyright years for 2016
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
index 818b1fd..939e9f8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 #!/usr/bin/make -f
 # -*- makefile -*-
 #
-# Copyright (C) 2012-2015  B.A.T.M.A.N. contributors
+# Copyright (C) 2012-2016  B.A.T.M.A.N. contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/alfred.h b/alfred.h
index b23487f..cf97e78 100644
--- a/alfred.h
+++ b/alfred.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/batadv_query.c b/batadv_query.c
index c289b80..2604503 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/batadv_query.h b/batadv_query.h
index 8991ee9..d9660bc 100644
--- a/batadv_query.h
+++ b/batadv_query.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/client.c b/client.c
index 22b8439..2a5e8a5 100644
--- a/client.c
+++ b/client.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/gpsd/Makefile b/gpsd/Makefile
index 5055987..72e4445 100644
--- a/gpsd/Makefile
+++ b/gpsd/Makefile
@@ -1,7 +1,7 @@
 #!/usr/bin/make -f
 # -*- makefile -*-
 #
-# Copyright (C) 2013-2015  B.A.T.M.A.N. contributors
+# Copyright (C) 2013-2016  B.A.T.M.A.N. contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 2516417..88f841c 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2013-2016  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn, Simon Wunderlich
  *
diff --git a/gpsd/alfred-gpsd.h b/gpsd/alfred-gpsd.h
index 4f87063..ca91f43 100644
--- a/gpsd/alfred-gpsd.h
+++ b/gpsd/alfred-gpsd.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2013-2016  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn, Simon Wunderlich
  *
diff --git a/hash.c b/hash.c
index f2c8b9c..7669679 100644
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
index 6e027bb..24bddb1 100644
--- a/hash.h
+++ b/hash.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2006-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/main.c b/main.c
index 452d9ae..9610398 100644
--- a/main.c
+++ b/main.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/netsock.c b/netsock.c
index 6bf6016..d72541e 100644
--- a/netsock.c
+++ b/netsock.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/packet.h b/packet.h
index 5ecdf39..ebb4274 100644
--- a/packet.h
+++ b/packet.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Sven Eckelmann
  *
diff --git a/recv.c b/recv.c
index f459190..98539cb 100644
--- a/recv.c
+++ b/recv.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/send.c b/send.c
index 43c10f4..70f694c 100644
--- a/send.c
+++ b/send.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/server.c b/server.c
index ac253a9..47aee4f 100644
--- a/server.c
+++ b/server.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/unix_sock.c b/unix_sock.c
index 570c62c..3c7e583 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/util.c b/util.c
index 84d4b2d..db6ec96 100644
--- a/util.c
+++ b/util.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2012-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/vis/Makefile b/vis/Makefile
index 32a578e..accd1fa 100644
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -1,7 +1,7 @@
 #!/usr/bin/make -f
 # -*- makefile -*-
 #
-# Copyright (C) 2013-2015  B.A.T.M.A.N. contributors
+# Copyright (C) 2013-2016  B.A.T.M.A.N. contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/vis/vis.c b/vis/vis.c
index c1f8dad..753cb91 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2013-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/vis/vis.h b/vis/vis.h
index 969ca33..1b7e210 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013-2015  B.A.T.M.A.N. contributors:
+ * Copyright (C) 2013-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
-- 
2.6.4

