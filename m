Return-Path: <russell@personaltelco.net>
References: <86r4775d8s.fsf@coulee.tdb.com>
From: Russell Senior <russell@personaltelco.net>
Date: Thu, 13 Feb 2014 06:01:19 -0800
In-Reply-To: <86r4775d8s.fsf@coulee.tdb.com> (Russell Senior's message of
 "Thu\, 13 Feb 2014 05\:54\:59 -0800")
Message-ID: <86mwhv5cy8.fsf@coulee.tdb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [B.A.T.M.A.N.] [PATCH 2/4] openwrt routing feed: batman-adv: split
	kmod and userland into separate packages
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Creates a new package, batctl, split out from the batman-adv package.
Simplifies the Makefiles, allows QUILT patch management to work,
removes the quirky naming requirement for patches.  The batctl package
is a dependency of kmod-batman-adv, retaining the existing dependency
relationship.

Signed-off-by: Russell Senior <russell@personaltelco.net>
---
 batctl/Makefile                                    | 66 +++++++++++++++++
 batman-adv/Config.in                               |  9 ---
 batman-adv/Makefile                                | 84 +++-------------------
 .../patches/0011-batman-adv-memory-leak-fix.patch  | 15 ++--
 4 files changed, 80 insertions(+), 94 deletions(-)
 create mode 100644 batctl/Makefile

diff --git a/batctl/Makefile b/batctl/Makefile
new file mode 100644
index 0000000..7a34957
--- /dev/null
+++ b/batctl/Makefile
@@ -0,0 +1,66 @@
+#
+# Copyright (C) 2010-2014 OpenWrt.org
+#
+# This is free software, licensed under the GNU General Public License v2.
+# See /LICENSE for more information.
+#
+
+include $(TOPDIR)/rules.mk
+
+PKG_NAME:=batctl
+PKG_VERSION:=2014.0.0
+PKG_RELEASE:=2
+PKG_MD5SUM:=b0bcf29fef80ddcc33769e13f5937d0a
+
+PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
+PKG_SOURCE_URL:=http://downloads.open-mesh.org/batman/releases/batman-adv-$(PKG_VERSION)
+
+include $(INCLUDE_DIR)/package.mk
+
+define Package/batctl
+  URL:=http://www.open-mesh.org/
+  SECTION:=net
+  CATEGORY:=Network
+  TITLE:=B.A.T.M.A.N. Advanced user space configuration tool batctl
+  MAINTAINER:=Marek Lindner <lindner_marek@yahoo.de>
+endef
+
+define Package/batctl/description
+B.A.T.M.A.N. advanced is a kernel module which allows to
+build layer 2 mesh networks. This package contains the
+version $(PKG_VERSION) of the user space configuration & 
+management tool batctl.
+endef
+
+TARGET_CFLAGS  += -ffunction-sections -fdata-sections
+TARGET_LDFLAGS += -Wl,--gc-sections
+
+# Link-time optimization allows to move parts of the optimization from the single
+# source file to the global source view. This is done by emitting the GIMPLE
+# representation in each object file and analyzing it again during the link step.
+
+TARGET_CFLAGS  += -flto
+TARGET_LDFLAGS += -fuse-linker-plugin
+
+MAKE_BATCTL_ENV += \
+        CPPFLAGS="$(TARGET_CPPFLAGS)" \
+        CFLAGS="$(TARGET_CFLAGS)" \
+        LDFLAGS="$(TARGET_LDFLAGS)"
+
+MAKE_BATCTL_ARGS += \
+        REVISION="" \
+        CC="$(TARGET_CC)" \
+        DESTDIR="$(PKG_INSTALL_DIR)" \
+        batctl install
+
+
+define Build/compile
+	$(MAKE_BATCTL_ENV) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_BATCTL_ARGS)
+endef
+
+define Package/batctl/install
+	$(INSTALL_DIR) $(1)/usr/sbin
+	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/sbin/
+endef
+
+$(eval $(call BuildPackage,batctl))
diff --git a/batman-adv/Config.in b/batman-adv/Config.in
index 1330525..160d3a3 100644
--- a/batman-adv/Config.in
+++ b/batman-adv/Config.in
@@ -18,12 +18,3 @@ config KMOD_BATMAN_ADV_NC
 	bool "enable network coding [requires promisc mode support]"
 	depends on PACKAGE_kmod-batman-adv
 	default n
