Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 12 May 2013 21:51:15 +0200
Message-Id: <1368388275-1383-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: h_vlan_encapsulated_proto
	access refactoring
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

In the gateway code in case of VLAN tagged frame the ethhdr
pointer is moved forward by 4 bytes so that the offset of
h_proto in struct ethhdr matches the real
h_vlan_encapsulated_proto address in the skb.

This trick is correct but the code is not easy to understand
and may lead to bugs in case of re-use of ethhdr for other
purposes.

Do some code refactoring in order to make it easier to
understand and to change in the future.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2:
- slightly change the commit subject and message
- use __constant_htons() when comparing proto with constants



 gateway_client.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 973f02d..f59e58d 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -626,24 +626,30 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 	struct iphdr *iphdr;
 	struct ipv6hdr *ipv6hdr;
 	struct udphdr *udphdr;
+	__be16 proto;
 
 	/* check for ethernet header */
 	if (!pskb_may_pull(skb, *header_len + ETH_HLEN))
 		return false;
 	ethhdr = (struct ethhdr *)skb->data;
+	proto = ethhdr->h_proto;
 	*header_len += ETH_HLEN;
 
 	/* check for initial vlan header */
-	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q) {
+	if (proto == __constant_htons(ETH_P_8021Q)) {
+		struct vlan_ethhdr *vhdr;
+
 		if (!pskb_may_pull(skb, *header_len + VLAN_HLEN))
 			return false;
-		ethhdr = (struct ethhdr *)(skb->data + VLAN_HLEN);
+
+		vhdr = (struct vlan_ethhdr *)skb->data;
+		proto = vhdr->h_vlan_encapsulated_proto;
 		*header_len += VLAN_HLEN;
 	}
 
 	/* check for ip header */
-	switch (ntohs(ethhdr->h_proto)) {
-	case ETH_P_IP:
+	switch (proto) {
+	case __constant_htons(ETH_P_IP):
 		if (!pskb_may_pull(skb, *header_len + sizeof(*iphdr)))
 			return false;
 		iphdr = (struct iphdr *)(skb->data + *header_len);
@@ -654,7 +660,7 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 			return false;
 
 		break;
-	case ETH_P_IPV6:
+	case __constant_htons(ETH_P_IPV6):
 		if (!pskb_may_pull(skb, *header_len + sizeof(*ipv6hdr)))
 			return false;
 		ipv6hdr = (struct ipv6hdr *)(skb->data + *header_len);
@@ -675,11 +681,11 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 	*header_len += sizeof(*udphdr);
 
 	/* check for bootp port */
-	if ((ntohs(ethhdr->h_proto) == ETH_P_IP) &&
+	if ((proto == __constant_htons(ETH_P_IP)) &&
 	    (ntohs(udphdr->dest) != 67))
 		return false;
 
-	if ((ntohs(ethhdr->h_proto) == ETH_P_IPV6) &&
+	if ((proto == __constant_htons(ETH_P_IPV6)) &&
 	    (ntohs(udphdr->dest) != 547))
 		return false;
 
-- 
1.8.1.5

