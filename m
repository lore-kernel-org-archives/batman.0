Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 15:45:07 +0200
Message-Id: <1305985517-3763-3-git-send-email-sven@narfation.org>
In-Reply-To: <1305985517-3763-1-git-send-email-sven@narfation.org>
References: <1305985517-3763-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 03/13] vis: Remove unused Makefile variables
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch depends on other patches submitted earlier:
 - vis: Remove obsolete creation of source packages
 - vis: Remove subversion/svk revision information

 Makefile |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index b3a7963..f7bcef9 100644
--- a/Makefile
+++ b/Makefile
@@ -32,17 +32,11 @@ LDFLAGS +=	-lpthread
 
 SBINDIR =	$(INSTALL_PREFIX)/usr/sbin
 
-LOG_BRANCH= trunk/vis
-
-SRC_FILES= "\(\.c\)\|\(\.h\)\|\(Makefile\)\|\(INSTALL\)\|\(LIESMICH\)\|\(README\)\|\(THANKS\)\|\(TRASH\)\|\(Doxyfile\)\|\(./posix\)\|\(./linux\)\|\(./bsd\)\|\(./man\)\|\(./doc\)"
-
 SRC_C= allocate.c hash.c list-batman.c vis.c udp_server.c
 SRC_H= allocate.h hash.h list-batman.h vis.h vis-types.h
 SRC_O= $(SRC_C:.c=.o)
 
-PACKAGE_NAME= vis
 BINARY_NAME= vis
-SOURCE_VERSION_HEADER= vis.h
 
 REVISION= $(shell      if [ -d .git ]; then \
                                echo $$(git describe --always --dirty 2> /dev/null || echo "[unknown]"); \
-- 
1.7.5.1

