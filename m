Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 17 Apr 2013 23:54:33 +0200
Message-Id: <1366235673-13763-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1366235673-13763-1-git-send-email-linus.luessing@web.de>
References: <1366235673-13763-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Refactor forward packet
	creation/destruction
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

This patch abstracts the forward packet creation and destruction in the
functions batadv_forw_packet_alloc() and batadv_forw_packet_free().

That way there is less complexity to wrap the head around when freeing a
forward packet.

For instance broadcast/ogm queue left counting will not need
to be done with "manual" atomic_inc/dec calls anymore, which should
greatly reduce the risk of having or reintroducing another
queue-left-miscounting again.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 bat_iv_ogm.c |   32 ++++--------------
 send.c       |  103 +++++++++++++++++++++++++++++++++++++++++-----------------
 send.h       |    5 +++
 types.h      |    1 +
 4 files changed, 86 insertions(+), 55 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 42b7a94..c113627 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -427,26 +427,13 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	struct batadv_forw_packet *forw_packet_aggr;
 	unsigned char *skb_buff;
 	unsigned int skb_size;
+	atomic_t *queue_left = own_packet ? NULL : &bat_priv->batman_queue_left;
 
-	if (!atomic_inc_not_zero(&if_incoming->refcount))
+	forw_packet_aggr = batadv_forw_packet_alloc(if_incoming, queue_left,
+						    bat_priv);
+	if (!forw_packet_aggr)
 		return;
 
-	/* own packet should always be scheduled */
-	if (!own_packet) {
-		if (!batadv_atomic_dec_not_zero(&bat_priv->batman_queue_left)) {
-			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-				   "batman packet queue full\n");
-			goto out;
-		}
-	}
-
-	forw_packet_aggr = kmalloc(sizeof(*forw_packet_aggr), GFP_ATOMIC);
-	if (!forw_packet_aggr) {
-		if (!own_packet)
-			atomic_inc(&bat_priv->batman_queue_left);
-		goto out;
-	}
-
 	if ((atomic_read(&bat_priv->aggregated_ogms)) &&
 	    (packet_len < BATADV_MAX_AGGREGATION_BYTES))
 		skb_size = BATADV_MAX_AGGREGATION_BYTES;
@@ -457,10 +444,8 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 
 	forw_packet_aggr->skb = dev_alloc_skb(skb_size);
 	if (!forw_packet_aggr->skb) {
-		if (!own_packet)
-			atomic_inc(&bat_priv->batman_queue_left);
-		kfree(forw_packet_aggr);
-		goto out;
+		batadv_forw_packet_free(forw_packet_aggr);
+		return;
 	}
 	skb_reserve(forw_packet_aggr->skb, ETH_HLEN + NET_IP_ALIGN);
 
@@ -471,7 +456,6 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	memcpy(skb_buff, packet_buff, packet_len);
 
 	forw_packet_aggr->own = own_packet;
-	forw_packet_aggr->if_incoming = if_incoming;
 	forw_packet_aggr->num_packets = 0;
 	forw_packet_aggr->direct_link_flags = BATADV_NO_FLAGS;
 	forw_packet_aggr->send_time = send_time;
@@ -491,10 +475,6 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	queue_delayed_work(batadv_event_workqueue,
 			   &forw_packet_aggr->delayed_work,
 			   send_time - jiffies);
-
-	return;
-out:
-	batadv_hardif_free_ref(if_incoming);
 }
 
 /* aggregate a new packet into the existing ogm packet */
diff --git a/send.c b/send.c
index 2d539d6..36a1c4c 100644
--- a/send.c
+++ b/send.c
@@ -138,12 +138,77 @@ void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface)
 	bat_priv->bat_algo_ops->bat_ogm_schedule(hard_iface);
 }
 
