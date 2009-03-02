From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  2 Mar 2009 14:15:54 +0100
Message-Id: <1235999754-6552-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Generate source dependency informations on
	the fly
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

The current way to track dependencies in batman and related tools is to
look for changes in the .c file and if it exist the .h file with the
same name. This can lead to inconsistent compilations when changes are
done in a header which is included in different .c files.
The easiest workaround is to let the compiler generate the dependency
information which is then included in the makefile to notice changes
in directly and indirectly included files. The first run is made without
these informations during the build of object files. No extra execve or
gcc startup related overhead is generated in that way and future changes
are still tracked by make.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-userspace/Makefile |   10 ++++------
 batman/Makefile               |    9 ++++-----
 battool/Makefile              |    7 ++++---
 vis-advanced/Makefile         |   10 ++++------
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/batman-adv-userspace/Makefile b/batman-adv-userspace/Makefile
index 6e3c2dd..265799b 100644
--- a/batman-adv-userspace/Makefile
+++ b/batman-adv-userspace/Makefile
@@ -60,11 +60,9 @@ all:
 $(BINARY_NAME):	$(SRC_O) $(SRC_H) Makefile
 	$(Q_LD)$(CC) -o $@ $(SRC_O) $(LDFLAGS)
 
-%.o: %.c %.h
-	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
-
-%.o: %.c
-	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+.c.o:
+	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -MD -c $< -o $@
+-include $(SRC_C:.c=.d)
 
 sources:
 	mkdir -p $(FILE_NAME)
@@ -80,7 +78,7 @@ sources:
 	tar czvf $(FILE_NAME).tgz $(FILE_NAME)
 
 clean:
-	rm -f $(BINARY_NAME) *.o
+	rm -f $(BINARY_NAME) *.o *.d
 
 
 clean-long:
diff --git a/batman/Makefile b/batman/Makefile
index 565d75e..509217d 100644
--- a/batman/Makefile
+++ b/batman/Makefile
@@ -78,11 +78,9 @@ all:
 $(BINARY_NAME):	$(SRC_O) $(SRC_H) Makefile
 	$(Q_LD)$(CC) -o $@ $(SRC_O) $(LDFLAGS)
 
-%.o: %.c %.h
-	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
-
-%.o: %.c
-	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+.c.o:
+	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -MD -c $< -o $@
+-include $(SRC_C:.c=.d)
 
 sources:
 	mkdir -p $(FILE_NAME)
@@ -99,6 +97,7 @@ sources:
 
 clean:
 	rm -f $(BINARY_NAME) *.o posix/*.o linux/*.o bsd/*.o
+	rm -f `find . -name '*.d' -print`
 
 
 clean-long:
diff --git a/battool/Makefile b/battool/Makefile
index 10d310f..4c8d497 100644
--- a/battool/Makefile
+++ b/battool/Makefile
@@ -73,8 +73,9 @@ all:		$(BINARY_NAME)
 $(BINARY_NAME):	$(SRC_O) $(SRC_H) Makefile
 	$(Q_LD)$(CC) -o $@ $(SRC_O) $(LDFLAGS)
 
-%.o: %.c
-	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+.c.o:
+	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -MD -c $< -o $@
+-include $(SRC_C:.c=.d)
 
 sources:
 	mkdir -p $(FILE_NAME)
@@ -91,7 +92,7 @@ sources:
 	tar czvf $(FILE_NAME).tgz $(FILE_NAME)
 
 clean:
-	rm -f $(BINARY_NAME) *.o
+	rm -f $(BINARY_NAME) *.o *.d
 
 
 clean-long:
diff --git a/vis-advanced/Makefile b/vis-advanced/Makefile
index 548d85f..3eaf1eb 100644
--- a/vis-advanced/Makefile
+++ b/vis-advanced/Makefile
@@ -42,11 +42,9 @@ vis-adv:	$(SRC_O) Makefile
 vis-adv-static:	$(SRC_O) Makefile
 		$(Q_LD)$(CC) $(CFLAGS) -o $@ $(SRC_O) $(LDFLAGS_STATIC)
 
-%.o: %.c %.h
-	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
-
-%.o: %.c
-	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+.c.o:
+	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -MD -c $< -o $@
+-include $(SRC_C:.c=.d)
 
 clean:
-		rm -f vis-adv vis-adv-static *.o *~
+		rm -f vis-adv vis-adv-static *.o *.d *~
-- 
1.6.1.3

