Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri, 14 Dec 2012 07:32:49 +0100
Message-Id: <1e4a245ef554ae147b4bde551d16f5796003dea4.1355466678.git.martin@hundeboll.net>
In-Reply-To: <cover.1355466678.git.martin@hundeboll.net>
References: <cover.1355466678.git.martin@hundeboll.net>
In-Reply-To: <cover.1355466678.git.martin@hundeboll.net>
References: <cover.1355466678.git.martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 4/7] batman-adv: Buffer unicast packets
	before forward.
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

Two be able to network code two packets, one packet must be buffered
until the next is available. This is done in a "coding buffer", which is
essentially a hash table with lists of packets. Each entry in the hash
table corresponds to a specific src-dst pair, which has a linked list of
packets that are buffered.

This patch adds skbs to the buffer just before forwarding them. The
buffer is traversed every 10 ms, where timed skbs are removed from the
buffer and transmitted. To allow experiments with the network coding
scheme, the timeout is tunable through a file in debugfs.

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 compat.c         |  10 ++
 compat.h         |   1 +
 main.h           |   1 +
 network-coding.c | 492 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 network-coding.h |  10 ++
 routing.c        |  18 +-
 types.h          |  49 ++++++
 7 files changed, 574 insertions(+), 7 deletions(-)

diff --git a/compat.c b/compat.c
index c8006c6..5664d90 100644
--- a/compat.c
+++ b/compat.c
@@ -74,4 +74,14 @@ void batadv_free_rcu_dat_entry(struct rcu_head *rcu)
 }
 #endif
 
+#ifdef CONFIG_BATMAN_ADV_NC
+void batadv_free_rcu_nc_path(struct rcu_head *rcu)
+{
+	struct batadv_nc_path *nc_path;
+
+	nc_path = container_of(rcu, struct batadv_nc_path, rcu);
+	kfree(nc_path);
+}
+#endif
+
 #endif /* < KERNEL_VERSION(3, 0, 0) */
diff --git a/compat.h b/compat.h
index 07ac401..3c7ad44 100644
--- a/compat.h
+++ b/compat.h
@@ -145,6 +145,7 @@ void batadv_free_rcu_neigh_node(struct rcu_head *rcu);
 void batadv_free_rcu_tt_local_entry(struct rcu_head *rcu);
 void batadv_free_rcu_backbone_gw(struct rcu_head *rcu);
 void batadv_free_rcu_dat_entry(struct rcu_head *rcu);