-
-config KMOD_BATMAN_ADV_BATCTL
-	bool "enable batctl"
-	depends on PACKAGE_kmod-batman-adv
-	default y
-	help
-	  batctl is a more intuitive managment utility for B.A.T.M.A.N.-Advanced.
-	  It is an easier method for configuring batman-adv and
-	  provides some additional tools for debugging as well.
diff --git a/batman-adv/Makefile b/batman-adv/Makefile
index 4bfbe54..c5c7625 100644
--- a/batman-adv/Makefile
+++ b/batman-adv/Makefile
@@ -1,35 +1,29 @@
 #
-# Copyright (C) 2010 OpenWrt.org
+# Copyright (C) 2010-2014 OpenWrt.org
 #
 # This is free software, licensed under the GNU General Public License v2.
 # See /LICENSE for more information.
 #
-# $Id: Makefile 5624 2006-11-23 00:29:07Z nbd $
 
 include $(TOPDIR)/rules.mk
+include $(INCLUDE_DIR)/kernel.mk
 
 PKG_NAME:=batman-adv
-
 PKG_VERSION:=2014.0.0
-BATCTL_VERSION:=2014.0.0
-PKG_RELEASE:=1
-PKG_MD5SUM:=8d58ecaede17dc05aab1b549dc09fa7d
-BATCTL_MD5SUM:=b0bcf29fef80ddcc33769e13f5937d0a
+PKG_RELEASE:=2
 
 PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
 PKG_SOURCE_URL:=http://downloads.open-mesh.org/batman/releases/batman-adv-$(PKG_VERSION)
-
-PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_NAME)-$(PKG_VERSION)
-PKG_BATCTL_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/batctl-$(BATCTL_VERSION)
+PKG_MD5SUM:=8d58ecaede17dc05aab1b549dc09fa7d
+PKG_CAT:=zcat
 
 include $(INCLUDE_DIR)/package.mk
-include $(INCLUDE_DIR)/kernel.mk
 
 define KernelPackage/batman-adv
   URL:=http://www.open-mesh.org/
   MAINTAINER:=Marek Lindner <lindner_marek@yahoo.de>
   SUBMENU:=Network Support
-  DEPENDS:=+KMOD_BATMAN_ADV_BLA:kmod-lib-crc16 +kmod-crypto-core +kmod-crypto-crc32c +kmod-lib-crc32c +libc
+  DEPENDS:=+KMOD_BATMAN_ADV_BLA:kmod-lib-crc16 +kmod-crypto-core +kmod-crypto-crc32c +kmod-lib-crc32c +libc +batctl
   TITLE:=B.A.T.M.A.N. Adv
   FILES:=$(PKG_BUILD_DIR)/batman-adv.$(LINUX_KMOD_SUFFIX)
   AUTOLOAD:=$(call AutoLoad,50,batman-adv)
@@ -38,8 +32,7 @@ endef
 define KernelPackage/batman-adv/description
 B.A.T.M.A.N. advanced is a kernel module which allows to
 build layer 2 mesh networks. This package contains the
-version $(PKG_VERSION) of the kernel module plus its user space
-configuration & managerment tool batctl.
+version $(PKG_VERSION) of the kernel module.
 endef
 
 define KernelPackage/batman-adv/config
@@ -60,75 +53,16 @@ MAKE_BATMAN_ADV_ARGS += \
 	CONFIG_BATMAN_ADV_NC=$(if $(CONFIG_KMOD_BATMAN_ADV_NC),y,n) \
 	REVISION="" all
 
