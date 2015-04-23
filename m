Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 23 Apr 2015 18:22:25 +0200
Message-Id: <1429806145-28753-2-git-send-email-sven@narfation.org>
In-Reply-To: <1429806145-28753-1-git-send-email-sven@narfation.org>
References: <1429806145-28753-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Remove unused post-VLAN
	ethhdr in batadv_gw_dhcp_recipient_get
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
To: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_client.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 14f0a22..bb01586 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -753,11 +753,6 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 	if (!pskb_may_pull(skb, *header_len + sizeof(*udphdr)))
 		return BATADV_DHCP_NO;
 
-	/* skb->data might have been reallocated by pskb_may_pull() */
-	ethhdr = eth_hdr(skb);
-	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q)
-		ethhdr = (struct ethhdr *)(skb->data + VLAN_HLEN);
-
 	udphdr = (struct udphdr *)(skb->data + *header_len);
 	*header_len += sizeof(*udphdr);
 
-- 
2.1.4

