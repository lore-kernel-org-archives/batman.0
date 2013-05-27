Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 27 May 2013 21:43:03 +0200
Message-Id: <1369683792-531-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1369683792-531-1-git-send-email-ordex@autistici.org>
References: <1369683792-531-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 03/12] batman-adv: add the VLAN ID
	attribute to the TT entry
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

To make the translation table code VLAN-aware, each entry
must carry the VLAN ID which it belongs to. This patch adds
such attribute to the related TT structures.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bridge_loop_avoidance.c |  37 +++-----
 distributed-arp-table.c |  11 ++-
 gateway_client.c        |   3 +-
 main.c                  |  30 +++++-
 main.h                  |   9 +-
 packet.h                |  12 +++
 routing.c               |  28 +++---
 send.c                  |   8 +-
 send.h                  |  16 ++--
 soft-interface.c        |  33 ++++---
 translation-table.c     | 238 ++++++++++++++++++++++++++++++++++++++----------
 translation-table.h     |  19 ++--
 types.h                 |   2 +
 13 files changed, 314 insertions(+), 132 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index ab537ec..02f6f81 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -858,27 +858,25 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
 				    struct batadv_hard_iface *primary_if,
 				    struct sk_buff *skb)
 {
-	struct ethhdr *ethhdr;
-	struct vlan_ethhdr *vhdr;
-	struct arphdr *arphdr;
-	uint8_t *hw_src, *hw_dst;
 	struct batadv_bla_claim_dst *bla_dst;
+	uint8_t *hw_src, *hw_dst;
+	struct vlan_ethhdr *vhdr;
+	struct ethhdr *ethhdr;
+	struct arphdr *arphdr;
+	unsigned short vid;
 	__be16 proto;
 	int headlen;
-	unsigned short vid = BATADV_NO_FLAGS;
 	int ret;
 
+	vid = batadv_get_vid(skb, 0);
 	ethhdr = eth_hdr(skb);
 
-	if (ethhdr->h_proto == htons(ETH_P_8021Q)) {
+	proto = ethhdr->h_proto;
+	headlen = ETH_HLEN;
+	if (vid & BATADV_VLAN_HAS_TAG) {
 		vhdr = (struct vlan_ethhdr *)ethhdr;
-		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
-		vid |= BATADV_VLAN_HAS_TAG;
 		proto = vhdr->h_vlan_encapsulated_proto;
-		headlen = sizeof(*vhdr);
-	} else {
-		proto = ethhdr->h_proto;
-		headlen = ETH_HLEN;
+		headlen += VLAN_HLEN;
 	}
 
 	if (proto != htons(ETH_P_ARP))
@@ -1361,10 +1359,8 @@ int batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, uint8_t *orig)
 int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 			      struct batadv_orig_node *orig_node, int hdr_size)
 {
-	struct ethhdr *ethhdr;
-	struct vlan_ethhdr *vhdr;
 	struct batadv_bla_backbone_gw *backbone_gw;
-	unsigned short vid = BATADV_NO_FLAGS;
+	unsigned short vid;
 
 	if (!atomic_read(&orig_node->bat_priv->bridge_loop_avoidance))
 		return 0;
@@ -1373,16 +1369,7 @@ int batadv_bla_is_backbone_gw(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, hdr_size + ETH_HLEN))
 		return 0;
 
-	ethhdr = (struct ethhdr *)(((uint8_t *)skb->data) + hdr_size);
-
-	if (ethhdr->h_proto == htons(ETH_P_8021Q)) {
-		if (!pskb_may_pull(skb, hdr_size + VLAN_ETH_HLEN))
-			return 0;
-
-		vhdr = (struct vlan_ethhdr *)(skb->data + hdr_size);
-		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
-		vid |= BATADV_VLAN_HAS_TAG;
-	}
+	vid = batadv_get_vid(skb, hdr_size);
 
 	/* see if this originator is a backbone gw for this VLAN */
 	backbone_gw = batadv_backbone_hash_find(orig_node->bat_priv,
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 99da412..1b590f0 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -905,7 +905,8 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		 * additional DAT answer may trigger kernel warnings about
 		 * a packet coming from the wrong port.
 		 */
-		if (batadv_is_my_client(bat_priv, dat_entry->mac_addr)) {
+		if (batadv_is_my_client(bat_priv, dat_entry->mac_addr,
+					BATADV_NO_FLAGS)) {
 			ret = true;
 			goto out;
 		}
@@ -990,9 +991,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	 */
 	if (hdr_size == sizeof(struct batadv_unicast_4addr_packet))
 		err = batadv_send_skb_unicast_4addr(bat_priv, skb_new,
-						    BATADV_P_DAT_CACHE_REPLY);
+						    BATADV_P_DAT_CACHE_REPLY,
+						    BATADV_NO_FLAGS);
 	else
-		err = batadv_send_skb_unicast(bat_priv, skb_new);
+		err = batadv_send_skb_unicast(bat_priv, skb_new,
+					      BATADV_NO_FLAGS);
 
 	if (!err) {
 		batadv_inc_counter(bat_priv, BATADV_CNT_DAT_CACHED_REPLY_TX);
@@ -1080,7 +1083,7 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	/* if this REPLY is directed to a client of mine, let's deliver the
 	 * packet to the interface
 	 */
-	ret = !batadv_is_my_client(bat_priv, hw_dst);
+	ret = !batadv_is_my_client(bat_priv, hw_dst, BATADV_NO_FLAGS);
 out:
 	if (ret)
 		kfree_skb(skb);
diff --git a/gateway_client.c b/gateway_client.c
index 131136f..d0491fe 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -706,7 +706,8 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 		goto out;
 
 	orig_dst_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
-						 ethhdr->h_dest);
+						 ethhdr->h_dest,
+						 BATADV_NO_FLAGS);
 	if (!orig_dst_node)
 		goto out;
 
