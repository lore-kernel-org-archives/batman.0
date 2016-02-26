Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 Feb 2016 17:56:13 +0100
Message-Id: <1456505773-1059-1-git-send-email-sven@narfation.org>
In-Reply-To: <b.a.t.m.a.n@lists.open-mesh.org>
References: <b.a.t.m.a.n@lists.open-mesh.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Check skb size before using
	encapsulated ETH+VLAN header
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

The encapsulated ethernet and VLAN header may be outside the received
ethernet frame. Thus the skb buffer size has to be checked before it can be
parsed to find out if it encapsulates another batman-adv packet.

Fixes: 48628bb9419f ("batman-adv: softif bridge loop avoidance")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 0710379..8a136b6 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -408,11 +408,17 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	 */
 	nf_reset(skb);
 
+	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
+		goto dropped;
+
 	vid = batadv_get_vid(skb, 0);
 	ethhdr = eth_hdr(skb);
 
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_8021Q:
+		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
+			goto dropped;
+
 		vhdr = (struct vlan_ethhdr *)skb->data;
 
 		if (vhdr->h_vlan_encapsulated_proto != ethertype)
@@ -424,8 +430,6 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	}
 
 	/* skb->dev & skb->pkt_type are set here */
-	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
-		goto dropped;
 	skb->protocol = eth_type_trans(skb, soft_iface);
 
 	/* should not be necessary anymore as we use skb_pull_rcsum()
-- 
2.7.0

