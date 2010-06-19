Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 19 Jun 2010 02:51:50 +0200
Message-Id: <1276908713-28365-6-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
References: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 5/8] Staging: batman-adv: 32bit sequence
	number and TTL for broadcasts
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
To: Greg KH <greg@kroah.com>
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

This patch changes the sequence number range from 8 or 16 bit to 32 bit.
This should avoid problems with the sequence number sliding window algorithm
which we had seen in the past for broadcast floods or malicious packet
injections. We can not assure 100% security with this patch, but it is quite
an improvement over the old 16 bit sequence numbers:

 * expected window size can be increased (4096 -> 65536)
 * 64k packets in the right order would now be needed to cause a loop,
   which seems practically impossible.

Furthermore, a TTL field has been added to the broadcast packet type, just to
make sure.

These changes required to increase the compatibility level once again.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
[sven.eckelmann@gmx.de: Change atomic64_* back to atomic_*, Rework on
top of current version]
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/aggregation.c    |    4 ++--
 drivers/staging/batman-adv/bitarray.c       |    8 ++++----
 drivers/staging/batman-adv/bitarray.h       |    6 +++---
 drivers/staging/batman-adv/main.h           |    2 +-
 drivers/staging/batman-adv/packet.h         |    9 +++++----
 drivers/staging/batman-adv/routing.c        |   17 ++++++++++-------
 drivers/staging/batman-adv/send.c           |   15 ++++++++++-----
 drivers/staging/batman-adv/soft-interface.c |    5 +++--
 drivers/staging/batman-adv/types.h          |    6 +++---
 drivers/staging/batman-adv/vis.c            |    5 +++--
 10 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/batman-adv/aggregation.c b/drivers/staging/batman-adv/aggregation.c
