Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Tue, 23 Jan 2018 10:59:49 +0100
Message-Id: <05cee97344804ffb2a8df87603663a098fd0cb36.1516701590.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCH maint v2 1/2] batman-adv: fix packet checksum
 in receive path
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

eth_type_trans() internally calls skb_pull(), which does not adjust the
skb checksum; skb_postpull_rcsum() is necessary to avoid log spam of the
form "bat0: hw csum failure" when packets with CHECKSUM_COMPLETE are
received.

Note that in usual setups, packets don't reach batman-adv with
CHECKSUM_COMPLETE (I assume NICs bail out of checksumming when they see
batadv's ethtype?), which is why the log messages do nor occur on every
system using batman-adv. I could reproduce this issue by stacking
batman-adv on top of a VXLAN interface.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 net/batman-adv/soft-interface.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 9f673cdf..6f7ce7a6 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -451,13 +451,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 
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
2.16.1

