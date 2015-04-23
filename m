Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 23 Apr 2015 13:16:36 +0200
Message-Id: <1429787796-11341-2-git-send-email-sven@narfation.org>
In-Reply-To: <1429787796-11341-1-git-send-email-sven@narfation.org>
References: <1429787796-11341-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: update copyright years for
	2015 in compat code
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile                               | 2 +-
 compat-include/linux/atomic.h          | 2 +-
 compat-include/linux/bug.h             | 2 +-
 compat-include/linux/compiler.h        | 2 +-
 compat-include/linux/etherdevice.h     | 2 +-
 compat-include/linux/export.h          | 2 +-
 compat-include/linux/if_ether.h        | 2 +-
 compat-include/linux/if_vlan.h         | 2 +-
 compat-include/linux/kconfig.h         | 2 +-
 compat-include/linux/kernel.h          | 2 +-
 compat-include/linux/list.h            | 2 +-
 compat-include/linux/moduleparam.h     | 2 +-
 compat-include/linux/net.h             | 2 +-
 compat-include/linux/netdev_features.h | 2 +-
 compat-include/linux/netdevice.h       | 2 +-
 compat-include/linux/percpu.h          | 2 +-
 compat-include/linux/printk.h          | 2 +-
 compat-include/linux/random.h          | 2 +-
 compat-include/linux/rculist.h         | 2 +-
 compat-include/linux/rcupdate.h        | 2 +-
 compat-include/linux/seq_file.h        | 2 +-
 compat-include/linux/skbuff.h          | 2 +-
 compat-include/linux/slab.h            | 2 +-
 compat.h                               | 2 +-
 24 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index e57fcb3..3700f34 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/compat-include/linux/atomic.h b/compat-include/linux/atomic.h
index 304af51..025c8b1 100644
--- a/compat-include/linux/atomic.h
+++ b/compat-include/linux/atomic.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/bug.h b/compat-include/linux/bug.h
index 66f79f8..9b7b571 100644
--- a/compat-include/linux/bug.h
+++ b/compat-include/linux/bug.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/compiler.h b/compat-include/linux/compiler.h
index 1717105..29a02ae 100644
--- a/compat-include/linux/compiler.h
+++ b/compat-include/linux/compiler.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/etherdevice.h b/compat-include/linux/etherdevice.h
index c20b43c..aada96d 100644
--- a/compat-include/linux/etherdevice.h
+++ b/compat-include/linux/etherdevice.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/export.h b/compat-include/linux/export.h
index 3b31a2d..3901b29 100644
--- a/compat-include/linux/export.h
+++ b/compat-include/linux/export.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/if_ether.h b/compat-include/linux/if_ether.h
index 5ea164f..edfc7e8 100644
--- a/compat-include/linux/if_ether.h
+++ b/compat-include/linux/if_ether.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/if_vlan.h b/compat-include/linux/if_vlan.h
index 3b146b4..0cbd5c4 100644
--- a/compat-include/linux/if_vlan.h
+++ b/compat-include/linux/if_vlan.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/kconfig.h b/compat-include/linux/kconfig.h
index be8aa02..a8d0766 100644
--- a/compat-include/linux/kconfig.h
+++ b/compat-include/linux/kconfig.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/kernel.h b/compat-include/linux/kernel.h
index 81b2862..6eee020 100644
--- a/compat-include/linux/kernel.h
+++ b/compat-include/linux/kernel.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/list.h b/compat-include/linux/list.h
index dcd604c..75bcc1c 100644
--- a/compat-include/linux/list.h
+++ b/compat-include/linux/list.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/moduleparam.h b/compat-include/linux/moduleparam.h
index fd8ac41..c266b9c 100644
--- a/compat-include/linux/moduleparam.h
+++ b/compat-include/linux/moduleparam.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/net.h b/compat-include/linux/net.h
index fcd7873..c60acf7 100644
--- a/compat-include/linux/net.h
+++ b/compat-include/linux/net.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/netdev_features.h b/compat-include/linux/netdev_features.h
index 36c9c2f..f381142 100644
--- a/compat-include/linux/netdev_features.h
+++ b/compat-include/linux/netdev_features.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 8d77bd8..f19f624 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/percpu.h b/compat-include/linux/percpu.h
index 82355e4..34d3bb7 100644
--- a/compat-include/linux/percpu.h
+++ b/compat-include/linux/percpu.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/printk.h b/compat-include/linux/printk.h
index c69c406..2b31ed1 100644
--- a/compat-include/linux/printk.h
+++ b/compat-include/linux/printk.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/random.h b/compat-include/linux/random.h
index ce12f1a..55b0384 100644
--- a/compat-include/linux/random.h
+++ b/compat-include/linux/random.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/rculist.h b/compat-include/linux/rculist.h
index 4736db1..0b8d7c6 100644
--- a/compat-include/linux/rculist.h
+++ b/compat-include/linux/rculist.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/rcupdate.h b/compat-include/linux/rcupdate.h
index 12a1c2a..f0d0413 100644
--- a/compat-include/linux/rcupdate.h
+++ b/compat-include/linux/rcupdate.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/seq_file.h b/compat-include/linux/seq_file.h
index 5eaaec8..3c0c618 100644
--- a/compat-include/linux/seq_file.h
+++ b/compat-include/linux/seq_file.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index ed911ef..d363cc0 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/slab.h b/compat-include/linux/slab.h
index 569c5aa..276d678 100644
--- a/compat-include/linux/slab.h
+++ b/compat-include/linux/slab.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat.h b/compat.h
index 99e75c5..05fb4f1 100644
--- a/compat.h
+++ b/compat.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
-- 
2.1.4