+void batadv_free_rcu_nc_path(struct rcu_head *rcu);
 
 static inline void skb_reset_mac_len(struct sk_buff *skb)
 {
diff --git a/main.h b/main.h
index 44945dc..9fd81b8 100644
--- a/main.h
+++ b/main.h
@@ -104,6 +104,7 @@
 #define BATADV_EXPECTED_SEQNO_RANGE	65536
 
 #define BATADV_NC_NODE_TIMEOUT 10000 /* Milliseconds */
+#define BATADV_NC_PATH_TIMEOUT 10000 /* Milliseconds */
 
 enum batadv_mesh_state {
 	BATADV_MESH_INACTIVE,
diff --git a/network-coding.c b/network-coding.c
index e3d9f01..2388176 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -20,10 +20,14 @@
 #include <linux/debugfs.h>
 
 #include "main.h"
+#include "hash.h"
 #include "network-coding.h"
+#include "send.h"
 #include "originator.h"
 #include "hard-interface.h"
 
+static struct lock_class_key batadv_nc_coding_hash_lock_class_key;
+
 static void batadv_nc_worker(struct work_struct *work);
 
 /**
@@ -42,10 +46,25 @@ static void batadv_nc_start_timer(struct batadv_priv *bat_priv)
  */
 int batadv_nc_init(struct batadv_priv *bat_priv)
 {
+	bat_priv->nc.timestamp_fwd_flush = jiffies;
+
+	if (bat_priv->nc.coding_hash)
+		return 0;
+
+	bat_priv->nc.coding_hash = batadv_hash_new(128);
+	if (!bat_priv->nc.coding_hash)
+		goto err;
+
+	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
+				   &batadv_nc_coding_hash_lock_class_key);
+
 	INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);
 	batadv_nc_start_timer(bat_priv);
 
 	return 0;
+
+err:
+	return -ENOMEM;
 }
 
 /**
@@ -56,6 +75,7 @@ void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv)
 {
 	atomic_set(&bat_priv->network_coding, 1);
 	bat_priv->nc.min_tq = 200;
+	bat_priv->nc.max_fwd_delay = 10;
 }
 
 /**
@@ -96,6 +116,30 @@ static void batadv_nc_node_free_ref(struct batadv_nc_node *nc_node)
 }
 
 /**
+ * batadv_nc_path_free_ref - decrements the nc path refcounter and possibly
+ * frees it
+ * @nc_path: the nc node to free
+ */
+static void batadv_nc_path_free_ref(struct batadv_nc_path *nc_path)
+{
+	if (atomic_dec_and_test(&nc_path->refcount))
+		kfree_rcu(nc_path, rcu);
+}
+
+/**
+ * batadv_nc_packet_free - frees nc packet
+ * @nc_packet: the nc packet to free
+ */
+static void batadv_nc_packet_free(struct batadv_nc_packet *nc_packet)
+{
+	if (nc_packet->skb)
+		kfree_skb(nc_packet->skb);
+
+	batadv_nc_path_free_ref(nc_packet->nc_path);
+	kfree(nc_packet);
+}
+
+/**
  * batadv_nc_to_purge_nc_node - checks whether an nc node has to be purged
  * @bat_priv: the bat priv with all the soft interface information
  * @nc_node: the nc node to check
@@ -112,6 +156,26 @@ static bool batadv_nc_to_purge_nc_node(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_nc_to_purge_nc_path_coding - checks whether an nc path has timed out
+ * @bat_priv: the bat priv with all the soft interface information
+ * @nc_path: the nc path to check
+ *
+ * Returns true if the entry has to be purged now, false otherwise
+ */
+static bool batadv_nc_to_purge_nc_path_coding(struct batadv_priv *bat_priv,
+					      struct batadv_nc_path *nc_path)
+{
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+		return true;
+
+	/* purge the path when no packets has been added for 10 times the
+	 * max_fwd_delay time
+	 */
+	return batadv_has_timed_out(nc_path->last_valid,
+				    bat_priv->nc.max_fwd_delay * 10);
+}
+
+/**
  * batadv_nc_purge_orig_nc_nodes - go through list of nc nodes and purge stale
  *  entries
  * @bat_priv: the bat priv with all the soft interface information
@@ -204,6 +268,267 @@ static void batadv_nc_purge_orig_hash(struct batadv_priv *bat_priv)
 }
 
 /**
+ * batadv_nc_purge_paths - traverse all nc paths part of the hash and remove
+ *  unused ones
+ * @bat_priv: the bat priv with all the soft interface information
+ * @hash: hash table containing the nc paths to check
+ * @to_purge: function in charge to decide whether an entry has to be purged or
+ *	      not. This function takes the nc node as argument and has to return
+ *	      a boolean value: true is the entry has to be deleted, false
+ *	      otherwise
+ */
+static void batadv_nc_purge_paths(struct batadv_priv *bat_priv,
+				  struct batadv_hashtable *hash,
+				  bool (*to_purge)(struct batadv_priv *,
+						   struct batadv_nc_path *))
+{
+	struct hlist_head *head;
+	struct hlist_node *node, *node_tmp;
+	struct batadv_nc_path *nc_path;
+	spinlock_t *lock; /* Protects lists in hash */
+	uint32_t i;
+
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+		lock = &hash->list_locks[i];
+
+		/* For each nc_path in this bin */
+		spin_lock_bh(lock);
+		hlist_for_each_entry_safe(nc_path, node, node_tmp,
+					  head, hash_entry) {
+
+			/* if an helper function has been passed as parameter,
+			 * ask it if the entry has to be purged or not
+			 */
+			if (to_purge && !to_purge(bat_priv, nc_path))
+				continue;
+
+			/* purging an non-empty nc_path should never happen, but
+			 * is observed under high CPU load. Delay the purging
+			 * until next iteration to allow the packet_list to be
+			 * emptied first.
+			 */
+			if (!unlikely(list_empty(&nc_path->packet_list))) {
+				net_ratelimited_function(printk,
+							 KERN_WARNING
+							 "Skipping free of non-empty nc_path (%pM -> %pM)!\n",
+							 nc_path->prev_hop,
+							 nc_path->next_hop);
+				continue;
+			}
+
+			/* nc_path is unused, so remove it */
+			batadv_dbg(BATADV_DBG_NC, bat_priv,
+				   "Remove nc_path %pM -> %pM\n",
+				   nc_path->prev_hop, nc_path->next_hop);
+			hlist_del_rcu(node);
+			batadv_nc_path_free_ref(nc_path);
+		}
+		spin_unlock_bh(lock);
+	}
+}
+
+/**
+ * batadv_nc_hash_key_gen - computes the nc_path hash key
+ * @key: buffer to hold the final hash key
+ * @src: source ethernet mac address going into the hash key
+ * @dst: destination ethernet mac address going into the hash key
+ */
+static void batadv_nc_hash_key_gen(struct batadv_nc_path *key,
+					  const char *src,
+					  const char *dst)
+{
+	memcpy(key->prev_hop, src, sizeof(key->prev_hop));
+	memcpy(key->next_hop, dst, sizeof(key->next_hop));
+}
+
+/**
+ * batadv_nc_hash_choose - compute the hash value for an nc path
+ * @data: data to hash
+ * @size: size of the hash table
+ *
+ * Returns the selected index in the hash table for the given data.
+ */
+static uint32_t batadv_nc_hash_choose(const void *data, uint32_t size)
+{
+	const struct batadv_nc_path *nc_path = data;
+	uint32_t hash = 0;
+
+	hash = batadv_hash_bytes(hash, &nc_path->prev_hop,
+				 sizeof(nc_path->prev_hop));
+	hash = batadv_hash_bytes(hash, &nc_path->next_hop,
+				 sizeof(nc_path->next_hop));
+
+	hash += (hash << 3);
+	hash ^= (hash >> 11);
+	hash += (hash << 15);
+
+	return hash % size;
+}
+
+/**
+ * batadv_nc_hash_compare - comparing function used in the network coding hash
+ *  tables
+ * @node: node in the local table
+ * @data2: second object to compare the node to
+ *
+ * Returns 1 if the two entry are the same, 0 otherwise
+ */
+static int batadv_nc_hash_compare(const struct hlist_node *node,
+				  const void *data2)
+{
+	const struct batadv_nc_path *nc_path1, *nc_path2;
+
+	nc_path1 = container_of(node, struct batadv_nc_path, hash_entry);
+	nc_path2 = data2;
+
+	/* Return 1 if the two keys are identical */
+	if (memcmp(nc_path1->prev_hop, nc_path2->prev_hop,
+		   sizeof(nc_path1->prev_hop)) != 0)
+		return 0;
+
+	if (memcmp(nc_path1->next_hop, nc_path2->next_hop,
+		   sizeof(nc_path1->next_hop)) != 0)
+		return 0;
+
+	return 1;
+}
+
+/**
+ * batadv_nc_hash_find - search for an existing nc path and return it
+ * @hash: hash table containing the nc path
+ * @data: search key
+ *
+ * Returns the nc_path if found, NULL otherwise.
+ */
+static struct batadv_nc_path *
+batadv_nc_hash_find(struct batadv_hashtable *hash,
+		    void *data)
+{
+	struct hlist_head *head;
+	struct hlist_node *node;
+	struct batadv_nc_path *nc_path, *nc_path_tmp = NULL;
+	int index;
+
+	if (!hash)
+		return NULL;
+
+	index = batadv_nc_hash_choose(data, hash->size);
+	head = &hash->table[index];
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(nc_path, node, head, hash_entry) {
+		if (!batadv_nc_hash_compare(node, data))
+			continue;
+
+		if (!atomic_inc_not_zero(&nc_path->refcount))
+			continue;
+
+		nc_path_tmp = nc_path;
+		break;
+	}
+	rcu_read_unlock();
+
+	return nc_path_tmp;
+}
+
+/**
+ * batadv_nc_send_packet - send non-coded packet and free nc_packet struct
+ * @nc_packet: the nc packet to send
+ */
+static void batadv_nc_send_packet(struct batadv_nc_packet *nc_packet)
+{
+	batadv_send_skb_packet(nc_packet->skb,
+			       nc_packet->neigh_node->if_incoming,
+			       nc_packet->nc_path->next_hop);
+	nc_packet->skb = NULL;
+	batadv_nc_packet_free(nc_packet);
+}
+
+/**
+ * batadv_nc_fwd_flush - Checks the timestamp of the given nc packet.
+ * @bat_priv: the bat priv with all the soft interface information
+ * @nc_path: the nc path the packet belongs to
+ * @nc_packet: the nc packet to be checked
+ *
+ * Checks whether the given nc packet has hit its forward timeout. If so, the
+ * packet is no longer delayed, immediately sent and the entry deleted from the
+ * queue. Has to be called with the appropriate locks.
+ *
+ * Returns false as soon as the entry in the fifo queue has not been timed out
+ * yet and true otherwise.
+ */
+static bool batadv_nc_fwd_flush(struct batadv_priv *bat_priv,
+				struct batadv_nc_path *nc_path,
+				struct batadv_nc_packet *nc_packet)
+{
+	unsigned long timeout = bat_priv->nc.max_fwd_delay;
+
+	/* Packets are added to tail, so the remaining packets did not time
+	 * out and we can stop processing the current queue
+	 */
+	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE &&
+	    !batadv_has_timed_out(nc_packet->timestamp, timeout))
+		return false;
+
+	/* Send packet */
+	batadv_inc_counter(bat_priv, BATADV_CNT_FORWARD);
+	batadv_add_counter(bat_priv, BATADV_CNT_FORWARD_BYTES,
+			   nc_packet->skb->len + ETH_HLEN);
+	list_del(&nc_packet->list);
+	batadv_nc_send_packet(nc_packet);
+
+	return true;
+}
+
+/**
+ * batadv_nc_process_nc_paths - traverse given nc packet pool and free timed out
+ *  nc packets
+ * @bat_priv: the bat priv with all the soft interface information
+ * @hash: to be processed hash table
+ * @process_fn: Function called to process given nc packet. Should return true
+ *	        to encourage this function to proceed with the next packet.
+ *	        Otherwise the rest of the current queue is skipped.
+ */
+static void
+batadv_nc_process_nc_paths(struct batadv_priv *bat_priv,
+			   struct batadv_hashtable *hash,
+			   bool (*process_fn)(struct batadv_priv *,
+					      struct batadv_nc_path *,
+					      struct batadv_nc_packet *))
+{
+	struct hlist_node *node;
+	struct hlist_head *head;
+	struct batadv_nc_packet *nc_packet, *nc_packet_tmp;
+	struct batadv_nc_path *nc_path;
+	bool ret;
+	int i;
+
+	if (!hash)
+		return;
+
+	/* Loop hash table bins */
+	for (i = 0; i < hash->size; i++) {
+		head = &hash->table[i];
+
+		/* Loop coding paths */
+		rcu_read_lock();
+		hlist_for_each_entry_rcu(nc_path, node, head, hash_entry) {
+			/* Loop packets */
+			spin_lock_bh(&nc_path->packet_list_lock);
+			list_for_each_entry_safe(nc_packet, nc_packet_tmp,
+						 &nc_path->packet_list, list) {
+				ret = process_fn(bat_priv, nc_path, nc_packet);
+				if (!ret)
+					break;
+			}
+			spin_unlock_bh(&nc_path->packet_list_lock);
+		}
+		rcu_read_unlock();
+	}
+}
+
+/**
  * batadv_nc_worker - periodic task for house keeping related to network coding
  * @work: kernel work struct
  */
