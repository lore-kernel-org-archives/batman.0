Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 22 Jun 2015 09:23:40 +0200
Message-Id: <1434957820-8418-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add missing include rculist.h
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

originator.c is using hlist_for_each_entry_rcu but did not include the
required header for it.

Reported-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 4500e3a..f51860d 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -26,6 +26,7 @@
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
+#include <linux/rculist.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-- 
2.1.4

