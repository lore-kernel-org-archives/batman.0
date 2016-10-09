Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  9 Oct 2016 08:57:28 +0200
Message-Id: <20161009065738.8279-1-sven@narfation.org>
In-Reply-To: <1647833.jYley1tZnH@sven-edge>
References: <1647833.jYley1tZnH@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH next v2 01/11] batman-adv: Introduce
	compat-patches support
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

compat-includes/compat.h can usually be used to solve compatibility
problems with older kernels. This works well for functions, defines/enums
and sometimes even structures that were introduced.

But this can fail when structs changed. Some of these can be solved in
crude ways but sometimes it is unavoidable to have a version specific code.
Unfortunately, this kind of code is not acceptable in the kernel and thus
the compat infrastructure of the external module has to do add it
automatically before the source is compiled.

This process works by creating a build directory which is prefilled with
the source from net/batman-adv/. The patches from compat-patches/ will be
applied on top of this copy and then the code is compiled.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - no change
---
 .gitignore              | 10 ++++------
 Makefile                | 31 +++++++++++++++++++++++++++----
 compat-patches/README   | 23 +++++++++++++++++++++++
 compat-sources/Makefile |  6 +++---
 4 files changed, 57 insertions(+), 13 deletions(-)
 create mode 100644 compat-patches/README

diff --git a/.gitignore b/.gitignore
index 4c03561..15a99aa 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,10 +1,8 @@
+/build/
 /compat-autoconf.h
 /compat-autoconf.h.tmp
 /compat-sources/**/.*
 /compat-sources/**/*.o
-/net/batman-adv/.*
-/net/batman-adv/batman-adv.ko
-/net/batman-adv/batman-adv.mod.c
-/net/batman-adv/modules.order
-/net/batman-adv/Module.symvers
-/net/batman-adv/*.o
+/modules.order
+/Module.symvers
+/.tmp_versions
diff --git a/Makefile b/Makefile
index d42bb56..b105290 100644
--- a/Makefile
+++ b/Makefile
@@ -33,6 +33,7 @@ export CONFIG_BATMAN_ADV_MCAST=y
 export CONFIG_BATMAN_ADV_BATMAN_V=n
 
 PWD:=$(shell pwd)
+BUILD_DIR=$(PWD)/build
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
 # sanity check: does KERNELPATH exist?
 ifeq ($(shell cd $(KERNELPATH) && pwd),)
@@ -41,6 +42,14 @@ endif
 
 export KERNELPATH
 RM ?= rm -f
+MKDIR := mkdir -p
+PATCH_FLAGS = --batch --fuzz=0 --forward --strip=1 --unified --version-control=never -g0 --remove-empty-files --no-backup-if-mismatch --reject-file=-
+PATCH := patch $(PATCH_FLAGS) -i
+CP := cp -fpR
+
+SOURCE = $(wildcard net/batman-adv/*.[ch]) net/batman-adv/Makefile
+SOURCE_BUILD = $(wildcard $(BUILD_DIR)/net/batman-adv/*.[ch]) $(BUILD_DIR)/net/batman-adv/Makefile
+SOURCE_STAMP = $(BUILD_DIR)/net/batman-adv/.compat-prepared
 
 REVISION= $(shell	if [ -d "$(PWD)/.git" ]; then \
 				echo $$(git --git-dir="$(PWD)/.git" describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
@@ -57,7 +66,7 @@ endif
 
 include $(PWD)/compat-sources/Makefile
 
-obj-y += net/batman-adv/
+obj-y += build/net/batman-adv/
 
 export batman-adv-y
 
@@ -76,18 +85,32 @@ BUILD_FLAGS := \
 	CONFIG_BATMAN_ADV_BATMAN_V=$(CONFIG_BATMAN_ADV_BATMAN_V) \
 	INSTALL_MOD_DIR=updates/
 
-all: config
+all: config $(SOURCE_STAMP)
 	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS)	modules
 
 clean:
 	$(RM) compat-autoconf.h*
-	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS) clean
+	$(RM) -r $(BUILD_DIR)
 
-install: config
+install: config $(SOURCE_STAMP)
 	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS) modules_install
 	depmod -a
 
 config:
 	$(PWD)/gen-compat-autoconf.sh $(PWD)/compat-autoconf.h
 
+$(SOURCE_STAMP): $(SOURCE) compat-patches/*
+	$(MKDIR) $(BUILD_DIR)/net/batman-adv/
+	@$(RM) $(SOURCE_BUILD)
+	@$(CP) $(SOURCE) $(BUILD_DIR)/net/batman-adv/
+	@set -e; \
+	patches="$$(ls -1 compat-patches/|grep '.patch$$'|sort)"; \
+	for i in $${patches}; do \
+		echo '  COMPAT_PATCH '$${i};\
+		cd $(BUILD_DIR); \
+		$(PATCH) ../compat-patches/$${i}; \
+		cd - > /dev/null; \
+	done
+	touch $(SOURCE_STAMP)
+
 .PHONY: all clean install config
diff --git a/compat-patches/README b/compat-patches/README
new file mode 100644
index 0000000..3bbddb3
--- /dev/null
+++ b/compat-patches/README
@@ -0,0 +1,23 @@
+WARNING
+=======
+
+Please avoid using the compat-patches/ to implement support for old kernels.
+This should be the last resort.
+
+ * it is nearly always possible to use compat-includes/ to do the same with a
+   lot less problems
+
+ * maintaining these patches is *censored*
+
+GENERATING A PATCH
+==================
+
+If it not possible to avoid a patch then please make the patch as small as
+possible. Even refactor the code which has to be patched to reduce the
+size/number of the changes.
+
+Please use git-format-patches to generate them and order same inside via the
+XXXX- prefix of the patch name.
+
+    git format-patch --abbrev=7 -U3 --diff-algorithm=histogram --no-signature \
+	--format=format:'From: %an <%ae>%nDate: %aD%nSubject: [PATCH] %B' -1
diff --git a/compat-sources/Makefile b/compat-sources/Makefile
index a45c202..c8bae49 100644
--- a/compat-sources/Makefile
+++ b/compat-sources/Makefile
@@ -1,3 +1,3 @@
-batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../compat-sources/net/core/skbuff.o
-batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../compat-sources/net/ipv4/igmp.o
-batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../compat-sources/net/ipv6/mcast_snoop.o
+batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../../compat-sources/net/core/skbuff.o
+batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../../compat-sources/net/ipv4/igmp.o
+batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../../compat-sources/net/ipv6/mcast_snoop.o
-- 
2.9.3

