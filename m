Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 19 May 2013 12:55:16 +0200
Message-Id: <1368960916-861-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4] batman-adv: use htons when possible
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
of htons() instead of converting the value at runtime using
ntohs().

This refactoring may slightly improve the code performance.

Moreover substitute __constant_htons() with htons() since
the latter increase readability and it is smart enough to be
as efficient as the former

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2:
- patch rebased on top of
"batman-adv: use VLAN_ETH_HLEN instead of sizeof(struct vlan_eth_hdr)"

v3:
- use __constant* for vlan_insert_tag() argument

v4:
- use htons instead of __constant_htons

 bridge_loop_avoidance.c | 12 ++++++------
 gateway_client.c        | 14 +++++++-------
 hard-interface.c        |  2 +-
 send.c                  |  4 ++--
 soft-interface.c        |  4 ++--
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 9e691b0..ab537ec 100644
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
+	if (ethhdr->h_proto == htons(ETH_P_8021Q)) {
 		vhdr = (struct vlan_ethhdr *)ethhdr;
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
+	if (proto != htons(ETH_P_ARP))
 		return 0; /* not a claim frame */
 
 	/* this must be a ARP frame. check if it is a claim. */
@@ -1375,7 +1375,7 @@ int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 
 	ethhdr = (struct ethhdr *)(((uint8_t *)skb->data) + hdr_size);
 
-	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q) {
+	if (ethhdr->h_proto == htons(ETH_P_8021Q)) {
 		if (!pskb_may_pull(skb, hdr_size + VLAN_ETH_HLEN))
 			return 0;
 
diff --git a/gateway_client.c b/gateway_client.c
index 3a27408..131136f 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -637,7 +637,7 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 	*header_len += ETH_HLEN;
 
 	/* check for initial vlan header */
-	if (proto == __constant_htons(ETH_P_8021Q)) {
+	if (proto == htons(ETH_P_8021Q)) {
 		if (!pskb_may_pull(skb, *header_len + VLAN_HLEN))
 			return false;
 
@@ -648,7 +648,7 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 
 	/* check for ip header */
 	switch (proto) {
-	case __constant_htons(ETH_P_IP):
+	case htons(ETH_P_IP):
 		if (!pskb_may_pull(skb, *header_len + sizeof(*iphdr)))
 			return false;
 		iphdr = (struct iphdr *)(skb->data + *header_len);
@@ -659,7 +659,7 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 			return false;
 
 		break;
-	case __constant_htons(ETH_P_IPV6):
+	case htons(ETH_P_IPV6):
 		if (!pskb_may_pull(skb, *header_len + sizeof(*ipv6hdr)))
 			return false;
 		ipv6hdr = (struct ipv6hdr *)(skb->data + *header_len);
@@ -680,12 +680,12 @@ bool batadv_gw_is_dhcp_target(struct sk_buff *skb, unsigned int *header_len)
 	*header_len += sizeof(*udphdr);
 
 	/* check for bootp port */
-	if ((proto == __constant_htons(ETH_P_IP)) &&
-	    (ntohs(udphdr->dest) != 67))
+	if ((proto == htons(ETH_P_IP)) &&
+	    (udphdr->dest != htons(67)))
 		return false;
 
-	if ((proto == __constant_htons(ETH_P_IPV6)) &&
-	    (ntohs(udphdr->dest) != 547))
+	if ((proto == htons(ETH_P_IPV6)) &&
+	    (udphdr->dest != htons(547)))
 		return false;
 
 	return true;
diff --git a/hard-interface.c b/hard-interface.c
index 9746600..5edbe52 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -379,7 +379,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 {
 	struct batadv_priv *bat_priv;
 	struct net_device *soft_iface, *master;
-	__be16 ethertype = __constant_htons(ETH_P_BATMAN);
+	__be16 ethertype = htons(ETH_P_BATMAN);
 	int ret;
 
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
diff --git a/send.c b/send.c
index 23c7f79..f2ec99c 100644
--- a/send.c
+++ b/send.c
@@ -63,11 +63,11 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 	ethhdr = eth_hdr(skb);
 	memcpy(ethhdr->h_source, hard_iface->net_dev->dev_addr, ETH_ALEN);
 	memcpy(ethhdr->h_dest, dst_addr, ETH_ALEN);
-	ethhdr->h_proto = __constant_htons(ETH_P_BATMAN);
+	ethhdr->h_proto = htons(ETH_P_BATMAN);
 
 	skb_set_network_header(skb, ETH_HLEN);
 	skb->priority = TC_PRIO_CONTROL;
-	skb->protocol = __constant_htons(ETH_P_BATMAN);
+	skb->protocol = htons(ETH_P_BATMAN);
 
 	skb->dev = hard_iface->net_dev;
 
diff --git a/soft-interface.c b/soft-interface.c
index a6ab9e4..4696142 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -147,7 +147,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_bcast_packet *bcast_packet;
 	struct vlan_ethhdr *vhdr;
-	__be16 ethertype = __constant_htons(ETH_P_BATMAN);
+	__be16 ethertype = htons(ETH_P_BATMAN);
 	static const uint8_t stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00,
 						   0x00, 0x00};
 	static const uint8_t ectp_addr[ETH_ALEN] = {0xCF, 0x00, 0x00, 0x00,
@@ -304,7 +304,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	struct vlan_ethhdr *vhdr;
 	struct batadv_header *batadv_header = (struct batadv_header *)skb->data;
 	unsigned short vid __maybe_unused = BATADV_NO_FLAGS;
-	__be16 ethertype = __constant_htons(ETH_P_BATMAN);
+	__be16 ethertype = htons(ETH_P_BATMAN);
 	bool is_bcast;
 
 	is_bcast = (batadv_header->packet_type == BATADV_BCAST);
-- 
1.8.1.5

