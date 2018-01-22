Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Mon, 22 Jan 2018 20:24:50 +0100
Message-Id: <6d1b250c047fb4cd3aac72d9e921ed33428fdaf5.1516648598.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix packet checksum in
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
To: b.a.t.m.a.n@lists.open-mesh.org

skb_postpull_rcsum() is necessary after eth_type_trans() to adjust the
skb checksum, otherwise log spam of the form "bat0: hw csum failure" will
result when packets with CHECKSUM_COMPLETE are received (at least in some
setups, e.g. when stacking batman-adv on top of VXLAN).

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---

I don't know what the exact circumstances are that trigger the log spam,
but it seems this was broken forever (I could also reproduce the issue with
our compat-14 legacy branch)... so please ask David to queue this up for
stable :)


 net/batman-adv/soft-interface.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index c95e2b26..edeffcb9 100644
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
2.16.0

