Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 15:10:42 +0200
Message-Id: <1305983442-1607-14-git-send-email-sven@narfation.org>
In-Reply-To: <1305983442-1607-1-git-send-email-sven@narfation.org>
References: <1305983442-1607-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 14/14] batmand: Install manpage
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

 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 21a379c..4f6fe64 100755
--- a/Makefile
+++ b/Makefile
@@ -48,6 +48,7 @@ OS_OBJ =	$(BSD_OBJ) $(POSIX_OBJ)
 endif
 
 OBJ = batman.o originator.o schedule.o list-batman.o allocate.o bitarray.o hash.o profile.o ring_buffer.o hna.o $(OS_OBJ)
+MANPAGE = man/batmand.8
 
 # activate this variable to deactivate policy routing for backward compatibility
 #NO_POLICY_ROUTING = -DNO_POLICY_ROUTING
@@ -78,6 +79,7 @@ LINK.o = $(Q_LD)$(CC) $(LDFLAGS) $(TARGET_ARCH)
 # standard install paths
 PREFIX = /usr/local
 SBINDIR = $(PREFIX)/sbin
+MANDIR = $(PREFIX)/share/man
 
 # try to generate revision
 REVISION = $(shell if [ -d .git ]; then echo $$(git describe --always --dirty 2> /dev/null || echo "[unknown]"); fi)
@@ -99,7 +101,9 @@ clean:
 
 install: $(BINARY_NAME)
 	$(MKDIR) $(DESTDIR)$(SBINDIR)
+	$(MKDIR) $(DESTDIR)$(MANDIR)/man8
 	$(INSTALL) -m 0755 $(BINARY_NAME) $(DESTDIR)$(SBINDIR)
+	$(INSTALL) -m 0644 $(MANPAGE) $(DESTDIR)$(MANDIR)/man8
 
 # load dependencies
 DEP = $(OBJ:.o=.d)
-- 
1.7.5.1

