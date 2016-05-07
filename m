Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  7 May 2016 09:50:44 +0200
Message-Id: <1462607444-16656-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Add missing include for
	batadv_v_neigh_is_sob
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

batadv_v_neigh_is_sob started to use false which is defined in
linux/stddef.h.

Fixes: 036aa7b7181e ("batman-adv: Avoid nullptr derefence in batadv_v_neigh_is_sob")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 2bcb29b..5b30a11 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -27,6 +27,7 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
