Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 21 Jun 2010 18:18:34 +0200
Message-Id: <1277137115-10338-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: Add support for git revision
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

A full example would be v2010.0.0-15-g154f68a-dirty

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batctl/Makefile |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/batctl/Makefile b/batctl/Makefile
index ab9c075..fde5486 100644
--- a/batctl/Makefile
+++ b/batctl/Makefile
@@ -47,23 +47,27 @@ PACKAGE_NAME = batctl
 BINARY_NAME = batctl
 SOURCE_VERSION_HEADER = main.h
 
-REVISION = $(shell if [ -d .svn ]; then \
-					if which svn > /dev/null; then \
-						svn info | grep "Rev:" | sed -e '1p' -n | awk '{print $$4}'; \
-					else \
-						echo "[unknown]"; \
-					fi ; \
+REVISION= $(shell	if [ -d .svn ]; then \
+				if which svn > /dev/null; then \
+					echo rv$$(svn info | grep "Rev:" | sed -e '1p' -n | awk '{print $$4}'); \
 				else \
-					if [ -d ~/.svk ]; then \
-						if which svk > /dev/null; then \
-							echo $$(svk info | grep "Mirrored From" | awk '{print $$5}'); \
-						else \
-							echo "[unknown]"; \
-						fi; \
-					fi; \
-				fi)
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
 
-REVISION_VERSION =\"\ rv$(REVISION)\"
+REVISION_VERSION =\"\ $(REVISION)\"
 
 BAT_VERSION = $(shell grep "^\#define SOURCE_VERSION " $(SOURCE_VERSION_HEADER) | sed -e '1p' -n | awk -F '"' '{print $$2}' | awk '{print $$1}')
 FILE_NAME = $(PACKAGE_NAME)_$(BAT_VERSION)-rv$(REVISION)_$@
-- 
1.7.1

