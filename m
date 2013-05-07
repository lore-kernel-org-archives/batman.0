Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  7 May 2013 13:54:02 +0200
Message-Id: <1367927642-3223-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: access h_vlan_encapsulated_proto
	properly
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

Use a standalone protocol variable and assign it accordingly
to the header type

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 gateway_client.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 973f02d..8ea13e1 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -626,23 +626,29 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 	struct iphdr *iphdr;
 	struct ipv6hdr *ipv6hdr;
 	struct udphdr *udphdr;
+	uint16_t proto;
 
 	/* check for ethernet header */
 	if (!pskb_may_pull(skb, *header_len + ETH_HLEN))
 		return false;
 	ethhdr = (struct ethhdr *)skb->data;
+	proto = ntohs(ethhdr->h_proto);
 	*header_len += ETH_HLEN;
 
 	/* check for initial vlan header */
-	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q) {
+	if (proto == ETH_P_8021Q) {
+		struct vlan_ethhdr *vhdr;
+
 		if (!pskb_may_pull(skb, *header_len + VLAN_HLEN))
 			return false;
-		ethhdr = (struct ethhdr *)(skb->data + VLAN_HLEN);
+
+		vhdr = (struct vlan_ethhdr *)skb->data;
+		proto = ntohs(vhdr->h_vlan_encapsulated_proto);
 		*header_len += VLAN_HLEN;
 	}
 
 	/* check for ip header */
-	switch (ntohs(ethhdr->h_proto)) {
+	switch (proto) {
 	case ETH_P_IP:
 		if (!pskb_may_pull(skb, *header_len + sizeof(*iphdr)))
 			return false;
@@ -675,11 +681,11 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 	*header_len += sizeof(*udphdr);
 
 	/* check for bootp port */
-	if ((ntohs(ethhdr->h_proto) == ETH_P_IP) &&
+	if ((proto == ETH_P_IP) &&
 	    (ntohs(udphdr->dest) != 67))
 		return false;
 
-	if ((ntohs(ethhdr->h_proto) == ETH_P_IPV6) &&
+	if ((proto == ETH_P_IPV6) &&
 	    (ntohs(udphdr->dest) != 547))
 		return false;
 
-- 
1.8.1.5

