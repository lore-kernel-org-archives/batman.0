Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 15:10:37 +0200
Message-Id: <1305983442-1607-9-git-send-email-sven@narfation.org>
In-Reply-To: <1305983442-1607-1-git-send-email-sven@narfation.org>
References: <1305983442-1607-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 09/14] batmand: Reorder Makefile for better
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
 - batmand: Fix FTBFS on second build attempt
 - batmand: Remove obsolete creation of source packages
 - batmand: Remove subversion/svk revision information
 - batmand: Use nproc to get number of available processors

 Makefile |   65 +++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/Makefile b/Makefile
index df2f5b2..a25f3fc 100755
--- a/Makefile
+++ b/Makefile
@@ -18,24 +18,8 @@
 # 02110-1301, USA
 #
 
-ifneq ($(findstring $(MAKEFLAGS),s),s)
-ifndef V
-	Q_CC = @echo '   ' CC $@;
-	Q_LD = @echo '   ' LD $@;
-	export Q_CC
-	export Q_LD
-endif
-endif
-
-# activate this variable to deactivate policy routing for backward compatibility
-#NO_POLICY_ROUTING = -DNO_POLICY_ROUTING
-
-CC ?=		gcc
-CFLAGS +=	-pedantic -Wall -W -std=gnu99
-EXTRA_CFLAGS =	-DDEBUG_MALLOC -DMEMORY_USAGE -DPROFILE_DATA $(NO_POLICY_ROUTING) -DREVISION_VERSION=$(REVISION_VERSION)
-LDFLAGS +=	-lpthread
-
-SBINDIR =	$(INSTALL_PREFIX)/usr/sbin
+# batmand build
+BINARY_NAME = batmand
 
 UNAME =		$(shell uname)
 POSIX_OBJ =	posix/init.o posix/posix.o posix/tunnel.o posix/unix_socket.o
@@ -64,24 +48,45 @@ OS_OBJ =	$(BSD_OBJ) $(POSIX_OBJ)
 endif
 
 OBJ = batman.o originator.o schedule.o list-batman.o allocate.o bitarray.o hash.o profile.o ring_buffer.o hna.o $(OS_OBJ)
-DEP = $(OBJ:.o=.d)
 
-BINARY_NAME =	batmand
+# activate this variable to deactivate policy routing for backward compatibility
+#NO_POLICY_ROUTING = -DNO_POLICY_ROUTING
 
-REVISION= $(shell      if [ -d .git ]; then \
-                               echo $$(git describe --always --dirty 2> /dev/null || echo "[unknown]"); \
-                        fi)
+# batmand flags and options
+CFLAGS +=	-pedantic -Wall -W -std=gnu99
+EXTRA_CFLAGS =	-DDEBUG_MALLOC -DMEMORY_USAGE -DPROFILE_DATA $(NO_POLICY_ROUTING) -DREVISION_VERSION=$(REVISION_VERSION)
+LDFLAGS +=	-lpthread
+
+# disable verbose output
+ifneq ($(findstring $(MAKEFLAGS),s),s)
+ifndef V
+	Q_CC = @echo '   ' CC $@;
+	Q_LD = @echo '   ' LD $@;
+	export Q_CC
+	export Q_LD
+endif
+endif
+
+# standard build tools
+CC ?=		gcc
+
+# standard install paths
+SBINDIR =	$(INSTALL_PREFIX)/usr/sbin
+
+# try to generate revision
+REVISION = $(shell if [ -d .git ]; then echo $$(git describe --always --dirty 2> /dev/null || echo "[unknown]"); fi)
 REVISION_VERSION =\"\ $(REVISION)\"
 
-
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
@@ -90,4 +95,8 @@ install: $(BINARY_NAME)
 	mkdir -p $(SBINDIR)
 	install -m 0755 $(BINARY_NAME) $(SBINDIR)
 
+# load dependencies
+DEP = $(OBJ:.o=.d)
+-include $(DEP)
+
 .PHONY: all clean install
-- 
1.7.5.1

