Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 16 Feb 2012 00:40:00 +0100
Message-Id: <1329349200-8507-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use ETH_HLEN instead of
	sizeof(struct ethhdr)
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

Instead of using sizeof(struct ethhdr) it is strongly recommended to use the
kernel macro ETH_HLEN. This patch substitute each occurrence of the former
expressione with the latter one.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_iv_ogm.c            |    7 +++----
 bridge_loop_avoidance.c |    8 +++-----
 hard-interface.c        |    3 +--
 icmp_socket.c           |    4 ++--
 routing.c               |    8 ++++----
 soft-interface.c        |    2 +-
 types.h                 |    2 +-
 vis.c                   |    8 ++++----
 8 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index caa67e4..42c121d 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -358,10 +358,9 @@ static void bat_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	if ((atomic_read(&bat_priv->aggregated_ogms)) &&
 	    (packet_len < MAX_AGGREGATION_BYTES))
 		forw_packet_aggr->skb = dev_alloc_skb(MAX_AGGREGATION_BYTES +
-						      sizeof(struct ethhdr));
+						      ETH_HLEN);
 	else
-		forw_packet_aggr->skb = dev_alloc_skb(packet_len +
-						      sizeof(struct ethhdr));
+		forw_packet_aggr->skb = dev_alloc_skb(packet_len + ETH_HLEN);
 
 	if (!forw_packet_aggr->skb) {
 		if (!own_packet)
@@ -369,7 +368,7 @@ static void bat_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 		kfree(forw_packet_aggr);
 		goto out;
 	}
-	skb_reserve(forw_packet_aggr->skb, sizeof(struct ethhdr));
+	skb_reserve(forw_packet_aggr->skb, ETH_HLEN);
 
 	INIT_HLIST_NODE(&forw_packet_aggr->list);
 
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 99b0a8f..af93e5c 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -292,9 +292,7 @@ static void bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 		goto out;
 
 	ethhdr = (struct ethhdr *)skb->data;
