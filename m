Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri, 30 Nov 2012 16:08:33 +0100
Message-Id: <96863da15554203e10f89fde514157b1acaed698.1354287613.git.martin@hundeboll.net>
In-Reply-To: <cover.1354287613.git.martin@hundeboll.net>
References: <cover.1354287613.git.martin@hundeboll.net>
In-Reply-To: <cover.1354287613.git.martin@hundeboll.net>
References: <cover.1354287613.git.martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: Code and transmit packets if
	possible.
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Before adding forward-skbs to the coding buffer, the buffer is searched
for a potential coding opportunity. If one is found, the two packets are
network coded and transmitted right away. If not, the forward-skb is
added to the buffer.

Network coded packets are transmitted with information about the two
receivers and the two coded packets. The first receiver is given by the
MAC header, while the second is given in the payload/bat-header. The
second receiver uses promiscuous mode to receive the packet and check
the second destination.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 main.h           |   6 +
 network-coding.c | 394 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 packet.h         |  33 +++++
 soft-interface.c |   6 +
 types.h          |  16 +++
 5 files changed, 455 insertions(+)

diff --git a/main.h b/main.h
index 9fd81b8..c738d27 100644
--- a/main.h
+++ b/main.h
@@ -303,4 +303,10 @@ static inline uint64_t batadv_sum_counter(struct batadv_priv *bat_priv,
 	return sum;
 }
 
+/* Define a macro to reach the control buffer of the skb. The members of the
+ * control buffer are defined in struct bat_skb_cb in types.h.
+ * The macro is inspired by the similar macro TCP_SKB_CB() in tcp.h.
+ */
+#define BATADV_SKB_CB(__skb)       ((struct batadv_skb_cb *)&((__skb)->cb[0]))
+
 #endif /* _NET_BATMAN_ADV_MAIN_H_ */
