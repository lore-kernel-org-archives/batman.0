Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Mon, 21 Jan 2013 11:22:25 +0100
Message-Id: <1358763746-16742-6-git-send-email-martin@hundeboll.net>
In-Reply-To: <1358763746-16742-1-git-send-email-martin@hundeboll.net>
References: <1358763746-16742-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv3 5/6] batman-adv: Save overheard and tx
	packets for decoding.
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

To be able to decode a network coded packet, a node must already know
one of the two coded packets. This is done by buffering skbs before
transmission and buffering packets sniffed with promiscuous mode from
other hosts.

Packets are kept in a buffer similar to the one with forward-skbs: A
hash table, where each entry, which corresponds to a src-dst pair, has a
linked list packets.

This patch depends on my previous patch on the mailing list:
"Return reason for failure in batadv_check_unicast_packet()"

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
v3:
 * Use new return values from batadv_check_unicast_packet()

 network-coding.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 network-coding.h |  18 +++++
 routing.c        |  13 +++-
 send.c           |   5 ++
 soft-interface.c |   1 +
 types.h          |  10 +++
 6 files changed, 252 insertions(+), 3 deletions(-)

diff --git a/network-coding.c b/network-coding.c
index 3c5249d..af96211 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -27,6 +27,7 @@
 #include "hard-interface.h"
 
 static struct lock_class_key batadv_nc_coding_hash_lock_class_key;
+static struct lock_class_key batadv_nc_decoding_hash_lock_class_key;
 
 static void batadv_nc_worker(struct work_struct *work);
 
@@ -47,8 +48,9 @@ static void batadv_nc_start_timer(struct batadv_priv *bat_priv)
 int batadv_nc_init(struct batadv_priv *bat_priv)
 {
 	bat_priv->nc.timestamp_fwd_flush = jiffies;
+	bat_priv->nc.timestamp_sniffed_purge = jiffies;
 
-	if (bat_priv->nc.coding_hash)
+	if (bat_priv->nc.coding_hash || bat_priv->nc.decoding_hash)
 		return 0;
 
 	bat_priv->nc.coding_hash = batadv_hash_new(128);
@@ -58,6 +60,13 @@ int batadv_nc_init(struct batadv_priv *bat_priv)
 	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
 				   &batadv_nc_coding_hash_lock_class_key);
 
+	bat_priv->nc.decoding_hash = batadv_hash_new(128);
+	if (!bat_priv->nc.decoding_hash)
+		goto err;
+
+	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
+				   &batadv_nc_decoding_hash_lock_class_key);
+
 	INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);
 	batadv_nc_start_timer(bat_priv);
 
@@ -76,6 +85,7 @@ void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
 	atomic_set(&bat_priv->network_coding, 1);
 	bat_priv->nc.min_tq = 200;
 	bat_priv->nc.max_fwd_delay = 10;
