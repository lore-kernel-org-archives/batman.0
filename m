Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 5 Apr 2010 00:01:20 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100404220120.GA9171@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Reorganize sequence number
	handling
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

BATMAN and broadcast packets are tracked with a sequence number window of
currently 64 entries to measure and avoid duplicates. Packets which have a 
sequence number smaller than the newest received packet minus 64 are not
within this sequence number window anymore and are called "old packets" from
now on.

When old packets are received, the routing code assumes that the host of the 
originator has been restarted. This assumption however might be wrong as 
packets can also be delayed by NIC drivers, e.g. because of long queues or 
collision detection in dense WiFi environments. This behaviour can be 
reproduced by doing a broadcast ping flood in a dense node environment.

The effect is that the sequence number window is jumping forth and back, 
accepting and forwarding any packet (because packets are assumed to be "new")
and causing loops.

To overcome this problem, the sequence number handling has been reorganized.
When an old packet is received, the window is reset back only once. Other old
packets are dropped for (currently) 30 seconds to "protect" the new sequence
number and avoid the hopping as described above.

The reorganization brings some code cleanups (at least i hope you feel the
same) and also fixes a bug in count_real_packets() which falsely updated 
the last_real_seqno for slightly older packets within the seqno window
if they are no duplicates.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Acked-by: Linus Luessing <linus.luessing@web.de>

Index: a/batman-adv-kernelland/types.h
===================================================================
--- a/batman-adv-kernelland/types.h	(revision 1616)
+++ a/batman-adv-kernelland/types.h	(working copy)
@@ -55,6 +55,10 @@
 	uint8_t tq_own;
 	int tq_asym_penalty;
 	unsigned long last_valid;        /* when last packet from this node was received */
+	unsigned long bcast_seqno_reset; /* time when the broadcast
+					    seqno window was reset. */
+	unsigned long batman_seqno_reset;/* time when the batman seqno
+					    window was reset. */
 	uint8_t gw_flags;      /* flags related to gateway class */
 	uint8_t flags;    /* for now only VIS_SERVER flag. */
 	unsigned char *hna_buff;
Index: a/batman-adv-kernelland/bitarray.c
===================================================================
--- a/batman-adv-kernelland/bitarray.c	(revision 1616)
+++ a/batman-adv-kernelland/bitarray.c	(working copy)
@@ -111,48 +111,74 @@
 		seq_bits[i] = 0;
 }
 
+static void bit_reset_window(TYPE_OF_WORD *seq_bits)
+{
+	int i;
+	for (i = 0; i < NUM_WORDS; i++)
+		seq_bits[i] = 0;
+}
 
