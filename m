Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 22 Mar 2014 09:56:02 +0100
Message-Id: <1395478576-10999-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395478576-10999-1-git-send-email-antonio@meshcoding.com>
References: <1395478576-10999-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 02/16] batman-adv: use vlan_/eth_hdr()
	instead of skb->data in interface_tx path
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Linus Lüssing <linus.luessing@web.de>

Our .ndo_start_xmit handler (batadv_interface_tx()) can rely on having
the skb mac header pointer set correctly since the following commit
present in kernels >= 3.9:

"net: reset mac header in dev_start_xmit()" (6d1ccff627)

Therefore we can safely use eth_hdr() and vlan_eth_hdr() instead of
skb->data now, which spares us some ugly type casts.

At the same time set the mac_header in batadv_dat_snoop_incoming_arp_request()
before sending the skb along the TX path.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/bridge_loop_avoidance.c |  2 +-
 net/batman-adv/distributed-arp-table.c |  5 +++++
 net/batman-adv/gateway_client.c        |  6 +++---
 net/batman-adv/send.c                  | 11 +++++------
 net/batman-adv/soft-interface.c        |  8 ++++----
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 05f0712..73d8372 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -882,7 +882,7 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
 	proto = ethhdr->h_proto;
 	headlen = ETH_HLEN;
 	if (vid & BATADV_VLAN_HAS_TAG) {
-		vhdr = (struct vlan_ethhdr *)ethhdr;
+		vhdr = vlan_eth_hdr(skb);
 		proto = vhdr->h_vlan_encapsulated_proto;
 		headlen += VLAN_HLEN;
 	}
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index edee504..5bb37a8 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1027,6 +1027,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	if (!skb_new)
 		goto out;
 
+	/* the rest of the TX path assumes that the mac_header offset pointing
+	 * to the inner Ethernet header has been set, therefore reset it now.
+	 */
+	skb_reset_mac_header(skb_new);
+
 	if (vid & BATADV_VLAN_HAS_TAG)
 		skb_new = vlan_insert_tag(skb_new, htons(ETH_P_8021Q),
 					  vid & VLAN_VID_MASK);
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index d7fafc1..07c7f21 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -678,7 +678,7 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 	if (!pskb_may_pull(skb, *header_len + ETH_HLEN))
 		return BATADV_DHCP_NO;
 
-	ethhdr = (struct ethhdr *)skb->data;
+	ethhdr = eth_hdr(skb);
 	proto = ethhdr->h_proto;
 	*header_len += ETH_HLEN;
 
@@ -687,7 +687,7 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 		if (!pskb_may_pull(skb, *header_len + VLAN_HLEN))
 			return BATADV_DHCP_NO;
 
-		vhdr = (struct vlan_ethhdr *)skb->data;
+		vhdr = vlan_eth_hdr(skb);
 		proto = vhdr->h_vlan_encapsulated_proto;
 		*header_len += VLAN_HLEN;
 	}
@@ -726,7 +726,7 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 		return BATADV_DHCP_NO;
 
 	/* skb->data might have been reallocated by pskb_may_pull() */
-	ethhdr = (struct ethhdr *)skb->data;
+	ethhdr = eth_hdr(skb);
 	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q)
 		ethhdr = (struct ethhdr *)(skb->data + VLAN_HLEN);
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 843febd..1703a2e 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -256,7 +256,7 @@ static int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 {
 	struct ethhdr *ethhdr;
 	struct batadv_unicast_packet *unicast_packet;
-	int ret = NET_XMIT_DROP, hdr_size;
+	int ret = NET_XMIT_DROP;
 
 	if (!orig_node)
 		goto out;
@@ -265,16 +265,12 @@ static int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 	case BATADV_UNICAST:
 		if (!batadv_send_skb_prepare_unicast(skb, orig_node))
 			goto out;
-
-		hdr_size = sizeof(*unicast_packet);
 		break;
 	case BATADV_UNICAST_4ADDR:
 		if (!batadv_send_skb_prepare_unicast_4addr(bat_priv, skb,
 							   orig_node,
 							   packet_subtype))
 			goto out;
-
-		hdr_size = sizeof(struct batadv_unicast_4addr_packet);
 		break;
 	default:
 		/* this function supports UNICAST and UNICAST_4ADDR only. It
@@ -283,7 +279,10 @@ static int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 		goto out;
 	}
 
-	ethhdr = (struct ethhdr *)(skb->data + hdr_size);
+	/* skb->data might have been reallocated by
+	 * batadv_send_skb_prepare_unicast{,_4addr}()
+	 */
+	ethhdr = eth_hdr(skb);
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
 
 	/* inform the destination node that we are still missing a correct route
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index f82c267..c4392fc 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -176,11 +176,11 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 	soft_iface->trans_start = jiffies;
 	vid = batadv_get_vid(skb, 0);
-	ethhdr = (struct ethhdr *)skb->data;
+	ethhdr = eth_hdr(skb);
 
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_8021Q:
-		vhdr = (struct vlan_ethhdr *)skb->data;
+		vhdr = vlan_eth_hdr(skb);
 
 		if (vhdr->h_vlan_encapsulated_proto != ethertype)
 			break;
@@ -194,7 +194,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		goto dropped;
 
 	/* skb->data might have been reallocated by batadv_bla_tx() */
-	ethhdr = (struct ethhdr *)skb->data;
+	ethhdr = eth_hdr(skb);
 
 	/* Register the client MAC in the transtable */
 	if (!is_multicast_ether_addr(ethhdr->h_source)) {
@@ -230,7 +230,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 		/* skb->data may have been modified by
 		 * batadv_gw_dhcp_recipient_get()
 		 */
-		ethhdr = (struct ethhdr *)skb->data;
+		ethhdr = eth_hdr(skb);
 		/* if gw_mode is on, broadcast any non-DHCP message.
 		 * All the DHCP packets are going to be sent as unicast
 		 */
-- 
1.8.3.2