diff --git a/main.c b/main.c
index 34c3e89..6c3d219 100644
--- a/main.c
+++ b/main.c
@@ -19,6 +19,7 @@
 
 #include <linux/crc32c.h>
 #include <linux/highmem.h>
+#include <linux/if_vlan.h>
 #include "main.h"
 #include "sysfs.h"
 #include "debugfs.h"
@@ -127,7 +128,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 		goto err;
 
 	batadv_tt_local_add(soft_iface, soft_iface->dev_addr,
-			    BATADV_NULL_IFINDEX);
+			    BATADV_NULL_IFINDEX, BATADV_NO_FLAGS);
 
 	ret = batadv_bla_init(bat_priv);
 	if (ret < 0)
@@ -1108,6 +1109,33 @@ out:
 		batadv_orig_node_free_ref(orig_node);
 }
 
+/**
+ * batadv_get_vid - extract the VLAN identifier from skb if any
+ * @skb: the buffer containing the packet
+ * @header_len: length of the batman header preceding the Ethernet one
+ *
+ * If the packet contained in skb is vlan tagged then this function returns the
+ * VID with the BATADV_VLAN_HAS_TAG flag. Otherwise returns BATADV_NO_FLAGS
+ */
+unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len)
+{
+	struct ethhdr *ethhdr = (struct ethhdr *)(skb->data + header_len);
+	struct vlan_ethhdr *vhdr;
+	unsigned short vid;
+
+	if (ethhdr->h_proto != htons(ETH_P_8021Q))
+		return BATADV_NO_FLAGS;
+
+	if (!pskb_may_pull(skb, header_len + VLAN_ETH_HLEN))
+		return BATADV_NO_FLAGS;
+
+	vhdr = (struct vlan_ethhdr *)(skb->data + header_len);
+	vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
+	vid |= BATADV_VLAN_HAS_TAG;
+
+	return vid;
+}
+
 static int batadv_param_set_ra(const char *val, const struct kernel_param *kp)
 {
 	struct batadv_algo_ops *bat_algo_ops;
diff --git a/main.h b/main.h
index 3db6c2e..fb46cbb 100644
--- a/main.h
+++ b/main.h
@@ -171,14 +171,6 @@ enum batadv_uev_type {
 
 #include "types.h"
 
-/**
- * batadv_vlan_flags - flags for the four MSB of any vlan ID field
- * @BATADV_VLAN_HAS_TAG: whether the field contains a valid vlan tag or not
- */
-enum batadv_vlan_flags {
-	BATADV_VLAN_HAS_TAG	= BIT(15),
-};
-
 #define BATADV_PRINT_VID(vid) (vid & BATADV_VLAN_HAS_TAG ? \
 			       (int)(vid & VLAN_VID_MASK) : -1)
 
@@ -368,5 +360,6 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, uint8_t *src,
 			      uint8_t *dst, uint8_t type, uint8_t version,
 			      void *tvlv_value, uint16_t tvlv_value_len);
+unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len);
 
 #endif /* _NET_BATMAN_ADV_MAIN_H_ */
diff --git a/packet.h b/packet.h
index 30b1740..9f5837c 100644
--- a/packet.h
+++ b/packet.h
@@ -122,6 +122,14 @@ enum batadv_tt_client_flags {
 	BATADV_TT_CLIENT_TEMP	 = BIT(11),
 };
 
+/**
+ * batadv_vlan_flags - flags for the four MSB of any vlan ID field
+ * @BATADV_VLAN_HAS_TAG: whether the field contains a valid vlan tag or not
+ */
+enum batadv_vlan_flags {
+	BATADV_VLAN_HAS_TAG	= BIT(15),
+};
+
 /* claim frame types for the bridge loop avoidance */
 enum batadv_bla_claimframe {
 	BATADV_CLAIM_TYPE_CLAIM		= 0x00,
@@ -425,19 +433,23 @@ struct batadv_tvlv_tt_data {
  *  batadv_tt_client_flags)
  * @reserved: reserved field
  * @addr: mac address of non-mesh client that triggered this tt change
+ * @vid: VLAN identifier
  */
 struct batadv_tvlv_tt_change {
 	uint8_t flags;
 	uint8_t reserved;
 	uint8_t addr[ETH_ALEN];
+	__be16 vid;
 };
 
 /**
  * struct batadv_tvlv_roam_adv - roaming advertisement
  * @client: mac address of roaming client
+ * @vid: VLAN identifier
  */
 struct batadv_tvlv_roam_adv {
 	uint8_t client[ETH_ALEN];
+	__be16 vid;
 };
 
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
diff --git a/routing.c b/routing.c
index 7b98c67..e63b05d 100644
--- a/routing.c
+++ b/routing.c
@@ -30,6 +30,8 @@
 #include "network-coding.h"
 #include "fragmentation.h"
 
+#include <linux/if_vlan.h>
+
 static int batadv_route_unicast_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if);
 
@@ -708,6 +710,7 @@ out:
  * @bat_priv: the bat priv with all the soft interface information
  * @unicast_packet: the unicast header to be updated
  * @dst_addr: the payload destination
