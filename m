Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 14:28:14 +0200
Message-Id: <1305980898-30494-10-git-send-email-sven@narfation.org>
In-Reply-To: <1305980898-30494-1-git-send-email-sven@narfation.org>
References: <1305980898-30494-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 10/14] batctl: Use standard-like build rules
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
 Makefile |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 0683fd7..edd8907 100755
--- a/Makefile
+++ b/Makefile
@@ -23,9 +23,9 @@ BINARY_NAME = batctl
 OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o list-batman.o hash.o vis.o debugfs.o bisect.o
 
 # batctl flags and options
-CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing
-EXTRA_CFLAGS += -DREVISION_VERSION=$(REVISION_VERSION)
-LDFLAGS += -lm
+CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD
+CPPFLAGS += -DREVISION_VERSION=$(REVISION_VERSION)
+LDLIBS += -lm
 
 # disable verbose output
 ifneq ($(findstring $(MAKEFLAGS),s),s)
@@ -39,6 +39,8 @@ endif
 
 # standard build tools
 CC ?= gcc
+COMPILE.c = $(Q_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
+LINK.o = $(Q_LD)$(CC) $(LDFLAGS) $(TARGET_ARCH)
 
 # standard install paths
 SBINDIR = $(INSTALL_PREFIX)/usr/sbin
@@ -53,10 +55,10 @@ all: $(BINARY_NAME)
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