+	bat_priv->nc.max_buffer_time = 200;
 }
 
 /**
@@ -176,6 +186,26 @@ static bool batadv_nc_to_purge_nc_path_coding(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_nc_to_purge_nc_path_decoding - checks whether an nc path has timed out
+ * @bat_priv: the bat priv with all the soft interface information
+ * @nc_path: the nc path to check
+ *
+ * Returns true if the entry has to be purged now, false otherwise
+ */
+static bool batadv_nc_to_purge_nc_path_decoding(struct batadv_priv *bat_priv,
+						struct batadv_nc_path *nc_path)
+{
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+		return true;
+
+	/* purge the path when no packets has been added for 10 times the
+	 * max_buffer time
+	 */
+	return batadv_has_timed_out(nc_path->last_valid,
+				    bat_priv->nc.max_buffer_time*10);
+}
+
+/**
  * batadv_nc_purge_orig_nc_nodes - go through list of nc nodes and purge stale
  *  entries
  * @bat_priv: the bat priv with all the soft interface information
@@ -446,6 +476,43 @@ static void batadv_nc_send_packet(struct batadv_nc_packet *nc_packet)
 }
 
 /**
+ * batadv_nc_sniffed_purge - Checks timestamp of given sniffed nc_packet.
+ * @bat_priv: the bat priv with all the soft interface information
+ * @nc_path: the nc path the packet belongs to
+ * @nc_packet: the nc packet to be checked
+ *
+ * Checks whether the given sniffed (overheard) nc_packet has hit its buffering
+ * timeout. If so, the packet is no longer kept and the entry deleted from the
+ * queue. Has to be called with the appropriate locks.
+ *
+ * Returns false as soon as the entry in the fifo queue has not been timed out
+ * yet and true otherwise.
+ */
+static bool batadv_nc_sniffed_purge(struct batadv_priv *bat_priv,
+				    struct batadv_nc_path *nc_path,
+				    struct batadv_nc_packet *nc_packet)
+{
+	unsigned long timeout = bat_priv->nc.max_buffer_time;
+	bool res = false;
+
+	/* Packets are added to tail, so the remaining packets did not time
+	 * out and we can stop processing the current queue
+	 */
+	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE &&
+	    !batadv_has_timed_out(nc_packet->timestamp, timeout))
+		goto out;
+
+	/* purge nc packet */
+	list_del(&nc_packet->list);
+	batadv_nc_packet_free(nc_packet);
+
+	res = true;
+
+out:
+	return res;
+}
+
+/**
  * batadv_nc_fwd_flush - Checks the timestamp of the given nc packet.
  * @bat_priv: the bat priv with all the soft interface information
  * @nc_path: the nc path the packet belongs to
@@ -546,6 +613,8 @@ static void batadv_nc_worker(struct work_struct *work)
 	batadv_nc_purge_orig_hash(bat_priv);
 	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash,
 			      batadv_nc_to_purge_nc_path_coding);
+	batadv_nc_purge_paths(bat_priv, bat_priv->nc.decoding_hash,
+			      batadv_nc_to_purge_nc_path_decoding);
 
 	timeout = bat_priv->nc.max_fwd_delay;
 
@@ -555,6 +624,13 @@ static void batadv_nc_worker(struct work_struct *work)
 		bat_priv->nc.timestamp_fwd_flush = jiffies;
 	}
 
+	if (batadv_has_timed_out(bat_priv->nc.timestamp_sniffed_purge,
+				 bat_priv->nc.max_buffer_time)) {
+		batadv_nc_process_nc_paths(bat_priv, bat_priv->nc.decoding_hash,
+					   batadv_nc_sniffed_purge);
+		bat_priv->nc.timestamp_sniffed_purge = jiffies;
+	}
+
 	/* Schedule a new check */
 	batadv_nc_start_timer(bat_priv);
 }
