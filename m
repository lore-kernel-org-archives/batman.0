Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue,  8 Nov 2016 17:45:10 +0100
Message-Id: <20161108164526.7518-2-sw@simonwunderlich.de>
In-Reply-To: <20161108164526.7518-1-sw@simonwunderlich.de>
References: <20161108164526.7518-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 01/17] batman-adv: Introduce missing headers
	for genetlink restructure
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Fixes: 56989f6d8568 ("genetlink: mark families as __ro_after_init")
Fixes: 2ae0f17df1cd ("genetlink: use idr to track families")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 005012b..2171281 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -20,11 +20,14 @@
 
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
+#include <linux/cache.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/fs.h>
 #include <linux/genetlink.h>
 #include <linux/if_ether.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/printk.h>
-- 
2.10.1