+ * @vid: VLAN identifier
  *
  * Search the translation table for dst_addr and update the unicast header with
  * the new corresponding information (originator address where the destination
@@ -718,21 +721,22 @@ out:
 static bool
 batadv_reroute_unicast_packet(struct batadv_priv *bat_priv,
 			      struct batadv_unicast_packet *unicast_packet,
-			      uint8_t *dst_addr)
+			      uint8_t *dst_addr, unsigned short vid)
 {
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
 	bool ret = false;
 	uint8_t *orig_addr, orig_ttvn;
 
-	if (batadv_is_my_client(bat_priv, dst_addr)) {
+	if (batadv_is_my_client(bat_priv, dst_addr, vid)) {
 		primary_if = batadv_primary_if_get_selected(bat_priv);
 		if (!primary_if)
 			goto out;
 		orig_addr = primary_if->net_dev->dev_addr;
 		orig_ttvn = (uint8_t)atomic_read(&bat_priv->tt.vn);
 	} else {
-		orig_node = batadv_transtable_search(bat_priv, NULL, dst_addr);
+		orig_node = batadv_transtable_search(bat_priv, NULL, dst_addr,
+						     vid);
 		if (!orig_node)
 			goto out;
 
@@ -759,11 +763,12 @@ out:
 
 static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 				     struct sk_buff *skb, int hdr_len) {
-	uint8_t curr_ttvn, old_ttvn;
-	struct batadv_orig_node *orig_node;
-	struct ethhdr *ethhdr;
+	struct batadv_unicast_packet *unicast_packet;
 	struct batadv_hard_iface *primary_if;
-	struct batadv_unicast_packet *unicast_packet;
+	struct batadv_orig_node *orig_node;
+	uint8_t curr_ttvn, old_ttvn;
+	struct ethhdr *ethhdr;
+	unsigned short vid;
 	int is_old_ttvn;
 
 	/* check if there is enough data before accessing it */
@@ -775,6 +780,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 		return 0;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
+	vid = batadv_get_vid(skb, hdr_len);
 	ethhdr = (struct ethhdr *)(skb->data + hdr_len);
 
 	/* check if the destination client was served by this node and it is now
@@ -782,9 +788,9 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	 * message and that it knows the new destination in the mesh to re-route
 	 * the packet to
 	 */
-	if (batadv_tt_local_client_is_roaming(bat_priv, ethhdr->h_dest)) {
+	if (batadv_tt_local_client_is_roaming(bat_priv, ethhdr->h_dest, vid)) {
 		if (batadv_reroute_unicast_packet(bat_priv, unicast_packet,
-						  ethhdr->h_dest))
+						  ethhdr->h_dest, vid))
 			net_ratelimited_function(batadv_dbg, BATADV_DBG_TT,
 						 bat_priv,
 						 "Rerouting unicast packet to %pM (dst=%pM): Local Roaming\n",
@@ -830,7 +836,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	 * target host
 	 */
 	if (batadv_reroute_unicast_packet(bat_priv, unicast_packet,
-					  ethhdr->h_dest)) {
+					  ethhdr->h_dest, vid)) {
 		net_ratelimited_function(batadv_dbg, BATADV_DBG_TT, bat_priv,
 					 "Rerouting unicast packet to %pM (dst=%pM): TTVN mismatch old_ttvn=%u new_ttvn=%u\n",
 					 unicast_packet->dest, ethhdr->h_dest,
@@ -842,7 +848,7 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	 * currently served by this node or there is no destination at all and
 	 * it is possible to drop the packet
 	 */
-	if (!batadv_is_my_client(bat_priv, ethhdr->h_dest))
+	if (!batadv_is_my_client(bat_priv, ethhdr->h_dest, vid))
 		return 0;
 
 	/* update the header in order to let the packet be delivered to this
diff --git a/send.c b/send.c
index 8f74201..3198c91 100644
--- a/send.c
+++ b/send.c
@@ -241,12 +241,14 @@ out:
  * @packet_type: the batman unicast packet type to use
  * @packet_subtype: the unicast 4addr packet subtype (only relevant for unicast
  *  4addr packets)
+ * @vid: the vid to be used to search the translation table
  *
  * Returns 1 in case of error or 0 otherwise.
  */
 int batadv_send_skb_generic_unicast(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb, int packet_type,
-				    int packet_subtype)
+				    int packet_subtype,
+				    unsigned short vid)
 {
 	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct batadv_unicast_packet *unicast_packet;
@@ -265,7 +267,7 @@ int batadv_send_skb_generic_unicast(struct batadv_priv *bat_priv,
 	 * returns NULL in case of AP isolation
 	 */
 	orig_node = batadv_transtable_search(bat_priv, ethhdr->h_source,
-					     ethhdr->h_dest);
+					     ethhdr->h_dest, vid);
 
 find_router:
 	/* find_router():
@@ -299,7 +301,7 @@ find_router:
 	 * try to reroute it because the ttvn contained in the header is less
 	 * than the current one
 	 */
-	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest))
+	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest, vid))
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
 	if (batadv_send_skb_to_orig(skb, orig_node, NULL) != NET_XMIT_DROP)
diff --git a/send.h b/send.h
index ad63184..c030cb7 100644
--- a/send.h
+++ b/send.h
@@ -40,21 +40,23 @@ bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
 					   int packet_subtype);
 int batadv_send_skb_generic_unicast(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb, int packet_type,
-				    int packet_subtype);
-
+				    int packet_subtype,
+				    unsigned short vid);
 
 /**
  * batadv_send_unicast_skb - send the skb encapsulated in a unicast packet
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the payload to send
+ * @vid: the vid to be used to search the translation table
  *
  * Returns 1 in case of error or 0 otherwise.
  */
 static inline int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
