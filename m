Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 28 Jun 2012 11:34:24 +0200
Message-Id: <1340876067-28333-16-git-send-email-ordex@autistici.org>
In-Reply-To: <1340876067-28333-1-git-send-email-ordex@autistici.org>
References: <1340876067-28333-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 15/18] batman-adv: Prefix types defines with
	BATADV_
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/hard-interface.c |   11 ++++++-----
 net/batman-adv/soft-interface.c |    2 +-
 net/batman-adv/types.h          |    9 ++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 3401084..9b1cb23 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -196,7 +196,8 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
 		if (hard_iface->soft_iface != soft_iface)
 			continue;
 
-		min_mtu = min_t(int, hard_iface->net_dev->mtu - BAT_HEADER_LEN,
+		min_mtu = min_t(int,
+				hard_iface->net_dev->mtu - BATADV_HEADER_LEN,
 				min_mtu);
 	}
 	rcu_read_unlock();
@@ -320,18 +321,18 @@ int batadv_hardif_enable_interface(struct hard_iface *hard_iface,
 		    hard_iface->net_dev->name);
 
 	if (atomic_read(&bat_priv->fragmentation) && hard_iface->net_dev->mtu <
-		ETH_DATA_LEN + BAT_HEADER_LEN)
+		ETH_DATA_LEN + BATADV_HEADER_LEN)
 		batadv_info(hard_iface->soft_iface,
 			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to %zi would solve the problem.\n",
 			    hard_iface->net_dev->name, hard_iface->net_dev->mtu,
-			    ETH_DATA_LEN + BAT_HEADER_LEN);
+			    ETH_DATA_LEN + BATADV_HEADER_LEN);
 
 	if (!atomic_read(&bat_priv->fragmentation) && hard_iface->net_dev->mtu <
-		ETH_DATA_LEN + BAT_HEADER_LEN)
+		ETH_DATA_LEN + BATADV_HEADER_LEN)
 		batadv_info(hard_iface->soft_iface,
 			    "The MTU of interface %s is too small (%i) to handle the transport of batman-adv packets. If you experience problems getting traffic through try increasing the MTU to %zi.\n",
 			    hard_iface->net_dev->name, hard_iface->net_dev->mtu,
-			    ETH_DATA_LEN + BAT_HEADER_LEN);
+			    ETH_DATA_LEN + BATADV_HEADER_LEN);
 
 	if (batadv_hardif_is_iface_up(hard_iface))
 		batadv_hardif_activate_interface(hard_iface);
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index e726419..bbbc9a9 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -351,7 +351,7 @@ static void batadv_interface_setup(struct net_device *dev)
 	 */
 	dev->mtu = ETH_DATA_LEN;
 	/* reserve more space in the skbuff for our header */
-	dev->hard_header_len = BAT_HEADER_LEN;
+	dev->hard_header_len = BATADV_HEADER_LEN;
 
 	/* generate random address */
 	eth_hw_addr_random(dev);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 053c5d4..1d5d21e 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -22,12 +22,11 @@
 
 #include "packet.h"
 #include "bitarray.h"
+#include <linux/kernel.h>
 
-#define BAT_HEADER_LEN (ETH_HLEN + \
-	((sizeof(struct unicast_packet) > sizeof(struct bcast_packet) ? \
-	 sizeof(struct unicast_packet) : \
-	 sizeof(struct bcast_packet))))
-
+#define BATADV_HEADER_LEN \
+	(ETH_HLEN + max(sizeof(struct unicast_packet), \
+			sizeof(struct bcast_packet)))
 
 struct hard_iface {
 	struct list_head list;
-- 
1.7.9.4

