Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Dec 2015 16:16:16 +0100
Message-Id: <1449414976-21770-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] openwrt-feed-batman-adv: Switch to HTTPS
	version of links
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

open-mesh.org and its subdomains can only be accessed via HTTPS. HTTP-only
requests are currently redirected automatically to HTTPS but references
to it should be only https.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batctl-devel/Makefile     | 4 ++--
 batman-adv-devel/Makefile | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/batctl-devel/Makefile b/batctl-devel/Makefile
index 05e2d41..1c93c0b 100644
--- a/batctl-devel/Makefile
+++ b/batctl-devel/Makefile
@@ -14,7 +14,7 @@ PKG_BATCTL_SHORTREV:=$(shell echo $(PKG_VERSION) | cut -c1-7)
 PKG_BATCTL_FNAME:=batctl-devel-$(PKG_BATCTL_SHORTREV).tar.gz
 PKG_BATCTL_DIR:=batctl-$(PKG_BATCTL_SHORTREV)
 
-PKG_SOURCE_URL:=http://git.open-mesh.org/snapshot/
+PKG_SOURCE_URL:=https://git.open-mesh.org/snapshot/
 PKG_SOURCE:=$(PKG_BATCTL_FNAME)
 
 PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_BATCTL_DIR)
@@ -22,7 +22,7 @@ PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_BATCTL_DIR)
 include $(INCLUDE_DIR)/package.mk
 
 define Package/batctl-devel
-  URL:=http://www.open-mesh.org/
+  URL:=https://www.open-mesh.org/
   SECTION:=net
   CATEGORY:=Network
   DEPENDS:=+kmod-batman-adv-devel +libnl-tiny +libc
diff --git a/batman-adv-devel/Makefile b/batman-adv-devel/Makefile
index 9971e22..0d63ab3 100644
--- a/batman-adv-devel/Makefile
+++ b/batman-adv-devel/Makefile
@@ -15,7 +15,7 @@ PKG_BATMAN_SHORTREV:=$(shell echo $(PKG_VERSION) | cut -c1-7)
 PKG_BATMAN_FNAME:=batman-adv-devel-$(PKG_BATMAN_SHORTREV).tar.gz
 PKG_BATMAN_DIR:=batman-adv-$(PKG_BATMAN_SHORTREV)
 
-PKG_SOURCE_URL:=http://git.open-mesh.org/snapshot/
+PKG_SOURCE_URL:=https://git.open-mesh.org/snapshot/
 PKG_SOURCE:=$(PKG_BATMAN_FNAME)
 
 PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_BATMAN_DIR)
@@ -24,7 +24,7 @@ include $(INCLUDE_DIR)/package.mk
 include $(INCLUDE_DIR)/kernel.mk
 
 define KernelPackage/batman-adv-devel
-  URL:=http://www.open-mesh.org/
+  URL:=https://www.open-mesh.org/
   MAINTAINER:=Marek Lindner <mareklindner@neomailbox.ch>
   SUBMENU:=Network Support
   DEPENDS:=+KMOD_BATMAN_ADV_DEVEL_BLA:kmod-lib-crc16 +kmod-crypto-core +kmod-crypto-crc32c +kmod-lib-crc32c
-- 
2.6.2