-					  struct sk_buff *skb)
+					  struct sk_buff *skb,
+					  unsigned short vid)
 {
 	return batadv_send_skb_generic_unicast(bat_priv, skb, BATADV_UNICAST,
-					       0);
+					       0, vid);
 }
 
 /**
@@ -63,16 +65,18 @@ static inline int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the payload to send
  * @packet_subtype: the unicast 4addr packet subtype to use
+ * @vid: the vid to be used to search the translation table
  *
  * Returns 1 in case of error or 0 otherwise.
  */
 static inline int batadv_send_skb_unicast_4addr(struct batadv_priv *bat_priv,
 						struct sk_buff *skb,
-						int packet_subtype)
+						int packet_subtype,
+						unsigned short vid)
 {
 	return batadv_send_skb_generic_unicast(bat_priv, skb,
 					       BATADV_UNICAST_4ADDR,
-					       packet_subtype);
+					       packet_subtype, vid);
 }
 
 #endif /* _NET_BATMAN_ADV_SEND_H_ */
diff --git a/soft-interface.c b/soft-interface.c
index 2bad57f..3162ccb 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -118,9 +118,10 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 
 	/* only modify transtable if it has been initialized before */
 	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE) {
-		batadv_tt_local_remove(bat_priv, old_addr,
+		batadv_tt_local_remove(bat_priv, old_addr, BATADV_NO_FLAGS,
 				       "mac address changed", false);
-		batadv_tt_local_add(dev, addr->sa_data, BATADV_NULL_IFINDEX);
+		batadv_tt_local_add(dev, addr->sa_data, BATADV_NULL_IFINDEX,
+				    BATADV_NO_FLAGS);
 	}
 
 	return 0;
@@ -140,32 +141,33 @@ static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 static int batadv_interface_tx(struct sk_buff *skb,
 			       struct net_device *soft_iface)
 {
-	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
+	struct ethhdr *ethhdr;
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_bcast_packet *bcast_packet;
-	struct vlan_ethhdr *vhdr;
 	__be16 ethertype = htons(ETH_P_BATMAN);
 	static const uint8_t stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00,
 						   0x00, 0x00};
 	static const uint8_t ectp_addr[ETH_ALEN] = {0xCF, 0x00, 0x00, 0x00,
 						    0x00, 0x00};
+	struct vlan_ethhdr *vhdr;
 	unsigned int header_len = 0;
 	int data_len = skb->len, ret;
-	unsigned short vid __maybe_unused = BATADV_NO_FLAGS;
+	unsigned long brd_delay = 1;
 	bool do_bcast = false;
+	unsigned short vid;
 	uint32_t seqno;
-	unsigned long brd_delay = 1;
 
 	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
 
 	soft_iface->trans_start = jiffies;
+	vid = batadv_get_vid(skb, 0);
+	ethhdr = (struct ethhdr *)skb->data;
 
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_8021Q:
 		vhdr = (struct vlan_ethhdr *)skb->data;
-		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
 
 		if (vhdr->h_vlan_encapsulated_proto != ethertype)
 			break;
@@ -180,7 +182,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 	/* Register the client MAC in the transtable */
 	if (!is_multicast_ether_addr(ethhdr->h_source))
-		batadv_tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
+		batadv_tt_local_add(soft_iface, ethhdr->h_source, vid,
+				    skb->skb_iif);
 
 	/* don't accept stp packets. STP does not help in meshes.
 	 * better use the bridge loop avoidance ...
@@ -274,7 +277,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 
 		batadv_dat_snoop_outgoing_arp_reply(bat_priv, skb);
 
-		ret = batadv_send_skb_unicast(bat_priv, skb);
+		ret = batadv_send_skb_unicast(bat_priv, skb, vid);
 		if (ret != 0)
 			goto dropped_freed;
 	}
@@ -297,12 +300,12 @@ void batadv_interface_rx(struct net_device *soft_iface,
 			 struct sk_buff *skb, struct batadv_hard_iface *recv_if,
 			 int hdr_size, struct batadv_orig_node *orig_node)
 {
-	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
-	struct ethhdr *ethhdr;
-	struct vlan_ethhdr *vhdr;
 	struct batadv_header *batadv_header = (struct batadv_header *)skb->data;
-	unsigned short vid __maybe_unused = BATADV_NO_FLAGS;
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	__be16 ethertype = htons(ETH_P_BATMAN);
+	struct vlan_ethhdr *vhdr;
+	struct ethhdr *ethhdr;
+	unsigned short vid;
 	bool is_bcast;
 
 	is_bcast = (batadv_header->packet_type == BATADV_BCAST);
@@ -314,12 +317,12 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	skb_pull_rcsum(skb, hdr_size);
 	skb_reset_mac_header(skb);
 
+	vid = batadv_get_vid(skb, hdr_size);
 	ethhdr = eth_hdr(skb);
 
 	switch (ntohs(ethhdr->h_proto)) {
 	case ETH_P_8021Q:
 		vhdr = (struct vlan_ethhdr *)skb->data;
-		vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
 
 		if (vhdr->h_vlan_encapsulated_proto != ethertype)
 			break;
@@ -355,7 +358,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 
 	if (orig_node)
 		batadv_tt_add_temporary_global_entry(bat_priv, orig_node,
-						     ethhdr->h_source);
+						     ethhdr->h_source, vid);
 
 	if (batadv_is_ap_isolated(bat_priv, ethhdr->h_source, ethhdr->h_dest))
 		goto dropped;
diff --git a/translation-table.c b/translation-table.c
index 9989bd6..6c38099 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -34,6 +34,7 @@ static struct lock_class_key batadv_tt_local_hash_lock_class_key;
 static struct lock_class_key batadv_tt_global_hash_lock_class_key;
 
 static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
+				 unsigned short vid,
 				 struct batadv_orig_node *orig_node);
 static void batadv_tt_purge(struct work_struct *work);
 static void
@@ -41,7 +42,8 @@ batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry);
 static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 struct batadv_orig_node *orig_node,
 				 const unsigned char *addr,
-				 const char *message, bool roaming);
+				 unsigned short vid, const char *message,
+				 bool roaming);
 
 /* returns 1 if they are the same mac addr */
 static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
@@ -52,43 +54,93 @@ static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
 	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
 }
 
