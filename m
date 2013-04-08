Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  8 Apr 2013 15:08:18 +0200
Message-Id: <1365426498-3187-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use eth_hdr() when possible
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

Instead of casting the result of skb_mac_header() to
"struct ethhdr *" every time, the eth_hdr inline function
can be use to beautify the code and improve its readability

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_iv_ogm.c            |  2 +-
 bridge_loop_avoidance.c |  8 ++++----
 network-coding.c        | 10 +++++-----
 routing.c               | 12 ++++++------
 send.c                  |  2 +-
 soft-interface.c        |  2 +-
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 66d2c3b..282ddf6 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1326,7 +1326,7 @@ static int batadv_iv_ogm_receive(struct sk_buff *skb,
 			   skb->len + ETH_HLEN);
 
 	packet_len = skb_headlen(skb);
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 	packet_buff = skb->data;
 	batadv_ogm_packet = (struct batadv_ogm_packet *)packet_buff;
 
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 6a4f728..0cc0c3e 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -864,7 +864,7 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
 	short vid = -1;
 	int ret;
 
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 
 	if (ntohs(ethhdr->h_proto) == ETH_P_8021Q) {
 		vhdr = (struct vlan_ethhdr *)ethhdr;
@@ -885,7 +885,7 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
 		return 0;
 
 	/* pskb_may_pull() may have modified the pointers, get ethhdr again */
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 	arphdr = (struct arphdr *)((uint8_t *)ethhdr + headlen);
 
 	/* Check whether the ARP frame carries a valid
@@ -1432,7 +1432,7 @@ int batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid,
 	struct batadv_hard_iface *primary_if;
 	int ret;
 
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
@@ -1539,7 +1539,7 @@ int batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb, short vid)
 	if (batadv_bla_process_claim(bat_priv, primary_if, skb))
 		goto handled;
 
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 
 	if (unlikely(atomic_read(&bat_priv->bla.num_requests)))
 		/* don't allow broadcasts while requests are in flight */
diff --git a/network-coding.c b/network-coding.c
index 6b9a544..80fe2ea 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -1245,7 +1245,7 @@ static void batadv_nc_skb_store_before_coding(struct batadv_priv *bat_priv,
 		return;
 
 	/* Set the mac header as if we actually sent the packet uncoded */
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 	memcpy(ethhdr->h_source, ethhdr->h_dest, ETH_ALEN);
 	memcpy(ethhdr->h_dest, eth_dst_new, ETH_ALEN);
 
@@ -1423,7 +1423,7 @@ void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
 {
 	struct batadv_unicast_packet *packet;
 	struct batadv_nc_path *nc_path;
-	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	struct ethhdr *ethhdr = eth_hdr(skb);
 	__be32 packet_id;
 	u8 *payload;
 
@@ -1482,7 +1482,7 @@ out:
 void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb)
 {
-	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	struct ethhdr *ethhdr = eth_hdr(skb);
 
 	if (batadv_is_my_mac(ethhdr->h_dest))
 		return;
@@ -1531,7 +1531,7 @@ batadv_nc_skb_decode_packet(struct sk_buff *skb,
 	skb_reset_network_header(skb);
 
 	/* Reconstruct original mac header */
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 	memcpy(ethhdr, &ethhdr_tmp, sizeof(*ethhdr));
 
 	/* Select the correct unicast header information based on the location
@@ -1672,7 +1672,7 @@ static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 		return NET_RX_DROP;
 
 	coded_packet = (struct batadv_coded_packet *)skb->data;
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 
 	/* Verify frame is destined for us */
 	if (!batadv_is_my_mac(ethhdr->h_dest) &&
diff --git a/routing.c b/routing.c
index 0b79e65..3f3fa55 100644
--- a/routing.c
+++ b/routing.c
@@ -227,7 +227,7 @@ bool batadv_check_management_packet(struct sk_buff *skb,
 	if (unlikely(!pskb_may_pull(skb, header_len)))
 		return false;
 
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 
 	/* packet with broadcast indication but unicast recipient */
 	if (!is_broadcast_ether_addr(ethhdr->h_dest))
@@ -363,7 +363,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
 		goto out;
 
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 
 	/* packet with unicast indication but broadcast recipient */
 	if (is_broadcast_ether_addr(ethhdr->h_dest))
@@ -538,7 +538,7 @@ static int batadv_check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
 		return -ENODATA;
 
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 
 	/* packet with unicast indication but broadcast recipient */
 	if (is_broadcast_ether_addr(ethhdr->h_dest))
@@ -771,7 +771,7 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_unicast_packet *unicast_packet;
-	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	struct ethhdr *ethhdr = eth_hdr(skb);
 	int ret = NET_RX_DROP;
 	struct sk_buff *new_skb;
 
@@ -1134,7 +1134,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
 		goto out;
 
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 
 	/* packet with broadcast indication but unicast recipient */
 	if (!is_broadcast_ether_addr(ethhdr->h_dest))
@@ -1234,7 +1234,7 @@ int batadv_recv_vis_packet(struct sk_buff *skb,
 		return NET_RX_DROP;
 
 	vis_packet = (struct batadv_vis_packet *)skb->data;
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 
 	/* not for me */
 	if (!batadv_is_my_mac(ethhdr->h_dest))
diff --git a/send.c b/send.c
index eb16b04..ed7072a 100644
--- a/send.c
+++ b/send.c
@@ -61,7 +61,7 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 
 	skb_reset_mac_header(skb);
 
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 	memcpy(ethhdr->h_source, hard_iface->net_dev->dev_addr, ETH_ALEN);
 	memcpy(ethhdr->h_dest, dst_addr, ETH_ALEN);
 	ethhdr->h_proto = __constant_htons(ETH_P_BATMAN);
diff --git a/soft-interface.c b/soft-interface.c
index 403b8c4..c2a9c20 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -316,7 +316,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	skb_pull_rcsum(skb, hdr_size);
 	skb_reset_mac_header(skb);
 
-	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	ethhdr = eth_hdr(skb);
 
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_8021Q:
-- 
1.8.1.5