-/* receive and process one packet, returns 1 if received seq_num is considered
- * new, 0 if old  */
+
+/* receive and process one packet within the sequence number window.
+ *
+ * returns:
+ *  1 if the window was moved (either new or very old)
+ *  0 if the window was not moved/shifted.
+ */
 char bit_get_packet(TYPE_OF_WORD *seq_bits, int16_t seq_num_diff,
 		    int8_t set_mark)
 {
-	int i;
+	/* sequence number is slightly older. We already got a sequence number
+	 * higher than this one, so we just mark it. */
 
-	/* we already got a sequence number higher than this one, so we just
-	 * mark it. this should wrap around the integer just fine */
 	if ((seq_num_diff < 0) && (seq_num_diff >= -TQ_LOCAL_WINDOW_SIZE)) {
 		if (set_mark)
 			bit_mark(seq_bits, -seq_num_diff);
 		return 0;
 	}
 
-	/* it seems we missed a lot of packets or the other host restarted */
-	if ((seq_num_diff > TQ_LOCAL_WINDOW_SIZE) ||
-	    (seq_num_diff < -TQ_LOCAL_WINDOW_SIZE)) {
+	/* sequence number is slightly newer, so we shift the window and
+	 * set the mark if required */
 
-		if (seq_num_diff > TQ_LOCAL_WINDOW_SIZE)
-			bat_dbg(DBG_BATMAN,
-				"We missed a lot of packets (%i) !\n",
-				seq_num_diff-1);
+	if ((seq_num_diff >= 0) && (seq_num_diff <= TQ_LOCAL_WINDOW_SIZE)) {
+		bit_shift(seq_bits, seq_num_diff);
 
-		if (-seq_num_diff > TQ_LOCAL_WINDOW_SIZE)
-			bat_dbg(DBG_BATMAN,
-				"Other host probably restarted !\n");
+		if (set_mark)
+			bit_mark(seq_bits, 0);
+		return 1;
+	}
 
-		for (i = 0; i < NUM_WORDS; i++)
-			seq_bits[i] = 0;
+	/* sequence number is much newer, probably missed a lot of packets */
 
+	if (seq_num_diff > TQ_LOCAL_WINDOW_SIZE) {
+		bat_dbg(DBG_BATMAN,
+			"We missed a lot of packets (%i) !\n",
+			seq_num_diff - 1);
+		bit_reset_window(seq_bits);
 		if (set_mark)
-			seq_bits[0] = 1;  /* we only have the latest packet */
-	} else {
-		bit_shift(seq_bits, seq_num_diff);
+			bit_mark(seq_bits, 0);
+		return 1;
+	}
 
+	/* received a much older packet. The other host either restarted
+	 * or the old packet got delayed somewhere in the network. The
+	 * packet should be dropped without calling this function if the
+	 * seqno window is protected. */
+
+	if (-seq_num_diff > TQ_LOCAL_WINDOW_SIZE) {
+
+		bat_dbg(DBG_BATMAN,
+			"Other host probably restarted!\n");
+
+		bit_reset_window(seq_bits);
 		if (set_mark)
 			bit_mark(seq_bits, 0);
+
+		return 1;
 	}
 
-	return 1;
+	/* never reached */
+	return 0;
 }
 
 /* count the hamming weight, how many good packets did we receive? just count
Index: a/batman-adv-kernelland/originator.c
===================================================================
--- a/batman-adv-kernelland/originator.c	(revision 1616)
+++ a/batman-adv-kernelland/originator.c	(working copy)
@@ -141,6 +141,8 @@
 	orig_node->router = NULL;
 	orig_node->batman_if = NULL;
 	orig_node->hna_buff = NULL;
+	orig_node->bcast_seqno_reset = jiffies;
+	orig_node->batman_seqno_reset = jiffies;
 
 	size = num_ifs * sizeof(TYPE_OF_WORD) * NUM_WORDS;
 
Index: a/batman-adv-kernelland/routing.c
===================================================================
--- a/batman-adv-kernelland/routing.c	(revision 1616)
+++ a/batman-adv-kernelland/routing.c	(working copy)
@@ -323,6 +323,37 @@
 		gw_check_election(bat_priv, orig_node);
 }
 
+/* checks whether the host restarted and is in the protection time.
+ * returns:
+ *  0 if the packet is to be accepted
+ *  1 if the packet is to be ignored.
+ */
+static int window_protected(int16_t seq_num_diff,
+				unsigned long *last_reset)
+{
+	if (-seq_num_diff > TQ_LOCAL_WINDOW_SIZE) {
+		if (time_after(jiffies, *last_reset +
+			msecs_to_jiffies(RESET_PROTECTION_MS))) {
+
+			*last_reset = jiffies;
+			bat_dbg(DBG_BATMAN,
+				"old packet received, start protection\n");
+
+			return 0;
+		} else
+			return 1;
+	}
+	return 0;
+}
+
+/* processes a batman packet for all interfaces, adjusts the sequence number and
+ * finds out whether it is a duplicate.
+ * returns:
+ *   1 the packet is a duplicate
+ *   0 the packet has not yet been received
+ *  -1 the packet is old and has been received while the seqno window
+ *     was protected. Caller should drop it.
+ */
 static char count_real_packets(struct ethhdr *ethhdr,
 			       struct batman_packet *batman_packet,
 			       struct batman_if *if_incoming)
@@ -330,31 +361,41 @@
 	struct orig_node *orig_node;
 	struct neigh_node *tmp_neigh_node;
 	char is_duplicate = 0;
-	uint16_t seq_diff;
+	int16_t seq_diff;
+	int need_update = 0;
+	int set_mark;
 
 	orig_node = get_orig_node(batman_packet->orig);
 	if (orig_node == NULL)
 		return 0;
 
+	seq_diff = batman_packet->seqno - orig_node->last_real_seqno;
+
+	/* signalize caller that the packet is to be dropped. */
+	if (window_protected(seq_diff, &orig_node->batman_seqno_reset))
+		return -1;
+
 	list_for_each_entry(tmp_neigh_node, &orig_node->neigh_list, list) {
 
-		if (!is_duplicate)
-			is_duplicate =
-				get_bit_status(tmp_neigh_node->real_bits,
+		is_duplicate |= get_bit_status(tmp_neigh_node->real_bits,
 					       orig_node->last_real_seqno,
 					       batman_packet->seqno);
-		seq_diff = batman_packet->seqno - orig_node->last_real_seqno;
+
 		if (compare_orig(tmp_neigh_node->addr, ethhdr->h_source) &&
 		    (tmp_neigh_node->if_incoming == if_incoming))
-			bit_get_packet(tmp_neigh_node->real_bits, seq_diff, 1);
+			set_mark = 1;
 		else
-			bit_get_packet(tmp_neigh_node->real_bits, seq_diff, 0);
+			set_mark = 0;
 
+		/* if the window moved, set the update flag. */
+		need_update |= bit_get_packet(tmp_neigh_node->real_bits,
+						seq_diff, set_mark);
+
 		tmp_neigh_node->real_packet_count =
 			bit_packet_count(tmp_neigh_node->real_bits);
 	}
 
-	if (!is_duplicate) {
+	if (need_update) {
 		bat_dbg(DBG_BATMAN, "updating last_seqno: old %d, new %d\n",
 			orig_node->last_real_seqno, batman_packet->seqno);
 		orig_node->last_real_seqno = batman_packet->seqno;
@@ -587,24 +628,27 @@
 		return;
 	}
 
-	if (batman_packet->tq == 0) {
-		count_real_packets(ethhdr, batman_packet, if_incoming);
-
-		bat_dbg(DBG_BATMAN, "Drop packet: originator packet with tq equal 0\n");
-		return;
-	}
-
 	if (is_my_oldorig) {
 		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast echos (sender: %pM)\n", ethhdr->h_source);
 		return;
 	}
 
-	is_duplicate = count_real_packets(ethhdr, batman_packet, if_incoming);
-
 	orig_node = get_orig_node(batman_packet->orig);
 	if (orig_node == NULL)
 		return;
 
+	is_duplicate = count_real_packets(ethhdr, batman_packet, if_incoming);
+
+	if (is_duplicate == -1) {
+		bat_dbg(DBG_BATMAN, "Drop packet: packet within seqno protection time (sender: %pM)\n", ethhdr->h_source);
+		return;
+	}
+
+	if (batman_packet->tq == 0) {
+		bat_dbg(DBG_BATMAN,	"Drop packet: originator packet with tq equal 0\n");
+		return;
+	}
+
 	/* avoid temporary routing loops */
 	if ((orig_node->router) &&
 	    (orig_node->router->orig_node->router) &&
@@ -1088,6 +1132,7 @@
 	struct bcast_packet *bcast_packet;
 	struct ethhdr *ethhdr;
 	int hdr_size = sizeof(struct bcast_packet);
+	int16_t seq_diff;
 	unsigned long flags;
 
 	/* drop packet if it has not necessary minimum size */
@@ -1123,7 +1168,7 @@
 		return NET_RX_DROP;
 	}
 
-	/* check flood history */
+	/* check whether the packet is a duplicate */
 	if (get_bit_status(orig_node->bcast_bits,
 			   orig_node->last_bcast_seqno,
 			   ntohs(bcast_packet->seqno))) {
@@ -1131,14 +1176,20 @@
 		return NET_RX_DROP;
 	}
 
-	/* mark broadcast in flood history */
-	if (bit_get_packet(orig_node->bcast_bits,
-			   ntohs(bcast_packet->seqno) -
-			   orig_node->last_bcast_seqno, 1))
+	seq_diff = ntohs(bcast_packet->seqno) - orig_node->last_bcast_seqno;
+
+	/* check whether the packet is old and the host just restarted. */
+	if (window_protected(seq_diff, &orig_node->bcast_seqno_reset)) {
+		spin_unlock_irqrestore(&orig_hash_lock, flags);
+		return NET_RX_DROP;
+	}
+
+	/* mark broadcast in flood history, update window position
+	 * if required. */
+	if (bit_get_packet(orig_node->bcast_bits, seq_diff, 1))
 		orig_node->last_bcast_seqno = ntohs(bcast_packet->seqno);
 
 	spin_unlock_irqrestore(&orig_hash_lock, flags);
-
 	/* rebroadcast packet */
 	add_bcast_packet_to_list(skb);
 
Index: a/batman-adv-kernelland/main.h
===================================================================
--- a/batman-adv-kernelland/main.h	(revision 1616)
+++ a/batman-adv-kernelland/main.h	(working copy)
@@ -66,6 +66,9 @@
 				   * forw_packet->direct_link_flags */
 #define MAX_AGGREGATION_MS 100
 
+#define RESET_PROTECTION_MS 30000
+/* don't reset again within 30 seconds */
+
 #define MODULE_INACTIVE 0
 #define MODULE_ACTIVE 1
 #define MODULE_DEACTIVATING 2

