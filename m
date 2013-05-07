Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  7 May 2013 14:51:05 +0200
Message-Id: <1367931069-7177-6-git-send-email-sven@narfation.org>
In-Reply-To: <1367931069-7177-1-git-send-email-sven@narfation.org>
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/9] alfred: Use section garbage collection
	to reduce binary size
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

The linker can identify unused sections of a binary when each symbol is stored
in a separate section. This mostly removes the unused debugfs function and
reduces the size by ~5% on mipsel.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/alfred/Makefile b/alfred/Makefile
index 4578c3b..ab19325 100644
--- a/alfred/Makefile
+++ b/alfred/Makefile
@@ -44,6 +44,9 @@ endef
 MAKE_ALFRED_FLAGS=\
 	CONFIG_ALFRED_VIS=$(if $(CONFIG_PACKAGE_ALFRED_VIS),y,n)
 
+TARGET_CFLAGS  += -ffunction-sections -fdata-sections
+TARGET_LDFLAGS += -Wl,--gc-sections
+
 define Build/Compile
 	CFLAGS="$(TARGET_CPPFLAGS) $(TARGET_CFLAGS)" \
 	LDFLAGS="$(TARGET_LDFLAGS)" \
-- 
1.8.2.1

