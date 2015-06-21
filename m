Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2015 19:40:06 +0200
Message-Id: <1434908409-1922-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 1/4] batman-adv: Return EINVAL on invalid
	gw_bandwidth change
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

Invalid speed settings by the user are currently acknowledged as correct
but not stored. Instead the return of the store operation of the file
"gw_bandwidth" should indicate that the given value is not acceptable.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3:
 * no change
v2:
 * rebased on current master
 * add missing header linux/errno.h

 net/batman-adv/gateway_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index c50931c..6b930a6 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -19,6 +19,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/errno.h>
 #include <linux/byteorder/generic.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
@@ -160,7 +161,7 @@ ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 
 	ret = batadv_parse_gw_bandwidth(net_dev, buff, &down_new, &up_new);
 	if (!ret)
-		goto end;
+		return -EINVAL;
 
 	if (!down_new)
 		down_new = 1;
@@ -184,7 +185,6 @@ ssize_t batadv_gw_bandwidth_set(struct net_device *net_dev, char *buff,
 	atomic_set(&bat_priv->gw.bandwidth_up, up_new);
 	batadv_gw_tvlv_container_update(bat_priv);
 
-end:
 	return count;
 }
 
-- 
2.1.4

