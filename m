Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  2 Jul 2012 15:22:58 +0200
Message-Id: <1341235378-3111-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: generalise size in bitarray API
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

The current bitarray library assumes that the windows are always
BATADV_TQ_LOCAL_WINDOW_SIZE long. If we want to reuse the same library in other
contexts we need to make it general enough. This patch enables such the bitarray
library to handle windows of any size.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_iv_ogm.c |    9 ++++++---
 bitarray.c   |   31 ++++++++++++++++---------------
 bitarray.h   |   11 ++++++-----
 routing.c    |    9 ++++++---
 4 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index e877af8..f8e4c0e 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -910,6 +910,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	int set_mark, ret = -1;
 	uint32_t seqno = ntohl(batadv_ogm_packet->seqno);
 	uint8_t *neigh_addr;
+	int win_size = BATADV_TQ_LOCAL_WINDOW_SIZE;
 
 	orig_node = batadv_get_orig_node(bat_priv, batadv_ogm_packet->orig);
 	if (!orig_node)
@@ -930,7 +931,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 
 		is_duplicate |= batadv_test_bit(tmp_neigh_node->real_bits,
 						orig_node->last_real_seqno,
-						seqno);
+						seqno, win_size);
 
 		neigh_addr = tmp_neigh_node->addr;
 		if (batadv_compare_eth(neigh_addr, ethhdr->h_source) &&
@@ -942,7 +943,8 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 		/* if the window moved, set the update flag. */
 		need_update |= batadv_bit_get_packet(bat_priv,
 						     tmp_neigh_node->real_bits,
-						     seq_diff, set_mark);
+						     seq_diff, set_mark,
+						     win_size);
 
 		tmp_neigh_node->real_packet_count =
 			bitmap_weight(tmp_neigh_node->real_bits,
@@ -1093,7 +1095,8 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 			word = &(orig_neigh_node->bcast_own[offset]);
 			bit_pos = if_incoming_seqno - 2;
 			bit_pos -= ntohl(batadv_ogm_packet->seqno);
-			batadv_set_bit(word, bit_pos);
+			batadv_set_bit(word, bit_pos,
+				       BATADV_TQ_LOCAL_WINDOW_SIZE);
 			weight = &orig_neigh_node->bcast_own_sum[if_num];
 			*weight = bitmap_weight(word,
 						BATADV_TQ_LOCAL_WINDOW_SIZE);
diff --git a/bitarray.c b/bitarray.c
index aea174c..b46a81e 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -23,12 +23,13 @@
 #include <linux/bitops.h>
 
 /* shift the packet array by n places. */
-static void batadv_bitmap_shift_left(unsigned long *seq_bits, int32_t n)
+static void batadv_bitmap_shift_left(unsigned long *seq_bits, int32_t n,
+				     int size)
 {
-	if (n <= 0 || n >= BATADV_TQ_LOCAL_WINDOW_SIZE)
+	if (n <= 0 || n >= size)
 		return;
 
-	bitmap_shift_left(seq_bits, seq_bits, n, BATADV_TQ_LOCAL_WINDOW_SIZE);
+	bitmap_shift_left(seq_bits, seq_bits, n, size);
 }
 
 
@@ -39,39 +40,39 @@ static void batadv_bitmap_shift_left(unsigned long *seq_bits, int32_t n)
  *  0 if the window was not moved/shifted.
  */
 int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
-			  int32_t seq_num_diff, int set_mark)
+			  int32_t seq_num_diff, int set_mark, int size)
 {
 	struct batadv_priv *bat_priv = priv;
 
 	/* sequence number is slightly older. We already got a sequence number
 	 * higher than this one, so we just mark it.
 	 */
-	if (seq_num_diff <= 0 && seq_num_diff > -BATADV_TQ_LOCAL_WINDOW_SIZE) {
+	if (seq_num_diff <= 0 && seq_num_diff > -size) {
 		if (set_mark)
-			batadv_set_bit(seq_bits, -seq_num_diff);
+			batadv_set_bit(seq_bits, -seq_num_diff, size);
 		return 0;
 	}
 
 	/* sequence number is slightly newer, so we shift the window and
 	 * set the mark if required
 	 */
-	if (seq_num_diff > 0 && seq_num_diff < BATADV_TQ_LOCAL_WINDOW_SIZE) {
-		batadv_bitmap_shift_left(seq_bits, seq_num_diff);
+	if (seq_num_diff > 0 && seq_num_diff < size) {
+		batadv_bitmap_shift_left(seq_bits, seq_num_diff, size);
 
 		if (set_mark)
-			batadv_set_bit(seq_bits, 0);
+			batadv_set_bit(seq_bits, 0, size);
 		return 1;
 	}
 
 	/* sequence number is much newer, probably missed a lot of packets */
-	if (seq_num_diff >= BATADV_TQ_LOCAL_WINDOW_SIZE &&
+	if (seq_num_diff >= size &&
 	    seq_num_diff < BATADV_EXPECTED_SEQNO_RANGE) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "We missed a lot of packets (%i) !\n",
 			   seq_num_diff - 1);
-		bitmap_zero(seq_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
+		bitmap_zero(seq_bits, size);
 		if (set_mark)
-			batadv_set_bit(seq_bits, 0);
+			batadv_set_bit(seq_bits, 0, size);
 		return 1;
 	}
 
@@ -80,15 +81,15 @@ int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
 	 * packet should be dropped without calling this function if the
 	 * seqno window is protected.
 	 */
-	if (seq_num_diff <= -BATADV_TQ_LOCAL_WINDOW_SIZE ||
+	if (seq_num_diff <= -size ||
 	    seq_num_diff >= BATADV_EXPECTED_SEQNO_RANGE) {
 
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Other host probably restarted!\n");
 
-		bitmap_zero(seq_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
+		bitmap_zero(seq_bits, size);
 		if (set_mark)
-			batadv_set_bit(seq_bits, 0);
+			batadv_set_bit(seq_bits, 0, size);
 
 		return 1;
 	}
diff --git a/bitarray.h b/bitarray.h
index a081ce1..830d5bd 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -24,22 +24,23 @@
  * and curr_seqno is within range of last_seqno
  */
 static inline int batadv_test_bit(const unsigned long *seq_bits,
-				  uint32_t last_seqno, uint32_t curr_seqno)
+				  uint32_t last_seqno, uint32_t curr_seqno,
+				  int size)
 {
 	int32_t diff;
 
 	diff = last_seqno - curr_seqno;
-	if (diff < 0 || diff >= BATADV_TQ_LOCAL_WINDOW_SIZE)
+	if (diff < 0 || diff >= size)
 		return 0;
 	else
 		return  test_bit(diff, seq_bits);
 }
 
 /* turn corresponding bit on, so we can remember that we got the packet */
-static inline void batadv_set_bit(unsigned long *seq_bits, int32_t n)
+static inline void batadv_set_bit(unsigned long *seq_bits, int32_t n, int size)
 {
 	/* if too old, just drop it */
-	if (n < 0 || n >= BATADV_TQ_LOCAL_WINDOW_SIZE)
+	if (n < 0 || n >= size)
 		return;
 
 	set_bit(n, seq_bits); /* turn the position on */
@@ -49,6 +50,6 @@ static inline void batadv_set_bit(unsigned long *seq_bits, int32_t n)
  * new, 0 if old
  */
 int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
-			  int32_t seq_num_diff, int set_mark);
+			  int32_t seq_num_diff, int set_mark, int size);
 
 #endif /* _NET_BATMAN_ADV_BITARRAY_H_ */
diff --git a/routing.c b/routing.c
index bc2b88b..ec68df0 100644
--- a/routing.c
+++ b/routing.c
@@ -53,7 +53,8 @@ void batadv_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 			word_index = hard_iface->if_num * BATADV_NUM_WORDS;
 			word = &(orig_node->bcast_own[word_index]);
 
-			batadv_bit_get_packet(bat_priv, word, 1, 0);
+			batadv_bit_get_packet(bat_priv, word, 1, 0,
+					      BATADV_TQ_LOCAL_WINDOW_SIZE);
 			w = &orig_node->bcast_own_sum[hard_iface->if_num];
 			*w = bitmap_weight(word, BATADV_TQ_LOCAL_WINDOW_SIZE);
 			spin_unlock_bh(&orig_node->ogm_cnt_lock);
@@ -1118,7 +1119,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
 	/* check whether the packet is a duplicate */
 	if (batadv_test_bit(orig_node->bcast_bits, orig_node->last_bcast_seqno,
-			    ntohl(bcast_packet->seqno)))
+			    ntohl(bcast_packet->seqno),
+			    BATADV_TQ_LOCAL_WINDOW_SIZE))
 		goto spin_unlock;
 
 	seq_diff = ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
@@ -1131,7 +1133,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	/* mark broadcast in flood history, update window position
 	 * if required.
 	 */
-	if (batadv_bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1))
+	if (batadv_bit_get_packet(bat_priv, orig_node->bcast_bits, seq_diff, 1,
+				  BATADV_TQ_LOCAL_WINDOW_SIZE))
 		orig_node->last_bcast_seqno = ntohl(bcast_packet->seqno);
 
 	spin_unlock_bh(&orig_node->bcast_seqno_lock);
-- 
1.7.9.4

