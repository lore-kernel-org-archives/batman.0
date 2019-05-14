Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH 1/3] batman-adv: bcast: queue per interface, if needed
Date: Tue, 14 May 2019 09:38:57 +0200
Message-Id: <20190514073859.2053-2-linus.luessing@c0d3.blue>
In-Reply-To: <20190514073859.2053-1-linus.luessing@c0d3.blue>
References: <20190514073859.2053-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Currently we schedule a broadcast packet like:

3x: [ [(re-)queue] --> for(hard-if): maybe-transmit ]

The intention of queueing a broadcast packet multiple times is to
increase robustness for wireless interfaces. However on interfaces
which we only broadcast on once the queueing induces an unncessary
penalty. This patch restructures the queueing to be performed on a per
interface basis:

for(hard-if):
- transmit
- if wireless: [queue] --> transmit --> [requeue] --> transmit

Next to the performance benefits on non-wireless interfaces this
should also make it easier to apply alternative strategies for
transmissions on wireless interfaces in the future (for instance sending
via unicast transmissions on wireless interfaces, without queueing in
batman-adv, if appropriate).

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/main.h           |   1 -
 net/batman-adv/routing.c        |   9 +-
 net/batman-adv/send.c           | 391 ++++++++++++++++++++++----------
 net/batman-adv/send.h           |  12 +-
 net/batman-adv/soft-interface.c |  12 +-
 5 files changed, 288 insertions(+), 137 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index c59afcba..ddef606c 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -88,7 +88,6 @@
 /* number of packets to send for broadcasts on different interface types */
 #define BATADV_NUM_BCASTS_DEFAULT 1
 #define BATADV_NUM_BCASTS_WIRELESS 3
-#define BATADV_NUM_BCASTS_MAX 3
 
 /* length of the single packet used by the TP meter */
 #define BATADV_TP_PACKET_LEN ETH_DATA_LEN
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index f0f86482..30fbd073 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1188,9 +1188,9 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	struct batadv_bcast_packet *bcast_packet;
 	struct ethhdr *ethhdr;
 	int hdr_size = sizeof(*bcast_packet);
-	int ret = NET_RX_DROP;
 	s32 seq_diff;
 	u32 seqno;
+	int ret;
 
 	/* drop packet if it has not necessary minimum size */
 	if (unlikely(!pskb_may_pull(skb, hdr_size)))
@@ -1216,7 +1216,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (batadv_is_my_mac(bat_priv, bcast_packet->orig))
 		goto free_skb;
 
-	if (bcast_packet->ttl < 2)
+	if (bcast_packet->ttl-- < 2)
 		goto free_skb;
 
 	orig_node = batadv_orig_hash_find(bat_priv, bcast_packet->orig);
@@ -1255,7 +1255,9 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	batadv_skb_set_priority(skb, sizeof(struct batadv_bcast_packet));
 
 	/* rebroadcast packet */
-	batadv_add_bcast_packet_to_list(bat_priv, skb, 1, false);
+	ret = batadv_forw_bcast_packet(bat_priv, skb, 0, false);
+	if (ret == NETDEV_TX_BUSY)
+		goto free_skb;
 
 	/* don't hand the broadcast up if it is from an originator
 	 * from the same backbone.
@@ -1281,6 +1283,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
 free_skb:
 	kfree_skb(skb);
+	ret = NET_RX_DROP;
 out:
 	if (orig_node)
 		batadv_orig_node_put(orig_node);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 3ce5f7ba..1341b9ac 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -737,57 +737,52 @@ void batadv_forw_packet_ogmv1_queue(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_add_bcast_packet_to_list() - queue broadcast packet for multiple sends
+ * batadv_forw_bcast_packet_to_list() - queue broadcast packet for transmissions
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: broadcast packet to add
  * @delay: number of jiffies to wait before sending
  * @own_packet: true if it is a self-generated broadcast packet
+ * @if_in: the interface where the packet was received on
+ * @if_out: the outgoing interface to queue on
  *
- * add a broadcast packet to the queue and setup timers. broadcast packets
+ * Adds a broadcast packet to the queue and sets up timers. Broadcast packets
  * are sent multiple times to increase probability for being received.
  *
- * The skb is not consumed, so the caller should make sure that the
- * skb is freed.
+ * This call clones the given skb, hence the caller needs to take into
+ * account that the data segment of the original skb might not be
+ * modifiable anymore.
  *
  * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY on errors.
  */
