Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 30 Sep 2011 13:32:00 +0200
Message-Id: <1317382322-6922-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Don't use EXTRA_CFLAGS to
	add source version
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

EXTRA_CFLAGS is deprecated since v2.6.23-2309-gf77bf01 and should not be used
anymore to add additional flags for the c compiler.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile.kbuild |    4 ++--
 README          |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 6377c17..bd7e93c 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -25,10 +25,10 @@ ifeq ($(MAKING_MODULES),1)
 -include $(TOPDIR)/Rules.make
 endif
 
-# EXTRA_CFLAGS += -DCONFIG_BATMAN_ADV_DEBUG
+# ccflags-y += -DCONFIG_BATMAN_ADV_DEBUG
 
 ifneq ($(REVISION),)
-EXTRA_CFLAGS += -DSOURCE_VERSION=\"$(REVISION)\"
+ccflags-y += -DSOURCE_VERSION=\"$(REVISION)\"
 endif
 
 obj-m += batman-adv.o
diff --git a/README b/README
index 1e000ee..5ba56b5 100644
--- a/README
+++ b/README
@@ -1,4 +1,4 @@
-[state: 21-08-2011]
+[state: 30-09-2011]
 
 BATMAN-ADV
 ----------
@@ -206,7 +206,7 @@ option "B.A.T.M.A.N. debugging". When compiling  outside  of  the
 kernel  tree it is necessary to edit the file Makefile.kbuild and
 uncomment the line
 
-#EXTRA_CFLAGS += -DCONFIG_BATMAN_ADV_DEBUG
+#ccflags-y += -DCONFIG_BATMAN_ADV_DEBUG
 
 Those additional  debug messages can be accessed  using a special
 file in debugfs
-- 
1.7.6.3

