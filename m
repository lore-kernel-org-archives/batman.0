Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Fri, 16 Mar 2018 11:29:11 +0100
Message-Id: <c09f296ac6e85467147096e656d12ddf05713216.1521196151.git.mschiffer@universe-factory.net>
In-Reply-To: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
In-Reply-To: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCH maint 3/3] batman-adv: do not modify batadv
 packet header before pulling it
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

batadv_check_unicast_ttvn() may modify the batadv header, leading to
checksum errors in the following processing of the packet.

Rather than fixing up the checksum, simply pull the batadv header before
modifying it (and push it back in case the packet is rerouted).

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 net/batman-adv/routing.c        | 38 +++++++++++++++++++++-----------------
 net/batman-adv/soft-interface.c | 10 ++--------
 net/batman-adv/soft-interface.h |  2 +-
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 0f10c565ac85..37b87fce685b 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -824,16 +824,16 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	int is_old_ttvn;
 
 	/* check if there is enough data before accessing it */
-	if (!pskb_may_pull(skb, hdr_len + ETH_HLEN))
+	if (!pskb_may_pull(skb, ETH_HLEN))
 		return false;
 
 	/* create a copy of the skb (in case of for re-routing) to modify it. */
-	if (skb_cow(skb, sizeof(*unicast_packet)) < 0)
+	if (skb_cow_head(skb, ETH_HLEN + hdr_len) < 0)
 		return false;
 
-	unicast_packet = (struct batadv_unicast_packet *)skb->data;
-	vid = batadv_get_vid(skb, hdr_len);
-	ethhdr = (struct ethhdr *)(skb->data + hdr_len);
+	unicast_packet = (struct batadv_unicast_packet *)(skb->data - hdr_len);
+	vid = batadv_get_vid(skb, 0);
+	ethhdr = (struct ethhdr *)skb->data;
 
 	/* check if the destination client was served by this node and it is now
 	 * roaming. In this case, it means that the node has got a ROAM_ADV
@@ -985,13 +985,16 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	 */
 	if (check == -EREMOTE)
 		batadv_nc_skb_store_sniffed_unicast(bat_priv, skb);
-
 	if (check < 0)
 		goto free_skb;
+
+	/* batadv_check_unicast_packet has checked if we may pull */
+	skb_pull_rcsum(skb, hdr_size);
+
 	if (!batadv_check_unicast_ttvn(bat_priv, skb, hdr_size))
 		goto free_skb;
 
-	unicast_packet = (struct batadv_unicast_packet *)skb->data;
+	unicast_packet = (struct batadv_unicast_packet *)(skb->data - hdr_size);
 
 	/* packet for me */
 	if (batadv_is_my_mac(bat_priv, unicast_packet->dest)) {
@@ -1001,8 +1004,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 		orig_addr_gw = eth_hdr(skb)->h_source;
 		orig_node_gw = batadv_orig_hash_find(bat_priv, orig_addr_gw);
 		if (orig_node_gw) {
-			is_gw = batadv_bla_is_backbone_gw(skb, orig_node_gw,
-							  hdr_size);
+			is_gw = batadv_bla_is_backbone_gw(skb, orig_node_gw, 0);
 			batadv_orig_node_put(orig_node_gw);
 			if (is_gw) {
 				batadv_dbg(BATADV_DBG_BLA, bat_priv,
@@ -1014,7 +1016,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 
 		if (is4addr) {
 			unicast_4addr_packet =
-				(struct batadv_unicast_4addr_packet *)skb->data;
+				(struct batadv_unicast_4addr_packet *)
+				unicast_packet;
 			subtype = unicast_4addr_packet->subtype;
 			batadv_dat_inc_counter(bat_priv, subtype);
 
@@ -1031,15 +1034,12 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 			}
 		}
 
-		if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb,
-							  hdr_size))
+		if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb, 0))
 			goto rx_success;
-		if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb,
-							hdr_size))
+		if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, 0))
 			goto rx_success;
 
-		batadv_interface_rx(recv_if->soft_iface, skb, hdr_size,
-				    orig_node);
+		batadv_interface_rx(recv_if->soft_iface, skb, false, orig_node);
 
 rx_success:
 		if (orig_node)
@@ -1048,6 +1048,8 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 		return NET_RX_SUCCESS;
 	}
 
+	skb_push_rcsum(skb, hdr_size);
+
 	ret = batadv_route_unicast_packet(skb, recv_if);
 	/* skb was consumed */
 	skb = NULL;
@@ -1273,8 +1275,10 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size))
 		goto rx_success;
 
+	skb_pull_rcsum(skb, hdr_size);
+
 	/* broadcast for me */
-	batadv_interface_rx(recv_if->soft_iface, skb, hdr_size, orig_node);
+	batadv_interface_rx(recv_if->soft_iface, skb, true, orig_node);
 
 rx_success:
 	ret = NET_RX_SUCCESS;
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index edeffcb9f3a2..370770759bb8 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -400,7 +400,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
  * batadv_interface_rx() - receive ethernet frame on local batman-adv interface
  * @soft_iface: local interface which will receive the ethernet frame
  * @skb: ethernet frame for @soft_iface
- * @hdr_size: size of already parsed batman-adv header
+ * @is_bcast: true if the received frame is a batman-adv broadcast
  * @orig_node: originator from which the batman-adv packet was sent
  *
  * Sends a ethernet frame to the receive path of the local @soft_iface.
@@ -414,20 +414,14 @@ static int batadv_interface_tx(struct sk_buff *skb,
  * isolated clients.
  */
 void batadv_interface_rx(struct net_device *soft_iface,
-			 struct sk_buff *skb, int hdr_size,
+			 struct sk_buff *skb, bool is_bcast,
 			 struct batadv_orig_node *orig_node)
 {
-	struct batadv_bcast_packet *batadv_bcast_packet;
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct vlan_ethhdr *vhdr;
 	struct ethhdr *ethhdr;
 	unsigned short vid;
-	bool is_bcast;
 
-	batadv_bcast_packet = (struct batadv_bcast_packet *)skb->data;
-	is_bcast = (batadv_bcast_packet->packet_type == BATADV_BCAST);
-
-	skb_pull_rcsum(skb, hdr_size);
 	skb_reset_mac_header(skb);
 
 	/* clean the netfilter state now that the batman-adv header has been
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index daf87f07fadd..53071d45093a 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -30,7 +30,7 @@ struct sk_buff;
 
 int batadv_skb_head_push(struct sk_buff *skb, unsigned int len);
 void batadv_interface_rx(struct net_device *soft_iface,
-			 struct sk_buff *skb, int hdr_size,
+			 struct sk_buff *skb, bool is_bcast,
 			 struct batadv_orig_node *orig_node);
 struct net_device *batadv_softif_create(struct net *net, const char *name);
 void batadv_softif_destroy_sysfs(struct net_device *soft_iface);
-- 
2.16.2

