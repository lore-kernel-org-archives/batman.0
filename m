Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 14:28:07 +0200
Message-Id: <1305980898-30494-3-git-send-email-sven@narfation.org>
In-Reply-To: <1305980898-30494-1-git-send-email-sven@narfation.org>
References: <1305980898-30494-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 03/14] batctl: Remove unused Makefile
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
 Makefile |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 61a81fb..cf0b5c5 100644
--- a/Makefile
+++ b/Makefile
@@ -32,10 +32,6 @@ LDFLAGS += -lm
 
 SBINDIR = $(INSTALL_PREFIX)/usr/sbin
 
-LOG_BRANCH = trunk/batctl
-
-SRC_FILES = "\(\.c\)\|\(\.h\)\|\(Makefile\)\|\(INSTALL\)\|\(LIESMICH\)\|\(README\)\|\(THANKS\)\|\(TRASH\)\|\(Doxyfile\)\|\(./posix\)\|\(./linux\)\|\(./bsd\)\|\(./man\)\|\(./doc\)"
-
 EXTRA_MODULES_C := bisect.c
 EXTRA_MODULES_H := bisect.h
 
@@ -43,9 +39,7 @@ SRC_C = main.c bat-hosts.c functions.c sys.c debug.c ping.c traceroute.c tcpdump
 SRC_H = main.h bat-hosts.h functions.h sys.h debug.h ping.h traceroute.h tcpdump.h list-batman.h hash.h allocate.h vis.h debugfs.h $(EXTRA_MODULES_H)
 SRC_O = $(SRC_C:.c=.o)
 
-PACKAGE_NAME = batctl
 BINARY_NAME = batctl
-SOURCE_VERSION_HEADER = main.h
 
 REVISION= $(shell	if [ -d .git ]; then \
 				echo $$(git describe --always --dirty 2> /dev/null || echo "[unknown]"); \
-- 
1.7.5.1

