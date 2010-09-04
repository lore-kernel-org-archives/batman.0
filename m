Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  5 Sep 2010 01:58:30 +0200
Message-Id: <1283644718-653-14-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
References: <1283644718-653-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 13/21] Staging: batman-adv: Aggregate batman
	packets directly in skb
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

All originator messages are send through aggregation buffers. Those
buffers can directly be allocated as skb to reduce the cost of
allocation an extra buffer and copying them to a new allocated skb
directly before it gets send.

Now only the skb must be cloned in case of send_packet_to_if as it gets
called by send_packet for each interface. Non-primary ogms must not
cloned at all because they will only send once and the forward_packet
structure is freed by send_outstanding_bat_packet afterwards.

Reported-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/aggregation.c |   22 ++++++++++++----------
 drivers/staging/batman-adv/send.c        |   24 ++++++++++++------------
 drivers/staging/batman-adv/types.h       |    1 -
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/batman-adv/aggregation.c b/drivers/staging/batman-adv/aggregation.c
index d738b7a..5896cf2 100644
--- a/drivers/staging/batman-adv/aggregation.c
+++ b/drivers/staging/batman-adv/aggregation.c
@@ -39,7 +39,7 @@ static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 			       struct forw_packet *forw_packet)
 {
 	struct batman_packet *batman_packet =
-		(struct batman_packet *)forw_packet->packet_buff;
+		(struct batman_packet *)forw_packet->skb->data;
 	int aggregated_bytes = forw_packet->packet_len + packet_len;
 
 	/**
@@ -106,6 +106,7 @@ static void new_aggregated_packet(unsigned char *packet_buff,
 {
 	struct forw_packet *forw_packet_aggr;
 	unsigned long flags;
+	unsigned char *skb_buff;
 	/* FIXME: each batman_if will be attached to a softif */
 	struct bat_priv *bat_priv = netdev_priv(soft_device);
 
@@ -125,23 +126,22 @@ static void new_aggregated_packet(unsigned char *packet_buff,
 		return;
 	}
 
-	forw_packet_aggr->packet_buff = kmalloc(MAX_AGGREGATION_BYTES,
-						GFP_ATOMIC);
-	if (!forw_packet_aggr->packet_buff) {
+	forw_packet_aggr->skb = dev_alloc_skb(MAX_AGGREGATION_BYTES +
+					      sizeof(struct ethhdr));
+	if (!forw_packet_aggr->skb) {
 		if (!own_packet)
 			atomic_inc(&bat_priv->batman_queue_left);
 		kfree(forw_packet_aggr);
 		return;
 	}
+	skb_reserve(forw_packet_aggr->skb, sizeof(struct ethhdr));
 
 	INIT_HLIST_NODE(&forw_packet_aggr->list);
 
+	skb_buff = skb_put(forw_packet_aggr->skb, packet_len);
 	forw_packet_aggr->packet_len = packet_len;
-	memcpy(forw_packet_aggr->packet_buff,
-	       packet_buff,
-	       forw_packet_aggr->packet_len);
+	memcpy(skb_buff, packet_buff, packet_len);
 
-	forw_packet_aggr->skb = NULL;
 	forw_packet_aggr->own = own_packet;
 	forw_packet_aggr->if_incoming = if_incoming;
 	forw_packet_aggr->num_packets = 0;
@@ -171,8 +171,10 @@ static void aggregate(struct forw_packet *forw_packet_aggr,
 		      int packet_len,
 		      bool direct_link)
 {
-	memcpy((forw_packet_aggr->packet_buff + forw_packet_aggr->packet_len),
-	       packet_buff, packet_len);
+	unsigned char *skb_buff;
+
+	skb_buff = skb_put(forw_packet_aggr->skb, packet_len);
+	memcpy(skb_buff, packet_buff, packet_len);
 	forw_packet_aggr->packet_len += packet_len;
 	forw_packet_aggr->num_packets++;
 
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index 8dd9dd4..6b138b9 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -126,14 +126,14 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 	uint8_t packet_num;
 	int16_t buff_pos;
 	struct batman_packet *batman_packet;
+	struct sk_buff *skb;
 
 	if (batman_if->if_status != IF_ACTIVE)
 		return;
 
 	packet_num = 0;
 	buff_pos = 0;
-	batman_packet = (struct batman_packet *)
-		(forw_packet->packet_buff);
+	batman_packet = (struct batman_packet *)forw_packet->skb->data;
 
 	/* adjust all flags and log packets */
 	while (aggregated_packet(buff_pos,
@@ -165,12 +165,13 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 			(batman_packet->num_hna * ETH_ALEN);
 		packet_num++;
 		batman_packet = (struct batman_packet *)
-			(forw_packet->packet_buff + buff_pos);
+			(forw_packet->skb->data + buff_pos);
 	}
 
-	send_raw_packet(forw_packet->packet_buff,
-			forw_packet->packet_len,
-			batman_if, broadcast_addr);
+	/* create clone because function is called more than once */
+	skb = skb_clone(forw_packet->skb, GFP_ATOMIC);
+	if (skb)
+		send_skb_packet(skb, batman_if, broadcast_addr);
 }
 
 /* send a batman packet */
@@ -180,7 +181,7 @@ static void send_packet(struct forw_packet *forw_packet)
 	struct bat_priv *bat_priv = netdev_priv(soft_device);
 	struct batman_if *batman_if;
 	struct batman_packet *batman_packet =
-		(struct batman_packet *)(forw_packet->packet_buff);
+		(struct batman_packet *)(forw_packet->skb->data);
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
 
 	if (!forw_packet->if_incoming) {
@@ -206,10 +207,11 @@ static void send_packet(struct forw_packet *forw_packet)
 			batman_packet->ttl, forw_packet->if_incoming->dev,
 			forw_packet->if_incoming->addr_str);
 
-		send_raw_packet(forw_packet->packet_buff,
-				forw_packet->packet_len,
-				forw_packet->if_incoming,
+		/* skb is only used once and than forw_packet is free'd */
+		send_skb_packet(forw_packet->skb, forw_packet->if_incoming,
 				broadcast_addr);
+		forw_packet->skb = NULL;
+
 		return;
 	}
 
@@ -366,7 +368,6 @@ static void forw_packet_free(struct forw_packet *forw_packet)
 {
 	if (forw_packet->skb)
 		kfree_skb(forw_packet->skb);
-	kfree(forw_packet->packet_buff);
 	kfree(forw_packet);
 }
 
@@ -425,7 +426,6 @@ int add_bcast_packet_to_list(struct sk_buff *skb)
 	skb_reset_mac_header(skb);
 
 	forw_packet->skb = skb;
-	forw_packet->packet_buff = NULL;
 
 	/* how often did we send the bcast packet ? */
 	forw_packet->num_packets = 0;
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 2b06944..4b2e832 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -161,7 +161,6 @@ struct forw_packet {
 	unsigned long send_time;
 	uint8_t own;
 	struct sk_buff *skb;
-	unsigned char *packet_buff;
 	uint16_t packet_len;
 	uint32_t direct_link_flags;
 	uint8_t num_packets;
-- 
1.7.1

