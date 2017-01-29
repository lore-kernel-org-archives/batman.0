Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 29 Jan 2017 14:57:40 +0100
Message-Id: <20170129135743.21312-4-linus.luessing@c0d3.blue>
In-Reply-To: <20170129135743.21312-1-linus.luessing@c0d3.blue>
References: <20170129135743.21312-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/6] batman-adv: aggregation packet queueing
	and transmission
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

This patch implements the queueing of any broadcast packet and its
following tranmission in an aggregation packet.

A broadcast packet is usually queued for up to 100ms (plus-minus
some jitter) or about 50ms on average.

However if the aggregation worker cannot keep up with emptying its
queue, a 10 to 20 times faster aggregation packet transmission rate is
used.

If an aggregation queue still runs full then broadcast packets are handed
over to the driver directly without aggregation, leaving it up to the
driver to either transmit or drop it, for instance due to congestion.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/aggregation.c    | 475 ++++++++++++++++++++++++++++++++++++++++
 net/batman-adv/aggregation.h    |  31 +++
 net/batman-adv/bat_iv_ogm.c     |   6 +-
 net/batman-adv/hard-interface.c |   5 +
 net/batman-adv/main.c           |  10 +
 net/batman-adv/main.h           |   1 +
 net/batman-adv/originator.c     |   2 +
 net/batman-adv/send.c           |   9 +
 net/batman-adv/soft-interface.c |  11 +-
 net/batman-adv/sysfs.c          |   5 +-
 net/batman-adv/types.h          |  42 +++-
 11 files changed, 590 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/aggregation.c b/net/batman-adv/aggregation.c
index f8b40d1..21b29be 100644
--- a/net/batman-adv/aggregation.c
+++ b/net/batman-adv/aggregation.c
@@ -18,15 +18,430 @@
 #include "aggregation.h"
 #include "main.h"
 
+#include <linux/atomic.h>
+#include <linux/bitops.h>
 #include <linux/etherdevice.h>
 #include <linux/if_ether.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/random.h>
 #include <linux/skbuff.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
