Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 17:12:06 +0100
Message-Id: <20171119161207.32588-6-sven@narfation.org>
In-Reply-To: <20171119161207.32588-1-sven@narfation.org>
References: <20171119161207.32588-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: Remove unused sched.h include
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

The linux/wait.h include was removed with commit 421d988b2c08 ("batman-adv:
Consolidate logging related functions"). The previously required (but not
unused) linux/sched.h include can also be dropped now.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/debugfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index e5f76c76..96df3959 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -28,7 +28,6 @@
 #include <linux/fs.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
-#include <linux/sched.h> /* for linux/wait.h */
 #include <linux/seq_file.h>
 #include <linux/stat.h>
 #include <linux/stddef.h>
-- 
2.11.0

