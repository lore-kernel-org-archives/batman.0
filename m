Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 23 Oct 2013 18:04:58 +0200
Message-Id: <1382544303-2694-12-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1382544303-2694-1-git-send-email-antonio@meshcoding.com>
References: <1382544303-2694-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 11/16] batman-adv: send GW_DEL event in case
	of soft-iface destruction
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

In case of soft_iface destruction send a GW DEL event to
userspace so that applications which are listening for GW
events are informed about the lost of connectivity and can
react accordingly.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/hard-interface.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index c60d3ed..1ba8a55 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -28,6 +28,7 @@
 #include "originator.h"
 #include "hash.h"
 #include "bridge_loop_avoidance.h"
+#include "gateway_client.h"
 
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
@@ -535,8 +536,12 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
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
1.8.4

