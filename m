Return-Path: <sven@open-mesh.com>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Thu, 21 Jan 2016 16:16:48 +0100
Message-ID: <1755169.cZlx8PuODy@bentobox>
In-Reply-To: <56A0EF66.9090003@openwrt.org>
References: <8047297.0qIFjkW2bL@voltaire> <132128022.hJazYISVSs@bentobox>
 <56A0EF66.9090003@openwrt.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3700177.3Tqf3Fob9g"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] OpenWrt cfg80211.h station_info incompatibility
	with kernel+mac80211 [was: B.A.T.M.A.N. V leaves the nest v2]
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Felix Fietkau <nbd@openwrt.org>
Cc: openwrt-devel@lists.openwrt.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

This is a multi-part message in MIME format.

--nextPart3700177.3Tqf3Fob9g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 21 January 2016 15:47:02 Felix Fietkau wrote:
[...]
> > Hm, didn't work out so well. It basically explodes right away because 
> > possible_net_t, possible_read_pnet, possible_write_pnet is not defined on 
> > v3.18 when not using the mac80211 backporting headers. And when usign the 
> > backporting headers then it will explode because it conflicts with batman-
> > adv's own backporting stuff. And without the batman-adv's backporting headers 
> > it will also not compile due to missing backporting hacks.
> I think in the short term it would be a good idea to identify what's
> missing in the mac80211 backport support and make patches for it.
> You should also rebase those on top of backports.git and submit them
> upstream.

Yes, this was already started after/during the linux plumbers conf 2014 [1]. But
it died the horrible death of being ignored and neglected - especially after the
multicast optimization was integrated.

Someone who want to use the mac80211 stuff with the batman-adv package can use
the attached patch as starting point.

Kind regards,
	Sven

[1] https://github.com/ordex/batman-adv-backport/commits/TODO-compat

--nextPart3700177.3Tqf3Fob9g
Content-Disposition: attachment; filename="0001-batman-adv-Use-the-mac80211-compat-layer.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-batman-adv-Use-the-mac80211-compat-layer.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 21 Jan 2016 16:04:20 +0100
Subject: [PATCH] batman-adv: Use the mac80211 compat layer
---
 batman-adv/Makefile | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/batman-adv/Makefile b/batman-adv/Makefile
index 1eb6bbe..0b2637d 100644
--- a/batman-adv/Makefile
+++ b/batman-adv/Makefile
@@ -27,7 +27,7 @@ define KernelPackage/batman-adv
   URL:=https://www.open-mesh.org/
   MAINTAINER:=Marek Lindner <mareklindner@neomailbox.ch>
   SUBMENU:=Network Support
-  DEPENDS:=+KMOD_BATMAN_ADV_BLA:kmod-lib-crc16 +kmod-crypto-core +kmod-crypto-crc32c +kmod-lib-crc32c
+  DEPENDS:=+KMOD_BATMAN_ADV_BLA:kmod-lib-crc16 +kmod-crypto-core +kmod-crypto-crc32c +kmod-lib-crc32c +kmod-cfg80211
   TITLE:=B.A.T.M.A.N. Adv
   FILES:=$(PKG_BUILD_DIR)/net/batman-adv/batman-adv.$(LINUX_KMOD_SUFFIX)
   AUTOLOAD:=$(call AutoLoad,50,batman-adv)
@@ -47,20 +47,37 @@ define Package/kmod-batman-adv/conffiles
 /etc/config/batman-adv
 endef
 
-MAKE_BATMAN_ADV_ARGS += \
-	CROSS_COMPILE="$(TARGET_CROSS)" \
-	KERNELPATH="$(LINUX_DIR)" \
-	ARCH="$(LINUX_KARCH)" \
-	PATH="$(TARGET_PATH)" \
-	SUBDIRS="$(PKG_BUILD_DIR)" \
-	PWD="$(PKG_BUILD_DIR)" \
-	LINUX_VERSION="$(LINUX_VERSION)" \
+PKG_EXTRA_KCONFIG:= \
+	CONFIG_BATMAN_ADV=m \
 	CONFIG_BATMAN_ADV_DEBUG=$(if $(CONFIG_KMOD_BATMAN_ADV_DEBUG_LOG),y,n) \
 	CONFIG_BATMAN_ADV_BLA=$(if $(CONFIG_KMOD_BATMAN_ADV_BLA),y,n) \
 	CONFIG_BATMAN_ADV_DAT=$(if $(CONFIG_KMOD_BATMAN_ADV_DAT),y,n) \
 	CONFIG_BATMAN_ADV_MCAST=$(if $(CONFIG_KMOD_BATMAN_ADV_MCAST),y,n) \
 	CONFIG_BATMAN_ADV_NC=$(if $(CONFIG_KMOD_BATMAN_ADV_NC),y,n) \
-	REVISION="" all
+	CONFIG_BATMAN_ADV_BATMAN_V=$(if $(CONFIG_KMOD_BATMAN_ADV_BATMAN_V),y,n) \
+
+PKG_EXTRA_CFLAGS:= \
+	$(patsubst CONFIG_%, -DCONFIG_%=1, $(patsubst %=m,%,$(filter %=m,$(PKG_EXTRA_KCONFIG)))) \
+	$(patsubst CONFIG_%, -DCONFIG_%=1, $(patsubst %=y,%,$(filter %=y,$(PKG_EXTRA_KCONFIG)))) \
+
+NOSTDINC_FLAGS = \
+	-I$(PKG_BUILD_DIR)/net/batman-adv \
+	-I$(STAGING_DIR)/usr/include/mac80211-backport/uapi \
+	-I$(STAGING_DIR)/usr/include/mac80211-backport \
+	-I$(STAGING_DIR)/usr/include/mac80211/uapi \
+	-I$(STAGING_DIR)/usr/include/mac80211 \
+	-include backport/backport.h
+
+define Build/Compile
+	+$(MAKE) $(PKG_JOBS) -C "$(LINUX_DIR)" \
+		ARCH="$(LINUX_KARCH)" \
+		CROSS_COMPILE="$(TARGET_CROSS)" \
+		SUBDIRS="$(PKG_BUILD_DIR)/net/batman-adv" \
+		$(PKG_EXTRA_KCONFIG) \
+		EXTRA_CFLAGS="$(PKG_EXTRA_CFLAGS)" \
+		NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" \
+		modules
+endef
 
 define Build/Prepare
 	$(call Build/Prepare/Default)
@@ -68,10 +85,6 @@ define Build/Prepare
 		$(PKG_BUILD_DIR)/net/batman-adv/main.h
 endef
 
-define Build/Compile
-	$(MAKE) -C "$(PKG_BUILD_DIR)" $(MAKE_BATMAN_ADV_ARGS)
-endef
-
 define Build/Clean
         rm -rf $(BUILD_DIR)/$(PKG_NAME)/
 endef

--nextPart3700177.3Tqf3Fob9g--

