Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Fri, 24 Apr 2015 16:19:21 +0200
Message-Id: <1429885161-8762-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Fix dependency to IPv6
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
Cc: Sven Eckelmann <sven@open-mesh.com>

alfred always requires IPv6 support in the kernel and not only when
"Enable IPv6 support in packages" is enabled.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 alfred/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/alfred/Makefile b/alfred/Makefile
index dade218..8f6855b 100644
--- a/alfred/Makefile
+++ b/alfred/Makefile
@@ -28,7 +28,7 @@ define Package/alfred
   SECTION:=net
   CATEGORY:=Network
   TITLE:=A.L.F.R.E.D. - Almighty Lightweight Fact Remote Exchange Daemon
-  DEPENDS:= +libc +IPV6:kmod-ipv6 +librt \
+  DEPENDS:= +libc +kmod-ipv6 +librt \
 	  +ALFRED_NEEDS_lua:lua \
 	  +ALFRED_NEEDS_libgps:libgps
 endef
-- 
2.1.4

