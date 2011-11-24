Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 24 Nov 2011 11:40:38 +0100
Message-Id: <1322131238-11036-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: Move build compat stuff to Makefile
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

Hi,

I looked at the new patches from ordex and thought about using the Makefile
from the kernel as the Makefile.kbuild in the standalone distribution. The
Makefile is only the user friendly compatibility layer over the kbuild stuff.

The problem is: The OpenWRT buildscript only uses the Makefile.kbuild (for a
reason I don't know right now) and "adds" those extra includes for OpenWRT
specific rules to the Makefile.kbuild (another part I never understood and only
saw in the batman-adv makefiles).

So maybe it is possible to discuss those different points and maybe find a
solution for it. Things which are done here:
 * Import of kernel Makefile as Makefile.kbuild
   - Removes OpenWRT specific include of Rules.make
   - Removes place to manually set -DCONFIG_BATMAN_ADV_DEBUG
   - Removes compat.c build
 * Removal of the automatic detection of CPUs (see the discussion of the batctl
   patch)
 * Enabling of the batman-adv module build and adding of compat.o to the build
   through Makefile instead of Makefile.kbuild
 * Introducing the "new" way to enable optional features through
   `make CONFIG_BATMAN_ADV_FEATURE=y`
 * Fix of source revision "branding" when directly calling `make install` in
   the clean source directory

Kind regards,
	Sven
---
diff --git a/Makefile b/Makefile
index 3374687..b4159ed 100644
--- a/Makefile
+++ b/Makefile
@@ -33,15 +33,19 @@ REVISION= $(shell	if [ -d .git ]; then \
 				echo $$(git describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
 			fi)
 
-NUM_CPUS = $(shell nproc 2> /dev/null || echo 1)
-
+CONFIG_BATMAN_ADV=m
+batman-adv-y += compat.o
+ifneq ($(REVISION),)
+ccflags-y += -DSOURCE_VERSION=\"$(REVISION)\"
+endif
+ccflags-$(CONFIG_BATMAN_ADV_DEBUG) += -DCONFIG_BATMAN_ADV_DEBUG
 include $(PWD)/Makefile.kbuild
 
 all:
-	$(MAKE) -C $(KERNELPATH) REVISION=$(REVISION) M=$(PWD) PWD=$(PWD) -j $(NUM_CPUS) modules
+	$(MAKE) -C $(KERNELPATH) REVISION=$(REVISION) M=$(PWD) PWD=$(PWD) modules
 
 clean:
 	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) clean
 
 install:
-	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) INSTALL_MOD_DIR=kernel/net/batman-adv/ modules_install
+	$(MAKE) -C $(KERNELPATH) REVISION=$(REVISION) M=$(PWD) PWD=$(PWD) INSTALL_MOD_DIR=kernel/net/batman-adv/ modules_install
diff --git a/Makefile.kbuild b/Makefile.kbuild
index bd7e93c..ce68611 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -18,20 +18,7 @@
 # 02110-1301, USA
 #
 
-
-
-# openwrt integration
-ifeq ($(MAKING_MODULES),1)
--include $(TOPDIR)/Rules.make
-endif
-
-# ccflags-y += -DCONFIG_BATMAN_ADV_DEBUG
-
-ifneq ($(REVISION),)
-ccflags-y += -DSOURCE_VERSION=\"$(REVISION)\"
-endif
-
-obj-m += batman-adv.o
+obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
 batman-adv-y += bat_debugfs.o
 batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bat_sysfs.o
@@ -50,4 +37,3 @@ batman-adv-y += soft-interface.o
 batman-adv-y += translation-table.o
 batman-adv-y += unicast.o
 batman-adv-y += vis.o
-batman-adv-y += compat.o
diff --git a/README b/README
index 7404c0a..ddc9569 100644
--- a/README
+++ b/README
@@ -207,10 +207,10 @@ times  necessary  to see more detail debug messages. This must be
 enabled when compiling the batman-adv module. When building  bat-
 man-adv  as  part of kernel, use "make menuconfig" and enable the
 option "B.A.T.M.A.N. debugging". When compiling  outside  of  the
-kernel  tree it is necessary to edit the file Makefile.kbuild and
-uncomment the line
+kernel  tree it is necessary to enable  it using  the make option
+CONFIG_BATMAN_ADV_DEBUG=y
 
-#ccflags-y += -DCONFIG_BATMAN_ADV_DEBUG
+# make CONFIG_BATMAN_ADV_DEBUG=y
 
 Those additional  debug messages can be accessed  using a special
 file in debugfs
-- 
1.7.7.1

