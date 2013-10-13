Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 13 Oct 2013 13:22:51 +0200
Message-Id: <1381663381-626-7-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1381663381-626-1-git-send-email-antonio@meshcoding.com>
References: <1381663381-626-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 06/16] batman-adv: use VLAN_ETH_HLEN instead
	of sizeof(struct vlan_eth_hdr)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <ordex@autistici.org>

From: Antonio Quartulli <ordex@autistici.org>

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 264de88..70da18a 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1380,7 +1380,7 @@ int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 	ethhdr = (struct ethhdr *)(((uint8_t *)skb->data) + hdr_size);
 
 	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q) {
-		if (!pskb_may_pull(skb, hdr_size + sizeof(struct vlan_ethhdr)))
+		if (!pskb_may_pull(skb, hdr_size + VLAN_ETH_HLEN))
 			return 0;
 
 		vhdr = (struct vlan_ethhdr *)(skb->data + hdr_size);
-- 
1.8.3.2