-int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
-				    const struct sk_buff *skb,
-				    unsigned long delay,
-				    bool own_packet)
+static int batadv_forw_bcast_packet_to_list(struct batadv_priv *bat_priv,
+					    struct sk_buff *skb,
+					    unsigned long delay,
+					    bool own_packet,
+					    struct batadv_hard_iface *if_in,
+					    struct batadv_hard_iface *if_out)
 {
-	struct batadv_hard_iface *primary_if;
 	struct batadv_forw_packet *forw_packet;
-	struct batadv_bcast_packet *bcast_packet;
+	unsigned long send_time = jiffies;
 	struct sk_buff *newskb;
 
-	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if)
+	newskb = skb_clone(skb, GFP_ATOMIC);
+	if (!newskb)
 		goto err;
 
-	newskb = skb_copy(skb, GFP_ATOMIC);
-	if (!newskb) {
-		batadv_hardif_put(primary_if);
-		goto err;
-	}
-
-	forw_packet = batadv_forw_packet_alloc(primary_if, NULL,
+	forw_packet = batadv_forw_packet_alloc(if_in, if_out,
 					       &bat_priv->bcast_queue_left,
 					       bat_priv, newskb);
-	batadv_hardif_put(primary_if);
 	if (!forw_packet)
 		goto err_packet_free;
 
-	/* as we have a copy now, it is safe to decrease the TTL */
-	bcast_packet = (struct batadv_bcast_packet *)newskb->data;
-	bcast_packet->ttl--;
-
 	forw_packet->own = own_packet;
 
 	INIT_DELAYED_WORK(&forw_packet->delayed_work,
 			  batadv_send_outstanding_bcast_packet);
 
-	batadv_forw_packet_bcast_queue(bat_priv, forw_packet, jiffies + delay);
+	send_time += delay ? delay : msecs_to_jiffies(5);
+
+	batadv_forw_packet_bcast_queue(bat_priv, forw_packet, send_time);
 	return NETDEV_TX_OK;
 
 err_packet_free:
@@ -796,6 +791,231 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	return NETDEV_TX_BUSY;
 }
 
