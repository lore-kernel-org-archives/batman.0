Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 24 May 2016 00:14:22 +0200
Message-Id: <1464041662-639-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Refactor forward packet
	creation/destruction
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

This patch abstracts the forward packet creation and destruction via
the new functions batadv_forw_packet_alloc() and batadv_forw_packet_free().

This should simplify the freeing of a forward packet as for instance queue
counting is now done internally.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
Changelog v2:
* Rebase to current master
* Fixed typo: "ressources" vs. "resources"
* Moved forw_packet->num_packets initialization into forw_packet_alloc(), too
* Adjusted commit message

Zombie patch - rotten & dead since 2013, but w{al,or}ks again!

 net/batman-adv/bat_iv_ogm.c |   34 ++++----------
 net/batman-adv/send.c       |  103 +++++++++++++++++++++++++++++++------------
 net/batman-adv/send.h       |    6 +++
 net/batman-adv/types.h      |    2 +
 4 files changed, 92 insertions(+), 53 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index e2d8848..5a7923c 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -685,19 +685,12 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
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
@@ -709,7 +702,8 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 
 	forw_packet_aggr->skb = netdev_alloc_skb_ip_align(NULL, skb_size);
 	if (!forw_packet_aggr->skb)
-		goto out_free_forw_packet;
+		goto packet_free;
+
 	forw_packet_aggr->skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(forw_packet_aggr->skb, ETH_HLEN);
 
@@ -717,12 +711,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
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
 
@@ -743,11 +732,8 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 			   send_time - jiffies);
 
 	return;
-out_free_forw_packet:
-	kfree(forw_packet_aggr);
-out_nomem:
-	if (!own_packet)
-		atomic_inc(&bat_priv->batman_queue_left);
+packet_free:
+	batadv_forw_packet_free(forw_packet_aggr);
 }
 
 /* aggregate a new packet into the existing ogm packet */
@@ -1830,10 +1816,6 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 		batadv_iv_ogm_schedule(forw_packet->if_incoming);
 
 out:
-	/* don't count own packet */
-	if (!forw_packet->own)
-		atomic_inc(&bat_priv->batman_queue_left);
-
 	batadv_forw_packet_free(forw_packet);
 }
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 49836da..711f8a8 100644
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
@@ -437,9 +444,71 @@ void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
 		batadv_hardif_put(forw_packet->if_incoming);
 	if (forw_packet->if_outgoing)
 		batadv_hardif_put(forw_packet->if_outgoing);
+	if (forw_packet->queue_left)
+		atomic_inc(forw_packet->queue_left);
 	kfree(forw_packet);
 }
 
+/**
+ * batadv_forw_packet_alloc - Allocates a forwarding packet
+ * @if_incoming: The (optional) if_incoming to be grabbed
+ * @if_outgoing: The (optional) if_outgoing to be grabbed
+ * @queue_left: The (optional) queue counter to decrease
+ * @bat_priv: The bat_priv for the mesh of this forw_packet
+ *
+ * Allocates a forwarding packet and tries to get a reference to the
+ * (optional) if_incoming and queue_left. If queue_left is NULL then
+ * bat_priv is optional, too.
+ *
+ * On success, returns the allocated forwarding packet. Otherwise returns
+ * NULL.
+ */
+struct batadv_forw_packet *
+batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
+			 struct batadv_hard_iface *if_outgoing,
+			 atomic_t *queue_left,
+			 struct batadv_priv *bat_priv)
+{
+	struct batadv_forw_packet *forw_packet = NULL;
+
+	if (queue_left && !batadv_atomic_dec_not_zero(queue_left)) {
+		if (queue_left == &bat_priv->bcast_queue_left)
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "bcast queue full\n");
+		else if (queue_left == &bat_priv->batman_queue_left)
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "batman queue full\n");
+		else
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "a mysterious queue is full\n");
+		goto out;
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
+	goto out;
+
+err:
+	if (queue_left)
+		atomic_inc(queue_left);
+out:
+	return forw_packet;
+}
+
 static void
 _batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				 struct batadv_forw_packet *forw_packet,
@@ -478,20 +547,16 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
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
+		goto out;
 
+	forw_packet = batadv_forw_packet_alloc(primary_if, NULL,
+					       &bat_priv->bcast_queue_left,
+					       bat_priv);
+	batadv_hardif_put(primary_if);
 	if (!forw_packet)
-		goto out_and_inc;
+		goto out;
 
 	newskb = skb_copy(skb, GFP_ATOMIC);
 	if (!newskb)
@@ -504,11 +569,6 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	skb_reset_mac_header(newskb);
 
 	forw_packet->skb = newskb;
-	forw_packet->if_incoming = primary_if;
-	forw_packet->if_outgoing = NULL;
-
-	/* how often did we send the bcast packet ? */
-	forw_packet->num_packets = 0;
 
 	INIT_DELAYED_WORK(&forw_packet->delayed_work,
 			  batadv_send_outstanding_bcast_packet);
@@ -517,12 +577,8 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	return NETDEV_TX_OK;
 
 packet_free:
-	kfree(forw_packet);
-out_and_inc:
-	atomic_inc(&bat_priv->bcast_queue_left);
+	batadv_forw_packet_free(forw_packet);
 out:
-	if (primary_if)
-		batadv_hardif_put(primary_if);
 	return NETDEV_TX_BUSY;
 }
 
@@ -583,7 +639,6 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 
 out:
 	batadv_forw_packet_free(forw_packet);
-	atomic_inc(&bat_priv->bcast_queue_left);
 }
 
 void
@@ -624,9 +679,6 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
 		if (pending) {
 			hlist_del(&forw_packet->list);
-			if (!forw_packet->own)
-				atomic_inc(&bat_priv->bcast_queue_left);
-
 			batadv_forw_packet_free(forw_packet);
 		}
 	}
@@ -654,9 +706,6 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
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
index a331e3a..b1b82a2 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1373,6 +1373,7 @@ struct batadv_skb_cb {
  *  locally generated packet
  * @if_outgoing: packet where the packet should be sent to, or NULL if
  *  unspecified
+ * @queue_left: The queue (counter) this packet was applied to
  */
 struct batadv_forw_packet {
 	struct hlist_node list;
@@ -1385,6 +1386,7 @@ struct batadv_forw_packet {
 	struct delayed_work delayed_work;
 	struct batadv_hard_iface *if_incoming;
 	struct batadv_hard_iface *if_outgoing;
+	atomic_t *queue_left;
 };
 
 /**
-- 
1.7.10.4

