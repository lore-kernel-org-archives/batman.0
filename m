Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 Sep 2013 16:31:15 +0200
Message-Id: <1379773877-6299-2-git-send-email-sven@narfation.org>
In-Reply-To: <1379773877-6299-1-git-send-email-sven@narfation.org>
References: <1379773877-6299-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] alfred: Fix version number for git
	builds of vis
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vis/Makefile b/vis/Makefile
index 9bf72c9..bd83877 100644
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -49,7 +49,7 @@ PREFIX = /usr/local
 SBINDIR = $(PREFIX)/sbin
 
 # try to generate revision
-REVISION= $(shell	if [ -d .git ]; then \
+REVISION= $(shell	if [ -d ../.git ]; then \
 				echo $$(git describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
 			fi)
 ifneq ($(REVISION),)
-- 
1.8.4.rc3

