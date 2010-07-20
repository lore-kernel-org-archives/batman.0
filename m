Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 20 Jul 2010 23:42:24 +0200
Message-Id: <1279662144-17356-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't increment stats of foreign
	device
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
To: b.a.t.m.a.n@lists.open-mesh.net

The receive hook for batman-adv ethernet frames tried to get the last
device which processed the skb before us. It only used that information
to update the rx_bytes and rx_packets stat of that foreign device which
already has updated it using its own receive functions.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/compat.h         |    8 --------
 batman-adv/hard-interface.c |    8 --------
 2 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/batman-adv/compat.h b/batman-adv/compat.h
index 103593d..09016c8 100644
--- a/batman-adv/compat.h
+++ b/batman-adv/compat.h
@@ -249,12 +249,4 @@ static inline struct net_device_stats *dev_get_stats(struct net_device *dev)
 
 #endif /* < KERNEL_VERSION(2, 6, 29) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
-
-#define dev_get_stats(x, y) dev_get_stats(x)
-
-#define rtnl_link_stats64 rtnl_link_stats __attribute__((unused))
-
-#endif /* < KERNEL_VERSION(2, 6, 36) */
-
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index a072c3d..fdabe4f 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -471,8 +471,6 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct batman_packet *batman_packet;
 	struct batman_if *batman_if;
-	struct net_device_stats *stats;
-	struct rtnl_link_stats64 temp;
 	int ret;
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
@@ -508,12 +506,6 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (batman_if->if_status != IF_ACTIVE)
 		goto err_free;
 
-	stats = (struct net_device_stats *)dev_get_stats(skb->dev, &temp);
-	if (stats) {
-		stats->rx_packets++;
-		stats->rx_bytes += skb->len;
-	}
-
 	batman_packet = (struct batman_packet *)skb->data;
 
 	if (batman_packet->version != COMPAT_VERSION) {
-- 
1.7.1

