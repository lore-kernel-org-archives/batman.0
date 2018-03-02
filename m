Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  2 Mar 2018 18:51:36 +0100
Message-Id: <20180302175142.11838-2-sw@simonwunderlich.de>
In-Reply-To: <20180302175142.11838-1-sw@simonwunderlich.de>
References: <20180302175142.11838-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/7] batman-adv: fix packet checksum in
 receive path
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Matthias Schiffer <mschiffer@universe-factory.net>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Matthias Schiffer <mschiffer@universe-factory.net>

eth_type_trans() internally calls skb_pull(), which does not adjust the
skb checksum; skb_postpull_rcsum() is necessary to avoid log spam of the
form "bat0: hw csum failure" when packets with CHECKSUM_COMPLETE are
received.

Note that in usual setups, packets don't reach batman-adv with
CHECKSUM_COMPLETE (I assume NICs bail out of checksumming when they see
batadv's ethtype?), which is why the log messages do not occur on every
system using batman-adv. I could reproduce this issue by stacking
batman-adv on top of a VXLAN interface.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Tested-by: Maximilian Wilhelm <max@sdn.clinic>
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/soft-interface.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 900c5ce21cd4..367a81fb785f 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -459,13 +459,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 
 	/* skb->dev & skb->pkt_type are set here */
 	skb->protocol = eth_type_trans(skb, soft_iface);
-
-	/* should not be necessary anymore as we use skb_pull_rcsum()
-	 * TODO: please verify this and remove this TODO
-	 * -- Dec 21st 2009, Simon Wunderlich
-	 */
-
-	/* skb->ip_summed = CHECKSUM_UNNECESSARY; */
+	skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_RX);
 	batadv_add_counter(bat_priv, BATADV_CNT_RX_BYTES,
-- 
2.11.0

