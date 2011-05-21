Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 14:28:08 +0200
Message-Id: <1305980898-30494-4-git-send-email-sven@narfation.org>
In-Reply-To: <1305980898-30494-1-git-send-email-sven@narfation.org>
References: <1305980898-30494-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 04/14] batctl: Directly specify objects in
	Makefile
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

The information about header and source files aren't needed by the
Makefile. Only the dependencies to headers provide useful information,
but these are automatically included by the generated *.d files.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index cf0b5c5..1bc4879 100644
--- a/Makefile
+++ b/Makefile
@@ -32,12 +32,8 @@ LDFLAGS += -lm
 
 SBINDIR = $(INSTALL_PREFIX)/usr/sbin
 
-EXTRA_MODULES_C := bisect.c
-EXTRA_MODULES_H := bisect.h
-
-SRC_C = main.c bat-hosts.c functions.c sys.c debug.c ping.c traceroute.c tcpdump.c list-batman.c hash.c vis.c debugfs.c $(EXTRA_MODULES_C)
-SRC_H = main.h bat-hosts.h functions.h sys.h debug.h ping.h traceroute.h tcpdump.h list-batman.h hash.h allocate.h vis.h debugfs.h $(EXTRA_MODULES_H)
-SRC_O = $(SRC_C:.c=.o)
+OBJ = main.o bat-hosts.o functions.o sys.o debug.o ping.o traceroute.o tcpdump.o list-batman.o hash.o vis.o debugfs.o bisect.o
+DEP = $(OBJ:.o=.d)
 
 BINARY_NAME = batctl
 
@@ -49,15 +45,15 @@ REVISION_VERSION =\"\ $(REVISION)\"
 
 all: $(BINARY_NAME)
 
-$(BINARY_NAME): $(SRC_O) $(SRC_H) Makefile
-	$(Q_LD)$(CC) -o $@ $(SRC_O) $(LDFLAGS)
+$(BINARY_NAME): $(OBJ) Makefile
+	$(Q_LD)$(CC) -o $@ $(OBJ) $(LDFLAGS)
 
 .c.o:
 	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -MD -c $< -o $@
--include $(SRC_C:.c=.d)
+-include $(DEP)
 
 clean:
-	rm -f $(BINARY_NAME) *.o *.d
+	rm -f $(BINARY_NAME) $(OBJ) $(DEP)
 
 install:
 	mkdir -p $(SBINDIR)
-- 
1.7.5.1

