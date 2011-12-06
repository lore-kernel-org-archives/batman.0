Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  6 Dec 2011 19:57:11 +0100
Message-Id: <1323197832-1791-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batmand: Don't override CPPFLAGS set by user
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

Users or build servers may want to enable preprocessor specific options like
-D_FORTIFY_SOURCE=2 that are usually placed in CPPFLAGS. The batmand makefile
should not override these options to add own preprocessor variables.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 346b14a..65e0cf2 100755
--- a/Makefile
+++ b/Makefile
@@ -55,7 +55,7 @@ MANPAGE = man/batmand.8
 
 # batmand flags and options
 CFLAGS +=	-pedantic -Wall -W -std=gnu99 -MD
-CPPFLAGS =	-DDEBUG_MALLOC -DMEMORY_USAGE -DPROFILE_DATA $(NO_POLICY_ROUTING)
+CPPFLAGS +=	-DDEBUG_MALLOC -DMEMORY_USAGE -DPROFILE_DATA $(NO_POLICY_ROUTING)
 LDLIBS +=	-lpthread
 
 # disable verbose output
-- 
1.7.7.3

