Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  7 May 2013 14:51:06 +0200
Message-Id: <1367931069-7177-7-git-send-email-sven@narfation.org>
In-Reply-To: <1367931069-7177-1-git-send-email-sven@narfation.org>
References: <1367931069-7177-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/9] alfred: Enable Link-time optimization
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

Link-time optimization allows to move parts of the optimization from the single
source file to the global source view. This is done by emitting the GIMPLE
representation in each object file and analyzing it again during the link step.

This reduces the binary size by around 10% on mipsel (this includes parts which
were also removed by garbage collection).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/alfred/Makefile b/alfred/Makefile
index ab19325..2656d1c 100644
--- a/alfred/Makefile
+++ b/alfred/Makefile
@@ -44,8 +44,8 @@ endef
 MAKE_ALFRED_FLAGS=\
 	CONFIG_ALFRED_VIS=$(if $(CONFIG_PACKAGE_ALFRED_VIS),y,n)
 
-TARGET_CFLAGS  += -ffunction-sections -fdata-sections
-TARGET_LDFLAGS += -Wl,--gc-sections
+TARGET_CFLAGS  += -ffunction-sections -fdata-sections -flto
+TARGET_LDFLAGS += -Wl,--gc-sections -fuse-linker-plugin
 
 define Build/Compile
 	CFLAGS="$(TARGET_CPPFLAGS) $(TARGET_CFLAGS)" \
-- 
1.8.2.1