index ce8b8a6..3a5c349 100644
--- a/drivers/staging/batman-adv/aggregation.c
+++ b/drivers/staging/batman-adv/aggregation.c
@@ -252,9 +252,9 @@ void receive_aggr_bat_packet(struct ethhdr *ethhdr, unsigned char *packet_buff,
 	while (aggregated_packet(buff_pos, packet_len,
 				 batman_packet->num_hna)) {
 
-		/* network to host order for our 16bit seqno, and the
+		/* network to host order for our 32bit seqno, and the
 		   orig_interval. */
-		batman_packet->seqno = ntohs(batman_packet->seqno);
+		batman_packet->seqno = ntohl(batman_packet->seqno);
 
 		hna_buff = packet_buff + buff_pos + BAT_PACKET_LEN;
 		receive_bat_packet(ethhdr, batman_packet,
diff --git a/drivers/staging/batman-adv/bitarray.c b/drivers/staging/batman-adv/bitarray.c
index cfca033..c10fe03 100644
--- a/drivers/staging/batman-adv/bitarray.c
+++ b/drivers/staging/batman-adv/bitarray.c
@@ -24,10 +24,10 @@
 
 /* returns true if the corresponding bit in the given seq_bits indicates true
  * and curr_seqno is within range of last_seqno */
-uint8_t get_bit_status(TYPE_OF_WORD *seq_bits, uint16_t last_seqno,
-		       uint16_t curr_seqno)
+uint8_t get_bit_status(TYPE_OF_WORD *seq_bits, uint32_t last_seqno,
+		       uint32_t curr_seqno)
 {
-	int16_t diff, word_offset, word_num;
+	int32_t diff, word_offset, word_num;
 
 	diff = last_seqno - curr_seqno;
 	if (diff < 0 || diff >= TQ_LOCAL_WINDOW_SIZE) {
@@ -125,7 +125,7 @@ static void bit_reset_window(TYPE_OF_WORD *seq_bits)
  *  1 if the window was moved (either new or very old)
  *  0 if the window was not moved/shifted.
  */
-char bit_get_packet(TYPE_OF_WORD *seq_bits, int16_t seq_num_diff,
+char bit_get_packet(TYPE_OF_WORD *seq_bits, int32_t seq_num_diff,
 		    int8_t set_mark)
 {
 	/* sequence number is slightly older. We already got a sequence number
diff --git a/drivers/staging/batman-adv/bitarray.h b/drivers/staging/batman-adv/bitarray.h
index 4dd1e7c..dad13bf 100644
--- a/drivers/staging/batman-adv/bitarray.h
+++ b/drivers/staging/batman-adv/bitarray.h
@@ -26,8 +26,8 @@
 
 /* returns true if the corresponding bit in the given seq_bits indicates true
  * and curr_seqno is within range of last_seqno */
-uint8_t get_bit_status(TYPE_OF_WORD *seq_bits, uint16_t last_seqno,
-					   uint16_t curr_seqno);
+uint8_t get_bit_status(TYPE_OF_WORD *seq_bits, uint32_t last_seqno,
+					   uint32_t curr_seqno);
 
 /* turn corresponding bit on, so we can remember that we got the packet */
 void bit_mark(TYPE_OF_WORD *seq_bits, int32_t n);
@@ -35,7 +35,7 @@ void bit_mark(TYPE_OF_WORD *seq_bits, int32_t n);
 
 /* receive and process one packet, returns 1 if received seq_num is considered
  * new, 0 if old  */
-char bit_get_packet(TYPE_OF_WORD *seq_bits, int16_t seq_num_diff,
+char bit_get_packet(TYPE_OF_WORD *seq_bits, int32_t seq_num_diff,
 					int8_t set_mark);
 
 /* count the hamming weight, how many good packets did we receive? */
diff --git a/drivers/staging/batman-adv/main.h b/drivers/staging/batman-adv/main.h
index f70d99a..145ac51 100644
--- a/drivers/staging/batman-adv/main.h
+++ b/drivers/staging/batman-adv/main.h
@@ -65,7 +65,7 @@
 #define MAX_AGGREGATION_MS 100
 
 #define RESET_PROTECTION_MS 30000
-#define EXPECTED_SEQNO_RANGE	4096
+#define EXPECTED_SEQNO_RANGE	65536
 /* don't reset again within 30 seconds */
 
 #define MODULE_INACTIVE 0
diff --git a/drivers/staging/batman-adv/packet.h b/drivers/staging/batman-adv/packet.h
index 152f57b..f0387ba 100644
--- a/drivers/staging/batman-adv/packet.h
+++ b/drivers/staging/batman-adv/packet.h
@@ -28,7 +28,7 @@
 #define BAT_VIS       0x05
 
 /* this file is included by batctl which needs these defines */
-#define COMPAT_VERSION 8
+#define COMPAT_VERSION 11
 #define DIRECTLINK 0x40
 #define VIS_SERVER 0x20
 
@@ -48,7 +48,7 @@ struct batman_packet {
 	uint8_t  version;  /* batman version field */
 	uint8_t  flags;    /* 0x40: DIRECTLINK flag, 0x20 VIS_SERVER flag... */
 	uint8_t  tq;
-	uint16_t seqno;
+	uint32_t seqno;
 	uint8_t  orig[6];
 	uint8_t  prev_sender[6];
 	uint8_t  ttl;
@@ -79,15 +79,16 @@ struct bcast_packet {
 	uint8_t  packet_type;
 	uint8_t  version;  /* batman version field */
 	uint8_t  orig[6];
-	uint16_t seqno;
+	uint8_t  ttl;
+	uint32_t seqno;
 } __attribute__((packed));
 
 struct vis_packet {
 	uint8_t  packet_type;
 	uint8_t  version;        /* batman version field */
 	uint8_t  vis_type;	 /* which type of vis-participant sent this? */
-	uint8_t  seqno;		 /* sequence number */
 	uint8_t  entries;	 /* number of entries behind this struct */
+	uint32_t seqno;		 /* sequence number */
 	uint8_t  ttl;		 /* TTL */
 	uint8_t  vis_orig[6];	 /* originator that informs about its
 				  * neighbors */
diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 480c645..9dbfabe 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -318,7 +318,7 @@ update_hna:
  *  0 if the packet is to be accepted
  *  1 if the packet is to be ignored.
  */
-static int window_protected(int16_t seq_num_diff,
+static int window_protected(int32_t seq_num_diff,
 				unsigned long *last_reset)
 {
 	if ((seq_num_diff <= -TQ_LOCAL_WINDOW_SIZE)
@@ -352,7 +352,7 @@ static char count_real_packets(struct ethhdr *ethhdr,
 	struct orig_node *orig_node;
 	struct neigh_node *tmp_neigh_node;
 	char is_duplicate = 0;
-	int16_t seq_diff;
+	int32_t seq_diff;
 	int need_update = 0;
 	int set_mark;
 
@@ -406,7 +406,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	char is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
 	char is_broadcast = 0, is_bidirectional, is_single_hop_neigh;
 	char is_duplicate;
-	unsigned short if_incoming_seqno;
+	uint32_t if_incoming_seqno;
 
 	/* Silently drop when the batman packet is actually not a
 	 * correct packet.
@@ -950,7 +950,7 @@ int recv_bcast_packet(struct sk_buff *skb)
 	struct bcast_packet *bcast_packet;
 	struct ethhdr *ethhdr;
 	int hdr_size = sizeof(struct bcast_packet);
-	int16_t seq_diff;
+	int32_t seq_diff;
 	unsigned long flags;
 
 	/* drop packet if it has not necessary minimum size */
@@ -977,6 +977,9 @@ int recv_bcast_packet(struct sk_buff *skb)
 	if (is_my_mac(bcast_packet->orig))
 		return NET_RX_DROP;
 
+	if (bcast_packet->ttl < 2)
+		return NET_RX_DROP;
+
 	spin_lock_irqsave(&orig_hash_lock, flags);
 	orig_node = ((struct orig_node *)
 		     hash_find(orig_hash, bcast_packet->orig));
@@ -989,12 +992,12 @@ int recv_bcast_packet(struct sk_buff *skb)
 	/* check whether the packet is a duplicate */
 	if (get_bit_status(orig_node->bcast_bits,
 			   orig_node->last_bcast_seqno,
-			   ntohs(bcast_packet->seqno))) {
+			   ntohl(bcast_packet->seqno))) {
 		spin_unlock_irqrestore(&orig_hash_lock, flags);
 		return NET_RX_DROP;
 	}
 
-	seq_diff = ntohs(bcast_packet->seqno) - orig_node->last_bcast_seqno;
+	seq_diff = ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
 
 	/* check whether the packet is old and the host just restarted. */
 	if (window_protected(seq_diff, &orig_node->bcast_seqno_reset)) {
@@ -1005,7 +1008,7 @@ int recv_bcast_packet(struct sk_buff *skb)
 	/* mark broadcast in flood history, update window position
 	 * if required. */
 	if (bit_get_packet(orig_node->bcast_bits, seq_diff, 1))
-		orig_node->last_bcast_seqno = ntohs(bcast_packet->seqno);
+		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
 
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
 	/* rebroadcast packet */
diff --git a/drivers/staging/batman-adv/send.c b/drivers/staging/batman-adv/send.c
index e8f0e2a..f2653dd 100644
--- a/drivers/staging/batman-adv/send.c
+++ b/drivers/staging/batman-adv/send.c
@@ -159,7 +159,7 @@ static void send_packet_to_if(struct forw_packet *forw_packet,
 			"%s %spacket (originator %pM, seqno %d, TQ %d, TTL %d,"
 			" IDF %s) on interface %s [%s]\n",
 			fwd_str, (packet_num > 0 ? "aggregated " : ""),
-			batman_packet->orig, ntohs(batman_packet->seqno),
+			batman_packet->orig, ntohl(batman_packet->seqno),
 			batman_packet->tq, batman_packet->ttl,
 			(batman_packet->flags & DIRECTLINK ?
 			 "on" : "off"),
@@ -204,7 +204,7 @@ static void send_packet(struct forw_packet *forw_packet)
 			"%s packet (originator %pM, seqno %d, TTL %d) "
 			"on interface %s [%s]\n",
 			(forw_packet->own ? "Sending own" : "Forwarding"),
-			batman_packet->orig, ntohs(batman_packet->seqno),
+			batman_packet->orig, ntohl(batman_packet->seqno),
 			batman_packet->ttl, forw_packet->if_incoming->dev,
 			forw_packet->if_incoming->addr_str);
 
@@ -283,14 +283,14 @@ void schedule_own_packet(struct batman_if *batman_if)
 	batman_packet = (struct batman_packet *)batman_if->packet_buff;
 
 	/* change sequence number to network order */
-	batman_packet->seqno = htons((uint16_t)atomic_read(&batman_if->seqno));
+	batman_packet->seqno =
+		htonl((uint32_t)atomic_read(&batman_if->seqno));
 
 	if (vis_server == VIS_TYPE_SERVER_SYNC)
 		batman_packet->flags = VIS_SERVER;
 	else
 		batman_packet->flags &= ~VIS_SERVER;
 
-	/* could be read by receive_bat_packet() */
 	atomic_inc(&batman_if->seqno);
 
 	slide_own_bcast_window(batman_if);
@@ -347,7 +347,7 @@ void schedule_forward_packet(struct orig_node *orig_node,
 		in_tq, tq_avg, batman_packet->tq, in_ttl - 1,
 		batman_packet->ttl);
 
-	batman_packet->seqno = htons(batman_packet->seqno);
+	batman_packet->seqno = htonl(batman_packet->seqno);
 
 	if (directlink)
 		batman_packet->flags |= DIRECTLINK;
@@ -399,6 +399,7 @@ static void _add_bcast_packet_to_list(struct forw_packet *forw_packet,
 int add_bcast_packet_to_list(struct sk_buff *skb)
 {
 	struct forw_packet *forw_packet;
+	struct bcast_packet *bcast_packet;
 
 	if (!atomic_dec_not_zero(&bcast_queue_left)) {
 		bat_dbg(DBG_BATMAN, "bcast packet queue full\n");
@@ -414,6 +415,10 @@ int add_bcast_packet_to_list(struct sk_buff *skb)
 	if (!skb)
 		goto packet_free;
 
+	/* as we have a copy now, it is safe to decrease the TTL */
+	bcast_packet = (struct bcast_packet *)skb->data;
+	bcast_packet->ttl--;
+
 	skb_reset_mac_header(skb);
 
 	forw_packet->skb = skb;
diff --git a/drivers/staging/batman-adv/soft-interface.c b/drivers/staging/batman-adv/soft-interface.c
index c483693..ce789a7 100644
--- a/drivers/staging/batman-adv/soft-interface.c
+++ b/drivers/staging/batman-adv/soft-interface.c
@@ -30,7 +30,7 @@
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
 
-static uint16_t bcast_seqno = 1; /* give own bcast messages seq numbers to avoid
+static uint32_t bcast_seqno = 1; /* give own bcast messages seq numbers to avoid
 				  * broadcast storms */
 static int32_t skb_packets;
 static int32_t skb_bad_packets;
@@ -155,6 +155,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 
 		bcast_packet = (struct bcast_packet *)skb->data;
 		bcast_packet->version = COMPAT_VERSION;
+		bcast_packet->ttl = TTL;
 
 		/* batman packet type: broadcast */
 		bcast_packet->packet_type = BAT_BCAST;
@@ -164,7 +165,7 @@ int interface_tx(struct sk_buff *skb, struct net_device *dev)
 		memcpy(bcast_packet->orig, mainIfAddr, ETH_ALEN);
 
 		/* set broadcast sequence number */
-		bcast_packet->seqno = htons(bcast_seqno);
+		bcast_packet->seqno = htonl(bcast_seqno);
 
 		/* broadcast packet. on success, increase seqno. */
 		if (add_bcast_packet_to_list(skb) == NETDEV_TX_OK)
diff --git a/drivers/staging/batman-adv/types.h b/drivers/staging/batman-adv/types.h
index 751cd63..d0af489 100644
--- a/drivers/staging/batman-adv/types.h
+++ b/drivers/staging/batman-adv/types.h
@@ -72,11 +72,11 @@ struct orig_node {
 	unsigned long batman_seqno_reset;
 	uint8_t  flags;
 	unsigned char *hna_buff;
-	int16_t  hna_buff_len;
-	uint16_t last_real_seqno;
+	int16_t hna_buff_len;
+	uint32_t last_real_seqno;
 	uint8_t last_ttl;
 	TYPE_OF_WORD bcast_bits[NUM_WORDS];
-	uint16_t last_bcast_seqno;
+	uint32_t last_bcast_seqno;
 	struct list_head neigh_list;
 };
 
diff --git a/drivers/staging/batman-adv/vis.c b/drivers/staging/batman-adv/vis.c
index 7bd553a..d9ab981 100644
--- a/drivers/staging/batman-adv/vis.c
+++ b/drivers/staging/batman-adv/vis.c
@@ -357,7 +357,8 @@ static struct vis_info *add_packet(struct vis_packet *vis_packet,
 	old_info = hash_find(vis_hash, &search_elem);
 
 	if (old_info != NULL) {
-		if (!seq_after(vis_packet->seqno, old_info->packet.seqno)) {
+		if (!seq_after(ntohl(vis_packet->seqno),
+				ntohl(old_info->packet.seqno))) {
 			if (old_info->packet.seqno == vis_packet->seqno) {
 				recv_list_add(&old_info->recv_list,
 					      vis_packet->sender_orig);
@@ -525,7 +526,7 @@ static int generate_vis_packet(struct bat_priv *bat_priv)
 	spin_lock_irqsave(&orig_hash_lock, flags);
 	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);
 	info->packet.ttl = TTL;
-	info->packet.seqno++;
+	info->packet.seqno = htonl(ntohl(info->packet.seqno) + 1);
 	info->packet.entries = 0;
 
 	if (info->packet.vis_type == VIS_TYPE_CLIENT_UPDATE) {
-- 
1.7.1