+/**
+ * batadv_choose_tt - return the index of the tt entry in the hash table
+ * @data: pointer to the tt_common_entry object to map
+ * @size: the size of the hash table
+ *
+ * Return the index where the object represented by 'data' should be stored in
+ * the hash table
+ */
+static inline uint32_t batadv_choose_tt(const void *data, uint32_t size)
+{
+	struct batadv_tt_common_entry *tt;
+	uint32_t hash = 0;
+
+	tt = (struct batadv_tt_common_entry *)data;
+	hash = batadv_hash_bytes(hash, &tt->addr, ETH_ALEN);
+	hash = batadv_hash_bytes(hash, &tt->vid, sizeof(tt->vid));
+
+	hash += (hash << 3);
+	hash ^= (hash >> 11);
+	hash += (hash << 15);
+
+	return hash % size;
+}
+
+/**
+ * batadv_tt_hash_find - looks for a client in the given hash table
+ * @hash: the hash table to search
+ * @addr: the mac address of the client to look for
+ * @vid: VLAN identifier
+ *
+ * Return a pointer to the tt_common struct belonging to the searched client if
+ * found, NULL otherwise
+ */
 static struct batadv_tt_common_entry *
-batadv_tt_hash_find(struct batadv_hashtable *hash, const void *data)
+batadv_tt_hash_find(struct batadv_hashtable *hash, const uint8_t *addr,
+		    unsigned short vid)
 {
 	struct hlist_head *head;
-	struct batadv_tt_common_entry *tt_common_entry;
-	struct batadv_tt_common_entry *tt_common_entry_tmp = NULL;
+	struct batadv_tt_common_entry to_search, *tt, *tt_tmp = NULL;
 	uint32_t index;
 
 	if (!hash)
 		return NULL;
 
-	index = batadv_choose_orig(data, hash->size);
+	memcpy(to_search.addr, addr, ETH_ALEN);
+	to_search.vid = vid;
+
+	index = batadv_choose_tt(&to_search, hash->size);
 	head = &hash->table[index];
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(tt_common_entry, head, hash_entry) {
-		if (!batadv_compare_eth(tt_common_entry, data))
+	hlist_for_each_entry_rcu(tt, head, hash_entry) {
+		if (!batadv_compare_eth(tt, addr))
 			continue;
 
-		if (!atomic_inc_not_zero(&tt_common_entry->refcount))
+		if (tt->vid != vid)
 			continue;
 
-		tt_common_entry_tmp = tt_common_entry;
+		if (!atomic_inc_not_zero(&tt->refcount))
+			continue;
+
+		tt_tmp = tt;
 		break;
 	}
 	rcu_read_unlock();
 
-	return tt_common_entry_tmp;
+	return tt_tmp;
 }
 
+/**
+ * batadv_tt_local_hash_find - Search the local table for a given client
+ * @bat_priv: the bat priv with all the soft interface information
+ * @addr: the mac address of the client to look for
+ * @vid: VLAN identifier
+ *
+ * Return a pointer to the corresponding tt_local_entry struct if the client is
+ * found, NULL otherwise
+ */
 static struct batadv_tt_local_entry *
-batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const void *data)
+batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const uint8_t *addr,
+			  unsigned short vid)
 {
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local_entry = NULL;
 
-	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.local_hash, data);
+	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.local_hash, addr,
+					      vid);
 	if (tt_common_entry)
 		tt_local_entry = container_of(tt_common_entry,
 					      struct batadv_tt_local_entry,
@@ -96,13 +148,24 @@ batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const void *data)
 	return tt_local_entry;
 }
 
+/**
+ * batadv_tt_global_hash_find - Search the global table for a given client
+ * @bat_priv: the bat priv with all the soft interface information
+ * @addr: the mac address of the client to look for
+ * @vid: VLAN identifier
+ *
+ * Return a pointer to the corresponding tt_global_entry struct if the client is
+ * found, NULL otherwise
+ */
 static struct batadv_tt_global_entry *
-batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const void *data)
+batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const uint8_t *addr,
+			   unsigned short vid)
 {
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
 
-	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.global_hash, data);
+	tt_common_entry = batadv_tt_hash_find(bat_priv->tt.global_hash, addr,
+					      vid);
 	if (tt_common_entry)
 		tt_global_entry = container_of(tt_common_entry,
 					       struct batadv_tt_global_entry,
@@ -178,6 +241,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 	tt_change_node->change.flags = flags;
 	tt_change_node->change.reserved = 0;
 	memcpy(tt_change_node->change.addr, common->addr, ETH_ALEN);
+	tt_change_node->change.vid = htons(common->vid);
 
 	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
@@ -268,12 +332,21 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 		   tt_global->common.addr, message);
 
 	batadv_hash_remove(bat_priv->tt.global_hash, batadv_compare_tt,
-			   batadv_choose_orig, tt_global->common.addr);
+			   batadv_choose_tt, &tt_global->common);
 	batadv_tt_global_entry_free_ref(tt_global);
 }
 
