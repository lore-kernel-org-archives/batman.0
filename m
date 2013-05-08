Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  8 May 2013 09:21:25 +0200
Message-Id: <1367997686-12331-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [Bonus-PATCH 10/9] batman-adv-devel: Don't overwrite
	batctl's CFLAGS
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
Cc: Sven Eckelmann <sven@narfation.org>

The batctl makefile has CFLAGS which change the behavior of the compiler. This
includes important things like the C-dialect used or whether the compiler can
ignore aliasing problems during the optimization step.

The OpenWRT build environment should not overwrite these settings without a
good reason. Most of these reasons can probably directly be fixed upstream.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv-devel/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/batman-adv-devel/Makefile b/batman-adv-devel/Makefile
index cad95c6..fb2c24a 100644
--- a/batman-adv-devel/Makefile
+++ b/batman-adv-devel/Makefile
@@ -65,9 +65,6 @@ MAKE_BATMAN_ADV_ARGS += \
 	REVISION="$(PKG_BATMAN_SHORTREV)" all
 
 MAKE_BATCTL_ARGS += \
-	CFLAGS="$(TARGET_CFLAGS)" \
-	CCFLAGS="$(TARGET_CFLAGS)" \
-	OFLAGS="$(TARGET_CFLAGS)" \
 	REVISION="$(PKG_BATCTL_SHORTREV)" \
 	CC="$(TARGET_CC)" \
 	NODEBUG=1 \
-- 
1.8.2.1

