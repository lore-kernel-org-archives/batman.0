Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Sep 2013 22:58:32 +0200
Message-Id: <1379019524-23543-2-git-send-email-sven@narfation.org>
In-Reply-To: <1379019524-23543-1-git-send-email-sven@narfation.org>
References: <1379019524-23543-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 01/13] batmand: Disable strict-aliasing rules
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

There are different aliasing problems in posix/tunnel.c and maybe other files.
This can lead to wrongly generated code when the compiler assumes strict
aliasing rules.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ce1e198..3205573 100755
--- a/Makefile
+++ b/Makefile
@@ -37,7 +37,7 @@ MANPAGE = man/batmand.8
 #NO_POLICY_ROUTING = -DNO_POLICY_ROUTING
 
 # batmand flags and options
-CFLAGS +=	-pedantic -Wall -W -std=gnu99 -MD
+CFLAGS +=	-pedantic -Wall -W -std=gnu99 -MD -fno-strict-aliasing
 CPPFLAGS +=	-DDEBUG_MALLOC -DMEMORY_USAGE -DPROFILE_DATA $(NO_POLICY_ROUTING)
 LDLIBS +=	-lpthread
 
-- 
1.8.4.rc3

