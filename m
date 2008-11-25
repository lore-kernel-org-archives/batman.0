From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 25 Nov 2008 23:29:26 +0100
Message-Id: <1227652166-9181-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Reduce verbosity of make
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

Make's normal output makes it hard to distinguish between warnings and
commands, but `make -s` will completely hide information about what is currently
done and irritate the user. A good compromise is linux way of printing the type
of build command and the output filename of each target.

The normal behaviour can be restored by running `make V=99`.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-userspace/Makefile |   14 +++++++++++---
 batman/Makefile               |   16 ++++++++++++----
 battool/Makefile              |   12 ++++++++++--
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/batman-adv-userspace/Makefile b/batman-adv-userspace/Makefile
index e27acc5..d71b5e6 100644
--- a/batman-adv-userspace/Makefile
+++ b/batman-adv-userspace/Makefile
@@ -16,6 +16,14 @@
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
 
 CC =		gcc
 CFLAGS =	-Wall -W -O1 -g
@@ -50,13 +58,13 @@ all:
 	$(MAKE) -j $(NUM_CPUS) $(BINARY_NAME)
 
 $(BINARY_NAME):	$(SRC_O) $(SRC_H) Makefile
-	$(CC) -o $@ $(SRC_O) $(LDFLAGS)
+	$(Q_LD)$(CC) -o $@ $(SRC_O) $(LDFLAGS)
 
 %.o: %.c %.h
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
 
 %.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
 
 sources:
 	mkdir -p $(FILE_NAME)
diff --git a/batman/Makefile b/batman/Makefile
index 61e5a98..22cdbbd 100644
--- a/batman/Makefile
+++ b/batman/Makefile
@@ -16,6 +16,14 @@
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
 
 CC =		gcc
 CFLAGS =	-pedantic -Wall -W -O1 -g3
@@ -65,16 +73,16 @@ NUM_CPUS = $(shell NUM_CPUS=`cat /proc/cpuinfo | grep -v 'model name' | grep pro
 
 
 all:
-	$(MAKE) -j $(NUM_CPUS) $(BINARY_NAME)
+	@$(MAKE) -j $(NUM_CPUS) $(BINARY_NAME)
 
 $(BINARY_NAME):	$(SRC_O) $(SRC_H) Makefile
-	$(CC) -o $@ $(SRC_O) $(LDFLAGS)
+	$(Q_LD)$(CC) -o $@ $(SRC_O) $(LDFLAGS)
 
 %.o: %.c %.h
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
 
 %.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
 
 sources:
 	mkdir -p $(FILE_NAME)
diff --git a/battool/Makefile b/battool/Makefile
index a9ded64..805e454 100644
--- a/battool/Makefile
+++ b/battool/Makefile
@@ -16,6 +16,14 @@
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
 
 CC =		gcc
 CFLAGS =	-W -Wall -O1 -g
@@ -63,10 +71,10 @@ FILE_NAME=	$(PACKAGE_NAME)_$(BAT_VERSION)-rv$(REVISION)_$@
 all:		$(BINARY_NAME)
 
 $(BINARY_NAME):	$(SRC_O) $(SRC_H) Makefile
-	$(CC) -o $@ $(SRC_O) $(LDFLAGS)
+	$(Q_LD)$(CC) -o $@ $(SRC_O) $(LDFLAGS)
 
 %.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
+	$(Q_CC)$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
 
 sources:
 	mkdir -p $(FILE_NAME)
-- 
1.6.0.4

