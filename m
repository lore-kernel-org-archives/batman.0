Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:33 +0200
Message-Id: <1283644718-653-17-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 16/21] Staging: batman-adv: Provide full
	headers and packets as linear skb
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

We must ensure that all interesting data is linear and not paged out to
access all information in a header or a full batman-adv related packet.
Otherwise we may drop packets which have non-linear headers but which
hold valid data.

This doesn't affect non-linear skbs which have all headers in a linear
head unless we must process the whole packet like in ogms or vis
packets.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/hard-interface.c |    2 +-
 drivers/staging/batman-adv/routing.c        |   22 ++++++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/batman-adv/hard-interface.c b/drivers/staging/batman-adv/hard-interface.c
index f33c73f..c1863d2 100644
--- a/drivers/staging/batman-adv/hard-interface.c
+++ b/drivers/staging/batman-adv/hard-interface.c
@@ -486,7 +486,7 @@ int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 		goto err_free;
 
 	/* packet should hold at least type and version */
-	if (unlikely(skb_headlen(skb) < 2))
+	if (unlikely(!pskb_may_pull(skb, 2)))
 		goto err_free;
 
 	/* expect a valid ethernet header here. */
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 7e993a2..6009adc 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -744,7 +744,7 @@ int recv_bat_packet(struct sk_buff *skb,
 	unsigned long flags;
 
 	/* drop packet if it has not necessary minimum size */
-	if (skb_headlen(skb) < sizeof(struct batman_packet))
+	if (unlikely(!pskb_may_pull(skb, sizeof(struct batman_packet))))
 		return NET_RX_DROP;
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
@@ -761,6 +761,10 @@ int recv_bat_packet(struct sk_buff *skb,
 	if (skb_cow(skb, 0) < 0)
 		return NET_RX_DROP;
 
+	/* keep skb linear */
+	if (skb_linearize(skb) < 0)
+		return NET_RX_DROP;
+
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	spin_lock_irqsave(&orig_hash_lock, flags);
@@ -914,11 +918,11 @@ int recv_icmp_packet(struct sk_buff *skb)
 	/**
 	 * we truncate all incoming icmp packets if they don't match our size
 	 */
-	if (skb_headlen(skb) >= sizeof(struct icmp_packet_rr))
+	if (skb->len >= sizeof(struct icmp_packet_rr))
 		hdr_size = sizeof(struct icmp_packet_rr);
 
 	/* drop packet if it has not necessary minimum size */
-	if (skb_headlen(skb) < hdr_size)
+	if (unlikely(!pskb_may_pull(skb, hdr_size)))
 		return NET_RX_DROP;
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
@@ -1087,7 +1091,7 @@ static int check_unicast_packet(struct sk_buff *skb, int hdr_size)
 	struct ethhdr *ethhdr;
 
 	/* drop packet if it has not necessary minimum size */
-	if (skb_headlen(skb) < hdr_size)
+	if (unlikely(!pskb_may_pull(skb, hdr_size)))
 		return -1;
 
 	ethhdr = (struct ethhdr *) skb_mac_header(skb);
@@ -1247,7 +1251,7 @@ int recv_bcast_packet(struct sk_buff *skb)
 	unsigned long flags;
 
 	/* drop packet if it has not necessary minimum size */
-	if (skb_headlen(skb) < hdr_size)
+	if (unlikely(!pskb_may_pull(skb, hdr_size)))
 		return NET_RX_DROP;
 
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
@@ -1320,7 +1324,11 @@ int recv_vis_packet(struct sk_buff *skb)
 	struct bat_priv *bat_priv;
 	int hdr_size = sizeof(struct vis_packet);
 
-	if (skb_headlen(skb) < hdr_size)
+	/* keep skb linear */
+	if (skb_linearize(skb) < 0)
+		return NET_RX_DROP;
+
+	if (unlikely(!pskb_may_pull(skb, hdr_size)))
 		return NET_RX_DROP;
 
 	vis_packet = (struct vis_packet *) skb->data;
@@ -1342,13 +1350,11 @@ int recv_vis_packet(struct sk_buff *skb)
 
 	switch (vis_packet->vis_type) {
 	case VIS_TYPE_SERVER_SYNC:
-		/* TODO: handle fragmented skbs properly */
 		receive_server_sync_packet(bat_priv, vis_packet,
 					   skb_headlen(skb));
 		break;
 
 	case VIS_TYPE_CLIENT_UPDATE:
-		/* TODO: handle fragmented skbs properly */
 		receive_client_update_packet(bat_priv, vis_packet,
 					     skb_headlen(skb));
 		break;
-- 
1.7.1

