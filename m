Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 Oct 2013 17:14:20 +0200
Message-Id: <1381936460-2922-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Add installation of the alfred-gpsd
	manpage
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

It is nice to have a manpage somewhere but the user is most likely more
interested in reading it from a familiar place. Installing it together with the
binary seems appropriate because then the user only has to call his/her prefered
manpage reader to get fast and easy access to information about everything the
alfred-gpsd binary provides.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Marek: can you create a html manpage for
 http://downloads.open-mesh.org/batman/manpages/ ?

Thanks

 gpsd/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gpsd/Makefile b/gpsd/Makefile
index eaf390b..9b21652 100644
--- a/gpsd/Makefile
+++ b/gpsd/Makefile
@@ -21,6 +21,7 @@
 # alfred-gpsd build
 BINARY_NAME = alfred-gpsd
 OBJ = alfred-gpsd.o
+MANPAGE = man/alfred-gpsd.8
 
 # alfred flags and options
 CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
@@ -64,6 +65,7 @@ LINK.o = $(Q_LD)$(CC) $(CFLAGS) $(LDFLAGS) $(TARGET_ARCH)
 # standard install paths
 PREFIX = /usr/local
 SBINDIR = $(PREFIX)/sbin
+MANDIR = $(PREFIX)/share/man
 
 # try to generate revision
 REVISION= $(shell	if [ -d ../.git ]; then \
@@ -89,7 +91,9 @@ clean:
 
 install: $(BINARY_NAME)
 	$(MKDIR) $(DESTDIR)$(SBINDIR)
+	$(MKDIR) $(DESTDIR)$(MANDIR)/man8
 	$(INSTALL) -m 0755 $(BINARY_NAME) $(DESTDIR)$(SBINDIR)
+	$(INSTALL) -m 0644 $(MANPAGE) $(DESTDIR)$(MANDIR)/man8
 
 # load dependencies
 DEP = $(OBJ:.o=.d)
-- 
1.8.4.rc3

