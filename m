Return-Path: <bittorf@bluebottle.com>
Date: Wed, 15 Jan 2014 15:03:33 +0100
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20140115140332.GA20268@medion.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Makefile: add depends for
 'crc16' which is still needed but removed accidentally
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

batman-adv: Makefile: add depends for 'crc16' which is still needed/used in BLA-framework
(Bridge Loop Avoidance) in bridge_loop_avoidance.c. Thanks to Antonio 'ordex' Quartulli for
confirmation.

Signed-off-by: Bastian Bittorf <bittorf@bluebottle.com>
---
 batman-adv/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/batman-adv/Makefile b/batman-adv/Makefile
index 0e0945b..2504682 100644
--- a/batman-adv/Makefile
+++ b/batman-adv/Makefile
@@ -29,7 +29,7 @@ define KernelPackage/batman-adv
   URL:=http://www.open-mesh.org/
   MAINTAINER:=Marek Lindner <lindner_marek@yahoo.de>
   SUBMENU:=Network Support
-  DEPENDS:=+kmod-crypto-core +kmod-crypto-crc32c +kmod-lib-crc32c +libc
+  DEPENDS:=+kmod-lib-crc16 +kmod-crypto-core +kmod-crypto-crc32c +kmod-lib-crc32c +libc
   TITLE:=B.A.T.M.A.N. Adv
   FILES:=$(PKG_BUILD_DIR)/batman-adv.$(LINUX_KMOD_SUFFIX)
   AUTOLOAD:=$(call AutoLoad,50,batman-adv)
-- 
1.8.1.2

