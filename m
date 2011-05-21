Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 15:10:31 +0200
Message-Id: <1305983442-1607-3-git-send-email-sven@narfation.org>
In-Reply-To: <1305983442-1607-1-git-send-email-sven@narfation.org>
References: <1305983442-1607-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 03/14] batmand: Remove unused Makefile
	variables
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
 - batmand: Fix FTBFS on second build attempt
 - batmand: Remove obsolete creation of source packages
 - batmand: Remove subversion/svk revision information
 - batmand: Use nproc to get number of available processors

 Makefile |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index f8864d0..ce94472 100644
--- a/Makefile
+++ b/Makefile
@@ -60,17 +60,11 @@ ifeq ($(UNAME),OpenBSD)
 OS_C =		$(BSD_C) $(POSIX_C)
 endif
 
-LOG_BRANCH =	trunk/batman
-
-SRC_FILES = "\(\.c\)\|\(\.h\)\|\(Makefile\)\|\(INSTALL\)\|\(LIESMICH\)\|\(README\)\|\(THANKS\)\|\(TRASH\)\|\(Doxyfile\)\|\(./posix\)\|\(./linux\)\|\(./bsd\)\|\(./man\)\|\(./doc\)"
-
 SRC_C= batman.c originator.c schedule.c list-batman.c allocate.c bitarray.c hash.c profile.c ring_buffer.c hna.c $(OS_C)
 SRC_H= batman.h originator.h schedule.h list-batman.h os.h allocate.h bitarray.h hash.h profile.h packet.h types.h ring_buffer.h hna.h
 SRC_O= $(SRC_C:.c=.o)
 
-PACKAGE_NAME =	batmand
 BINARY_NAME =	batmand
-SOURCE_VERSION_HEADER = batman.h
 
 REVISION= $(shell      if [ -d .git ]; then \
                                echo $$(git describe --always --dirty 2> /dev/null || echo "[unknown]"); \
-- 
1.7.5.1

