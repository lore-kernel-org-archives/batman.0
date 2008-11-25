From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 25 Nov 2008 23:39:50 +0100
Message-Id: <1227652790-9362-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Compile object files before linking
	vis-advanced
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 vis-advanced/Makefile |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/vis-advanced/Makefile b/vis-advanced/Makefile
index 9448fd9..548d85f 100644
--- a/vis-advanced/Makefile
+++ b/vis-advanced/Makefile
@@ -16,6 +16,15 @@
 # 02110-1301, USA
 #
 
+ifneq ($(findstring $(MAKEFLAGS),s),s)
+ifndef V
+	Q_CC = @echo '   ' CC $@;
+	Q_LD = @echo '   ' LD $@;
+	export Q_CC
+	export Q_LD
+endif
+endif
+
 CC = gcc
 CFLAGS =         -Wall -W -O0 -g3 -DDEBUG_MALLOC -DMEMORY_USAGE
 LDFLAGS =        -lpthread
@@ -24,13 +33,20 @@ LDFLAGS_STATIC = -lpthread -static
 
 SRC_C= allocate.c hash.c list-batman.c vis.c udp_server.c
 SRC_H= allocate.h hash.h list-batman.h vis.h vis-types.h
+SRC_O=		$(SRC_C:.c=.o)
+
+
+vis-adv:	$(SRC_O) Makefile
+		$(Q_LD)$(CC) $(CFLAGS) -o $@ $(SRC_O) $(LDFLAGS)
 
+vis-adv-static:	$(SRC_O) Makefile
+		$(Q_LD)$(CC) $(CFLAGS) -o $@ $(SRC_O) $(LDFLAGS_STATIC)
 
-vis-adv:	$(SRC_C) $(SRC_H) Makefile
-		$(CC) $(CFLAGS) -o $@ $(SRC_C) $(LDFLAGS)
+%.o: %.c %.h
+	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
 
-vis-adv-static:	$(SRC_C) $(SRC_H) Makefile
-		$(CC) $(CFLAGS) -o $@ $(SRC_C) $(LDFLAGS_STATIC)
+%.o: %.c
+	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
 
 clean:
 		rm -f vis-adv vis-adv-static *.o *~
-- 
1.6.0.4