+/**
+ * batadv_tt_local_add - add a new client to the local table or update it if
+ *  already exists
+ * @soft_iface: netdev struct of the mesh interface
+ * @addr: the mac address of the client to add
+ * @vid: VLAN identifier
+ * @ifindex: index of the interface where the client is connected to (useful to
+ *  identify wireless clients)
+ */
 void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
-			 int ifindex)
+			 unsigned short vid, int ifindex)
 {
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_tt_local_entry *tt_local;
@@ -283,8 +356,8 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	int hash_added;
 	bool roamed_back = false;
 
-	tt_local = batadv_tt_local_hash_find(bat_priv, addr);
-	tt_global = batadv_tt_global_hash_find(bat_priv, addr);
+	tt_local = batadv_tt_local_hash_find(bat_priv, addr, vid);
+	tt_global = batadv_tt_global_hash_find(bat_priv, addr, vid);
 
 	if (tt_local) {
 		tt_local->last_seen = jiffies;
@@ -329,6 +402,7 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 	 * (consistency check)
 	 */
 	tt_local->common.flags = BATADV_TT_CLIENT_NEW;
+	tt_local->common.vid = vid;
 	if (batadv_is_wifi_iface(ifindex))
 		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
 	atomic_set(&tt_local->common.refcount, 2);
@@ -340,7 +414,7 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
 
 	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
-				     batadv_choose_orig, &tt_local->common,
+				     batadv_choose_tt, &tt_local->common,
 				     &tt_local->common.hash_entry);
 
 	if (unlikely(hash_added != 0)) {
@@ -362,6 +436,7 @@ check_roaming:
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(orig_entry, head, list) {
 			batadv_send_roam_adv(bat_priv, tt_global->common.addr,
+					     tt_global->common.vid,
 					     orig_entry->orig_node);
 		}
 		rcu_read_unlock();
@@ -550,19 +625,20 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
  * batadv_tt_local_remove - logically remove an entry from the local table
  * @bat_priv: the bat priv with all the soft interface information
  * @addr: the MAC address of the client to remove
+ * @vid: VLAN identifier
  * @message: message to append to the log on deletion
  * @roaming: true if the deletion is due to a roaming event
  *
  * Returns the flags assigned to the local entry before being deleted
  */
 uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
-				const uint8_t *addr, const char *message,
-				bool roaming)
+				const uint8_t *addr, unsigned short vid,
+				const char *message, bool roaming)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
 	uint16_t flags, curr_flags = BATADV_NO_FLAGS;
 
-	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
+	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
 		goto out;
 
@@ -798,6 +874,7 @@ out:
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: the originator announcing the client
  * @tt_addr: the mac address of the non-mesh client
+ * @vid: VLAN identifier
  * @flags: TT flags that have to be set for this non-mesh client
  * @ttvn: the tt version number ever announcing this non-mesh client
  *
@@ -813,7 +890,8 @@ out:
  */
 static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 				 struct batadv_orig_node *orig_node,
-				 const unsigned char *tt_addr, uint16_t flags,
+				 const unsigned char *tt_addr,
+				 unsigned short vid, uint16_t flags,
 				 uint8_t ttvn)
 {
 	struct batadv_tt_global_entry *tt_global_entry;
@@ -823,8 +901,8 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *common;
 	uint16_t local_flags;
 
-	tt_global_entry = batadv_tt_global_hash_find(bat_priv, tt_addr);
-	tt_local_entry = batadv_tt_local_hash_find(bat_priv, tt_addr);
+	tt_global_entry = batadv_tt_global_hash_find(bat_priv, tt_addr, vid);
+	tt_local_entry = batadv_tt_local_hash_find(bat_priv, tt_addr, vid);
 
 	/* if the node already has a local client for this entry, it has to wait
 	 * for a roaming advertisement instead of manually messing up the global
@@ -841,6 +919,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 
 		common = &tt_global_entry->common;
 		memcpy(common->addr, tt_addr, ETH_ALEN);
+		common->vid = vid;
 
 		common->flags = flags;
 		tt_global_entry->roam_at = 0;
@@ -858,7 +937,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 
 		hash_added = batadv_hash_add(bat_priv->tt.global_hash,
 					     batadv_compare_tt,
-					     batadv_choose_orig, common,
+					     batadv_choose_tt, common,
 					     &common->hash_entry);
 
 		if (unlikely(hash_added != 0)) {
@@ -924,7 +1003,7 @@ add_orig_entry:
 out_remove:
 
 	/* remove address from local hash if present */
-	local_flags = batadv_tt_local_remove(bat_priv, tt_addr,
+	local_flags = batadv_tt_local_remove(bat_priv, tt_addr, vid,
 					     "global tt received",
 					     flags & BATADV_TT_CLIENT_ROAM);
 	tt_global_entry->common.flags |= local_flags & BATADV_TT_CLIENT_WIFI;
@@ -1147,17 +1226,25 @@ batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
 						orig_node, message);
 }
 
