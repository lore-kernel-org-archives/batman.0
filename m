Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 21 Jun 2010 18:18:35 +0200
Message-Id: <1277137115-10338-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1277137115-10338-1-git-send-email-sven.eckelmann@gmx.de>
References: <1277137115-10338-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Add support for git revision
	string
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

The Makefile tries to find a version number which describes the state of
the version somebody compiles. Currently this can only be a subversion
revision. This must also be done for git as it is used to prepare the
actual releases.

The revision string consists of 4 parts:
 1. last annotated tag name
 2. number of commits inbetween last tag name and this commit
 3. shortened sha1 sum of the commit
 4. indicator whether the files where modified

The first part is only shown when there was a tag before the commit or
the current commit was tagged. Part two and three is only shown when the
current commit is not tagged. The indicator is also only shown when the
files were modified.

This should make it quite easy understandable for humans and still makes
it possible to find the commit in the repository using standard git
tools (for that purpose the "-dirty" string  must be ommited).

A full example would be v2010.0.0-25-gdc3f30c-dirty

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/Makefile        |   30 +++++++++++++++++++-----------
 batman-adv/Makefile.kbuild |    2 +-
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/batman-adv/Makefile b/batman-adv/Makefile
index 4f6a460..e52a2d3 100644
--- a/batman-adv/Makefile
+++ b/batman-adv/Makefile
@@ -29,17 +29,25 @@ endif
 
 export KERNELPATH
 
-REVISION=	$(shell if [ -d .svn ]; then \
-						if which svn > /dev/null; then \
-							svn info | grep "Rev:" | sed -e '1p' -n | awk '{print $$4}'; \
-						fi; \
-					else \
-						if [ -d ~/.svk ]; then \
-							if which svk > /dev/null; then \
-								echo $$(svk info | grep "Mirrored From" | awk '{print $$5}'); \
-							fi; \
-						fi; \
-					fi)
+REVISION= $(shell	if [ -d .svn ]; then \
+				if which svn > /dev/null; then \
+					echo rv$$(svn info | grep "Rev:" | sed -e '1p' -n | awk '{print $$4}'); \
+				else \
+					echo "[unknown]"; \
+				fi; \
+			elif [ -d .git ]; then \
+				if which git > /dev/null; then \
+					echo $$(git describe --always --dirty 2> /dev/null); \
+				else \
+					echo "[unknown]"; \
+				fi; \
+			elif [ -d ~/.svk ]; then \
+				if which svk > /dev/null; then \
+					echo rv$$(svk info | grep "Mirrored From" | awk '{print $$5}'); \
+				else \
+					echo "[unknown]"; \
+				fi; \
+			fi)
 
 NUM_CPUS = $(shell NUM_CPUS=`cat /proc/cpuinfo | grep -v 'model name' | grep processor | tail -1 | awk -F' ' '{print $$3}'`;echo `expr $$NUM_CPUS + 1`)
 
diff --git a/batman-adv/Makefile.kbuild b/batman-adv/Makefile.kbuild
index d42f6a3..762ee4e 100644
--- a/batman-adv/Makefile.kbuild
+++ b/batman-adv/Makefile.kbuild
@@ -28,7 +28,7 @@ endif
 # EXTRA_CFLAGS += -DCONFIG_BATMAN_ADV_DEBUG
 
 ifneq ($(REVISION),)
-EXTRA_CFLAGS += -DREVISION_VERSION=\"r$(REVISION)\"
+EXTRA_CFLAGS += -DREVISION_VERSION=\"$(REVISION)\"
 endif
 
 obj-m += batman-adv.o
-- 
1.7.1

