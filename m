Return-Path: <sven@dvalin.narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/3] alfred: Update copyright years for 2020
Date: Wed,  1 Jan 2020 00:00:59 +0100
Message-Id: <20191231230101.32668-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 8840961..2bfe18c 100755
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # -*- makefile -*-
 #
-# Copyright (C) 2012-2019  B.A.T.M.A.N. contributors
+# Copyright (C) 2012-2020  B.A.T.M.A.N. contributors
 #
 # License-Filename: LICENSES/preferred/GPL-2.0
 
diff --git a/alfred.h b/alfred.h
index 2b7e175..38cc27b 100644
--- a/alfred.h
+++ b/alfred.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/batadv_query.c b/batadv_query.c
index fb72e77..f758b42 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/batadv_query.h b/batadv_query.h
index 7e93791..291292d 100644
--- a/batadv_query.h
+++ b/batadv_query.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/batadv_querynl.c b/batadv_querynl.c
index d5e9402..2793242 100644
--- a/batadv_querynl.c
+++ b/batadv_querynl.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/batadv_querynl.h b/batadv_querynl.h
index e2066c2..f684ad8 100644
--- a/batadv_querynl.h
+++ b/batadv_querynl.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/batman_adv.h b/batman_adv.h
index 67f4636..617c180 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: MIT */
-/* Copyright (C) 2016-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2020  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  */
diff --git a/bitops.h b/bitops.h
index ead4a4f..2333aa4 100644
--- a/bitops.h
+++ b/bitops.h
@@ -2,7 +2,7 @@
 /* Minimal Linux-like bit manipulation helper functions
  * (reduced version for alfred)
  *
- * Copyright (c) 2012-2019, Sven Eckelmann <sven@narfation.org>
+ * Copyright (c) 2012-2020, Sven Eckelmann <sven@narfation.org>
  *
  * License-Filename: LICENSES/preferred/MIT
  */
diff --git a/client.c b/client.c
index 85a05ce..b808295 100644
--- a/client.c
+++ b/client.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/gpsd/Makefile b/gpsd/Makefile
index 81bf254..0645573 100755
--- a/gpsd/Makefile
+++ b/gpsd/Makefile
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # -*- makefile -*-
 #
-# Copyright (C) 2013-2019  B.A.T.M.A.N. contributors
+# Copyright (C) 2013-2020  B.A.T.M.A.N. contributors
 #
 # License-Filename: LICENSES/preferred/GPL-2.0
 
diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 6e9137c..884bdbf 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2020  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn, Simon Wunderlich
  *
diff --git a/gpsd/alfred-gpsd.h b/gpsd/alfred-gpsd.h
index addfa4f..5783eee 100644
--- a/gpsd/alfred-gpsd.h
+++ b/gpsd/alfred-gpsd.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2020  B.A.T.M.A.N. contributors:
  *
  * Andrew Lunn, Simon Wunderlich
  *
diff --git a/hash.c b/hash.c
index 02ac15e..82a287e 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/hash.h b/hash.h
index f5a8fb5..32a9e57 100644
--- a/hash.h
+++ b/hash.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/main.c b/main.c
index f633462..57bea61 100644
--- a/main.c
+++ b/main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/netlink.c b/netlink.c
index e8fe55e..865ed9f 100644
--- a/netlink.c
+++ b/netlink.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/netlink.h b/netlink.h
index 26ad1e8..2964a2b 100644
--- a/netlink.h
+++ b/netlink.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2020  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
  *
diff --git a/netsock.c b/netsock.c
index fcbc20b..9b200d2 100644
--- a/netsock.c
+++ b/netsock.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/packet.h b/packet.h
index 564afad..ad2dfa6 100644
--- a/packet.h
+++ b/packet.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: MIT */
-/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Sven Eckelmann
  *
diff --git a/recv.c b/recv.c
index e7c2c24..74a0f85 100644
--- a/recv.c
+++ b/recv.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/send.c b/send.c
index d4043bc..02f4022 100644
--- a/send.c
+++ b/send.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/server.c b/server.c
index 18109cc..cdd5be2 100644
--- a/server.c
+++ b/server.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/unix_sock.c b/unix_sock.c
index 1d17cee..420affc 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/util.c b/util.c
index e14350e..f1dc0dc 100644
--- a/util.c
+++ b/util.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/vis/Makefile b/vis/Makefile
index 53d1f44..cfd0921 100755
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # -*- makefile -*-
 #
-# Copyright (C) 2013-2019  B.A.T.M.A.N. contributors
+# Copyright (C) 2013-2020  B.A.T.M.A.N. contributors
 #
 # License-Filename: LICENSES/preferred/GPL-2.0
 
diff --git a/vis/vis.c b/vis/vis.c
index cdc5524..17e067e 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/vis/vis.h b/vis/vis.h
index fa5a248..3e8277a 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2020  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
-- 
2.20.1

