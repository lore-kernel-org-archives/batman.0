Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 16 Apr 2013 18:17:36 +0200
Message-Id: <1366129056-29381-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix batadv_is_my_mac() usage
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

batadv_is_my_mac() has been changed in net and now code in
net-next using it must be adapted.
Some kernel doc has been added as well.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.c           |  6 ++++++
 network-coding.c | 18 ++++++++++--------
 routing.c        |  1 +
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/main.c b/main.c
index 790e917..3e30a0f 100644
--- a/main.c
+++ b/main.c
@@ -177,6 +177,12 @@ void batadv_mesh_free(struct net_device *soft_iface)
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_INACTIVE);
 }
 
+/**
+ * batadv_is_my_mac - check if the given mac address belongs to any of the real
+ * interfaces in the current mesh
+ * @bat_priv: the bat priv with all the soft interface information
+ * @addr: the address to check
+ */
 int batadv_is_my_mac(struct batadv_priv *bat_priv, const uint8_t *addr)
 {
 	const struct batadv_hard_iface *hard_iface;
diff --git a/network-coding.c b/network-coding.c
index 6b9a544..4eb49fc 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -1484,7 +1484,7 @@ void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
-	if (batadv_is_my_mac(ethhdr->h_dest))
+	if (batadv_is_my_mac(bat_priv, ethhdr->h_dest))
 		return;
 
 	/* Set data pointer to MAC header to mimic packets from our tx path */
@@ -1496,6 +1496,7 @@ void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
 /**
  * batadv_nc_skb_decode_packet - decode given skb using the decode data stored
  *  in nc_packet
+ * @bat_priv: the bat priv with all the soft interface information
  * @skb: unicast skb to decode
  * @nc_packet: decode data needed to decode the skb
  *
@@ -1503,7 +1504,8 @@ void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
  * in case of an error.
  */
 static struct batadv_unicast_packet *
-batadv_nc_skb_decode_packet(struct sk_buff *skb,
+batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv,
+			    struct sk_buff *skb,
 			    struct batadv_nc_packet *nc_packet)
 {
 	const int h_size = sizeof(struct batadv_unicast_packet);
@@ -1537,7 +1539,7 @@ batadv_nc_skb_decode_packet(struct sk_buff *skb,
 	/* Select the correct unicast header information based on the location
 	 * of our mac address in the coded_packet header
 	 */
-	if (batadv_is_my_mac(coded_packet_tmp.second_dest)) {
+	if (batadv_is_my_mac(bat_priv, coded_packet_tmp.second_dest)) {
 		/* If we are the second destination the packet was overheard,
 		 * so the Ethernet address must be copied to h_dest and
 		 * pkt_type changed from PACKET_OTHERHOST to PACKET_HOST
@@ -1608,7 +1610,7 @@ batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
 
 	/* Select the correct packet id based on the location of our mac-addr */
 	dest = ethhdr->h_source;
-	if (!batadv_is_my_mac(coded->second_dest)) {
+	if (!batadv_is_my_mac(bat_priv, coded->second_dest)) {
 		source = coded->second_source;
 		packet_id = coded->second_crc;
 	} else {
@@ -1675,12 +1677,12 @@ static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
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
@@ -1698,7 +1700,7 @@ static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
 		goto free_nc_packet;
 
 	/* Decode the packet */
-	unicast_packet = batadv_nc_skb_decode_packet(skb, nc_packet);
+	unicast_packet = batadv_nc_skb_decode_packet(bat_priv, skb, nc_packet);
 	if (!unicast_packet) {
 		batadv_inc_counter(bat_priv, BATADV_CNT_NC_DECODE_FAILED);
 		goto free_nc_packet;
diff --git a/routing.c b/routing.c
index addeff8..2f1f889 100644
--- a/routing.c
+++ b/routing.c
@@ -551,6 +551,7 @@ batadv_find_ifalter_router(struct batadv_orig_node *primary_orig,
 
 /**
  * batadv_check_unicast_packet - Check for malformed unicast packets
+ * @bat_priv: the bat priv with all the soft interface information
  * @skb: packet to check
  * @hdr_size: size of header to pull
  *
-- 
1.8.1.5

