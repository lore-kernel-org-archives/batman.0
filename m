Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  1 Jan 2019 00:00:00 +0100
Message-Id: <20181231230001.17417-3-sven@narfation.org>
In-Reply-To: <20181231230001.17417-1-sven@narfation.org>
References: <20181231230001.17417-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/3] alfred: Update copyright years for 2019
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
 batadv_querynl.c   | 2 +-
 batadv_querynl.h   | 2 +-
 batman_adv.h       | 2 +-
 bitops.h           | 2 +-
 client.c           | 2 +-
 gpsd/Makefile      | 2 +-
 gpsd/alfred-gpsd.c | 2 +-
 gpsd/alfred-gpsd.h | 2 +-
 hash.c             | 2 +-
 hash.h             | 2 +-
 main.c             | 2 +-
 netlink.c          | 2 +-
 netlink.h          | 2 +-
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
 27 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Makefile b/Makefile
index 97277a6..0a54c1b 100755
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # -*- makefile -*-
 #
-# Copyright (C) 2012-2018  B.A.T.M.A.N. contributors
+# Copyright (C) 2012-2019  B.A.T.M.A.N. contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/alfred.h b/alfred.h
index 487e97a..7e062be 100644
--- a/alfred.h
+++ b/alfred.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/batadv_query.c b/batadv_query.c
index 9daf2d8..7486bf4 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/batadv_query.h b/batadv_query.h
index 58033f3..fd7eb2e 100644
--- a/batadv_query.h
+++ b/batadv_query.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2006-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/batadv_querynl.c b/batadv_querynl.c
index ec0389c..20ab8b3 100644
--- a/batadv_querynl.c
+++ b/batadv_querynl.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/batadv_querynl.h b/batadv_querynl.h
index abbf0da..565c0e1 100644
--- a/batadv_querynl.h
+++ b/batadv_querynl.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/batman_adv.h b/batman_adv.h
index 324a0e1..a28e76a 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: MIT */
-/* Copyright (C) 2016-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2019  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  *
diff --git a/bitops.h b/bitops.h
index 34e3714..c4dc5af 100644
--- a/bitops.h
+++ b/bitops.h
@@ -2,7 +2,7 @@
 /* Minimal Linux-like bit manipulation helper functions
  * (reduced version for alfred)
  *
- * Copyright (c) 2012-2018, Sven Eckelmann <sven@narfation.org>
+ * Copyright (c) 2012-2019, Sven Eckelmann <sven@narfation.org>
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
diff --git a/client.c b/client.c
index 4e3f990..c3bd0cb 100644
--- a/client.c
+++ b/client.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/gpsd/Makefile b/gpsd/Makefile
index 5acd101..33129c1 100755
--- a/gpsd/Makefile
+++ b/gpsd/Makefile
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # -*- makefile -*-
 #
-# Copyright (C) 2013-2018  B.A.T.M.A.N. contributors
+# Copyright (C) 2013-2019  B.A.T.M.A.N. contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 66bdb77..1db9ff9 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn, Simon Wunderlich
  *
diff --git a/gpsd/alfred-gpsd.h b/gpsd/alfred-gpsd.h
index 537686d..120b893 100644
--- a/gpsd/alfred-gpsd.h
+++ b/gpsd/alfred-gpsd.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn, Simon Wunderlich
  *
diff --git a/hash.c b/hash.c
index 1c6eec5..778a7f4 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2006-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hash.h b/hash.h
index 3149835..d3fedb1 100644
--- a/hash.h
+++ b/hash.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2006-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/main.c b/main.c
index 34d771e..6378c49 100644
--- a/main.c
+++ b/main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/netlink.c b/netlink.c
index 864123f..ffc29f2 100644
--- a/netlink.c
+++ b/netlink.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/netlink.h b/netlink.h
index f8903be..fcea003 100644
--- a/netlink.h
+++ b/netlink.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/netsock.c b/netsock.c
index a3a26d5..927e5cc 100644
--- a/netsock.c
+++ b/netsock.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/packet.h b/packet.h
index c9b7962..4378694 100644
--- a/packet.h
+++ b/packet.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Sven Eckelmann
  *
diff --git a/recv.c b/recv.c
index 5ff4bb5..a2e0602 100644
--- a/recv.c
+++ b/recv.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/send.c b/send.c
index 89bf4aa..f7f37d8 100644
--- a/send.c
+++ b/send.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/server.c b/server.c
index 151b6dd..4cbbc7b 100644
--- a/server.c
+++ b/server.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/unix_sock.c b/unix_sock.c
index 9fa6636..25348e8 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/util.c b/util.c
index 0794792..ed7407b 100644
--- a/util.c
+++ b/util.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/vis/Makefile b/vis/Makefile
index cb8bdf5..50e6112 100755
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # -*- makefile -*-
 #
-# Copyright (C) 2013-2018  B.A.T.M.A.N. contributors
+# Copyright (C) 2013-2019  B.A.T.M.A.N. contributors
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of version 2 of the GNU General Public
diff --git a/vis/vis.c b/vis/vis.c
index 6075d12..3953475 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/vis/vis.h b/vis/vis.h
index 575d210..2de49f2 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
-- 
2.19.2

