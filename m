Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Oct 2016 11:46:29 +0100
Message-Id: <20161030104629.16418-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Install module in
	$INSTALL_MOD_DIR/updates/net/batman-adv
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
Cc: jj.sarton@t-online.de

depmod may skip the batman-adv.ko module in the $INSTALL_MOD_DIR/update/
folder when it is also available in $INSTALL_MOD_DIR/kernel/ but in an
higher position in the subtree.

Avoid this extra directory "build" in the installation path by making the
obj-y dir relative to build/ in the source directory.

Reported-by: Jean-Jacques Sarton <jj.sarton@t-online.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 7ef2569..2f5cff6 100644
--- a/Makefile
+++ b/Makefile
@@ -46,6 +46,7 @@ MKDIR := mkdir -p
 PATCH_FLAGS = --batch --fuzz=0 --forward --strip=1 --unified --version-control=never -g0 --remove-empty-files --no-backup-if-mismatch --reject-file=-
 PATCH := patch $(PATCH_FLAGS) -i
 CP := cp -fpR
+LN := ln -sf
 
 SOURCE = $(wildcard net/batman-adv/*.[ch]) net/batman-adv/Makefile
 SOURCE_BUILD = $(wildcard $(BUILD_DIR)/net/batman-adv/*.[ch]) $(BUILD_DIR)/net/batman-adv/Makefile
@@ -55,25 +56,25 @@ REVISION= $(shell	if [ -d "$(PWD)/.git" ]; then \
 				echo $$(git --git-dir="$(PWD)/.git" describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
 			fi)
 NOSTDINC_FLAGS += \
-	-I$(PWD)/compat-include/ \
-	-I$(PWD)/include/ \
-	-include $(PWD)/compat.h \
+	-I$(PWD)/../compat-include/ \
+	-I$(PWD)/../include/ \
+	-include $(PWD)/../compat.h \
 	$(CFLAGS)
 
 ifneq ($(REVISION),)
 NOSTDINC_FLAGS += -DBATADV_SOURCE_VERSION=\"$(REVISION)\"
 endif
 
-include $(PWD)/compat-sources/Makefile
+-include $(PWD)/../compat-sources/Makefile
 
-obj-y += build/net/batman-adv/
+obj-y += net/batman-adv/
 
 export batman-adv-y
 
 
 BUILD_FLAGS := \
-	M=$(PWD) \
-	PWD=$(PWD) \
+	M=$(BUILD_DIR) \
+	PWD=$(BUILD_DIR) \
 	REVISION=$(REVISION) \
 	CONFIG_BATMAN_ADV=m \
 	CONFIG_BATMAN_ADV_DEBUG=$(CONFIG_BATMAN_ADV_DEBUG) \
@@ -89,6 +90,7 @@ all: config $(SOURCE_STAMP)
 	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS)	modules
 
 clean:
+	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS) modules_clean
 	$(RM) compat-autoconf.h*
 	$(RM) -r $(BUILD_DIR)
 
@@ -101,6 +103,7 @@ config:
 
 $(SOURCE_STAMP): $(SOURCE) compat-patches/* compat-patches/replacements.sh
 	$(MKDIR) $(BUILD_DIR)/net/batman-adv/
+	@$(LN) ../Makefile $(BUILD_DIR)/Makefile
 	@$(RM) $(SOURCE_BUILD)
 	@$(CP) $(SOURCE) $(BUILD_DIR)/net/batman-adv/
 	@set -e; \
-- 
2.10.1

