Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/2] batman-adv: Re-add compat-patches infrastructure
Date: Sat, 26 Sep 2020 10:12:19 +0200
Message-Id: <20200926081220.40779-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>

Some patches were added again in the mainline kernel which make it rather
hard to allow building of the unmodified batman-adv sources against older
kernel versions.

Just switch again to the old build infrastructure again. It creates a
copy of the sources in net/batman-adv which can be patched and then
compiled+linked to create build/net/batman-adv/batman-adv.ko

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 .gitignore                     | 13 +-----------
 Makefile                       | 38 +++++++++++++++++++++++++++-------
 compat-patches/README          | 27 ++++++++++++++++++++++++
 compat-patches/replacements.sh |  5 +++++
 4 files changed, 64 insertions(+), 19 deletions(-)
 create mode 100644 compat-patches/README
 create mode 100755 compat-patches/replacements.sh

diff --git a/.gitignore b/.gitignore
index 4df7f60a..1a8dbc0d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,14 +1,3 @@
-/.cache.mk
 /compat-autoconf.h
 /compat-autoconf.h.tmp
-/compat-sources/**/.*
-/compat-sources/**/*.o
-/modules.order
-/Module.symvers
-/net/batman-adv/batman-adv.ko
-/net/batman-adv/.batman-adv.ko.cmd
-/net/batman-adv/batman-adv.mod.c
-/net/batman-adv/modules.order
-/net/batman-adv/*.o
-/net/batman-adv/.*.o.cmd
-/.tmp_versions
+/build/
diff --git a/Makefile b/Makefile
index afdbc03c..25c75f46 100644
--- a/Makefile
+++ b/Makefile
@@ -24,6 +24,7 @@ export CONFIG_BATMAN_ADV_SYSFS=3Dn
 export CONFIG_BATMAN_ADV_TRACING=3Dn
=20
 PWD:=3D$(shell pwd)
+BUILD_DIR=3D$(PWD)/build
 KERNELPATH ?=3D /lib/modules/$(shell uname -r)/build
 # sanity check: does KERNELPATH exist?
 ifeq ($(shell cd $(KERNELPATH) && pwd),)
@@ -32,17 +33,24 @@ endif
=20
 export KERNELPATH
 RM ?=3D rm -f
+MKDIR :=3D mkdir -p
+PATCH_FLAGS =3D --batch --fuzz=3D0 --forward --strip=3D1 --unified --ver=
sion-control=3Dnever -g0 --remove-empty-files --no-backup-if-mismatch --r=
eject-file=3D-
+PATCH :=3D patch $(PATCH_FLAGS) -i
 CP :=3D cp -fpR
 LN :=3D ln -sf
 DEPMOD :=3D depmod -a
=20
+SOURCE =3D $(wildcard net/batman-adv/*.[ch]) net/batman-adv/Makefile
+SOURCE_BUILD =3D $(wildcard $(BUILD_DIR)/net/batman-adv/*.[ch]) $(BUILD_=
DIR)/net/batman-adv/Makefile
+SOURCE_STAMP =3D $(BUILD_DIR)/net/batman-adv/.compat-prepared
+
 REVISION=3D $(shell	if [ -d "$(PWD)/.git" ]; then \
 				echo $$(git --git-dir=3D"$(PWD)/.git" describe --always --dirty --ma=
tch "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
 			fi)
 NOSTDINC_FLAGS +=3D \
-	-I$(PWD)/compat-include/ \
-	-I$(PWD)/include/ \
-	-include $(PWD)/compat.h \
+	-I$(PWD)/../compat-include/ \
+	-I$(PWD)/../include/ \
+	-include $(PWD)/../compat.h \
 	$(CFLAGS)
=20
 ifneq ($(REVISION),)
@@ -55,8 +63,8 @@ export batman-adv-y
=20
=20
 BUILD_FLAGS :=3D \
-	M=3D$(PWD) \
-	PWD=3D$(PWD) \
+	M=3D$(BUILD_DIR) \
+	PWD=3D$(BUILD_DIR) \
 	REVISION=3D$(REVISION) \
 	CONFIG_BATMAN_ADV=3Dm \
 	CONFIG_BATMAN_ADV_DEBUG=3D$(CONFIG_BATMAN_ADV_DEBUG) \
@@ -70,18 +78,34 @@ BUILD_FLAGS :=3D \
 	CONFIG_BATMAN_ADV_BATMAN_V=3D$(CONFIG_BATMAN_ADV_BATMAN_V) \
 	INSTALL_MOD_DIR=3Dupdates/
=20
-all: config
+all: config $(SOURCE_STAMP)
 	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS)	modules
=20
 clean:
 	$(RM) compat-autoconf.h*
 	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS) clean
=20
-install: config
+install: config $(SOURCE_STAMP)
 	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS) modules_install
 	$(DEPMOD)
=20
 config:
 	$(PWD)/gen-compat-autoconf.sh $(PWD)/compat-autoconf.h
=20
+$(SOURCE_STAMP): $(SOURCE) compat-patches/* compat-patches/replacements.=
sh
+	$(MKDIR) $(BUILD_DIR)/net/batman-adv/
+	@$(LN) ../Makefile $(BUILD_DIR)/Makefile
+	@$(RM) $(SOURCE_BUILD)
+	@$(CP) $(SOURCE) $(BUILD_DIR)/net/batman-adv/
+	@set -e; \
+	patches=3D"$$(ls -1 compat-patches/|grep '.patch$$'|sort)"; \
+	for i in $${patches}; do \
+		echo '  COMPAT_PATCH '$${i};\
+		cd $(BUILD_DIR); \
+		$(PATCH) ../compat-patches/$${i}; \
+		cd - > /dev/null; \
+	done
+	compat-patches/replacements.sh
+	touch $(SOURCE_STAMP)
+
 .PHONY: all clean install config
diff --git a/compat-patches/README b/compat-patches/README
new file mode 100644
index 00000000..55cb0fe2
--- /dev/null
+++ b/compat-patches/README
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+WARNING
+=3D=3D=3D=3D=3D=3D=3D
+
+Please avoid using the compat-patches/ to implement support for old kern=
els.
+This should be the last resort.
+
+ * it is nearly always possible to use compat-includes/ to do the same w=
ith a
+   lot less problems
+
+ * maintaining these patches is *censored*
+
+GENERATING A PATCH
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+If it not possible to avoid a patch then please make the patch as small =
as
+possible. Even refactor the code which has to be patched to reduce the
+size/number of the changes.
+
+Please use git-format-patches to generate them and order them inside via=
 the
+XXXX- prefix before the patch name.
+
+    git format-patch --no-stat --full-index --no-renames --binary \
+      --diff-algorithm=3Dhistogram --no-signature \
+      --format=3Dformat:'From: %an <%ae>%nDate: %aD%nSubject: %B' \
+      -1
diff --git a/compat-patches/replacements.sh b/compat-patches/replacements=
.sh
new file mode 100755
index 00000000..1b64e5c2
--- /dev/null
+++ b/compat-patches/replacements.sh
@@ -0,0 +1,5 @@
+#! /bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2007-2018  B.A.T.M.A.N. contributors
+
+set -e
--=20
2.28.0
