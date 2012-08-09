Return-Path: <montik@autistici.org>
From: Edo Monticelli <montik@autistici.org>
Date: Thu,  9 Aug 2012 14:15:26 +0200
Message-Id: <1344514526-30256-4-git-send-email-montik@autistici.org>
In-Reply-To: <1344514526-30256-1-git-send-email-montik@autistici.org>
References: <1344514526-30256-1-git-send-email-montik@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC 3/3] batman-adv: seqnumber is wrap around safe
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

Sequence number in packet header is 16 bit and is made wrap around safe. Two 32
bit counters, window_first and total_to_send are locally kept in the struct
bw_vars. On packet or acks arrival batadv_seq_before()/after() are used to check
seqno against 16bit version of these counters.
BATADV_BW_FIRST_SEQ is the sequence number of the first packet. It is set to
65530 to generate a wrap-around. *Both sides must agree on this value*

Signed-off-by: Edo Monticelli <montik@autistici.org>
---
 bw_meter.c |   56 +++++++++++++++++++++++++++++++-------------------------
 types.h    |    4 ++--
 2 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/bw_meter.c b/bw_meter.c
index b582ab0..c636c53 100644
--- a/bw_meter.c
+++ b/bw_meter.c
@@ -16,6 +16,7 @@
 #define BATADV_BW_RECV_TIMEOUT 1000
 #define BATADV_BW_TOTAL_TO_SEND 5000
 #define BATADV_BW_MAX_RETRY 3
+#define BATADV_BW_FIRST_SEQ 65530
 
 static int batadv_bw_queue_sender_worker(struct batadv_bw_vars *bw_vars);
 static int batadv_bw_queue_receiver_worker(struct batadv_bw_vars *bw_vars);
@@ -158,7 +159,7 @@ void batadv_bw_meter_received(struct batadv_priv *bat_priv, struct sk_buff *skb)
 	struct batadv_bw_vars *bw_vars;
 	struct batadv_icmp_packet *icmp_packet;
 	struct batadv_socket_client *socket_client;
-	uint16_t seqno;
+	uint16_t seqno, window_first_16;
 	socket_client = container_of(&bat_priv,
 				     struct batadv_socket_client, bat_priv);
 
@@ -169,7 +170,7 @@ void batadv_bw_meter_received(struct batadv_priv *bat_priv, struct sk_buff *skb)
 	seqno = ntohs(icmp_packet->seqno);
 	bw_vars = batadv_bw_list_find(bat_priv, &icmp_packet->dst);
 	if (!bw_vars) {
-		if (seqno != 0) {
+		if (seqno != BATADV_BW_FIRST_SEQ) {
 			spin_unlock_bh(&bat_priv->bw_list_lock);
 			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 				   "Meter: seq != 0 cannot initiate connection\n");
@@ -184,7 +185,7 @@ void batadv_bw_meter_received(struct batadv_priv *bat_priv, struct sk_buff *skb)
 		}
 		memcpy(&bw_vars->other_end, &icmp_packet->dst, ETH_ALEN);
 		bw_vars->status = RECEIVER;
-		bw_vars->window_first = 0;
+		bw_vars->window_first = BATADV_BW_FIRST_SEQ;
 		bw_vars->bat_priv = bat_priv;
 		spin_lock_init(&bw_vars->bw_vars_lock);
 		list_add(&bw_vars->list, &bat_priv->bw_list);
@@ -199,18 +200,20 @@ void batadv_bw_meter_received(struct batadv_priv *bat_priv, struct sk_buff *skb)
 			   "Meter: dropping packet: connection is not expecting any\n");
 		goto out;
 	}
+	window_first_16 = (uint16_t) bw_vars->window_first;
 	spin_unlock_bh(&bat_priv->bw_list_lock);
 
 	/* check if the packet belongs to window */
 	spin_lock_bh(&bw_vars->bw_vars_lock);
