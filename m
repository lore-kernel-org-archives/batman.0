Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Tue, 15 Feb 2011 18:12:18 +0100
Message-Id: <1297789948-16948-4-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
References: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 03/13] batman-adv: Unify TTL handling
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

All our packets have a TTL and with the last batman header patch also at
the same place in a batman encapsulated packet. We can therefore savely
do one single TTL check before sending any batman packet type.

This commit also modifies the TTL handling to be more consistent with
how it is done in other network protocols (like IPv6): The TTL is always
decreased before transmitting a packet and not on receiption for one
thing. And packets with a TTL of zero will never be be sent out
on a network interface for another.
Compare with: RFC1812; RFC2460,4.4; RFC3443,2.3

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 aggregation.c    |    2 +-
 hard-interface.c |    2 +-
 routing.c        |   92 ---------------------------------------
 send.c           |  125 +++++++++++++++++++++++++++++++++++++++++++++++-------
 unicast.c        |    3 -
 vis.c            |    6 ---
 6 files changed, 111 insertions(+), 119 deletions(-)

diff --git a/batman-adv/aggregation.c b/batman-adv/aggregation.c
index ad3c91b..550317e 100644
--- a/batman-adv/aggregation.c
+++ b/batman-adv/aggregation.c
@@ -69,7 +69,7 @@ static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 		 * are flooded through the net  */
 		if ((!directlink) &&
 		    (!(batman_packet->flags & DIRECTLINK)) &&
-		    (batman_packet->header.ttl != 1) &&
+		    (batman_packet->header.ttl != 2) &&
 
 		    /* own packets originating non-primary
 		     * interfaces leave only that interface */
diff --git a/batman-adv/hard-interface.c b/batman-adv/hard-interface.c
index 8d523cc..52d32f2 100644
--- a/batman-adv/hard-interface.c
+++ b/batman-adv/hard-interface.c
@@ -314,7 +314,7 @@ int hardif_enable_interface(struct batman_if *batman_if, char *iface_name)
 	batman_packet = (struct batman_packet *)(batman_if->packet_buff);
 	batman_packet->header.packet_type = BAT_PACKET;
 	batman_packet->header.version = COMPAT_VERSION;
-	batman_packet->header.ttl = 2;
+	batman_packet->header.ttl = 3;
 	batman_packet->flags = 0;
 	batman_packet->tq = TQ_MAX_VALUE;
 	batman_packet->num_hna = 0;
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 89e765f..293bb32 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -943,75 +943,6 @@ out:
 	return ret;
 }
 
