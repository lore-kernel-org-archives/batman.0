Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Dec 2010 21:46:59 +0100
Message-Id: <1292186819-26232-2-git-send-email-sven@narfation.org>
In-Reply-To: <201012122143.10618.sven@narfation.org>
References: <201012122143.10618.sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 2/2] batman-adv: Remove TYPE_OF_WORD define
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

We use functions like hweight_long or set/test_bit which enforce the
type "unsigned long". This makes it impossible to replace the type in
this define with any other type without breaking the kernel module.

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv/bitarray.c   |   12 ++++++------
 batman-adv/bitarray.h   |   17 +++++------------
 batman-adv/originator.c |    8 ++++----
 batman-adv/routing.c    |    4 ++--
 batman-adv/types.h      |    6 +++---
 5 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/batman-adv/bitarray.c b/batman-adv/bitarray.c
index 5dad5e8..bbcd8f7 100644
--- a/batman-adv/bitarray.c
+++ b/batman-adv/bitarray.c
@@ -26,7 +26,7 @@
 
 /* returns true if the corresponding bit in the given seq_bits indicates true
  * and curr_seqno is within range of last_seqno */
-uint8_t get_bit_status(TYPE_OF_WORD *seq_bits, uint32_t last_seqno,
+uint8_t get_bit_status(unsigned long *seq_bits, uint32_t last_seqno,
 		       uint32_t curr_seqno)
 {
 	int32_t diff, word_offset, word_num;
@@ -48,7 +48,7 @@ uint8_t get_bit_status(TYPE_OF_WORD *seq_bits, uint32_t last_seqno,
 }
 
 /* turn corresponding bit on, so we can remember that we got the packet */
-void bit_mark(TYPE_OF_WORD *seq_bits, int32_t n)
+void bit_mark(unsigned long *seq_bits, int32_t n)
 {
 	int32_t word_offset, word_num;
 
@@ -65,7 +65,7 @@ void bit_mark(TYPE_OF_WORD *seq_bits, int32_t n)
 }
 
 /* shift the packet array by n places. */
-static void bit_shift(TYPE_OF_WORD *seq_bits, int32_t n)
+static void bit_shift(unsigned long *seq_bits, int32_t n)
 {
 	int32_t word_offset, word_num;
 	int32_t i;
@@ -113,7 +113,7 @@ static void bit_shift(TYPE_OF_WORD *seq_bits, int32_t n)
 		seq_bits[i] = 0;
 }
 
-static void bit_reset_window(TYPE_OF_WORD *seq_bits)
+static void bit_reset_window(unsigned long *seq_bits)
 {
 	int i;
 	for (i = 0; i < NUM_WORDS; i++)
@@ -127,7 +127,7 @@ static void bit_reset_window(TYPE_OF_WORD *seq_bits)
  *  1 if the window was moved (either new or very old)
  *  0 if the window was not moved/shifted.
  */
-char bit_get_packet(void *priv, TYPE_OF_WORD *seq_bits,
+char bit_get_packet(void *priv, unsigned long *seq_bits,
 		    int32_t seq_num_diff, int8_t set_mark)
 {
 	struct bat_priv *bat_priv = (struct bat_priv *)priv;
@@ -190,7 +190,7 @@ char bit_get_packet(void *priv, TYPE_OF_WORD *seq_bits,
 /* count the hamming weight, how many good packets did we receive? just count
  * the 1's.
  */
-int bit_packet_count(TYPE_OF_WORD *seq_bits)
+int bit_packet_count(unsigned long *seq_bits)
 {
 	int i, hamming = 0;
 
diff --git a/batman-adv/bitarray.h b/batman-adv/bitarray.h
index 2635d67..ac54017 100644
--- a/batman-adv/bitarray.h
+++ b/batman-adv/bitarray.h
@@ -22,30 +22,23 @@
 #ifndef _NET_BATMAN_ADV_BITARRAY_H_
 #define _NET_BATMAN_ADV_BITARRAY_H_
 
-/* you should choose something big, if you don't want to waste cpu
- * and keep the type in sync with bit_packet_count */
-
-/* don't change 'unsigned long' as test_bit()/set_bit()/hweight_long()
- * expect this length
- */
-#define TYPE_OF_WORD unsigned long
-#define WORD_BIT_SIZE (sizeof(TYPE_OF_WORD) * 8)
+#define WORD_BIT_SIZE (sizeof(unsigned long) * 8)
 
 /* returns true if the corresponding bit in the given seq_bits indicates true
  * and curr_seqno is within range of last_seqno */
-uint8_t get_bit_status(TYPE_OF_WORD *seq_bits, uint32_t last_seqno,
+uint8_t get_bit_status(unsigned long *seq_bits, uint32_t last_seqno,
 					   uint32_t curr_seqno);
 
 /* turn corresponding bit on, so we can remember that we got the packet */
-void bit_mark(TYPE_OF_WORD *seq_bits, int32_t n);
+void bit_mark(unsigned long *seq_bits, int32_t n);
 
 
 /* receive and process one packet, returns 1 if received seq_num is considered
  * new, 0 if old  */
-char bit_get_packet(void *priv, TYPE_OF_WORD *seq_bits,
+char bit_get_packet(void *priv, unsigned long *seq_bits,
 		    int32_t seq_num_diff, int8_t set_mark);
 
 /* count the hamming weight, how many good packets did we receive? */
-int  bit_packet_count(TYPE_OF_WORD *seq_bits);
+int  bit_packet_count(unsigned long *seq_bits);
 
 #endif /* _NET_BATMAN_ADV_BITARRAY_H_ */
diff --git a/batman-adv/originator.c b/batman-adv/originator.c
index 7b1fc52..93ac59b 100644
--- a/batman-adv/originator.c
+++ b/batman-adv/originator.c
@@ -151,7 +151,7 @@ struct orig_node *get_orig_node(struct bat_priv *bat_priv, uint8_t *addr)
 	orig_node->batman_seqno_reset = jiffies - 1
 					- msecs_to_jiffies(RESET_PROTECTION_MS);
 
-	size = bat_priv->num_ifaces * sizeof(TYPE_OF_WORD) * NUM_WORDS;
+	size = bat_priv->num_ifaces * sizeof(unsigned long) * NUM_WORDS;
 
 	orig_node->bcast_own = kzalloc(size, GFP_ATOMIC);
 	if (!orig_node->bcast_own)
@@ -397,7 +397,7 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 {
 	void *data_ptr;
 
-	data_ptr = kmalloc(max_if_num * sizeof(TYPE_OF_WORD) * NUM_WORDS,
+	data_ptr = kmalloc(max_if_num * sizeof(unsigned long) * NUM_WORDS,
 			   GFP_ATOMIC);
 	if (!data_ptr) {
 		pr_err("Can't resize orig: out of memory\n");
@@ -405,7 +405,7 @@ static int orig_node_add_if(struct orig_node *orig_node, int max_if_num)
 	}
 
 	memcpy(data_ptr, orig_node->bcast_own,
-	       (max_if_num - 1) * sizeof(TYPE_OF_WORD) * NUM_WORDS);
+	       (max_if_num - 1) * sizeof(unsigned long) * NUM_WORDS);
 	kfree(orig_node->bcast_own);
 	orig_node->bcast_own = data_ptr;
 
@@ -466,7 +466,7 @@ static int orig_node_del_if(struct orig_node *orig_node,
 	if (max_if_num == 0)
 		goto free_bcast_own;
 
-	chunk_size = sizeof(TYPE_OF_WORD) * NUM_WORDS;
+	chunk_size = sizeof(unsigned long) * NUM_WORDS;
 	data_ptr = kmalloc(max_if_num * chunk_size, GFP_ATOMIC);
 	if (!data_ptr) {
 		pr_err("Can't resize orig: out of memory\n");
diff --git a/batman-adv/routing.c b/batman-adv/routing.c
index 8cec99b..cd2d4d8 100644
--- a/batman-adv/routing.c
+++ b/batman-adv/routing.c
@@ -44,7 +44,7 @@ void slide_own_bcast_window(struct batman_if *batman_if)
 	struct hlist_head *head;
 	struct element_t *bucket;
 	struct orig_node *orig_node;
-	TYPE_OF_WORD *word;
+	unsigned long *word;
 	int i;
 	size_t word_index;
 
@@ -634,7 +634,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 	}
 
 	if (is_my_orig) {
-		TYPE_OF_WORD *word;
+		unsigned long *word;
 		int offset;
 
 		orig_neigh_node = get_orig_node(bat_priv, ethhdr->h_source);
diff --git a/batman-adv/types.h b/batman-adv/types.h
index 1d00849..97cb23d 100644
--- a/batman-adv/types.h
+++ b/batman-adv/types.h
@@ -68,7 +68,7 @@ struct orig_node {
 	uint8_t orig[ETH_ALEN];
 	uint8_t primary_addr[ETH_ALEN];
 	struct neigh_node *router;
-	TYPE_OF_WORD *bcast_own;
+	unsigned long *bcast_own;
 	uint8_t *bcast_own_sum;
 	uint8_t tq_own;
 	int tq_asym_penalty;
@@ -81,7 +81,7 @@ struct orig_node {
 	int16_t hna_buff_len;
 	uint32_t last_real_seqno;
 	uint8_t last_ttl;
-	TYPE_OF_WORD bcast_bits[NUM_WORDS];
+	unsigned long bcast_bits[NUM_WORDS];
 	uint32_t last_bcast_seqno;
 	struct list_head neigh_list;
 	struct list_head frag_list;
@@ -114,7 +114,7 @@ struct neigh_node {
 	uint8_t last_ttl;
 	struct neigh_node *next_bond_candidate;
 	unsigned long last_valid;
-	TYPE_OF_WORD real_bits[NUM_WORDS];
+	unsigned long real_bits[NUM_WORDS];
 	struct orig_node *orig_node;
 	struct batman_if *if_incoming;
 };
-- 
1.7.2.3

