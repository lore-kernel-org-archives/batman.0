Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  1 Feb 2019 12:14:10 +0100
Message-Id: <20190201111412.13807-2-sw@simonwunderlich.de>
In-Reply-To: <20190201111412.13807-1-sw@simonwunderlich.de>
References: <20190201111412.13807-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Avoid WARN on net_device
 without parent in netns
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

It is not allowed to use WARN* helpers on potential incorrect input from
the user or transient problems because systems configured as panic_on_warn
will reboot due to such a problem.

A NULL return value of __dev_get_by_index can be caused by various problems
which can either be related to the system configuration or problems
(incorrectly returned network namespaces) in other (virtual) net_device
drivers. batman-adv should not cause a (harmful) WARN in this situation and
instead only report it via a simple message.

Fixes: b7eddd0b3950 ("batman-adv: prevent using any virtual device created on batman-adv as hard-interface")
Reported-by: syzbot+c764de0fcfadca9a8595@syzkaller.appspotmail.com
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 508f4416dfc9..415d494cbe22 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -20,7 +20,6 @@
 #include "main.h"
 
 #include <linux/atomic.h>
-#include <linux/bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
@@ -179,8 +178,10 @@ static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
 	parent_dev = __dev_get_by_index((struct net *)parent_net,
 					dev_get_iflink(net_dev));
 	/* if we got a NULL parent_dev there is something broken.. */
-	if (WARN(!parent_dev, "Cannot find parent device"))
+	if (!parent_dev) {
+		pr_err("Cannot find parent device\n");
 		return false;
+	}
 
 	if (batadv_mutual_parents(net_dev, net, parent_dev, parent_net))
 		return false;
-- 
2.11.0

