Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 12 May 2013 22:06:05 +0200
Message-Id: <1368389165-1882-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use __constant_htons when
	possible
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
Cc: Antonio Quartulli <ordex@autistici.org>

When comparing a network ordered value with a constant, it
is better to convert the constant at compile time by means
of __constant_htons() instead of converting the value at
runtime using ntohs().

This refactoring may slightly improve the code performance.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bridge_loop_avoidance.c | 12 ++++++------
 gateway_client.c        |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 124a743..b7df579 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -863,25 +863,25 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
 	struct arphdr *arphdr;
 	uint8_t *hw_src, *hw_dst;
 	struct batadv_bla_claim_dst *bla_dst;
-	uint16_t proto;
+	__be16 proto;
 	int headlen;
 	unsigned short vid = BATADV_NO_FLAGS;
 	int ret;
 
 	ethhdr = eth_hdr(skb);
 
-	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q) {
+	if (ethhdr->h_proto == __constant_htons(ETH_P_8021Q)) {
 		vhdr = vlan_eth_hdr(skb);
 		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
 		vid |= BATADV_VLAN_HAS_TAG;
-		proto = ntohs(vhdr->h_vlan_encapsulated_proto);
+		proto = vhdr->h_vlan_encapsulated_proto;
 		headlen = sizeof(*vhdr);
 	} else {
-		proto = ntohs(ethhdr->h_proto);
+		proto = ethhdr->h_proto;
 		headlen = ETH_HLEN;
 	}
 
-	if (proto != ETH_P_ARP)
+	if (proto != __constant_htons(ETH_P_ARP))
 		return 0; /* not a claim frame */
 
 	/* this must be a ARP frame. check if it is a claim. */
@@ -1375,7 +1375,7 @@ int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 
 	ethhdr = (struct ethhdr *)(((uint8_t *)skb->data) + hdr_size);
 
-	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q) {
+	if (ethhdr->h_proto == __constant_htons(ETH_P_8021Q)) {
 		if (!pskb_may_pull(skb, hdr_size + VLAN_ETH_HLEN))
 			return 0;
 
diff --git a/gateway_client.c b/gateway_client.c
index f59e58d..3cf92f8 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -682,11 +682,11 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 
 	/* check for bootp port */
 	if ((proto == __constant_htons(ETH_P_IP)) &&
-	    (ntohs(udphdr->dest) != 67))
+	    (udphdr->dest != __constant_htons(67)))
 		return false;
 
 	if ((proto == __constant_htons(ETH_P_IPV6)) &&
-	    (ntohs(udphdr->dest) != 547))
+	    (udphdr->dest != __constant_htons(547)))
 		return false;
 
 	return true;
-- 
1.8.1.5

