Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:32 +0200
Message-Id: <1283644718-653-16-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 15/21] Staging: batman-adv: Create copy of
	skb with pre-allocated headroom
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net

We can use skb_cow instead of a handwritten function to test and create
a writable skb buffer. This also allows us to pre-allocate headroom to
be able to send the data without re-allocating the buffer again to add
the ethernet header.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/routing.c |   77 ++++++++++-----------------------
 1 files changed, 24 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index d8e77ac..7e993a2 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -742,7 +742,6 @@ int recv_bat_packet(struct sk_buff *skb,
 {
 	struct ethhdr *ethhdr;
 	unsigned long flags;
-	struct sk_buff *skb_old;
 
 	/* drop packet if it has not necessary minimum size */
 	if (skb_headlen(skb) < sizeof(struct batman_packet))
@@ -758,18 +757,11 @@ int recv_bat_packet(struct sk_buff *skb,
 	if (is_bcast(ethhdr->h_source))
 		return NET_RX_DROP;
 
-	/* TODO: we use headlen instead of "length", because
-	 * only this data is paged in. */
-
 	/* create a copy of the skb, if needed, to modify it. */
-	if (!skb_clone_writable(skb, skb_headlen(skb))) {
-		skb_old = skb;
-		skb = skb_copy(skb, GFP_ATOMIC);
-		if (!skb)
-			return NET_RX_DROP;
-		ethhdr = (struct ethhdr *)skb_mac_header(skb);
-		kfree_skb(skb_old);
-	}
+	if (skb_cow(skb, 0) < 0)
+		return NET_RX_DROP;
+
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
 	receive_aggr_bat_packet(ethhdr,
@@ -789,7 +781,6 @@ static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
 	struct orig_node *orig_node;
 	struct icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
-	struct sk_buff *skb_old;
 	struct batman_if *batman_if;
 	int ret;
 	unsigned long flags;
@@ -824,16 +815,11 @@ static int recv_my_icmp_packet(struct sk_buff *skb, size_t icmp_len)
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
 		/* create a copy of the skb, if needed, to modify it. */
-		skb_old = NULL;
-		if (!skb_clone_writable(skb, icmp_len)) {
-			skb_old = skb;
-			skb = skb_copy(skb, GFP_ATOMIC);
-			if (!skb)
-				return NET_RX_DROP;
-			icmp_packet = (struct icmp_packet_rr *)skb->data;
-			ethhdr = (struct ethhdr *)skb_mac_header(skb);
-			kfree_skb(skb_old);
-		}
+		if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
+			return NET_RX_DROP;
+
+		icmp_packet = (struct icmp_packet_rr *)skb->data;
+		ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 		memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
 		memcpy(icmp_packet->orig,
@@ -857,7 +843,6 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 	struct orig_node *orig_node;
 	struct icmp_packet *icmp_packet;
 	struct ethhdr *ethhdr;
-	struct sk_buff *skb_old;
 	struct batman_if *batman_if;
 	int ret;
 	unsigned long flags;
@@ -893,15 +878,11 @@ static int recv_icmp_ttl_exceeded(struct sk_buff *skb, size_t icmp_len)
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
 		/* create a copy of the skb, if needed, to modify it. */
-		if (!skb_clone_writable(skb, icmp_len)) {
-			skb_old = skb;
-			skb = skb_copy(skb, GFP_ATOMIC);
-			if (!skb)
-				return NET_RX_DROP;
-			icmp_packet = (struct icmp_packet *) skb->data;
-			ethhdr = (struct ethhdr *)skb_mac_header(skb);
-			kfree_skb(skb_old);
-		}
+		if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
+			return NET_RX_DROP;
+
+		icmp_packet = (struct icmp_packet *) skb->data;
+		ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 		memcpy(icmp_packet->dst, icmp_packet->orig, ETH_ALEN);
 		memcpy(icmp_packet->orig,
@@ -924,7 +905,6 @@ int recv_icmp_packet(struct sk_buff *skb)
 	struct icmp_packet_rr *icmp_packet;
 	struct ethhdr *ethhdr;
 	struct orig_node *orig_node;
-	struct sk_buff *skb_old;
 	struct batman_if *batman_if;
 	int hdr_size = sizeof(struct icmp_packet);
 	int ret;
@@ -990,15 +970,11 @@ int recv_icmp_packet(struct sk_buff *skb)
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 
 		/* create a copy of the skb, if needed, to modify it. */
-		if (!skb_clone_writable(skb, hdr_size)) {
-			skb_old = skb;
-			skb = skb_copy(skb, GFP_ATOMIC);
-			if (!skb)
-				return NET_RX_DROP;
-			icmp_packet = (struct icmp_packet_rr *)skb->data;
-			ethhdr = (struct ethhdr *)skb_mac_header(skb);
-			kfree_skb(skb_old);
-		}
+		if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
+			return NET_RX_DROP;
+
+		icmp_packet = (struct icmp_packet_rr *)skb->data;
+		ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 		/* decrement ttl */
 		icmp_packet->ttl--;
@@ -1137,7 +1113,6 @@ static int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 	struct orig_node *orig_node;
 	struct neigh_node *router;
 	struct batman_if *batman_if;
-	struct sk_buff *skb_old;
 	uint8_t dstaddr[ETH_ALEN];
 	unsigned long flags;
 	struct unicast_packet *unicast_packet =
@@ -1173,15 +1148,11 @@ static int route_unicast_packet(struct sk_buff *skb, struct batman_if *recv_if,
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 
 	/* create a copy of the skb, if needed, to modify it. */
-	if (!skb_clone_writable(skb, hdr_size)) {
-		skb_old = skb;
-		skb = skb_copy(skb, GFP_ATOMIC);
-		if (!skb)
-			return NET_RX_DROP;
-		unicast_packet = (struct unicast_packet *) skb->data;
-		ethhdr = (struct ethhdr *)skb_mac_header(skb);
-		kfree_skb(skb_old);
-	}
+	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
+		return NET_RX_DROP;
+
+	unicast_packet = (struct unicast_packet *) skb->data;
+	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	/* decrement ttl */
 	unicast_packet->ttl--;
-- 
1.7.1

