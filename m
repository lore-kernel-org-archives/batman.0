Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Nov 2018 15:07:51 +0100
Message-Id: <20181114140804.18381-4-sw@simonwunderlich.de>
In-Reply-To: <20181114140804.18381-1-sw@simonwunderlich.de>
References: <20181114140804.18381-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 03/16] batman-adv: Add includes for
 deprecation warning
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

The commit 00caf6a2b318 ("batman-adv: Mark debugfs functionality as
deprecated") introduced various messages to inform the user about the
deprecation of the debugfs based functionality. The messages also include
the context/task in which this problem was observed.

The datastructures and functions to access this information require special
headers. These should be included directly instead of depending on a more
complex and fragile include chain.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 8b608a2e2653..d4a7702e48d8 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -19,6 +19,7 @@
 #include "debugfs.h"
 #include "main.h"
 
+#include <asm/current.h>
 #include <linux/dcache.h>
 #include <linux/debugfs.h>
 #include <linux/err.h>
@@ -27,6 +28,7 @@
 #include <linux/fs.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
+#include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/stat.h>
 #include <linux/stddef.h>
-- 
2.11.0

