Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri, 14 Dec 2012 07:32:52 +0100
Message-Id: <66c208d5aff25f1835c1da8b744adb5d28318178.1355466678.git.martin@hundeboll.net>
In-Reply-To: <cover.1355466678.git.martin@hundeboll.net>
References: <cover.1355466678.git.martin@hundeboll.net>
In-Reply-To: <cover.1355466678.git.martin@hundeboll.net>
References: <cover.1355466678.git.martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 7/7] batman-adv: Receive coded packets and
	decode them.
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

When receiving a network coded packet, the decoding buffer is searched
for a packet to use for decoding. The source, destination, and crc32 from
the coded packet is used to identify the wanted packet. The decoded
packet is passed to the usual unicast receiver function, as had it never
been network coded.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 network-coding.c | 230 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 soft-interface.c |   4 +
 types.h          |   4 +
 3 files changed, 238 insertions(+)

diff --git a/network-coding.c b/network-coding.c
index b148ccb..61f6ec8 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -25,11 +25,14 @@
 #include "send.h"
 #include "originator.h"
 #include "hard-interface.h"
+#include "routing.h"
 
 static struct lock_class_key batadv_nc_coding_hash_lock_class_key;
 static struct lock_class_key batadv_nc_decoding_hash_lock_class_key;
 
 static void batadv_nc_worker(struct work_struct *work);
+static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
+				       struct batadv_hard_iface *recv_if);
 
 /**
  * batadv_nc_start_timer - initialise the nc periodic worker
@@ -67,6 +70,11 @@ int batadv_nc_init(struct batadv_priv *bat_priv)
 	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
 				   &batadv_nc_decoding_hash_lock_class_key);
 
+	/* Register our packet type */
+	if (batadv_recv_handler_register(BATADV_CODED,
+					 batadv_nc_recv_coded_packet) < 0)
+		goto err;
+
 	INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);
 	batadv_nc_start_timer(bat_priv);
 