@@ -212,12 +537,23 @@ static void batadv_nc_worker(struct work_struct *work)
 	struct delayed_work *delayed_work;
 	struct batadv_priv_nc *priv_nc;
 	struct batadv_priv *bat_priv;
+	unsigned long timeout;
 
 	delayed_work = container_of(work, struct delayed_work, work);
 	priv_nc = container_of(delayed_work, struct batadv_priv_nc, work);
 	bat_priv = container_of(priv_nc, struct batadv_priv, nc);
 
 	batadv_nc_purge_orig_hash(bat_priv);
+	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash,
+			      batadv_nc_to_purge_nc_path_coding);
+
+	timeout = bat_priv->nc.max_fwd_delay;
+
+	if (batadv_has_timed_out(bat_priv->nc.timestamp_fwd_flush, timeout)) {
+		batadv_nc_process_nc_paths(bat_priv, bat_priv->nc.coding_hash,
+					   batadv_nc_fwd_flush);
+		bat_priv->nc.timestamp_fwd_flush = jiffies;
+	}
 
 	/* Schedule a new check */
 	batadv_nc_start_timer(bat_priv);
@@ -408,12 +744,163 @@ out:
 }
 
 /**
+ * batadv_nc_get_path - get existing nc_path or allocate a new one
+ * @bat_priv: the bat priv with all the soft interface information
+ * @hash: hash table containing the nc path
+ * @src: ethernet source address - first half of the nc path search key
+ * @dst: ethernet destination address - second half of the nc path search key
+ *
+ * Returns pointer to nc_path if the path was found or created, returns NULL
+ * on error.
+ */
+static struct batadv_nc_path *batadv_nc_get_path(struct batadv_priv *bat_priv,
+						 struct batadv_hashtable *hash,
+						 uint8_t *src,
+						 uint8_t *dst)
+{
+	int hash_added;
+	struct batadv_nc_path *nc_path, nc_path_key;
+
+	batadv_nc_hash_key_gen(&nc_path_key, src, dst);
+
+	/* Search for existing nc_path */
+	nc_path = batadv_nc_hash_find(hash, (void *)&nc_path_key);
+
+	if (nc_path) {
+		/* Set timestamp to delay removal of nc_path */
+		nc_path->last_valid = jiffies;
+		return nc_path;
+	}
+
+	/* No existing nc_path was found; create a new */
+	nc_path = kzalloc(sizeof(*nc_path), GFP_ATOMIC);
+
+	if (!nc_path)
+		return NULL;
+
+	/* Initialize nc_path */
+	INIT_LIST_HEAD(&nc_path->packet_list);
+	spin_lock_init(&nc_path->packet_list_lock);
+	atomic_set(&nc_path->refcount, 2);
+	nc_path->last_valid = jiffies;
+	memcpy(nc_path->next_hop, dst, ETH_ALEN);
+	memcpy(nc_path->prev_hop, src, ETH_ALEN);
+
+	batadv_dbg(BATADV_DBG_NC, bat_priv, "Adding nc_path %pM -> %pM\n",
+		   nc_path->prev_hop,
+		   nc_path->next_hop);
+
+	/* Add nc_path to hash table */
+	hash_added = batadv_hash_add(hash, batadv_nc_hash_compare,
+				     batadv_nc_hash_choose, &nc_path_key,
+				     &nc_path->hash_entry);
+
+	if (hash_added < 0) {
+		kfree(nc_path);
+		return NULL;
+	}
+
+	return nc_path;
+}
+
+/**
+ * batadv_nc_skb_add_to_path - buffer skb for later encoding / decoding
+ * @skb: skb to add to path
+ * @nc_path: path to add skb to
+ * @neigh_node: next hop to forward packet to
+ * @packet_id: checksum to identify packet
+ *
+ * Returns true if the packet was buffered or false in case of an error.
+ */
+static bool batadv_nc_skb_add_to_path(struct sk_buff *skb,
+				      struct batadv_nc_path *nc_path,
+				      struct batadv_neigh_node *neigh_node,
+				      __be32 packet_id)
+{
+	struct batadv_nc_packet *nc_packet;
+
+	nc_packet = kzalloc(sizeof(*nc_packet), GFP_ATOMIC);
+	if (!nc_packet)
+		return false;
+
+	/* Initialize nc_packet */
+	nc_packet->timestamp = jiffies;
+	nc_packet->packet_id = packet_id;
+	nc_packet->skb = skb;
+	nc_packet->neigh_node = neigh_node;
+	nc_packet->nc_path = nc_path;
+
+	/* Add coding packet to list */
+	spin_lock_bh(&nc_path->packet_list_lock);
+	list_add_tail(&nc_packet->list, &nc_path->packet_list);
+	spin_unlock_bh(&nc_path->packet_list_lock);
+
+	return true;
+}
+
+/**
+ * batadv_nc_skb_forward - try to code a packet or add it to the coding packet
+ *  buffer
+ * @skb: data skb to forward
+ * @neigh_node: next hop to forward packet to
+ * @ethhdr: pointer to the ethernet header inside the skb
+ *
+ * Returns true if the skb was consumed (encoded packet sent) or false otherwise
+ */
+bool batadv_nc_skb_forward(struct sk_buff *skb,
+			   struct batadv_neigh_node *neigh_node,
+			   struct ethhdr *ethhdr)
+{
+	const struct net_device *netdev = neigh_node->if_incoming->soft_iface;
+	struct batadv_priv *bat_priv = netdev_priv(netdev);
+	struct batadv_unicast_packet *packet;
+	struct batadv_nc_path *nc_path;
+	__be32 packet_id;
+	u8 *payload;
+
+	/* Check if network coding is enabled */
+	if (!atomic_read(&bat_priv->network_coding))
+		goto out;
+
+	/* We only handle unicast packets */
+	payload = skb_network_header(skb);
+	packet = (struct batadv_unicast_packet *)payload;
+	if (packet->header.packet_type != BATADV_UNICAST)
+		goto out;
+
+	/* Find or create a nc_path for this src-dst pair */
+	nc_path = batadv_nc_get_path(bat_priv,
+				     bat_priv->nc.coding_hash,
+				     ethhdr->h_source,
+				     neigh_node->addr);
+
+	if (!nc_path)
+		goto out;
+
+	/* Add skb to nc_path */
+	packet_id = batadv_skb_crc32(skb, payload + sizeof(*packet));
+	if (!batadv_nc_skb_add_to_path(skb, nc_path, neigh_node, packet_id))
+		goto free_nc_path;
+
+	/* Packet is consumed */
+	return true;
+
+free_nc_path:
+	batadv_nc_path_free_ref(nc_path);
+out:
+	/* Packet is not consumed */
+	return false;
+}
+
+/**
  * batadv_nc_free - clean up network coding memory
  * @bat_priv: the bat priv with all the soft interface information
  */
 void batadv_nc_free(struct batadv_priv *bat_priv)
 {
 	cancel_delayed_work_sync(&bat_priv->nc.work);
+	batadv_nc_purge_paths(bat_priv, bat_priv->nc.coding_hash, NULL);
+	batadv_hash_destroy(bat_priv->nc.coding_hash);
 }
 
 /**
@@ -490,6 +977,11 @@ int batadv_nc_init_debugfs(struct batadv_priv *bat_priv)
 	if (!file)
 		goto out;
 
+	file = debugfs_create_u32("max_fwd_delay", S_IRUGO | S_IWUSR, nc_dir,
+				  &bat_priv->nc.max_fwd_delay);
+	if (!file)
+		goto out;
+
 	return 0;
 
 out:
diff --git a/network-coding.h b/network-coding.h
index 56dadfd..970dbde 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -35,6 +35,9 @@ void batadv_nc_purge_orig(struct batadv_priv *bat_priv,
 					   struct batadv_nc_node *));
 void batadv_nc_init_bat_priv(struct batadv_priv *bat_priv);
 void batadv_nc_init_orig(struct batadv_orig_node *orig_node);
+bool batadv_nc_skb_forward(struct sk_buff *skb,
+			   struct batadv_neigh_node *neigh_node,
+			   struct ethhdr *ethhdr);
 int batadv_nc_nodes_seq_print_text(struct seq_file *seq, void *offset);
 int batadv_nc_init_debugfs(struct batadv_priv *bat_priv);
 
@@ -79,6 +82,13 @@ static inline void batadv_nc_init_orig(struct batadv_orig_node *orig_node)
 	return;
 }
 
+static inline bool batadv_nc_skb_forward(struct sk_buff *skb,
+					 struct batadv_neigh_node *neigh_node,
+					 struct ethhdr *ethhdr)
+{
+	return false;
+}
+
 static inline int batadv_nc_nodes_seq_print_text(struct seq_file *seq,
 						 void *offset)
 {
diff --git a/routing.c b/routing.c
index 0cea96b..f97cfe3 100644
--- a/routing.c
+++ b/routing.c
@@ -29,6 +29,7 @@
 #include "unicast.h"
 #include "bridge_loop_avoidance.h"
 #include "distributed-arp-table.h"
+#include "network-coding.h"
 
 static int batadv_route_unicast_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if);
@@ -865,14 +866,17 @@ static int batadv_route_unicast_packet(struct sk_buff *skb,
 	/* decrement ttl */
 	unicast_packet->header.ttl--;
 
