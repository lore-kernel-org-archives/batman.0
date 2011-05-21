Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 15:10:32 +0200
Message-Id: <1305983442-1607-4-git-send-email-sven@narfation.org>
In-Reply-To: <1305983442-1607-1-git-send-email-sven@narfation.org>
References: <1305983442-1607-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 04/14] batmand: Directly specify objects in
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
 - batmand: Fix FTBFS on second build attempt
 - batmand: Remove obsolete creation of source packages
 - batmand: Remove subversion/svk revision information
 - batmand: Use nproc to get number of available processors

 Makefile |   29 ++++++++++++++---------------
 1 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index ce94472..3ac2885 100644
--- a/Makefile
+++ b/Makefile
@@ -36,33 +36,33 @@ LDFLAGS +=	-lpthread
 SBINDIR =	$(INSTALL_PREFIX)/usr/sbin
 
 UNAME =		$(shell uname)
-POSIX_C =	posix/init.c posix/posix.c posix/tunnel.c posix/unix_socket.c
-BSD_C =		bsd/route.c bsd/tun.c bsd/kernel.c bsd/compat.c
+POSIX_OBJ =	posix/init.o posix/posix.o posix/tunnel.o posix/unix_socket.o
+BSD_OBJ =	bsd/route.o bsd/tun.o bsd/kernel.o bsd/compat.o
+LINUX_OBJ =	linux/route.o linux/tun.o linux/kernel.o
 
 ifeq ($(UNAME),Linux)
-OS_C =		linux/route.c linux/tun.c linux/kernel.c $(POSIX_C)
+OS_OBJ =	$(LINUX_OBJ) $(POSIX_OBJ)
 endif
 
 ifeq ($(UNAME),Darwin)
-OS_C =		$(BSD_C) $(POSIX_C)
+OS_OBJ =	$(BSD_OBJ) $(POSIX_OBJ)
 endif
 
 ifeq ($(UNAME),GNU/kFreeBSD)
-OS_C =		$(BSD_C) $(POSIX_C)
+OS_OBJ =	$(BSD_OBJ) $(POSIX_OBJ)
 LDFLAGS +=	-lfreebsd -lbsd
 endif
 
 ifeq ($(UNAME),FreeBSD)
-OS_C =		$(BSD_C) $(POSIX_C)
+OS_OBJ =	$(BSD_OBJ) $(POSIX_OBJ)
 endif
 
 ifeq ($(UNAME),OpenBSD)
-OS_C =		$(BSD_C) $(POSIX_C)
+OS_OBJ =	$(BSD_OBJ) $(POSIX_OBJ)
 endif
 
-SRC_C= batman.c originator.c schedule.c list-batman.c allocate.c bitarray.c hash.c profile.c ring_buffer.c hna.c $(OS_C)
-SRC_H= batman.h originator.h schedule.h list-batman.h os.h allocate.h bitarray.h hash.h profile.h packet.h types.h ring_buffer.h hna.h
-SRC_O= $(SRC_C:.c=.o)
+OBJ = batman.o originator.o schedule.o list-batman.o allocate.o bitarray.o hash.o profile.o ring_buffer.o hna.o $(OS_OBJ)
+DEP = $(OBJ:.o=.d)
 
 BINARY_NAME =	batmand
 
@@ -74,16 +74,15 @@ REVISION_VERSION =\"\ $(REVISION)\"
 
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
-	rm -f $(BINARY_NAME) *.o posix/*.o linux/*.o bsd/*.o
-	rm -f *.d posix/*.d linux/*.d bsd/*.d
+	rm -f $(BINARY_NAME) $(OBJ) $(DEP)
 
 install:
 	mkdir -p $(SBINDIR)
-- 
1.7.5.1

