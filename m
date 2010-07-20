Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 21 Jul 2010 00:25:20 +0200
Message-Id: <1279664722-27500-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1279664722-27500-1-git-send-email-sven.eckelmann@gmx.de>
References: <1279664722-27500-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] Staging: batman-adv: Don't increment
	stats of foreign device
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net

The receive hook for batman-adv ethernet frames tried to get the last
device which processed the skb before us. It only used that information
to update the rx_bytes and rx_packets stat of that foreign device which
already has updated it using its own receive functions.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/hard-interface.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index 5cc369c..f6345c4 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -442,7 +442,6 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct batman_packet *batman_packet;
 	struct batman_if *batman_if;
-	struct net_device_stats *stats;
 	int ret;
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
@@ -478,12 +477,6 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (batman_if->if_status != IF_ACTIVE)
 		goto err_free;
 
-	stats = (struct net_device_stats *)dev_get_stats(skb->dev);
-	if (stats) {
-		stats->rx_packets++;
-		stats->rx_bytes += skb->len;
-	}
-
 	batman_packet = (struct batman_packet *)skb->data;
 
 	if (batman_packet->version != COMPAT_VERSION) {
-- 
1.7.1

