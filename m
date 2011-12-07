Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  7 Dec 2011 13:29:11 +0100
Message-Id: <1323260777-30119-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Allow to disable features
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

The user could not disable features which were enabled in the target kernel as
explained in b3d474c54bca76797e88878f29f100a7d5c7e02b. We have to undef
batman-adv specific preprocessor variables and generate an own header that sets
them according to the user settings.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile               |   17 +++++++++++------
 compat.h               |    7 +++++++
 gen-compat-autoconf.sh |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 6 deletions(-)
 create mode 100755 gen-compat-autoconf.sh

diff --git a/Makefile b/Makefile
index e78e797..99fd366 100644
--- a/Makefile
+++ b/Makefile
@@ -18,10 +18,9 @@
 # 02110-1301, USA
 #
 
-# uncomment the CONFIG_* line to enable the related feature
-# features enabled in the target kernel configuration cannot be disabled
+# changing the CONFIG_* line to 'y' enables the related feature
 # B.A.T.M.A.N. debugging:
-# CONFIG_BATMAN_ADV_DEBUG=y
+export CONFIG_BATMAN_ADV_DEBUG=n
 
 PWD:=$(shell pwd)
 KERNELPATH ?= /lib/modules/$(shell uname -r)/build
@@ -31,6 +30,7 @@ $(warning $(KERNELPATH) is missing, please set KERNELPATH)
 endif
 
 export KERNELPATH
+RM ?= rm -f
 
 REVISION= $(shell	if [ -d .git ]; then \
 				echo $$(git describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
@@ -41,14 +41,19 @@ batman-adv-y += compat.o
 ifneq ($(REVISION),)
 ccflags-y += -DSOURCE_VERSION=\"$(REVISION)\"
 endif
-ccflags-$(CONFIG_BATMAN_ADV_DEBUG) += -DCONFIG_BATMAN_ADV_DEBUG
 include $(PWD)/Makefile.kbuild
 
-all:
+all: config
 	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) modules
 
 clean:
+	$(RM) compat-autoconf.h*
 	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) clean
 
-install:
+install: config
 	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) INSTALL_MOD_DIR=kernel/net/batman-adv/ modules_install
+
+config:
+	$(PWD)/gen-compat-autoconf.sh $(PWD)/compat-autoconf.h
+
+.PHONY: all clean install config
diff --git a/compat.h b/compat.h
index 964c066..6480614 100644
--- a/compat.h
+++ b/compat.h
@@ -27,6 +27,13 @@
 
 #include <linux/version.h>	/* LINUX_VERSION_CODE */
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33))
+#include <linux/autoconf.h>
+#else
+#include <generated/autoconf.h>
+#endif
+#include "compat-autoconf.h"
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 33)
 
 #define __always_unused			__attribute__((unused))
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
new file mode 100755
index 0000000..440accc
--- /dev/null
+++ b/gen-compat-autoconf.sh
@@ -0,0 +1,35 @@
+#! /bin/sh
+
+set -e
+
+TARGET=${1:="compat-autoconf.h"}
+TMP="${TARGET}.tmp"
+
+echo -n > "${TMP}"
+
+gen_config() {
+	KEY="${1}"
+	VALUE="${2}"
+
+	echo "#undef ${KEY}"
+	case "${VALUE}" in
+	y)
+		echo "#define ${KEY} 1"
+		;;
+	m)
+		echo "#define ${KEY} 1"
+		;;
+	n)
+		# leave it undefined
+		;;
+	*)
+		echo "#define ${KEY} \"${VALUE}\""
+		;;
+	esac
+}
+
+# write config variables
+gen_config 'CONFIG_BATMAN_ADV_DEBUG' ${CONFIG_BATMAN_ADV_DEBUG:="n"} >> "${TMP}"
+
+# only regenerate compat-autoconf.h when config was changed
+diff "${TMP}" "${TARGET}" > /dev/null 2>&1 || cp "${TMP}" "${TARGET}"
-- 
1.7.7.3