+/**
+ * batadv_forw_bcast_packet_if() - forward and queue a broadcast packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: broadcast packet to add
+ * @delay: number of jiffies to wait before sending
+ * @own_packet: true if it is a self-generated broadcast packet
+ * @if_in: the interface where the packet was received on
+ * @if_out: the outgoing interface to forward to
+ *
+ * Transmits a broadcast packet on the specified interface either immediately
+ * or if a delay is given after that. Furthermore, queues additional
+ * retransmissions if this interface is a wireless one.
+ *
+ * This call clones the given skb, hence the caller needs to take into
+ * account that the data segment of the original skb might not be
+ * modifiable anymore.
+ *
+ * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY on errors.
+ */
+static int batadv_forw_bcast_packet_if(struct batadv_priv *bat_priv,
+				       struct sk_buff *skb,
+				       unsigned long delay,
+				       bool own_packet,
+				       struct batadv_hard_iface *if_in,
+				       struct batadv_hard_iface *if_out)
+{
+	unsigned int num_bcasts = if_out->num_bcasts;
+	struct sk_buff *newskb;
+	int ret = NETDEV_TX_OK;
+
+	if (!delay) {
+		newskb = skb_clone(skb, GFP_ATOMIC);
+		if (!newskb)
+			return NETDEV_TX_BUSY;
+
+		batadv_send_broadcast_skb(newskb, if_out);
+		num_bcasts--;
+	}
+
+	/* delayed broadcast or rebroadcasts? */
+	if (delay || num_bcasts >= 1) {
+		BATADV_SKB_CB(skb)->num_bcasts = num_bcasts;
+
+		ret = batadv_forw_bcast_packet_to_list(bat_priv, skb, delay,
+						       own_packet, if_in,
+						       if_out);
+	}
+
+	return ret;
+}
+
+/**
+ * batadv_send_no_broadcast() - check whether (re)broadcast is necessary
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: broadcast packet to check
+ * @own_packet: true if it is a self-generated broadcast packet
+ * @if_out: the outgoing interface checked and considered for (re)broadcast
+ *
+ * Return: False if a packet needs to be (re)broadcasted on the given interface,
+ * true otherwise.
+ */
+static bool batadv_send_no_broadcast(struct batadv_priv *bat_priv,
+				     struct sk_buff *skb, bool own_packet,
+				     struct batadv_hard_iface *if_out)
+{
+	struct batadv_hardif_neigh_node *neigh_node = NULL;
+	struct batadv_bcast_packet *bcast_packet;
+	u8 *orig_neigh;
+	u8 *neigh_addr;
+	char *type;
+	int ret;
+
+	if (!own_packet) {
+		neigh_addr = eth_hdr(skb)->h_source;
+		neigh_node = batadv_hardif_neigh_get(if_out,
+						     neigh_addr);
+	}
+
+	bcast_packet = (struct batadv_bcast_packet *)skb->data;
+	orig_neigh = neigh_node ? neigh_node->orig : NULL;
+
+	ret = batadv_hardif_no_broadcast(if_out, bcast_packet->orig,
+					 orig_neigh);
+
+	if (neigh_node)
+		batadv_hardif_neigh_put(neigh_node);
+
+	/* ok, may broadcast */
+	if (!ret)
+		return false;
+
+	/* no broadcast */
+	switch (ret) {
+	case BATADV_HARDIF_BCAST_NORECIPIENT:
+		type = "no neighbor";
+		break;
+	case BATADV_HARDIF_BCAST_DUPFWD:
+		type = "single neighbor is source";
+		break;
+	case BATADV_HARDIF_BCAST_DUPORIG:
+		type = "single neighbor is originator";
+		break;
+	default:
+		type = "unknown";
+	}
+
+	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+		   "BCAST packet from orig %pM on %s suppressed: %s\n",
+		   bcast_packet->orig,
+		   if_out->net_dev->name, type);
+
+	return true;
+}
+
+/**
+ * __batadv_forw_bcast_packet() - forward and queue a broadcast packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: broadcast packet to add
+ * @delay: number of jiffies to wait before sending
+ * @own_packet: true if it is a self-generated broadcast packet
+ *
+ * Transmits a broadcast packet either immediately or if a delay is given
+ * after that. Furthermore, queues additional retransmissions on wireless
+ * interfaces.
+ *
+ * This call clones the given skb, hence the caller needs to take into
+ * account that the data segment of the given skb might not be
+ * modifiable anymore.
+ *
+ * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY on errors.
+ */
+static int __batadv_forw_bcast_packet(struct batadv_priv *bat_priv,
+				      struct sk_buff *skb,
+				      unsigned long delay,
+				      bool own_packet)
+{
+	struct batadv_hard_iface *hard_iface;
+	struct batadv_hard_iface *primary_if;
+	int ret = NETDEV_TX_OK;
+
+	primary_if = batadv_primary_if_get_selected(bat_priv);
+	if (!primary_if)
+		return NETDEV_TX_BUSY;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
+		if (hard_iface->soft_iface != bat_priv->soft_iface)
+			continue;
+
+		if (!kref_get_unless_zero(&hard_iface->refcount))
+			continue;
+
+		if (batadv_send_no_broadcast(bat_priv, skb, own_packet,
+					     hard_iface)) {
+			batadv_hardif_put(hard_iface);
+			continue;
+		}
+
+		ret = batadv_forw_bcast_packet_if(bat_priv, skb, delay,
+						  own_packet, primary_if,
+						  hard_iface);
+		batadv_hardif_put(hard_iface);
+
+		if (ret == NETDEV_TX_BUSY)
+			break;
+	}
+	rcu_read_unlock();
+
+	batadv_hardif_put(primary_if);
+	return ret;
+}
+
+/**
+ * batadv_forw_bcast_packet() - forward and queue a broadcast packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: broadcast packet to add
+ * @delay: number of jiffies to wait before sending
+ * @own_packet: true if it is a self-generated broadcast packet
+ *
+ * Transmits a broadcast packet either immediately or if a delay is given
+ * after that. Furthermore, queues additional retransmissions on wireless
+ * interfaces.
+ *
+ * This call might reallocate skb data.
+ *
+ * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY on errors.
+ */
+int batadv_forw_bcast_packet(struct batadv_priv *bat_priv,
+			     struct sk_buff *skb,
+			     unsigned long delay,
+			     bool own_packet)
+{
+	int ret = __batadv_forw_bcast_packet(bat_priv, skb, delay, own_packet);
+
+	if (ret == NETDEV_TX_BUSY)
+		return ret;
+
+	/* __batadv_forw_bcast_packet clones, make sure original
+	 * skb stays writeable
+	 */
+	return (skb_cow(skb, 0) < 0) ? NETDEV_TX_BUSY : NETDEV_TX_OK;
+}
+
+/**
+ * batadv_send_bcast_packet() - send and queue a broadcast packet
+ * @bat_priv: the bat priv with all the soft interface information
+ * @skb: broadcast packet to add
+ * @delay: number of jiffies to wait before sending
+ * @own_packet: true if it is a self-generated broadcast packet
+ *
+ * Transmits a broadcast packet either immediately or if a delay is given
+ * after that. Furthermore, queues additional retransmissions on wireless
+ * interfaces.
+ *
+ * Consumes the provided skb.
+ */
+void batadv_send_bcast_packet(struct batadv_priv *bat_priv,
+			      struct sk_buff *skb,
+			      unsigned long delay,
+			      bool own_packet)
+{
+	__batadv_forw_bcast_packet(bat_priv, skb, delay, own_packet);
+	consume_skb(skb);
+}
+
 /**
  * batadv_forw_packet_bcasts_left() - check if a retransmission is necessary
  * @forw_packet: the forwarding packet to check
@@ -811,28 +1031,20 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
  * Return: True if (re)transmissions are left, false otherwise.
  */
 static bool
