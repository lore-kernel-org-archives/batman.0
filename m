Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 10 Jun 2012 23:58:51 +0200
Message-Id: <1339365531-22386-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove bat_ prefix from
	bat_{debugfs, sysfs}.{c, h}
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

The "bat_" prefix in the source files implementing the batman-adv sysfs and
debugfs interface doesn't have a special meaning and are only used by these
files and files that implement the actual B.A.T.M.A.N. path finding algorithm.

The prefix is better suited to mark files that are used to implement the main
part of the path finding. All other files should not use it and therefore gets
renamed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile.kbuild            |    4 ++--
 bat_debugfs.c => debugfs.c |    2 +-
 bat_debugfs.h => debugfs.h |    0
 gateway_client.c           |    2 +-
 hard-interface.c           |    2 +-
 main.c                     |    4 ++--
 soft-interface.c           |    4 ++--
 bat_sysfs.c => sysfs.c     |    2 +-
 bat_sysfs.h => sysfs.h     |    0
 9 files changed, 10 insertions(+), 10 deletions(-)
 rename bat_debugfs.c => debugfs.c (99%)
 rename bat_debugfs.h => debugfs.h (100%)
 rename bat_sysfs.c => sysfs.c (99%)
 rename bat_sysfs.h => sysfs.h (100%)

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 6d5c194..8676d2b 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -19,11 +19,10 @@
 #
 
 obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
-batman-adv-y += bat_debugfs.o
 batman-adv-y += bat_iv_ogm.o
-batman-adv-y += bat_sysfs.o
 batman-adv-y += bitarray.o
 batman-adv-$(CONFIG_BATMAN_ADV_BLA) += bridge_loop_avoidance.o
+batman-adv-y += debugfs.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
@@ -35,6 +34,7 @@ batman-adv-y += ring_buffer.o
 batman-adv-y += routing.o
 batman-adv-y += send.o
 batman-adv-y += soft-interface.o
+batman-adv-y += sysfs.o
 batman-adv-y += translation-table.o
 batman-adv-y += unicast.o
 batman-adv-y += vis.o
diff --git a/bat_debugfs.c b/debugfs.c
similarity index 99%
rename from bat_debugfs.c
rename to debugfs.c
index f7d161f..de610ba 100644
--- a/bat_debugfs.c
+++ b/debugfs.c
@@ -21,7 +21,7 @@
 
 #include <linux/debugfs.h>
 
-#include "bat_debugfs.h"
+#include "debugfs.h"
 #include "translation-table.h"
 #include "originator.h"
 #include "hard-interface.h"
diff --git a/bat_debugfs.h b/debugfs.h
similarity index 100%
rename from bat_debugfs.h
rename to debugfs.h
diff --git a/gateway_client.c b/gateway_client.c
index 13bca58..6fe5cc8 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -18,7 +18,7 @@
  */
 
 #include "main.h"
-#include "bat_sysfs.h"
+#include "sysfs.h"
 #include "gateway_client.h"
 #include "gateway_common.h"
 #include "hard-interface.h"
diff --git a/hard-interface.c b/hard-interface.c
index f18ccc3..14e17ea 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -23,7 +23,7 @@
 #include "send.h"
 #include "translation-table.h"
 #include "routing.h"
-#include "bat_sysfs.h"
+#include "sysfs.h"
 #include "originator.h"
 #include "hash.h"
 #include "bridge_loop_avoidance.h"
diff --git a/main.c b/main.c
index 17dcdd9..13c88b2 100644
--- a/main.c
+++ b/main.c
@@ -18,8 +18,8 @@
  */
 
 #include "main.h"
-#include "bat_sysfs.h"
-#include "bat_debugfs.h"
+#include "sysfs.h"
+#include "debugfs.h"
 #include "routing.h"
 #include "send.h"
 #include "originator.h"
diff --git a/soft-interface.c b/soft-interface.c
index 7a7d821..b7c655c 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -22,12 +22,12 @@
 #include "hard-interface.h"
 #include "routing.h"
 #include "send.h"
-#include "bat_debugfs.h"
+#include "debugfs.h"
 #include "translation-table.h"
 #include "hash.h"
 #include "gateway_common.h"
 #include "gateway_client.h"
-#include "bat_sysfs.h"
+#include "sysfs.h"
 #include "originator.h"
 #include <linux/slab.h>
 #include <linux/ethtool.h>
diff --git a/bat_sysfs.c b/sysfs.c
similarity index 99%
rename from bat_sysfs.c
rename to sysfs.c
index ca0bdda..6d519ee 100644
--- a/bat_sysfs.c
+++ b/sysfs.c
@@ -18,7 +18,7 @@
  */
 
 #include "main.h"
-#include "bat_sysfs.h"
+#include "sysfs.h"
 #include "translation-table.h"
 #include "originator.h"
 #include "hard-interface.h"
diff --git a/bat_sysfs.h b/sysfs.h
similarity index 100%
rename from bat_sysfs.h
rename to sysfs.h
-- 
1.7.10

