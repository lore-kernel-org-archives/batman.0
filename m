Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 15:10:38 +0200
Message-Id: <1305983442-1607-10-git-send-email-sven@narfation.org>
In-Reply-To: <1305983442-1607-1-git-send-email-sven@narfation.org>
References: <1305983442-1607-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 10/14] batmand: Use standard-like build rules
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

User expect a specific naming inside makefile rules which they can
modify by changing environment variables or providing them explicitely
as parameters of the make call. The naming was extracted from the gnu
make standard rules database.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This patch depends on other patches submitted earlier:
 - batmand: Fix FTBFS on second build attempt
 - batmand: Remove obsolete creation of source packages
 - batmand: Remove subversion/svk revision information
 - batmand: Use nproc to get number of available processors

 Makefile |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index a25f3fc..a0a7f88 100755
--- a/Makefile
+++ b/Makefile
@@ -36,7 +36,7 @@ endif
 
 ifeq ($(UNAME),GNU/kFreeBSD)
 OS_OBJ =	$(BSD_OBJ) $(POSIX_OBJ)
-LDFLAGS +=	-lfreebsd -lbsd
+LDLIBS +=	-lfreebsd -lbsd
 endif
 
 ifeq ($(UNAME),FreeBSD)
@@ -53,9 +53,9 @@ OBJ = batman.o originator.o schedule.o list-batman.o allocate.o bitarray.o hash.
 #NO_POLICY_ROUTING = -DNO_POLICY_ROUTING
 
 # batmand flags and options
-CFLAGS +=	-pedantic -Wall -W -std=gnu99
-EXTRA_CFLAGS =	-DDEBUG_MALLOC -DMEMORY_USAGE -DPROFILE_DATA $(NO_POLICY_ROUTING) -DREVISION_VERSION=$(REVISION_VERSION)
-LDFLAGS +=	-lpthread
+CFLAGS +=	-pedantic -Wall -W -std=gnu99 -MD
+CPPFLAGS =	-DDEBUG_MALLOC -DMEMORY_USAGE -DPROFILE_DATA $(NO_POLICY_ROUTING) -DREVISION_VERSION=$(REVISION_VERSION)
+LDLIBS +=	-lpthread
 
 # disable verbose output
 ifneq ($(findstring $(MAKEFLAGS),s),s)
@@ -69,6 +69,8 @@ endif
 
 # standard build tools
 CC ?=		gcc
+COMPILE.c = $(Q_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
+LINK.o = $(Q_LD)$(CC) $(LDFLAGS) $(TARGET_ARCH)
 
 # standard install paths
 SBINDIR =	$(INSTALL_PREFIX)/usr/sbin
@@ -83,10 +85,10 @@ all: $(BINARY_NAME)
 # standard build rules
 .SUFFIXES: .o .c
 .c.o:
-	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -MD -c $< -o $@
+	$(COMPILE.c) -o $@ $<
 
-$(BINARY_NAME): $(OBJ) Makefile
-	$(Q_LD)$(CC) -o $@ $(OBJ) $(LDFLAGS)
+$(BINARY_NAME): $(OBJ)
+	$(LINK.o) $^ $(LDLIBS) -o $@
 
 clean:
 	rm -f $(BINARY_NAME) $(OBJ) $(DEP)
-- 
1.7.5.1