-	/* Update stats counter */
-	batadv_inc_counter(bat_priv, BATADV_CNT_FORWARD);
-	batadv_add_counter(bat_priv, BATADV_CNT_FORWARD_BYTES,
-			   skb->len + ETH_HLEN);
-
-	/* route it */
-	if (batadv_send_skb_to_orig(skb, orig_node, recv_if))
+	/* network code packet if possible */
+	if (batadv_nc_skb_forward(skb, neigh_node, ethhdr)) {
 		ret = NET_RX_SUCCESS;
+	} else if (batadv_send_skb_to_orig(skb, orig_node, recv_if)) {
+		ret = NET_RX_SUCCESS;
+
+		/* Update stats counter */
+		batadv_inc_counter(bat_priv, BATADV_CNT_FORWARD);
+		batadv_add_counter(bat_priv, BATADV_CNT_FORWARD_BYTES,
+				   skb->len + ETH_HLEN);
+	}
 
 out:
 	if (neigh_node)
diff --git a/types.h b/types.h
index beb84f4..b34fde7 100644
--- a/types.h
+++ b/types.h
@@ -275,11 +275,19 @@ struct batadv_priv_dat {
  * struct batadv_priv_nc - per mesh interface network coding private data
  * @work: work queue callback item for cleanup
  * @min_tq: only consider neighbors for encoding if neigh_tq > min_tq
+ * @max_fwd_delay: maximum packet forward delay to allow coding of packets
+ * @timestamp_fwd_flush: timestamp of last forward packet queue flush
+ * @coding_hash: Hash table used to buffer skbs while waiting for another
+ *  incoming skb to code it with. Skbs are added to the buffer just before being
+ *  forwarded in routing.c
  */
 struct batadv_priv_nc {
 	struct delayed_work work;
 	struct dentry *debug_dir;
 	u8 min_tq;
+	u32 max_fwd_delay;
+	unsigned long timestamp_fwd_flush;
+	struct batadv_hashtable *coding_hash;
 };
 
 /**
@@ -441,6 +449,47 @@ struct batadv_nc_node {
 	unsigned long last_seen;
 };
 
+/**
+ * struct batadv_nc_path - network coding path
+ * @hash_entry: next and prev pointer for the list handling
+ * @rcu: struct used for freeing in an RCU-safe manner
+ * @refcount: number of contexts the object is used by
+ * @packet_list: list of buffered packets for this path
+ * @packet_list_lock: access lock for packet list
+ * @next_hop: next hop (destination) of path
+ * @prev_hop: previous hop (source) of path
+ * @last_valid: timestamp for last validation of path
+ */
+struct batadv_nc_path {
+	struct hlist_node hash_entry;
+	struct rcu_head rcu;
+	atomic_t refcount;
+	struct list_head packet_list;
+	spinlock_t packet_list_lock; /* Protects packet_list */
+	uint8_t next_hop[ETH_ALEN];
+	uint8_t prev_hop[ETH_ALEN];
+	unsigned long last_valid;
+};
+
+/**
+ * struct batadv_nc_packet - network coding packet used when coding and
+ *  decoding packets
+ * @list: next and prev pointer for the list handling
+ * @packet_id: crc32 checksum of skb data
+ * @timestamp: field containing the info when the packet was added to path
+ * @neigh_node: pointer to original next hop neighbor of skb
+ * @skb: skb which can be encoded or used for decoding
+ * @nc_path: pointer to path this nc packet is attached to
+ */
+struct batadv_nc_packet {
+	struct list_head list;
+	__be32 packet_id;
+	unsigned long timestamp;
+	struct batadv_neigh_node *neigh_node;
+	struct sk_buff *skb;
+	struct batadv_nc_path *nc_path;
+};
+
 /*	forw_packet - structure for forw_list maintaining packets to be
  *	              send/forwarded
  */
-- 
1.8.0.2

