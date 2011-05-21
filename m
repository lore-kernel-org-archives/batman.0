Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 15:45:13 +0200
Message-Id: <1305985517-3763-9-git-send-email-sven@narfation.org>
In-Reply-To: <1305985517-3763-1-git-send-email-sven@narfation.org>
References: <1305985517-3763-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 09/13] vis: Reorder Makefile for better
	readability
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

 Makefile |   39 ++++++++++++++++++++++++---------------
 1 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 75d59cc..da966ac 100755
--- a/Makefile
+++ b/Makefile
@@ -18,6 +18,16 @@
 # 02110-1301, USA
 #
 
+# vis build
+BINARY_NAME= vis
+OBJ = allocate.o hash.o list-batman.o vis.o udp_server.o
+
+# vis flags and options
+CFLAGS +=	-pedantic -Wall -W -std=gnu99
+EXTRA_CFLAGS =	-DDEBUG_MALLOC -DMEMORY_USAGE -DREVISION_VERSION=$(REVISION_VERSION)
+LDFLAGS +=	-lpthread
+
+# disable verbose output
 ifneq ($(findstring $(MAKEFLAGS),s),s)
 ifndef V
 	Q_CC = @echo '   ' CC $@;
@@ -27,31 +37,26 @@ ifndef V
 endif
 endif
 
+# standard build tools
 CC ?=		gcc
-CFLAGS +=	-pedantic -Wall -W -std=gnu99
-EXTRA_CFLAGS =	-DDEBUG_MALLOC -DMEMORY_USAGE -DREVISION_VERSION=$(REVISION_VERSION)
-LDFLAGS +=	-lpthread
 
+# standard install paths
 SBINDIR =	$(INSTALL_PREFIX)/usr/sbin
 
-OBJ = allocate.o hash.o list-batman.o vis.o udp_server.o
-DEP = $(OBJ:.o=.d)
-
-BINARY_NAME= vis
-
-REVISION= $(shell      if [ -d .git ]; then \
-                               echo $$(git describe --always --dirty 2> /dev/null || echo "[unknown]"); \
-                        fi)
+# try to generate revision
+REVISION = $(shell if [ -d .git ]; then echo $$(git describe --always --dirty 2> /dev/null || echo "[unknown]"); fi)
 REVISION_VERSION=\"\ $(REVISION)\"
 
+# default target
 all: $(BINARY_NAME)
 
-$(BINARY_NAME): $(OBJ) Makefile
-	$(Q_LD)$(CC) -o $@ $(OBJ) $(LDFLAGS)
-
+# standard build rules
+.SUFFIXES: .o .c
 .c.o:
 	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -MD -c $< -o $@
--include $(DEP)
+
+$(BINARY_NAME): $(OBJ) Makefile
+	$(Q_LD)$(CC) -o $@ $(OBJ) $(LDFLAGS)
 
 clean:
 	rm -f $(BINARY_NAME) $(OBJ) $(DEP)
@@ -60,4 +65,8 @@ install: $(BINARY_NAME)
 	mkdir -p $(SBINDIR)
 	install -m 0755 $(BINARY_NAME) $(SBINDIR)
 
+# load dependencies
+DEP = $(OBJ:.o=.d)
+-include $(DEP)
+
 .PHONY: all clean install
-- 
1.7.5.1

