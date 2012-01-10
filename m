Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 Jan 2012 20:19:22 +0100
Message-Id: <1326223162-15181-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: Replace bitarray operations with
	bitmap [aka. lets break batman-av]
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

bitarray.c consists mostly of functionality that is already available as part
of the standard kernel API. batman-adv could use architecture optimized code
and reduce the binary size by switching to the standard functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
--
This patch is completely untested. Simon and I just talked about standard
kernel bit operations and noticed that we hadn't fulfilled our promise to
remove the code that is already available in the linux kernel. So this is just
a reminder and should not be seen as a finished patch.

 bat_iv_ogm.c |    5 ++-
 bitarray.c   |   92 +++++----------------------------------------------------
 bitarray.h   |    5 ---
 main.h       |    2 +-
 routing.c    |    2 +-
 types.h      |    4 +-
 6 files changed, 15 insertions(+), 95 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 2b66dae..d026819 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -874,7 +874,8 @@ static int bat_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 					      seq_diff, set_mark);
 
 		tmp_neigh_node->real_packet_count =
-			bit_packet_count(tmp_neigh_node->real_bits);
+			bitmap_weight(tmp_neigh_node->real_bits,
+				      TQ_LOCAL_WINDOW_SIZE);
 	}
 	rcu_read_unlock();
 
@@ -1013,7 +1014,7 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 				 if_incoming_seqno -
 						batman_ogm_packet->seqno - 2);
 			orig_neigh_node->bcast_own_sum[if_incoming->if_num] =
-				bit_packet_count(word);
+				bitmap_weight(word, TQ_LOCAL_WINDOW_SIZE);
 			spin_unlock_bh(&orig_neigh_node->ogm_cnt_lock);
 		}
 
diff --git a/bitarray.c b/bitarray.c
index e63069d..8220506 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -29,95 +29,32 @@
 int get_bit_status(const unsigned long *seq_bits, uint32_t last_seqno,
 		   uint32_t curr_seqno)
 {
-	int32_t diff, word_offset, word_num;
+	int32_t diff;
 
 	diff = last_seqno - curr_seqno;
-	if (diff < 0 || diff >= TQ_LOCAL_WINDOW_SIZE) {
+	if (diff < 0 || diff >= TQ_LOCAL_WINDOW_SIZE)
 		return 0;
-	} else {
-		/* which word */
-		word_num = (last_seqno - curr_seqno) / WORD_BIT_SIZE;
-		/* which position in the selected word */
-		word_offset = (last_seqno - curr_seqno) % WORD_BIT_SIZE;
-
-		if (test_bit(word_offset, &seq_bits[word_num]))
-			return 1;
-		else
-			return 0;
-	}
+	else
+		return  test_bit(diff, seq_bits);
 }
 
 /* turn corresponding bit on, so we can remember that we got the packet */
 void bit_mark(unsigned long *seq_bits, int32_t n)
 {
-	int32_t word_offset, word_num;
-
 	/* if too old, just drop it */
 	if (n < 0 || n >= TQ_LOCAL_WINDOW_SIZE)
 		return;
 
-	/* which word */
-	word_num = n / WORD_BIT_SIZE;
-	/* which position in the selected word */
-	word_offset = n % WORD_BIT_SIZE;
-
-	set_bit(word_offset, &seq_bits[word_num]); /* turn the position on */
+	set_bit(n, seq_bits); /* turn the position on */
 }
 
 /* shift the packet array by n places. */
 static void bit_shift(unsigned long *seq_bits, int32_t n)
 {
-	int32_t word_offset, word_num;
-	int32_t i;
-
 	if (n <= 0 || n >= TQ_LOCAL_WINDOW_SIZE)
 		return;
 
-	word_offset = n % WORD_BIT_SIZE;/* shift how much inside each word */
-	word_num = n / WORD_BIT_SIZE;	/* shift over how much (full) words */
-
-	for (i = NUM_WORDS - 1; i > word_num; i--) {
-		/* going from old to new, so we don't overwrite the data we copy
-		 * from.
-		 *
-		 * left is high, right is low: FEDC BA98 7654 3210
-		 *					  ^^ ^^
-		 *			       vvvv
-		 * ^^^^ = from, vvvvv =to, we'd have word_num==1 and
-		 * word_offset==WORD_BIT_SIZE/2 ????? in this example.
-		 * (=24 bits)
-		 *
-		 * our desired output would be: 9876 5432 1000 0000
-		 * */
-
-		seq_bits[i] =
-			(seq_bits[i - word_num] << word_offset) +
-			/* take the lower port from the left half, shift it left
-			 * to its final position */
-			(seq_bits[i - word_num - 1] >>
-			 (WORD_BIT_SIZE-word_offset));
-		/* and the upper part of the right half and shift it left to
-		 * its position */
-		/* for our example that would be: word[0] = 9800 + 0076 =
-		 * 9876 */
-	}
-	/* now for our last word, i==word_num, we only have its "left" half.
-	 * that's the 1000 word in our example.*/
-
-	seq_bits[i] = (seq_bits[i - word_num] << word_offset);
-
-	/* pad the rest with 0, if there is anything */
-	i--;
-
-	for (; i >= 0; i--)
-		seq_bits[i] = 0;
-}
-
-static void bit_reset_window(unsigned long *seq_bits)
-{
-	int i;
-	for (i = 0; i < NUM_WORDS; i++)
-		seq_bits[i] = 0;
+	bitmap_shift_left(seq_bits, seq_bits, n, TQ_LOCAL_WINDOW_SIZE);
 }
 
 
