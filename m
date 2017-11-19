Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 17:12:05 +0100
Message-Id: <20171119161207.32588-5-sven@narfation.org>
In-Reply-To: <20171119161207.32588-1-sven@narfation.org>
References: <20171119161207.32588-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: include kobject.h for
 kobject_* functions
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

The linux/kobject.h provides the kobject_* function declarations and should
therefore be included directly before they are used.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 5c29e38a..9eed0664 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -29,6 +29,7 @@
 #include <linux/if.h>
 #include <linux/if_vlan.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
-- 
2.11.0

