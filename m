Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 13 Jun 2017 13:37:00 +0200
Message-Id: <20170613113700.31220-11-sw@simonwunderlich.de>
In-Reply-To: <20170613113700.31220-1-sw@simonwunderlich.de>
References: <20170613113700.31220-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 10/10] batman-adv: Accept only filled wifi
 station info
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

The wifi driver can decide to not provide parts of the station info. For
example, the expected throughput of the station can be omitted when the
used rate control doesn't provide this kind of information.

The B.A.T.M.A.N. V implementation must therefore check the filled bitfield
before it tries to access the expected_throughput of the returned
station_info.

Reported-by: Alvaro Antelo <alvaro.antelo@gmail.com>
Fixes: c833484e5f38 ("batman-adv: ELP - compute the metric based on the estimated throughput")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Reviewed-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 96e7333764f0..b58007b79e3a 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -19,6 +19,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -29,6 +30,7 @@
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/netdevice.h>
+#include <linux/nl80211.h>
 #include <linux/random.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -111,6 +113,8 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 		}
 		if (ret)
 			goto default_throughput;
+		if (!(sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)))
+			goto default_throughput;
 
 		return sinfo.expected_throughput / 100;
 	}
-- 
2.11.0