-
-
+/**
+ * batadv_tt_global_del - remove a client from the global table
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: an originator serving this client
+ * @addr: the mac address of the client
+ * @vid: VLAN identifier
+ * @message: a message explaining the reason for deleting the client to print
+ *  for debugging purpose
+ * @roaming: true if the deletion has been triggered by a roaming event
+ */
 static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 struct batadv_orig_node *orig_node,
-				 const unsigned char *addr,
+				 const unsigned char *addr, unsigned short vid,
 				 const char *message, bool roaming)
 {
 	struct batadv_tt_global_entry *tt_global_entry;
 	struct batadv_tt_local_entry *local_entry = NULL;
 
-	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr);
+	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr, vid);
 	if (!tt_global_entry)
 		goto out;
 
@@ -1186,7 +1273,8 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 	 *    the global entry, since it is useless now.
 	 */
 	local_entry = batadv_tt_local_hash_find(bat_priv,
-						tt_global_entry->common.addr);
+						tt_global_entry->common.addr,
+						vid);
 	if (local_entry) {
 		/* local entry exists, case 2: client roamed to us. */
 		batadv_tt_global_del_orig_list(tt_global_entry);
@@ -1354,9 +1442,24 @@ _batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
 	return ret;
 }
 
+/**
+ * batadv_transtable_search - get the mesh destination for a given client
+ * @bat_priv: the bat priv with all the soft interface information
+ * @src: mac address of the source client
+ * @addr: mac address of the destination client
+ * @vid: VLAN identifier
+ *
+ * Return a pointer to the originator being the node selected as destination in
+ * the mesh for contacting the client 'addr', NULL otherwise.
+ * In case of multiple originators serving the same client, the function returns
+ * the best one (best in terms of TQ).
+ *
+ * If the two clients are AP isolated the function returns NULL.
+ */
 struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 						  const uint8_t *src,
-						  const uint8_t *addr)
+						  const uint8_t *addr,
+						  unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry = NULL;
 	struct batadv_tt_global_entry *tt_global_entry = NULL;
@@ -1364,13 +1467,13 @@ struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 	struct batadv_tt_orig_list_entry *best_entry;
 
 	if (src && atomic_read(&bat_priv->ap_isolation)) {
-		tt_local_entry = batadv_tt_local_hash_find(bat_priv, src);
+		tt_local_entry = batadv_tt_local_hash_find(bat_priv, src, vid);
 		if (!tt_local_entry ||
 		    (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING))
 			goto out;
 	}
 
-	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr);
+	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr, vid);
 	if (!tt_global_entry)
 		goto out;
 
@@ -1649,6 +1752,7 @@ batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 			memcpy(tt_change->addr, tt_common_entry->addr,
 			       ETH_ALEN);
 			tt_change->flags = tt_common_entry->flags;
+			tt_change->vid = htons(tt_common_entry->vid);
 			tt_change->reserved = 0;
 
 			tt_num_entries++;
@@ -1979,11 +2083,13 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 			roams = (tt_change + i)->flags & BATADV_TT_CLIENT_ROAM;
 			batadv_tt_global_del(bat_priv, orig_node,
 					     (tt_change + i)->addr,
+					     ntohs((tt_change + i)->vid),
 					     "tt removed by changes",
 					     roams);
 		} else {
 			if (!batadv_tt_global_add(bat_priv, orig_node,
 						  (tt_change + i)->addr,
+						  ntohs((tt_change + i)->vid),
 						  (tt_change + i)->flags, ttvn))
 				/* In case of problem while storing a
 				 * global_entry, we stop the updating
@@ -2040,12 +2146,21 @@ static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
 	atomic_set(&orig_node->last_ttvn, ttvn);
 }
 
-bool batadv_is_my_client(struct batadv_priv *bat_priv, const uint8_t *addr)
+/**
+ * batadv_is_my_client - check if a client is served by the local node
+ * @bat_priv: the bat priv with all the soft interface information
+ * @addr: the mac adress of the client to check
+ * @vid: VLAN identifier
+ *
+ * Return true if the client is served by this node, false otherwise
+ */
+bool batadv_is_my_client(struct batadv_priv *bat_priv, const uint8_t *addr,
+			 unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
 	bool ret = false;
 
-	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
+	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
 		goto out;
 	/* Check if the client has been logically deleted (but is kept for
@@ -2194,7 +2309,19 @@ unlock:
 	return ret;
 }
 
+/**
+ * batadv_send_roam_adv - send a roaming advertisement message
+ * @bat_priv: the bat priv with all the soft interface information
+ * @client: mac address of the roaming client
+ * @vid: VLAN identifier
+ * @orig_node: message destination
+ *
+ * Send a ROAMING_ADV message to the node which was previously serving this
+ * client. This is done to inform the originator that now all the traffic
+ * directed to the provided mac address has to be forwarded here
+ */
 static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
+				 unsigned short vid,
 				 struct batadv_orig_node *orig_node)
 {
 	struct batadv_hard_iface *primary_if;
@@ -2217,6 +2344,7 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, uint8_t *client,
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_ROAM_ADV_TX);
 
 	memcpy(tvlv_roam.client, client, sizeof(tvlv_roam.client));
+	tvlv_roam.vid = htons(vid);
 
 	batadv_tvlv_unicast_send(bat_priv, primary_if->net_dev->dev_addr,
 				 orig_node->orig, BATADV_TVLV_ROAM, 1,
@@ -2382,11 +2510,13 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, uint8_t *src,
 	if (!atomic_read(&bat_priv->ap_isolation))
 		goto out;
 
-	tt_local_entry = batadv_tt_local_hash_find(bat_priv, dst);
+	tt_local_entry = batadv_tt_local_hash_find(bat_priv, dst,
+						   BATADV_NO_FLAGS);
 	if (!tt_local_entry)
 		goto out;
 
-	tt_global_entry = batadv_tt_global_hash_find(bat_priv, src);
+	tt_global_entry = batadv_tt_global_hash_find(bat_priv, src,
+						     BATADV_NO_FLAGS);
 	if (!tt_global_entry)
 		goto out;
 
@@ -2481,17 +2611,23 @@ request_table:
 	}
 }
 