@@ -1151,6 +1227,41 @@ batadv_nc_skb_src_search(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_nc_skb_store_before_coding - set the ethernet src and dst of the
+ *  unicast skb before it is stored for use in later decoding
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: data skb to store
+ * @eth_dst_new: new destination mac address of skb
+ */
+static void batadv_nc_skb_store_before_coding(struct batadv_priv *bat_priv,
+					      struct sk_buff *skb,
+					      uint8_t *eth_dst_new)
+{
+	struct ethhdr *ethhdr;
+
+	/* Copy skb header to change the mac header */
+	skb = pskb_copy(skb, GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	/* Set the mac header as if we actually sent the packet uncoded */
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	memcpy(ethhdr->h_source, ethhdr->h_dest, ETH_ALEN);
+	memcpy(ethhdr->h_dest, eth_dst_new, ETH_ALEN);
+
+	/* Set data pointer to MAC header to mimic packets from our tx path */
+	skb_push(skb, ETH_HLEN);
+
+	/* Add the packet to the decoding packet pool */
+	batadv_nc_skb_store_for_decoding(bat_priv, skb);
+
+	/* batadv_nc_skb_store_for_decoding() clones the skb, so we must free
+	 * our ref
+	 */
+	kfree_skb(skb);
+}
+
+/**
  * batadv_nc_skb_dst_search - Loops through list of neighboring nodes to dst.
  * @skb: data skb to forward
  * @neigh_node: next hop to forward packet to
@@ -1189,6 +1300,12 @@ static bool batadv_nc_skb_dst_search(struct sk_buff *skb,
 	if (!nc_packet)
 		return false;
 
+	/* Save packets for later decoding */
+	batadv_nc_skb_store_before_coding(bat_priv, skb,
+					  neigh_node->addr);
+	batadv_nc_skb_store_before_coding(bat_priv, nc_packet->skb,
+					  nc_packet->neigh_node->addr);
+
 	/* Code and send packets */
 	if (batadv_nc_code_packets(bat_priv, skb, ethhdr, nc_packet,
 				   neigh_node))
@@ -1296,14 +1413,98 @@ out:
 }
 
 /**
+ * batadv_nc_skb_store_for_decoding - save a clone of the skb which can be used
+ *  when decoding coded packets
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: data skb to store
+ */
+void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
+				      struct sk_buff *skb)
+{
+	struct batadv_unicast_packet *packet;
+	struct batadv_nc_path *nc_path;
+	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	__be32 packet_id;
+	u8 *payload;
+
+	/* Check if network coding is enabled */
+	if (!atomic_read(&bat_priv->network_coding))
+		goto out;
+
+	/* Check for supported packet type */
+	payload = skb_network_header(skb);
+	packet = (struct batadv_unicast_packet *)payload;
+	if (packet->header.packet_type != BATADV_UNICAST)
+		goto out;
+
+	/* Find existing nc_path or create a new */
+	nc_path = batadv_nc_get_path(bat_priv,
+				     bat_priv->nc.decoding_hash,
+				     ethhdr->h_source,
+				     ethhdr->h_dest);
+
+	if (!nc_path)
+		goto out;
+
+	/* Clone skb and adjust skb->data to point at batman header */
+	skb = skb_clone(skb, GFP_ATOMIC);
+	if (unlikely(!skb))
+		goto free_nc_path;
+
+	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
+		goto free_skb;
+
+	if (unlikely(!skb_pull_rcsum(skb, ETH_HLEN)))
+		goto free_skb;
+
+	/* Add skb to nc_path */
+	packet_id = batadv_skb_crc32(skb, payload + sizeof(*packet));
+	if (!batadv_nc_skb_add_to_path(skb, nc_path, NULL, packet_id))
+		goto free_skb;
+
+	batadv_inc_counter(bat_priv, BATADV_CNT_NC_BUFFER);
+	return;
+
+free_skb:
+	kfree_skb(skb);
+free_nc_path:
+	batadv_nc_path_free_ref(nc_path);
+out:
+	return;
+}
+
+/**
+ * batadv_nc_skb_store_sniffed_unicast - check if a received unicast packet
+ *  should be saved in the decoding buffer and, if so, store it there
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: unicast skb to store
+ */
+void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
+					 struct sk_buff *skb)
+{
+	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+
+	if (batadv_is_my_mac(ethhdr->h_dest))
+		return;
+
+	/* Set data pointer to MAC header to mimic packets from our tx path */
+	skb_push(skb, ETH_HLEN);
+
+	batadv_nc_skb_store_for_decoding(bat_priv, skb);
+}
+
+/**
  * batadv_nc_free - clean up network coding memory
  * @bat_priv: the bat priv with all the soft interface information
  */
 void batadv_nc_free(struct batadv_priv *bat_priv)
 {
 	cancel_delayed_work_sync(&bat_priv->nc.work);
+
 	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash, NULL);
 	batadv_hash_destroy(bat_priv->nc.coding_hash);
+	batadv_nc_purge_paths(bat_priv, bat_priv->nc.decoding_hash, NULL);
+	batadv_hash_destroy(bat_priv->nc.decoding_hash);
 }
 
 /**
@@ -1385,6 +1586,11 @@ int batadv_nc_init_debugfs(struct batadv_priv *bat_priv)
 	if (!file)
 		goto out;
 
+	file = debugfs_create_u32("max_buffer_time", S_IRUGO | S_IWUSR, nc_dir,
+				  &bat_priv->nc.max_buffer_time);
+	if (!file)
+		goto out;
+
 	return 0;
 
 out:
diff --git a/network-coding.h b/network-coding.h
index 6e53cc8..352c693 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -38,6 +38,10 @@ void batadv_nc_init_orig(struct batadv_orig_node *orig_node);
 bool batadv_nc_skb_forward(struct sk_buff *skb,
 			   struct batadv_neigh_node *neigh_node,
 			   struct ethhdr *ethhdr);
+void batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
+				      struct sk_buff *skb);
+void batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
+					 struct sk_buff *skb);
 int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_nc_init_debugfs(struct batadv_priv *bat_priv);
 
@@ -89,6 +93,20 @@ static inline bool batadv_nc_skb_forward(struct sk_buff *skb,
 	return false;
 }
 
+static inline void
+batadv_nc_skb_store_for_decoding(struct batadv_priv *bat_priv,
+				 struct sk_buff *skb)
+{
+	return;
+}
+
+static inline void
+batadv_nc_skb_store_sniffed_unicast(struct batadv_priv *bat_priv,
+				    struct sk_buff *skb)
+{
+	return;
+}
+
 static inline int batadv_nc_nodes_seq_print_text(struct seq_file *seq,
 						 void *offset)
 {
diff --git a/routing.c b/routing.c
index 48a6d35..1a5c1e9 100644
--- a/routing.c
+++ b/routing.c
@@ -1049,7 +1049,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	struct batadv_unicast_4addr_packet *unicast_4addr_packet;
 	uint8_t *orig_addr;
 	struct batadv_orig_node *orig_node = NULL;
-	int hdr_size = sizeof(*unicast_packet);
+	int check, hdr_size = sizeof(*unicast_packet);
 	bool is4addr;
 
 	unicast_packet = (struct batadv_unicast_packet *)skb->data;
@@ -1060,7 +1060,16 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 	if (is4addr)
 		hdr_size = sizeof(*unicast_4addr_packet);
 
-	if (batadv_check_unicast_packet(skb, hdr_size) < 0)
+	/* function returns -EREMOTE for promiscuous packets */
+	check = batadv_check_unicast_packet(skb, hdr_size);
+
+	/* Even though the packet is not for us, we might save it to use for
+	 * decoding a later received coded packet
+	 */
+	if (check == -EREMOTE)
+		batadv_nc_skb_store_sniffed_unicast(bat_priv, skb);
+
+	if (check < 0)
 		return NET_RX_DROP;
 
 	if (!batadv_check_unicast_ttvn(bat_priv, skb))
