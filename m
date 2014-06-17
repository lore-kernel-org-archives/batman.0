Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 Jun 2014 21:56:00 +0200
Message-Id: <1403034964-6737-3-git-send-email-sven@narfation.org>
In-Reply-To: <1403034964-6737-1-git-send-email-sven@narfation.org>
References: <1403034964-6737-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/7] batmand: Fix bitarray 1 bit shift type
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
Cc: Sven Eckelmann <sven@narfation.org>

The default type of an integer constant is int. This reduced the possible bits
for a shift to 32. But the size of uintmax_t is most likely larger (64 bit).
Thus the upper 32 bit cannot be accessed correctly with this bitarray
implementation.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bitarray.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitarray.c b/bitarray.c
index 133f6e7..354eddd 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -49,7 +49,7 @@ uint8_t get_bit_status( TYPE_OF_WORD *seq_bits, uint16_t last_seqno, uint16_t cu
 		word_offset= ( last_seqno - curr_seqno ) % WORD_BIT_SIZE;	/* which position in the selected word */
 		word_num   = ( last_seqno - curr_seqno ) / WORD_BIT_SIZE;	/* which word */
 
-		if ( seq_bits[word_num] & 1<<word_offset )   /* get position status */
+		if ( seq_bits[word_num] & (1ULL << word_offset))   /* get position status */
 			return 1;
 		else
 			return 0;
@@ -72,7 +72,7 @@ void bit_mark( TYPE_OF_WORD *seq_bits, int32_t n ) {
 	word_offset= n%WORD_BIT_SIZE;	/* which position in the selected word */
 	word_num   = n/WORD_BIT_SIZE;	/* which word */
 
-	seq_bits[word_num]|= 1<<word_offset;	/* turn the position on */
+	seq_bits[word_num] |= 1ULL << word_offset;	/* turn the position on */
 }
 
 /* shift the packet array p by n places. */
-- 
2.0.0