-	if (seqno < bw_vars->window_first) {
+	if (batadv_seq_before(seqno, window_first_16)) {
 		spin_unlock_bh(&bw_vars->bw_vars_lock);
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Meter: %d < window_first\n", icmp_packet->seqno);
 		goto out; /* TODO send an ack! */
 	}
 
-	if (seqno > bw_vars->window_first + BATADV_BW_WINDOW_SIZE) {
+	if (batadv_seq_after(seqno, (uint16_t) (window_first_16 +
+						BATADV_BW_WINDOW_SIZE))) {
 		spin_unlock_bh(&bw_vars->bw_vars_lock);
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Meter: unexpected packet received\n");
@@ -218,7 +221,7 @@ void batadv_bw_meter_received(struct batadv_priv *bat_priv, struct sk_buff *skb)
 	}
 
 	/* packet does belong to the window */
-	if (seqno == bw_vars->window_first) {
+	if (seqno == window_first_16) {
 		bw_vars->window_first++;
 		bw_vars->last_sent_time = jiffies;
 		spin_unlock_bh(&bw_vars->bw_vars_lock);
@@ -253,7 +256,7 @@ static int batadv_bw_multiple_send(struct batadv_priv *bat_priv,
 	struct batadv_icmp_packet *icmp_to_send;
 	struct batadv_socket_client *socket_client;
 	int ret, bw_packet_len;
-	uint16_t window_default_end, window_end, next_to_send;
+	uint16_t window_end, next_to_send;
 
 	ret = -1;
 	bw_packet_len = BATADV_BW_PACKET_LEN;
@@ -265,9 +268,8 @@ static int batadv_bw_multiple_send(struct batadv_priv *bat_priv,
 
 	while (1) {
 		spin_lock_bh(&bw_vars->bw_window_first_lock);
-		window_default_end = bw_vars->window_first +
-				     BATADV_BW_WINDOW_SIZE;
-		window_end = min(window_default_end, bw_vars->total_to_send);
+		window_end = min(bw_vars->window_first + BATADV_BW_WINDOW_SIZE,
+				 bw_vars->total_to_send);
 
 		if (!batadv_seq_before(bw_vars->next_to_send, window_end)) {
 			spin_unlock_bh(&bw_vars->bw_send_lock);
@@ -275,12 +277,15 @@ static int batadv_bw_multiple_send(struct batadv_priv *bat_priv,
 			break;
 		}
 
-		next_to_send = bw_vars->next_to_send++;
 		bw_vars->last_sent_time = jiffies;
+		next_to_send = bw_vars->next_to_send++;
 		spin_unlock_bh(&bw_vars->bw_window_first_lock);
 
-		if (bw_vars->next_to_send == bw_vars->total_to_send)
+		if ((bw_vars->window_first + BATADV_BW_WINDOW_SIZE >=
+		     bw_vars->total_to_send) &&
+		    bw_vars->next_to_send == (uint16_t)bw_vars->total_to_send) {
 			bw_packet_len -= 1;
+		}
 
 		skb = dev_alloc_skb(bw_packet_len + ETH_HLEN);
 		if (!skb) {
@@ -320,7 +325,7 @@ void batadv_bw_ack_received(struct batadv_priv *bat_priv,
 {
 	struct batadv_icmp_packet *icmp_packet;
 	struct batadv_bw_vars *bw_vars;
-	uint16_t window_end, seqno;
+	uint16_t seqno, window_end, window_first_16;
 
 	icmp_packet = (struct batadv_icmp_packet *)skb->data;
 
@@ -338,10 +343,11 @@ void batadv_bw_ack_received(struct batadv_priv *bat_priv,
 	/* slide and send fresh packets */
 	spin_lock_bh(&bw_vars->bw_window_first_lock);
 	seqno = ntohs(icmp_packet->seqno);
-	window_end = bw_vars->window_first + BATADV_BW_WINDOW_SIZE;
-	if (!batadv_seq_after(bw_vars->window_first, seqno) &&
+	window_first_16 = (uint16_t) bw_vars->window_first;
+	window_end = window_first_16 + BATADV_BW_WINDOW_SIZE;
+	if (!batadv_seq_after(window_first_16, seqno) &&
 	    batadv_seq_before(seqno, bw_vars->next_to_send)) {
-		bw_vars->window_first = seqno + 1;
+		bw_vars->window_first += seqno + 1 - window_first_16;
 	} else if (bw_vars->status != ABORTING) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Meter: received unespected ack\n");
@@ -393,14 +399,15 @@ static void batadv_bw_sender_worker(struct work_struct *work)
 		if (bw_vars->window_first == bw_vars->last_resent_window) {
 			bw_vars->retry_number += 1;
 			if (bw_vars->retry_number > BATADV_BW_MAX_RETRY) {
-				bw_vars->window_first = BATADV_BW_TOTAL_TO_SEND;
+				bw_vars->window_first = bw_vars->total_to_send;
 				bw_vars->status = ABORTING;
 			}
 		} else {
 			bw_vars->retry_number = 0;
 		}
 
-		pr_info("RESENDING WHOLE WINDOW %d\n", bw_vars->window_first);
+		pr_info("RESENDING WHOLE WINDOW %d\n",
+			(uint16_t)bw_vars->window_first);
 		bw_vars->last_resent_window = bw_vars->window_first;
 		bw_vars->next_to_send = bw_vars->window_first;
 		batadv_bw_multiple_send(bat_priv, bw_vars);
@@ -422,9 +429,8 @@ static void batadv_bw_sender_worker(struct work_struct *work)
 			result->total_bytes = 0;
 		} else {
 			result->test_time = ((long)jiffies -
-					     (long)bw_vars->start_time) *
-					    (1000/HZ);
-			result->total_bytes = bw_vars->total_to_send *
+					     (long)bw_vars->start_time);
+			result->total_bytes = BATADV_BW_TOTAL_TO_SEND *
 					      BATADV_BW_PACKET_LEN;
 		}
 		batadv_socket_receive_packet(icmp_packet_rr,
@@ -468,7 +474,7 @@ void batadv_bw_stop(struct batadv_priv *bat_priv,
 	}
 	spin_unlock_bh(&bat_priv->bw_list_lock);
 	spin_lock_bh(&bw_vars->bw_window_first_lock);
-	bw_vars->window_first = BATADV_BW_TOTAL_TO_SEND;
+	bw_vars->window_first = bw_vars->total_to_send;
 	bw_vars->status = ABORTING;
 	spin_unlock_bh(&bw_vars->bw_window_first_lock);
 }
@@ -500,9 +506,9 @@ void batadv_bw_start(struct batadv_socket_client *socket_client,
 
 	/* initialize bw_vars */
 	memcpy(&bw_vars->other_end, &icmp_packet->dst, ETH_ALEN);
-	bw_vars->total_to_send = BATADV_BW_TOTAL_TO_SEND;
-	bw_vars->next_to_send = 0;
-	bw_vars->window_first = 0;
+	bw_vars->total_to_send = BATADV_BW_TOTAL_TO_SEND + BATADV_BW_FIRST_SEQ;
+	bw_vars->window_first = BATADV_BW_FIRST_SEQ;
+	bw_vars->next_to_send = BATADV_BW_FIRST_SEQ;
 	bw_vars->last_resent_window = 0;
 	bw_vars->bat_priv = bat_priv;
 	bw_vars->socket_client = socket_client;
diff --git a/types.h b/types.h
index e5ba150..dd515e6 100644
--- a/types.h
+++ b/types.h
@@ -245,10 +245,10 @@ struct batadv_bw_vars {
 	/* protects multiple_send calls */
 	spinlock_t bw_send_lock;
 	/* total data to send OR window data received */
-	uint16_t total_to_send;
+	uint32_t total_to_send;
 	/* offset of the first window packet */
 	uint16_t next_to_send;
-	uint16_t window_first;
+	uint32_t window_first;
 	uint8_t other_end[ETH_ALEN];
 	uint8_t status; /* see bm_meter_status */
 	unsigned long start_time;
-- 
1.7.8.6