-# The linker can identify unused sections of a binary when each symbol is stored
-# in a separate section. This mostly removes unused linker sections and reduces 
-# the size by ~3% on mipsel.
-
-TARGET_CFLAGS  += -ffunction-sections -fdata-sections
-TARGET_LDFLAGS += -Wl,--gc-sections
-
-# Link-time optimization allows to move parts of the optimization from the single
-# source file to the global source view. This is done by emitting the GIMPLE
-# representation in each object file and analyzing it again during the link step.
-
-TARGET_CFLAGS  += -flto
-TARGET_LDFLAGS += -fuse-linker-plugin
-
-MAKE_BATCTL_ENV += \
-	CPPFLAGS="$(TARGET_CPPFLAGS)" \
-	CFLAGS="$(TARGET_CFLAGS)" \
-	LDFLAGS="$(TARGET_LDFLAGS)"
-
-MAKE_BATCTL_ARGS += \
-	REVISION="" \
-	CC="$(TARGET_CC)" \
-	DESTDIR="$(PKG_INSTALL_DIR)" \
-	batctl install
-
-ifneq ($(DEVELOPER)$(CONFIG_KMOD_BATMAN_ADV_BATCTL),)
-define Download/batctl
-  FILE:=batctl-$(BATCTL_VERSION).tar.gz
-  URL:=$(PKG_SOURCE_URL)
-  MD5SUM:=$(BATCTL_MD5SUM)
-endef
-$(eval $(call Download,batctl))
-
-BATCTL_EXTRACT = tar xzf "$(DL_DIR)/batctl-$(BATCTL_VERSION).tar.gz" -C "$(BUILD_DIR)/$(PKG_NAME)"
-BATCTL_PATCH = $(call Build/DoPatch,"$(PKG_BATCTL_BUILD_DIR)","$(PATCH_DIR)","*batctl*")
-BATCTL_BUILD = $(MAKE_BATCTL_ENV) $(MAKE) -C $(PKG_BATCTL_BUILD_DIR) $(MAKE_BATCTL_ARGS)
-BATCTL_INSTALL = $(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/local/sbin/batctl $(1)/usr/sbin/
-endif
-
-KPATCH ?= $(PATCH)
-define Build/DoPatch
-	@if [ -d "$(2)" ]; then \
-		if [ "$$$$(ls $(2) | grep -Ec $(3))" -gt 0 ]; then \
-			$(KPATCH) "$(1)" "$(2)" "$(3)"; \
-		fi; \
-	fi
-endef
-
-define Build/Patch
-	$(call Build/DoPatch,"$(PKG_BUILD_DIR)","$(PATCH_DIR)","*batman*")
-	$(BATCTL_EXTRACT)
-	$(BATCTL_PATCH)
-endef
-
 define Build/Prepare
 	$(call Build/Prepare/Default)
-	$(SED) '/#define _NET_BATMAN_ADV_MAIN_H_/a\#undef CONFIG_MODULE_STRIPPED' \
-		$(PKG_BUILD_DIR)/main.h
+	$(SED) '/#define _NET_BATMAN_ADV_MAIN_H_/a\#undef CONFIG_MODULE_STRIPPED' $(PKG_BUILD_DIR)/main.h
 endef
 
 
 define Build/Compile
 	$(MAKE) -C "$(PKG_BUILD_DIR)" $(MAKE_BATMAN_ADV_ARGS)
-	$(BATCTL_BUILD)
 endef
 
-define Build/Clean
-        rm -rf $(BUILD_DIR)/$(PKG_NAME)/
-endef
 
 define KernelPackage/batman-adv/install
 	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/hotplug.d/net $(1)/etc/hotplug.d/iface $(1)/lib/batman-adv $(1)/usr/sbin $(1)/lib/netifd/proto
@@ -136,7 +70,7 @@ define KernelPackage/batman-adv/install
 	$(INSTALL_DATA) ./files/lib/batman-adv/config.sh $(1)/lib/batman-adv
 	$(INSTALL_BIN) ./files/etc/hotplug.d/net/99-batman-adv $(1)/etc/hotplug.d/net
 	$(INSTALL_BIN) ./files/lib/netifd/proto/batadv.sh $(1)/lib/netifd/proto
-	$(BATCTL_INSTALL)
 endef
 
+
 $(eval $(call KernelPackage,batman-adv))
diff --git a/batman-adv/patches/0011-batman-adv-memory-leak-fix.patch b/batman-adv/patches/0011-batman-adv-memory-leak-fix.patch
index c991d5d..d8fe56e 100644
--- a/batman-adv/patches/0011-batman-adv-memory-leak-fix.patch
+++ b/batman-adv/patches/0011-batman-adv-memory-leak-fix.patch
@@ -19,11 +19,11 @@ Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
  routing.c | 2 ++
  1 file changed, 2 insertions(+)
 
-diff --git a/routing.c b/routing.c
-index f7579d0..71bf698 100644
---- a/routing.c
-+++ b/routing.c
-@@ -1063,6 +1063,8 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
+Index: batman-adv-2014.0.0/routing.c
+===================================================================
+--- batman-adv-2014.0.0.orig/routing.c
++++ batman-adv-2014.0.0/routing.c
+@@ -1063,6 +1063,8 @@ int batadv_recv_unicast_tvlv(struct sk_b
  
  	if (ret != NET_RX_SUCCESS)
  		ret = batadv_route_unicast_packet(skb, recv_if);
@@ -32,8 +32,3 @@ index f7579d0..71bf698 100644
  
  	return ret;
  }
--- 
-1.8.5.3
-
-
-
-- 
1.8.1.2


-- 
Russell Senior, President
russell@personaltelco.net