-batadv_forw_packet_bcasts_left(struct batadv_forw_packet *forw_packet,
-			       struct batadv_hard_iface *hard_iface)
+batadv_forw_packet_bcasts_left(struct batadv_forw_packet *forw_packet)
 {
-	unsigned int max;
-
-	if (hard_iface)
-		max = hard_iface->num_bcasts;
-	else
-		max = BATADV_NUM_BCASTS_MAX;
-
-	return BATADV_SKB_CB(forw_packet->skb)->num_bcasts < max;
+	return BATADV_SKB_CB(forw_packet->skb)->num_bcasts;
 }
 
 /**
- * batadv_forw_packet_bcasts_inc() - increment retransmission counter of a
+ * batadv_forw_packet_bcasts_dec() - decrement retransmission counter of a
  *  packet
- * @forw_packet: the packet to increase the counter for
+ * @forw_packet: the packet to decrease the counter for
  */
 static void
-batadv_forw_packet_bcasts_inc(struct batadv_forw_packet *forw_packet)
+batadv_forw_packet_bcasts_dec(struct batadv_forw_packet *forw_packet)
 {
-	BATADV_SKB_CB(forw_packet->skb)->num_bcasts++;
+	BATADV_SKB_CB(forw_packet->skb)->num_bcasts--;
 }
 
 /**
@@ -843,30 +1055,30 @@ batadv_forw_packet_bcasts_inc(struct batadv_forw_packet *forw_packet)
  */
 bool batadv_forw_packet_is_rebroadcast(struct batadv_forw_packet *forw_packet)
 {
-	return BATADV_SKB_CB(forw_packet->skb)->num_bcasts > 0;
+	unsigned char num_bcasts = BATADV_SKB_CB(forw_packet->skb)->num_bcasts;
+
+	return num_bcasts != forw_packet->if_outgoing->num_bcasts;
 }
 
+/**
+ * batadv_send_outstanding_bcast_packet() - transmit a queued broadcast packet
+ * @work: work queue item
+ *
+ * Transmits a queued broadcast packet and if necessary reschedules it.
+ */
 static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 {
-	struct batadv_hard_iface *hard_iface;
-	struct batadv_hardif_neigh_node *neigh_node;
+	unsigned long send_time = jiffies + msecs_to_jiffies(5);
+	struct batadv_forw_packet *forw_packet;
 	struct delayed_work *delayed_work;
-	struct batadv_forw_packet *forw_packet;
-	struct batadv_bcast_packet *bcast_packet;
+	struct batadv_priv *bat_priv;
 	struct sk_buff *skb1;
-	struct net_device *soft_iface;
-	struct batadv_priv *bat_priv;
-	unsigned long send_time = jiffies + msecs_to_jiffies(5);
 	bool dropped = false;
-	u8 *neigh_addr;
-	u8 *orig_neigh;
-	int ret = 0;
 
 	delayed_work = to_delayed_work(work);
 	forw_packet = container_of(delayed_work, struct batadv_forw_packet,
 				   delayed_work);
-	soft_iface = forw_packet->if_incoming->soft_iface;
-	bat_priv = netdev_priv(soft_iface);
+	bat_priv = netdev_priv(forw_packet->if_incoming->soft_iface);
 
 	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING) {
 		dropped = true;
@@ -878,76 +1090,15 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 		goto out;
 	}
 
-	bcast_packet = (struct batadv_bcast_packet *)forw_packet->skb->data;
+	/* send a copy of the saved skb */
+	skb1 = skb_clone(forw_packet->skb, GFP_ATOMIC);
+	if (!skb1)
+		goto out;
 
-	/* rebroadcast packet */
-	rcu_read_lock();
-	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
-		if (hard_iface->soft_iface != soft_iface)
-			continue;
+	batadv_send_broadcast_skb(skb1, forw_packet->if_outgoing);
+	batadv_forw_packet_bcasts_dec(forw_packet);
 
