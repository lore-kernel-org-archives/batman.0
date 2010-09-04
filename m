Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 00:44:30 +0200
Message-Id: <1283640270-30498-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283639100-6506-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283639100-6506-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Don't double free unicast skb
	on failure
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
To: b.a.t.m.a.n@lists.open-mesh.org

The soft-interface transmission function expects that the unicast skb is
still available when a send failed. This is not true on failed search
for a router. Thus we would try to free the skb twice and create many
different and hard to debug memory access failures due to access on not
(anymore) allocated memory.

Reported-by: Andreas Langer <an.langer@gmx.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
I decided that it makes more sense that the called function frees the data.
This makes it similar to dev_queue_xmit or our send_skb_packet. This also
fixes the problem with fragmented unicast packets

 soft-interface.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 38134ae..47e5ada 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -182,7 +182,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	} else {
 		ret = unicast_send_skb(skb, bat_priv);
 		if (ret != 0)
-			goto dropped;
+			goto dropped_freed;
 	}
 
 	bat_priv->stats.tx_packets++;
@@ -190,8 +190,9 @@ int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	goto end;
 
 dropped:
-	bat_priv->stats.tx_dropped++;
 	kfree_skb(skb);
+dropped_freed:
+	bat_priv->stats.tx_dropped++;
 end:
 	return NETDEV_TX_OK;
 }
-- 
1.7.1