@@ -1494,11 +1502,233 @@ void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_nc_skb_decode_packet - decode given skb using the decode data stored
+ *  in nc_packet
+ * @skb: unicast skb to decode
+ * @nc_packet: decode data needed to decode the skb
+ *
+ * Returns pointer to decoded unicast packet if the packet was decoded or NULL
+ * in case of an error.
+ */
+static struct batadv_unicast_packet *
+batadv_nc_skb_decode_packet(struct sk_buff *skb,
+			    struct batadv_nc_packet *nc_packet)
+{
+	const int h_size = sizeof(struct batadv_unicast_packet);
+	const int h_diff = sizeof(struct batadv_coded_packet) - h_size;
+	struct batadv_unicast_packet *unicast_packet;
+	struct batadv_coded_packet coded_packet_tmp;
+	struct ethhdr *ethhdr, ethhdr_tmp;
+	uint8_t *orig_dest, ttl, ttvn;
+	unsigned int coding_len;
+
+	/* Save headers temporarily */
+	memcpy(&coded_packet_tmp, skb->data, sizeof(coded_packet_tmp));
+	memcpy(&ethhdr_tmp, skb_mac_header(skb), sizeof(ethhdr_tmp));
+
+	if (skb_cow(skb, 0) < 0)
+		return NULL;
+
+	if (unlikely(!skb_pull_rcsum(skb, h_diff)))
+		return NULL;
+
+	/* Data points to batman header, so set mac header 14 bytes before
+	 * and network to data
+	 */
+	skb_set_mac_header(skb, -ETH_HLEN);
+	skb_reset_network_header(skb);
+
+	/* Reconstruct original mac header */
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	memcpy(ethhdr, &ethhdr_tmp, sizeof(*ethhdr));
+
+	/* Select the correct unicast header information based on the location
+	 * of our mac address in the coded_packet header
+	 */
+	if (batadv_is_my_mac(coded_packet_tmp.second_dest)) {
+		/* If we are the second destination the packet was overheard,
+		 * so the Ethernet address must be copied to h_dest and
+		 * pkt_type changed from PACKET_OTHERHOST to PACKET_HOST
+		 */
+		memcpy(ethhdr->h_dest, coded_packet_tmp.second_dest, ETH_ALEN);
+		skb->pkt_type = PACKET_HOST;
+
+		orig_dest = coded_packet_tmp.second_orig_dest;
+		ttl = coded_packet_tmp.second_ttl;
+		ttvn = coded_packet_tmp.second_ttvn;
+	} else {
+		orig_dest = coded_packet_tmp.first_orig_dest;
+		ttl = coded_packet_tmp.header.ttl;
+		ttvn = coded_packet_tmp.first_ttvn;
+	}
+
+	coding_len = ntohs(coded_packet_tmp.coded_len);
+
+	if (coding_len > skb->len)
+		return NULL;
+
+	/* Here the magic is reversed:
+	 *   extract the missing packet from the received coded packet
+	 */
+	batadv_nc_memxor(skb->data + h_size,
+			 nc_packet->skb->data + h_size,
+			 coding_len);
+
+	/* Resize decoded skb if decoded with larger packet */
+	if (nc_packet->skb->len > coding_len + h_size)
+		pskb_trim_rcsum(skb, coding_len + h_size);
+
+	/* Create decoded unicast packet */
+	unicast_packet = (struct batadv_unicast_packet *)skb->data;
+	unicast_packet->header.packet_type = BATADV_UNICAST;
+	unicast_packet->header.version = BATADV_COMPAT_VERSION;
+	unicast_packet->header.ttl = ttl;
+	memcpy(unicast_packet->dest, orig_dest, ETH_ALEN);
+	unicast_packet->ttvn = ttvn;
+
+	batadv_nc_packet_free(nc_packet);
+	return unicast_packet;
+}
+
+/**
+ * batadv_nc_find_decoding_packet - search through buffered decoding data to
+ *  find the data needed to decode the coded packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ethhdr: pointer to the ethernet header inside the coded packet
+ * @coded: coded packet we try to find decode data for
+ *
+ * Returns pointer to nc packet if the needed data was found or NULL otherwise.
+ */
+static struct batadv_nc_packet *
+batadv_nc_find_decoding_packet(struct batadv_priv *bat_priv,
+			       struct ethhdr *ethhdr,
+			       struct batadv_coded_packet *coded)
+{
+	struct batadv_hashtable *hash = bat_priv->nc.decoding_hash;
+	struct hlist_node *hnode;
+	struct batadv_nc_packet *tmp_nc_packet, *nc_packet = NULL;
+	struct batadv_nc_path *nc_path, nc_path_key;
+	uint8_t *dest, *source;
+	__be32 packet_id;
+	int index;
+
+	if (!hash)
+		return NULL;
+
+	/* Select the correct packet id based on the location of our mac-addr */
+	dest = ethhdr->h_source;
+	if (!batadv_is_my_mac(coded->second_dest)) {
+		source = coded->second_source;
+		packet_id = coded->second_crc;
+	} else {
+		source = coded->first_source;
+		packet_id = coded->first_crc;
+	}
+
+	batadv_nc_hash_key_gen(&nc_path_key, source, dest);
+	index = batadv_nc_hash_choose(&nc_path_key, hash->size);
+
+	/* Search for matching coding path */
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(nc_path, hnode, &hash->table[index],
+				 hash_entry) {
+		/* Find matching nc_packet */
+		spin_lock_bh(&nc_path->packet_list_lock);
+		list_for_each_entry(tmp_nc_packet,
+				    &nc_path->packet_list, list) {
+			if (packet_id == tmp_nc_packet->packet_id) {
+				list_del(&tmp_nc_packet->list);
+
+				nc_packet = tmp_nc_packet;
+				break;
+			}
+		}
+		spin_unlock_bh(&nc_path->packet_list_lock);
+
+		if (nc_packet)
+			break;
+	}
+	rcu_read_unlock();
+
+	if (!nc_packet)
+		batadv_dbg(BATADV_DBG_NC, bat_priv,
+			   "No decoding packet found for %u\n", packet_id);
+
+	return nc_packet;
+}
+
+/**
+ * batadv_nc_recv_coded_packet - try to decode coded packet and enqueue the
+ *  resulting unicast packet
+ * @skb: incoming coded packet
+ * @recv_if: pointer to interface this packet was received on
+ */
+static int batadv_nc_recv_coded_packet(struct sk_buff *skb,
+				       struct batadv_hard_iface *recv_if)
+{
+	struct batadv_priv *bat_priv = netdev_priv(recv_if->soft_iface);
+	struct batadv_unicast_packet *unicast_packet;
+	struct batadv_coded_packet *coded_packet;
+	struct batadv_nc_packet *nc_packet;
+	struct ethhdr *ethhdr;
+	int hdr_size = sizeof(*coded_packet);
+
+	/* Check if network coding is enabled */
+	if (!atomic_read(&bat_priv->network_coding))
+		return NET_RX_DROP;
+
+	/* Make sure we can access (and remove) header */
+	if (unlikely(!pskb_may_pull(skb, hdr_size)))
+		return NET_RX_DROP;
+
+	coded_packet = (struct batadv_coded_packet *)skb->data;
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+
+	/* Verify frame is destined for us */
+	if (!batadv_is_my_mac(ethhdr->h_dest) &&
+	    !batadv_is_my_mac(coded_packet->second_dest))
+		return NET_RX_DROP;
+
+	/* Update stat counter */
+	if (batadv_is_my_mac(coded_packet->second_dest))
+		batadv_inc_counter(bat_priv, BATADV_CNT_NC_SNIFFED);
+
+	nc_packet = batadv_nc_find_decoding_packet(bat_priv, ethhdr,
+						   coded_packet);
+	if (!nc_packet) {
+		batadv_inc_counter(bat_priv, BATADV_CNT_NC_DECODE_FAILED);
+		return NET_RX_DROP;
+	}
+
+	/* Make skb's linear, because decoding accesses the entire buffer */
+	if (skb_linearize(skb) < 0)
+		return NET_RX_DROP;
+
+	if (skb_linearize(nc_packet->skb) < 0)
+		return NET_RX_DROP;
+
+	/* Decode the packet */
+	unicast_packet = batadv_nc_skb_decode_packet(skb, nc_packet);
+	if (!unicast_packet) {
+		batadv_inc_counter(bat_priv, BATADV_CNT_NC_DECODE_FAILED);
+		return NET_RX_DROP;
+	}
+
+	/* Mark packet as decoded to do correct recoding when forwarding */
+	BATADV_SKB_CB(skb)->decoded = true;
+	batadv_inc_counter(bat_priv, BATADV_CNT_NC_DECODE);
+	batadv_add_counter(bat_priv, BATADV_CNT_NC_DECODE_BYTES,
+			   skb->len + ETH_HLEN);
+	return batadv_recv_unicast_packet(skb, recv_if);
+}
+
+/**
  * batadv_nc_free - clean up network coding memory
  * @bat_priv: the bat priv with all the soft interface information
  */
 void batadv_nc_free(struct batadv_priv *bat_priv)
 {
+	batadv_recv_handler_unregister(BATADV_CODED);
 	cancel_delayed_work_sync(&bat_priv->nc.work);
 
 	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash, NULL);
diff --git a/soft-interface.c b/soft-interface.c
index 8f8a433..ac887d4 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -642,6 +642,10 @@ static const struct {
 	{ "nc_recode" },
 	{ "nc_recode_bytes" },
 	{ "nc_buffer" },
+	{ "nc_decode" },
+	{ "nc_decode_bytes" },
+	{ "nc_decode_failed" },
+	{ "nc_sniffed" },
 #endif
 };
 
diff --git a/types.h b/types.h
index 90df980..182daea 100644
--- a/types.h
+++ b/types.h
@@ -198,6 +198,10 @@ enum batadv_counters {
 	BATADV_CNT_NC_RECODE,
 	BATADV_CNT_NC_RECODE_BYTES,
 	BATADV_CNT_NC_BUFFER,
+	BATADV_CNT_NC_DECODE,
+	BATADV_CNT_NC_DECODE_BYTES,
+	BATADV_CNT_NC_DECODE_FAILED,
+	BATADV_CNT_NC_SNIFFED,
 #endif
 	BATADV_CNT_NUM,
 };
-- 
1.8.0.2