-static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
-				  struct sk_buff *skb)
-{
-	struct orig_node *orig_node = NULL;
-	struct neigh_node *neigh_node = NULL;
-	struct icmp_packet *icmp_packet;
-	int ret = NET_RX_DROP;
-
-	icmp_packet = (struct icmp_packet *)skb->data;
-
-	/* send TTL exceeded if packet is an echo request (traceroute) */
-	if (icmp_packet->msg_type != ECHO_REQUEST) {
-		pr_debug("Warning - can't forward icmp packet from %pM to "
-			 "%pM: ttl exceeded\n", icmp_packet->orig,
-			 icmp_packet->dst);
-		goto out;
-	}
-
-	if (!bat_priv->primary_if)
-		goto out;
-
-	/* get routing information */
-	rcu_read_lock();
-	orig_node = ((struct orig_node *)
-		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
-			       icmp_packet->orig));
-	if (!orig_node)
-		goto unlock;
-
-	kref_get(&orig_node->refcount);
-	neigh_node = orig_node->router;
-
-	if (!neigh_node)
-		goto unlock;
-
-	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
-		neigh_node = NULL;
-		goto unlock;
-	}
-
-	rcu_read_unlock();
-
-	/* create a copy of the skb, if needed, to modify it. */
-	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
-		goto out;
-
-	icmp_packet = (struct icmp_packet *)skb->data;
-
-	memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
-	memcpy(icmp_packet->orig,
-		bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
-	icmp_packet->msg_type = TTL_EXCEEDED;
-	icmp_packet->header.ttl = TTL;
-
-	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
-	ret = NET_RX_SUCCESS;
-	goto out;
-
-unlock:
-	rcu_read_unlock();
-out:
-	if (neigh_node)
-		neigh_node_free_ref(neigh_node);
-	if (orig_node)
-		kref_put(&orig_node->refcount, orig_node_free_ref);
-	return ret;
-}
-
-
 int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 {
 	struct bat_priv *bat_priv = netdev_priv(recv_if->soft_iface);
@@ -1060,10 +991,6 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (is_my_mac(icmp_packet->dst))
 		return recv_my_icmp_packet(bat_priv, skb, hdr_size);
 
-	/* TTL exceeded */
-	if (icmp_packet->header.ttl < 2)
-		return recv_icmp_ttl_exceeded(bat_priv, skb);
-
 	/* get routing information */
 	rcu_read_lock();
 	orig_node = ((struct orig_node *)
@@ -1091,9 +1018,6 @@ int recv_icmp_packet(struct sk_buff *skb, struct batman_if *recv_if)
 
 	icmp_packet = (struct icmp_packet_rr *)skb->data;
 
-	/* decrement ttl */
-	icmp_packet->header.ttl--;
-
 	/* route it */
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = NET_RX_SUCCESS;
@@ -1286,20 +1210,11 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	struct orig_node *orig_node = NULL;
 	struct neigh_node *neigh_node = NULL;
 	struct unicast_packet *unicast_packet;
-	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
 	int ret = NET_RX_DROP;
 	struct sk_buff *new_skb;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
 
-	/* TTL exceeded */
-	if (unicast_packet->header.ttl < 2) {
-		pr_debug("Warning - can't forward unicast packet from %pM to "
-			 "%pM: ttl exceeded\n", ethhdr->h_source,
-			 unicast_packet->dest);
-		goto out;
-	}
-
 	/* get routing information */
 	rcu_read_lock();
 	orig_node = ((struct orig_node *)
@@ -1347,12 +1262,8 @@ int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 		}
 
 		skb = new_skb;
-		unicast_packet = (struct unicast_packet *)skb->data;
 	}
 
-	/* decrement ttl */
-	unicast_packet->header.ttl--;
-
 	/* route it */
 	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
 	ret = NET_RX_SUCCESS;
@@ -1455,9 +1366,6 @@ int recv_bcast_packet(struct sk_buff *skb, struct batman_if *recv_if)
 	if (is_my_mac(bcast_packet->orig))
 		goto out;
 
-	if (bcast_packet->header.ttl < 2)
-		goto out;
-
 	rcu_read_lock();
 	orig_node = ((struct orig_node *)
 		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
diff --git a/batman-adv/send.c b/batman-adv/send.c
index b6a9a3b..f3e8895 100644
--- a/batman-adv/send.c
+++ b/batman-adv/send.c
@@ -22,6 +22,7 @@
 #include "main.h"
 #include "send.h"
 #include "routing.h"
+#include "hash.h"
 #include "translation-table.h"
 #include "soft-interface.h"
 #include "hard-interface.h"
@@ -53,13 +54,107 @@ static unsigned long forward_send_time(void)
 	return jiffies + msecs_to_jiffies(random32() % (JITTER/2));
 }
 
+static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
+				  struct sk_buff *skb)
+{
+	struct orig_node *orig_node = NULL;
+	struct neigh_node *neigh_node = NULL;
+	struct icmp_packet *icmp_packet;
+	int ret = NET_RX_DROP;
+
+	icmp_packet = (struct icmp_packet *)skb->data;
+
+	/* send TTL exceeded if packet is an echo request (traceroute) */
+	if (icmp_packet->msg_type != ECHO_REQUEST) {
+		pr_debug("Warning - can't forward icmp packet from %pM to "
+			 "%pM: ttl exceeded\n", icmp_packet->orig,
+			 icmp_packet->dst);
+		goto out;
+	}
+
+	if (!bat_priv->primary_if)
+		goto out;
+
+	/* get routing information */
+	rcu_read_lock();
+	orig_node = ((struct orig_node *)
+		     hash_find(bat_priv->orig_hash, compare_orig, choose_orig,
+			       icmp_packet->orig));
+	if (!orig_node)
+		goto unlock;
+
+	kref_get(&orig_node->refcount);
+	neigh_node = orig_node->router;
+
+	if (!neigh_node)
+		goto unlock;
+
+	if (!atomic_inc_not_zero(&neigh_node->refcount)) {
+		neigh_node = NULL;
+		goto unlock;
+	}
+
+	rcu_read_unlock();
+
+	/* create a copy of the skb, if needed, to modify it. */
+	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
+		goto out;
+
+	icmp_packet = (struct icmp_packet *)skb->data;
+
+	memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
+	memcpy(icmp_packet->orig,
+		bat_priv->primary_if->net_dev->dev_addr, ETH_ALEN);
+	icmp_packet->msg_type = TTL_EXCEEDED;
+	icmp_packet->header.ttl = TTL;
+
+	send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
+	ret = NET_RX_SUCCESS;
+	goto out;
+
+unlock:
+	rcu_read_unlock();
+out:
+	if (neigh_node)
+		neigh_node_free_ref(neigh_node);
+	if (orig_node)
+		kref_put(&orig_node->refcount, orig_node_free_ref);
+	return ret;
+}
+
+static void print_ttl_exceeded(struct sk_buff *skb, int packet_type,
+			       struct bat_priv *bat_priv) {
+	switch (packet_type) {
+	case BAT_PACKET:
+		bat_dbg(DBG_BATMAN, bat_priv, "ttl exceeded\n");
+		break;
+	case BAT_ICMP:
+		recv_icmp_ttl_exceeded(bat_priv, skb);
+		break;
+	case BAT_VIS:
+		pr_debug("Error - can't send vis packet: ttl exceeded\n");
+		break;
+	case BAT_UNICAST:
+		pr_debug("Warning - can't forward unicast packet from %pM to "
+			 "%pM: ttl exceeded\n",
+			 ((struct ethhdr *)skb->data)->h_source,
+			 ((struct unicast_packet *)skb->data)->dest);
+		break;
+	default:
+		break;
+	}
+}
+
 /* send out an already prepared packet to the given address via the
- * specified batman interface */
+ * specified batman interface; drops it if the current TTL is 1 or less
+ * or else reduces the TTL by one */
 int send_skb_packet(struct sk_buff *skb,
 				struct batman_if *batman_if,
 				uint8_t *dst_addr)
 {
 	struct ethhdr *ethhdr;
+	struct batman_header *batman_header;
+	struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);
 
 	if (batman_if->if_status != IF_ACTIVE)
 		goto send_skb_err;
