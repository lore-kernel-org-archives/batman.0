Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 31 Mar 2011 18:11:38 +0200
Message-Id: <1301587899-9449-2-git-send-email-sven@narfation.org>
In-Reply-To: <1301587899-9449-1-git-send-email-sven@narfation.org>
References: <1301587899-9449-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove subversion/svk revision
	information
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

The current version of batman-adv cannot be obtained from subversion or
svk anymore. It is unnecessary to provide the functionality to retrieve
the current revision using these tools.

We only have to differenciate between git checkout and official release.
We cannot detect a git snapshot and thus the distribution has to provide
the REVISION variable for snapshots.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile |   20 ++------------------
 1 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 830c53b..84828ea 100644
--- a/Makefile
+++ b/Makefile
@@ -29,24 +29,8 @@ endif
 
 export KERNELPATH
 
-REVISION= $(shell	if [ -d .svn ]; then \
-				if which svn > /dev/null; then \
-					echo rv$$(svn info | grep "Rev:" | sed -e '1p' -n | awk '{print $$4}'); \
-				else \
-					echo "[unknown]"; \
-				fi; \
-			elif [ -d .git ]; then \
-				if which git > /dev/null; then \
-					echo $$(git describe --always --dirty 2> /dev/null); \
-				else \
-					echo "[unknown]"; \
-				fi; \
-			elif [ -d ~/.svk ]; then \
-				if which svk > /dev/null; then \
-					echo rv$$(svk info | grep "Mirrored From" | awk '{print $$5}'); \
-				else \
-					echo "[unknown]"; \
-				fi; \
+REVISION= $(shell	if [ -d .git ]; then \
+				echo $$(git describe --always --dirty 2> /dev/null || echo "[unknown]"); \
 			fi)
 
 NUM_CPUS = $(shell nproc 2> /dev/null || echo 1)
-- 
1.7.4.1

