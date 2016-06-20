Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 20 Jun 2016 21:39:54 +0200
Message-Id: <1466451595-6347-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4] batman-adv: Introduce forward packet
	creation helper
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

This patch abstracts the forward packet creation into the new function
batadv_forw_packet_alloc().

The queue counting and interface reference counters are now handled
internally within batadv_forw_packet_alloc() and its
batadv_forw_packet_free() counterpart. This should reduce the risk of
having reference/queue counting bugs again and should increase
code readibility.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
Changelog v4:
* Removed goto in batadv_iv_ogm_aggregate_new()
* Removed two goto's in batadv_forw_packet_alloc()
* Easier to read debug output code in batadv_forw_packet_alloc()
* Renamed "out" and "packet_free" jump labels in batadv_add_bcast_packet_to_list()
  to "err" and "err_packet_free"

Changelog v3:
* Fixed kernel doc for batadv_forw_packet_alloc()
* New title / some more adjustments to commit message

Changelog v2:
* Rebase to current master
* Fixed typo: "ressources" vs. "resources"
* Moved forw_packet->num_packets initialization into forw_packet_alloc(), too
* Adjusted commit message

 net/batman-adv/bat_iv_ogm.c |  38 ++++-----------
 net/batman-adv/send.c       | 111 ++++++++++++++++++++++++++++++++------------
 net/batman-adv/send.h       |   6 +++
 net/batman-adv/types.h      |   2 +
 4 files changed, 98 insertions(+), 59 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 6af4462..d3c8c57 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -674,19 +674,12 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	struct batadv_forw_packet *forw_packet_aggr;
 	unsigned char *skb_buff;
 	unsigned int skb_size;
+	atomic_t *queue_left = own_packet ? NULL : &bat_priv->batman_queue_left;
 
-	/* own packet should always be scheduled */
-	if (!own_packet) {
-		if (!batadv_atomic_dec_not_zero(&bat_priv->batman_queue_left)) {
-			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-				   "batman packet queue full\n");
-			return;
-		}
-	}
-
-	forw_packet_aggr = kmalloc(sizeof(*forw_packet_aggr), GFP_ATOMIC);
+	forw_packet_aggr = batadv_forw_packet_alloc(if_incoming, if_outgoing,
+						    queue_left, bat_priv);
 	if (!forw_packet_aggr)
-		goto out_nomem;
+		return;
 
 	if (atomic_read(&bat_priv->aggregated_ogms) &&
 	    packet_len < BATADV_MAX_AGGREGATION_BYTES)
@@ -697,8 +690,11 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	skb_size += ETH_HLEN;
 
 	forw_packet_aggr->skb = netdev_alloc_skb_ip_align(NULL, skb_size);
-	if (!forw_packet_aggr->skb)
-		goto out_free_forw_packet;
+	if (!forw_packet_aggr->skb) {
+		batadv_forw_packet_free(forw_packet_aggr);
+		return;
+	}
+
 	forw_packet_aggr->skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(forw_packet_aggr->skb, ETH_HLEN);
 
@@ -706,12 +702,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	forw_packet_aggr->packet_len = packet_len;
 	memcpy(skb_buff, packet_buff, packet_len);
 
-	kref_get(&if_incoming->refcount);
-	kref_get(&if_outgoing->refcount);
 	forw_packet_aggr->own = own_packet;
-	forw_packet_aggr->if_incoming = if_incoming;
-	forw_packet_aggr->if_outgoing = if_outgoing;
-	forw_packet_aggr->num_packets = 0;
 	forw_packet_aggr->direct_link_flags = BATADV_NO_FLAGS;
 	forw_packet_aggr->send_time = send_time;
 
@@ -730,13 +721,6 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	queue_delayed_work(batadv_event_workqueue,
 			   &forw_packet_aggr->delayed_work,
 			   send_time - jiffies);
-
-	return;
-out_free_forw_packet:
-	kfree(forw_packet_aggr);
-out_nomem:
-	if (!own_packet)
-		atomic_inc(&bat_priv->batman_queue_left);
 }
 
 /* aggregate a new packet into the existing ogm packet */
@@ -1819,10 +1803,6 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 		batadv_iv_ogm_schedule(forw_packet->if_incoming);
 
 out:
-	/* don't count own packet */
-	if (!forw_packet->own)
-		atomic_inc(&bat_priv->batman_queue_left);
-
 	batadv_forw_packet_free(forw_packet);
 }
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 49836da..89c0ce3 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -430,6 +430,13 @@ int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
 				       orig_node, vid);
 }
 
+/**
+ * batadv_forw_packet_free - free a forwarding packet
+ * @forw_packet: The packet to free
+ *
+ * This frees a forwarding packet and releases any resources it might
+ * have claimed.
+ */
 void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
 {
 	kfree_skb(forw_packet->skb);
@@ -437,9 +444,73 @@ void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
 		batadv_hardif_put(forw_packet->if_incoming);
 	if (forw_packet->if_outgoing)
 		batadv_hardif_put(forw_packet->if_outgoing);
+	if (forw_packet->queue_left)
+		atomic_inc(forw_packet->queue_left);
 	kfree(forw_packet);
 }
 