-	hw_src = (uint8_t *) ethhdr +
-		 sizeof(struct ethhdr) +
-		 sizeof(struct arphdr);
+	hw_src = (uint8_t *) ethhdr + ETH_HLEN + sizeof(struct arphdr);
 
 	/* now we pretend that the client would have sent this ... */
 	switch (claimtype) {
@@ -346,7 +344,7 @@ static void bla_send_claim(struct bat_priv *bat_priv, uint8_t *mac,
 	skb_reset_mac_header(skb);
 	skb->protocol = eth_type_trans(skb, soft_iface);
 	bat_priv->stats.rx_packets++;
-	bat_priv->stats.rx_bytes += skb->len + sizeof(struct ethhdr);
+	bat_priv->stats.rx_bytes += skb->len + ETH_HLEN;
 	soft_iface->last_rx = jiffies;
 
 	netif_rx(skb);
@@ -1317,7 +1315,7 @@ int bla_is_backbone_gw(struct sk_buff *skb,
 		return 0;
 
 	/* first, find out the vid. */
-	if (!pskb_may_pull(skb, hdr_size + sizeof(struct ethhdr)))
+	if (!pskb_may_pull(skb, hdr_size + ETH_HLEN))
 		return 0;
 
 	ethhdr = (struct ethhdr *) (((uint8_t *)skb->data) + hdr_size);
diff --git a/hard-interface.c b/hard-interface.c
index 30b1c07..dfa948b 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -587,8 +587,7 @@ static int batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 		goto err_free;
 
 	/* expect a valid ethernet header here. */
-	if (unlikely(skb->mac_len != sizeof(struct ethhdr)
-				|| !skb_mac_header(skb)))
+	if (unlikely(skb->mac_len != ETH_HLEN || !skb_mac_header(skb)))
 		goto err_free;
 
 	if (!hard_iface->soft_iface)
diff --git a/icmp_socket.c b/icmp_socket.c
index 9b755f9..3128920 100644
--- a/icmp_socket.c
+++ b/icmp_socket.c
@@ -177,13 +177,13 @@ static ssize_t bat_socket_write(struct file *file, const char __user *buff,
 	if (len >= sizeof(struct icmp_packet_rr))
 		packet_len = sizeof(struct icmp_packet_rr);
 
-	skb = dev_alloc_skb(packet_len + sizeof(struct ethhdr));
+	skb = dev_alloc_skb(packet_len + ETH_HLEN);
 	if (!skb) {
 		len = -ENOMEM;
 		goto out;
 	}
 
-	skb_reserve(skb, sizeof(struct ethhdr));
+	skb_reserve(skb, ETH_HLEN);
 	icmp_packet = (struct icmp_packet_rr *)skb_put(skb, packet_len);
 
 	if (copy_from_user(icmp_packet, buff, packet_len)) {
diff --git a/routing.c b/routing.c
index 92fe20b..a055386 100644
--- a/routing.c
+++ b/routing.c
@@ -313,7 +313,7 @@ static int recv_my_icmp_packet(struct bat_priv *bat_priv,
 		goto out;
 
 	/* create a copy of the skb, if needed, to modify it. */
-	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
+	if (skb_cow(skb, ETH_HLEN) < 0)
 		goto out;
 
 	icmp_packet = (struct icmp_packet_rr *)skb->data;
@@ -369,7 +369,7 @@ static int recv_icmp_ttl_exceeded(struct bat_priv *bat_priv,
 		goto out;
 
 	/* create a copy of the skb, if needed, to modify it. */
-	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
+	if (skb_cow(skb, ETH_HLEN) < 0)
 		goto out;
 
 	icmp_packet = (struct icmp_packet *)skb->data;
@@ -455,7 +455,7 @@ int recv_icmp_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		goto out;
 
 	/* create a copy of the skb, if needed, to modify it. */
-	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
+	if (skb_cow(skb, ETH_HLEN) < 0)
 		goto out;
 
 	icmp_packet = (struct icmp_packet_rr *)skb->data;
@@ -842,7 +842,7 @@ static int route_unicast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 		goto out;
 
 	/* create a copy of the skb, if needed, to modify it. */
-	if (skb_cow(skb, sizeof(struct ethhdr)) < 0)
+	if (skb_cow(skb, ETH_HLEN) < 0)
 		goto out;
 
 	unicast_packet = (struct unicast_packet *)skb->data;
diff --git a/soft-interface.c b/soft-interface.c
index 3750e9b..3297c40 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -291,7 +291,7 @@ void interface_rx(struct net_device *soft_iface,
 /*	skb->ip_summed = CHECKSUM_UNNECESSARY;*/
 
 	bat_priv->stats.rx_packets++;
-	bat_priv->stats.rx_bytes += skb->len + sizeof(struct ethhdr);
+	bat_priv->stats.rx_bytes += skb->len + ETH_HLEN;
 
 	soft_iface->last_rx = jiffies;
 
diff --git a/types.h b/types.h
index 4d93aad..2f4848b 100644
--- a/types.h
+++ b/types.h
@@ -27,7 +27,7 @@
 #include "packet.h"
 #include "bitarray.h"
 
-#define BAT_HEADER_LEN (sizeof(struct ethhdr) + \
+#define BAT_HEADER_LEN (ETH_HLEN + \
 	((sizeof(struct unicast_packet) > sizeof(struct bcast_packet) ? \
 	 sizeof(struct unicast_packet) : \
 	 sizeof(struct bcast_packet))))
diff --git a/vis.c b/vis.c
index c4a5b8c..cec216f 100644
--- a/vis.c
+++ b/vis.c
@@ -434,12 +434,12 @@ static struct vis_info *add_packet(struct bat_priv *bat_priv,
 		return NULL;
 
 	info->skb_packet = dev_alloc_skb(sizeof(*packet) + vis_info_len +
-					 sizeof(struct ethhdr));
+					 ETH_HLEN);
 	if (!info->skb_packet) {
 		kfree(info);
 		return NULL;
 	}
-	skb_reserve(info->skb_packet, sizeof(struct ethhdr));
+	skb_reserve(info->skb_packet, ETH_HLEN);
 	packet = (struct vis_packet *)skb_put(info->skb_packet, sizeof(*packet)
 					      + vis_info_len);
 
@@ -894,11 +894,11 @@ int vis_init(struct bat_priv *bat_priv)
 
 	bat_priv->my_vis_info->skb_packet = dev_alloc_skb(sizeof(*packet) +
 							  MAX_VIS_PACKET_SIZE +
-							 sizeof(struct ethhdr));
+							  ETH_HLEN);
 	if (!bat_priv->my_vis_info->skb_packet)
 		goto free_info;
 
-	skb_reserve(bat_priv->my_vis_info->skb_packet, sizeof(struct ethhdr));
+	skb_reserve(bat_priv->my_vis_info->skb_packet, ETH_HLEN);
 	packet = (struct vis_packet *)skb_put(bat_priv->my_vis_info->skb_packet,
 					      sizeof(*packet));
 
-- 
1.7.3.4

