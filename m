Return-Path: <russell@personaltelco.net>
References: <86r4775d8s.fsf@coulee.tdb.com> <86mwhv5cy8.fsf@coulee.tdb.com>
From: Russell Senior <russell@personaltelco.net>
Date: Thu, 13 Feb 2014 06:14:21 -0800
In-Reply-To: <86mwhv5cy8.fsf@coulee.tdb.com> (Russell Senior's message of
 "Thu\, 13 Feb 2014 06\:01\:19 -0800")
Message-ID: <86iosj5cci.fsf_-_@coulee.tdb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [B.A.T.M.A.N.] [PATCH 3/4] openwrt routing feed: batman-adv: remove
	apparently unused variables from make arguments
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


Removes what appear to be unused and/or unnecessary environment
variables passed to make.

Signed-off-by: Russell Senior <russell@personaltelco.net>
---
 batman-adv/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/batman-adv/Makefile b/batman-adv/Makefile
index c5c7625..1344198 100644
--- a/batman-adv/Makefile
+++ b/batman-adv/Makefile
@@ -40,13 +40,8 @@ define KernelPackage/batman-adv/config
 endef
 
 MAKE_BATMAN_ADV_ARGS += \
-	CROSS_COMPILE="$(TARGET_CROSS)" \
 	KERNELPATH="$(LINUX_DIR)" \
-	ARCH="$(LINUX_KARCH)" \
-	PATH="$(TARGET_PATH)" \
-	SUBDIRS="$(PKG_BUILD_DIR)" \
 	PWD="$(PKG_BUILD_DIR)" \
-	LINUX_VERSION="$(LINUX_VERSION)" \
 	CONFIG_BATMAN_ADV_DEBUG=$(if $(CONFIG_KMOD_BATMAN_ADV_DEBUG_LOG),y,n) \
 	CONFIG_BATMAN_ADV_BLA=$(if $(CONFIG_KMOD_BATMAN_ADV_BLA),y,n) \
 	CONFIG_BATMAN_ADV_DAT=$(if $(CONFIG_KMOD_BATMAN_ADV_DAT),y,n) \
-- 
1.8.1.2



-- 
Russell Senior, President
russell@personaltelco.net
