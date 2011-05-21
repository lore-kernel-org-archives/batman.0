Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 15:45:08 +0200
Message-Id: <1305985517-3763-4-git-send-email-sven@narfation.org>
In-Reply-To: <1305985517-3763-1-git-send-email-sven@narfation.org>
References: <1305985517-3763-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 04/13] vis: Directly specify objects in
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
This patch depends on other patches submitted earlier:
 - vis: Remove obsolete creation of source packages
 - vis: Remove subversion/svk revision information

 Makefile |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index f7bcef9..a18aa72 100644
--- a/Makefile
+++ b/Makefile
@@ -32,9 +32,8 @@ LDFLAGS +=	-lpthread
 
 SBINDIR =	$(INSTALL_PREFIX)/usr/sbin
 
-SRC_C= allocate.c hash.c list-batman.c vis.c udp_server.c
-SRC_H= allocate.h hash.h list-batman.h vis.h vis-types.h
-SRC_O= $(SRC_C:.c=.o)
+OBJ = allocate.o hash.o list-batman.o vis.o udp_server.o
+DEP = $(OBJ:.o=.d)
 
 BINARY_NAME= vis
 
@@ -45,16 +44,15 @@ REVISION_VERSION=\"\ $(REVISION)\"
 
 all: $(BINARY_NAME)
 
-$(BINARY_NAME):	$(SRC_O) $(SRC_H) Makefile
-	$(Q_LD)$(CC) -o $@ $(SRC_O) $(LDFLAGS)
+$(BINARY_NAME): $(OBJ) Makefile
+	$(Q_LD)$(CC) -o $@ $(OBJ) $(LDFLAGS)
 
 .c.o:
 	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -MD -c $< -o $@
--include $(SRC_C:.c=.d)
+-include $(DEP)
 
 clean:
-	rm -f $(BINARY_NAME) *.o
-	rm -f `find . -name '*.d' -print`
+	rm -f $(BINARY_NAME) $(OBJ) $(DEP)
 
 install:
 	mkdir -p $(SBINDIR)
-- 
1.7.5.1

