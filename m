Return-Path: <martin@hundeboll.net>
Message-ID: <50AE8BE8.4010207@hundeboll.net>
Date: Thu, 22 Nov 2012 21:32:40 +0100
From: =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <CAMVTf1ieWEkLOjcK0w2prCvFRmR4W+BYMett7ySrTQP1Yt2m_Q@mail.gmail.com>
 <1587719.gZG6lsm63o@bentobox>
In-Reply-To: <1587719.gZG6lsm63o@bentobox>
Content-Type: multipart/mixed; boundary="------------060703050300010805000304"
Subject: Re: [B.A.T.M.A.N.] Compile batman-adv code
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is a multi-part message in MIME format.
--------------060703050300010805000304
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

On 2012-11-22 19:00, Sven Eckelmann wrote:
> You should just clean the batman-adv part of openwrt after each change in=
stead
> of compiling everything again. You can for example modify the prepare par=
t of
> the Makefile script of the batman-adv openwrt package to copy the
> .c/.h/.sh/Makefile* from your development folder. At least Martin did thi=
s (or
> at least something similar).

Attached is my package/feeds/batman/batman-adv-devel/Makefile :) Maybe=20
it can help a little bit... Look for absolute paths to=20
~/projects/batman-adv/ and ~/projects/batctl

--=20
Kind Regards
Martin Hundeb=F8ll
Frederiks All=E9 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net

--------------060703050300010805000304
Content-Type: text/plain; charset=UTF-8;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Makefile"

#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id: Makefile 5624 2006-11-23 00:29:07Z nbd $

include $(TOPDIR)/rules.mk

PKG_NAME:=batman-adv-devel

PKG_BATMAN_REV:=c3c748339f605c034bac3317a93e10fc0f8d1d0a
PKG_BATCTL_REV:=3e88396b24c65bc438be54e80f930a728ab5c65b

PKG_BATMAN_BRANCH:=$(subst ",,$(CONFIG_KMOD_BATMAN_ADV_DEVEL_BRANCH_NAME))
PKG_BATMAN_SHORTREV:=$(shell echo $(PKG_BATMAN_REV) | cut -c1-7)
PKG_BATMAN_FNAME:=batman-adv-devel-$(PKG_BATMAN_BRANCH)-$(PKG_BATMAN_SHORTREV).tar.gz
PKG_BATMAN_DIR:=batman-adv-$(PKG_BATMAN_SHORTREV)
PKG_BATCTL_SHORTREV:=$(shell echo $(PKG_BATCTL_REV) | cut -c1-7)
PKG_BATCTL_FNAME:=batctl-devel-$(PKG_BATCTL_SHORTREV).tar.gz
PKG_BATCTL_DIR:=batctl-$(PKG_BATCTL_SHORTREV)

PKG_SOURCE_URL:=http://git.open-mesh.org/snapshot/
PKG_SOURCE:=$(PKG_BATMAN_FNAME)

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_BATMAN_DIR)
PKG_BATCTL_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_BATCTL_DIR)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

define KernelPackage/batman-adv-devel
  URL:=http://www.open-mesh.org/
  MAINTAINER:=Marek Lindner <lindner_marek@yahoo.de>
  SUBMENU:=Network Support
  DEPENDS:=+kmod-lib-crc16 +libc
  TITLE:=B.A.T.M.A.N. Adv devel
  FILES:=$(PKG_BUILD_DIR)/batman-adv.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,50,batman-adv)
endef

define KernelPackage/batman-adv-devel/description
B.A.T.M.A.N. advanced is a kernel module which allows to
build layer 2 mesh networks. This package builds the latest
development version ($(PKG_BATMAN_SHORTREV)) of the kernel module plus 
its user space configuration & managerment tool batctl.
endef

define KernelPackage/batman-adv-devel/config
	source "$(SOURCE)/Config.in"
endef