@@ -73,6 +168,15 @@ int send_skb_packet(struct sk_buff *skb,
 		goto send_skb_err;
 	}
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(struct batman_packet))))
+		goto send_skb_err;
+	batman_header = (struct batman_header *) skb->data;
+	if (batman_header->ttl <= 1) {
+		print_ttl_exceeded(skb, batman_header->packet_type, bat_priv);
+		goto send_skb_err;
+	}
+	batman_header->ttl--;
+
 	/* push to the ethernet header. */
 	if (my_skb_head_push(skb, sizeof(struct ethhdr)) < 0)
 		goto send_skb_err;
@@ -181,7 +285,7 @@ static void send_packet(struct forw_packet *forw_packet)
 
 	/* multihomed peer assumed */
 	/* non-primary OGMs are only broadcasted on their interface */
-	if ((directlink && (batman_packet->header.ttl == 1)) ||
+	if ((directlink && (batman_packet->header.ttl == 2)) ||
 	    (forw_packet->own && (forw_packet->if_incoming->if_num > 0))) {
 
 		/* FIXME: what about aggregated packets ? */
@@ -310,15 +414,9 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	unsigned char in_tq, in_ttl, tq_avg = 0;
 	unsigned long send_time;
 
-	if (batman_packet->header.ttl <= 1) {
-		bat_dbg(DBG_BATMAN, bat_priv, "ttl exceeded\n");
-		return;
-	}
-
 	in_tq = batman_packet->tq;
 	in_ttl = batman_packet->header.ttl;
 
-	batman_packet->header.ttl--;
 	memcpy(batman_packet->prev_sender, ethhdr->h_source, ETH_ALEN);
 
 	/* rebroadcast tq of our best ranking neighbor to ensure the rebroadcast
@@ -331,7 +429,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 
 			if (orig_node->router->last_ttl)
 				batman_packet->header.ttl =
-					orig_node->router->last_ttl - 1;
+						orig_node->router->last_ttl;
 		}
 
 		tq_avg = orig_node->router->tq_avg;
@@ -343,8 +441,8 @@ void schedule_forward_packet(struct orig_node *orig_node,
 	bat_dbg(DBG_BATMAN, bat_priv,
 		"Forwarding packet: tq_orig: %i, tq_avg: %i, "
 		"tq_forw: %i, ttl_orig: %i, ttl_forw: %i\n",
-		in_tq, tq_avg, batman_packet->tq, in_ttl - 1,
-		batman_packet->header.ttl);
+		in_tq, tq_avg, batman_packet->tq, in_ttl,
+		batman_packet->header.ttl - 1);
 
 	batman_packet->seqno = htonl(batman_packet->seqno);
 
@@ -399,7 +497,6 @@ static void _add_bcast_packet_to_list(struct bat_priv *bat_priv,
 int add_bcast_packet_to_list(struct bat_priv *bat_priv, struct sk_buff *skb)
 {
 	struct forw_packet *forw_packet;
-	struct bcast_packet *bcast_packet;
 
 	if (!atomic_dec_not_zero(&bat_priv->bcast_queue_left)) {
 		bat_dbg(DBG_BATMAN, bat_priv, "bcast packet queue full\n");
@@ -418,10 +515,6 @@ int add_bcast_packet_to_list(struct bat_priv *bat_priv, struct sk_buff *skb)
 	if (!skb)
 		goto packet_free;
 
-	/* as we have a copy now, it is safe to decrease the TTL */
-	bcast_packet = (struct bcast_packet *)skb->data;
-	bcast_packet->header.ttl--;
-
 	skb_reset_mac_header(skb);
 
 	forw_packet->skb = skb;
diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 62e6c64..4cbc011 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -260,7 +260,6 @@ int frag_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv,
 
 	memcpy(frag1, &tmp_uc, sizeof(struct unicast_packet));
 
-	frag1->header.ttl--;
 	frag1->header.version = COMPAT_VERSION;
 	frag1->header.packet_type = BAT_UNICAST_FRAG;
 
@@ -337,8 +336,6 @@ find_router:
 	if (atomic_read(&bat_priv->fragmentation) &&
 	    data_len + sizeof(struct unicast_packet) >
 				neigh_node->if_incoming->net_dev->mtu) {
-		/* send frag skb decreases ttl */
-		unicast_packet->header.ttl++;
 		ret = frag_send_skb(skb, bat_priv,
 				    neigh_node->if_incoming, neigh_node->addr);
 		goto out;
diff --git a/batman-adv/vis.c b/batman-adv/vis.c
index 3551f06..926b328 100644
--- a/batman-adv/vis.c
+++ b/batman-adv/vis.c
@@ -806,20 +806,14 @@ static void send_vis_packet(struct bat_priv *bat_priv, struct vis_info *info)
 	struct vis_packet *packet;
 
 	packet = (struct vis_packet *)info->skb_packet->data;
-	if (packet->header.ttl < 2) {
-		pr_debug("Error - can't send vis packet: ttl exceeded\n");
-		return;
-	}
 
 	memcpy(packet->sender_orig, bat_priv->primary_if->net_dev->dev_addr,
 	       ETH_ALEN);
-	packet->header.ttl--;
 
 	if (is_broadcast_ether_addr(packet->target_orig))
 		broadcast_vis_packet(bat_priv, info);
 	else
 		unicast_vis_packet(bat_priv, info);
-	packet->header.ttl++; /* restore TTL */
 }
 
 /* called from timer; send (and maybe generate) vis packet. */
-- 
1.7.2.3

