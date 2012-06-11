Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 11 Jun 2012 16:46:46 +0200
Message-Id: <1339426006-13470-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix include of linux/kernel.h
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

This is a non-fatal include problem that was only detected by cppcheck. The
regression was introduced by 4738c60318e757cf0062476e2095caa5b6970a8d

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 types.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/types.h b/types.h
index fd86a44..2141c13 100644
--- a/types.h
+++ b/types.h
@@ -22,7 +22,7 @@
 
 #include "packet.h"
 #include "bitarray.h"
-#include "linux/kernel.h"
+#include <linux/kernel.h>
 
 #define BATADV_HEADER_LEN \
 	(ETH_HLEN + max(sizeof(struct batadv_unicast_packet), \
-- 
1.7.10