@@ -159,7 +96,7 @@ int bit_get_packet(void *priv, unsigned long *seq_bits,
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"We missed a lot of packets (%i) !\n",
 			seq_num_diff - 1);
-		bit_reset_window(seq_bits);
+		bitmap_zero(seq_bits, TQ_LOCAL_WINDOW_SIZE);
 		if (set_mark)
 			bit_mark(seq_bits, 0);
 		return 1;
@@ -176,7 +113,7 @@ int bit_get_packet(void *priv, unsigned long *seq_bits,
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Other host probably restarted!\n");
 
-		bit_reset_window(seq_bits);
+		bitmap_zero(seq_bits, TQ_LOCAL_WINDOW_SIZE);
 		if (set_mark)
 			bit_mark(seq_bits, 0);
 
@@ -186,16 +123,3 @@ int bit_get_packet(void *priv, unsigned long *seq_bits,
 	/* never reached */
 	return 0;
 }
-
-/* count the hamming weight, how many good packets did we receive? just count
- * the 1's.
- */
-int bit_packet_count(const unsigned long *seq_bits)
-{
-	int i, hamming = 0;
-
-	for (i = 0; i < NUM_WORDS; i++)
-		hamming += hweight_long(seq_bits[i]);
-
-	return hamming;
-}
diff --git a/bitarray.h b/bitarray.h
index c613572..48f940d 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -22,8 +22,6 @@
 #ifndef _NET_BATMAN_ADV_BITARRAY_H_
 #define _NET_BATMAN_ADV_BITARRAY_H_
 
-#define WORD_BIT_SIZE (sizeof(unsigned long) * 8)
-
 /* returns true if the corresponding bit in the given seq_bits indicates true
  * and curr_seqno is within range of last_seqno */
 int get_bit_status(const unsigned long *seq_bits, uint32_t last_seqno,
@@ -38,7 +36,4 @@ void bit_mark(unsigned long *seq_bits, int32_t n);
 int bit_get_packet(void *priv, unsigned long *seq_bits,
 		   int32_t seq_num_diff, int set_mark);
 
-/* count the hamming weight, how many good packets did we receive? */
-int bit_packet_count(const unsigned long *seq_bits);
-
 #endif /* _NET_BATMAN_ADV_BITARRAY_H_ */
diff --git a/main.h b/main.h
index 7f2d737..fd50c6e 100644
--- a/main.h
+++ b/main.h
@@ -65,7 +65,7 @@
 
 #define NULL_IFINDEX 0 /* dummy ifindex used to avoid iface checks */
 
-#define NUM_WORDS (TQ_LOCAL_WINDOW_SIZE / WORD_BIT_SIZE)
+#define NUM_WORDS BITS_TO_LONGS(TQ_LOCAL_WINDOW_SIZE)
 
 #define LOG_BUF_LEN 8192	  /* has to be a power of 2 */
 
diff --git a/routing.c b/routing.c
index cf9a2f6..efd543a 100644
--- a/routing.c
+++ b/routing.c
@@ -52,7 +52,7 @@ void slide_own_bcast_window(struct hard_iface *hard_iface)
 
 			bit_get_packet(bat_priv, word, 1, 0);
 			orig_node->bcast_own_sum[hard_iface->if_num] =
-				bit_packet_count(word);
+				bitmap_weight(word, TQ_LOCAL_WINDOW_SIZE);
 			spin_unlock_bh(&orig_node->ogm_cnt_lock);
 		}
 		rcu_read_unlock();
diff --git a/types.h b/types.h
index 302efb5..24c8a31 100644
--- a/types.h
+++ b/types.h
@@ -90,7 +90,7 @@ struct orig_node {
 	bool tt_poss_change;
 	uint32_t last_real_seqno;
 	uint8_t last_ttl;
-	unsigned long bcast_bits[NUM_WORDS];
+	DECLARE_BITMAP(bcast_bits, TQ_LOCAL_WINDOW_SIZE);
 	uint32_t last_bcast_seqno;
 	struct hlist_head neigh_list;
 	struct list_head frag_list;
@@ -132,7 +132,7 @@ struct neigh_node {
 	uint8_t last_ttl;
 	struct list_head bonding_list;
 	unsigned long last_valid;
-	unsigned long real_bits[NUM_WORDS];
+	DECLARE_BITMAP(real_bits, TQ_LOCAL_WINDOW_SIZE);
 	atomic_t refcount;
 	struct rcu_head rcu;
 	struct orig_node *orig_node;
-- 
1.7.7.3