MAKE_BATMAN_ADV_ARGS += \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	KERNELPATH="$(LINUX_DIR)" \
	ARCH="$(LINUX_KARCH)" \
	PATH="$(TARGET_PATH)" \
	SUBDIRS="$(PKG_BUILD_DIR)" \
	PWD="$(PKG_BUILD_DIR)" \
	LINUX_VERSION="$(LINUX_VERSION)" \
	CONFIG_BATMAN_ADV_DEBUG=$(if $(CONFIG_KMOD_BATMAN_ADV_DEVEL_DEBUG_LOG),y,n) \
	CONFIG_BATMAN_ADV_BLA=$(if $(CONFIG_KMOD_BATMAN_ADV_DEVEL_BLA),y,n) \
	REVISION="$(PKG_BATMAN_BRANCH)-$(PKG_BATMAN_SHORTREV)" all

MAKE_BATCTL_ARGS += \
	CFLAGS="$(TARGET_CFLAGS)" \
	CCFLAGS="$(TARGET_CFLAGS)" \
	OFLAGS="$(TARGET_CFLAGS)" \
	REVISION="$(PKG_BATCTL_SHORTREV)" \
	CC="$(TARGET_CC)" \
	NODEBUG=1 \
	UNAME="Linux" \
	DESTDIR="$(PKG_INSTALL_DIR)" \
	STRIP="/bin/true" \
	batctl install

ifneq ($(DEVELOPER)$(CONFIG_KMOD_BATMAN_ADV_DEVEL_BATCTL),)
define Download/batctl
  FILE:=$(PKG_BATCTL_FNAME)
  URL:=$(PKG_SOURCE_URL)
endef
$(eval $(call Download,batctl))

BATCTL_EXTRACT = tar xzf "$(DL_DIR)/$(PKG_BATCTL_FNAME)" -C "$(BUILD_DIR)/$(PKG_NAME)"
BATCTL_PATCH = $(call Build/DoPatch,"$(PKG_BATCTL_BUILD_DIR)","$(PATCH_DIR)","*batctl*")
BATCTL_BUILD = $(MAKE) -C $(PKG_BATCTL_BUILD_DIR) $(MAKE_BATCTL_ARGS)
BATCTL_INSTALL = $(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/local/sbin/batctl $(1)/usr/sbin/
endif

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	mkdir -p $(PKG_BATCTL_BUILD_DIR)
	$(CP) ~/projects/batman-adv/* $(PKG_BUILD_DIR)/
	$(CP) ~/projects/batctl/* $(PKG_BATCTL_BUILD_DIR)/
	$(MAKE) -C "$(PKG_BATCTL_BUILD_DIR)" clean
endef


KPATCH ?= $(PATCH)
define Build/DoPatch
	@if [ -d "$(2)" ]; then \
		if [ "$$$$(ls $(2) | grep -Ec $(3))" -gt 0 ]; then \
			$(KPATCH) "$(1)" "$(2)" "$(3)"; \
		fi; \
	fi
endef

define Build/Patch
	$(call Build/DoPatch,"$(PKG_BUILD_DIR)","$(PATCH_DIR)","*batman*")
	$(BATCTL_EXTRACT)
	$(BATCTL_PATCH)
endef

define Build/Compile
	$(MAKE) -C "$(PKG_BUILD_DIR)" $(MAKE_BATMAN_ADV_ARGS) -j2
	$(BATCTL_BUILD)
endef

define Build/Clean
        rm -rf $(BUILD_DIR)/$(PKG_NAME)/
endef

define KernelPackage/batman-adv-devel/install
	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/hotplug.d/net $(1)/lib/batman-adv $(1)/usr/sbin
	$(INSTALL_DATA) ./files/etc/config/batman-adv $(1)/etc/config
	$(INSTALL_DATA) ./files/lib/batman-adv/config.sh $(1)/lib/batman-adv
	$(INSTALL_BIN) ./files/etc/hotplug.d/net/99-batman-adv $(1)/etc/hotplug.d/net
	$(INSTALL_BIN) ./files/usr/sbin/batman-adv $(1)/usr/sbin
	$(BATCTL_INSTALL)
endef

$(eval $(call KernelPackage,batman-adv-devel))

--------------060703050300010805000304--
