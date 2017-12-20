Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 20 Dec 2017 12:01:16 +0100
Message-Id: <20171220110124.13117-12-sw@simonwunderlich.de>
In-Reply-To: <20171220110124.13117-1-sw@simonwunderlich.de>
References: <20171220110124.13117-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 11/19] batman-adv: Remove unused sched.h
 include
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The linux/wait.h include was removed with commit 421d988b2c08 ("batman-adv:
Consolidate logging related functions"). The previously required (but not
unused) linux/sched.h include can also be dropped now.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/debugfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index d94585dc2dbe..fddf16a3dc89 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -26,7 +26,6 @@
 #include <linux/fs.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
-#include <linux/sched.h> /* for linux/wait.h */
 #include <linux/seq_file.h>
 #include <linux/stat.h>
 #include <linux/stddef.h>
-- 
2.11.0