-/* returns true whether we know that the client has moved from its old
- * originator to another one. This entry is kept is still kept for consistency
- * purposes
+/**
+ * batadv_tt_global_client_is_roaming - check if a client is marked as roaming
+ * @bat_priv: the bat priv with all the soft interface information
+ * @addr: the mac address of the client to check
+ * @vid: VLAN identifier
+ *
+ * Return true whether we know that the client has moved from its old originator
+ * to another one. This entry is still kept for consistency purposes and will be
+ * deleted later by a DEL or because of timeout
  */
 bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
-					uint8_t *addr)
+					uint8_t *addr, unsigned short vid)
 {
 	struct batadv_tt_global_entry *tt_global_entry;
 	bool ret = false;
 
-	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr);
+	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr, vid);
 	if (!tt_global_entry)
 		goto out;
 
@@ -2504,19 +2640,20 @@ out:
 /**
  * batadv_tt_local_client_is_roaming - tells whether the client is roaming
  * @bat_priv: the bat priv with all the soft interface information
- * @addr: the MAC address of the local client to query
+ * @addr: the mac address of the local client to query
+ * @vid: VLAN identifier
  *
  * Returns true if the local client is known to be roaming (it is not served by
  * this node anymore) or not. If yes, the client is still present in the table
  * to keep the latter consistent with the node TTVN
  */
 bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
-				       uint8_t *addr)
+				       uint8_t *addr, unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
 	bool ret = false;
 
-	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr);
+	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
 		goto out;
 
@@ -2528,7 +2665,8 @@ out:
 
 bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node,
-					  const unsigned char *addr)
+					  const unsigned char *addr,
+					  unsigned short vlan)
 {
 	bool ret = false;
 
@@ -2539,7 +2677,7 @@ bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig))
 		goto out;
 
-	if (!batadv_tt_global_add(bat_priv, orig_node, addr,
+	if (!batadv_tt_global_add(bat_priv, orig_node, addr, vlan,
 				  BATADV_TT_CLIENT_TEMP,
 				  atomic_read(&orig_node->last_ttvn)))
 		goto out;
@@ -2705,7 +2843,7 @@ static int batadv_roam_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 		   src, roaming_adv->client);
 
 	batadv_tt_global_add(bat_priv, orig_node, roaming_adv->client,
-			     BATADV_TT_CLIENT_ROAM,
+			     ntohs(roaming_adv->vid), BATADV_TT_CLIENT_ROAM,
 			     atomic_read(&orig_node->last_ttvn) + 1);
 
 out:
diff --git a/translation-table.h b/translation-table.h
index 015d8b9..1d9506d 100644
--- a/translation-table.h
+++ b/translation-table.h
@@ -22,10 +22,10 @@
 
 int batadv_tt_init(struct batadv_priv *bat_priv);
 void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
-			 int ifindex);
+			 unsigned short vid, int ifindex);
 uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
-				const uint8_t *addr, const char *message,
-				bool roaming);
+				const uint8_t *addr, unsigned short vid,
+				const char *message, bool roaming);
 int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_tt_global_seq_print_text(struct seq_file *seq, void *offset);
 void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
@@ -33,18 +33,21 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 			       const char *message);
 struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 						  const uint8_t *src,
-						  const uint8_t *addr);
+						  const uint8_t *addr,
+						  unsigned short vid);
 void batadv_tt_free(struct batadv_priv *bat_priv);
-bool batadv_is_my_client(struct batadv_priv *bat_priv, const uint8_t *addr);
+bool batadv_is_my_client(struct batadv_priv *bat_priv, const uint8_t *addr,
+			 unsigned short vid);
 bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, uint8_t *src,
 			   uint8_t *dst);
 void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv);
 bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
-					uint8_t *addr);
+					uint8_t *addr, unsigned short vid);
 bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
-				       uint8_t *addr);
+				       uint8_t *addr, unsigned short vid);
 bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node,
-					  const unsigned char *addr);
+					  const unsigned char *addr,
+					  unsigned short vid);
 
 #endif /* _NET_BATMAN_ADV_TRANSLATION_TABLE_H_ */
diff --git a/types.h b/types.h
index c388e47..8841a1a 100644
--- a/types.h
+++ b/types.h
@@ -722,6 +722,7 @@ struct batadv_bla_claim {
 /**
  * struct batadv_tt_common_entry - tt local & tt global common data
  * @addr: mac address of non-mesh client
+ * @vid: VLAN identifier
  * @hash_entry: hlist node for batadv_priv_tt::local_hash or for
  *  batadv_priv_tt::global_hash
  * @flags: various state handling flags (see batadv_tt_client_flags)
@@ -731,6 +732,7 @@ struct batadv_bla_claim {
  */
 struct batadv_tt_common_entry {
 	uint8_t addr[ETH_ALEN];
+	unsigned short vid;
 	struct hlist_node hash_entry;
 	uint16_t flags;
 	unsigned long added_at;
-- 
1.8.1.5

