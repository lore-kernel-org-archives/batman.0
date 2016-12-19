Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 19 Dec 2016 12:25:33 +0100
Message-Id: <20161219112535.9446-5-linus.luessing@c0d3.blue>
In-Reply-To: <20161219112535.9446-1-linus.luessing@c0d3.blue>
References: <20161219112535.9446-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC PATCH 4/6] batman-adv: privatize forw_packet
	skb assignment
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

An skb is assigned to a forw_packet only once, shortly after the
forw_packet allocation.

With this patch the assignment is moved into the this allocation
function.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/bat_iv_ogm.c | 17 +++++++++--------
 net/batman-adv/send.c       | 21 ++++++++++++---------
 net/batman-adv/send.h       |  3 ++-
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 1b1c932..86a874d 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -679,15 +679,11 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_forw_packet *forw_packet_aggr;
+	struct sk_buff *skb;
 	unsigned char *skb_buff;
 	unsigned int skb_size;
 	atomic_t *queue_left = own_packet ? NULL : &bat_priv->batman_queue_left;
 
-	forw_packet_aggr = batadv_forw_packet_alloc(if_incoming, if_outgoing,
-						    queue_left, bat_priv);
-	if (!forw_packet_aggr)
-		return;
-
 	if (atomic_read(&bat_priv->aggregation) &&
 	    packet_len < BATADV_MAX_AGGREGATION_BYTES)
 		skb_size = BATADV_MAX_AGGREGATION_BYTES;
@@ -696,9 +692,14 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 
 	skb_size += ETH_HLEN;
 
-	forw_packet_aggr->skb = netdev_alloc_skb_ip_align(NULL, skb_size);
-	if (!forw_packet_aggr->skb) {
-		batadv_forw_packet_free(forw_packet_aggr, true);
+	skb = netdev_alloc_skb_ip_align(NULL, skb_size);
+	if (!skb)
+		return;
+
+	forw_packet_aggr = batadv_forw_packet_alloc(if_incoming, if_outgoing,
+						    queue_left, bat_priv, skb);
+	if (!forw_packet_aggr) {
+		kfree_skb(skb);
 		return;
 	}
 
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 731b807..b58f8a9 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -489,6 +489,7 @@ void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet,
  * @if_outgoing: The (optional) if_outgoing to be grabbed
  * @queue_left: The (optional) queue counter to decrease
  * @bat_priv: The bat_priv for the mesh of this forw_packet
+ * @skb: The raw packet this forwarding packet shall contain
  *
  * Allocates a forwarding packet and tries to get a reference to the
  * (optional) if_incoming, if_outgoing and queue_left. If queue_left
@@ -500,7 +501,8 @@ struct batadv_forw_packet *
 batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 			 struct batadv_hard_iface *if_outgoing,
 			 atomic_t *queue_left,
-			 struct batadv_priv *bat_priv)
+			 struct batadv_priv *bat_priv,
+			 struct sk_buff *skb)
 {
 	struct batadv_forw_packet *forw_packet;
 	const char *qname;
@@ -532,7 +534,7 @@ batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 
 	INIT_HLIST_NODE(&forw_packet->list);
 	INIT_HLIST_NODE(&forw_packet->cleanup_list);
-	forw_packet->skb = NULL;
+	forw_packet->skb = skb;
 	forw_packet->queue_left = queue_left;
 	forw_packet->if_incoming = if_incoming;
 	forw_packet->if_outgoing = if_outgoing;
@@ -763,22 +765,23 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	if (!primary_if)
 		goto err;
 
+	newskb = skb_copy(skb, GFP_ATOMIC);
+	if (!newskb) {
+		batadv_hardif_put(primary_if);
+		goto err;
+	}
+
 	forw_packet = batadv_forw_packet_alloc(primary_if, NULL,
 					       &bat_priv->bcast_queue_left,
-					       bat_priv);
+					       bat_priv, newskb);
 	batadv_hardif_put(primary_if);
 	if (!forw_packet)
-		goto err;
-
-	newskb = skb_copy(skb, GFP_ATOMIC);
-	if (!newskb)
 		goto err_packet_free;
 
 	/* as we have a copy now, it is safe to decrease the TTL */
 	bcast_packet = (struct batadv_bcast_packet *)newskb->data;
 	bcast_packet->ttl--;
 
-	forw_packet->skb = newskb;
 	forw_packet->own = own_packet;
 
 	INIT_DELAYED_WORK(&forw_packet->delayed_work,
@@ -788,7 +791,7 @@ int batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 	return NETDEV_TX_OK;
 
 err_packet_free:
-	batadv_forw_packet_free(forw_packet, true);
+	kfree_skb(newskb);
 err:
 	return NETDEV_TX_BUSY;
 }
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index a94e1e8..4506312 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -34,7 +34,8 @@ struct batadv_forw_packet *
 batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 			 struct batadv_hard_iface *if_outgoing,
 			 atomic_t *queue_left,
-			 struct batadv_priv *bat_priv);
+			 struct batadv_priv *bat_priv,
+			 struct sk_buff *skb);
 bool batadv_forw_packet_steal(struct batadv_forw_packet *packet, spinlock_t *l);
 void batadv_forw_packet_ogmv1_queue(struct batadv_priv *bat_priv,
 				    struct batadv_forw_packet *forw_packet,
-- 
2.1.4

