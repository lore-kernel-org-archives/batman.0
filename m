Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  4 Dec 2011 20:10:47 +0100
Message-Id: <1323025848-14024-3-git-send-email-sven@narfation.org>
In-Reply-To: <1323025848-14024-1-git-send-email-sven@narfation.org>
References: <1323025848-14024-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Remove non-kernel parts from
	Makefile.kbuild
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

The standalone batman-adv module is sent to the linux kernel maintainers to be
merged by them. A batman-adv developer has to manually merge the changes since
the last submission and apply it on top of the current linux development tree.
The standalone sources have to provide an additional layer that increases the
compatibility to kernels and to give a better user experience. This layer will
not be sent to the kernel maintainers and has to manually removed each time.

To reduce this work, the Makefile.kbuild should be cleaned up to be only the
vanilla version of the Makefile in the kernel. The Makefile in the standalone
sources is used to provide most of the additional layer.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile        |    8 +++++++-
 Makefile.kbuild |    9 +--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 15f099e..4f338aa 100644
--- a/Makefile
+++ b/Makefile
@@ -33,10 +33,16 @@ REVISION= $(shell	if [ -d .git ]; then \
 				echo $$(git describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
 			fi)
 
+CONFIG_BATMAN_ADV=m
+batman-adv-y += compat.o
+ifneq ($(REVISION),)
+ccflags-y += -DSOURCE_VERSION=\"$(REVISION)\"
+endif
+# ccflags-y += -DCONFIG_BATMAN_ADV_DEBUG
 include $(PWD)/Makefile.kbuild
 
 all:
-	$(MAKE) -C $(KERNELPATH) REVISION=$(REVISION) M=$(PWD) PWD=$(PWD) modules
+	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) modules
 
 clean:
 	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) clean
diff --git a/Makefile.kbuild b/Makefile.kbuild
index 3c51455..ce68611 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -18,13 +18,7 @@
 # 02110-1301, USA
 #
 
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
@@ -43,4 +37,3 @@ batman-adv-y += soft-interface.o
 batman-adv-y += translation-table.o
 batman-adv-y += unicast.o
 batman-adv-y += vis.o
-batman-adv-y += compat.o
-- 
1.7.7.3

