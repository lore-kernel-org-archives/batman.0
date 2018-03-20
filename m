Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 20 Mar 2018 04:36:01 +0100
Message-Id: <20180320033601.1728-2-linus.luessing@c0d3.blue>
In-Reply-To: <20180320033601.1728-1-linus.luessing@c0d3.blue>
References: <20180320033601.1728-1-linus.luessing@c0d3.blue>
Subject: [B.A.T.M.A.N.] [RFC PATCH maint 2/2] batman-adv: fix
 gateway-out-of-range check
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

The gateway feature is supposed to drop DHCP packet from a client to a
server which was transmitted via unicast if the client's selected gateway
is not the best one anymore and the difference in TQ dropped below a
certain threshold.

This will trigger the DHCP client to resend its DHCP packet via
broadcast/multicast allowing us to forward it to the new, best gateway.

Unfortunately, the gateway-out-of-range check was actually never applied
to unicasted packets so far. Resulting in unhealthily clingy DHCP
clients.

Fixing this by parsing DHCP packets not only for multicasted but also
unicasted ones.

Fixes: afae4e42aae6 ("batman-adv: refactoring gateway handling code")
Not-yet-signed-off-because-untested
---
 net/batman-adv/gateway_client.c | 10 ++++++++--
 net/batman-adv/gateway_client.h |  4 ++--
 net/batman-adv/soft-interface.c | 31 ++++++++++++++-----------------
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index e7a245bd..67dc5642 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -608,6 +608,7 @@ int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb)
 
 /**
  * batadv_gw_dhcp_recipient_get() - check if a packet is a DHCP message
+ * @bat_priv: the bat priv with all the soft interface information
  * @skb: the packet to check
  * @header_len: a pointer to the batman-adv header size
  * @chaddr: buffer where the client address will be stored. Valid
@@ -622,8 +623,8 @@ int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * - BATADV_DHCP_TO_CLIENT if this is a message going to a DHCP client
  */
 enum batadv_dhcp_recipient
-batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
-			     u8 *chaddr)
+batadv_gw_dhcp_recipient_get(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			     unsigned int *header_len, u8 *chaddr)
 {
 	enum batadv_dhcp_recipient ret = BATADV_DHCP_NO;
 	struct ethhdr *ethhdr;
@@ -633,8 +634,13 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 	struct vlan_ethhdr *vhdr;
 	int chaddr_offset;
 	__be16 proto;
+	int gw_mode;
 	u8 *p;
 
+	gw_mode = atomic_read(&bat_priv->gw.mode);
+	if (gw_mode == BATADV_GW_MODE_OFF)
+		return BATADV_DHCP_NO;
+
 	/* check for ethernet header */
 	if (!pskb_may_pull(skb, *header_len + ETH_HLEN))
 		return BATADV_DHCP_NO;
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index f0b86fcb..2451e1fe 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -48,8 +48,8 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb);
 bool batadv_gw_out_of_range(struct batadv_priv *bat_priv, struct sk_buff *skb);
 enum batadv_dhcp_recipient
-batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
-			     u8 *chaddr);
+batadv_gw_dhcp_recipient_get(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			     unsigned int *header_len, u8 *chaddr);
 struct batadv_gw_node *batadv_gw_node_get(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node);
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index edeffcb9..4f9e1440 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -268,20 +268,14 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	if (batadv_compare_eth(ethhdr->h_dest, ectp_addr))
 		goto dropped;
 
-	gw_mode = atomic_read(&bat_priv->gw.mode);
-	if (is_multicast_ether_addr(ethhdr->h_dest)) {
-		/* if gw mode is off, broadcast every packet */
-		if (gw_mode == BATADV_GW_MODE_OFF) {
-			do_bcast = true;
-			goto send;
-		}
+	dhcp_rcp = batadv_gw_dhcp_recipient_get(bat_priv, skb, &header_len,
+						chaddr);
+	/* skb->data may have been modified by
+	 * batadv_gw_dhcp_recipient_get()
+	 */
+	ethhdr = eth_hdr(skb);
 
-		dhcp_rcp = batadv_gw_dhcp_recipient_get(skb, &header_len,
-							chaddr);
-		/* skb->data may have been modified by
-		 * batadv_gw_dhcp_recipient_get()
-		 */
-		ethhdr = eth_hdr(skb);
+	if (is_multicast_ether_addr(ethhdr->h_dest)) {
 		/* if gw_mode is on, broadcast any non-DHCP message.
 		 * All the DHCP packets are going to be sent as unicast
 		 */
@@ -290,14 +284,17 @@ static int batadv_interface_tx(struct sk_buff *skb,
 			goto send;
 		}
 
-		if (dhcp_rcp == BATADV_DHCP_TO_CLIENT)
+		if (dhcp_rcp == BATADV_DHCP_TO_CLIENT) {
 			dst_hint = chaddr;
-		else if ((gw_mode == BATADV_GW_MODE_SERVER) &&
-			 (dhcp_rcp == BATADV_DHCP_TO_SERVER))
+		} else if (dhcp_rcp == BATADV_DHCP_TO_SERVER) {
 			/* gateways should not forward any DHCP message if
 			 * directed to a DHCP server
 			 */
-			goto dropped;
+			gw_mode = atomic_read(&bat_priv->gw.mode);
+
+			if (gw_mode == BATADV_GW_MODE_SERVER)
+				goto dropped;
+		}
 
 send:
 		if (do_bcast && !is_broadcast_ether_addr(ethhdr->h_dest)) {
-- 
2.11.0

