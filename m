Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 19 Aug 2013 18:39:59 +0200
Message-Id: <1376930399-1043-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: send GW_DEL event in case of
	soft-iface destruction
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

In case of soft_iface destruction send a GW DEL event to
userspace so that applications which are listening for GW
events are informed about the lost of connectivity and can
react accordingly.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 hard-interface.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index c5f871f..8a42745 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -28,6 +28,7 @@
 #include "originator.h"
 #include "hash.h"
 #include "bridge_loop_avoidance.h"
+#include "gateway_client.h"
 
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
@@ -524,8 +525,12 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 	dev_put(hard_iface->soft_iface);
 
 	/* nobody uses this interface anymore */
-	if (!bat_priv->num_ifaces && autodel == BATADV_IF_CLEANUP_AUTO)
-		batadv_softif_destroy_sysfs(hard_iface->soft_iface);
+	if (!bat_priv->num_ifaces) {
+		batadv_gw_check_client_stop(bat_priv);
+
+		if (autodel == BATADV_IF_CLEANUP_AUTO)
+			batadv_softif_destroy_sysfs(hard_iface->soft_iface);
+	}
 
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->soft_iface);
 	hard_iface->soft_iface = NULL;
-- 
1.8.1.5