+#include "send.h"
 #include "tvlv.h"
 
 /**
+ * batadv_aggr_hardif_start - schedule aggregation packet transmission
+ * @hard_iface: the hard interface to schedule the transmission on
+ *
+ * Schedules an aggregation packet transmission for the next aggregation
+ * interval, plus/minus some jitter.
+ */
+void batadv_aggr_hardif_start(struct batadv_hard_iface *hard_iface)
+{
+	unsigned int msecs = BATADV_MAX_AGGREGATION_MS * 1000;
+
+	/* msecs * [0.9, 1.1] */
+	msecs += prandom_u32() % (msecs / 5) - (msecs / 10);
+	queue_delayed_work(batadv_event_workqueue, &hard_iface->aggr.work,
+			   msecs_to_jiffies(msecs / 1000));
+}
+
+/**
+ * batadv_aggr_hardif_start_urgent - schedule urgent aggregate transmission
+ * @hard_iface: the hard interface to schedule the transmission on
+ *
+ * Schedules an urgent aggregation packet transmission, plus/minus some jitter.
+ * That is at some time between an interval 10 to 20 times faster than the
+ * regular aggregation interval.
+ */
+static void
+batadv_aggr_hardif_start_urgent(struct batadv_hard_iface *hard_iface)
+{
+	unsigned int msecs = BATADV_MAX_AGGREGATION_MS * 1000;
+
+	/* msecs * [0.05, 0.1] */
+	msecs = (msecs / 20) + prandom_u32() % (msecs / 20);
+	queue_delayed_work(batadv_event_workqueue, &hard_iface->aggr.work,
+			   msecs_to_jiffies(msecs / 1000));
+}
+
+/**
+ * batadv_aggr_skb_queue_free - free all elements in an skb queue
+ * @head: the skb queue to empty
+ *
+ * Empties an skb queue and frees all the skbs it contained.
+ */
+static void batadv_aggr_skb_queue_free(struct sk_buff_head *head)
+{
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(head)))
+		kfree_skb(skb);
+}
+
+/**
+ * batadv_aggr_hardif_stop - shutdown an aggregation routine
+ * @hard_iface: the interface to stop aggregation on
+ *
+ * Stops an aggregation timer and destroys the packets queued
+ * on the given interface.
+ */
+void batadv_aggr_hardif_stop(struct batadv_hard_iface *hard_iface)
+{
+	cancel_delayed_work_sync(&hard_iface->aggr.work);
+
+	spin_lock_bh(&hard_iface->aggr.aggr_list_lock);
+	batadv_aggr_skb_queue_free(&hard_iface->aggr.aggr_list);
+	spin_unlock_bh(&hard_iface->aggr.aggr_list_lock);
+}
+
+/**
+ * batadv_aggr_chunk_reserve - reserve space in an aggregation packet
+ * @hard_iface: the interface to reserve on
+ * @skb: the to be aggregated packet to reserve for
+ * @size: size of the aggregation packet
+ *
+ * Tries to reserve space in the aggregation packet for the given skb.
+ * If reservation was successful, then the size of the to be allocated
+ * aggregation packet is increased accordingly.
+ *
+ * Return: True if there was enough space in the aggregation packet left,
+ * false otherwise.
+ */
+static bool batadv_aggr_chunk_reserve(struct batadv_hard_iface *hard_iface,
+				      struct sk_buff *skb,
+				      int *size)
+{
+	unsigned int len = skb->len + sizeof(struct batadv_tvlv_hdr);
+
+	len -= sizeof(((struct batadv_aggr_packet *)0)->packet_type);
+	len -= sizeof(((struct batadv_aggr_packet *)0)->version);
+
+	if (*size + len > hard_iface->net_dev->mtu)
+		return false;
+
+	*size += len;
+	return true;
+}
+
+/**
+ * batadv_aggr_get_chunk - gets a chunk of packets from the aggregation queue
+ * @hard_iface: the interface to get to be aggregated packets from
+ * @head: queue to stage a chunk of to be aggregated+transmitted packets on
+ * @size: size of the aggregation packet
+ *
+ * Tries to grab as many packets from the aggregation queue as fit into a
+ * single aggregation packet.
+ *
+ * Return: True if there are no packets in the aggregation queue
+ * of the provided interface left afterwards, false otherwise.
+ */
+static bool batadv_aggr_get_chunk(struct batadv_hard_iface *hard_iface,
+				  struct sk_buff_head *head,
+				  int *size)
+{
+	struct sk_buff *skb, *skb_tmp;
+	bool emptied = true;
+
+	*size = sizeof(struct batadv_aggr_packet);
+
+	if (skb_queue_empty(&hard_iface->aggr.aggr_list))
+		return emptied;
+
+	spin_lock_bh(&hard_iface->aggr.aggr_list_lock);
+	skb_queue_walk_safe(&hard_iface->aggr.aggr_list, skb, skb_tmp) {
+		if (!batadv_aggr_chunk_reserve(hard_iface, skb, size)) {
+			emptied = false;
+			break;
+		}
+
+		skb_unlink(skb, &hard_iface->aggr.aggr_list);
+		skb_queue_tail(head, skb);
+	}
+	spin_unlock_bh(&hard_iface->aggr.aggr_list_lock);
+
+	return emptied;
+}
+
+/**
+ * batadv_aggr_alloc_skb - allocate an aggregation packet
+ * @size: size of the to be allocated packet (excluding ethernet header)
+ *
+ * Allocates a broadcast aggregation packet.
+ *
+ * Return: An aggregation packet on success, NULL otherwise.
+ */
+static struct sk_buff *batadv_aggr_alloc_skb(int size)
+{
+	struct batadv_aggr_packet *aggr_packet;
+	struct sk_buff *skb;
+	unsigned char *skb_buff;
+	unsigned int offset;
+
+	skb = dev_alloc_skb(size + ETH_HLEN + NET_IP_ALIGN);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, ETH_HLEN + NET_IP_ALIGN);
+	skb_reset_network_header(skb);
+
+	skb_buff = skb_put(skb, sizeof(*aggr_packet));
+	aggr_packet = (struct batadv_aggr_packet *)skb_buff;
+	aggr_packet->packet_type = BATADV_BCAST_AGGR;
+	aggr_packet->version = BATADV_COMPAT_VERSION;
+
+	offset = skb_network_offset(skb) + sizeof(*aggr_packet);
+	skb_set_transport_header(skb, offset);
+
+	return skb;
+}
+
+/**
+ * batadv_aggr_get_pkttypes - get the packet type of a batman packet
+ * @skb: the packet to get the type from
+ *
+ * Return: The packet type of the provided batman packet.
+ */
+static u8 batadv_aggr_get_pkttype(struct sk_buff *skb)
+{
+	struct batadv_aggr_packet *packet;
+
+	packet = (struct batadv_aggr_packet *)skb_network_header(skb);
+
+	return packet->packet_type;
+}
+
+/**
+ * batadv_aggr_put_tvlvhdr - append a tvlv header to an skb
+ * @skb: the aggregation packet to append the tvlv header to
+ * @type: the packet (= tvlv) type to set in the tvlv header
+ * @len: the size of the to be added tvlv data
+ *
+ * Appends a tvlv header to the given aggregation packet and sets its type and
+ * length as provided.
+ */
+static void batadv_aggr_put_tvlvhdr(struct sk_buff *skb, u8 type,
+				    unsigned int len)
+{
+	struct batadv_tvlv_hdr *tvlv_hdr;
+
+	tvlv_hdr = (struct batadv_tvlv_hdr *)skb_put(skb, sizeof(*tvlv_hdr));
+
+	tvlv_hdr->type = type;
+	tvlv_hdr->version = 1;
+	tvlv_hdr->len = htons(len);
+}
+
+/**
+ * batadv_aggr_queue_is_full - check for slots left in aggregation queue
+ * @hard_iface: the interface to check
+ *
+ * Return: True if if the queue is full, false otherwise.
+ */
+static inline bool
+batadv_aggr_queue_is_full(struct batadv_hard_iface *hard_iface)
+{
+	struct sk_buff_head *head = &hard_iface->aggr.aggr_list;
+
+	return skb_queue_len(head) >= BATADV_AGGR_QUEUE_LEN;
+}
+
+/**
+ * batadv_aggr_squash_chunk - squash packets into an aggregate
+ * @head: a list of to be squashed packets
+ * @size: the size of the to be created aggregation packet
+ *  (excluding the ethernet header)
+ *
+ * Allocates an aggregation packet and squashes the provided list of broadcast
+ * packets into it. The provided list of packets is freed/consumed.
+ *
+ * Return: An aggregation packet ready for transmission on success, NULL
+ * otherwise.
+ */
+static struct sk_buff *
+batadv_aggr_squash_chunk(struct sk_buff_head *head,
+			 int size)
+{
+	struct sk_buff *skb, *skb_tmp, *skb_aggr;
+	struct batadv_aggr_packet *aggr_packet;
+	unsigned int len, offset, tvlv_len = 0;
+	unsigned char *to;
+	u8 type;
+
+	if (skb_queue_empty(head))
+		return NULL;
+
+	skb_aggr = batadv_aggr_alloc_skb(size);
+	if (!skb_aggr) {
+		batadv_aggr_skb_queue_free(head);
+		return NULL;
+	}
+
+	aggr_packet = (struct batadv_aggr_packet *)skb_network_header(skb_aggr);
+
+	skb_queue_walk_safe(head, skb, skb_tmp) {
+		offset = skb_network_offset(skb);
+		offset += sizeof(aggr_packet->packet_type);
+		offset += sizeof(aggr_packet->version);
+		len = skb->len - offset;
+		type = batadv_aggr_get_pkttype(skb);
+
+		batadv_aggr_put_tvlvhdr(skb_aggr, type, len);
+		to = skb_put(skb_aggr, len);
+		skb_copy_bits(skb, offset, to, len);
+		skb_unlink(skb, head);
+		consume_skb(skb);
+
+		tvlv_len += len + sizeof(struct batadv_tvlv_hdr);
+	}
+
+	aggr_packet->tvlv_len = htons(tvlv_len);
+
+	return skb_aggr;
+}
+
+/**
+ * __batadv_aggr_send_chunk - send a prepared aggregation packet
+ * @hard_iface: the interface to transmit on
+ * @skb: the prepared aggregation packet to send
+ */
+static void __batadv_aggr_send_chunk(struct batadv_hard_iface *hard_iface,
+				     struct sk_buff *skb)
+{
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+
+	batadv_inc_counter(bat_priv, BATADV_CNT_AGGR_TX);
+	batadv_add_counter(bat_priv, BATADV_CNT_AGGR_TX_BYTES,
+			   skb->len + ETH_HLEN);
+
+	/* ToDo: Track transmission failures? */
+	batadv_send_skb_packet(skb, hard_iface, batadv_broadcast_addr);
+}
+
+/**
+ * batadv_aggr_send_chunk - prepare and transmit an aggregation packet
+ * @hard_iface: the interface to transmit on
+ *
+ * Fetches as many packets from the aggregation queue of the provided interface
+ * as fit into a single aggregation packet. Then aggregates them into such an
+ * aggregation packet and transmits the final aggregate.
+ *
+ * Return: True if there are no packets in the aggregation queue
+ * of the provided interface left afterwards, false otherwise.
+ */
+static bool batadv_aggr_send_chunk(struct batadv_hard_iface *hard_iface)
+{
+	struct sk_buff_head head;
+	struct sk_buff *skb;
+	int size = 0;
+	bool emptied;
+
+	skb_queue_head_init(&head);
+	emptied = batadv_aggr_get_chunk(hard_iface, &head, &size);
+
+	skb = batadv_aggr_squash_chunk(&head, size);
+	if (!skb)
+		goto out;
+
+	__batadv_aggr_send_chunk(hard_iface, skb);
+
+out:
+	return emptied;
+}
+
+/**
+ * batadv_aggr_work - periodic aggregation worker
+ * @work: work queue item
+ *
+ * Prepares and sends out an aggregation packet. In the end rearms the timer
+ * either to the next aggregation interval, or if there were still packets left
+ * in the aggregation queue, sets it to an earlier time.
+ */
+static void batadv_aggr_work(struct work_struct *work)
+{
+	struct batadv_hard_iface_aggr *aggr;
+	struct batadv_hard_iface *hard_iface;
+	struct batadv_priv *bat_priv;
+	bool emptied;
+
+	aggr = container_of(work, struct batadv_hard_iface_aggr, work.work);
+	hard_iface = container_of(aggr, struct batadv_hard_iface, aggr);
+	bat_priv = netdev_priv(hard_iface->soft_iface);
+
+	emptied = batadv_aggr_send_chunk(hard_iface);
+	if (emptied) {
+		batadv_aggr_hardif_start(hard_iface);
+	} else {
+		batadv_inc_counter(bat_priv, BATADV_CNT_AGGR_URGENT);
+		batadv_aggr_hardif_start_urgent(hard_iface);
+	}
+}
+
+/**
+ * batadv_aggr_queue - queue a broadcast packet for aggregation
+ * @skb: the packet to queue
+ * @hard_iface: the interface to queue on
+ *
+ * Return: NET_XMIT_SUCCESS if the skb was queued, NET_XMIT_DROP otherwise.
+ * The former consumes the skb.
+ */
+int batadv_aggr_queue(struct sk_buff *skb, struct batadv_hard_iface *hard_iface)
+{
+	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
+
+	if (!atomic_read(&bat_priv->aggregation))
+		return NET_XMIT_DROP;
+
+	if (atomic_read(&bat_priv->aggr_num_disabled))
+		return NET_XMIT_DROP;
+
+	if (batadv_aggr_queue_is_full(hard_iface)) {
+		batadv_inc_counter(bat_priv, BATADV_CNT_AGGR_QUEUE_FULL);
+		return NET_XMIT_DROP;
+	}
+
+	spin_lock_bh(&hard_iface->aggr.aggr_list_lock);
+	skb_queue_tail(&hard_iface->aggr.aggr_list, skb);
+	spin_unlock_bh(&hard_iface->aggr.aggr_list_lock);
+
+	batadv_inc_counter(bat_priv, BATADV_CNT_AGGR_PARTS_TX);
+	batadv_add_counter(bat_priv, BATADV_CNT_AGGR_PARTS_TX_BYTES,
+			   skb->len + ETH_HLEN);
+
+	return NET_XMIT_SUCCESS;
+}
+
+/**
+ * batadv_aggr_purge_orig - reset originator aggregation state modifications
+ * @orig: the originator which is going to get purged
+ */
+void batadv_aggr_purge_orig(struct batadv_orig_node *orig)
+{
+	struct batadv_priv *bat_priv = orig->bat_priv;
+
+	if (!test_bit(BATADV_ORIG_CAPA_HAS_AGGR, &orig->capabilities) &&
+	    test_bit(BATADV_ORIG_CAPA_HAS_AGGR, &orig->capa_initialized))
+		atomic_dec(&bat_priv->aggr_num_disabled);
+}
+
+/**
+ * batadv_aggr_hardif_init - initialize an interface for aggregation
+ * @hard_iface: the interface to initialize
+ */
+void batadv_aggr_hardif_init(struct batadv_hard_iface *hard_iface)
+{
+	INIT_DELAYED_WORK(&hard_iface->aggr.work, batadv_aggr_work);
+	skb_queue_head_init(&hard_iface->aggr.aggr_list);
+	spin_lock_init(&hard_iface->aggr.aggr_list_lock);
+}
+
+/**
  * batadv_aggr_add_counter_rx - update aggregation rx statistics
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the skb to count
@@ -150,6 +565,55 @@ static int batadv_aggr_tvlv_handler(struct batadv_priv *bat_priv,
 }
 
 /**
+ * batadv_aggr_ogm_handler - process incoming aggregation tvlv container
+ * @bat_priv: the bat priv with all the soft interface information
+ * @tvlv_value: tvlv buffer containing an aggregated broadcast packet
+ * @tvlv_value_len: tvlv buffer length
+ * @ctx: handler specific context information
+ *  (here: recv_if, h_source and packet type of aggregate)
+ *
+ * Parses an aggregation tvlv attached to an originator message and updates
+ * aggregation capabilities accordingly.
+ *
+ * Return: Always NET_RX_SUCCESS.
+ */
+static int batadv_aggr_ogm_handler(struct batadv_priv *bat_priv,
+				   void *tvlv_value, u16 tvlv_value_len,
+				   void *ctx)
+{
+	struct batadv_orig_node *orig = ctx;
+	bool orig_aggr_enabled = !!tvlv_value;
+	bool orig_initialized;
+
+	orig_initialized = test_bit(BATADV_ORIG_CAPA_HAS_AGGR,
+				    &orig->capa_initialized);
+
+	/* If aggregation support is turned on decrease the disabled aggregation
+	 * node counter only if we had increased it for this node before. If
+	 * this is a completely new orig_node no need to decrease the counter.
+	 */
+	if (orig_aggr_enabled &&
+	    !test_bit(BATADV_ORIG_CAPA_HAS_AGGR, &orig->capabilities)) {
+		if (orig_initialized)
+			atomic_dec(&bat_priv->aggr_num_disabled);
+		set_bit(BATADV_ORIG_CAPA_HAS_AGGR, &orig->capabilities);
+	/* If aggregation support is being switched off or if this is an initial
+	 * OGM without aggregation support then increase the disabled
+	 * aggregation node counter.
+	 */
+	} else if (!orig_aggr_enabled &&
+		   (test_bit(BATADV_ORIG_CAPA_HAS_AGGR, &orig->capabilities) ||
+		    !orig_initialized)) {
+		atomic_inc(&bat_priv->aggr_num_disabled);
+		clear_bit(BATADV_ORIG_CAPA_HAS_AGGR, &orig->capabilities);
+	}
+
+	set_bit(BATADV_ORIG_CAPA_HAS_AGGR, &orig->capa_initialized);
+
+	return NET_RX_SUCCESS;
+}
+
+/**
  * batadv_aggr_mesh_init - initialise the generic aggregation engine
  * @bat_priv: the bat priv with all the soft interface information
  *
@@ -160,6 +624,13 @@ int batadv_aggr_mesh_init(struct batadv_priv *bat_priv)
 	batadv_tvlv_handler_register2(bat_priv, batadv_aggr_tvlv_handler,
 				      BATADV_BCAST_AGGR, BATADV_TVLV_ANY, 1,
 				      BATADV_TVLV_HANDLER_MORECTX);
+	batadv_tvlv_handler_register2(bat_priv, batadv_aggr_ogm_handler,
+				      BATADV_IV_OGM, BATADV_TVLV_AGGR, 1,
+				      BATADV_TVLV_HANDLER_CIFNOTFND);
+	batadv_tvlv_handler_register2(bat_priv, batadv_aggr_ogm_handler,
+				      BATADV_OGM2, BATADV_TVLV_AGGR, 1,
+				      BATADV_TVLV_HANDLER_CIFNOTFND);
+
 	batadv_tvlv_container_register(bat_priv, BATADV_TVLV_AGGR, 1, NULL, 0);
 
 	return 0;
@@ -172,6 +643,10 @@ int batadv_aggr_mesh_init(struct batadv_priv *bat_priv)
 void batadv_aggr_mesh_free(struct batadv_priv *bat_priv)
 {
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_AGGR, 1);
+	batadv_tvlv_handler_unregister2(bat_priv, BATADV_OGM2, BATADV_TVLV_AGGR,
+					1);
+	batadv_tvlv_handler_unregister2(bat_priv, BATADV_IV_OGM,
+					BATADV_TVLV_AGGR, 1);
 	batadv_tvlv_handler_unregister2(bat_priv, BATADV_BCAST_AGGR,
 					BATADV_TVLV_ANY, 1);
 }
diff --git a/net/batman-adv/aggregation.h b/net/batman-adv/aggregation.h
index 5b577e6..7f4c3d6 100644
--- a/net/batman-adv/aggregation.h
+++ b/net/batman-adv/aggregation.h
@@ -27,6 +27,14 @@ struct sk_buff;
 void batadv_aggr_add_counter_rx(struct batadv_priv *bat_priv,
 				struct sk_buff *skb);
 
+void batadv_aggr_hardif_start(struct batadv_hard_iface *hard_iface);
+void batadv_aggr_hardif_stop(struct batadv_hard_iface *hard_iface);
+
+int batadv_aggr_queue(struct sk_buff *skb,
+		      struct batadv_hard_iface *hard_iface);
+
+void batadv_aggr_purge_orig(struct batadv_orig_node *orig);
+void batadv_aggr_hardif_init(struct batadv_hard_iface *hard_iface);
 int batadv_aggr_mesh_init(struct batadv_priv *bat_priv);
 void batadv_aggr_mesh_free(struct batadv_priv *bat_priv);
 
@@ -37,6 +45,29 @@ static inline void batadv_aggr_add_counter_rx(struct batadv_priv *bat_priv,
 {
 }
 
+static inline void
+batadv_aggr_hardif_start(struct batadv_hard_iface *hard_iface)
+{
+}
+
+static inline void batadv_aggr_hardif_stop(struct batadv_hard_iface *hard_iface)
+{
+}
+
+static inline int batadv_aggr_queue(struct sk_buff *skb,
+				    struct batadv_hard_iface *hard_iface)
+{
+	return NET_XMIT_DROP;
+}
+
+static inline void batadv_aggr_purge_orig(struct batadv_orig_node *orig)
+{
+}
+
+static inline void batadv_aggr_hardif_init(struct batadv_hard_iface *hard_iface)
+{
+}
+
 static inline int batadv_aggr_mesh_init(struct batadv_priv *bat_priv)
 {
 	return 0;
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 3718ac9..f493fc8 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -688,7 +688,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	if (!forw_packet_aggr)
 		return;
 
-	if (atomic_read(&bat_priv->aggregated_ogms) &&
+	if (atomic_read(&bat_priv->aggregation) &&
 	    packet_len < BATADV_MAX_AGGREGATION_BYTES)
 		skb_size = BATADV_MAX_AGGREGATION_BYTES;
 	else
@@ -776,7 +776,7 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 	/* find position for the packet in the forward queue */
 	spin_lock_bh(&bat_priv->forw_bat_list_lock);
 	/* own packets are not to be aggregated */
