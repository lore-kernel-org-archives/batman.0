Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Dec 2010 21:39:11 +0100
Message-Id: <1292186352-24624-1-git-send-email-sven@narfation.org>
In-Reply-To: <201012122136.48156.sven@narfation.org>
References: <201012122136.48156.sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: Use kernel facilities for
	bit operations
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

set_bit and test_bit provide an efficient way to set and test bits of an
unsigned long.

This also fixes the problem that a very old ogm got not recorded as
received due to the missing constant definition "1" as unsigned long
inside the bit_mark operation - also known as "1UL".

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv/bitarray.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/batman-adv/bitarray.c b/batman-adv/bitarray.c
index 814274f..5dad5e8 100644
--- a/batman-adv/bitarray.c
+++ b/batman-adv/bitarray.c
@@ -40,7 +40,7 @@ uint8_t get_bit_status(TYPE_OF_WORD *seq_bits, uint32_t last_seqno,
 		/* which position in the selected word */
 		word_offset = (last_seqno - curr_seqno) % WORD_BIT_SIZE;
 
-		if (seq_bits[word_num] & 1 << word_offset)
+		if (test_bit(word_offset, &seq_bits[word_num]))
 			return 1;
 		else
 			return 0;
@@ -61,7 +61,7 @@ void bit_mark(TYPE_OF_WORD *seq_bits, int32_t n)
 	/* which position in the selected word */
 	word_offset = n % WORD_BIT_SIZE;
 
-	seq_bits[word_num] |= 1 << word_offset;	/* turn the position on */
+	set_bit(word_offset, &seq_bits[word_num]); /* turn the position on */
 }
 
 /* shift the packet array by n places. */
-- 
1.7.2.3