diff --git a/network-coding.c b/network-coding.c
index 85288f2..ebbe0e9 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -803,6 +803,396 @@ static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_random_weight_tq - scale the receivers TQ-value to avoid unfair
+ *  selection of a receiver with slightly lower TQ than the other
+ * @tq: to be weighted tq value
+ */
+static uint8_t batadv_random_weight_tq(uint8_t tq)
+{
+	uint8_t rand_val, rand_tq;
+
+	get_random_bytes(&rand_val, sizeof(rand_val));
+
+	rand_tq = rand_val * (BATADV_TQ_MAX_VALUE - tq);
+	rand_tq /= BATADV_TQ_MAX_VALUE;
+
+	return BATADV_TQ_MAX_VALUE - rand_tq;
+}
+
+/* Code the bytes from data2 into data1 */
+static void batadv_memxor(char *data1, const char *data2,
+				 unsigned int len)
+{
+	unsigned int i;
+
+	for (i = 0; i < len; ++i)
+		data1[i] ^= data2[i];
+}
+
+/**
+ * batadv_nc_code_packets - code a received unicast_packet with an nc packet
+ *  into a coded_packet and send it
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: data skb to forward
+ * @ethhdr: pointer to the ethernet header inside the skb
+ * @nc_packet: structure containing the packet to the skb can be coded with
+ * @neigh_node: next hop to forward packet to
+ *
+ * Returns true if both packets are consumed, false otherwise.
+ */
+static bool batadv_nc_code_packets(struct batadv_priv *bat_priv,
+				   struct sk_buff *skb,
+				   struct ethhdr *ethhdr,
+				   struct batadv_nc_packet *nc_packet,
+				   struct batadv_neigh_node *neigh_node)
+{
+	const int unicast_size = sizeof(struct batadv_unicast_packet);
+	const int coded_size = sizeof(struct batadv_coded_packet);
+	const int header_add = sizeof(struct batadv_coded_packet) -
+			       sizeof(struct batadv_unicast_packet);
+	unsigned int coding_len;
+	uint8_t tq_weighted_neigh, tq_weighted_coding;
+	struct sk_buff *skb_dest, *skb_src;
+	struct batadv_unicast_packet *packet1;
+	struct batadv_unicast_packet *packet2;
+	struct batadv_coded_packet *coded_packet;
+	struct batadv_neigh_node *neigh_tmp, *router_neigh;
+	struct batadv_neigh_node *router_coding = NULL;
+	uint8_t *first_source, *first_dest, *second_source, *second_dest;
+	__be32 packet_id1, packet_id2;
+	size_t count;
+	bool res = false;
+
+	router_neigh = batadv_orig_node_get_router(neigh_node->orig_node);
+	if (!router_neigh)
+		goto out;
+
+	neigh_tmp = nc_packet->neigh_node;
+	router_coding = batadv_orig_node_get_router(neigh_tmp->orig_node);
+	if (!router_coding)
+		goto out;
+
+	tq_weighted_neigh = batadv_random_weight_tq(router_neigh->tq_avg);
+	tq_weighted_coding = batadv_random_weight_tq(router_coding->tq_avg);
+
+	/* Select one destination for the MAC-header dst-field based on
+	 * weighted TQ-values.
+	 */
+	if (tq_weighted_neigh >= tq_weighted_coding) {
+		/* Destination from nc_packet is selected for MAC-header */
+		first_dest = nc_packet->nc_path->next_hop;
+		first_source = nc_packet->nc_path->prev_hop;
+		second_dest = neigh_node->addr;
+		second_source = ethhdr->h_source;
+		packet1 = (struct batadv_unicast_packet *)nc_packet->skb->data;
+		packet2 = (struct batadv_unicast_packet *)skb->data;
+		packet_id1 = nc_packet->packet_id;
+		packet_id2 = batadv_skb_crc32(skb,
+					      skb->data + sizeof(*packet2));
+	} else {
+		/* Destination for skb is selected for MAC-header */
+		first_dest = neigh_node->addr;
+		first_source = ethhdr->h_source;
+		second_dest = nc_packet->nc_path->next_hop;
+		second_source = nc_packet->nc_path->prev_hop;
+		packet1 = (struct batadv_unicast_packet *)skb->data;
+		packet2 = (struct batadv_unicast_packet *)nc_packet->skb->data;
+		packet_id1 = batadv_skb_crc32(skb,
+					      skb->data + sizeof(*packet1));
+		packet_id2 = nc_packet->packet_id;
+	}
+
+	/* Instead of zero padding the smallest data buffer, we
+	 * code into the largest.
+	 */
+	if (skb->len <= nc_packet->skb->len) {
+		skb_dest = nc_packet->skb;
+		skb_src = skb;
+	} else {
+		skb_dest = skb;
+		skb_src = nc_packet->skb;
+	}
+
+	/* coding_len is used when decoding the packet */
+	coding_len = skb_src->len - unicast_size;
+
+	/* Make room for the larger coded_packet header. */
+	if (skb_cow(skb_dest, header_add) < 0)
+		goto out;
+
+	if (skb_linearize(skb_dest) < 0 || skb_linearize(skb_src) < 0)
+		goto out;
+
+	skb_push(skb_dest, header_add);
+
+	coded_packet = (struct batadv_coded_packet *)skb_dest->data;
+	skb_reset_mac_header(skb_dest);
+
+	coded_packet->header.packet_type = BATADV_CODED;
+	coded_packet->header.version = BATADV_COMPAT_VERSION;
+	coded_packet->header.ttl = packet1->header.ttl;
+
+	/* Info about first unicast packet */
+	memcpy(coded_packet->first_source, first_source, ETH_ALEN);
+	memcpy(coded_packet->first_orig_dest, packet1->dest, ETH_ALEN);
+	coded_packet->first_crc = packet_id1;
+	coded_packet->first_ttvn = packet1->ttvn;
+
+	/* Info about second unicast packet */
+	memcpy(coded_packet->second_dest, second_dest, ETH_ALEN);
+	memcpy(coded_packet->second_source, second_source, ETH_ALEN);
+	memcpy(coded_packet->second_orig_dest, packet2->dest, ETH_ALEN);
+	coded_packet->second_crc = packet_id2;
+	coded_packet->second_ttl = packet2->header.ttl;
+	coded_packet->second_ttvn = packet2->ttvn;
+	coded_packet->coded_len = htons(coding_len);
+
+	/* This is where the magic happens: Code skb_src into skb_dest */
+	batadv_memxor(skb_dest->data + coded_size, skb_src->data + unicast_size,
+		      coding_len);
+
+	/* Update counters accordingly */
+	if (BATADV_SKB_CB(skb_src)->decoded &&
+	    BATADV_SKB_CB(skb_dest)->decoded) {
+		/* Both packets are recoded */
+		count = skb_src->len + ETH_HLEN;
+		count += skb_dest->len + ETH_HLEN;
+		batadv_add_counter(bat_priv, BATADV_CNT_NC_RECODE, 2);
+		batadv_add_counter(bat_priv, BATADV_CNT_NC_RECODE_BYTES, count);
+	} else if (!BATADV_SKB_CB(skb_src)->decoded &&
+		   !BATADV_SKB_CB(skb_dest)->decoded) {
+		/* Both packets are newly coded */
+		count = skb_src->len + ETH_HLEN;
+		count += skb_dest->len + ETH_HLEN;
+		batadv_add_counter(bat_priv, BATADV_CNT_NC_CODE, 2);
+		batadv_add_counter(bat_priv, BATADV_CNT_NC_CODE_BYTES, count);
+	} else if (BATADV_SKB_CB(skb_src)->decoded &&
+		   !BATADV_SKB_CB(skb_dest)->decoded) {
+		/* skb_src recoded and skb_dest is newly coded */
+		batadv_inc_counter(bat_priv, BATADV_CNT_NC_RECODE);
+		batadv_add_counter(bat_priv, BATADV_CNT_NC_RECODE_BYTES,
+				   skb_src->len + ETH_HLEN);
+		batadv_inc_counter(bat_priv, BATADV_CNT_NC_CODE);
+		batadv_add_counter(bat_priv, BATADV_CNT_NC_CODE_BYTES,
+				   skb_dest->len + ETH_HLEN);
+	} else if (!BATADV_SKB_CB(skb_src)->decoded &&
+		   BATADV_SKB_CB(skb_dest)->decoded) {
+		/* skb_src is newly coded and skb_dest is recoded */
+		batadv_inc_counter(bat_priv, BATADV_CNT_NC_CODE);
+		batadv_add_counter(bat_priv, BATADV_CNT_NC_CODE_BYTES,
+				   skb_src->len + ETH_HLEN);
+		batadv_inc_counter(bat_priv, BATADV_CNT_NC_RECODE);
+		batadv_add_counter(bat_priv, BATADV_CNT_NC_RECODE_BYTES,
+				   skb_dest->len + ETH_HLEN);
+	}
+
+	/* skb_dest might be the one from nc_packet, so free only skb_src */
+	kfree_skb(skb_src);
+	nc_packet->skb = NULL;
+	batadv_nc_packet_free(nc_packet);
+
+	/* Send the coded packet and return true */
+	batadv_send_skb_packet(skb_dest, neigh_node->if_incoming, first_dest);
+	res = true;
+out:
+	if (router_neigh)
+		batadv_neigh_node_free_ref(router_neigh);
+	if (router_coding)
+		batadv_neigh_node_free_ref(router_coding);
+	return res;
+}
+
+/**
+ * batadv_nc_skb_coding_possible - Whenever we network code a packet we have to
+ *  check whether we received it in a network coded form. If so, we may not be
+ *  able to use it for coding because some neighbors may also have received
+ *  (overheard) the packet in the network coded form without being able to
+ *  decode it. It is hard to know which of the neighboring nodes was able to
+ *  decode the packet, therefore we can only re-code the packet if the source
+ *  of the previous encoded packet is involved. Since the source encoded the
+ *  packet we can be certain it has all necessary decode information.
+ * @skb: data skb to forward
+ * @dst: destination mac address of the other skb to code with
+ * @src: source mac address of skb
+ *
+ * Returns true if coding of a decoded packet is allowed.
+ */
+static bool batadv_nc_skb_coding_possible(struct sk_buff *skb,
+						 uint8_t *dst,
+						 uint8_t *src)
+{
+	if (BATADV_SKB_CB(skb)->decoded && !batadv_compare_eth(dst, src))
+		return false;
+	else
+		return true;
+}
+
+/**
+ * batadv_nc_path_search - Find the coding path matching in_nc_node and
+ *  out_nc_node to retrieve a buffered packet that can be used for coding.
+ * @bat_priv: the bat priv with all the soft interface information
+ * @in_nc_node: pointer to skb next hop's neighbor nc node
+ * @out_nc_node: pointer to skb source's neighbor nc node
+ * @skb: data skb to forward
+ * @eth_dst: next hop mac address of skb
+ *
+ * Returns true if coding of a decoded skb is allowed.
+ */
+static struct batadv_nc_packet *
+batadv_nc_path_search(struct batadv_priv *bat_priv,
+		      struct batadv_nc_node *in_nc_node,
+		      struct batadv_nc_node *out_nc_node,
+		      struct sk_buff *skb,
+		      uint8_t *eth_dst)
+{
+	struct batadv_nc_path *nc_path, nc_path_key;
+	struct batadv_nc_packet *nc_packet_out = NULL;
+	struct batadv_nc_packet *nc_packet, *nc_packet_tmp;
+	struct hlist_node *node;
+	struct batadv_hashtable *hash = bat_priv->nc.coding_hash;
+	int idx;
+
+	if (!hash)
+		return NULL;
+
+	/* Create almost path key */
+	batadv_nc_hash_key_gen(&nc_path_key, in_nc_node->addr,
+			       out_nc_node->addr);
+	idx = batadv_nc_hash_choose(&nc_path_key, hash->size);
+
+	/* Check for coding opportunities in this nc_path */
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(nc_path, node, &hash->table[idx], hash_entry) {
+		if (!batadv_compare_eth(nc_path->prev_hop, in_nc_node->addr))
+			continue;
+
+		if (!batadv_compare_eth(nc_path->next_hop, out_nc_node->addr))
+			continue;
+
+		spin_lock_bh(&nc_path->packet_list_lock);
+		if (list_empty(&nc_path->packet_list)) {
+			spin_unlock_bh(&nc_path->packet_list_lock);
+			continue;
+		}
+
+		list_for_each_entry_safe(nc_packet, nc_packet_tmp,
+					 &nc_path->packet_list, list) {
+			if (!batadv_nc_skb_coding_possible(nc_packet->skb,
+							   eth_dst,
+							   in_nc_node->addr))
+				continue;
+
+			/* Coding opportunity is found! */
+			list_del(&nc_packet->list);
+			nc_packet_out = nc_packet;
+			break;
+		}
+
+		spin_unlock_bh(&nc_path->packet_list_lock);
+		break;
+	}
+	rcu_read_unlock();
+
+	return nc_packet_out;
+}
+
+/**
+ * batadv_nc_skb_src_search - Loops through the list of neighoring nodes of the
+ *  skb's sender (may be equal to the originator).
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: data skb to forward
+ * @eth_dst: next hop mac address of skb
+ * @eth_src: source mac address of skb
+ * @in_nc_node: pointer to skb next hop's neighbor nc node
+ *
+ * Returns an nc packet if a suitable coding packet was found, NULL otherwise.
+ */
+static struct batadv_nc_packet *
+batadv_nc_skb_src_search(struct batadv_priv *bat_priv,
+			 struct sk_buff *skb,
+			 uint8_t *eth_dst,
+			 uint8_t *eth_src,
+			 struct batadv_nc_node *in_nc_node)
+{
+	struct batadv_orig_node *orig_node;
+	struct batadv_nc_node *out_nc_node;
+	struct batadv_nc_packet *nc_packet = NULL;
+
+	orig_node = batadv_orig_hash_find(bat_priv, eth_src);
+	if (!orig_node)
+		return NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(out_nc_node,
+				&orig_node->out_coding_list, list) {
+		/* Check if the skb is decoded and if recoding is possible */
+		if (!batadv_nc_skb_coding_possible(skb,
+						   out_nc_node->addr, eth_src))
+			continue;
+
+		/* Search for an opportunity in this nc_path */
+		nc_packet = batadv_nc_path_search(bat_priv, in_nc_node,
+						  out_nc_node, skb, eth_dst);
+		if (nc_packet)
+			break;
+	}
+	rcu_read_unlock();
+
+	batadv_orig_node_free_ref(orig_node);
+	return nc_packet;
+}
+
+/**
+ * batadv_nc_skb_dst_search - Loops through list of neighboring nodes the next
+ *  hop has a good connection to (receives OGMs with a sufficient quality). We
+ *  need to find a neighbor of our next hop that potentially sent a packet which
+ *  our next hop also received (overheard) and has stored for later decoding.
+ * @skb: data skb to forward
+ * @neigh_node: next hop to forward packet to
+ * @ethhdr: pointer to the ethernet header inside the skb
+ *
+ * Returns true if the skb was consumed (encoded packet sent) or false otherwise
+ */
+static bool batadv_nc_skb_dst_search(struct sk_buff *skb,
+				     struct batadv_neigh_node *neigh_node,
+				     struct ethhdr *ethhdr)
+{
+	struct net_device *netdev = neigh_node->if_incoming->soft_iface;
+	struct batadv_priv *bat_priv = netdev_priv(netdev);
+	struct batadv_orig_node *orig_node = neigh_node->orig_node;
+	struct batadv_nc_node *nc_node;
+	struct batadv_nc_packet *nc_packet = NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(nc_node, &orig_node->in_coding_list, list) {
+		/* Search for coding opportunity with this in_nc_node */
+		nc_packet = batadv_nc_skb_src_search(bat_priv, skb,
+						     neigh_node->addr,
+						     ethhdr->h_source, nc_node);
+
+		/* Opportunity was found, so stop searching */
+		if (nc_packet)
+			break;
+	}
+	rcu_read_unlock();
+
+	if (!nc_packet)
+		return false;
+
+	/* Code and send packets */
+	if (batadv_nc_code_packets(bat_priv, skb, ethhdr, nc_packet,
+				   neigh_node))
+		return true;
+
+	/* out of mem ? Coding failed - we have to free the buffered packet
+	 * to avoid memleaks. The skb passed as argument will be dealt with
+	 * by the calling function.
+	 */
+	batadv_nc_send_packet(nc_packet);
+	return false;
+}
+
+/**
  * batadv_nc_skb_add_to_path - buffer skb for later encoding / decoding
  * @skb: skb to add to path
  * @nc_path: path to add skb to
@@ -867,6 +1257,10 @@ bool batadv_nc_skb_forward(struct sk_buff *skb,
 	if (packet->header.packet_type != BATADV_UNICAST)
 		goto out;
 
+	/* Try to find a coding opportunity and send the skb if one is found */
+	if (batadv_nc_skb_dst_search(skb, neigh_node, ethhdr))
+		return true;
+
 	/* Find or create a nc_path for this src-dst pair */
 	nc_path = batadv_nc_get_path(bat_priv,
 				     bat_priv->nc.coding_hash,
diff --git a/packet.h b/packet.h
index cb6405b..49ab4f6 100644
--- a/packet.h
+++ b/packet.h
@@ -30,6 +30,7 @@ enum batadv_packettype {
 	BATADV_TT_QUERY		= 0x07,
 	BATADV_ROAM_ADV		= 0x08,
 	BATADV_UNICAST_4ADDR	= 0x09,
+	BATADV_CODED		= 0x0a,
 };
 
 /**
@@ -278,4 +279,36 @@ struct batadv_tt_change {
 	uint8_t addr[ETH_ALEN];
 } __packed;
 
+/**
+ * struct batadv_coded_packet - network coded packet
+ * @header: common batman packet header and ttl of first included packet
+ * @reserved: Align following fields to 2-byte boundaries
+ * @first_source: original source of first included packet
+ * @first_orig_dest: original destinal of first included packet
+ * @first_crc: checksum of first included packet
+ * @first_ttvn: tt-version number of first included packet
+ * @second_ttl: ttl of second packet
+ * @second_dest: second receiver of this coded packet
+ * @second_source: original source of second included packet
+ * @second_orig_dest: original destination of second included packet
+ * @second_crc: checksum of second included packet
+ * @second_ttvn: tt version number of second included packet
+ * @coded_len: length of network coded part of the payload
+ */
+struct batadv_coded_packet {
+	struct batadv_header header;
+	uint8_t  first_ttvn;
+	/* uint8_t  first_dest[ETH_ALEN]; - saved in mac header destination */
+	uint8_t  first_source[ETH_ALEN];
+	uint8_t  first_orig_dest[ETH_ALEN];
+	__be32   first_crc;
+	uint8_t  second_ttl;
+	uint8_t  second_ttvn;
+	uint8_t  second_dest[ETH_ALEN];
+	uint8_t  second_source[ETH_ALEN];
+	uint8_t  second_orig_dest[ETH_ALEN];
+	__be32   second_crc;
+	uint16_t coded_len;
+};
+
 #endif /* _NET_BATMAN_ADV_PACKET_H_ */
diff --git a/soft-interface.c b/soft-interface.c
index 69ad5e2..83abdf9 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -636,6 +636,12 @@ static const struct {
 	{ "dat_put_rx" },
 	{ "dat_cached_reply_tx" },
 #endif
+#ifdef CONFIG_BATMAN_ADV_NC
+	{ "nc_code" },
+	{ "nc_code_bytes" },
+	{ "nc_recode" },
+	{ "nc_recode_bytes" },
+#endif
 };
 
 static void batadv_get_strings(struct net_device *dev, uint32_t stringset,
diff --git a/types.h b/types.h
index b34fde7..a44e948 100644
--- a/types.h
+++ b/types.h
@@ -192,6 +192,12 @@ enum batadv_counters {
 	BATADV_CNT_DAT_PUT_RX,
 	BATADV_CNT_DAT_CACHED_REPLY_TX,
 #endif
+#ifdef CONFIG_BATMAN_ADV_NC
+	BATADV_CNT_NC_CODE,
+	BATADV_CNT_NC_CODE_BYTES,
+	BATADV_CNT_NC_RECODE,
+	BATADV_CNT_NC_RECODE_BYTES,
+#endif
 	BATADV_CNT_NUM,
 };
 
@@ -490,6 +496,16 @@ struct batadv_nc_packet {
 	struct batadv_nc_path *nc_path;
 };
 
+/**
+ * batadv_skb_cb - control buffer structure used to store private data relevant
+ *  to batman-adv in the skb->cb buffer in skbs.
+ * @decoded: Marks a skb as decoded, which is checked when searching for coding
+ *  opportunities in network-coding.c
+ */
+struct batadv_skb_cb {
+	bool decoded;
+};
+
 /*	forw_packet - structure for forw_list maintaining packets to be
  *	              send/forwarded
  */
-- 
1.8.0.1

