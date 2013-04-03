Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  3 Apr 2013 19:10:26 +0200
Message-Id: <1365009026-931-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: let is_my_mac() check for the
	current mesh only
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

In a multi-mesh node (a node running more than one batman
virtual interface) batadv_is_my_mac() has to check MAC
addresses of hard interfaces belonging to the current mesh
only

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

I think this is worth being merged into maint.
Being a fix, it should be sent to net.

Cheers,


 main.c              |  5 ++++-
 main.h              |  2 +-
 network-coding.c    | 12 ++++++------
 routing.c           | 38 ++++++++++++++++++++------------------
 translation-table.c |  2 +-
 vis.c               |  4 ++--
 6 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/main.c b/main.c
index 9b77d4d..8170d4e 100644
--- a/main.c
+++ b/main.c
@@ -178,7 +178,7 @@ void batadv_mesh_free(struct net_device *soft_iface)
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 }
 
-int batadv_is_my_mac(const uint8_t *addr)
+int batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr)
 {
 	const struct batadv_hard_iface *hard_iface;
 
@@ -187,6 +187,9 @@ int batadv_is_my_mac(const uint8_t *addr)
 		if (hard_iface->if_status != BATADV_IF_ACTIVE)
 			continue;
 
+		if (hard_iface->soft_iface != bat_priv->soft_iface)
+			continue;
+
 		if (batadv_compare_eth(hard_iface->net_dev->dev_addr, addr)) {
 			rcu_read_unlock();
 			return 1;
diff --git a/main.h b/main.h
index 2c751c6..24063e7 100644
--- a/main.h
+++ b/main.h
@@ -172,7 +172,7 @@ extern struct workqueue_struct *batadv_event_workqueue;
 
 int batadv_mesh_init(struct net_device *soft_iface);
 void batadv_mesh_free(struct net_device *soft_iface);
-int batadv_is_my_mac(const uint8_t *addr);
+int batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr);
 struct batadv_hard_iface *
 batadv_seq_print_text_primary_if_get(struct seq_file *seq);
 int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
diff --git a/network-coding.c b/network-coding.c
index 6b9a544..1bc0bea 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -1484,7 +1484,7 @@ void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
-	if (batadv_is_my_mac(ethhdr->h_dest))
+	if (batadv_is_my_mac(bat_priv, ethhdr->h_dest))
 		return;
 
 	/* Set data pointer to MAC header to mimic packets from our tx path */
@@ -1537,7 +1537,7 @@ batadv_nc_skb_decode_packet(struct sk_buff *skb,
 	/* Select the correct unicast header information based on the location
 	 * of our mac address in the coded_packet header
 	 */
-	if (batadv_is_my_mac(coded_packet_tmp.second_dest)) {
+	if (batadv_is_my_mac(bat_priv, coded_packet_tmp.second_dest)) {
 		/* If we are the second destination the packet was overheard,
 		 * so the Ethernet address must be copied to h_dest and
 		 * pkt_type changed from PACKET_OTHERHOST to PACKET_HOST
@@ -1608,7 +1608,7 @@ batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
 
 	/* Select the correct packet id based on the location of our mac-addr */
 	dest = ethhdr->h_source;
-	if (!batadv_is_my_mac(coded->second_dest)) {
+	if (!batadv_is_my_mac(bat_priv, coded->second_dest)) {
 		source = coded->second_source;
 		packet_id = coded->second_crc;
 	} else {
@@ -1675,12 +1675,12 @@ static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* Verify frame is destined for us */
-	if (!batadv_is_my_mac(ethhdr->h_dest) &&
-	    !batadv_is_my_mac(coded_packet->second_dest))
+	if (!batadv_is_my_mac(bat_priv, ethhdr->h_dest) &&
+	    !batadv_is_my_mac(bat_priv, coded_packet->second_dest))
 		return NET_RX_DROP;
 
 	/* Update stat counter */
-	if (batadv_is_my_mac(coded_packet->second_dest))
+	if (batadv_is_my_mac(bat_priv, coded_packet->second_dest))
 		batadv_inc_counter(bat_priv, BATADV_CNT_NC_SNIFFED);
 
 	nc_packet = batadv_nc_find_decoding_packet(bat_priv, ethhdr,
diff --git a/routing.c b/routing.c
index 0b79e65..0df28f9 100644
--- a/routing.c
+++ b/routing.c
@@ -374,7 +374,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 		goto out;
 
 	/* not for me */
-	if (!batadv_is_my_mac(ethhdr->h_dest))
+	if (!batadv_is_my_mac(bat_priv, ethhdr->h_dest))
 		goto out;
 
 	icmp_packet = (struct batadv_icmp_packet_rr *)skb->data;
@@ -388,7 +388,7 @@ int batadv_recv_icmp_packet(struct sk_buff *skb,
 	}
 
 	/* packet for me */
-	if (batadv_is_my_mac(icmp_packet->dst))
+	if (batadv_is_my_mac(bat_priv, icmp_packet->dst))
 		return batadv_recv_my_icmp_packet(bat_priv, skb, hdr_size);
 
 	/* TTL exceeded */
@@ -530,7 +530,8 @@ batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
  * reason: -ENODATA for bad header, -EBADR for broadcast destination or source,
  * and -EREMOTE for non-local (other host) destination.
  */
-static int batadv_check_unicast_packet(struct sk_buff *skb, int hdr_size)
+static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
+				       struct sk_buff *skb, int hdr_size)
 {
 	struct ethhdr *ethhdr;
 
@@ -549,7 +550,7 @@ static int batadv_check_unicast_packet(struct sk_buff *skb, int hdr_size)
 		return -EBADR;
 
 	/* not for me */
-	if (!batadv_is_my_mac(ethhdr->h_dest))
+	if (!batadv_is_my_mac(bat_priv, ethhdr->h_dest))
 		return -EREMOTE;
 
 	return 0;
@@ -564,7 +565,7 @@ int batadv_recv_tt_query(struct sk_buff *skb, struct batadv_hard_iface *recv_if)
 	char tt_flag;
 	size_t packet_size;
 
-	if (batadv_check_unicast_packet(skb, hdr_size) < 0)
+	if (batadv_check_unicast_packet(bat_priv, skb, hdr_size) < 0)
 		return NET_RX_DROP;
 
 	/* I could need to modify it */
@@ -596,7 +597,7 @@ int batadv_recv_tt_query(struct sk_buff *skb, struct batadv_hard_iface *recv_if)
 	case BATADV_TT_RESPONSE:
 		batadv_inc_counter(bat_priv, BATADV_CNT_TT_RESPONSE_RX);
 
-		if (batadv_is_my_mac(tt_query->dst)) {
+		if (batadv_is_my_mac(bat_priv, tt_query->dst)) {
 			/* packet needs to be linearized to access the TT
 			 * changes
 			 */
@@ -639,14 +640,15 @@ int batadv_recv_roam_adv(struct sk_buff *skb, struct batadv_hard_iface *recv_if)
 	struct batadv_roam_adv_packet *roam_adv_packet;
 	struct batadv_orig_node *orig_node;
 
-	if (batadv_check_unicast_packet(skb, sizeof(*roam_adv_packet)) < 0)
+	if (batadv_check_unicast_packet(bat_priv, skb,
+					sizeof(*roam_adv_packet)) < 0)
 		goto out;
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_ROAM_ADV_RX);
 
 	roam_adv_packet = (struct batadv_roam_adv_packet *)skb->data;
 
-	if (!batadv_is_my_mac(roam_adv_packet->dst))
+	if (!batadv_is_my_mac(bat_priv, roam_adv_packet->dst))
 		return batadv_route_unicast_packet(skb, recv_if);
 
 	/* check if it is a backbone gateway. we don't accept
@@ -952,7 +954,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	 * last time) the packet had an updated information or not
 	 */
 	curr_ttvn = (uint8_t)atomic_read(&bat_priv->tt.vn);
-	if (!batadv_is_my_mac(unicast_packet->dest)) {
+	if (!batadv_is_my_mac(bat_priv, unicast_packet->dest)) {
 		orig_node = batadv_orig_hash_find(bat_priv,
 						  unicast_packet->dest);
 		/* if it is not possible to find the orig_node representing the
@@ -1030,7 +1032,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 		hdr_size = sizeof(*unicast_4addr_packet);
 
 	/* function returns -EREMOTE for promiscuous packets */
-	check = batadv_check_unicast_packet(skb, hdr_size);
+	check = batadv_check_unicast_packet(bat_priv, skb, hdr_size);
 
 	/* Even though the packet is not for us, we might save it to use for
 	 * decoding a later received coded packet
@@ -1045,7 +1047,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 		return NET_RX_DROP;
 
 	/* packet for me */
-	if (batadv_is_my_mac(unicast_packet->dest)) {
+	if (batadv_is_my_mac(bat_priv, unicast_packet->dest)) {
 		if (is4addr) {
 			batadv_dat_inc_counter(bat_priv,
 					       unicast_4addr_packet->subtype);
@@ -1082,7 +1084,7 @@ int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
 	struct sk_buff *new_skb = NULL;
 	int ret;
 
-	if (batadv_check_unicast_packet(skb, hdr_size) < 0)
+	if (batadv_check_unicast_packet(bat_priv, skb, hdr_size) < 0)
 		return NET_RX_DROP;
 
 	if (!batadv_check_unicast_ttvn(bat_priv, skb))
@@ -1091,7 +1093,7 @@ int batadv_recv_ucast_frag_packet(struct sk_buff *skb,
 	unicast_packet = (struct batadv_unicast_frag_packet *)skb->data;
 
 	/* packet for me */
-	if (batadv_is_my_mac(unicast_packet->dest)) {
+	if (batadv_is_my_mac(bat_priv, unicast_packet->dest)) {
 		ret = batadv_frag_reassemble_skb(skb, bat_priv, &new_skb);
 
 		if (ret == NET_RX_DROP)
@@ -1145,13 +1147,13 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 		goto out;
 
 	/* ignore broadcasts sent by myself */
-	if (batadv_is_my_mac(ethhdr->h_source))
+	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		goto out;
 
 	bcast_packet = (struct batadv_bcast_packet *)skb->data;
 
 	/* ignore broadcasts originated by myself */
-	if (batadv_is_my_mac(bcast_packet->orig))
+	if (batadv_is_my_mac(bat_priv, bcast_packet->orig))
 		goto out;
 
 	if (bcast_packet->header.ttl < 2)
@@ -1237,14 +1239,14 @@ int batadv_recv_vis_packet(struct sk_buff *skb,
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* not for me */
-	if (!batadv_is_my_mac(ethhdr->h_dest))
+	if (!batadv_is_my_mac(bat_priv, ethhdr->h_dest))
 		return NET_RX_DROP;
 
 	/* ignore own packets */
-	if (batadv_is_my_mac(vis_packet->vis_orig))
+	if (batadv_is_my_mac(bat_priv, vis_packet->vis_orig))
 		return NET_RX_DROP;
 
-	if (batadv_is_my_mac(vis_packet->sender_orig))
+	if (batadv_is_my_mac(bat_priv, vis_packet->sender_orig))
 		return NET_RX_DROP;
 
 	switch (vis_packet->vis_type) {
diff --git a/translation-table.c b/translation-table.c
index 279f0fd..d3c1fc6 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1947,7 +1947,7 @@ out:
 bool batadv_send_tt_response(struct batadv_priv *bat_priv,
 			     struct batadv_tt_query_packet *tt_request)
 {
-	if (batadv_is_my_mac(tt_request->dst)) {
+	if (batadv_is_my_mac(bat_priv, tt_request->dst)) {
 		/* don't answer backbone gws! */
 		if (batadv_bla_is_backbone_gw_orig(bat_priv, tt_request->src))
 			return true;
diff --git a/vis.c b/vis.c
index 962ccf3..1625e57 100644
--- a/vis.c
+++ b/vis.c
@@ -477,7 +477,7 @@ void batadv_receive_client_update_packet(struct batadv_priv *bat_priv,
 
 	/* Are we the target for this VIS packet? */
 	if (vis_server == BATADV_VIS_TYPE_SERVER_SYNC	&&
-	    batadv_is_my_mac(vis_packet->target_orig))
+	    batadv_is_my_mac(bat_priv, vis_packet->target_orig))
 		are_target = 1;
 
 	spin_lock_bh(&bat_priv->vis.hash_lock);
@@ -496,7 +496,7 @@ void batadv_receive_client_update_packet(struct batadv_priv *bat_priv,
 		batadv_send_list_add(bat_priv, info);
 
 		/* ... we're not the recipient (and thus need to forward). */
-	} else if (!batadv_is_my_mac(packet->target_orig)) {
+	} else if (!batadv_is_my_mac(bat_priv, packet->target_orig)) {
 		batadv_send_list_add(bat_priv, info);
 	}
 
-- 
1.8.1.5