-	if (atomic_read(&bat_priv->aggregated_ogms) && !own_packet) {
+	if (atomic_read(&bat_priv->aggregation) && !own_packet) {
 		hlist_for_each_entry(forw_packet_pos,
 				     &bat_priv->forw_bat_list, list) {
 			if (batadv_iv_ogm_can_aggregate(batadv_ogm_packet,
@@ -802,7 +802,7 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 		 * we hold it back for a while, so that it might be aggregated
 		 * later on
 		 */
-		if (!own_packet && atomic_read(&bat_priv->aggregated_ogms))
+		if (!own_packet && atomic_read(&bat_priv->aggregation))
 			send_time += max_aggregation_jiffies;
 
 		batadv_iv_ogm_aggregate_new(packet_buff, packet_len,
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index c502c41..42d8e2b 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -38,6 +38,7 @@
 #include <net/net_namespace.h>
 #include <net/rtnetlink.h>
 
+#include "aggregation.h"
 #include "bat_v.h"
 #include "bridge_loop_avoidance.h"
 #include "debugfs.h"
@@ -759,6 +760,8 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	if (ret < 0)
 		goto err_upper;
 
+	batadv_aggr_hardif_start(hard_iface);
+
 	hard_iface->if_num = bat_priv->num_ifaces;
 	bat_priv->num_ifaces++;
 	hard_iface->if_status = BATADV_IF_INACTIVE;
@@ -845,6 +848,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 			batadv_hardif_put(new_if);
 	}
 
+	batadv_aggr_hardif_stop(hard_iface);
 	bat_priv->algo_ops->iface.disable(hard_iface);
 	hard_iface->if_status = BATADV_IF_NOT_IN_USE;
 
@@ -914,6 +918,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 		hard_iface->num_bcasts = BATADV_NUM_BCASTS_WIRELESS;
 
 	batadv_v_hardif_init(hard_iface);
+	batadv_aggr_hardif_init(hard_iface);
 
 	batadv_check_known_mac_addr(hard_iface->net_dev);
 	kref_get(&hard_iface->refcount);
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 6ea29c5..5d96eae 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -350,6 +350,16 @@ int batadv_max_header_len(void)
 	header_len = max_t(int, header_len,
 			   sizeof(struct batadv_coded_packet));
 #endif
+#ifdef CONFIG_BATMAN_ADV_AGGR
+	header_len = max_t(int, header_len,
+			   sizeof(struct batadv_aggr_packet) +
+			   sizeof(struct batadv_tvlv_hdr) +
+			   sizeof(struct batadv_bcast_packet) -
+			   sizeof(((struct batadv_bcast_packet *)0)
+				   ->packet_type) -
+			   sizeof(((struct batadv_bcast_packet *)0)
+				   ->version));
+#endif
 
 	return header_len + ETH_HLEN;
 }
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 57a8103..c9830ef 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -148,6 +148,7 @@ enum batadv_mesh_state {
 
 #define BATADV_BCAST_QUEUE_LEN		256
 #define BATADV_BATMAN_QUEUE_LEN	256
+#define BATADV_AGGR_QUEUE_LEN	512
 
 enum batadv_uev_action {
 	BATADV_UEV_ADD = 0,
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index ed802b5..f44aa16 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -39,6 +39,7 @@
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
+#include "aggregation.h"
 #include "bat_algo.h"
 #include "distributed-arp-table.h"
 #include "fragmentation.h"
@@ -902,6 +903,7 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 	batadv_mcast_purge_orig(orig_node);
 
 	batadv_frag_purge_orig(orig_node, NULL);
+	batadv_aggr_purge_orig(orig_node);
 
 	if (orig_node->bat_priv->algo_ops->orig.free)
 		orig_node->bat_priv->algo_ops->orig.free(orig_node);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index b60efbb..4789cbe 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -40,6 +40,7 @@
 #include <linux/stddef.h>
 #include <linux/workqueue.h>
 
+#include "aggregation.h"
 #include "distributed-arp-table.h"
 #include "fragmentation.h"
 #include "gateway_client.h"
@@ -126,6 +127,14 @@ send_skb_err:
 int batadv_send_broadcast_skb(struct sk_buff *skb,
 			      struct batadv_hard_iface *hard_iface)
 {
+	int ret;
+
+	skb_reset_network_header(skb);
+
+	ret = batadv_aggr_queue(skb, hard_iface);
+	if (ret == NET_XMIT_SUCCESS)
+		return ret;
+
 	return batadv_send_skb_packet(skb, hard_iface, batadv_broadcast_addr);
 }
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 1b0ef7e..abe21f1 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -798,7 +798,10 @@ static int batadv_softif_init_late(struct net_device *dev)
 	if (!bat_priv->bat_counters)
 		return -ENOMEM;
 
-	atomic_set(&bat_priv->aggregated_ogms, 1);
+	atomic_set(&bat_priv->aggregation, 1);
+#ifdef CONFIG_BATMAN_ADV_AGGR
+	atomic_set(&bat_priv->aggr_num_disabled, 0);
+#endif
 	atomic_set(&bat_priv->bonding, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_set(&bat_priv->bridge_loop_avoidance, 1);
@@ -1150,10 +1153,16 @@ static const struct {
 	{ "frag_fwd" },
 	{ "frag_fwd_bytes" },
 #ifdef CONFIG_BATMAN_ADV_AGGR
+	{ "aggr_tx" },
+	{ "aggr_tx_bytes" },
 	{ "aggr_rx" },
 	{ "aggr_rx_bytes" },
+	{ "aggr_parts_tx" },
+	{ "aggr_parts_tx_bytes" },
 	{ "aggr_parts_rx" },
 	{ "aggr_parts_rx_bytes" },
+	{ "aggr_queue_full" },
+	{ "aggr_urgent" },
 #endif
 	{ "tt_request_tx" },
 	{ "tt_request_rx" },
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 0ae8b30..387d324 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -665,7 +665,9 @@ static ssize_t batadv_store_isolation_mark(struct kobject *kobj,
 	return count;
 }
 
-BATADV_ATTR_SIF_BOOL(aggregated_ogms, 0644, NULL);
+BATADV_ATTR_SIF_BOOL(aggregation, 0644, NULL);
+static BATADV_ATTR(aggregated_ogms, 0644, batadv_show_aggregation,
+		   batadv_store_aggregation);
 BATADV_ATTR_SIF_BOOL(bonding, 0644, NULL);
 #ifdef CONFIG_BATMAN_ADV_BLA
 BATADV_ATTR_SIF_BOOL(bridge_loop_avoidance, 0644, batadv_bla_status_update);
@@ -698,6 +700,7 @@ static BATADV_ATTR(isolation_mark, 0644, batadv_show_isolation_mark,
 
 static struct batadv_attribute *batadv_mesh_attrs[] = {
 	&batadv_attr_aggregated_ogms,
+	&batadv_attr_aggregation,
 	&batadv_attr_bonding,
 #ifdef CONFIG_BATMAN_ADV_BLA
 	&batadv_attr_bridge_loop_avoidance,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0e25f01..575fdf1 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -145,6 +145,20 @@ enum batadv_hard_iface_wifi_flags {
 	BATADV_HARDIF_WIFI_CFG80211_INDIRECT = BIT(3),
 };
 
+#ifdef CONFIG_BATMAN_ADV_AGGR
+/**
+ * struct batadv_hard_iface_aggr - per hard-interface aggregation data
+ * @aggr_list: list for to be aggregated broadcast packets
+ * @aggr_list_lock: lock protecting aggr_list
+ * @work: work item for periodic aggregation packet transmissions
+ */
+struct batadv_hard_iface_aggr {
+	struct sk_buff_head aggr_list;
+	spinlock_t aggr_list_lock; /* protects aggr_list */
+	struct delayed_work work;
+};
+#endif
+
 /**
  * struct batadv_hard_iface - network device known to batman-adv
  * @list: list node for batadv_hardif_list
@@ -161,6 +175,7 @@ enum batadv_hard_iface_wifi_flags {
  * @rcu: struct used for freeing in an RCU-safe manner
  * @bat_iv: per hard-interface B.A.T.M.A.N. IV data
  * @bat_v: per hard-interface B.A.T.M.A.N. V data
+ * @aggr: per hard-interface aggregation data
  * @debug_dir: dentry for nc subdir in batman-adv directory in debugfs
  * @neigh_list: list of unique single hop neighbors via this interface
  * @neigh_list_lock: lock protecting neigh_list
@@ -181,6 +196,9 @@ struct batadv_hard_iface {
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	struct batadv_hard_iface_bat_v bat_v;
 #endif
+#ifdef CONFIG_BATMAN_ADV_AGGR
+	struct batadv_hard_iface_aggr aggr;
+#endif
 	struct dentry *debug_dir;
 	struct hlist_head neigh_list;
 	/* neigh_list_lock protects: neigh_list */
@@ -388,12 +406,14 @@ struct batadv_orig_node {
  * @BATADV_ORIG_CAPA_HAS_TT: orig node has tt capability
  * @BATADV_ORIG_CAPA_HAS_MCAST: orig node has some multicast capability
  *  (= orig node announces a tvlv of type BATADV_TVLV_MCAST)
+ * @BATADV_ORIG_CAPA_HAS_AGGR: orig node has broadcast aggregation capability
  */
 enum batadv_orig_capabilities {
 	BATADV_ORIG_CAPA_HAS_DAT,
 	BATADV_ORIG_CAPA_HAS_NC,
 	BATADV_ORIG_CAPA_HAS_TT,
 	BATADV_ORIG_CAPA_HAS_MCAST,
+	BATADV_ORIG_CAPA_HAS_AGGR,
 };
 
 /**
@@ -575,10 +595,17 @@ struct batadv_bcast_duplist_entry {
  * @BATADV_CNT_FRAG_RX_BYTES: received fragment traffic bytes counter
  * @BATADV_CNT_FRAG_FWD: forwarded fragment traffic packet counter
  * @BATADV_CNT_FRAG_FWD_BYTES: forwarded fragment traffic bytes counter
+ * @BATADV_CNT_AGGR_TX: transmitted aggregation traffic packet count
+ * @BATADV_CNT_AGGR_TX_BYTES: transmitted aggregation traffic bytes counter
  * @BATADV_CNT_AGGR_RX: received aggregation traffic packet count
  * @BATADV_CNT_AGGR_RX_BYTES: received aggregation traffic bytes counter
+ * @BATADV_CNT_AGGR_PARTS_TX: transmitted aggregated traffic packet counter
+ * @BATADV_CNT_AGGR_PARTS_TX_BYTES: transmitted aggregated bytes counter
  * @BATADV_CNT_AGGR_PARTS_RX: received aggregated traffic packet counter
  * @BATADV_CNT_AGGR_PARTS_RX_BYTES: received aggregated bytes counter
+ * @BATADV_CNT_AGGR_QUEUE_FULL: counter for packets dismissed for aggregation
+ *  due to a full aggregation queue
+ * @BATADV_CNT_AGGR_URGENT: counter for early aggregation packet transmissions
  * @BATADV_CNT_TT_REQUEST_TX: transmitted tt req traffic packet counter
  * @BATADV_CNT_TT_REQUEST_RX: received tt req traffic packet counter
  * @BATADV_CNT_TT_RESPONSE_TX: transmitted tt resp traffic packet counter
@@ -623,10 +650,16 @@ enum batadv_counters {
 	BATADV_CNT_FRAG_FWD,
 	BATADV_CNT_FRAG_FWD_BYTES,
 #ifdef CONFIG_BATMAN_ADV_AGGR
+	BATADV_CNT_AGGR_TX,
+	BATADV_CNT_AGGR_TX_BYTES,
 	BATADV_CNT_AGGR_RX,
 	BATADV_CNT_AGGR_RX_BYTES,
+	BATADV_CNT_AGGR_PARTS_TX,
+	BATADV_CNT_AGGR_PARTS_TX_BYTES,
 	BATADV_CNT_AGGR_PARTS_RX,
 	BATADV_CNT_AGGR_PARTS_RX_BYTES,
+	BATADV_CNT_AGGR_QUEUE_FULL,
+	BATADV_CNT_AGGR_URGENT,
 #endif
 	BATADV_CNT_TT_REQUEST_TX,
 	BATADV_CNT_TT_REQUEST_RX,
@@ -1031,7 +1064,9 @@ struct batadv_priv_bat_v {
  * @soft_iface: net device which holds this struct as private data
  * @stats: structure holding the data for the ndo_get_stats() call
  * @bat_counters: mesh internal traffic statistic counters (see batadv_counters)
- * @aggregated_ogms: bool indicating whether OGM aggregation is enabled
+ * @aggregation: bool indicating whether aggregation is enabled
+ * @aggr_num_disabled: number of nodes that have no broadcast aggregation
+ *  capability
  * @bonding: bool indicating whether traffic bonding is enabled
  * @fragmentation: bool indicating whether traffic fragmentation is enabled
  * @packet_size_max: max packet size that can be transmitted via
@@ -1086,7 +1121,10 @@ struct batadv_priv {
 	struct net_device *soft_iface;
 	struct net_device_stats stats;
 	u64 __percpu *bat_counters; /* Per cpu counters */
-	atomic_t aggregated_ogms;
+	atomic_t aggregation;
+#ifdef CONFIG_BATMAN_ADV_AGGR
+	atomic_t aggr_num_disabled;
+#endif
 	atomic_t bonding;
 	atomic_t fragmentation;
 	atomic_t packet_size_max;
-- 
2.1.4

