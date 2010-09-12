Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 12 Sep 2010 23:21:55 +0200
Message-Id: <1284326516-30540-5-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284326516-30540-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284326516-30540-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 4/5] Staging: batman-adv: removing redundant
	assignment of skb->dev
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/soft-interface.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index 8d14343..3904db9 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -201,7 +201,7 @@ void interface_rx(struct net_device *soft_iface,
 	skb_pull_rcsum(skb, hdr_size);
 /*	skb_set_mac_header(skb, -sizeof(struct ethhdr));*/
 
-	skb->dev = soft_iface;
+	/* skb->dev & skb->pkt_type are set here */
 	skb->protocol = eth_type_trans(skb, soft_iface);
 
 	/* should not be neccesary anymore as we use skb_pull_rcsum()
@@ -210,9 +210,6 @@ void interface_rx(struct net_device *soft_iface,
 
 /*	skb->ip_summed = CHECKSUM_UNNECESSARY;*/
 
-	/* TODO: set skb->pkt_type to PACKET_BROADCAST, PACKET_MULTICAST,
-	 * PACKET_OTHERHOST or PACKET_HOST */
-
 	priv->stats.rx_packets++;
 	priv->stats.rx_bytes += skb->len + sizeof(struct ethhdr);
 
-- 
1.7.2.3

