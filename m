Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 13 Jun 2017 13:36:56 +0200
Message-Id: <20170613113700.31220-7-sw@simonwunderlich.de>
In-Reply-To: <20170613113700.31220-1-sw@simonwunderlich.de>
References: <20170613113700.31220-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 06/10] batman-adv: tp_meter: mark init
 function with __init
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Antonio Quartulli <a@unstable.cc>

batadv_tp_meter_init() is invoked in batadv_init() only
which is marked with __init.

For this reason batadv_tp_meter_init() can be marked with
__init as well and dropped after module load.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 556f9a865ddf..e3e2585d0977 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -27,6 +27,7 @@
 #include <linux/etherdevice.h>
 #include <linux/fs.h>
 #include <linux/if_ether.h>
+#include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
@@ -1497,7 +1498,7 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 /**
  * batadv_tp_meter_init - initialize global tp_meter structures
  */
-void batadv_tp_meter_init(void)
+void __init batadv_tp_meter_init(void)
 {
 	get_random_bytes(batadv_tp_prerandom, sizeof(batadv_tp_prerandom));
 }
-- 
2.11.0

