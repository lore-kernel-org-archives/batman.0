Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5/5] batman-adv: Drop lockdep.h include for soft-interface.c
Date: Tue,  5 Nov 2019 10:35:31 +0100
Message-Id: <20191105093531.11398-6-sw@simonwunderlich.de>
In-Reply-To: <20191105093531.11398-1-sw@simonwunderlich.de>
References: <20191105093531.11398-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The commit ab92d68fc22f ("net: core: add generic lockdep keys") removed
all lockdep functionality from soft-interface.c but didn't remove the
include for this functionality.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/soft-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 697f2da12487..832e156c519e 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -22,7 +22,6 @@
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
-#include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/percpu.h>
-- 
2.20.1

