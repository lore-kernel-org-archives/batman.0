Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  5 Jul 2011 10:54:59 +0200
Message-Id: <1309856099-10122-1-git-send-email-sven@narfation.org>
In-Reply-To: <1309855371-9389-1-git-send-email-sven@narfation.org>
References: <1309855371-9389-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: Replace version info instead of
	appending them
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

The version number of batctl can get revision numbers added. This is useful to
give hints about the revision of a distribution package and the used patchset
or the commit which was used to build it. The prepended source number or branch
name doesn't add any additional information which would help to identify
problems and can therefore be omitted.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile |    9 ++++++---
 main.c   |    2 +-
 main.h   |    6 +++---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index eee5a63..85efc30 100755
--- a/Makefile
+++ b/Makefile
@@ -25,7 +25,6 @@ MANPAGE = man/batctl.8
 
 # batctl flags and options
 CFLAGS += -pedantic -Wall -W -std=gnu99 -fno-strict-aliasing -MD
-CPPFLAGS += -DREVISION_VERSION=$(REVISION_VERSION)
 LDLIBS += -lm
 
 # disable verbose output
@@ -52,8 +51,12 @@ SBINDIR = $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 
 # try to generate revision
-REVISION = $(shell if [ -d .git ]; then echo $$(git describe --always --dirty 2> /dev/null || echo "[unknown]"); fi)
-REVISION_VERSION =\"\ $(REVISION)\"
+REVISION= $(shell	if [ -d .git ]; then \
+				echo $$(git describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
+			fi)
+ifneq ($(REVISION),)
+CPPFLAGS += -DSOURCE_VERSION=\"$(REVISION)\"
+endif
 
 # default target
 all: $(BINARY_NAME)
diff --git a/main.c b/main.c
index eb67737..e0cccbd 100644
--- a/main.c
+++ b/main.c
@@ -95,7 +95,7 @@ int main(int argc, char **argv)
 		goto err;
 
 	if (strcmp(argv[1], "-v") == 0) {
-		printf("batctl %s%s\n", SOURCE_VERSION, (strlen(REVISION_VERSION) > 3 ? REVISION_VERSION : ""));
+		printf("batctl %s\n", SOURCE_VERSION);
 		exit(EXIT_SUCCESS);
 	}
 
diff --git a/main.h b/main.h
index a9102b1..dd6428b 100644
--- a/main.h
+++ b/main.h
@@ -19,9 +19,9 @@
  *
  */
 
-
-
-#define SOURCE_VERSION "next"
+#ifndef SOURCE_VERSION
+#define SOURCE_VERSION "2011.2.0"
+#endif
 
 #define SOCKET_PATH_FMT "%s/batman_adv/%s/socket"
 
-- 
1.7.5.4

