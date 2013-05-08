Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  8 May 2013 09:21:26 +0200
Message-Id: <1367997686-12331-2-git-send-email-sven@narfation.org>
In-Reply-To: <1367997686-12331-1-git-send-email-sven@narfation.org>
References: <1367997686-12331-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [Bonus-PATCH 11/9] batman-adv-devel: Remove unused
	parameters from MAKE_BATCTL_ARGS
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

The NODEBUG, UNAME and STRIP parameter aren't used in batctl's Makefile.
Removing them should be safe.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv-devel/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/batman-adv-devel/Makefile b/batman-adv-devel/Makefile
index fb2c24a..4689181 100644
--- a/batman-adv-devel/Makefile
+++ b/batman-adv-devel/Makefile
@@ -67,10 +67,7 @@ MAKE_BATMAN_ADV_ARGS += \
 MAKE_BATCTL_ARGS += \
 	REVISION="$(PKG_BATCTL_SHORTREV)" \
 	CC="$(TARGET_CC)" \
-	NODEBUG=1 \
-	UNAME="Linux" \
 	DESTDIR="$(PKG_INSTALL_DIR)" \
-	STRIP="/bin/true" \
 	batctl install
 
 TARGET_CFLAGS  += -ffunction-sections -fdata-sections -flto
-- 
1.8.2.1