diff --git a/send.c b/send.c
index 80ca65f..0a0bb45 100644
--- a/send.c
+++ b/send.c
@@ -27,6 +27,7 @@
 #include "vis.h"
 #include "gateway_common.h"
 #include "originator.h"
+#include "network-coding.h"
 
 #include <linux/if_ether.h>
 
@@ -39,6 +40,7 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 			   struct batadv_hard_iface *hard_iface,
 			   const uint8_t *dst_addr)
 {
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	struct ethhdr *ethhdr;
 
 	if (hard_iface->if_status != BATADV_IF_ACTIVE)
@@ -70,6 +72,9 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 
 	skb->dev = hard_iface->net_dev;
 
+	/* Save a clone of the skb to use when decoding coded packets */
+	batadv_nc_skb_store_for_decoding(bat_priv, skb);
+
 	/* dev_queue_xmit() returns a negative result on error.	 However on
 	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP
 	 * (which is > 0). This will not be treated as an error.
diff --git a/soft-interface.c b/soft-interface.c
index 7e463c3..75204ec 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -670,6 +670,7 @@ static const struct {
 	{ "nc_code_bytes" },
 	{ "nc_recode" },
 	{ "nc_recode_bytes" },
+	{ "nc_buffer" },
 #endif
 };
 
diff --git a/types.h b/types.h
index fc65df3..21171b7 100644
--- a/types.h
+++ b/types.h
@@ -307,6 +307,7 @@ enum batadv_counters {
 	BATADV_CNT_NC_CODE_BYTES,
 	BATADV_CNT_NC_RECODE,
 	BATADV_CNT_NC_RECODE_BYTES,
+	BATADV_CNT_NC_BUFFER,
 #endif
 	BATADV_CNT_NUM,
 };
@@ -448,18 +449,27 @@ struct batadv_priv_dat {
  * @work: work queue callback item for cleanup
  * @min_tq: only consider neighbors for encoding if neigh_tq > min_tq
  * @max_fwd_delay: maximum packet forward delay to allow coding of packets
+ * @max_buffer_time: buffer time for sniffed packets used to decoding
  * @timestamp_fwd_flush: timestamp of last forward packet queue flush
+ * @timestamp_sniffed_purge: timestamp of last sniffed packet queue purge
  * @coding_hash: Hash table used to buffer skbs while waiting for another
  *  incoming skb to code it with. Skbs are added to the buffer just before being
  *  forwarded in routing.c
+ * @decoding_hash: Hash table used to buffer skbs that might be needed to decode
+ *  a received coded skb. The buffer is used for 1) skbs arriving on the
+ *  soft-interface; 2) skbs overheard on the hard-interface; and 3) skbs
+ *  forwarded by batman-adv.
  */
 struct batadv_priv_nc {
 	struct delayed_work work;
 	struct dentry *debug_dir;
 	u8 min_tq;
 	u32 max_fwd_delay;
+	u32 max_buffer_time;
 	unsigned long timestamp_fwd_flush;
+	unsigned long timestamp_sniffed_purge;
 	struct batadv_hashtable *coding_hash;
+	struct batadv_hashtable *decoding_hash;
 };
 
 /**
-- 
1.8.1.1

