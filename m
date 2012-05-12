Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 May 2012 13:48:53 +0200
Message-Id: <1336823339-4095-2-git-send-email-sven@narfation.org>
In-Reply-To: <1336823339-4095-1-git-send-email-sven@narfation.org>
References: <1336823339-4095-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/8] batman-adv: Prefix bitarray static
	inline functions with batadv_
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

All non-static symbols of batman-adv were prefixed with batadv_ to avoid
collisions with other symbols of the kernel. Other symbols of batman-adv
should use the same prefix to keep the naming scheme consistent.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bat_iv_ogm.c |   13 +++++++------
 bitarray.c   |    8 ++++----
 bitarray.h   |    6 +++---
 routing.c    |    4 ++--
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 84d93a5..bc30a40 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -901,9 +901,9 @@ static int bat_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	hlist_for_each_entry_rcu(tmp_neigh_node, node,
 				 &orig_node->neigh_list, list) {
 
-		is_duplicate |= bat_test_bit(tmp_neigh_node->real_bits,
-					     orig_node->last_real_seqno,
-					     seqno);
+		is_duplicate |= batadv_test_bit(tmp_neigh_node->real_bits,
+						orig_node->last_real_seqno,
+						seqno);
 
 		if (compare_eth(tmp_neigh_node->addr, ethhdr->h_source) &&
 		    (tmp_neigh_node->if_incoming == if_incoming))
@@ -1037,6 +1037,7 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 	if (is_my_orig) {
 		unsigned long *word;
 		int offset;
+		int32_t bit_pos;
 
 		orig_neigh_node = batadv_get_orig_node(bat_priv,
 						       ethhdr->h_source);
@@ -1054,9 +1055,9 @@ static void bat_iv_ogm_process(const struct ethhdr *ethhdr,
 
 			spin_lock_bh(&orig_neigh_node->ogm_cnt_lock);
 			word = &(orig_neigh_node->bcast_own[offset]);
-			bat_set_bit(word,
-				    if_incoming_seqno -
-					ntohl(batman_ogm_packet->seqno) - 2);
+			bit_pos = if_incoming_seqno - 2;
+			bit_pos -= ntohl(batman_ogm_packet->seqno);
+			batadv_set_bit(word, bit_pos);
 			orig_neigh_node->bcast_own_sum[if_incoming->if_num] =
 				bitmap_weight(word, TQ_LOCAL_WINDOW_SIZE);
 			spin_unlock_bh(&orig_neigh_node->ogm_cnt_lock);
diff --git a/bitarray.c b/bitarray.c
index 838abbc..7a7065c 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -48,7 +48,7 @@ int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
 	 */
 	if ((seq_num_diff <= 0) && (seq_num_diff > -TQ_LOCAL_WINDOW_SIZE)) {
 		if (set_mark)
-			bat_set_bit(seq_bits, -seq_num_diff);
+			batadv_set_bit(seq_bits, -seq_num_diff);
 		return 0;
 	}
 
@@ -59,7 +59,7 @@ int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
 		batadv_bitmap_shift_left(seq_bits, seq_num_diff);
 
 		if (set_mark)
-			bat_set_bit(seq_bits, 0);
+			batadv_set_bit(seq_bits, 0);
 		return 1;
 	}
 
@@ -71,7 +71,7 @@ int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
 			seq_num_diff - 1);
 		bitmap_zero(seq_bits, TQ_LOCAL_WINDOW_SIZE);
 		if (set_mark)
-			bat_set_bit(seq_bits, 0);
+			batadv_set_bit(seq_bits, 0);
 		return 1;
 	}
 
@@ -88,7 +88,7 @@ int batadv_bit_get_packet(void *priv, unsigned long *seq_bits,
 
 		bitmap_zero(seq_bits, TQ_LOCAL_WINDOW_SIZE);
 		if (set_mark)
-			bat_set_bit(seq_bits, 0);
+			batadv_set_bit(seq_bits, 0);
 
 		return 1;
 	}
diff --git a/bitarray.h b/bitarray.h
index 8ab5426..7954ba8 100644
--- a/bitarray.h
+++ b/bitarray.h
@@ -23,8 +23,8 @@
 /* returns true if the corresponding bit in the given seq_bits indicates true
  * and curr_seqno is within range of last_seqno
  */
-static inline int bat_test_bit(const unsigned long *seq_bits,
-			       uint32_t last_seqno, uint32_t curr_seqno)
+static inline int batadv_test_bit(const unsigned long *seq_bits,
+				  uint32_t last_seqno, uint32_t curr_seqno)
 {
 	int32_t diff;
 
@@ -36,7 +36,7 @@ static inline int bat_test_bit(const unsigned long *seq_bits,
 }
 
 /* turn corresponding bit on, so we can remember that we got the packet */
-static inline void bat_set_bit(unsigned long *seq_bits, int32_t n)
+static inline void batadv_set_bit(unsigned long *seq_bits, int32_t n)
 {
 	/* if too old, just drop it */
 	if (n < 0 || n >= TQ_LOCAL_WINDOW_SIZE)
diff --git a/routing.c b/routing.c
index 66aabab..091188e 100644
--- a/routing.c
+++ b/routing.c
@@ -1087,8 +1087,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb, struct hard_iface *recv_if)
 	spin_lock_bh(&orig_node->bcast_seqno_lock);
 
 	/* check whether the packet is a duplicate */
-	if (bat_test_bit(orig_node->bcast_bits, orig_node->last_bcast_seqno,
-			 ntohl(bcast_packet->seqno)))
+	if (batadv_test_bit(orig_node->bcast_bits, orig_node->last_bcast_seqno,
+			    ntohl(bcast_packet->seqno)))
 		goto spin_unlock;
 
 	seq_diff = ntohl(bcast_packet->seqno) - orig_node->last_bcast_seqno;
-- 
1.7.10