-		if (!batadv_forw_packet_bcasts_left(forw_packet, hard_iface))
-			continue;
-
-		if (forw_packet->own) {
-			neigh_node = NULL;
-		} else {
-			neigh_addr = eth_hdr(forw_packet->skb)->h_source;
-			neigh_node = batadv_hardif_neigh_get(hard_iface,
-							     neigh_addr);
-		}
-
-		orig_neigh = neigh_node ? neigh_node->orig : NULL;
-
-		ret = batadv_hardif_no_broadcast(hard_iface, bcast_packet->orig,
-						 orig_neigh);
-
-		if (ret) {
-			char *type;
-
-			switch (ret) {
-			case BATADV_HARDIF_BCAST_NORECIPIENT:
-				type = "no neighbor";
-				break;
-			case BATADV_HARDIF_BCAST_DUPFWD:
-				type = "single neighbor is source";
-				break;
-			case BATADV_HARDIF_BCAST_DUPORIG:
-				type = "single neighbor is originator";
-				break;
-			default:
-				type = "unknown";
-			}
-
-			batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "BCAST packet from orig %pM on %s suppressed: %s\n",
-				   bcast_packet->orig,
-				   hard_iface->net_dev->name, type);
-
-			if (neigh_node)
-				batadv_hardif_neigh_put(neigh_node);
-
-			continue;
-		}
-
-		if (neigh_node)
-			batadv_hardif_neigh_put(neigh_node);
-
-		if (!kref_get_unless_zero(&hard_iface->refcount))
-			continue;
-
-		/* send a copy of the saved skb */
-		skb1 = skb_clone(forw_packet->skb, GFP_ATOMIC);
-		if (skb1)
-			batadv_send_broadcast_skb(skb1, hard_iface);
-
-		batadv_hardif_put(hard_iface);
-	}
-	rcu_read_unlock();
-
-	batadv_forw_packet_bcasts_inc(forw_packet);
-
-	/* if we still have some more bcasts to send */
-	if (batadv_forw_packet_bcasts_left(forw_packet, NULL)) {
+	if (batadv_forw_packet_bcasts_left(forw_packet)) {
 		batadv_forw_packet_bcast_queue(bat_priv, forw_packet,
 					       send_time);
 		return;
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 5921ee4e..f8cfb1dd 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -40,10 +40,14 @@ int batadv_send_broadcast_skb(struct sk_buff *skb,
 			      struct batadv_hard_iface *hard_iface);
 int batadv_send_unicast_skb(struct sk_buff *skb,
 			    struct batadv_neigh_node *neigh_node);
-int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
-				    const struct sk_buff *skb,
-				    unsigned long delay,
-				    bool own_packet);
+int batadv_forw_bcast_packet(struct batadv_priv *bat_priv,
+			     struct sk_buff *skb,
+			     unsigned long delay,
+			     bool own_packet);
+void batadv_send_bcast_packet(struct batadv_priv *bat_priv,
+			      struct sk_buff *skb,
+			      unsigned long delay,
+			      bool own_packet);
 void
 batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 				 const struct batadv_hard_iface *hard_iface);
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index a7677e1d..5df29ce8 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -192,7 +192,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	struct vlan_ethhdr *vhdr;
 	unsigned int header_len = 0;
 	int data_len = skb->len, ret;
-	unsigned long brd_delay = 1;
+	unsigned long brd_delay = 0;
 	bool do_bcast = false, client_added;
 	unsigned short vid;
 	u32 seqno;
@@ -331,7 +331,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 
 		bcast_packet = (struct batadv_bcast_packet *)skb->data;
 		bcast_packet->version = BATADV_COMPAT_VERSION;
-		bcast_packet->ttl = BATADV_TTL;
+		bcast_packet->ttl = BATADV_TTL - 1;
 
 		/* batman packet type: broadcast */
 		bcast_packet->packet_type = BATADV_BCAST;
@@ -347,13 +347,7 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 		seqno = atomic_inc_return(&bat_priv->bcast_seqno);
 		bcast_packet->seqno = htonl(seqno);
 
-		batadv_add_bcast_packet_to_list(bat_priv, skb, brd_delay, true);
-
-		/* a copy is stored in the bcast list, therefore removing
-		 * the original skb.
-		 */
-		consume_skb(skb);
-
+		batadv_send_bcast_packet(bat_priv, skb, brd_delay, true);
 	/* unicast packet */
 	} else {
 		/* DHCP packets going to a server will use the GW feature */
-- 
2.20.1

