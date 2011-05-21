Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 15:10:39 +0200
Message-Id: <1305983442-1607-11-git-send-email-sven@narfation.org>
In-Reply-To: <1305983442-1607-1-git-send-email-sven@narfation.org>
References: <1305983442-1607-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 11/14] Make called tools in clean and install
	configurable
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

 Makefile |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index a0a7f88..6c77fe7 100755
--- a/Makefile
+++ b/Makefile
@@ -69,6 +69,9 @@ endif
 
 # standard build tools
 CC ?=		gcc
+RM ?= rm -f
+INSTALL ?= install
+MKDIR ?= mkdir -p
 COMPILE.c = $(Q_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
 LINK.o = $(Q_LD)$(CC) $(LDFLAGS) $(TARGET_ARCH)
 
@@ -91,11 +94,11 @@ $(BINARY_NAME): $(OBJ)
 	$(LINK.o) $^ $(LDLIBS) -o $@
 
 clean:
-	rm -f $(BINARY_NAME) $(OBJ) $(DEP)
+	$(RM) $(BINARY_NAME) $(OBJ) $(DEP)
 
 install: $(BINARY_NAME)
-	mkdir -p $(SBINDIR)
-	install -m 0755 $(BINARY_NAME) $(SBINDIR)
+	$(MKDIR) $(SBINDIR)
+	$(INSTALL) -m 0755 $(BINARY_NAME) $(SBINDIR)
 
 # load dependencies
 DEP = $(OBJ:.o=.d)
-- 
1.7.5.1