-static void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
+/**
+ * batadv_forw_packet_alloc - Allocates a forwarding packet
+ * @if_incoming: The (optional) if_incoming to be grabbed
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
+			 atomic_t *queue_left,
+			 struct batadv_priv *bat_priv)
+{
+	struct batadv_forw_packet *forw_packet = NULL;
+
+	if (if_incoming && !atomic_inc_not_zero(&if_incoming->refcount))
+		goto out;
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
+		goto err;
+	}
+
+	forw_packet = kmalloc(sizeof(struct batadv_forw_packet), GFP_ATOMIC);
+	if (!forw_packet)
+		goto err2;
+
+	forw_packet->skb = NULL;
+	forw_packet->if_incoming = if_incoming;
+	forw_packet->queue_left = queue_left;
+
+	goto out;
+
+err2:
+	if (queue_left)
+		atomic_inc(queue_left);
+err:
+	if (if_incoming)
+		batadv_hardif_free_ref(if_incoming);
+out:
+	return forw_packet;
+}
+
+/**
+ * batadv_forw_packet_free - Frees a forwarding packet
+ * @forw_packet: The packet to free
+ *
+ * This frees a forwarding packet and releases any ressources it might
+ * have claimed.
+ */
+void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
 {
 	if (forw_packet->skb)
 		kfree_skb(forw_packet->skb);
 	if (forw_packet->if_incoming)
 		batadv_hardif_free_ref(forw_packet->if_incoming);
+	if (forw_packet->queue_left)
+		atomic_inc(forw_packet->queue_left);
 	kfree(forw_packet);
 }
 
@@ -177,25 +242,21 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				    const struct sk_buff *skb,
 				    unsigned long delay)
 {
-	struct batadv_hard_iface *primary_if = NULL;
+	struct batadv_hard_iface *primary_if;
 	struct batadv_forw_packet *forw_packet;
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
 
+	forw_packet = batadv_forw_packet_alloc(primary_if,
+					       &bat_priv->bcast_queue_left,
+					       bat_priv);
+	batadv_hardif_free_ref(primary_if);
 	if (!forw_packet)
-		goto out_and_inc;
+		goto out;
 
 	newskb = skb_copy(skb, GFP_ATOMIC);
 	if (!newskb)
@@ -208,7 +269,6 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	skb_reset_mac_header(newskb);
 
 	forw_packet->skb = newskb;
-	forw_packet->if_incoming = primary_if;
 
 	/* how often did we send the bcast packet ? */
 	forw_packet->num_packets = 0;
@@ -220,12 +280,8 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	return NETDEV_TX_OK;
 
 packet_free:
-	kfree(forw_packet);
-out_and_inc:
-	atomic_inc(&bat_priv->bcast_queue_left);
+	batadv_forw_packet_free(forw_packet);
 out:
-	if (primary_if)
-		batadv_hardif_free_ref(primary_if);
 	return NETDEV_TX_BUSY;
 }
 
@@ -282,7 +338,6 @@ static void batadv_send_outstanding_bcast_packet(struct work_struct *work)
 
 out:
 	batadv_forw_packet_free(forw_packet);
-	atomic_inc(&bat_priv->bcast_queue_left);
 }
 
 void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work)
@@ -312,10 +367,6 @@ void batadv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 		batadv_schedule_bat_ogm(forw_packet->if_incoming);
 
 out:
-	/* don't count own packet */
-	if (!forw_packet->own)
-		atomic_inc(&bat_priv->batman_queue_left);
-
 	batadv_forw_packet_free(forw_packet);
 }
 
@@ -356,9 +407,6 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
 		if (pending) {
 			hlist_del(&forw_packet->list);
-			if (!forw_packet->own)
-				atomic_inc(&bat_priv->bcast_queue_left);
-
 			batadv_forw_packet_free(forw_packet);
 		}
 	}
@@ -385,9 +433,6 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
 		if (pending) {
 			hlist_del(&forw_packet->list);
-			if (!forw_packet->own)
-				atomic_inc(&bat_priv->batman_queue_left);
-
 			batadv_forw_packet_free(forw_packet);
 		}
 	}
diff --git a/send.h b/send.h
index 38e662f..7004486 100644
--- a/send.h
+++ b/send.h
@@ -27,6 +27,11 @@ bool batadv_send_skb_to_orig(struct sk_buff *skb,
 			     struct batadv_orig_node *orig_node,
 			     struct batadv_hard_iface *recv_if);
 void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface);
+struct batadv_forw_packet *batadv_forw_packet_alloc(
+					struct batadv_hard_iface *if_incoming,
+					atomic_t *queue_left,
+					struct batadv_priv *bat_priv);
+void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet);
 int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				    const struct sk_buff *skb,
 				    unsigned long delay);
diff --git a/types.h b/types.h
index 5f542bd..8c28142 100644
--- a/types.h
+++ b/types.h
@@ -863,6 +863,7 @@ struct batadv_forw_packet {
 	uint8_t num_packets;
 	struct delayed_work delayed_work;
 	struct batadv_hard_iface *if_incoming;
+	atomic_t *queue_left;
 };
 
 /**
-- 
1.7.10.4

