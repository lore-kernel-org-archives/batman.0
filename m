Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 16 Sep 2016 09:10:22 +0200
Message-Id: <20160916071022.22560-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: remove redundant #include
	<linux/kconfig.h>
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

From: Masahiro Yamada <yamada.masahiro@socionext.com>

Kernel source files need not include <linux/kconfig.h> explicitly
because the top Makefile forces to include it with:

  -include $(srctree)/include/linux/kconfig.h

Link: http://lkml.kernel.org/r/1473656164-11929-1-git-send-email-yamada.masahiro@socionext.com
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/debugfs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/batman-adv/debugfs.h b/net/batman-adv/debugfs.h
index c68ff3d..e49121e 100644
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -20,8 +20,6 @@
 
 #include "main.h"
 
-#include <linux/kconfig.h>
-
 struct net_device;
 
 #define BATADV_DEBUGFS_SUBDIR "batman_adv"
-- 
2.9.3

