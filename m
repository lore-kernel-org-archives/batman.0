Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 31 Oct 2016 08:27:19 +0100
Message-Id: <20161031072719.26286-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint v3] batman-adv: Install module in
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

depmod may skip the batman-adv.ko module in the $INSTALL_MOD_DIR/update/
folder when it contains the word "build" as directory name.

Avoid this extra directory "build" in the installation path by making the
obj-y dir relative to build/ in the source directory.

Reported-by: Jean-Jacques Sarton <jj.sarton@t-online.de>
Fixes: 66ac14a09445 ("batman-adv: Introduce compat-patches support")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3:
 - adjust commit message
v2:
 - Remove clean target change which was accidentally added to this patch

 Makefile | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 1d2e01c..e9c499f 100644
--- a/Makefile
+++ b/Makefile
@@ -54,6 +54,7 @@ PATCH_FLAGS = --batch --fuzz=0 --forward --strip=1 --unified --version-control=n
 PATCH := patch $(PATCH_FLAGS) -i
 SPATCH_FLAGS := --in-place --relax-include-path --use-coccigrep --very-quiet
 CP := cp -fpR
+LN := ln -sf
 
 SOURCE = $(wildcard net/batman-adv/*.[ch]) net/batman-adv/Makefile
 SOURCE_BUILD = $(wildcard $(BUILD_DIR)/net/batman-adv/*.[ch]) $(BUILD_DIR)/net/batman-adv/Makefile
@@ -63,25 +64,25 @@ REVISION= $(shell	if [ -d "$(PWD)/.git" ]; then \
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
@@ -109,6 +110,7 @@ config:
 
 $(SOURCE_STAMP): $(SOURCE) compat-patches/*
 	$(MKDIR) $(BUILD_DIR)/net/batman-adv/
+	@$(LN) ../Makefile $(BUILD_DIR)/Makefile
 	@$(RM) $(SOURCE_BUILD)
 	@$(CP) $(SOURCE) $(BUILD_DIR)/net/batman-adv/
 	@set -e; \
