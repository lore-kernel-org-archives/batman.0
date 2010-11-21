Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 00:55:40 +0100
Message-Id: <1290383767-32602-3-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 02/29] Staging: batman-adv: ensure that
	eth_type_trans gets linear memory
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

eth_type_trans tries to pull data with the length of the ethernet header
from the skb. We only ensured that enough data for the first ethernet
header and the batman header is available in non-paged memory of the skb
and not for the ethernet after the batman header.

eth_type_trans would fail sometimes with drivers which don't ensure that
all there data is perfectly linearised.

Reported-by: Rafal Lesniak <lesniak@eresi-project.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/soft-interface.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index 3904db9..0e99618 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -194,14 +194,15 @@ void interface_rx(struct net_device *soft_iface,
 	struct bat_priv *priv = netdev_priv(soft_iface);
 
 	/* check if enough space is available for pulling, and pull */
-	if (!pskb_may_pull(skb, hdr_size)) {
-		kfree_skb(skb);
-		return;
-	}
+	if (!pskb_may_pull(skb, hdr_size))
+		goto dropped;
+
 	skb_pull_rcsum(skb, hdr_size);
 /*	skb_set_mac_header(skb, -sizeof(struct ethhdr));*/
 
 	/* skb->dev & skb->pkt_type are set here */
+	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
+		goto dropped;
 	skb->protocol = eth_type_trans(skb, soft_iface);
 
 	/* should not be neccesary anymore as we use skb_pull_rcsum()
@@ -216,6 +217,11 @@ void interface_rx(struct net_device *soft_iface,
 	soft_iface->last_rx = jiffies;
 
 	netif_rx(skb);
+	return;
+
+dropped:
+	kfree_skb(skb);
+	return;
 }
 
 #ifdef HAVE_NET_DEVICE_OPS
-- 
1.7.2.3

