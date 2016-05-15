Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 May 2016 23:46:02 +0200
Message-Id: <1463348762-26642-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: Fix build against recent
	Debian Stretch kernels
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

The kernels for Debian stretch require some special CFLAGS settings which
are only correctly defined when NOSTDINC_FLAGS is defined inside the
execution of the Makefile via kbuild. But batman-adv sets it currently
outside to insert compatibility include headers and compat-sources.

This can be avoided by making the top Makefile kbuild compatible and
redefining the NOSTDINC_FLAGS when kbuild include this Makefile. The actual
build of the batman-adv module is then done by adding the subdirectory to
obj-y.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 365a7cc..d662573 100644
--- a/Makefile
+++ b/Makefile
@@ -43,7 +43,7 @@ RM ?= rm -f
 REVISION= $(shell	if [ -d "$(PWD)/.git" ]; then \
 				echo $$(git --git-dir="$(PWD)/.git" describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
 			fi)
-export NOSTDINC_FLAGS := \
+NOSTDINC_FLAGS := \
 	-I$(PWD)/compat-include/ \
 	-I$(PWD)/include/ \
 	-include $(PWD)/compat.h \
@@ -54,11 +54,13 @@ NOSTDINC_FLAGS += -DBATADV_SOURCE_VERSION=\"$(REVISION)\"
 endif
 
 include $(PWD)/compat-sources/Makefile
-
+obj-y += net/batman-adv/
 export batman-adv-y
 
 BUILD_FLAGS := \
-	M=$(PWD)/net/batman-adv \
+	M=$(PWD) \
+	PWD=$(PWD) \
+	REVISION=$(REVISION) \
 	CONFIG_BATMAN_ADV=m \
 	CONFIG_BATMAN_ADV_DEBUG=$(CONFIG_BATMAN_ADV_DEBUG) \
 	CONFIG_BATMAN_ADV_BLA=$(CONFIG_BATMAN_ADV_BLA) \
@@ -66,7 +68,7 @@ BUILD_FLAGS := \
 	CONFIG_BATMAN_ADV_NC=$(CONFIG_BATMAN_ADV_NC) \
 	CONFIG_BATMAN_ADV_MCAST=$(CONFIG_BATMAN_ADV_MCAST) \
 	CONFIG_BATMAN_ADV_BATMAN_V=$(CONFIG_BATMAN_ADV_BATMAN_V) \
-	INSTALL_MOD_DIR=updates/net/batman-adv/
+	INSTALL_MOD_DIR=updates/
 
 all: config
 	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS)	modules
-- 
2.8.1