+/**
+ * batadv_forw_packet_alloc - Allocate a forwarding packet
+ * @if_incoming: The (optional) if_incoming to be grabbed
+ * @if_outgoing: The (optional) if_outgoing to be grabbed
+ * @queue_left: The (optional) queue counter to decrease
+ * @bat_priv: The bat_priv for the mesh of this forw_packet
+ *
+ * Allocates a forwarding packet and tries to get a reference to the
+ * (optional) if_incoming, if_outgoing and queue_left. If queue_left
+ * is NULL then bat_priv is optional, too.
+ *
+ * Return: An allocated forwarding packet on success, NULL otherwise.
+ */
+struct batadv_forw_packet *
+batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
+			 struct batadv_hard_iface *if_outgoing,
+			 atomic_t *queue_left,
+			 struct batadv_priv *bat_priv)
+{
+	struct batadv_forw_packet *forw_packet;
+	const char *qname;
+
+	if (queue_left && !batadv_atomic_dec_not_zero(queue_left)) {
+		qname = "unknown";
+
+		if (queue_left == &bat_priv->bcast_queue_left)
+			qname = "bcast";
+
+		if (queue_left == &bat_priv->batman_queue_left)
+			qname = "batman";
+
+		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+			   "%s queue is full\n", qname);
+
+		return NULL;
+	}
+
+	forw_packet = kmalloc(sizeof(*forw_packet), GFP_ATOMIC);
+	if (!forw_packet)
+		goto err;
+
+	if (if_incoming)
+		kref_get(&if_incoming->refcount);
+
+	if (if_outgoing)
+		kref_get(&if_outgoing->refcount);
+
+	forw_packet->skb = NULL;
+	forw_packet->queue_left = queue_left;
+	forw_packet->if_incoming = if_incoming;
+	forw_packet->if_outgoing = if_outgoing;
+	forw_packet->num_packets = 0;
+
+	return forw_packet;
+
+err:
+	if (queue_left)
+		atomic_inc(queue_left);
+
+	return NULL;
+}
+
 static void
 _batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				 struct batadv_forw_packet *forw_packet,
@@ -478,24 +549,20 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	struct batadv_bcast_packet *bcast_packet;
 	struct sk_buff *newskb;
 
-	if (!batadv_atomic_dec_not_zero(&bat_priv->bcast_queue_left)) {
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "bcast packet queue full\n");
-		goto out;
-	}
-
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
-		goto out_and_inc;
-
-	forw_packet = kmalloc(sizeof(*forw_packet), GFP_ATOMIC);
+		goto err;
 
+	forw_packet = batadv_forw_packet_alloc(primary_if, NULL,
+					       &bat_priv->bcast_queue_left,
+					       bat_priv);
+	batadv_hardif_put(primary_if);
 	if (!forw_packet)
-		goto out_and_inc;
+		goto err;
 
 	newskb = skb_copy(skb, GFP_ATOMIC);
 	if (!newskb)
-		goto packet_free;
+		goto err_packet_free;
 
 	/* as we have a copy now, it is safe to decrease the TTL */
 	bcast_packet = (struct batadv_bcast_packet *)newskb->data;
@@ -504,11 +571,6 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	skb_reset_mac_header(newskb);
 
 	forw_packet->skb = newskb;
-	forw_packet->if_incoming = primary_if;
-	forw_packet->if_outgoing = NULL;
-
-	/* how often did we send the bcast packet ? */
-	forw_packet->num_packets = 0;
 
 	INIT_DELAYED_WORK(&forw_packet->delayed_work,
 			  batadv_send_outstanding_bcast_packet);
@@ -516,13 +578,9 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	_batadv_add_bcast_packet_to_list(bat_priv, forw_packet, delay);
 	return NETDEV_TX_OK;
 
-packet_free:
-	kfree(forw_packet);
-out_and_inc:
-	atomic_inc(&bat_priv->bcast_queue_left);
-out:
-	if (primary_if)
-		batadv_hardif_put(primary_if);
+err_packet_free:
+	batadv_forw_packet_free(forw_packet);
+err:
 	return NETDEV_TX_BUSY;
 }
 
@@ -583,7 +641,6 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 
 out:
 	batadv_forw_packet_free(forw_packet);
-	atomic_inc(&bat_priv->bcast_queue_left);
 }
 
 void
@@ -624,9 +681,6 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
 		if (pending) {
 			hlist_del(&forw_packet->list);
-			if (!forw_packet->own)
-				atomic_inc(&bat_priv->bcast_queue_left);
-
 			batadv_forw_packet_free(forw_packet);
 		}
 	}
@@ -654,9 +708,6 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
 		if (pending) {
 			hlist_del(&forw_packet->list);
-			if (!forw_packet->own)
-				atomic_inc(&bat_priv->batman_queue_left);
-
 			batadv_forw_packet_free(forw_packet);
 		}
 	}
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 7cecb75..999f786 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -28,6 +28,12 @@
 struct sk_buff;
 
 void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet);
+struct batadv_forw_packet *
+batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
+			 struct batadv_hard_iface *if_outgoing,
+			 atomic_t *queue_left,
+			 struct batadv_priv *bat_priv);
+
 int batadv_send_skb_to_orig(struct sk_buff *skb,
 			    struct batadv_orig_node *orig_node,
 			    struct batadv_hard_iface *recv_if);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fb445c5..89ea104 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1371,6 +1371,7 @@ struct batadv_skb_cb {
  *  locally generated packet
  * @if_outgoing: packet where the packet should be sent to, or NULL if
  *  unspecified
+ * @queue_left: The queue (counter) this packet was applied to
  */
 struct batadv_forw_packet {
 	struct hlist_node list;
@@ -1383,6 +1384,7 @@ struct batadv_forw_packet {
 	struct delayed_work delayed_work;
 	struct batadv_hard_iface *if_incoming;
 	struct batadv_hard_iface *if_outgoing;
+	atomic_t *queue_left;
 };
 
 /**
-- 
2.1.4

